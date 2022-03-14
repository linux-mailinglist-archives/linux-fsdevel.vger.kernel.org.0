Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D64D7C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 08:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiCNHl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCNHl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:41:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7240E72;
        Mon, 14 Mar 2022 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647243648; x=1678779648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fBX/t2oikz4UgBkbzXr5iRjX/1vZ65vECMGRW58M0CE=;
  b=oqQpHeTMQAbCAfbyIsi8NpKXIAVCVdzEfFXrti4ozPYs0OX1RC537Ntn
   3mQC3CSFmm2SaHvscRCB0rm4cDlvcTidnWSpkUWxgI71qSQdfRfHaLRjy
   sGu1S5OH2tc+8wwFIAeY2J3iwemQNxsddDbIeLwOSMTMpK+02U8xHjzTX
   zKNoY2OYO9Vp8SmPaa19Ay+efD8k5pV83LDW4Sv5NOoiEv65XO/Xw1JPD
   XPmsKQJJvByy68ZzFcq8r/8w9jnjzbs7gk6TgbdSD2weRFvq0WhYFo2Hd
   nrb8kaSklRHR4spR1nLfQGkcSGKHKZTgdggSPsbqapNEfCnoDlSuAO6Vw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="194204651"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 15:40:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W394CvidTpzgxprW9JG01A65udHUFWVaO1WKTJWV9D6xi0a2/dQCI/bjwYNcssZQm2rzFhiGKGIaHioIZy8VoVVbhJnPK1OaYxjwFU05RqTNOF4cQ8iw6nT3OLhnYyGZyu2YiVMnmX2USPfrrfKyfXE0OaMP1dIPyWYHRakzdOpfhGWqOPlOthei4DI2qvUgBhNPc/NA/AZloA7zrRqUVXyEgb61BbXzSyztBxWrtNnpt9OpKz7l+ld9Yd8SNUliH7Vpg/xyOGqUopC93GF6yBMe3t4VVVu4yBu4cOOQy91UDxQcaFejwfM3T8Jn9ab6Lh5wW7KqdNXCt0JsmoHqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBX/t2oikz4UgBkbzXr5iRjX/1vZ65vECMGRW58M0CE=;
 b=Ze4z1aIIWRYFqJq7h6vgtLllMC2sYvcyJxIhXTgWBeLJh7aKnYqDCeDXtj0njRf/xLJ3i4y5R3eTIMgnJP2LYvu6Y78iooS3jndTcxQwQdDoFXNtWT+aFQWk0w5p93RzM4g4JAQLvsv707H7rLhS35DdJOz0u58W/l76mR2j3ia1Un3R6UMw/pEtT27ofLrRUIrFAvHZ73VC8k6lmL4i06FqZA8Bjn/eQtJ/5xZxqz+0q3TFfen8/8Am4dTFapc3GIkxRBTcqNdEDz5sFpy+Anr7wHkHmCTbiGBQxxQBobmvzxxl4gswuTmnnZyewyds0UmDi56v8os3tAmH9234wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBX/t2oikz4UgBkbzXr5iRjX/1vZ65vECMGRW58M0CE=;
 b=h7t8jJMSkhcgz6qQc1mhFg4WDU+HQVKrUxsuXxBY6xC1d2fraPZyYF285ZD9aUjYJg9EFdCdPuwuZ5zxVhUGgU5AlkGjkSz5oAVAKxshzmDa1Cnu5vUBnygnGVKTEY/UdIp/Ku8yBzL0rnVyIs1iOAOxdv74mNue+bqynVtWjSw=
