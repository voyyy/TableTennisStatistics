import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/core/services/Api.dart';
import 'package:table_tennis_statistics/core/models/MatchModel.dart';
import 'package:table_tennis_statistics/locator.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Match> matches;

  Future<List<Match>> fetchMatches() async {
    var result = await _api.getMatchHistoryCollection();
    matches = result.documents
        .map((doc) => Match.fromMap(doc.data, doc.documentID))
        .toList();
    return matches;
  }

  Stream<QuerySnapshot> fetchMatchesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Match> getMatchById(String id) async {
    var doc = await _api.getMatchById(id);
    return Match.fromMap(doc.data, doc.documentID);
  }

  Future removeMatch(String id) async {
    await _api.removeMatch(id);
    return;
  }

  Future addMatch(Match data) async {
    await _api.addMatch(data.toJson());
    return;
  }

  Future updateMatch(Match data, String id) async {
    await _api.updateMatch(data.toJson(), id);
    return;
  }
}
