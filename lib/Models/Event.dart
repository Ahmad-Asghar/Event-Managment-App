
class Event {

  String? eventId;
  String? eventCreatedTime;
  String? eventImage;
  String? eventName;
  String? location;
  String? dateTime;
  String? maxEntries;
  String? tags;
  String? frequency;
  String? startTime;
  String? endTime;
  String? price;
  String? privacy;
  String? eventStatus;
  String? description;
  List<String>? sender;
  List<String>? joined;
  List<String>? senderModel;
  List<String>? eventVideos;

  Event({
    this.eventVideos,
    this.description,
    this.eventId,
    this.eventCreatedTime,
    this.eventImage,
    this.eventName,
    this.maxEntries,
    this.dateTime,
    this.location,
    this.endTime,
    this.frequency,
    this.joined,
    this.price,
    this.sender,
    this.startTime,
    this.tags,
    this.privacy,
    this.eventStatus,
    this.senderModel,
  });
  Event.fromMap(Map<String, dynamic> map) {
    description = map['description'];
    eventId = map['eventId'];
    eventCreatedTime = map['eventCreatedTime'];
    senderModel = (map['senderModel'] as List<dynamic>).cast<String>();
    eventImage = map['eventImage'];
    privacy = map['privacy'];
    eventStatus = map['eventStatus'];
    eventName = map['eventName'];
    maxEntries = map['maxEntries'];
    dateTime = map['dateTime'];
    location = map['location'];
    endTime = map['endTime'];
    frequency = map['frequency'];
    joined = (map['joined'] as List<dynamic>).cast<String>();
    eventVideos = (map['eventVideos'] as List<dynamic>).cast<String>();
    price = map['price'];
    sender = (map['sender'] as List<dynamic>).cast<String>();
    startTime = map['startTime'];
    tags = map['tags'];
  }
  Map<String, dynamic> toMap() {
    return {

      'description': description,
      'eventId': eventId,
      'eventCreatedTime': eventCreatedTime,
      'senderModel': senderModel,
      'eventVideos':eventVideos,
      'eventImage': eventImage,
      'eventStatus': eventStatus,
      'privacy': privacy,
      'eventName': eventName,
      'maxEntries': maxEntries,
      'dateTime': dateTime,
      'location': location,
      'endTime': endTime,
      'frequency': frequency,
      'joined': joined,
      'price': price,
      'sender': sender,
      'startTime': startTime,
      'tags': tags,
    };
  }
}

