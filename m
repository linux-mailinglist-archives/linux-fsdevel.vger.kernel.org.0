Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492AB16D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 23:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfEGVYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 17:24:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfEGVYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 17:24:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47LE1hS020331;
        Tue, 7 May 2019 14:24:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TvhHgmWOGiILa2VtWTss5ZvNvIruRwKzymE5dljvDpk=;
 b=QlKzHquR/0iHo7caVacFmycoM4foAGKrWSNYaxMmFBf7R94XyYSZLHKTQi/l6IX8C6BL
 r1ULtMZroR+mGisenRpk6QJBg5BZy/cFuNs/YZt75Ezn2XZk24eWSj4IFoMxRLb1qMWy
 oTxOZoi1onPfgz8VMN/6HTrHE5+KCgSgK1o= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbca39edu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 May 2019 14:24:48 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 14:24:43 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 14:24:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 14:24:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvhHgmWOGiILa2VtWTss5ZvNvIruRwKzymE5dljvDpk=;
 b=dccgKoHv4jGB3J8wrFg93MmPIDRTAMs7NlJ271Ztw4vFtUrhVNcfIY4IubJG939aENtHaUXuOKpjqfvovVzfhYrOnu8d7eKCNUrCO5Jrbl9GXy8SPN14hoVb8o4qKzFgL2qjedLFH9QrTjSIlznwry5k54WdLtIJs4xb2ZHxayU=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1177.namprd15.prod.outlook.com (10.173.209.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 21:24:41 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 21:24:41 +0000
From:   Chris Mason <clm@fb.com>
To:     Bryan Gurney <bgurney@redhat.com>
CC:     Ric Wheeler <ricwheeler@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Jan Tulak <jtulak@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        "Dennis Zhou" <dennisz@fb.com>
Subject: Re: Testing devices for discard support properly
Thread-Topic: Testing devices for discard support properly
Thread-Index: AQHVBE5Bi2ef6/xelUuGGE5bSnXuBqZfP0GAgAAbioCAAA5XgIAANwSAgAAsXICAAAJ3gIAASgcAgAAU4QA=
Date:   Tue, 7 May 2019 21:24:41 +0000
Message-ID: <31794121-DEDA-4269-8B72-50EB4D0BCABE@fb.com>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507071021.wtm25mxx2as6babr@work>
 <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
 <20190507094015.hb76w3rjzx7shxjp@work>
 <09953ba7-e4f2-36e9-33b7-0ddbbb848257@gmail.com>
 <CAHhmqcT_yabMDY+dZoBAUA28f6tkPe0uH+xtRUS51gvv4p2vuQ@mail.gmail.com>
 <5a02e30d-cb46-a2ab-554f-b8ef4807bd97@gmail.com>
 <CAHhmqcQw69S3Fn=Nej7MezCOZ3_ZNi64p+PFLSV+b91e1gTjZA@mail.gmail.com>
In-Reply-To: <CAHhmqcQw69S3Fn=Nej7MezCOZ3_ZNi64p+PFLSV+b91e1gTjZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c094:180::1:589a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d3bf3d6-0083-49b6-0d1f-08d6d3326aab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1177;
x-ms-traffictypediagnostic: DM5PR15MB1177:
x-microsoft-antispam-prvs: <DM5PR15MB1177658DD176240614691672D3310@DM5PR15MB1177.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(66476007)(64756008)(66556008)(73956011)(66446008)(186003)(102836004)(6116002)(386003)(53546011)(6506007)(81166006)(8676002)(81156014)(76176011)(8936002)(86362001)(33656002)(316002)(52116002)(99286004)(54906003)(476003)(446003)(11346002)(66946007)(305945005)(2906002)(7736002)(6436002)(68736007)(36756003)(6512007)(83716004)(71190400001)(71200400001)(2616005)(486006)(5660300002)(82746002)(53936002)(478600001)(46003)(6916009)(6246003)(229853002)(14454004)(50226002)(25786009)(256004)(6486002)(4326008)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1177;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0I14ExgcMw9MR5KNfpekf81uTfm4yx+QdvHYI/y0guqkLZKmpFn7F1PmbFZgdXmUMA+ugovIJHZnNcuSnKoEuMpYl21XxeC8ppbubLqaTenH2YzrhkGFjAUe28XzxCFrE+4YvqdvcpDFO1rE2CLGZtptWt4Xxu8RlOAy17mpgAl1sohtMmPy2b99g5ebNY0ylHL0uWHu76BXR+s85kwWYWwwUhtWY2YeTDip2iiPluewwmwuBVH/I/91yLfIvFTkXLnnatAFX6khH0O/kFlEIGqQRwj5Hf/2le6nKeEp1FVaqkBD1FBtoeed2TZhUV8cc9O5sxov1aK/mWYi8JWkkyYF+giE80pgUzJk9Z68nfvXRAlv4kTZJ/+ovULLwIQRZ79CSZypBvW358II5JLivbOJ/9wYZp0+C5RP/K09/3Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3bf3d6-0083-49b6-0d1f-08d6d3326aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 21:24:41.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1177
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNyBNYXkgMjAxOSwgYXQgMTY6MDksIEJyeWFuIEd1cm5leSB3cm90ZToNCg0KPiBJIGZvdW5k
IGFuIGV4YW1wbGUgaW4gbXkgdHJhY2Ugb2YgdGhlICJ0d28gYmFuZHMgb2YgbGF0ZW5jeSIgYmVo
YXZpb3IuDQo+IENvbnNpZGVyIHRoZXNlIHRocmVlIHNlZ21lbnRzIG9mIHRyYWNlIGRhdGEgZHVy
aW5nIHRoZSB3cml0ZXM6DQo+DQoNClsgLi4uIF0NCg0KPiBUaGVyZSdzIGFuIGF2ZXJhZ2UgbGF0
ZW5jeSBvZiAxNCBtaWxsaXNlY29uZHMgZm9yIHRoZXNlIDEyOCBraWxvYnl0ZQ0KPiB3cml0ZXMu
ICBBdCAwLjIxODI4ODc5NCBzZWNvbmRzLCB3ZSBjYW4gc2VlIGEgc3VkZGVuIGFwcGVhcmFuY2Ug
b2YgMS43DQo+IG1pbGxpc2Vjb25kIGxhdGVuY3kgdGltZXMsIG11Y2ggbG93ZXIgdGhhbiB0aGUg
YXZlcmFnZS4NCj4NCj4gVGhlbiB3ZSBzZWUgYW4gYWx0ZXJuYXRpb24gb2YgMS43IG1pbGxpc2Vj
b25kIGNvbXBsZXRpb25zIGFuZCAxNA0KPiBtaWxsaXNlY29uZCBjb21wbGV0aW9ucywgd2l0aCB0
aGVzZSB0d28gImxhdGVuY3kgZ3JvdXBzIiBpbmNyZWFzaW5nLA0KPiB1cCB0byBhYm91dCAxNCBt
aWxsaXNlY29uZHMgYW5kIDI1IG1pbGxpc2Vjb25kcyBhdCAwLjI0MTI4NzE4NyBzZWNvbmRzDQo+
IGludG8gdGhlIHRyYWNlLg0KPg0KPiBBdCAwLjMxNzM1MTg4OCBzZWNvbmRzLCB3ZSBzZWUgdGhl
IHBhdHRlcm4gc3RhcnQgYWdhaW4sIHdpdGggYSBzdWRkZW4NCj4gYXBwZWFyYW5jZSBvZiAxLjg5
IG1pbGxpc2Vjb25kIGxhdGVuY3kgd3JpdGUgY29tcGxldGlvbnMsIGFtb25nIDE0LjcNCj4gbWls
bGlzZWNvbmQgbGF0ZW5jeSB3cml0ZSBjb21wbGV0aW9ucy4NCj4NCj4gSWYgeW91IGdyYXBoIGl0
LCBpdCBsb29rcyBsaWtlIGEgInRyaWFuZ2xlIHdhdmUiIHB1bHNlLCB3aXRoIGENCj4gZHVyYXRp
b24gb2YgYWJvdXQgMjMgbWlsbGlzZWNvbmRzLCB0aGF0IHJlcGVhdHMgYWZ0ZXIgYWJvdXQgMTAw
DQo+IG1pbGxpc2Vjb25kcy4gIEluIGEgd2F5LCBpdCdzIGxpa2UgYSAiaGVhcnRiZWF0Ii4gIFRo
aXMgd291bGRuJ3QgYmUgYXMNCj4gZWFzeSB0byBkZXRlY3Qgd2l0aCBhIHNpbXBsZSAiYXZlcmFn
ZSIgb3IgInBlcmNlbnRpbGUiIHJlYWRpbmcuDQo+DQo+IFRoaXMgd2FzIGR1cmluZyBhIHNpbXBs
ZSBzZXF1ZW50aWFsIHdyaXRlIGF0IGEgcXVldWUgZGVwdGggb2YgMzIsIGJ1dA0KPiB3aGF0IGhh
cHBlbnMgd2l0aCBhIHdyaXRlIGFmdGVyIGEgZGlzY2FyZCBpbiB0aGUgc2FtZSByZWdpb24gb2YN
Cj4gc2VjdG9ycz8gIFRoaXMgYmVoYXZpb3IgY291bGQgY2hhbmdlLCBkZXBlbmRpbmcgb24gZGlm
ZmVyZW50IGRyaXZlDQo+IG1vZGVscywgYW5kL29yIGRyaXZlIGNvbnRyb2xsZXIgYWxnb3JpdGht
cy4NCj4NCg0KSSB0aGluayB0aGVzZSBhcmUgYWxsIHJlYWxseSBpbnRlcmVzdGluZywgYW5kIGRl
ZmluaXRlbHkgc3VwcG9ydCB0aGUgDQppZGVhIG9mIGEgc2VyaWVzIG9mIHRlc3RzIHdlIGRvIHRv
IG1ha2Ugc3VyZSBhIGRyaXZlIGltcGxlbWVudHMgZGlzY2FyZCANCmluIHRoZSBnZW5lcmFsIHdh
eXMgdGhhdCB3ZSBleHBlY3QuDQoNCkJ1dCB3aXRoIHRoYXQgc2FpZCwgSSB0aGluayBhIG1vcmUg
aW1wb3J0YW50IGRpc2N1c3Npb24gYXMgZmlsZXN5c3RlbSANCmRldmVsb3BlcnMgaXMgaG93IHdl
IHByb3RlY3QgdGhlIHJlc3Qgb2YgdGhlIGZpbGVzeXN0ZW0gZnJvbSBoaWdoIA0KbGF0ZW5jaWVz
IGNhdXNlZCBieSBkaXNjYXJkcy4gIEZvciByZWFkcyBhbmQgd3JpdGVzLCB3ZSd2ZSBiZWVuIGRv
aW5nIA0KdGhpcyBmb3IgYSBsb25nIHRpbWUuICBJTyBzY2hlZHVsZXJzIGhhdmUgYWxsIGtpbmRz
IG9mIGNoZWNrcyBhbmQgDQpiYWxhbmNlcyBmb3IgUkVRX01FVEEgb3IgUkVRX1NZTkMsIGFuZCB3
ZSB0aHJvdHRsZSBkaXJ0eSBwYWdlcyBhbmQgDQpyZWFkYWhlYWQgYW5kIGRhbmNlIGFyb3VuZCBy
ZXF1ZXN0IGJhdGNoaW5nIGV0YyBldGMuDQoNCkJ1dCBmb3IgZGlzY2FyZHMsIHdlIGp1c3Qgb3Bl
biB0aGUgZmxvb2RnYXRlcyBhbmQgaG9wZSBpdCB3b3JrcyBvdXQuICBBdCANCnNvbWUgcG9pbnQg
d2UncmUgZ29pbmcgdG8gaGF2ZSB0byBmaWd1cmUgb3V0IGhvdyB0byBxdWV1ZSBhbmQgdGhyb3R0
bGUgDQpkaXNjYXJkcyBhcyB3ZWxsIGFzIHdlIGRvIHJlYWRzL3dyaXRlcy4gIFRoYXQncyBraW5k
IG9mIHRyaWNreSBiZWNhdXNlIA0KdGhlIEZTIG5lZWRzIHRvIGNvb3JkaW5hdGUgd2hlbiB3ZSdy
ZSBhbGxvd2VkIHRvIGRpc2NhcmQgc29tZXRoaW5nIGFuZCANCm5lZWRzIHRvIGtub3cgd2hlbiB0
aGUgZGlzY2FyZCBpcyBkb25lLCBhbmQgd2UgYWxsIGhhdmUgZGlmZmVyZW50IA0Kc2NoZW1lcyBm
b3Iga2VlcGluZyB0cmFjay4NCg0KLWNocmlzDQo=
