Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8C13338
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfECRkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 13:40:15 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:33116 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 13:40:15 -0400
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 147612677
IronPort-PHdr: =?us-ascii?q?9a23=3ACcCkFxwt8jZnIxrXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YhGN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZudBkr2MOzCaiUmHIJfSFJ19mr9PERIS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EeAAC2fMxchzImL2hlHgEGBwaBUQk?=
 =?us-ascii?q?LAYE9UIFhBAsoCoQGg0cDhTGJT4IqLZhSgSQDGDwBDgEtAoQ+AheCEzQJDgE?=
 =?us-ascii?q?DAQEFAQEBAQICAhABAQEIDQkIKSMMg0U5MgEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQUCODgBAQEDARIRBA0MAQEpAgwBDwIBCBUDAgI?=
 =?us-ascii?q?mAgICMBUCAQ0CBA4gAwSDAIFrAw4PAaFAPQJiAguBASmIX3F8M4J5AQEFhQA?=
 =?us-ascii?q?YQQeBRgmBCycBi14GgUE+gTiBbX4+hB0TFIMKgliLGyGBbSyYfGUJAoIJkj8?=
 =?us-ascii?q?GG5VInUqDOgIEAgQFAg4BAQWBT4IPchM7gmyCDwwOCYNMilNAATGBKY1EASW?=
 =?us-ascii?q?BCwGBIAEB?=
X-IPAS-Result: =?us-ascii?q?A2EeAAC2fMxchzImL2hlHgEGBwaBUQkLAYE9UIFhBAsoC?=
 =?us-ascii?q?oQGg0cDhTGJT4IqLZhSgSQDGDwBDgEtAoQ+AheCEzQJDgEDAQEFAQEBAQICA?=
 =?us-ascii?q?hABAQEIDQkIKSMMg0U5MgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCODgBAQEDARIRBA0MAQEpAgwBDwIBCBUDAgImAgICMBUCAQ0CB?=
 =?us-ascii?q?A4gAwSDAIFrAw4PAaFAPQJiAguBASmIX3F8M4J5AQEFhQAYQQeBRgmBCycBi?=
 =?us-ascii?q?14GgUE+gTiBbX4+hB0TFIMKgliLGyGBbSyYfGUJAoIJkj8GG5VInUqDOgIEA?=
 =?us-ascii?q?gQFAg4BAQWBT4IPchM7gmyCDwwOCYNMilNAATGBKY1EASWBCwGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.60,426,1549951200"; 
   d="scan'208";a="147612677"
X-Utexas-Seen-Outbound: true
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by esa10.utexas.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2019 12:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFCQhWZ++O2GonS8IeDPRCmcn30Wv2hQ5pAaoP4GgaU=;
 b=lXdSrTF/mMLegYstgXYtO2Tg/0xTLO92DZw2+RghyT9drmoPmEifAJZPWwB9HFFtSM9H7Ew6JkVC5D80ivZGfAa8Bnvh1fW3TegCV6NmXke9wRujciyYgF1Q1uegUVqQas9vQaIxfNCDYqUas6X2XXBBxvyesSF5jQiK23FEHOs=
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com (10.167.109.15) by
 DM5PR0601MB3703.namprd06.prod.outlook.com (10.167.109.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 17:39:55 +0000
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507]) by DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507%6]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 17:39:55 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?utf-8?B?QW5kcmVhcyBHcsO8bmJhY2hlcg==?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Thread-Topic: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Thread-Index: AQHVAIspItZqAESGCECfW8viq8okK6ZXI70AgAARYICAAI5xAIAAWKOAgAAB8oCAAWoWAIAAJReA
Date:   Fri, 3 May 2019 17:39:55 +0000
Message-ID: <c8981a63-2b57-6d91-7aa1-3b11d5bdb5a8@math.utexas.edu>
References: <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name>
 <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
 <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
 <31520294-b2cc-c1cb-d9c5-d3811e00939a@math.utexas.edu>
 <20190503152702.GI12608@fieldses.org>
