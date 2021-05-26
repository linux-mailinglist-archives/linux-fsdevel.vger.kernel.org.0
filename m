Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D830390D43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 02:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhEZA0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 20:26:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58840 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhEZA0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 20:26:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q0Etl0018391;
        Tue, 25 May 2021 17:24:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=O5LG+s8GOPeGyuy0MRw9wJ1jDKnNGx+bw0RD+ZN26KU=;
 b=W9cv9A4+IV7lR3sujYqCsuXVlNuioqIpB6oa0RakxAmOOsyIE1YYl43WYvzRhZIDkQyp
 5SlzjOdIBO0geiPo0anGKO+oe4mAS6VnsU+OVoQYpxczWEI4rNCMdReHG9LxmVczywCO
 xn+wlpWdEmFJIgXDaNSlIDk6ZCpHEUudEE4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38rh3ss5wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 17:24:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY/PuxnORNIH3VGmRGFMHr5/geOlVLBaOfz/PMcP1g6naUnhjk165RuPUagcdwglDdI7tIgojjH9N95GdYTO7olRNmWtFkLvGAtlvwiD2kQPAwVTfAh6xQ5+V6f2CEPy5MAIKBvNmgsfBDTkFrPf6hBZNQG8VtnlR1h+iiBZV9XtjjeqbtsV3oZLX9mhkdGLZaN1I5fvM8uf6sqkA28yD0P/KajgK5pnB/KbHmmBRiJeXnhQ5CdrQpIob6UhQ5lF4li+7RUPGZNfA7yzi7P5tj9LDdYIpVo16S5EiQe+jVj0qiVQDLMOLqaGNbteGQIcnenJThzFMB7ZQ0jH3F0LmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5LG+s8GOPeGyuy0MRw9wJ1jDKnNGx+bw0RD+ZN26KU=;
 b=QbtJyJKS8h4moUsdBTCOJ2BIi1+x0jVV84K0kNH9t71a+d0cex55pN71SoQc04O49IKGY9IWETc0GJsKB+lfLifseTm3Mzx1HPCmz2l4CU4xQjBwnk3cvI1XOAW+Rcw0Wg5NFHnfuizr7M9NtUODXm2QsOxYHRUqwlut5lzPIszfZss0kMhnheuzSd8cJl+UuWV6qTCQo05sHO/pF6goPIA+X0J4KEGt/oowKeWD0H8gyyL19A1EOi+i5OFUiqwhYdrDtivDwLLL0ye7YLlja3UoLPX4Wbrgis9oYlsQ5GHgpErsEv6+l1WT7b555NN5GX1c3uIluS4VvCUfl1577w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4359.namprd15.prod.outlook.com (2603:10b6:a03:358::15)
 by BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 00:24:56 +0000
