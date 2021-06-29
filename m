Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9FD3B6EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 09:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhF2HwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 03:52:01 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:13547 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhF2HwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624952975; x=1656488975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gbututhmmXu0XiA4nxF78NY8fi5m1RF+SLdydwwvXFk=;
  b=FD/w/9JBQ0zEj6Oh6AjNTIvawtKsrOKmTNPObjuWhSTY9wbYdcaaSpJ8
   Fy0qZfijWNui6sTYBfqZboyrguCV98mYeHl5C75onJn4gEP3K9usDhZft
   hQeP55NjpjuZbPqcw26dP5r1vu8rI9wq2vtNhwE2clqoxBxXeu/f2vIiw
   Vsrj5cilYXXtiodGpf61Wa+t3JMzY8ftYC26DYoeGu5x5GyD1KnDnNKxC
   9A0G94eXTT3mU31tUjP4Twas8Y5m0ZS5aY7/T5MdCAdlj6wm+tn/0k6MF
   9VDRoUBpgX9jysy9LkAwHcyVije8Xb7sLrvT7w/DjdvgHJ45ApPqNlxtz
   Q==;
IronPort-SDR: 9ZezAwZbVeAORJ6Qei2ZXxBw4SqY0ZhDJRZdVf8hWP6kcZEQuOQcrbz+bwZ1r9hAuope+kUDHl
 JbHSTtjlpLkrFp6kxlWG6Z9PU5KaRCw8UFXmItGQVucq9MUpqUsqYyJhVMj4p5I+RpQb8cK2js
 V4CJpLbcNiJSPtFWNvUtq3URs2yBX0UDIfxTdfbcxTxHeCvaIl0ZYHDIwlUT+/4J9TcLf6axEJ
 CXzQDaVCy69OFsUD94vxUcdTADcmMVbdA4HUq4sGZ2JgqFSp+oNbSUWeajN8NtjPTAs9yyjfbi
 +yo=
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="41911581"
X-IronPort-AV: E=Sophos;i="5.83,308,1616425200"; 
   d="scan'208";a="41911581"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 16:49:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ7L+Va6+rsFNfnKW1uOr2FBB2z2oTHthJqgBbksXKxnR77GTFbMJF3AJnRdhcVwnRYVlYPe2QGilbxsbdLKP3Cx8DfHxOc8M/9vCm+atZ4VoeUsfd9iF6tjScjns8JCk9y7Fv/kKWzsI/NG3kZ0yZhAKoX1gn7PpwG3tDVDqaZ/PVql8JlOYd26DFpWDbTcBPiH/8MyLYP+k04WSqyLOu+f2do7P8VnVWmh3k98BNrlkC5Nj3DcnLScZIxdpwkmHDRetMETCraLTzVGfyuVSVFA92V8YCkA60de65hjkN1SoOi10JlUG7TRXsEVpxt7umVX/MqrR3ZjiBl9X5GBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbututhmmXu0XiA4nxF78NY8fi5m1RF+SLdydwwvXFk=;
 b=QDnt2b33G3xmK45HiVPmURL+BHQD8yBL43WGbJynEQqM5VklpxL+adlMZioRlYWzPUXH9eKzpwNDOgptJsnc9YDhC7U1X49esb4l042nWqoHC5hKBPzQF09Yudfa+t8FIC6UqufSlb2GAdTUPYGZahNvW2AXbLQOegH91zdpfKOcZWC2Nf5odHE7EM57ZAh1iyExq+s9VltGSKd1vQrl6n82DWmQWx+kOcUaXDnkD5WPAk/fl7XIGJcEbwg0AZIxXiQdUN3gzcNEQDSg1t5hSB41JrdDAG4zGpB7pfj6GpbbZypl8KbYEbp5DqRJ30aA2kpVB6PXFmuPjBTuWCfSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbututhmmXu0XiA4nxF78NY8fi5m1RF+SLdydwwvXFk=;
 b=ilvjPFiNGYjLae45iDuc2GIz+RST7fKTNmoR2eVZgcINHbv1+9NaAsPMDeSlRB7ywNPlBMoYukg6SWGUzXjiV0HlUGGmUnF6ajELtofh111f+E+Q1V4csrv6Q6jcXHhXsaxp4xRzYVyp2G92cHnnJha5tI5jjklDneOWN5bdHsY=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB1640.jpnprd01.prod.outlook.com (2603:1096:603:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 07:49:25 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:49:24 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Topic: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Index: AQHXa7EmrHLpSGG2eEOWO38ftnVtTKspT/mAgAFCBXA=
Date:   Tue, 29 Jun 2021 07:49:24 +0000
Message-ID: <OSBPR01MB292012F7C264076E9AA645C3F4029@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
 <20210628000218.387833-6-ruansy.fnst@fujitsu.com>
 <YNm3VeeWuI0m4Vcx@casper.infradead.org>
In-Reply-To: <YNm3VeeWuI0m4Vcx@casper.infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 745b76d0-9bf2-40df-b028-08d93ad26a42
x-ms-traffictypediagnostic: OSBPR01MB1640:
x-microsoft-antispam-prvs: <OSBPR01MB164009921EE90C9565C9FEC0F4029@OSBPR01MB1640.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NGk8+wcYfzubbACPAWze6Dtv1Rb86b2Th0qnBGyiWDJ3+P+OjmIQAI/RNYtEB7ipHm/hyYhucz16Visv9tQGL5SMRDdviydfq8Y9j32Yx0fGV3j6ApyUz4X3mPTTW7LkJnGFO0PIU0eJ7RgL0pFwctzixORoB5uMM5HZ2jdkdm4z76EPYiSANTUSwQx9D7OC0u5cXuv18TIMCpOiNOeWxJDi831OyNVE6zXRfutr2PfEtaWKe/BTeMiJpp0QEMndfeZqvSqzAPERAuTs6lwEmI5R8CuetaZoY7YQfEhNwmhLHjbZYVv8qN9IQB5v3ZWKueLV+xIPGX71RikHaZ0aVVx8hfgFDBQB6+xatSiMrUtaHVtDDyKE7IEvh2o0gk9ylKnyVU0yrXR3rKWivxbhNmW9FrE11iIYcy4HTN0ATP7yOmLE2nFfIyHpULijIiwfZKyl81ZVp3h2gOe6g7c6/u1a9jma2hDWbNe7m6Pudc6aSeKzDwKuFWR2QhqHzS3AAjkkvKHPzv3r6LVLJqX1CL4phln9hxLFwHkAK9EyXOqUfFg5asXza099oRTGLvuV4ey+AHAi4yhuJ74ZvUhkQ4mxnF6MGfy9lyWjg1auQT6wicRqMv+q/R1TTLI/uTci2VT0jKBybSquje2vWyTtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(33656002)(6506007)(54906003)(316002)(5660300002)(26005)(6916009)(83380400001)(186003)(85182001)(122000001)(52536014)(66446008)(7696005)(66946007)(71200400001)(66556008)(64756008)(66476007)(55016002)(2906002)(86362001)(9686003)(478600001)(8676002)(4326008)(76116006)(38100700002)(8936002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0xlSXdaOVBGM0QzOXVzREczOFhCWWdseVE5MzYrdTNrMFlrQ2I4QWkzQ1dC?=
 =?gb2312?B?TDNIam1RVzNVWHIvWFpCK0Q5cVV4cEowa2dYVjNHTG44OE5DTnZ0d1V5S3ZM?=
 =?gb2312?B?SWFNekU0b09CR3pSNlhzRmhKR1B6MkJUN1MwSXlzNzVFOEVYR0J0M05WRDJT?=
 =?gb2312?B?MmtER3o5SDBmU0ptRWF0MEZHN3RqaG9nUUdMbmJVYng3WFBCN1lRdWxXbUQ2?=
 =?gb2312?B?TWp4VktlRkVmL3lCem5mbG1uNm5kVEgzWVpzSzRGU0NBanlyWHA2Q2dsUWs0?=
 =?gb2312?B?V3RkVnJlTU9PTjVzVFoyNy9mUUJyeUc2SXpnMnpKamtMWlJUWEpLMXlaS2tO?=
 =?gb2312?B?ajhnUFhiNUdTR1ZtaE4yT1g0OXc4R3dTay9Gcmd2cXVFUkMvVGhnZDVGaFd0?=
 =?gb2312?B?eWtDQ2htZ2dWRmwreVNXbTBhK2daOUVnVTZiR0p1WDNlVm5nd0JZbjF5QlQx?=
 =?gb2312?B?eHRNSFZZSElONUVMOWl6bjlMNjR5SjR6R0xLTFFPeFp2YVE4R2h0NXpqOE9X?=
 =?gb2312?B?emZ4dXBoYXltdjJCUHZXRGRnaG9HdEFRSWZlVDBlcEtaOUUyanZyZ2E1ckxr?=
 =?gb2312?B?aEhYYzhHOFJPSy9ZRmtoOTdrVUJZaVNLd1QrQzg3MFl6K3pKdmNYKzZlNWVm?=
 =?gb2312?B?Ry96S2t1OGNZL01vRmN0RmJtUWNyLzRWMEtCUndkTG1mRUFYYjFEeFNUYTdo?=
 =?gb2312?B?b1dlanQ0RjVycHk3V204VzJFbzZTOElNc0MwdTkxNUxaNTByNzJzeDQxNllq?=
 =?gb2312?B?Z0JDREs1VmU0Zkp0Rk5qL3lMdFZTdUQ4RTg3MWc2WHNJbUllUWZwYWxJdGF1?=
 =?gb2312?B?ZW9TYWlGZFF4eGI3SExZOUlSdnNoVnJFTTUxQkdQWW9GR3JkRkVja3FIVkN5?=
 =?gb2312?B?V3hQT3BrcWVHT0hYazZwTSt4WTBBeXBBNzYvelRsdTRCbmVsUFdWWlhvMFZp?=
 =?gb2312?B?M29Bb3p3SENLVlU0cUlDdllqVmVLOS8wSWo5cllicWkzUEp2bHJSa3FYMHZs?=
 =?gb2312?B?Wk5PYnRxaXZ5cklxSnd6Z1RJU0ZNOHA4L0ViVmtTL3NHNXZ5MFhmU2hlNFRO?=
 =?gb2312?B?VnFVamEzZDhsU3ZNeURKT2ZZWW1CQVJLV3BTK3VXbnd0cjRlRC9mTnkvRDdR?=
 =?gb2312?B?c1B6cUxKQ2FjYkVqR1BVNlA5YW96emhHSUordzhmZmlCWFJmR0dIN3FjQktU?=
 =?gb2312?B?Mnljdm8zQ2JaN1lxb05hdnR3YllRTmg2cFRLR2ZQRmcyK2gwMFA3aUJzKytC?=
 =?gb2312?B?YVZqRVgyMU91emRLVTMwbmJvUnFudVdsYXhKM0U0bHlsLzdnd0xwZi9yK2NI?=
 =?gb2312?B?V0VVb1o1WGEyZkY0SWpMUVpTR1RVZXVNelVlZjBCNXdVNzhidFVRRGdBQTNj?=
 =?gb2312?B?WW0xUlZqUk01dTVtWVYyV1plbVdyTThORGtuLzkwTXM4SnNUeVR2N2JCS0t5?=
 =?gb2312?B?Nmx2TVhQK2NaVmZSVmlBWFkvc2lUT0U3UlZ2QjZwNEZHUys5M2NUaFlrd3E2?=
 =?gb2312?B?S2UxREFMSFlJMFBBMmE1d0pTY0xnemZPbDBTMmlqNUVUR2wvZUJjbzAxMCt3?=
 =?gb2312?B?WlRLSGpkclBkTHB3ZnBNUmhVWFRCMDgrNGZ6YVdxNktjZ2YvVU16RnY0WUxR?=
 =?gb2312?B?Nk5INlhrbElkM3pLN0FweXVPRy9qN1hVMHhkZ3VHRTN6U1V5ak1tZ0FWU1ds?=
 =?gb2312?B?ckYyOVhBZHdVSlZtRkh1aE1Pd3VUTTdXakFiSGRtUmZEL1dBc1hWZnhWalQz?=
 =?gb2312?Q?XvqPbtE6NyVL1vofi1mtM3rBdsL0SDAdm3El/aM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745b76d0-9bf2-40df-b028-08d93ad26a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 07:49:24.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ze499s5y02PyM2AZlb3Le/sYwzLrlzeDQ1HsmmTLNQXiXwoGMKr8s+RPR6QHS2GK20x267NmkiChwfzjmSAnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1640
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hdHRoZXcgV2lsY294IDx3
aWxseUBpbmZyYWRlYWQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDUvOV0gbW06IElu
dHJvZHVjZSBtZl9kYXhfa2lsbF9wcm9jcygpIGZvciBmc2RheCBjYXNlDQo+IA0KPiBPbiBNb24s
IEp1biAyOCwgMjAyMSBhdCAwODowMjoxNEFNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+
ID4gKy8qDQo+ID4gKyAqIGRheF9sb2FkX3BmbiAtIExvYWQgcGZuIG9mIHRoZSBEQVggZW50cnkg
Y29ycmVzcG9uZGluZyB0byBhIHBhZ2UNCj4gPiArICogQG1hcHBpbmc6CVRoZSBmaWxlIHdob3Nl
IGVudHJ5IHdlIHdhbnQgdG8gbG9hZA0KPiA+ICsgKiBAaW5kZXg6CW9mZnNldCB3aGVyZSB0aGUg
REFYIGVudHJ5IGxvY2F0ZWQgaW4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOglwZm4gbnVtYmVy
IG9mIHRoZSBEQVggZW50cnkNCj4gPiArICovDQo+IA0KPiBUaGlzIGlzIGFuIGV4dGVybmFsbHkg
dmlzaWJsZSBmdW5jdGlvbjsgd2h5IG5vdCBhZGQgdGhlIHNlY29uZCAnKicgYW5kIG1ha2UgdGhp
cw0KPiBrZXJuZWwtZG9jPw0KDQpJJ2xsIGZpeCB0aGlzIGFuZCBhZGQga2VybmVsLWRvYy4NCg0K
PiANCj4gPiArdW5zaWduZWQgbG9uZyBkYXhfbG9hZF9wZm4oc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsIHVuc2lnbmVkDQo+ID4gK2xvbmcgaW5kZXgpIHsNCj4gPiArCVhBX1NUQVRFKHhh
cywgJm1hcHBpbmctPmlfcGFnZXMsIGluZGV4KTsNCj4gPiArCXZvaWQgKmVudHJ5Ow0KPiA+ICsJ
dW5zaWduZWQgbG9uZyBwZm47DQo+ID4gKw0KPiA+ICsJeGFzX2xvY2tfaXJxKCZ4YXMpOw0KPiA+
ICsJZW50cnkgPSB4YXNfbG9hZCgmeGFzKTsNCj4gPiArCXBmbiA9IGRheF90b19wZm4oZW50cnkp
Ow0KPiA+ICsJeGFzX3VubG9ja19pcnEoJnhhcyk7DQo+IA0KPiBXaHkgZG8geW91IG5lZWQgdGhl
IGlfcGFnZXMgbG9jayB0byBkbyB0aGlzPyAgaXMgdGhlIHJjdV9yZWFkX2xvY2soKSBpbnN1ZmZp
Y2llbnQ/DQoNCkkgd2FzIG1pc3VzaW5nIHRoZXNlIGxvY2tzLCBub3QgdmVyeSBmaWxtaWVyIHdp
dGggdGhlbS4uLg0KDQpTbywgSSB0aGluayBJIHNob3VsZCBsZWFybiBmcm9tIGRheF9sb2NrX3Bh
Z2UoKTogcmN1X3JlYWRfbG9jaygpLCB4YXNfbG9hZCgmeGFzLCBpbmRleCksIGFuZCB0aGVuIHdh
aXRfZW50cnlfdW5sb2NrZWQoKSwgZmluYWxseSBnZXQgYW4gdW5sb2NrZWQgZW50cnksIHRyYW5z
bGF0ZSB0byBQRk4gYW5kIHJldHVybi4NCg0KPiBGb3IgdGhhdCBtYXR0ZXIsIHdoeSB1c2UgdGhl
IHhhcyBmdW5jdGlvbnM/ICBXaHkgbm90DQo+IHNpbXBseToNCj4gDQo+IAl2b2lkICplbnRyeSA9
IHhhX2xvYWQoJm1hcHBpbmctPmlfcGFnZXMsIGluZGV4KTsNCj4gCXJldHVybiBkYXhfdG9fcGZu
KGVudHJ5KTsNCj4gDQo+IExvb2tpbmcgYXQgaXQgbW9yZSB0aG91Z2gsIGhvdyBkbyB5b3Uga25v
dyB0aGlzIGlzIGEgUEZOIGVudHJ5Pw0KPiBJdCBjb3VsZCBiZSBsb2NrZWQsIGZvciBleGFtcGxl
LiAgT3IgdGhlIHplcm8gcGFnZSwgb3IgZW1wdHkuDQoNClllcywgSSBkaWRuJ3QgdGFrZSB0aGVz
ZSBpbiBjb25zaWRlcmF0aW9uLiAgSWYgdGhpcyBmaWxlIGhhc24ndCBiZWVuIG1tYXBwZWQgYW5k
IGFjY2Vzc2VkLCBJIGNhbid0IGdldCBpdHMgUEZOIHJpZ2h0bHkuDQoNCj4gDQo+IEJ1dCBJIHRo
aW5rIHRoaXMgaXMgdW5uZWNlc3Nhcnk7IHdoeSBub3QganVzdCBwYXNzIHRoZSBQRk4gaW50byBt
Zl9kYXhfa2lsbF9wcm9jcz8NCg0KQmVjYXVzZSB0aGUgbWZfZGF4X2tpbGxfcHJvY3MoKSBpcyBj
YWxsZWQgaW4gZmlsZXN5c3RlbSByZWNvdmVyeSBmdW5jdGlvbiwgd2hpY2ggaXMgYXQgdGhlIGVu
ZCBvZiB0aGUgUk1BUCByb3V0aW5lLiAgQW5kIHRoZSBQRk4gaGFzIGJlZW4gdHJhbnNsYXRlZCB0
byBkaXNrIG9mZnNldCBpbiBwbWVtIGRyaXZlciBpbiBvcmRlciB0byBkbyBSTUFQIHNlYXJjaCBp
biBmaWxlc3lzdGVtLiAgU28sIGlmIHdlIGhhdmUgdG8gcGFzcyBpdCwgZXZlcnkgZnVuY3Rpb24g
aW4gdGhpcyByb3V0aW5lIG5lZWRzIHRvIGFkZCBhbiBhcmd1bWVudCBmb3IgdGhpcyBQRk4uICBJ
IHdhcyBob3BpbmcgSSBjYW4gYXZvaWQgcGFzc2luZyBQRk4gdGhyb3VnaCB0aGUgd2hvbGUgc3Rh
Y2sgd2l0aCB0aGUgaGVscCBvZiB0aGlzIGRheF9sb2FkX3BmbigpLg0KDQpTbywgYmFzZWQgb24g
dGhlIGFib3ZlLCBpZiBhIGZpbGUgaGFzbid0IGJlZW4gbW1hcHBlZCBhbmQgYWNjZXNzZWQsIHdl
IGNhbid0IGdldCB0aGUgcmlnaHQgUEZOIG51bWJlciwgd2hpY2ggYWxzbyBtZWFucyBubyBwcm9j
ZXNzIGlzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIFBGTi4gIFRoZW4gd2UgZG9uJ3QgaGF2ZSB0byBr
aWxsIGFueSBwcm9jZXNzIGFueSBtb3JlLiAgSnVzdCByZXR1cm4gd2l0aCBhbiBlcnJvciBjb2Rl
LiAgbWZfZGF4X2tpbGxfcG9yY2VzcygpIGNhbiBhbHNvIHJldHVybiBpbW1lZGlhdGVseS4gIEhv
dyBkbyB5b3UgdGhpbms/DQoNCg0KLS0NClRoYW5rcywNClJ1YW4uDQoNCg==