Received: from SN6PR04MB3872.namprd04.prod.outlook.com (2603:10b6:805:50::31)
 by SN6PR04MB4304.namprd04.prod.outlook.com (2603:10b6:805:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 07:40:42 +0000
Received: from SN6PR04MB3872.namprd04.prod.outlook.com
 ([fe80::1b:7d93:4b79:4898]) by SN6PR04MB3872.namprd04.prod.outlook.com
 ([fe80::1b:7d93:4b79:4898%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:40:42 +0000
From:   Avi Shchislowski <Avi.Shchislowski@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM212Z9iQWtQ9nE29yElpvaJJrqy4fs0AgAALUQCAAHQXToAABrkAgAArovyAATdHAIAAJKuAgAP5+gA=
Date:   Mon, 14 Mar 2022 07:40:42 +0000
Message-ID: <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
In-Reply-To: <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8313e84f-fac3-4b92-f545-08da058df15a
x-ms-traffictypediagnostic: SN6PR04MB4304:EE_
x-microsoft-antispam-prvs: <SN6PR04MB43047D42BA6A106FC93675439A0F9@SN6PR04MB4304.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LI5r7XAlXB3wK5DTnARUDE18uUctwoW2PsObJ/pR+EtskKTetLomScodQrPY9kAA7ED7Cg6EbH1M+oSEKVZMQ+X+7BmbjMiIaxgiLoE+aS1tvo4UnlAPmLgtccq29D30ySd0Dza6Tcz6H99usNdzr0FlAwsXxC7wy+dHutre271a9Yb7/b2+T9skBz+2YJwVdk/QGHNHAoCHgbzeQnDkqBN8DVFC0gDZ+rKl47iJU9iR2sQiLKCB9h3t35tWB2DgdJ0L/ldlAly7kc6+3apffuqwqQdDmYuZgc9cZyC0OjwSU1wLga5b0Gh6/+V0JL9J8twjz49e2pvOeZYEggcyJqFy8Ksv6WY9AWfMTEFCw2wGxndV9NIWYZrkrmD+x2MJRxtu3TzIOPGnRIUrTut5+hKr0mQaZlXyegIfmp/yEBNliEAZM6k2D/FkAWoYU1nRH6o15PMlDYgleRDO6E3gEseukhIZTkyOpzL4sSNDTJawS1iVBBgRvyG60ZgvtaxePxBLHSb05NjdlMGzsbcNHqHDcQrUM6IAQE0Su4ZGTr4tPMwOpwaQS1sFNNJZ0mDN5GvbjNTIV86LXyAy2JKCXlaCrUI8xlRee3hZ4+s1iFe6+fTWvefOzp1NXA1OUlvDE56x9mpdVEsmFYqjdRKc3HMgzJAXZBD4r+2JN0k4yTMONA43zJJDMcBs/hMABa2f3HJEJ2wb83mS7Gtm5DODPkSmhA4Vjvaz+rFPm5dT58OXI6ranujQurIf0d6LRPToNqW9c+6p+2TgB68jcjcCEw824IWHfCCYRWMugjzIaI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB3872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(966005)(5660300002)(71200400001)(33656002)(4326008)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(52536014)(508600001)(7416002)(8936002)(55016003)(186003)(86362001)(26005)(83380400001)(38070700005)(2906002)(6506007)(7696005)(9686003)(82960400001)(122000001)(38100700002)(316002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFXYXhxdzhQRFYwUjRzN3BlTmxQWE9PWXI0NWx4RU5SL0k0aE5JY1RDUFQ2?=
 =?utf-8?B?Y3VJdklad3BROG5oOW5abHlxcXU0ZGFHWnc1N0JnL0hxOW9xS3J4Ymo5cjhB?=
 =?utf-8?B?YVFrNkdYK242d3pOY010dEg2VXBxdjd1WFZhUFpvRTc0VkFJUHVwaGphUERQ?=
 =?utf-8?B?cExyclZ2LzlDZDhJZTRUS2g1YXNuUmlCekk4WG1ER3k3RG5sY2lDSE5VbjFL?=
 =?utf-8?B?UnE1eFY1ditKeDlSMGNwNDZhbTI3Z2N2NURWTGlwQU9iN1N1L2lWTWRYVHBR?=
 =?utf-8?B?YUUrc3FXT2IrSVZJWkdvVjNKUzZUZkRhOVhwVDhqbEhPS2pUNkUwdXN5YzYw?=
 =?utf-8?B?eWF3c1hKQkUwRFdSeVRkYy8ySEZjekMrcU15YitYOUNpVy84OHR0TEpxcW1l?=
 =?utf-8?B?Vkd5T09GRXZsL0pCSTRjUzUwS1ROOXFGRHNiMVNCcW5iNWgwV2NiWkM3bHNy?=
 =?utf-8?B?bEdlOHlxTHFZRW5MQjIzQ2U5bnpRT0JndHBLblUzRlJvMCtMZDNyLzlzWngz?=
 =?utf-8?B?R2M1NjhqWmxoRlBtNlBST21aNEFBUkcvWXI4Uzl3czhqSGgxNnRSYWp2dmlH?=
 =?utf-8?B?NmhsWG44R2JSTnA0S3dLY1k4SWp5Y01pZ0txTy93VndOZ1VFdWg0eTRobkxT?=
 =?utf-8?B?WmxSbjhWRkVSb1FHaUwwS0pRZDVvMEZDc2dpdmtxM0ZXL05qRGh1ZDJpY1o0?=
 =?utf-8?B?Rm4rdUdFZ1NhRWgvREtHaVVBK2ZTbDVpVUNqVndrK09yaGl2YllEd21GanA4?=
 =?utf-8?B?QVpDN3ZOMlFWckZpTTdlK3k3VHpaR0tCV3VRUnpVekgvcEN3cVQ4OXBKUC81?=
 =?utf-8?B?Vkt1UmI5Z2NQamI3eFpmS29FUmJ2ZTdOZ084bFcyb1h1QXJSMlAvMzJGeW1j?=
 =?utf-8?B?azZoR1N4aFdzcWs2Y21hRWtPVHJON2habmdYaFRQa2NFYU0rSnpYUENLakpD?=
 =?utf-8?B?dWt6N2FPU0hxM2RZYWd1TGh4MnBFeUMxUC9rYmdhbFJFY3pTcTdId1VXa0d5?=
 =?utf-8?B?VWNrTlMyY085MWxobElBMmJQampkWUNSNklEaGVuVVZidVNibFV0OE9FeHJE?=
 =?utf-8?B?d0syZTY5cEZwYTdoQ2ozc0lkVmd3d1JCa1RXc0ZKRGcyTFNhYm14OGI1SGlN?=
 =?utf-8?B?SDBQZm9DNlo5c1NhZFBDMDNYNzBCZmJHbklVQWJkV2RaU1RpSDI3K2lmWGJL?=
 =?utf-8?B?aGt3TjFSRzg5RDZ0U2RRODY0TDYyeGNPdHpHRldTWlZxMXNUZDJwM2NVcHlU?=
 =?utf-8?B?bk9EMjAvSEpZUkQ0ZEptOFFIL1VYUUViTlIvU21Vd0Y2R1JIN054ZHhhSk5H?=
 =?utf-8?B?bm16cWdpQmw0SUNzdTJNRExvbzBiSklOeGZSbCt3YzM1WUNZQTkxajB5N045?=
 =?utf-8?B?UERzM0Nkcnova0p6Tnk5U1MvZUx3TlVhK0gvVU9Rc0NzLzFhV0R2clA4SFFx?=
 =?utf-8?B?d2h2bjJpVmFzc3V6di8yS1FvQ1RCRjJoaEV3NjFVSktSV2V3S250M1NjVk1Z?=
 =?utf-8?B?ZnhYZnFWYjk2Ykw2aEdUYWMxYStUREpWWDZxdmR0ZWtLZ2J1QU9rNHdEaWFH?=
 =?utf-8?B?dkthV1ArU1FsUjQweVFCeWxBZmE2RHpWSFpqRHZyUGZwdnBMNnp6V0I4ZmRS?=
 =?utf-8?B?S21aU1pLaG5rK2NEckluOTRMTnhrVHkzZmkzd0IyK1R2RFltSVNsSlhaeUtW?=
 =?utf-8?B?RWJndzhOamhWOFUvL2hjYU9RUHVsYlVyblZjbWFFTGk5RmlUVUJOblBJeEoy?=
 =?utf-8?B?V3hCTWYrT3F6aWxvM2dBM1JzVHp3ODJ0ZUhzaXE0b0taZVQ0MGpsWXp2M2Q0?=
 =?utf-8?B?OTJSZkI5VGMvOGV3NDB1THJnU0tDUmkxWHlUSGF3cVVwVGc3UjN3TURualhO?=
 =?utf-8?B?aWdmQm9KMVN3cXRzRVArT25wT2RIdUdYSkg0T21PVXNHb1I3SjU4a1ViWGRs?=
 =?utf-8?Q?meUPhtAh+HPeWt+z3eyuBh3nCnyDhcE/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8313e84f-fac3-4b92-f545-08da058df15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 07:40:42.1956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/Nl4ACy8IKYr2e6vbTB91BOU1wFn4dXu9IuHQ1IpKHCxILxTP+759tmlW69HP2V88cetsAdMZIJh65XLWlW7UDpen+VJhBYOeb+l+Kvzik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4304
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+DQo+ID4gSGkgSmVucywNCj4gPg0KPiA+IFRoZSAidXBzdHJlYW0gZmlyc3QiIHBvbGljeSBh
cHBsaWVzIHRvIHRoZSBBbmRyb2lkIGtlcm5lbCAoc2VlIGFsc28NCj4gPiBodHRwczovL2Fyc3Rl
Y2huaWNhLmNvbS9nYWRnZXRzLzIwMjEvMDkvYW5kcm9pZC10by10YWtlLWFuLXVwc3RyZWFtLQ0K
PiBmaXJzdC1kZXZlbG9wbWVudC1tb2RlbC1mb3ItdGhlLWxpbnV4LWtlcm5lbC8pLg0KPiA+IElm
IGFueW9uZSByZXF1ZXN0cyBpbmNsdXNpb24gaW4gdGhlIEFuZHJvaWQga2VybmVsIHRyZWUgb2Yg
YSBwYXRjaA0KPiA+IHRoYXQgaXMgbm90IHVwc3RyZWFtLCB0aGF0IHJlcXVlc3QgaXMgcmVqZWN0
ZWQgdW5sZXNzIGEgdmVyeSBzdHJvbmcNCj4gPiByZWFzb24gY2FuIGJlIHByb3ZpZGVkIHdoeSBp
dCBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhlIEFuZHJvaWQga2VybmVsDQo+ID4gb25seSBpbnN0
ZWFkIG9mIGJlaW5nIHNlbnQgdXBzdHJlYW0uIEl0IGlzIG5vdCBjbGVhciB0byBtZSB3aHkgdGhl
DQo+ID4gcGF0Y2ggQmVhbiBtZW50aW9uZWQgaXMgbm90IHVwc3RyZWFtIG5vciBpbiB0aGUgdXBz
dHJlYW0gQW5kcm9pZA0KPiA+IGtlcm5lbCB0cmVlLg0KPiA+DQo+ID4gRnJvbSBhIFVGUyB2ZW5k
b3IgSSByZWNlaXZlZCB0aGUgZmVlZGJhY2sgdGhhdCB0aGUgRjJGUyB3cml0ZSBoaW50DQo+ID4g
aW5mb3JtYXRpb24gaGVscHMgdG8gcmVkdWNlIHdyaXRlIGFtcGxpZmljYXRpb24gc2lnbmlmaWNh
bnRseS4gSWYgdGhlDQo+ID4gd3JpdGUgaGludCBpbmZvcm1hdGlvbiBpcyByZXRhaW5lZCBpbiB0
aGUgdXBzdHJlYW0ga2VybmVsIEkgY2FuIGhlbHANCj4gPiB3aXRoIG1ha2luZyBzdXJlIHRoYXQg
dGhlIFVGUyBwYXRjaCBtZW50aW9uZWQgYWJvdmUgaXMgaW50ZWdyYXRlZCBpbg0KPiA+IHRoZSB1
cHN0cmVhbSBMaW51eCBrZXJuZWwuDQo+IA0KPiBJJ20gcmVhbGx5IG5vdCB0aGF0IGludGVyZXN0
ZWQgYXQgdGhpcyBwb2ludCwgYW5kIEkgZG9uJ3Qgd2FudCB0byBnYXRlIHJlbW92YWwgb3INCj4g
aW5jbHVzaW9uIG9mIGNvZGUgb24gc29tZSBwb3RlbnRpYWwgZnV0dXJlIGV2ZW50IHRoYXQgbWF5
IG5ldmVyIGhhcHBlbi4NCj4gDQo+IFRoYXQgZG9lc24ndCBtZWFuIHRoYXQgdGhlIHdvcmsgYW5k
IHByb2Nlc3MgY2FuJ3QgY29udGludWUgb24gdGhlIEFuZHJvaWQNCj4gZnJvbnQsIHRoZSBvbmx5
IGRpZmZlcmVuY2UgaXMgd2hhdCB0aGUgYmFzZWxpbmUga2VybmVsIGxvb2tzIGxpa2UgZm9yIHRo
ZQ0KPiBzdWJtaXR0ZWQgcGF0Y2hzZXQuDQo+IA0KPiBIZW5jZSBJIGRvIHRoaW5rIHdlIHNob3Vs
ZCBnbyBhaGVhZCBhcyBwbGFubmVkLCBhbmQgdGhlbiB3ZSdsbCBqdXN0IHJldmlzaXQNCj4gdGhl
IHRvcGljIGlmL3doZW4gc29tZSBhY3R1YWwgY29kZSBjb21lcyB1cC4NCj4gDQpXZSBhbHNvIHN1
cHBvcnRzIFNhbXN1bmcgJiBNaWNyb24gYXBwcm9hY2ggYW5kIHNvcnJ5IHRvIHNlZSB0aGF0IHRo
aXMgZnVuY3Rpb25hbGl0eQ0KaGFzIGJlZW4gcmVtb3ZlZC4NCg0KQ2hlZXJzLA0KQXZpDQo+IC0t
DQo+IEplbnMgQXhib2UNCj4gDQoNCg==