Received: from SJ0PR15MB4359.namprd15.prod.outlook.com
 ([fe80::1836:351b:ea83:df75]) by SJ0PR15MB4359.namprd15.prod.outlook.com
 ([fe80::1836:351b:ea83:df75%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 00:24:56 +0000
From:   Chris Mason <clm@fb.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Josh Triplett <josh@joshtriplett.org>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Thread-Topic: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Thread-Index: AQHXSy5S9wK3qRYDs0OeBucANXpnfartabQAgAMvKACABCaAAIAANWGA
Date:   Wed, 26 May 2021 00:24:56 +0000
Message-ID: <5D04989A-E253-47B5-B50A-E96419F0E151@fb.com>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca> <YKntRtEUoxTEFBOM@localhost>
 <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
In-Reply-To: <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: dilger.ca; dkim=none (message not signed)
 header.d=none;dilger.ca; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:c291]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efe623f6-5038-4c53-b0bb-08d91fdcb071
x-ms-traffictypediagnostic: BY5PR15MB3651:
x-microsoft-antispam-prvs: <BY5PR15MB3651F1B5B1BC769A817B3FAED3249@BY5PR15MB3651.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hGgclooLRGPvPTpyr87nGtERQEc9dFiF1TzZjQJTTqJL8iQHQhJABdeyNFtyYy7AHd/iPMSErID9xrlhrBRG60Il4zIQ7yfOPBzwX3jDbVoOaisZiL+HVXjgFr+Gn3xmZIHfuKnItEX+q9IV0f9wMTl+osQMohDK7Rtj8Pw8uBr4jy0IWBNeAKO2bhiyCnfWXbVA1OK9U+/gienixgZ0+3h+BpPFrULDDtsRq4bpSAwn7KTT0uCxPTxCTJLS00j2sDeeCeuSrHJwmetiIF8UF7otFXkZMfG0a0MHQlCBYeK1eL1XzKLyQhoChR5j+uPQLYsAW4c3JLNkkUk3WG8vLkJNCX5RT1rSS1yZsqd8f/Pvp3l8QbOJMUzhNPKW96fT7jb6lgEqK4THOZRVA9VE9unLFb7dBYeBOw4/jVRI/cBL2pQRmGTlpB/XyN/wuvCgSE3qwEA3Pb+4chadGG3/y2NnyMCMD30IcDmkdF5nyaZNizqeNqTG/+4lzyjC5lKZ/RY5KsRGvLUOXZ1FxBzUNtuAGRq7Ok+z54hXNvAUlnc80ZXmQtp4oQOPXvBfyMrLrIsv0R1JFXpYwEJkYiq5h9Aya8f/CqAzD8F/N5OJpFfCH4oiO9b++MfhtTBHFS7crdeSx66wcfg81Fwq/Uk5IxB8nRDS6yofYFchLyqeV/hFJvJKoW390d5LrpDNYFnc0j/Dq7Rhr7d185INZQrjb0zgdloePCuJnMZDlt0kQGvOuvCjx64sO9I78UtGaPF4MdtHwpqvFUjEDY4MAaGJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4359.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(8676002)(2616005)(4326008)(76116006)(6916009)(122000001)(53546011)(6512007)(86362001)(6506007)(83380400001)(38100700002)(54906003)(8936002)(36756003)(91956017)(71200400001)(478600001)(6486002)(66946007)(64756008)(66556008)(2906002)(316002)(66476007)(186003)(5660300002)(7416002)(966005)(66446008)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWRvQXljclk4U1FuUVJOTXdKQ0V2SDdHYkZ6OGZBem1XeStHdWgzdXVkYTBa?=
 =?utf-8?B?SFJnM1pPV0IxVEtJQ3VQOG84RE83ZkNhTUUyb1JjalpidlRKME80MmIzeStR?=
 =?utf-8?B?bzgrQ3dRc3pZZGJ5Z1NYMWR1RUp0ZXltZERlU01INS9vNTNKQlI4Rks2ZTFC?=
 =?utf-8?B?WWp1YUVoS2pjQXNURURhYmNiY1VBVTA0QlVtWmdyN3JzNkt6aVBmb1BvcUc5?=
 =?utf-8?B?ZjhuRVBwZnVkT1N4WDEwMDR2SjBWZTVBeThDTnhTcXVMeWljZ0RScEZ1bWJ3?=
 =?utf-8?B?YXlaV05NSjI5eWZ6T3F3Um5PZzNlT1BNa0pwa0ZnNmNieVc5bThRS1VnQVpV?=
 =?utf-8?B?OFFiTWI5dWJrbFpmZjJteE5oSG9QZDVFT01rMUU2c0w0NW9wLzNlRUEvdzZh?=
 =?utf-8?B?NUFJN2F5QkNtUkRCc2RzYTR3elo3TjAzR2ZvSkdYTHlEYkk2R0loN0RmVmdr?=
 =?utf-8?B?REh6TzJMcktEQjJBd0ZiQjRacjJqOXNCTlA4WWE2eU1QWEhoT3J1MW9IRHA3?=
 =?utf-8?B?d0dGcGxsdkVWMVVLdVRFeU9DZXR0YStMQ1NUaEdSc2xiTm9KU2lrejZrMFVO?=
 =?utf-8?B?SnBrbW5OVHRraE9EeDQ4WXhwZkkzaHhObkVkUWRvK1BJSW85MG5JMlRXM0RB?=
 =?utf-8?B?SGpFQjl3MjNoWTNmc1VwRzh2bVRXaHJFNDI2S1liL1F2N1p5WDAvYk4vMldz?=
 =?utf-8?B?aThveTZkZ1l4dTh2N0FDRzM1bERGMTR2ZEE1OUpqdTlyekhZb3hQZ3RrU0FB?=
 =?utf-8?B?Q0JuQUl6bkpDa295Mlhvb1h6NkNpbWE5TUhlYURqc1E0Z1Job01KcmFpUVEx?=
 =?utf-8?B?ZXByaVpZSTdqQzNFMmVqeW1pcnJ5cVl6U3EyelExVmM1UUI4MVJUZ3hUWWlx?=
 =?utf-8?B?a3llT2RLUlJOaUo1bHdCaWl5L2dZVXpOaElDaUdiUWl3c0tuV3R4OFU4VmU5?=
 =?utf-8?B?NGkxeVczOWxsN0JlaFRqc2ZEdGg4bUZLNkhVdVNYcUd6emdmN2ttV3lPWUFn?=
 =?utf-8?B?clVGR21ORWdsa0ZoZHRSa01LK2NqWXFJTzM2dGpYaCtFLzkwei9oWWdUd21S?=
 =?utf-8?B?VzVkTmlac1hpZjFlRFMzQkdJckZkOEVUNW0yZWR6NFhyUVEvOUpyQk4wOVZj?=
 =?utf-8?B?QTdaU3FKdWZLTTJyUHhvbnNTeUVERk5JenlmWE1uQXhYZy9iWTBVd2F4L2dw?=
 =?utf-8?B?Q0s4cUtxR3pNVlpKazdoa1kwdldSTUtNeTBvcW1ITW1lMDM5TkJSQmZsOE5j?=
 =?utf-8?B?cTNzOStucExXZFV5RzFpYUxwWUZWZitqVE1RWHJSZ1BQbWhCN0czUEpqWTcx?=
 =?utf-8?B?N2JZM1FTSDBGbXg2dk9YUVQySnVJaFAxZzdGTDExWG91OG80MjBsUzdhNm1U?=
 =?utf-8?B?bC9yc1hBRDljNVpQMkh6Y0tSK1puTDcxTHB3Tm9FOXlLWTdYclJjZzVheWNN?=
 =?utf-8?B?c3VmaWtpQ1ExaDZOTWNRbHk2eG9BR0hEM1pQaHc0UDk3NXdhbGM5K0V2cWxO?=
 =?utf-8?B?SlN6UDZOMWJIOXVUZHZPdDBXcWNLM0J5dkRoUy9MSzEySmNiSk1yTm4xbnMz?=
 =?utf-8?B?Qk41V2t4eEMyWG1JY25mMFU3aGtkQUIwckhuOC9ucUZ1TWplaTVXcXlPSXcx?=
 =?utf-8?B?SkVEdzNZMndCWlpiRnRGVktjZE00c1NpMDFQVlZaZUM4T3pYSkRQUkVEUFIz?=
 =?utf-8?B?citrY1g5dGY3cW0wMHlMdk4vckZwU0tuZnhsd0FvNitrZ2ZmRis1SnR3VmNG?=
 =?utf-8?B?Tk1vb055U1gwaGw5NjJFR3ZEbk1QWDJhMnN3Rlp6SU1OdTNQL2FqdHU2UHZm?=
 =?utf-8?Q?sA6SH82QlB2THk+x6E6O+8WXOqpT5WAu0YCrw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <64DD6B250E69824292823F92CE0A6B7C@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4359.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe623f6-5038-4c53-b0bb-08d91fdcb071
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 00:24:56.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /V2/Rc3aiT010Yby6v9B1qe/AlRBH27H4FjLtCYmEZynOoWJPrmVkc07NynfZxfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3651
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: us4V7As8E9WJ3ioIQ2sV-d-TpTqbIaKt
X-Proofpoint-ORIG-GUID: us4V7As8E9WJ3ioIQ2sV-d-TpTqbIaKt
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_09:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE1heSAyNSwgMjAyMSwgYXQgNToxMyBQTSwgQW5kcmVhcyBEaWxnZXIgPGFkaWxnZXJA
ZGlsZ2VyLmNhPiB3cm90ZToNCj4gDQo+IE9uIE1heSAyMiwgMjAyMSwgYXQgMTE6NTEgUE0sIEpv
c2ggVHJpcGxldHQgPGpvc2hAam9zaHRyaXBsZXR0Lm9yZz4gd3JvdGU6DQo+PiANCj4+IE9uIFRo
dSwgTWF5IDIwLCAyMDIxIGF0IDExOjEzOjI4UE0gLTA2MDAsIEFuZHJlYXMgRGlsZ2VyIHdyb3Rl
Og0KPj4+IE9uIE1heSAxNywgMjAyMSwgYXQgOTowNiBBTSwgRGF2aWQgSG93ZWxscyA8ZGhvd2Vs
bHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+IFdpdGggZmlsZXN5c3RlbXMgbGlrZSBleHQ0LCB4
ZnMgYW5kIGJ0cmZzLCB3aGF0IGFyZSB0aGUgbGltaXRzIG9uIGRpcmVjdG9yeQ0KPj4+PiBjYXBh
Y2l0eSwgYW5kIGhvdyB3ZWxsIGFyZSB0aGV5IGluZGV4ZWQ/DQo+Pj4+IA0KPj4+PiBUaGUgcmVh
c29uIEkgYXNrIGlzIHRoYXQgaW5zaWRlIG9mIGNhY2hlZmlsZXMsIEkgaW5zZXJ0IGZhbm91dCBk
aXJlY3Rvcmllcw0KPj4+PiBpbnNpZGUgaW5kZXggZGlyZWN0b3JpZXMgdG8gZGl2aWRlIHVwIHRo
ZSBzcGFjZSBmb3IgZXh0MiB0byBjb3BlIHdpdGggdGhlDQo+Pj4+IGxpbWl0cyBvbiBkaXJlY3Rv
cnkgc2l6ZXMgYW5kIHRoYXQgaXQgZGlkIGxpbmVhciBzZWFyY2hlcyAoSUlSQykuDQo+Pj4+IA0K
Pj4+PiBGb3Igc29tZSBhcHBsaWNhdGlvbnMsIEkgbmVlZCB0byBiZSBhYmxlIHRvIGNhY2hlIG92
ZXIgMU0gZW50cmllcyAocmVuZGVyDQo+Pj4+IGZhcm0pIGFuZCBldmVuIGEga2VybmVsIHRyZWUg
aGFzIG92ZXIgMTAway4NCj4+Pj4gDQo+Pj4+IFdoYXQgSSdkIGxpa2UgdG8gZG8gaXMgcmVtb3Zl
IHRoZSBmYW5vdXQgZGlyZWN0b3JpZXMsIHNvIHRoYXQgZm9yIGVhY2ggbG9naWNhbA0KPj4+PiAi
dm9sdW1lIlsqXSBJIGhhdmUgYSBzaW5nbGUgZGlyZWN0b3J5IHdpdGggYWxsIHRoZSBmaWxlcyBp
biBpdC4gIEJ1dCB0aGF0DQo+Pj4+IG1lYW5zIHN0aWNraW5nIG1hc3NpdmUgYW1vdW50cyBvZiBl
bnRyaWVzIGludG8gYSBzaW5nbGUgZGlyZWN0b3J5IGFuZCBob3BpbmcNCj4+Pj4gaXQgKGEpIGlz
bid0IHRvbyBzbG93IGFuZCAoYikgZG9lc24ndCBoaXQgdGhlIGNhcGFjaXR5IGxpbWl0Lg0KPj4+
IA0KPj4+IEV4dDQgY2FuIGNvbWZvcnRhYmx5IGhhbmRsZSB+MTJNIGVudHJpZXMgaW4gYSBzaW5n
bGUgZGlyZWN0b3J5LCBpZiB0aGUNCj4+PiBmaWxlbmFtZXMgYXJlIG5vdCB0b28gbG9uZyAoZS5n
LiAzMiBieXRlcyBvciBzbykuICBXaXRoIHRoZSAibGFyZ2VfZGlyIg0KPj4+IGZlYXR1cmUgKHNp
bmNlIDQuMTMsIGJ1dCBub3QgZW5hYmxlZCBieSBkZWZhdWx0KSBhIHNpbmdsZSBkaXJlY3Rvcnkg
Y2FuDQo+Pj4gaG9sZCBhcm91bmQgNEIgZW50cmllcywgYmFzaWNhbGx5IGFsbCB0aGUgaW5vZGVz
IG9mIGEgZmlsZXN5c3RlbS4NCj4+IA0KPj4gZXh0NCBkZWZpbml0ZWx5IHNlZW1zIHRvIGJlIGFi
bGUgdG8gaGFuZGxlIGl0LiBJJ3ZlIHNlZW4gYm90dGxlbmVja3MgaW4NCj4+IG90aGVyIHBhcnRz
IG9mIHRoZSBzdG9yYWdlIHN0YWNrLCB0aG91Z2guDQo+PiANCj4+IFdpdGggYSBub3JtYWwgTlZN
ZSBkcml2ZSwgYSBkbS1jcnlwdCB2b2x1bWUgY29udGFpbmluZyBleHQ0LCBhbmQgZGlzY2FyZA0K
Pj4gZW5hYmxlZCAob24gYm90aCBleHQ0IGFuZCBkbS1jcnlwdCksIEkndmUgc2VlbiBybSAtciBv
ZiBhIGRpcmVjdG9yeSB3aXRoDQo+PiBhIGZldyBtaWxsaW9uIGVudHJpZXMgKGVhY2ggcG9pbnRp
bmcgdG8gYSB+NC04ayBmaWxlKSB0YWtlIHRoZSBiZXR0ZXINCj4+IHBhcnQgb2YgYW4gaG91ciwg
YWxtb3N0IGFsbCBvZiBpdCBzeXN0ZW0gdGltZSBpbiBpb3dhaXQuIEFsc28gbWFrZXMgYW55DQo+
PiBvdGhlciBjb25jdXJyZW50IGRpc2sgd3JpdGVzIGhhbmcsIGV2ZW4gYSBzaW1wbGUgInRvdWNo
IHgiLiBUdXJuaW5nIG9mZg0KPj4gZGlzY2FyZCBzcGVlZHMgaXQgdXAgYnkgc2V2ZXJhbCBvcmRl
cnMgb2YgbWFnbml0dWRlLg0KPj4gDQo+PiAoSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgYSBrbm93
biBpc3N1ZSBvciBub3QsIHNvIGhlcmUgYXJlIHRoZSBkZXRhaWxzDQo+PiBqdXN0IGluIGNhc2Ug
aXQgaXNuJ3QuIEFsc28sIGlmIHRoaXMgaXMgYWxyZWFkeSBmaXhlZCBpbiBhIG5ld2VyIGtlcm5l
bCwNCj4+IG15IGFwb2xvZ2llcyBmb3IgdGhlIG91dGRhdGVkIHJlcG9ydC4pDQo+IA0KPiBEZWZp
bml0ZWx5ICItbyBkaXNjYXJkIiBpcyBrbm93biB0byBoYXZlIGEgbWVhc3VyYWJsZSBwZXJmb3Jt
YW5jZSBpbXBhY3QsDQo+IHNpbXBseSBiZWNhdXNlIGl0IGVuZHMgdXAgc2VuZGluZyBhIGxvdCBt
b3JlIHJlcXVlc3RzIHRvIHRoZSBibG9jayBkZXZpY2UsDQo+IGFuZCB0aG9zZSByZXF1ZXN0cyBj
YW4gYmUgc2xvdy9ibG9jayB0aGUgcXVldWUsIGRlcGVuZGluZyBvbiB1bmRlcmx5aW5nDQo+IHN0
b3JhZ2UgYmVoYXZpb3IuDQo+IA0KPiBUaGVyZSB3YXMgYSBwYXRjaCBwdXNoZWQgcmVjZW50bHkg
dGhhdCB0YXJnZXRzICItbyBkaXNjYXJkIiBwZXJmb3JtYW5jZToNCj4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LWV4dDQvbGlzdC8/c2VyaWVzPTI0NDA5MQ0KPiB0
aGF0IG5lZWRzIGEgYml0IG1vcmUgd29yaywgYnV0IG1heSBiZSB3b3J0aHdoaWxlIHRvIHRlc3Qg
aWYgaXQgaW1wcm92ZXMNCj4geW91ciB3b3JrbG9hZCwgYW5kIGhlbHAgcHV0IHNvbWUgd2VpZ2h0
IGJlaGluZCBsYW5kaW5nIGl0Pw0KPiANCg0KVGhpcyBpcyBwcmV0dHkgZmFyIG9mZiB0b3BpYyBm
cm9tIHRoZSBvcmlnaW5hbCBtZXNzYWdlLCBidXQgd2XigJl2ZSBoYWQgYSBsb25nIGxpc3Qgb2Yg
ZGlzY2FyZCBwcm9ibGVtcyBpbiBwcm9kdWN0aW9uOg0KDQoqIFN5bmNocm9ub3VzIGRpc2NhcmRz
IHN0YWxsIHVuZGVyIGhlYXZ5IGRlbGV0ZSBsb2FkcywgZXNwZWNpYWxseSBvbiBsb3dlciBlbmQg
ZHJpdmVzLiAgRXZlbiBkcml2ZXMgdGhhdCBzZXJ2aWNlIHRoZSBkaXNjYXJkcyBlbnRpcmVseSBp
biByYW0gb24gdGhlIGhvc3QgKGZ1c2lvbi1pb+KAmXMgYmVzdCBmZWF0dXJlIGltaG8pIGhhZCB0
cm91YmxlLiAgSeKAmW0gc3VyZSBzb21lIHJlYWxseSBoaWdoIGVuZCBmbGFzaCBpcyByZWFsbHkg
aGlnaCBlbmQsIGJ1dCBpdCBoYXNu4oCZdCBiZWVuIGEgZHJpdmluZyBjcml0ZXJpYSBmb3IgdXMg
aW4gdGhlIGZsZWV0Lg0KDQoqIFhGUyBhc3luYyBkaXNjYXJkcyBkZWNvdXBsZSB0aGUgY29tbWl0
IGxhdGVuY3kgZnJvbSB0aGUgZGlzY2FyZCBsYXRlbmN5LCB3aGljaCBpcyBncmVhdC4gIEJ1dCB0
aGUgYmFja2xvZyBvZiBkaXNjYXJkcyB3YXNu4oCZdCByZWFsbHkgbGltaXRlZCwgc28gbWFzcyBk
ZWxldGlvbiBldmVudHMgZW5kZWQgdXAgZ2VuZXJhdGluZyBzdGFsbHMgZm9yIHJlYWRzIGFuZCB3
cml0ZXMgdGhhdCB3ZXJlIGNvbXBldGluZyB3aXRoIHRoZSBkaXNjYXJkcy4gIFdlIGxhc3QgYmVu
Y2htYXJrZWQgdGhpcyB3aXRoIHY1LjIsIHNvIGl0IG1pZ2h0IGJlIGRpZmZlcmVudCBub3csIGJ1
dCB1bmZvcnR1bmF0ZWx5IGl0IHdhc27igJl0IHVzYWJsZSBmb3IgdXMuDQoNCiogZnN0cmltLWZy
b20tY3JvbiBsaW1pdHMgdGhlIHN0YWxscyB0byAyYW0sIHdoaWNoIGlzIHBlYWsgc29tZXdoZXJl
IGluIHRoZSB3b3JsZCwgc28gaXQgaXNuJ3QgaWRlYWwuICBPbiBzb21lIGRyaXZlcyBpdHMgZmlu
ZSwgb24gb3RoZXJzIGl04oCZcyBhIDEwIG1pbnV0ZSBsdW5jaCBicmVhay4NCg0KRm9yIFhGUyBp
biBsYXRlbmN5IHNlbnNpdGl2ZSB3b3JrbG9hZHMsIHdl4oCZdmUgc2V0dGxlZCBvbiBzeW5jaHJv
bm91cyBkaXNjYXJkcyBhbmQgYXBwbGljYXRpb25zIHVzaW5nIGl0ZXJhdGluZyB0cnVuY2F0ZSBj
YWxscyB0aGF0IG5pYmJsZSB0aGUgZW5kcyBvZmYgb2YgYSBmaWxlIGJpdCBieSBiaXQgd2hpbGUg
Y2FsbGluZyBmc3luYyBpbiByZWFzb25hYmxlIGludGVydmFscy4gIEl0IGh1cnRzIHRvIHNheSBv
dXQgbG91ZCBidXQgaXMgYWxzbyB3b25kZXJmdWxseSBwcmVkaWN0YWJsZS4NCg0KV2UgZ2VuZXJh
bGx5IHVzZSBidHJmcyBvbiBsb3cgZW5kIHJvb3QgZHJpdmVzLCB3aGVyZSBkaXNjYXJkcyBhcmUg
YSBtdWNoIGJpZ2dlciBwcm9ibGVtLiAgVGhlIGJ0cmZzIGFzeW5jIGRpc2NhcmQgaW1wbGVtZW50
YXRpb24gY29uc2lkZXJzIHJlLWFsbG9jYXRpbmcgdGhlIGJsb2NrIHRoZSBzYW1lIGFzIGRpc2Nh
cmRpbmcgaXQsIHNvIHdlIGF2b2lkIHNvbWUgZGlzY2FyZHMganVzdCBieSByZXVzaW5nIGJsb2Nr
cy4gIEl0IHNvcnRzIHBlbmRpbmcgZGlzY2FyZHMgdG8gcHJlZmVyIGxhcmdlciBJT3MsIGFuZCBk
cmliYmxlcyB0aGVtIG91dCBzbG93bHkgdG8gYXZvaWQgc2F0dXJhdGluZyB0aGUgZHJpdmUuICBJ
dOKAmXMgYSBnaWFudCBiYWcgb2YgY29tcHJvbWlzZXMgYnV0IGF2b2lkcyBsYXRlbmNpZXMgYW5k
IG1haW50YWlucyB0aGUgd3JpdGUgYW1wbGlmaWNhdGlvbiB0YXJnZXRzLiAgV2UgZG8gdXNlIGl0
IG9uIGEgZmV3IGRhdGEgaW50ZW5zaXZlIHdvcmtsb2FkcyB3aXRoIGhpZ2hlciBlbmQgZmxhc2gs
IGJ1dCB3ZSBjcmFuayB1cCB0aGUgaW9wcyB0YXJnZXRzIGZvciB0aGUgZGlzY2FyZHMgdGhlcmUu
DQoNCi1jaHJpcw==
