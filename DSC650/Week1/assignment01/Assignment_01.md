---
title: Assignment 1
<br>subtitle: Computer performance, reliability, and scalability calculation
<br>author: Anjani Bonda
---

## 1.2 

#### a. Data Sizes

##### Calculation

###### a. Character Message
File Size: Number of characters x 1 byte
###### b. Image File
File Size: pixel count × bit depth
<br> Bit Depth: 32 for PNG; 8, 10, 12 14 bits are available for RAW in which I have chosen 14 bits
<br> Link: https://toolstud.io/photo/filesize.php?imagewidth=1024&imageheight=768

###### b. Video Files
File Size: Bitrate x duration x compression ratio
<br> Bitrate: Frame size x Frames Rate
<br> Pixel Count: W * H
<br> Uncompressed Pixel Count: W * H * 24 bit
<br> HD and 4K: I chose Youtube video as reference 
<br> Link: https://toolstud.io/video/filesize.php?width=3840&height=2160&framerate=30&timeduration=15&timeduration_unit=minutes&compression=27127&specificbitrate=20&specificbitrate_unit=1000000

| Data Item                                  | Size per Item | 
|--------------------------------------------|--------------:|
| 128 character message.                     | 128 Bytes       |
| 1024x768 PNG image                         | 3.15 MB          |
| 1024x768 RAW image                         | 1.38 MB          | 
| HD (1080p) HEVC Video (15 minutes)         | 1.08 GB          |
| HD (1080p) Uncompressed Video (15 minutes) | 150 GB          |
| 4K UHD HEVC Video (15 minutes)             | 2.25 GB          |
| 4k UHD Uncompressed Video (15 minutes)     | 672 GB          |
| Human Genome (Uncompressed)                | 3.43 GB          |

#### b. Scaling

###### a. Tweets
Daily uncompressed tweets: 500M x 128 bytes
<br>Daily snappy compressed tweets: (500M x 128 bytes)/1.6
<br> Compression rate: 1.6%

###### b.Instagram Photos
Daily Photos: 100M x 3.15 MB (PNG)
<br> Hard Disk: (315 TB x 3 Replica)/10 TB 

###### c.Youtube Photos
Daily Video: 500 Hours x 1440 Mins (per day) * 1.08 GB
<br> Hard Disk: (3.11 PB x 3 Replica)/10 TB

###### d. Yearly Calculation
Yearly Calculation: All the data * 365 days

|                                           | Size     | # HD | 
|-------------------------------------------|---------:|-----:|
| Daily Twitter Tweets (Uncompressed)       | 64 GB    |   1   |
| Daily Twitter Tweets (Snappy Compressed)  | 40 GB    |   1   |
| Daily Instagram Photos                    | 315 TB   |   95  |
| Daily YouTube Videos                      | 3.11 PB  |  ~935  |
| Yearly Twitter Tweets (Uncompressed)      | 23.36 TB |  8    |
| Yearly Twitter Tweets (Snappy Compressed) | 14.60 TB |  5    |
| Yearly Instagram Photos                   | ~115 PB   |  ~34493    |
| Yearly YouTube Videos                     | 1135.3 PB | ~340590      |

#### c. Reliability

 Annualized Failure Rate for 2022: 1.46% 
<br> Reference: https://www.backblaze.com/b2/hard-drive-test-data.html

|                                    | # HD | # Failures |
|------------------------------------|-----:|-----------:|
| Twitter Tweets (Uncompressed)      | 8   |      0      |
| Twitter Tweets (Snappy Compressed) | 5   |      0     |
| Instagram Photos                   | 34493   |  518  |
| YouTube Videos                     | 340590   | 5109   |

#### d. Latency

###### Los Angeles to Amsterdam
Link: https://www.consoleconnect.com/locations/amsterdam/

###### Low Earth Orbit Satellite & Geostationary Satellite
Link: https://www.satsig.net/latency.htm

###### Earth to the Moon & Earth to Mars
Link: https://www.spaceacademy.net.au/spacelink/commdly.htm

|                           | One Way Latency      |
|---------------------------|---------------------:|
| Los Angeles to Amsterdam  | 112 ms                 |
| Low Earth Orbit Satellite | 75 ms                |
| Geostationary Satellite   | 250 ms               |
| Earth to the Moon         | 1300 ms              |
| Earth to Mars             | 5 - 20 minutes       | 
