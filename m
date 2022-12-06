Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358C643F02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiLFItn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 03:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLFItm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:49:42 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2078.outbound.protection.outlook.com [40.92.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945F2BD7;
        Tue,  6 Dec 2022 00:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJA80ODj3yYm1IvM9xDAvNhR3r2QC3qPhLCI+lMMV+N8+9IpUCTtUmBC5LRkURel06qgZeX4OB0kY6Qr8YJmCd6ySOfFry+WxI5VOp5K2lKVOfzo6veRhVHmSAHhdv9fYNUyzFmpEwAL+2uFNA8l6Haq6/ch8jBFW7H5KynqabN9yBAdD9FeQld+0UF3hvUZtIywFQm+mByHBsnRHJOc5MGZN48pHorISDsAxy9rQ8tzlfN3zRevd3e4tchSmjwMorE8jJpo4phWPR+7dtTrsYeEtmI6ra2Rat5oLOtzuWy5RD41kQrZ8tSFRAsUOJgho9uQvzG1yjGZDKFfVYpEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCqQO65eRe5hn3duEhi+39UEBgzcTeDIxtHIDBOTc74=;
 b=njAmzgvzqNXiq154OdEGROIYxSqx4BKKOiZEDfx0iRPlLd76QIumDsZ8VSdiRh5VmunbqIymJNSiq+CKLjeYayceaHCwtB2QkZhYNJJp3IlsaArF+z0QdL+XTQme0n45F3Ehwkf2o1RpP85GbMhvsI6FbrokYuMvFBDAGhSnwi/vMu1izn8bgo+uYvbiz6LK28ws7v93VxGtrMd+51gd5ct/9chPCFsOYOiEiHPe4hkBjifrya2Cq2UrsQDr9ABgIsKQHu1V2c5lb7qf0FzI/clBIX5v4RdnHLii8dG9lob5TzsfDiKIAjScu+EtcvfeGPOp+K+BZ8DF4h3kfK6+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCqQO65eRe5hn3duEhi+39UEBgzcTeDIxtHIDBOTc74=;
 b=rkOKSwuG1fdxWqiugm8NL1IOcD3b2U+O8JxF0S569Z2DK8kTP+ccWHYBNaqN5M9z8IJq5/i1hRi5CyfSjf80z+6zAs7i/P77meCaUgbNIxB87KywBx4K4F5sm9r2exP4hYuDH+dGSCqmBopVXt3lpsUId8kypPDJ7lHGrfwPjhWhCVXL8xPnOzh5/DSxmFEgACEdMLex/pO0cK8lH8Cz42WfGojvgy/NT5PG6iI7u117jjWvs07VwEd9yjG8jUUJ4vRiJhaWsd56Q95UR3ghzPsqr6wRU2NQI7/sjnWPfrF6MSretVQZk6wnIcenYdGYO0OJuvQfXbuM6HW32roOOg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB4474.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 08:49:34 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:49:34 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Topic: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Index: AQHZBmRIqZUco1oHfUewwcIrvr9k1a5bExaAgAC5qICABDvJAIAAf4aAgAAKbwA=
Date:   Tue, 6 Dec 2022 08:49:34 +0000
Message-ID: <CD80923F-4422-416B-AAC1-A676D37C564F@live.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
 <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
 <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
 <FBF299DB-E235-4BD3-82BD-5A54EE9E26DA@live.com>
In-Reply-To: <FBF299DB-E235-4BD3-82BD-5A54EE9E26DA@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [U4eUTjpSRsfKuhoFbKvPSLSa+/Lzavn8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB4474:EE_
x-ms-office365-filtering-correlation-id: 9cf4ce07-076f-4444-ea9c-08dad766cc90
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GION6ND+yMTmTcxo0xQ+UcZOZGJYhUObfGxNl318suN1AVpmm53rbNJaO1ugcrOoEKFIiSIYYetKRFNJri82bHwd+ycHkH8LDRS8c8qoDNA7FbfBtYI8t9/6lKIhqu+0zs0KUdQFQhUmPk5uHX4WVPb/wOl9tR01AVibbtDz/DqhiAD0MVbmESZGzs5qHmzb4NOTEEE3K3NjWYvC/N/jKVvZ2vH/KcasFpG24gXltaJvvz+oqwL/MU7vuWeplyzP3jHdJLTraL2wYAekWViSMIkesZdPLxxGLLPnRbEuYMjCyQsSzcjXv1+3sEye3EhoUq3HGcA1Ij+G2ggsgL+CwlJLMQ3gsCE6nm5ow+CgDibf6vF8BPvbTgHMPAa24xG4LERlrA+gvh3cPaOoba7aXly7iD2oRu2/WzjhmFgTZJn/hxWcoI+obeI3/zmA9Gi3ruL8lrHUk8V7Hza83LYxPWD3zoJOIAGz6ht/eOWePSIWDPPL8CgMdnJOmgV2S9EoC7Dzl/G976fbYVqLdmnFqi7nb/uljLxsC+7qAblUBH56QfjcXFezS1gi2RPredoFFLHqHmv4WWqY8DzELigZoHRqH3mo6hf8NI+T8PbgMuUaTmHhGIZQjpr7gImbGG4SOeBZFjNxX87ijT9K9FciaA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFRlck9FTlc5NmpTbmRQcWE4eFJCYU9seWNYaTc2aWhhODFpejE3RkE5SUFN?=
 =?utf-8?B?a2hNT3A4MHVlSlI1YXJ0VzFrcEdmaE9ocTJmRm00ZlR4czhQRC83NTY3d2JT?=
 =?utf-8?B?VnBUNDNtYnAwQ2xzZk9xanM3YXc0VFRFMnBmK0tDTnV3dFNKajZlRWcxZlFI?=
 =?utf-8?B?ZkpqYTBTbGVVZ2NYRzVpQ0RUV2xrTVpxbWNWUXVHa1lZWlNoTWpPY29kemt2?=
 =?utf-8?B?bVJVZTVybXQyd2NDbkVxMUJuT2dpcGJyVWs4c2Nucy9paVhEMk41WmtPV3ZR?=
 =?utf-8?B?cDVCM3VldXZURFZONmhpcnVpOHU0akxmazlJVjZlenJFeHkzUk9kTHJlNUlU?=
 =?utf-8?B?ekNHMHpORWNNb041OUdqWm1YbVhIdHViWVlXV21SaXpkb0crTVdpajNKZWNW?=
 =?utf-8?B?R3RyTzhSeHZjNGlPZGNSaWw4d3ExZElqTThIZmdRVjdvNDVQaGxTdWpaOEdr?=
 =?utf-8?B?ZWNESmxjMXZreld2K0cvR3hXVnRFUEZERjFHVGJlM25LbWpGNXJpNDA3VWFp?=
 =?utf-8?B?MHpjNHJHR1J3QU1iOGZEUEp6dkl1N0VxNFdlUmtRdGZEbG9ZSG1aemNnYWlE?=
 =?utf-8?B?MzhOVWdsalVzWE5hcjdNVDBac3lNVDUySldyUlQ0U3Q2ZEZLL0g1aU9GdEti?=
 =?utf-8?B?dnRlTURpeTFqNlJMbzRrNkJKNWdxWGpSVnJwc05DeUFrc1BLYjRPa3BCTmNI?=
 =?utf-8?B?QkxBc0Vvd2kyMUdjUy94VVBUNUhzenhXU1YzMDM0MW9nUEl6VEp5ekRSNTU1?=
 =?utf-8?B?T3ZXM0NTYjgxNWJpWGNHVUx6TnhVMDhiZWRqd0F6dUlvT3I4YngvRUFZdTRM?=
 =?utf-8?B?NG94M2t2RmJzMktVYU1XRkl2TklpemJPNmZGSHVkVlVWYUlZdmJLT3RmVDdO?=
 =?utf-8?B?MUpId3FRaUpiY21MSWZhOXQvTDV5NjF5RjI2Q09QUUpYSWlNSGZ3YWlRVHZz?=
 =?utf-8?B?K2N1Nk84YnlrZk0xUm0zRU92TlI4N1ViV3I1UHgxSEppQm5SRkdMRXFPMnlB?=
 =?utf-8?B?YWlSL2JKOXhZYVN5NUNtTlZhbDhsZXVBTHBxcmZkYVczMlJXNzdSL2FZWWk0?=
 =?utf-8?B?Qi85OWtpNGs3ZWx4dys2U1VheVI1SEZ2ZzF4OVUwRzJuY2tiK3VKcUk0MHBR?=
 =?utf-8?B?NUltMUdKL3NNN1h6SklVUDEvdnRSZUI4VnRuMXpNU3BtVGRSblhaeDZlZ0Vk?=
 =?utf-8?B?d1EzMWhZbW1tWi9pcVQzU254N2pQN2tRa0NXU3MrVzE5ZFc2a1pndDdEUDA1?=
 =?utf-8?B?Y0dsQmNiWXlrdExyK1pXcC9FMmsxU09sQzRyZDBObCtRWXVMRFFIOEZPT0xl?=
 =?utf-8?B?SEFnNExkK0ZoY3p2ZFYwTXZrMEZiM3plNGg5SnBzNVZkdXM4NEpPZ1ZFV2R6?=
 =?utf-8?B?VTBZQ0hIaWMxdkVnYk9qazN6c0ZTbVE0N25oRHpFdU9zR0RNampzaC9uck1S?=
 =?utf-8?B?NEhuek40S2dpYzVTaWZJZ3Ezak5vaDRVNFA5RGZCbGxpdTNkUFpFYVViYko2?=
 =?utf-8?B?MnU5bFhvNTRWZVU4emNPLzlyeGRLdEFqZ3lYVXAvMHFDbHFITDB3T2QwUG5s?=
 =?utf-8?B?eFhrVnpSMWwrOHZBWitRWEZJZjlzd2lMTGwySnBKOHVJMTZzaFFSd3FIMmo5?=
 =?utf-8?B?ekw3ckN0V0JvcGx0RlVRWllsVmJiQWpMQzJqblpsalFvRWZPYUFGVkVLNXJB?=
 =?utf-8?B?NytrbWVHM3pMNWt3akRkenVVUjlPQ0hLdE1mcWI0V0kzakx5RDF1VkxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B6E5B47F85C3408EB162D7C3DFF9FF@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf4ce07-076f-4444-ea9c-08dad766cc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 08:49:34.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IFdlbGwgaW5pdGlhbGx5IEkgd2hlbiBJIHRyaWVkIHRvIGludmVzdGlnYXRlIHdoYXTigJlz
IHdyb25nLCBhbmQgZm91bmQgdGhhdCB0aGUgb2xkIGxvZ2ljIHdhcyB0aGUgY3VscHJpdCwgSSBk
aWQgc29tZSBsb2dnaW5nIHRvIHNlZSB3aGF0IGV4YWN0bHkgd2FzIHdyb25nLiBUaGUgbG9nIHBh
dGNoIGlzIGhlcmUgYnR3IDotIGh0dHBzOi8vZ2l0aHViLmNvbS9BZGl0eWFHYXJnOC9saW51eC9j
b21taXQvZjY2OGZiMDEyZjU5NWQ4MzA1MzAyMGI4OGI5NDM5YzI5NWI0ZGMyMQ0KPiANCj4gU28g
SSBzYXcgdGhhdCB0aGUgb2xkIGxvZ2ljIHdhcyBhbHdheXMgZmFsc2UsIG5vIG1hdHRlciB3aGV0
aGVyIEkgbW91bnRlZCB3aXRoIHVpZCBvciBub3QuDQo+IA0KPiBJIHRyaWVkIHRvIHNlZSB3aGF0
IG1ha2VzIHRoaXMgdHJ1ZSwgYnV0IGNvdWxkbid0IHN1Y2NlZWQuIFNvLCBJIHRob3VnaHQgb2Yg
YSBzaW1wbGVyIGFwcHJvYWNoIGFuZCBjaGFuZ2VkIHRoZSBsb2dpYyBpdHNlbGYuDQo+IA0KPiBU
byBiZSBob25lc3QsIEkgZHVubm8gd2hhdCBpcyB0aGUgb2xkIGxvZ2ljIGZvci4gTWF5YmUgaW5z
dGVhZCBvZiBjb21wbGV0ZWx5IHJlbW92aW5nIHRoZSBvbGQgbG9naWMsIEkgY291bGQgdXNlIGFu
IE9SPw0KPiANCj4gSWYgeW91IHRoaW5rIGl0cyBtb3JlIGxvZ2ljYWwsIEkgY2FuIG1ha2UgdGhp
cyBjaGFuZ2UgOi0NCj4gDQo+IC0JaWYgKCFpX2dpZF9yZWFkKGlub2RlKSAmJiAhbW9kZSkNCj4g
KwlpZiAoKHRlc3RfYml0KEhGU1BMVVNfU0JfVUlELCAmc2JpLT5mbGFncykpIHx8ICghaV91aWRf
cmVhZChpbm9kZSkgJiYgIW1vZGUpKQ0KPiANCj4gVGhhbmtzDQo+IEFkaXR5YQ0KPiANCj4gDQoN
CkkgY29udGludWF0aW9uIHdpdGggdGhpcyBtZXNzYWdlLCBJIGFsc28gdGhpbmsgdGhlIGJpdHMg
c2hvdWxkIGJlIHNldCBvbmx5IGlmICghdWlkX3ZhbGlkKHNiaS0+dWlkKSBpcyBmYWxzZSwgZWxz
ZSB0aGUgYml0cyBtYXkgYmUgc2V0IGV2ZW4gaWYgVUlEIGlzIGludmFsaWQ/IFNvLCBkbyB5b3Ug
dGhpbmsgdGhlIGNoYW5nZSBnaXZlbiBiZWxvdyBzaG91bGQgYmUgZ29vZCBmb3IgdGhpcz8NCg0K
ZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvb3B0aW9ucy5jIGIvZnMvaGZzcGx1cy9vcHRpb25zLmMN
CmluZGV4IDA0N2UwNWM1Ny4uYzk0YTU4NzYyIDEwMDY0NA0KLS0tIGEvZnMvaGZzcGx1cy9vcHRp
b25zLmMNCisrKyBiL2ZzL2hmc3BsdXMvb3B0aW9ucy5jDQpAQCAtMTQwLDYgKzE0MCw4IEBAIGlu
dCBoZnNwbHVzX3BhcnNlX29wdGlvbnMoY2hhciAqaW5wdXQsIHN0cnVjdCBoZnNwbHVzX3NiX2lu
Zm8gKnNiaSkNCiAJCQlpZiAoIXVpZF92YWxpZChzYmktPnVpZCkpIHsNCiAJCQkJcHJfZXJyKCJp
bnZhbGlkIHVpZCBzcGVjaWZpZWRcbiIpOw0KIAkJCQlyZXR1cm4gMDsNCisJCQl9IGVsc2Ugew0K
KwkJCQlzZXRfYml0KEhGU1BMVVNfU0JfVUlELCAmc2JpLT5mbGFncyk7DQogCQkJfQ0KIAkJCWJy
ZWFrOw0KIAkJY2FzZSBvcHRfZ2lkOg0KQEAgLTE1MSw2ICsxNTMsOCBAQCBpbnQgaGZzcGx1c19w
YXJzZV9vcHRpb25zKGNoYXIgKmlucHV0LCBzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkpDQog
CQkJaWYgKCFnaWRfdmFsaWQoc2JpLT5naWQpKSB7DQogCQkJCXByX2VycigiaW52YWxpZCBnaWQg
c3BlY2lmaWVkXG4iKTsNCiAJCQkJcmV0dXJuIDA7DQorCQkJfSBlbHNlIHsNCisJCQkJc2V0X2Jp
dChIRlNQTFVTX1NCX0dJRCwgJnNiaS0+ZmxhZ3MpOw0KIAkJCX0NCiAJCQlicmVhazsNCiAJCWNh
c2Ugb3B0X3BhcnQ6DQoNCg==
