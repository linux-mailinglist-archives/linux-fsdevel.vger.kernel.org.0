Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6D46D7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhLHQTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:19:45 -0500
Received: from mail-bn7nam10on2114.outbound.protection.outlook.com ([40.107.92.114]:37472
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231381AbhLHQTp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJgNUGOa1NNtoO6NrqGJH8yp8Lq1Nvho7imSC8Uf3/gTTqw206fDa9qq8KnHGOwiI6cEfZuY2Cfj4ETpkkeLnHdaqlqvdyR1b4B5ZLKNGiNhyLxe5xsxSoYbeWnidD0EhsRib0X32TaNySfiQJkqRVdgP9MJhwhD764Ebe6S7WjL/nQvAGwBy3oc9/HNiZF90FxZhB+Fo408AW/5qDtJLJQDLRKBeowT5rg3kndnHWxyCLEVhjj1toyyOX32D044QrIRGzQAkExmahhljaKauIYK4pEqNVEmILsV+Rdz8M5HrNT3DjTBMaYP1ijSDTqdIIMoJydUwMv3uiMxAzyHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBQB3Ulh+3MVFlqk5jriXk4NdF6ROpKjq6vB03K9oiI=;
 b=cCwoatQ4ohYwyse4govjTPxs2IL5/LF0v2x1k96F0oRJZFmYEm3dsrhjmahxv8UEol8mWzuS1tyqq3STOjYqQGJ/KBglP1xKcWQ4IH5Vi7DjtBYKR5Nmfg/dtg6j5hLWA5XgfpuTG2ZDb/f4Iz4S3WUC1i9SN23Aeh+S8ynKvZ55glFMKkmavwKAAJwzyufaq9Wmq96yfBgqcyYacBCvXhvMYJUgdF+oKVHcUM1rXwCC0ECSO+MdbHIZnj4BbUaa3GqH6k/msnH4aQYctCX4tpX0ROJ2fRrERcjz6ah3meeboDFNsACAFvPCAOHSGSDvx+KcCOn3FNPAfML/lT1MTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBQB3Ulh+3MVFlqk5jriXk4NdF6ROpKjq6vB03K9oiI=;
 b=KcJMv5PRV8ZHfUO85KekdGYmN3xf1zTTEmFjmI0h3VhwL8PrfzVKzQn2otcq4JxAijy39oyN6V7xGeoNGFdik6hHVGqypPqQzfIaeqUFih9ZFuUVHJTINxhPBl1lS3C1vI+UjWPNtXpTXnz0KTxk1T1qYAnJZm7TTXic0DQWU0A=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5081.namprd13.prod.outlook.com (2603:10b6:610:ec::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7; Wed, 8 Dec
 2021 16:16:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 16:16:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssWdMvYdu7B0EyGEYzPlOZdG6wl4NyAgALhbICAAAXyAA==
Date:   Wed, 8 Dec 2021 16:16:09 +0000
Message-ID: <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
         <20211206175942.47326-3-dai.ngo@oracle.com>
         <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
         <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
In-Reply-To: <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02321f57-4ba0-44be-49b5-08d9ba660bff
x-ms-traffictypediagnostic: CH0PR13MB5081:EE_
x-microsoft-antispam-prvs: <CH0PR13MB50819D488F7B1CEF3484CE38B86F9@CH0PR13MB5081.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+nBKC/DOV9d35y0pSwcFBapkNKKyUo0KFmzHiOEQ/jydcJhbDQIqHQXbB8V1Z1bj2iuzRL9eppi4HmJ7d+MYRoUZMPZM9qbMDDD/JMTAdFWXE9YTYKhlEGDF/TAhfasLu6Hr+F1FI4WrTv4JZzNaBIOAJgXhSUQ6oMgG2SmUswYmnLZUObNTl5K9r2xnGBowhZsUNVhoRAuqJrDc7mrqKYA6ww+Jr9604XfsJTqdXcMBB6TrW4b3sjCMvi95tGOR5Ff8o2F/nYS15U+KRQbHGAIKBty9pv4hfK9zx863do+yu93Dj2pk7dDJcFYCD1utlqoorseP1zLFz/z313poqmzwodv8xOtf/EVY8v8V7lpd9xzqESUpUFPSaEMp6tGgDiWOJCclbw3/VK4eO/Q/vLisloNtHLLJn7ccPQcrEaTJrKuhVWvXAEhSwTRZx8D2nRG7Ys4956BPRD/lMZ6F84gxVmx+42AebC8hgeaii0bLQaDGPy1mMAY6CFwCdcWzr/motQWyxUE3nnOZ6uCcXsJ8pi44oj0yZlJj6/IE7GI84dE+fp/iCj79otJSqUw1CIz61rCN0OysAFvl6l5nnWXNXiTOnWGxdPm2DjuVbeQPVsfd2xUTQYvLzhOyJuxW3aty2K4OaLhIFY3gUBJ1glDtthMCdDeTs9YK3Pvsv/ZswKH4o0Aj9nleqWVFezNcu5Ku+sIzQ7grla7eVdrkEcA4zGZuE25Psy20bh5LNu0BPKEil++0F8jce68viUjKBPPGzc22Nt1LUoN9Jp05ILRqj8MX7GPrbgPhuQSysw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39840400004)(76116006)(71200400001)(508600001)(6512007)(8676002)(2906002)(966005)(8936002)(66946007)(4326008)(5660300002)(316002)(6486002)(38100700002)(66476007)(64756008)(66556008)(66446008)(54906003)(19627235002)(122000001)(36756003)(2616005)(86362001)(38070700005)(110136005)(6506007)(53546011)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THl4cm94RG9LamZWeXhiS3Z3QThLNTR6WE1iLzFaVE9WaVBMVU1IMkNYR3VL?=
 =?utf-8?B?cG1seG1nVVd2Rm1NV2ZrVkZDczBpSmlvUmUzYlkrZE1POVNObDBrQTZRSTNq?=
 =?utf-8?B?UldIU2JlS2ZkN2thUXViQ1U2YU5lczhRTWRlY2lMSmlmSHhxQ3RKNmJ3eS84?=
 =?utf-8?B?a25qeGRFcitZL0JIbkV0TDNqRkRySmRRZUhwUjNPMW5aZnVwek9LQ2QvcHJJ?=
 =?utf-8?B?dHFRWm9acGlRbGVrL1hqOU41a2tadXFaVlIxYzJNcDBrby9SMnF2cmhuZmNZ?=
 =?utf-8?B?dkNuNnRydldnN1FZb2hMeStPZmxaWXU3NjdCVUc3Y2V2V3N5L010akJHNmFw?=
 =?utf-8?B?ZVgySWJqRWFsT1BSNDNTV3U4Ykx3aFVaLzI3cTg4MThid3dkVnNBVzZ4SHVi?=
 =?utf-8?B?SnZqdmdNNmZkZmJIUzVURTJvUjJxcjJnZjFkY2lVaUtwZDQ1VWFLcXg4c2pY?=
 =?utf-8?B?N3RhZDZXLzY1UnFyRzRRWENFeFBVS0xsa2lEa1hLOXpvYUlSRXFMcGI4OWxp?=
 =?utf-8?B?YW1RMDNVYVFxYkFtc25LcFFKc0pteUdxdUpleUtvNGh2MFJDcklrVDZWc3h1?=
 =?utf-8?B?eHRBL1QvaWRHcmU1bjIvTllwMVVZckhkQ2g5YXpockpmdkdITDN3Qk9rZjNz?=
 =?utf-8?B?RFVxckw1aDZHajR4c21aTGFyNVhZazdFeHZYQXBxdlhRYUZHMmxma0lWTllH?=
 =?utf-8?B?dWhPLzF3SVAzSU9RS0JYUVYyUmszQ0dFcFRwQUdCL1pWUWFCTjBDM0J6djJo?=
 =?utf-8?B?VlpQdWZNa3NlYkhsa0ZRVllmRkpGdWRQTlNFQkt6YlppbDltT1U3cHVzODM2?=
 =?utf-8?B?UkVqakVGaGRoYjFLaUdDZFFWYndCN2VzQThYcGU3WlZLNEVTRVVRNTU4dzJN?=
 =?utf-8?B?RGtzS1Zvdmdwb21LTFVrL2lZZWoxTFVpYzcrSTRtS1RKWXVMNnQ1ZitsOWh0?=
 =?utf-8?B?TmhEM2p5R2tkTklPK3VSNWY3ZU95N0kyWDZJWDEyQW4vbVJVb2lXZnhkeXlD?=
 =?utf-8?B?UXhHZVIwT2N2dmRYT2lUNFlxNm1FWlgzTUdVQlJXOFZGMi9KakdqS3o1c2cv?=
 =?utf-8?B?cER6bGM1cHNaamVzNVh0dElhZGYvVGFDRElLc1lic2R2dm1Ha3gyVjQyb1Ay?=
 =?utf-8?B?SXVwRDZGZWpHVUlmb0ZnLzdNdEV4MWlvWGF3VGsxeE5YK3F3TEtBajRWR050?=
 =?utf-8?B?SjRFdGUreThGdlpGUy91akQ5RFJyQll1a1E1VFNhUWZKbGJGRVR6Rk5aZm9k?=
 =?utf-8?B?eVI2VTBxUUZRL0hCZEJMVllXdFF3bHBJMmRTRG9QQis0Lys2UWlVc21Jbnls?=
 =?utf-8?B?elFLc1laaFA1V0RqQjB3YTRaWDlrUld2ekxyUWxpN3VUWE5MNkYrNm9paGh0?=
 =?utf-8?B?bkYyVDQvOUdYNDhHeWxKWE9lYmc0bndjdkdLRXBUSGZ6ZzVWWWRMeVZTWWsw?=
 =?utf-8?B?REtVMFovYWp5V2o3cVE1em40MXRIcmNPdGJBWHVrQmxxbEZ2M0FoNlFmdEk4?=
 =?utf-8?B?VTZEZ0dPVjl0OEZaY2dzTWc1MTl2UDRtbGM0cnhvK09RVFpVcVluZlYva2hR?=
 =?utf-8?B?OHZ6U0ltQTJJKzM0dndMbWNncVB2cTUrdzdYZzZzaG1haTRNaHF3by9DOGVk?=
 =?utf-8?B?YWtCUHE4emQvVG1ycHRJSVRHN2hqL1NQb0VtNWdISjNWenRWODEreW9xY0Rv?=
 =?utf-8?B?dEsyZ2pOZW1DRXl2b2F6b0J2SnIxNDNGTWJzek5BanFFUzMxM09yaWNqdll4?=
 =?utf-8?B?U1dNQU1mV1hxaHBrTHJOYW5qNCs2RTkzVkV1S1NWaXcxbWZFcVJKRHpjaTYx?=
 =?utf-8?B?ZWlLZndFUUxzVjJHUUx6ODBtOHY5dGF2VGZvUXduVXcxVy9TQlVkWExQeXdX?=
 =?utf-8?B?QS83WU5FY1JxbWh3SHFweWMvNDFqbVpTU3Jpb0FUOTFzeERXRkl3Q1JWRVlp?=
 =?utf-8?B?UUpUbzZFb0RWczkvNUdBTXRyL0hCSVZuMHBENktKU3k2aDNEaVd1VVh3K0R0?=
 =?utf-8?B?ZmlCRVIxNEZGVGdNN1ZDVEh4TzJSbGNYa3k0a3JWaEQweHZ3Z2U4ZHBENGpT?=
 =?utf-8?B?VHJoOVpLZkNqZitqb0g5VXhSUlNnQWg1T3BtRXl4NzRxNllGa1p0L3h5bVEr?=
 =?utf-8?B?R0lKdE9IclBaK0J6S2JpRVFQYkMzMkJ2S2dEd2dLS08wTTRCMUxocWZ2QWpB?=
 =?utf-8?Q?0SPzX32RSSpIy89DwuXfuso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A130E7EC50607479EFF8ADE5C7D53B4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02321f57-4ba0-44be-49b5-08d9ba660bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 16:16:09.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxQym7SeqJAKN/2+Cl0xmqcQo3Iktv67AaExcgYgq6JuZCJRNPU84wqGUwZwULSpCEmTjehix0i3f4uY68Rqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5081
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTA4IGF0IDA3OjU0IC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6Cj4gT24gMTIvNi8yMSAxMTo1NSBBTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgo+IAo+ID4g
Cj4gPiA+ICsKPiA+ID4gKy8qCj4gPiA+ICsgKiBGdW5jdGlvbiB0byBjaGVjayBpZiB0aGUgbmZz
ZXJyX3NoYXJlX2RlbmllZCBlcnJvciBmb3IgJ2ZwJwo+ID4gPiByZXN1bHRlZAo+ID4gPiArICog
ZnJvbSBjb25mbGljdCB3aXRoIGNvdXJ0ZXN5IGNsaWVudHMgdGhlbiByZWxlYXNlIHRoZWlyIHN0
YXRlIHRvCj4gPiA+IHJlc29sdmUKPiA+ID4gKyAqIHRoZSBjb25mbGljdC4KPiA+ID4gKyAqCj4g
PiA+ICsgKiBGdW5jdGlvbiByZXR1cm5zOgo+ID4gPiArICrCoMKgwqDCoMKgIDAgLcKgIG5vIGNv
bmZsaWN0IHdpdGggY291cnRlc3kgY2xpZW50cwo+ID4gPiArICrCoMKgwqDCoMKgPjAgLcKgIGNv
bmZsaWN0IHdpdGggY291cnRlc3kgY2xpZW50cyByZXNvbHZlZCwgdHJ5Cj4gPiA+IGFjY2Vzcy9k
ZW55IGNoZWNrIGFnYWluCj4gPiA+ICsgKsKgwqDCoMKgwqAtMSAtwqAgY29uZmxpY3Qgd2l0aCBj
b3VydGVzeSBjbGllbnRzIGJlaW5nIHJlc29sdmVkIGluCj4gPiA+IGJhY2tncm91bmQKPiA+ID4g
KyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmZzZXJyX2p1a2Vib3ggdG8gTkZTIGNs
aWVudAo+ID4gPiArICovCj4gPiA+ICtzdGF0aWMgaW50Cj4gPiA+ICtuZnM0X2Rlc3Ryb3lfY2xu
dHNfd2l0aF9zcmVzdl9jb25mbGljdChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLAo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0X2Zp
bGUgKmZwLCBzdHJ1Y3QKPiA+ID4gbmZzNF9vbF9zdGF0ZWlkICpzdHAsCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTMyIGFjY2VzcywgYm9vbCBz
aGFyZV9hY2Nlc3MpCj4gPiA+ICt7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGludCBjbnQgPSAwOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQgYXN5bmNfY250ID0gMDsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgYm9vbCBub19yZXRyeSA9IGZhbHNlOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZz
NF9jbGllbnQgKmNsOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkICpwb3Ms
ICpuZXh0LCByZWFwbGlzdDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc2RfbmV0ICpu
biA9IG5ldF9nZW5lcmljKFNWQ19ORVQocnFzdHApLAo+ID4gPiBuZnNkX25ldF9pZCk7Cj4gPiA+
ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgSU5JVF9MSVNUX0hFQUQoJnJlYXBsaXN0KTsKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZubi0+Y2xpZW50X2xvY2spOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqBsaXN0X2Zvcl9lYWNoX3NhZmUocG9zLCBuZXh0LCAmbm4tPmNsaWVudF9scnUpIHsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsID0gbGlzdF9lbnRyeShwb3Ms
IHN0cnVjdCBuZnM0X2NsaWVudCwgY2xfbHJ1KTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC8qCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjaGVj
ayBhbGwgbmZzNF9vbF9zdGF0ZWlkIG9mIHRoaXMgY2xpZW50Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBmb3IgY29uZmxpY3RzIHdpdGggJ2FjY2Vzcydtb2RlLgo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAobmZzNF9jaGVja19kZW55X2JtYXAoY2wsIGZwLCBzdHAsIGFj
Y2VzcywKPiA+ID4gc2hhcmVfYWNjZXNzKSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghdGVzdF9iaXQoTkZTRDRfQ09VUlRFU1lfQ0xJ
RU5ULCAmY2wtCj4gPiA+ID5jbF9mbGFncykpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogY29uZmxpY3Qgd2l0
aCBub24tY291cnRlc3kKPiA+ID4gY2xpZW50ICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5vX3JldHJ5ID0gdHJ1
ZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY250ID0gMDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaWYgdG9vIG1hbnkgdG8g
cmVzb2x2ZSBzeW5jaHJvbm91c2x5Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogdGhlbiBkbyB0aGUgcmVzdCBpbiBiYWNrZ3JvdW5kCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNudCA+
IDEwMCkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRfYml0KE5GU0Q0X0RFU1RST1lfQ09VUlRFU1lfQ0xJRQo+
ID4gPiBOVCwgJmNsLT5jbF9mbGFncyk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFzeW5jX2NudCsrOwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb250aW51ZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKG1hcmtfY2xpZW50X2V4cGlyZWRfbG9ja2VkKGNsKSkKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29udGludWU7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY250Kys7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbGlzdF9hZGQoJmNsLT5jbF9scnUsICZyZWFwbGlzdCk7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+IEJydWNl
IHN1Z2dlc3RlZCBzaW1wbHkgcmV0dXJuaW5nIE5GUzRFUlJfREVMQVkgZm9yIGFsbCBjYXNlcy4K
PiA+IFRoYXQgd291bGQgc2ltcGxpZnkgdGhpcyBxdWl0ZSBhIGJpdCBmb3Igd2hhdCBpcyBhIHJh
cmUgZWRnZQo+ID4gY2FzZS4KPiAKPiBJZiB3ZSBhbHdheXMgZG8gdGhpcyBhc3luY2hyb25vdXNs
eSBieSByZXR1cm5pbmcgTkZTNEVSUl9ERUxBWQo+IGZvciBhbGwgY2FzZXMgdGhlbiB0aGUgZm9s
bG93aW5nIHB5bmZzIHRlc3RzIG5lZWQgdG8gYmUgbW9kaWZpZWQKPiB0byBoYW5kbGUgdGhlIGVy
cm9yOgo+IAo+IFJFTkVXM8KgwqAgc3RfcmVuZXcudGVzdEV4cGlyZWTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ogo+IEZBSUxVUkUKPiBMS1UxMMKgwqDCoCBzdF9sb2NrdS50ZXN0VGltZWRvdXRVbmxvY2vCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoK
PiBGQUlMVVJFCj4gQ0xPU0U5wqDCoCBzdF9jbG9zZS50ZXN0VGltZWRvdXRDbG9zZTLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoKPiBG
QUlMVVJFCj4gCj4gYW5kIGFueSBuZXcgdGVzdHMgdGhhdCBvcGVucyBmaWxlIGhhdmUgdG8gYmUg
cHJlcGFyZWQgdG8gaGFuZGxlCj4gTkZTNEVSUl9ERUxBWSBkdWUgdG8gdGhlIGxhY2sgb2YgZGVz
dHJveV9jbGllbnRpZCBpbiA0LjAuCj4gCj4gRG8gd2Ugc3RpbGwgd2FudCB0byB0YWtlIHRoaXMg
YXBwcm9hY2g/CgpORlM0RVJSX0RFTEFZIGlzIGEgdmFsaWQgZXJyb3IgZm9yIGJvdGggQ0xPU0Ug
YW5kIExPQ0tVIChzZWUgUkZDNzUzMApzZWN0aW9uIDEzLjIgaHR0cHM6Ly9kYXRhdHJhY2tlci5p
ZXRmLm9yZy9kb2MvaHRtbC9yZmM3NTMwI3NlY3Rpb24tMTMuMgopIHNvIGlmIHB5bmZzIGNvbXBs
YWlucywgdGhlbiBpdCBuZWVkcyBmaXhpbmcgcmVnYXJkbGVzcy4KClJFTkVXLCBvbiB0aGUgb3Ro
ZXIgaGFuZCwgY2Fubm90IHJldHVybiBORlM0RVJSX0RFTEFZLCBidXQgd2h5IHdvdWxkIGl0Cm5l
ZWQgdG8/IEVpdGhlciB0aGUgbGVhc2UgaXMgc3RpbGwgdmFsaWQsIG9yIGVsc2Ugc29tZW9uZSBp
cyBhbHJlYWR5CnRyeWluZyB0byB0ZWFyIGl0IGRvd24gZHVlIHRvIGFuIGV4cGlyYXRpb24gZXZl
bnQuIEkgZG9uJ3Qgc2VlIHdoeQpjb3VydGVzeSBsb2NrcyBuZWVkIHRvIGFkZCBhbnkgZnVydGhl
ciBjb21wbGV4aXR5IHRvIHRoYXQgdGVzdC4KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tCgoK