In-Reply-To: <20190503152702.GI12608@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::36) To DM5PR0601MB3718.namprd06.prod.outlook.com
 (2603:10b6:4:7d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8b777d-b08a-4fb5-308d-08d6cfee5ab5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR0601MB3703;
x-ms-traffictypediagnostic: DM5PR0601MB3703:
x-microsoft-antispam-prvs: <DM5PR0601MB37037E0DF5673A053C4F287083350@DM5PR0601MB3703.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(2906002)(7736002)(486006)(31686004)(305945005)(229853002)(6486002)(6436002)(786003)(316002)(71190400001)(86362001)(476003)(31696002)(25786009)(14454004)(71200400001)(54906003)(446003)(2616005)(99286004)(11346002)(5660300002)(7416002)(3846002)(6246003)(6916009)(26005)(66066001)(66476007)(81156014)(6512007)(53936002)(66946007)(68736007)(4326008)(6116002)(53546011)(386003)(478600001)(88552002)(52116002)(75432002)(76176011)(186003)(6506007)(8936002)(64756008)(66556008)(81166006)(8676002)(102836004)(14444005)(256004)(73956011)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3703;H:DM5PR0601MB3718.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kLxBkO4Y8mxo5FOY7aA3Gu+EEj/8KpUqp9QDaMXI0a9Pa5q/65FBnFtghFp0TUVpcvV+MDpPeya3HovuQlMR09Wc3deM2P2QfDej9gsVfmjjr+R6eRG2dCRQdH/A4QCTxTT89FGoTJLIjduekJAPjVazVCzhc2ZKmnRBV18ef5BqmT6SIdwwku7csL/Qgn6vVEEKqTkVA3L3YQsw5vhQV0QRGwRlaDsOvfYwF3tDoNFdd6CqcO/s3wszfDPwGGxEkG8B8aN72el3ix4wB+2rcHnS+i+/bb81jUvsNUnTDZyF744N+PrNtz/TgMEmy9j4nfbPSWSpkFRieVpSypXkbpAeH46GW5HQA+DuwCGltmAXH9RBTFNQJ32ZSxNLTrJjlRDmepqdujRdJUXtyGSXWvRCbdmTpmiosV4QdYzM9Vc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2DD29316AA48A47B5F87E2A88CAD26B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b777d-b08a-4fb5-308d-08d6cfee5ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 17:39:55.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3703
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNS8zLzE5IDEwOjI3IEFNLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+IENocmlzdG9waCBh
bHNvIGhhZCBzb21lIG9iamVjdGlvbnMgdG8gdGhlIGltcGxlbWVudGF0aW9uIHdoaWNoIEkgdGhp
bmsNCj4gd2VyZSBhZGRyZXNzZWQsIGJ1dCBJIGNvdWxkIGJlIHdyb25nLg0KDQoNCkknbSBjZXJ0
YWlubHkgbm8gZXhwZXJ0LCBidXQgeWVzLCB0aGUgb2JqZWN0aW9ucyB0byB0aGUgUmljaEFDTCBw
YXRjaGVzIA0Kd2VyZSBhZGRyZXNzZWQgYW5kIG5vdCByZWFsbHkgY291bnRlciBjaGFsbGVuZ2Vk
LiAgSXQgc2VlbXMgbGlrZSBhIGNhc2UgDQpvZiBXaW5kb3dzIEFDTHMgYXJlIHl1Y2t5IGFuZCBj
b21wbGljYXRlZCBhbmQgbm90IG5lZWRlZCBpbiBhbGwgbGludXggDQplbnZpcm9ubWVudHMgKHdo
aWNoLCBieSB0aGUgd2F5LCBJJ3ZlIGxlYXJuZWQgaXNuJ3QgZW50aXJlbHkgdHJ1ZSkuDQoNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNocmlzdG9waCBIZWxs
d2lnOg0KID4gRm9yIG9uZSBJIHN0aWxsIHNlZSBubyByZWFzb24gdG8gbWVyZ2UgdGhpcyBicm9r
ZW4gQUNMIG1vZGVsIGF0IGFsbC4NCiA+IEl0IHByb3ZpZGVzIG91ciBhY3R1YWx5IExpbnV4IHVz
ZXJzIG5vIGJlbmVmaXQgYXQgYWxsLCB3aGlsZSBicmVha2luZw0KID4gYSBsb3Qgb2YgYXNzdW1w
dGlvbnMsIGVzcGVjaWFsbHkgYnkgYWRkaW5nIGFsbG93IGFuZCBkZW55IEFDRSBhdCB0aGUNCiA+
IHNhbWUgc2ltZS4NCg0KRnJvbTogQW5kcmVhcyBHcnVlbmJhY2hlcjoNClRoaXMgcGVybWlzc2lv
biBtb2RlbCBpcyB1c2VmdWwgaW4gbWl4ZWQgZW52aXJvbm1lbnRzIHRoYXQgaW52b2x2ZQ0KVU5J
WCBhbmQgV2luZG93cyBtYWNoaW5lcy4gVGhpbmsgb2YgTkFTIGJveGVzIHdpdGggTGludXggYW5k
IFdpbmRvd3MNCmNsaWVudHMsIGZvciBleGFtcGxlLiBJdCBhbHNvIGZpdHMgdGhlIE5GU3Y0IEFD
TCBtb2RlbCB2ZXJ5IHdlbGwuIElmDQp5b3UncmUgbm90IGEgdXNlciBkZWFsaW5nIHdpdGggc3Vj
aCBlbnZpcm9ubWVudHMsIHRoZW4gdGhlIG1vZGVsDQpsaWtlbHkgd29uJ3QgcHJvdmlkZSBhbnkg
YmVuZWZpdHMgdG8gKnlvdSosIGFuZCB5b3UncmUgYmV0dGVyIG9mZiB3aXRoDQphIGxlc3MgY29t
cGxpY2F0ZWQgcGVybWlzc2lvbiBtb2RlbC4gVGhhdCBkb2Vzbid0IHNheSBhbnl0aGluZyBhYm91
dA0Kb3RoZXIgdXNlcnMsIHRob3VnaC4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoNCmFuZCBoZXJlOg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQ2hyaXN0b3BoIEhlbGx3aWc6DQogPiBJdCBhbHNvIGRvZXNuJ3QgaGVscCB3
aXRoIHRoZSBpc3N1ZSB0aGF0IHRoZSBtYWluIHRoaW5nIGl0J3MgdHJ5aW5nDQogPiB0byBiZSBj
b21wYXRpYmxlIHdpdGggKFdpbmRvd3MpIGFjdHVhbGx5IHVzZXMgYSBmdW5kYW1lbnRhbGx5DQog
PiBkaWZmZXJlbnQgaWRlbnRpZmllciB0byBhcHBseSB0aGUgQUNMcyB0byAtIGFzIGxvbmcgYXMg
eW91J3JlDQogPiBzdGlsbCBsaW1pdGVkIHRvIHVzZXJzIGFuZCBncm91cHMgYW5kIG5vdCBndWlk
cyB3ZSdsbCBzdGlsbA0KID4gaGF2ZSB0aGF0IG1hcHBpbmcgcHJvYmxlbSBhbnl3YXkuDQoNCkZy
b206IEFuZHJlYXMgR3J1ZW5iYWNoZXI6DQpTYW1iYSBoYXMgYmVlbiBkZWFsaW5nIHdpdGggbWFw
cGluZyBiZXR3ZWVuIFNJRHMgYW5kIFVJRHMvR0lEcyBmb3IgYQ0KbG9uZyB0aW1lLCBhbmQgaXQn
cyB3b3JraW5nIGFjY2VwdGFibHkgd2VsbC4NCg0KV2UgY291bGQgc3RvcmUgU0lEcyBpbiBBQ0Vz
LCBidXQgdGhhdCB3b3VsZG4ndCBtYWtlIHRoZSBhY3R1YWwNCnByb2JsZW1zIGdvIGF3YXk6IEZp
bGVzIG9uIExpbnV4IGhhdmUgYW4gb3duZXIgYW5kIGFuIG93bmluZyBncm91cA0Kd2hpY2ggYXJl
IGlkZW50aXRpZmVkIGJ5IFVJRC9HSUQsIHdoZXJlYXMgYSBmaWxlIGlzIG93bmVkIGJ5IGEgU0lE
DQp3aGljaCBjYW4gYmUgZWl0aGVyIGEgdXNlciBvciBhIGdyb3VwIGluIGEgU0lEIHdvcmxkLiBB
bHNvLCBwcm9jZXNzZXMNCm9uIExpbnV4IGhhdmUgYW4gb3duZXIgYW5kIGEgbGlzdCBvZiBncm91
cHMgd2hpY2ggYXJlIGlkZW50aWZpZWQgYnkNClVJRC9HSUQsIHNvIGFueSBTSURzIHN0b3JlZCBp
biBmaWxlc3lzdGVtcyB3b3VsZCBuZXZlciBtYXRjaCBhDQpwcm9jZXNzLCBhbnl3YXkuDQoNCihO
RlN2NCByZWZlcnMgdG8gdXNlcnMgYW5kIGdyb3VwcyBhcyBvcHBvc2VkIHRvIFNJRHMsIGFuZCBz
byBpdA0KZG9lc24ndCBoYXZlIHRoaXMgcHJvYmxlbS4pDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpGdXJ0aGVyLCB0aGUgY291bnRlcmFyZ3VtZW50cyBzZWVt
IHdlYWssIGF0IGJlc3Q6DQoNCiA+IFBlb3BsZSBoYXZlIGxvbmcgbGVhcm5lZCB0aGF0IHdlIG9u
bHkgaGF2ZSAnYWxsb2MnIHBlcm1pc3Npb25zLiAgQW55DQogPiBtb2RlbCB0aGF0IG1peGVzIGFs
bG93IGFuZCBkZW55IEFDRSBpcyBhIG1pc3Rha2UuDQoNCkFzIHNvbWVvbmUgcG9pbnRlZCBvdXQg
ZWxzZXdoZXJlIGluIHRoZSB0aHJlYWQsIGxpbnV4IHBlb3BsZSBhcmUgDQpob3BlZnVsbHkgdXNl
ZCB0byBsZWFybmluZyBuZXcgdHJpY2tzLg0KDQpXaG8gdGhlc2UgZGF5cyBoYXMgdGhlIGx1eHVy
eSBvZiBub3Qgd29ya2luZyBpbiBhIG1peGVkIGVudmlyb25tZW50PyAgSSANCmFncmVlIHRoYXQg
V2luZG93cyBBQ0xzIGFyZSBraW5kIG9mIGdyb3NzIGFuZCBvdmVybHkgY29tcGxpY2F0ZWQgKGFu
ZCBhcyANCmEgcmVzdWx0LCBtYW55IHBlb3BsZSBkb24ndCB1c2UgdGhlbSBhdCBhbGwgYW5kIGVu
ZCB1cCB3aXRoIGxvdyBzZWN1cml0eSANCnBlcm1pc3Npb24gZW52aXJvbm1lbnRzKSwgYnV0IHRo
ZSBwcm9mZXNzaW9uYWwgV2luZG93cyBhZG1pbnMgSSBrbm93IGRvIA0KdXNlIHRoZW0sIGFuZCB3
ZSd2ZSBoYWQgYSBudW1iZXIgb2YgdXNlIGNhc2VzIGFscmVhZHkgd2hlcmUgcGVybWlzc2lvbnMg
DQpwcm9ibGVtcyBhcmUgc2ltcGx5IHNvbHZlZCB1c2luZyBXaW5kb3dzIEFDTHMsIGltcG9zc2li
bGUgdG8gZ2V0IGp1c3QgDQpyaWdodCB3aXRoIG1vZGUgYml0cyBhbmQgUE9TSVggQUNMcy4gIE5v
dCBoYXZpbmcgUmljaEFDTHMganVzdCBtYWtlcyBpdCANCnJlYWxseSBlYXN5IGZvciB0aGUgV2lu
ZG93cyBzdG9yYWdlIHBlb3BsZSB0byB3aW4gZXZlcnkgYXJndW1lbnQuDQoNClRoZSBTSUQgPC0t
PiBVSUQgdGhpbmcgaXMgbWFuYWdlYWJsZTsgd2UncmUgZG9pbmcgaXQgbm93LiAgRGVhbGluZyB3
aXRoIA0KZ3JvdXBzIGlzIGEgYml0IGhhcmRlci4gIFdoYXQgSSd2ZSBiZWVuIGRvaW5nIGlzIGNv
bnRpbnVpbmcgdG8gdXNlIA0KL2V0Yy9ncm91cCwgYnV0IHBvcHVsYXRpbmcgdGhlIGVudHJpZXMg
d2l0aCB0aGUgdXNlcm5hbWVzIGFzc29jaWF0ZWQgDQp3aXRoIFNJRHMgKHdoaWNoIGluIG91ciBj
YXNlIGFyZSBtYXBwZWQgZGlyZWN0bHkgdG8gVUlEcykuICBGb3IgZmlsZXMgDQpvd25lZCBieSBh
IGdyb3VwIFNJRCwgdGhlIHNpbXBsZSBzb2x1dGlvbiBpcyBqdXN0IHRvIHRyZWF0IHRoaXMgU0lE
IGFzIGEgDQpkdW1teSBVSUQuICBJIGhhdmVuJ3QgaGFkIHRvIHVzZSB0aGlzIHlldCwgYnV0IGl0
IHNlZW1zIGxpa2UgaXQgc2hvdWxkIA0Kd29yay4gc3NzZCBoYXMgbWFkZSBtdWNoIG9mIHRoaXMg
bW9yZSBtYW5hZ2VhYmxlLiAgVGhlIG1pc3Npbmcga2lsbGVyIA0KZmVhdHVyZSBpcyBhIHNvbWV3
aGF0IHVuaWZpZWQgYXV0aG9yaXphdGlvbiBtb2RlbC4NCg0KVGhlIGZhY3QgdGhhdCBXaW5kb3dz
IGFzc2lnbnMgU0lEcyB0byBtYWNoaW5lcyBpcyBhY3R1YWxseSBhIG1ham9yIA0KdGVjaG5vbG9n
aWNhbCBhZHZhbnRhZ2Ugb3ZlciB0aGUgVU5JWC9saW51eCBtb2RlbCAodGhpcyBzdXJlIHdvdWxk
IA0Kc2ltcGxpZnkgTkZTLCBmb3IgZXhhbXBsZSksIGJ1dCB0aGVuIHRoZXkgaGFkIHRoZSBhZHZh
bnRhZ2VzIG9mIA0KaGluZHNpZ2h0LiAgQW5kIHRoYXQncyBqdXN0IGFuIGFzaWRlIGFueXdheS4N
Cg==
