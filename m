Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F33F484C52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiAECJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 21:09:26 -0500
Received: from mail-bn8nam12on2136.outbound.protection.outlook.com ([40.107.237.136]:1888
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231898AbiAECJZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:09:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMPm6YX5jEn7sVEbKhJPZlTFfzqOI+uz+Hee893sFDvoUhqF4t33uCZ7PzgVGqmq+plMFSv+Vzw+U/tPmU5xiyVQ9ZBVs9Cggoq60n2E/r1LeEAHazn/uFBbJFEbo1UEKbY38lpjW71mUrWiLdXvpAc0y5ut8i6oFf4SejO3E9SYEvltcTxyxD0vjG80mVlRZ4R9DTNd08lLvm6NuL4Q9cqiNZnJZwieZxuP0WqcDO5lByLmgpTYMh5t3GoFDSxc0kyINjWjEZ+ozGAfvqpJQaQumJpDeJRX0Sn9xP+cDow7P9QFekwg8T9kxUMquBFCEHP04s2qFlvGzWcgfIQyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j29sEFUfnvck74oar1aoyj1T1L+OK3yo3OZO8rIC0c4=;
 b=HY/YS4axy9OgXxMCdBi6cHrmA67kCjo9K50Ebs/eOjebtcTgcYPSexNkQzqIMubgfXaprpBSmKckRiNtf0XHLgTxuccCE25ZRNlGs1P13ixzh2yGd3a8UgTph7poQs9/3qdFAVaNaJ60W3pnyg54dC6+8e1dmYRm6gXQOU70OLdMtzaHndMwSZiKhZ1aooXOsoMnggcvlUxXsnhE/QhiYRrqMluk7eKlvBiO9i/F368xT7YUJrwz8Qqymt+4sDWDOvdu6HQFikenQ58SGJOyo4hxHO/MZl3n4e8LkuECtvpBRqyTTv0Mlr6CSMdbSn+9Nx2BV3mqkOIMJlvqx/gwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j29sEFUfnvck74oar1aoyj1T1L+OK3yo3OZO8rIC0c4=;
 b=dKoI3HkDby2BDc8tE57U1DzEe0gZFN59PmECS7nn9I7cVh2olAibVpPntDpfY69jVU/Uptf4xkF3Rm8HOdQGy6h/P++FuPPP04EQV74ZSk4zEqmkmPVlbbk40zooq7UgkQJYPfhfA/iYoyi0WgFLrz2Zh6pfZOmZ66/4eEZhmuU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3387.namprd13.prod.outlook.com (2603:10b6:5:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.5; Wed, 5 Jan
 2022 02:09:22 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 02:09:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAGffQA=
Date:   Wed, 5 Jan 2022 02:09:21 +0000
Message-ID: <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
In-Reply-To: <20220104012215.GH945095@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 029b732b-ce7f-43e9-c140-08d9cff063c1
x-ms-traffictypediagnostic: DM6PR13MB3387:EE_
x-microsoft-antispam-prvs: <DM6PR13MB338751330BAAE6FBE94F4B76B84B9@DM6PR13MB3387.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHsciz5l9cGPsTxOyg+EZuQxyUq9z3MlycZwuXI7nQjQt4zJ87RYPUESGGL7tV1252MFNa6IQE8f0fp0o7LcJdPnd58e6lbv5esNxXXZC+XLF/77IALYpH8agrboMm9kYPh9ZaSmhnumTbEuXYt2t+oDMNaJ7gKWMcXp1yBtWBXFsg5rApmGcT+Pd+kHnuxUzlZdxcPVfU9+69zWekYnPlkYR5AdVi13R24ApAStVFK1bSdEOKdzw8lXbslSiWslWqvSvjhQ8pMWZse2VTmnd+vV0Ly4280s/Z5rdhk+R2WSzAtMpDY50zbSOEmL4fMW4+ebsJubNioSRhFljccoqAI3La0JOVb8CICxFzV8BaKBy1GatiL1+kofa3KrHziu8aEMTONdGiDO/AtecUTK97K9DhkuBDk3hVxfOrr6EZbc+a2aiHtu4PWtbqLvmDHqIbRUTAGOsFyBhCISUzBcos8iFfGl5TSKGzhLkK3keTLE58/rAlPAmp1Qv/DmBZ8/r3VpWMwKLuPaRHA/UiM9/gJUTYTKocMmnGJ2bb/pk6i9tN+WGZbARfajyVSXVSfrlwHfVywu1MpBz/Cut7vDJ4ULqD/WvZDrDhIC1UOVX2En/KV3zL1+qhxVx0sIW5+O9iA8MwQ1PqAx4nMXWt+6tyRYnhYVanaoJsajPTFd9fcxS5CADPLR0DCR60PO6Jm4l9Tr7agYlpfRZhB1byOwgXRl2DRFcT/HzSYd2WtTWCp7mRavn3vWCmfVyWubbJ9E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(376002)(396003)(366004)(136003)(346002)(54906003)(76116006)(6916009)(66446008)(71200400001)(38070700005)(83380400001)(86362001)(2906002)(5660300002)(38100700002)(64756008)(508600001)(6512007)(2616005)(26005)(4326008)(36756003)(186003)(8936002)(8676002)(66946007)(316002)(66556008)(6506007)(6486002)(122000001)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um1KcWQ5SnFLNE4xNTJobVZIREl5Mlc4aFZsQVM2ZlZHZ1c2WFQzclVpV0cz?=
 =?utf-8?B?WlNqM1VraXBVejRIUVgydGI0RGxrL3hLblNrUk43WHduVHpJdzZhaXFib3lQ?=
 =?utf-8?B?Q0tQejVnR1QrZHhVUVliQUpCajJvdVFlWmM5L3p3bHIxNDl3RXBtWmtQNnVZ?=
 =?utf-8?B?NXY1TlpHbURzUlcvcmQxSll6blI2SWkrMmFqak8zdVM3dFlrd09FOVBSM0la?=
 =?utf-8?B?TzRBZzhSVktxTENwOUYvY2kyR1loV3lROEhBY1N4a3Y3RUdMYXJqbnhVR2pp?=
 =?utf-8?B?ckt2ajN3WUJvd2pLb1hnc2lXRTR2OHQvMmVLdXhNUytvdlZGbi9JZ2lTVXdy?=
 =?utf-8?B?SzIyakI2a2V0MVJneEpzVjY3ejgxY3dXdzFUcmZ5WS9Bai9vMjRQdGgrcjNJ?=
 =?utf-8?B?ckd6eWpLOXFBM2o0NDJZRzlNRWtveFJncXJRRFR2ZzNJMCtCY2tGNUQzL3Zh?=
 =?utf-8?B?SFNKUVU4NzJocTZlK08xTnp1b3ZJdCt3QW9JMlFzenpOSTdHSjl1NWgvTXVS?=
 =?utf-8?B?VGEzNFlXS2NPd21Td2N4T2dyTlE4U3NtRWZuTVVuTWRjeGl3TEFzUGdjZ0l0?=
 =?utf-8?B?QVcxNnBiQzRRMWwwMndaVGJ1NWhpUXg3TWdWWE9EMW9HVGZrRmdSNm9acUcr?=
 =?utf-8?B?c2hIekhCTFo2QzkrRWhFcklxaFBjNzIyc2pTTkQ1R2dVZzI2Q2ZHQ3JvY0tF?=
 =?utf-8?B?c3Q5NWZkYiswUWVIN20yTHZCNTA1MWFXWTN1U2pBbUYwdHJ1T0UwWE40Z3cx?=
 =?utf-8?B?TEJuRzcyZzdnem5qNmEyUXFzSmtVV014aEcyYXEvbXlNSmtGOHF2cTNJNlNL?=
 =?utf-8?B?bnpiNXZta3NiZHZranU3b1B4bTdxTnpRRzU5VDRnYmZyclFNMW5CM2Rjdnda?=
 =?utf-8?B?dDFIYkxjaXQxaTF4WHpBNHBmekRMQkN2NmRtSnRaUWt0YmpiSkZSbGFjSE1w?=
 =?utf-8?B?ckY1NHFZdmhUc0Z2cHdiL1Z4aW1EYjhrb25Pd0lOR2M3a2VLdmhsUGtUbHVN?=
 =?utf-8?B?YVpDcVdxOEVSbTFqWnIxWlBoODlMc3dGclczTFljbWt0TXBwZWkvbG8vVXJ3?=
 =?utf-8?B?YWtkZ3YwcFB1RFZNaHQ0T0JrbkhKTSsxcktHRldycXhBYnJYdGpHNm5VNkxH?=
 =?utf-8?B?UTZaMzFQWUxKNjdKc09KcTFGalNwMGVZQ3RCZlV6TmwvUUFDcFh5bW5QNFpX?=
 =?utf-8?B?c29JVytwUUNzSnVydWNsUzc0V3dyZUVXdGZRaDdoRHU5ZXVtV25jZWRjc3JF?=
 =?utf-8?B?aVNYSHlzUEIxQkM0WW1mcnAwR1N3SStaTm94cDdveTluVTJFTEhkVnFlZ3Zn?=
 =?utf-8?B?SjdrV053OUpmdDNRR293ZlN6ZlhXeGpRY1RuTlc5WnFvYnFJOU8rYnpLZWtT?=
 =?utf-8?B?Z0hyZlFDRjdSa29MYkNSNFNTeEIzRVpWcWlhSTZRU3V4cmYxZUVnTUlEWk1K?=
 =?utf-8?B?bXlNTXlmOXZmcGQzS1hPM3NkMjJHaXp5RzBEaU9Qb2dMRkRIemI1Z05HNHlJ?=
 =?utf-8?B?SjFPbmVYWE1QZ3RsTk02RXlhblBEaXovdmlFQmZUakxhc3VkU0RxWkxyU3dT?=
 =?utf-8?B?NHBWUHFiTkRMMnE3MjV5RXJGKy9INTB3REVrNlVTWHBseEU5MTJVaHp5aE5m?=
 =?utf-8?B?SGRBaFF2RXNiK1JDRmQrZy9BSGcxWU8xRkdVdjRJaGRhNjE3ZmZmbmpSZ1Bs?=
 =?utf-8?B?VVZwMGZaaGR6a3BWbkxMNlg3c1RDVEMyT2pidDRxRXdMSWFsZVA3bnNIODV2?=
 =?utf-8?B?RWxEbFhpOWhFNkFsWFFrbU1OWTJhcGNSSlNMWVB4ZlE5amVwazRFbCtpRVlK?=
 =?utf-8?B?K0Y5b2srWXU3UzJjaklJUjRXa2ZoYnJnMjFVNGhib0VIUVIrbmRGSTk3VVhB?=
 =?utf-8?B?WS9PUENhOWpTRmVjZDhaTlM4OUIyc04xZnJnK0hUQ04zN2g4dUM1dkVpalFG?=
 =?utf-8?B?ZldMWHc4YktoaDFZNlpoeWhFK1ZZVWNaWmpJYi9qWGk3dGpVWWtLbmhNUG5V?=
 =?utf-8?B?ME5FYXdKQ0VPdHE5dWtmL0k3YTdlL3pzVjh5QVlBZlpEUmJjUUc5Y29Od1R5?=
 =?utf-8?B?SStiOTR3Nk5WOGZ4dmxhTEhKSll5clN6RUNhNlJaZzNFYVZDbkp2QmNQdVR5?=
 =?utf-8?B?bU5pZlNHVEZEY2hhdkR3eklDV0thQ2NMYW9EY1RScThYZnFUU0RqYmNtaGp0?=
 =?utf-8?Q?1Irl6rLtcLIIkEac/keKKoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B88E038C4FDBF4DB0878050A5DC57C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029b732b-ce7f-43e9-c140-08d9cff063c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 02:09:22.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvE8k2A+ypwpI/BIathRBbuTHRmr2SGDzkmJSY+ZKKf5bfYrXbgufJ6thwMEM3fuPewKAa962zSQQOfNV0VwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3387
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDEyOjIyICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFR1ZSwgSmFuIDA0LCAyMDIyIGF0IDEyOjA0OjIzQU0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMDEtMDQgYXQgMDk6MDMgKzExMDAsIERhdmUgQ2hp
bm5lciB3cm90ZToNCj4gPiA+IE9uIFNhdCwgSmFuIDAxLCAyMDIyIGF0IDA1OjM5OjQ1UE0gKzAw
MDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gU2F0LCAyMDIyLTAxLTAxIGF0
IDE0OjU1ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+ID4gPiA+ID4gQXMgaXQgaXMsIGlm
IHlvdSBhcmUgZ2V0dGluZyBzb2Z0IGxvY2t1cHMgaW4gdGhpcyBsb2NhdGlvbiwNCj4gPiA+ID4g
PiB0aGF0J3MNCj4gPiA+ID4gPiBhbiBpbmRpY2F0aW9uIHRoYXQgdGhlIGlvZW5kIGNoYWluIHRo
YXQgaXMgYmVpbmcgYnVpbHQgYnkgWEZTDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiB3YXksIHdh
eSB0b28gbG9uZy4gSU9XcywgdGhlIGNvbXBsZXRpb24gbGF0ZW5jeSBwcm9ibGVtIGlzDQo+ID4g
PiA+ID4gY2F1c2VkDQo+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiBhIGxhY2sgb2Ygc3VibWl0IHNp
ZGUgaW9lbmQgY2hhaW4gbGVuZ3RoIGJvdW5kaW5nIGluDQo+ID4gPiA+ID4gY29tYmluYXRpb24N
Cj4gPiA+ID4gPiB3aXRoIHVuYm91bmQgY29tcGxldGlvbiBzaWRlIG1lcmdpbmcgaW4geGZzX2Vu
ZF9iaW8gLSBpdCdzDQo+ID4gPiA+ID4gbm90IGENCj4gPiA+ID4gPiBwcm9ibGVtIHdpdGggdGhl
IGdlbmVyaWMgaW9tYXAgY29kZS4uLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMZXQncyB0cnkg
dG8gYWRkcmVzcyB0aGlzIGluIHRoZSBYRlMgY29kZSwgcmF0aGVyIHRoYW4gaGFjaw0KPiA+ID4g
PiA+IHVubmVjZXNzYXJ5IGJhbmQtYWlkcyBvdmVyIHRoZSBwcm9ibGVtIGluIHRoZSBnZW5lcmlj
IGNvZGUuLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDaGVlcnMsDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gRGF2ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZhaXIgZW5vdWdoLiBBcyBsb25nIGFzIHNv
bWVvbmUgaXMgd29ya2luZyBvbiBhIHNvbHV0aW9uLCB0aGVuDQo+ID4gPiA+IEknbQ0KPiA+ID4g
PiBoYXBweS4gSnVzdCBhIGNvdXBsZSBvZiB0aGluZ3M6DQo+ID4gPiA+IA0KPiA+ID4gPiBGaXJz
dGx5LCB3ZSd2ZSB2ZXJpZmllZCB0aGF0IHRoZSBjb25kX3Jlc2NoZWQoKSBpbiB0aGUgYmlvIGxv
b3ANCj4gPiA+ID4gZG9lcw0KPiA+ID4gPiBzdWZmaWNlIHRvIHJlc29sdmUgdGhlIGlzc3VlIHdp
dGggWEZTLCB3aGljaCB3b3VsZCB0ZW5kIHRvDQo+ID4gPiA+IGNvbmZpcm0NCj4gPiA+ID4gd2hh
dA0KPiA+ID4gPiB5b3UncmUgc2F5aW5nIGFib3ZlIGFib3V0IHRoZSB1bmRlcmx5aW5nIGlzc3Vl
IGJlaW5nIHRoZSBpb2VuZA0KPiA+ID4gPiBjaGFpbg0KPiA+ID4gPiBsZW5ndGguDQo+ID4gPiA+
IA0KPiA+ID4gPiBTZWNvbmRseSwgbm90ZSB0aGF0IHdlJ3ZlIHRlc3RlZCB0aGlzIGlzc3VlIHdp
dGggYSB2YXJpZXR5IG9mDQo+ID4gPiA+IG9sZGVyDQo+ID4gPiA+IGtlcm5lbHMsIGluY2x1ZGlu
ZyA0LjE4LngsIDUuMS54IGFuZCA1LjE1LngsIHNvIHBsZWFzZSBiZWFyIGluDQo+ID4gPiA+IG1p
bmQNCj4gPiA+ID4gdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwgZm9yIGFueSBmaXggdG8gYmUgYmFj
a3dhcmQgcG9ydGFibGUNCj4gPiA+ID4gdGhyb3VnaA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3Rh
YmxlIG1lY2hhbmlzbS4NCj4gPiA+IA0KPiA+ID4gVGhlIGluZnJhc3RydWN0dXJlIGhhc24ndCBj
aGFuZ2VkIHRoYXQgbXVjaCwgc28gd2hhdGV2ZXIgdGhlDQo+ID4gPiByZXN1bHQNCj4gPiA+IGlz
IGl0IHNob3VsZCBiZSBiYWNrcG9ydGFibGUuDQo+ID4gPiANCj4gPiA+IEFzIGl0IGlzLCBpcyB0
aGVyZSBhIHNwZWNpZmljIHdvcmtsb2FkIHRoYXQgdHJpZ2dlcnMgdGhpcyBpc3N1ZT8NCj4gPiA+
IE9yDQo+ID4gPiBhIHNwZWNpZmljIG1hY2hpbmUgY29uZmlnIChlLmcuIGxhcmdlIG1lbW9yeSwg
c2xvdyBzdG9yYWdlKS4gQXJlDQo+ID4gPiB0aGVyZSBsYXJnZSBmcmFnbWVudGVkIGZpbGVzIGlu
IHVzZSAoZS5nLiByYW5kb21seSB3cml0dGVuIFZNDQo+ID4gPiBpbWFnZQ0KPiA+ID4gZmlsZXMp
PyBUaGVyZSBhcmUgYSBmZXcgZmFjdG9ycyB0aGF0IGNhbiBleGFjZXJiYXRlIHRoZSBpb2VuZA0K
PiA+ID4gY2hhaW4NCj4gPiA+IGxlbmd0aHMsIHNvIGl0IHdvdWxkIGJlIGhhbmR5IHRvIGhhdmUg
c29tZSBpZGVhIG9mIHdoYXQgaXMNCj4gPiA+IGFjdHVhbGx5DQo+ID4gPiB0cmlnZ2VyaW5nIHRo
aXMgYmVoYXZpb3VyLi4uDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IA0KPiA+ID4gRGF2
ZS4NCj4gPiANCj4gPiBXZSBoYXZlIGRpZmZlcmVudCByZXByb2R1Y2Vycy4gVGhlIGNvbW1vbiBm
ZWF0dXJlIGFwcGVhcnMgdG8gYmUgdGhlDQo+ID4gbmVlZCBmb3IgYSBkZWNlbnRseSBmYXN0IGJv
eCB3aXRoIGZhaXJseSBsYXJnZSBtZW1vcnkgKDEyOEdCIGluIG9uZQ0KPiA+IGNhc2UsIDQwMEdC
IGluIHRoZSBvdGhlcikuIEl0IGhhcyBiZWVuIHJlcHJvZHVjZWQgd2l0aCBIRHMsIFNTRHMNCj4g
PiBhbmQNCj4gPiBOVk1FIHN5c3RlbXMuDQo+ID4gDQo+ID4gT24gdGhlIDEyOEdCIGJveCwgd2Ug
aGFkIGl0IHNldCB1cCB3aXRoIDEwKyBkaXNrcyBpbiBhIEpCT0QNCj4gPiBjb25maWd1cmF0aW9u
IGFuZCB3ZXJlIHJ1bm5pbmcgdGhlIEFKQSBzeXN0ZW0gdGVzdHMuDQo+ID4gDQo+ID4gT24gdGhl
IDQwMEdCIGJveCwgd2Ugd2VyZSBqdXN0IHNlcmlhbGx5IGNyZWF0aW5nIGxhcmdlICg+IDZHQikN
Cj4gPiBmaWxlcw0KPiA+IHVzaW5nIGZpbyBhbmQgdGhhdCB3YXMgb2NjYXNpb25hbGx5IHRyaWdn
ZXJpbmcgdGhlIGlzc3VlLiBIb3dldmVyDQo+ID4gZG9pbmcNCj4gPiBhbiBzdHJhY2Ugb2YgdGhh
dCB3b3JrbG9hZCB0byBkaXNrIHJlcHJvZHVjZWQgdGhlIHByb2JsZW0gZmFzdGVyIDotDQo+ID4g
KS4NCj4gDQo+IE9rLCB0aGF0IG1hdGNoZXMgdXAgd2l0aCB0aGUgImxvdHMgb2YgbG9naWNhbGx5
IHNlcXVlbnRpYWwgZGlydHkNCj4gZGF0YSBvbiBhIHNpbmdsZSBpbm9kZSBpbiBjYWNoZSIgdmVj
dG9yIHRoYXQgaXMgcmVxdWlyZWQgdG8gY3JlYXRlDQo+IHJlYWxseSBsb25nIGJpbyBjaGFpbnMg
b24gaW5kaXZpZHVhbCBpb2VuZHMuDQo+IA0KPiBDYW4geW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cg
YW5kIHNlZSBpZiBhZGRyZXNzZXMgdGhlIGlzc3VlPw0KPiANCg0KVGhhdCBwYXRjaCBkb2VzIHNl
ZW0gdG8gZml4IHRoZSBzb2Z0IGxvY2t1cHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
