import 'package:flutter/material.dart';
import 'widgets/supabase_config.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.annoKey,
  );
}