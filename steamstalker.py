import steam
from sqlalchemy import create_engine, Column, Integer, DateTime, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import argparse
import yaml
from datetime import datetime

parser = argparse.ArgumentParser()
parser.add_argument("--install", help="increase output verbosity", action="store_true")

args = parser.parse_args()

config = None

with open('storage/config.yml', 'r+') as f:
    config = yaml.load(f)

if not config:
    exit(1)

engine = create_engine(config['database_URI'])

Base = declarative_base(engine)

Session = sessionmaker()
Session.configure(bind=engine)
session = Session()


class Activity(Base):
    __tablename__ = 'activity'

    id = Column(Integer, primary_key=True)
    steamid = Column(Integer, nullable=False)
    gameid = Column(Integer, nullable=True)
    event_datetime = Column(DateTime, nullable=False)


class SteamGameName(Base):
    __tablename__ = 'steamgamename'

    id = Column(Integer, primary_key=True)
    gameid = Column(Integer, nullable=False)
    gamename = Column(String, nullable=False)


if args.install:
    Base.metadata.create_all()

try:
    steam.api.key.set(config['steam']['apikey'])

    profile_ids = []

    for url in config['steam']['profiles']:
        profile_ids.append(steam.user.vanity_url(url))

    activities = []

    for profile_id in profile_ids:
        activities.append(Activity(steamid=profile_id.id64,
                                   gameid=steam.user.profile(profile_id).current_game[0],
                                   event_datetime=datetime.now()))

    session.add_all(activities)
    session.commit()
    session.flush()
except:
    import traceback
    print(traceback.format_exc())
