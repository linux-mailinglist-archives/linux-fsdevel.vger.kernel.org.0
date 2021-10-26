Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489643BA6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhJZTOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 15:14:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235753AbhJZTOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:14:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QFXFue025846
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 12:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SJD6cKOueuUKfrym0Pm5Fr8iZXjKII2jSXwyHaHYSzI=;
 b=ViQJFRZ9XOCjxp1XRJO3+C+rc7NUFEmgtL3kCWHO/7kValUOSOu8Od6/cRx3a9TiAz3X
 7MpH4v5ZbWT5R3k9OiEDmWJKD0Ltf4JarMWxHIBVAbrzvwP5iXaTXxJvpUxXgn3QwfoV
 B5D2KtiBCgGsBXou1/+GDVNJy2sQYh2Q+IY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7qpp4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 12:11:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 12:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix8SoXj0k8AQMjO8aEHBsL2wzvHG3XSmjIJ9KpCiyiQCnWkVtzWJZZHoujtpvhTOP17R7F2H/hwXQt7mreHjvm6PH1iGvcXPOonKm+LUuqSmDL0ocdEo0Ucmkt0VKBIz5Wozhnf3zH+z/AFgjgk4a6JaR6uNLQ9+7NAYRN2Rg0HX5VUhoHwWjqmTEu+q7Nk8mDKe0mIyMmvt6aCqXw7KM/4V8sk/4IaSllhbqcU+rOByoejsJIZipffoKkkFALrak8Yc/cIYjJMP1fnQvj8nJl9l1Mqs/yFHOoH5yzFQVKZHooaEPIB6/94FhsKGzqvljXkL8UlTAN06idmzpfBWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJD6cKOueuUKfrym0Pm5Fr8iZXjKII2jSXwyHaHYSzI=;
 b=njGW8hFkDOCP/SZqq0i3HQ74nriWyCgVu3tuh1TVt/1/1VLKuaCaMJiDcS6YMUYmv5OnQTJT8VHGwiaRIkK0cSpOxgxrbZFWj0V6ZijjXszSTws/O5drtexrTumuHYr6QGoD/aXhldqdfLHIdQ6gJSKg2JxnJrDmesjnpHRalBrVqs1P2toFeFPSjeO+MgUlM7MdQJ1PB3MgRZHEa7mVqjErEnu/7RvwA+WjaR1WSHel1YPUuJo9IIHE/KXZYkix6YniahTH+sztyB4nxTZdt6ZZa2Wo5Obssnc7dp3EZ03PfQLPbNFFpPkzyfZjGDTVlOnmso9J33ZC0ROQFyk2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4924.namprd15.prod.outlook.com (2603:10b6:303:e3::16)
 by MW4PR15MB4561.namprd15.prod.outlook.com (2603:10b6:303:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 19:11:34 +0000
Received: from CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::85f8:f448:b5cd:9171]) by CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::85f8:f448:b5cd:9171%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 19:11:34 +0000
From:   Chris Mason <clm@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: mm: don't read i_size of inode unless we need it
Thread-Topic: mm: don't read i_size of inode unless we need it
Thread-Index: AQHXypVqgjSWReeIZ0mojalRKs7B2qvlpWmA
Date:   Tue, 26 Oct 2021 19:11:34 +0000
Message-ID: <9383DBC8-0C0E-4EF7-A3E3-272FFA9F14D2@fb.com>
References: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
In-Reply-To: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beab54b5-0705-46ad-1597-08d998b46d41
x-ms-traffictypediagnostic: MW4PR15MB4561:
x-microsoft-antispam-prvs: <MW4PR15MB45616134C34A582E0848731DD3849@MW4PR15MB4561.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDnSSpQGD3R9iAs9BHRSb6w8HO6YS4c+Qe/S2pdQ2jodrnjnC/9z6hFLzDtwEe2RozvaPOBGT6vnRm1+QUDvtqZNNG/hoU/o25KO3nv+MNKqG5ZlZW1QoVpHse10LrRwCgToywx419jkRCy6aySEV6iprAQT7Pp3zaCU5BG3targmYfM2uh6bxEaw3QPesCi/VReRu6jXYq+lrpWhKFx4KDAer/pEkRdWKSRN3NF8rZLGwU/worZvEEZcMXfKb48JSVzb1WfqO0aOno8LvZxl9pn2KESuXShjt3LNXPn3f+6t35Mr5O1hS5CWYSvqdkJ+eHfxD5HJ1olgQ8ldxBgD9isTE72Go7NutpEaFkMmixGEv4dngKCygRRXKGrdcULy4u2sUdNsd+baX6E06aMSi49kOFufORYl59AlghJe6nmYzonx1V/+e67k/M2X+j+mYXM8aHu5T7nEwtvzqsa+RhUSyDAhsNU1ac4svJfm3yFDKYPHiKnI+DEx2ooywJXnpnLoRK9uzrg5LYgfV5kiGjR5KksRhszIgmHGkYCThtOgNHQfhgpzteqTbWZORF5IikY669qfPSNzjAva8CP4LG3B2F9UdOJO4NpEAWbBVhvxze8a9D6eKKzPQrNTseNNN1JTYCTBzK3CogUy8Veq1asnN11YlJkpBOhOBbkVH1zQeMlFeSr7WT/gTGUErAYiJcfNXBEfyDmMV7O2PJjFpthFNOra7XO2pJLmHMc4hfnwvwS9ezplBFJfKSTN2fv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4924.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(64756008)(66476007)(36756003)(66946007)(33656002)(316002)(6486002)(8676002)(122000001)(38070700005)(4326008)(6506007)(8936002)(38100700002)(66446008)(83380400001)(2616005)(2906002)(76116006)(71200400001)(54906003)(6916009)(5660300002)(53546011)(186003)(86362001)(508600001)(91956017)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVQxdjRpWHJUMjhoZEJqQkQ4MGo1eUtxY2xrVlJTYmFhSHZWcVNOVmZBeUc5?=
 =?utf-8?B?VlVmc21SaVFKNDlkeFBOOW54YkhFOUJtMVBxRnhSWWw5QXVFNGpMZEJadi91?=
 =?utf-8?B?ZmRNWVJuYTMvcDlsS0xPTk9hbXZta3BKTEpmSHFLYUtXRW9hMmxOMTlCT1lu?=
 =?utf-8?B?MDQwd3F5REdLcC9QZFZ0aUFrbEtyY3NLYThzV0l3TUlQcDdlZkhOdnRNZDl1?=
 =?utf-8?B?d1hsWlg1VHZSVnVRMUxqdlB0UStYU3NnOTFLdEFYaWxRUlJaT0xtU1JLcG9Q?=
 =?utf-8?B?andHcHZOTWRWdE5RTWNlQlRKamZ6STRKdndvTDBZZ2Rwd0JnRWpqOGVPM2FJ?=
 =?utf-8?B?cUFZM1JDZitaL3JDaGwvZEJZdzZic3RHYlk0QWYzU2FPVVYvR29MOVptem5R?=
 =?utf-8?B?T2dlRlEvbEVjbmFHWG52Yk1PSEY2VHJWdEJKRWlpN0Zmb2ZLRndBOE8vZHZw?=
 =?utf-8?B?NENWdEZvczJRN1RuYm11NDlNVEhQR25CQlFiY08yZEhuS29kWW1XQXZVcHBh?=
 =?utf-8?B?Vk5lR2lZUE9hcWpDUW51TUI5NisycUdXOEplVlpWdTRNN3FkMklIcFZ6dWx0?=
 =?utf-8?B?Vi80VGJ3RWduTTZma3lWdFdUejJybHpERlRtdVZyZHhOSm1LampBRmlmV01v?=
 =?utf-8?B?RVdpdWl2VmZ0c3ZseE5STVdjTVpyb01pQWhEbnNiaUVTb1FLL0c4K2lJVnhB?=
 =?utf-8?B?YUFJeDU0RXoyM0g0enV0Z29mRzQrVU1RRkdTaVYxRjlHRWNlYktiYzMzMnVX?=
 =?utf-8?B?Slh4VGh0djR6aTNNTC92TjFLM3kwWlZZOXRoZjA0ekxNd3QxKzUrdXVhUHhR?=
 =?utf-8?B?QUlGZU5sQ3c5TXNGWFVTRUtaK0hVcXpxTFo3UUYzRVV2a3pNc2M0QU5SSlVQ?=
 =?utf-8?B?R2pNY3pPZUFhaXUvSW9lWjVtSjNQTWxMNEtRN0FiTWNpaDJUVXlFa1cvdUNK?=
 =?utf-8?B?WmJ2YXVoRm05dUFlYmRrSDFiSG9sWFk1d3c2Q0JGVVhuMm1xNndvLzZEYUhE?=
 =?utf-8?B?SWEwODQ5VTBxWnJCTTZCZFVWLzJuQXRaK1l5d1kySWFZcHRmVVVERjcwUUZT?=
 =?utf-8?B?MXJBR2tLbEh6a0VxMThGSStTTk9NZ01aOGRIOXRlRXYycjNsVW01WjdQRVF2?=
 =?utf-8?B?cGJTS1JFc05TTGJGOEFXanhETVZ1ZG5oQmZZQVA0RUJ6MmdYYUcrNDkxczc1?=
 =?utf-8?B?YTVQVlBRRDlsY3dkTnJwZ0htc0ZiSlljcmtGclY4eXEzM2pHNnAvOW9oUlk3?=
 =?utf-8?B?KytSRFN4NHNXMXgyL0NDY2hBbGlwbnI2YzdsRGFDWDgzVU1wblYrVWFUajI4?=
 =?utf-8?B?b1B0NFJaUkpIbmRENTBrYjY2MEZpL3N6dzE5Z3ozdVRDZHhhTjVqL2Y2VjJs?=
 =?utf-8?B?amtvUWZwaXNkMmFyVVQzblN5NS9ibnJtdjlPUGhKOUVhdjdUOUI3dzJiOVRE?=
 =?utf-8?B?Zk1hVHR5a2V6VkR4RVNVYzg3YVN1YTV3ZDRzMXJnZDZKczZSNjFvS0NUeU9n?=
 =?utf-8?B?dGFTb01IV3FOeXk4UVZnM2IyU015MmJ1TGxVanJRbmV3eGEvempEQXh4N240?=
 =?utf-8?B?czVQakhVcnppNEFJdk5XbkY3cmpaYkY5QVVFbWhlbTJ3VFF6TUZud1JmL3g5?=
 =?utf-8?B?ZktmZHZmcDFhVG9ydXN4MUFuZFNQV3FBL2xmL2REY1REL0l2YmRiQ2dpY25a?=
 =?utf-8?B?VStibVk5QmpBUURrY012VDFIdm9KOFVLUFZpTWEvNWJoVTFKZmg5WEY0Mk92?=
 =?utf-8?B?VVhXUlpWb0J1aTIwSHV1MXhXbzdSZ3FxMGo2ZEw2NDR6TGxqYzgwby9VTWJY?=
 =?utf-8?B?TmQvdmo3dTFyU0tsZUdhNnRQaVZOWjZiQ3pBTG9QUUdMbjZpM212SzRYcHlx?=
 =?utf-8?B?SEN2a2ZZOTd0VWF0L1BRNU1tTmQxbWZiMjdsY2lzNytZV1AyVCs3RWUyZFFt?=
 =?utf-8?B?Sjk4eG9LZWRIa1JwbytnZ0VYeWRFY2FKMWNTeWhQTS9sWHlQT2djci93VHdt?=
 =?utf-8?B?d21KYW1WUFFoY3VzSjJWWmQvZlNnWUJDL0sxVlZyK2NTcnpKZ1ZkSTNyMDIx?=
 =?utf-8?B?cTZFN29mclQxdkNXNWx4RHNDL2tWWHhnb2tOcDdyRmxRL2Vnb0hiQXE2MUV0?=
 =?utf-8?B?eWxMUms0bUpxN1JPSGFLUjM1ZkFXcXpoSjkwZkt4TjErZEZZNzRWOGRxWkcz?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7B11D3400E024EBF3686A62A1B1A8F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4924.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beab54b5-0705-46ad-1597-08d998b46d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 19:11:34.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+Ba3u63cjXKgCi4vQlPt9lBw3WIwjyE9iln70SmcycLpmyktmT7AkZvCHfM1RJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4561
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LgX-d6RPb2er_VxkhtnkmibMhhcFLax_
X-Proofpoint-ORIG-GUID: LgX-d6RPb2er_VxkhtnkmibMhhcFLax_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE9jdCAyNiwgMjAyMSwgYXQgMjoxNSBQTSwgSmVucyBBeGJvZSA8YXhib2VAa2VybmVs
LmRrPiB3cm90ZToNCj4gDQo+IFdlIGFsd2F5cyBnbyB0aHJvdWdoIGlfc2l6ZV9yZWFkKCksIGFu
ZCB3ZSByYXJlbHkgZW5kIHVwIG5lZWRpbmcgaXQuIFB1c2gNCj4gdGhlIHJlYWQgdG8gZG93biB3
aGVyZSB3ZSBuZWVkIHRvIGNoZWNrIGl0LCB3aGljaCBhdm9pZHMgaXQgZm9yIG1vc3QNCj4gY2Fz
ZXMuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHdlIGNhbiBldmVuIHJlbW92ZSB0aGlzIGNoZWNrIGVu
dGlyZWx5LCB3aGljaCBtaWdodCBiZQ0KPiB3b3J0aCBwdXJzdWluZy4gQnV0IGF0IGxlYXN0IHRo
aXMgdGFrZXMgaXQgb3V0IG9mIHRoZSBob3QgcGF0aC4NCj4gDQo+IEFja2VkLWJ5OiBDaHJpcyBN
YXNvbiA8Y2xtQGZiLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPg0KPiANCj4gLS0tDQo+IA0KPiBJIGNhbWUgYWNyb3NzIHRoaXMgYW5kIHdyb3RlIHRo
ZSBwYXRjaCB0aGUgb3RoZXIgZGF5LCB0aGVuIFBhdmVsIHBvaW50ZWQNCj4gbWUgYXQgaGlzIG9y
aWdpbmFsIHBvc3Rpbmcgb2YgYSB2ZXJ5IHNpbWlsYXIgcGF0Y2ggYmFjayBpbiBBdWd1c3QuDQo+
IERpc2N1c3NlZCBpdCB3aXRoIENocmlzLCBhbmQgaXQgc3VyZSBfc2VlbXNfIGxpa2UgdGhpcyB3
b3VsZCBiZSBmaW5lLg0KPiANCj4gSW4gYW4gYXR0ZW1wdCB0byBtb3ZlIHRoZSBvcmlnaW5hbCBk
aXNjdXNzaW9uIGZvcndhcmQsIGhlcmUncyB0aGlzDQo+IHBvc3RpbmcuDQo+IA0KDQpJIGhhZCB0
aGUgc2FtZSBjb25jZXJucyBEYXZlIENoaW5uZXIgZGlkLCBidXQgSSB0aGluayB0aGUgaV9zaXpl
IGNoZWNrIGluc2lkZSBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyKCkgaXMgZGVhZCBjb2RlIGF0IHRo
aXMgcG9pbnQuICBDaGVja2luZyBraV9wb3MgYWdhaW5zdCBpX3NpemUgd2FzIGFkZGVkIGZvciBC
dHJmczoNCg0KY29tbWl0IDY2Zjk5OGY2MTE4OTczMTliNTU1MzY0Y2VmZDVkNmU4OGEyMDU4NjYN
CkF1dGhvcjogSm9zZWYgQmFjaWsgPGpvc2VmQHJlZGhhdC5jb20+DQpEYXRlOiAgIFN1biBNYXkg
MjMgMTE6MDA6NTQgMjAxMCAtMDQwMA0KDQogICAgZnM6IGFsbG93IHNob3J0IGRpcmVjdC1pbyBy
ZWFkcyB0byBiZSBjb21wbGV0ZWQgdmlhIGJ1ZmZlcmVkIElPDQoNCkFuZCB3ZeKAmXZlIHN3aXRj
aGVkIHRvIGJ0cmZzX2ZpbGVfcmVhZF9pdGVyKCksIHdoaWNoIGRvZXMgdGhlIGNoZWNrIHRoZSBz
YW1lIHdheSBQYXZlbEplbnMgaGF2ZSBkb25lIGl0IGhlcmUuDQoNCkkgZG9u4oCZdCB0aGluayBj
aGVja2luZyBpX3NpemUgYmVmb3JlIG9yIGFmdGVyIE9fRElSRUNUIG1ha2VzIHRoZSByYWNlIGZ1
bmRhbWVudGFsbHkgZGlmZmVyZW50LiAgV2UgbWlnaHQgcmV0dXJuIGEgc2hvcnQgcmVhZCBhdCBk
aWZmZXJlbnQgIHRpbWVzIHRoYW4gd2UgZGlkIGJlZm9yZSwgYnV0IHdlIHdvbuKAmXQgYmUgcmV0
dXJuaW5nIHN0YWxlL2luY29ycmVjdCBkYXRhLg0KDQotY2hyaXMNCg0KPiBkaWZmIC0tZ2l0IGEv
bW0vZmlsZW1hcC5jIGIvbW0vZmlsZW1hcC5jDQo+IGluZGV4IDQ0YjRiNTUxZTQzMC4uODUwOTIw
Mjc2ODQ2IDEwMDY0NA0KPiAtLS0gYS9tbS9maWxlbWFwLmMNCj4gKysrIGIvbW0vZmlsZW1hcC5j
DQo+IEBAIC0yNzM2LDkgKzI3MzYsNyBAQCBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyKHN0cnVjdCBr
aW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KPiAJCXN0cnVjdCBmaWxlICpmaWxl
ID0gaW9jYi0+a2lfZmlscDsNCj4gCQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGZp
bGUtPmZfbWFwcGluZzsNCj4gCQlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gbWFwcGluZy0+aG9zdDsN
Cj4gLQkJbG9mZl90IHNpemU7DQo+IA0KPiAtCQlzaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOw0K
PiAJCWlmIChpb2NiLT5raV9mbGFncyAmIElPQ0JfTk9XQUlUKSB7DQo+IAkJCWlmIChmaWxlbWFw
X3JhbmdlX25lZWRzX3dyaXRlYmFjayhtYXBwaW5nLCBpb2NiLT5raV9wb3MsDQo+IAkJCQkJCWlv
Y2ItPmtpX3BvcyArIGNvdW50IC0gMSkpDQo+IEBAIC0yNzcwLDggKzI3NjgsOSBAQCBnZW5lcmlj
X2ZpbGVfcmVhZF9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVy
KQ0KPiAJCSAqIHRoZSByZXN0IG9mIHRoZSByZWFkLiAgQnVmZmVyZWQgcmVhZHMgd2lsbCBub3Qg
d29yayBmb3INCj4gCQkgKiBEQVggZmlsZXMsIHNvIGRvbid0IGJvdGhlciB0cnlpbmcuDQo+IAkJ
ICovDQo+IC0JCWlmIChyZXR2YWwgPCAwIHx8ICFjb3VudCB8fCBpb2NiLT5raV9wb3MgPj0gc2l6
ZSB8fA0KPiAtCQkgICAgSVNfREFYKGlub2RlKSkNCj4gKwkJaWYgKHJldHZhbCA8IDAgfHwgIWNv
dW50IHx8IElTX0RBWChpbm9kZSkpDQo+ICsJCQlyZXR1cm4gcmV0dmFsOw0KPiArCQlpZiAoaW9j
Yi0+a2lfcG9zID49IGlfc2l6ZV9yZWFkKGlub2RlKSkNCj4gCQkJcmV0dXJuIHJldHZhbDsNCj4g
CX0NCj4gDQoNCg0KDQo=
