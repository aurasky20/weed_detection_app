class Weed {
  final String name;
  final String image;

  Weed({required this.name, required this.image});
}

class GulmaData {
  static final Map<String, List<Weed>> data = {
    "Gulma Daun Lebar": [
      Weed(
        name: "Amaranthus Spinosus",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Amaranthus-Spinosus_gdsgnd.jpg",
      ),
      Weed(
        name: "Ageratum Conyzoides",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Ageratum_Conyzoides_e0w0tb.jpg",
      ),
      Weed(
        name: "Phyllanthus Niruri",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Phyllanthus_Niruri_ccaukm.jpg",
      ),
      Weed(
        name: "Asystasia Gangetica",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Asystasia_Gangetica_kasfa0.jpg",
      ),
    ],

    "Gulma Daun Sempit": [
      Weed(
        name: "Cynodon dactylon L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860405/Cynodon_dactylon_L_c4rflt.jpg",
      ),
      Weed(
        name: "Eleusine indica L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Eleusine_indica_L_pfgftj.jpg",
      ),
      Weed(
        name: "Imperata cylindrica L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Imperata_cylindrica_L_tnjvwe.jpg",
      ),
      Weed(
        name: "Echinochloa crus-galli L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Echinochloa_crus-galli_L_dcnjis.jpg",
      ),
    ],

    "Gulma Teki-teki": [
      Weed(
        name: "Cyperus bervifolius",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_bervifolius_ny8j9r.jpg",
      ),
      Weed(
        name: "Cyperus rotundus L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_rotundus_L_dv1jnu.jpg",
      ),
      Weed(
        name: "Cyperus difformia L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_difformia_L_ejz88f.jpg",
      ),
      Weed(
        name: "Cyperus halpan L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Cyperus_halpan_L_csw8a2.jpg",
      ),
    ],
  };
}