// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsArticleAdapter extends TypeAdapter<NewsArticle> {
  @override
  final int typeId = 0;

  @override
  NewsArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsArticle(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      content: fields[3] as String?,
      imageUrl: fields[4] as String,
      source: fields[5] as String,
      publishedAt: fields[6] as DateTime,
      category: fields[7] as String,
      videoUrl: fields[8] as String?,
      viralScore: fields[9] as double,
      generatedHashtags: (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsArticle obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.source)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.videoUrl)
      ..writeByte(9)
      ..write(obj.viralScore)
      ..writeByte(10)
      ..write(obj.generatedHashtags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
