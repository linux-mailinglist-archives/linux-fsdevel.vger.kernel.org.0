Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA050EE0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 03:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiDZBZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 21:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDZBZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:25:33 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB90939A5;
        Mon, 25 Apr 2022 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650936147; x=1682472147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xnSdHEaqkQeRanD4F8cR4DHCLskyLlv9HAdItk4KMuU=;
  b=gCUaW3n4vpWOefDmVvO0BhHVRBnmBof7ny/skjxGY44wQnjPga1gO+iL
   iPeM2FzrBhGdr0w8z6ZK0UXzuobOtjimX/Mp+gLzBDYmAucPAxQ26U/KI
   4uOJplT1L1EAFrG/6iAUxGOb80ruWFlP7VRy6Yve8ypJutoTjjV5XpqTC
   cTNrVmkg2ZDQn+8+qlcxmDeTAHE5Q+vJU+6I552ILhxY1OiDMWZLQnewy
   SGCPHT7Pht1ONm54ZahxniS0PrlK59XPj0WoJdFWwkje/EIqTzLGR4C8t
   7mz8PV4SXZ6FuiGJoxADWgiNigXj4JmJTXeIU0Q2eu0pcgyXkPXwtRQ96
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="54470394"
X-IronPort-AV: E=Sophos;i="5.90,289,1643641200"; 
   d="scan'208,217";a="54470394"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:22:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMlb6ObX9rg7e2Q9vC30mW7VS3T2gk1LCBFFs2WM1CJjpR1ZoXyW32J2e2tjXBmvWHQr6JrAUwXsFrdHOgko/QO3LJPV60ZP3sCWqvH9QjjPLRbRGZiPPc5Nk2n0BIUiQXOibS19n4z7L11GHyWGu8QkoDaajKDsTuMRQjew8iP6gWQK2+hvsovM9VR2FwBopkxiTSaKtuUdyCL42igUzk6f41+0+f6hYq+P+aR9yaCwKY5dO0LIEc8Yw253YBldBQ4pqs/EzKwFvnyI5lhc2sH5/xWqBcE3xs/p8kjCOnmILLMJPq6D7tw1a4iSsCV9p1T/9iKVkZtRgAEcUMpmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnSdHEaqkQeRanD4F8cR4DHCLskyLlv9HAdItk4KMuU=;
 b=jzKzD52AQDEw9DgEzmqMwpEi+EMX+tpvIyu71J4fKbRhVe7pTu78XPP8Yh4eFMnrtYV+YJpsEmDY2LHLep5id0w9PbuYeGOKsrGVnarqu+DGXZd+47X97g6ie2jKZBTOOeEhroAwbX7SF+VXboak/Xym1Obit5dFjjZlunNkeOW/2lYpXKiB06WAYLQzDrXqRJVQ9af1t3Blve+qdZvDfuWf0bCjuyQHik8IBmz0E9IMNzAHAJJyMneVDI3qGSWYKke3giECX1qt+5PfwRuwcfxsXjUuRdIOrUvz92rnLCdwmo4VuyPjsUj/pEPqtHSCb0BW1qu5joHpnHPJGz8Mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnSdHEaqkQeRanD4F8cR4DHCLskyLlv9HAdItk4KMuU=;
 b=d+294ulh/attf1FrQ8Jzw2bp1DHm6naCRJsh+N3WGgpkdXuE8UZfMnxwWpVdKn9w57tC0bArnO3SSGLxfUIRxDDEBKISqPhyzcKIJShzqx+YIL6L+qXdaqlFohljlV8gL5jTy76O5WjypKDuFvpxgja3DsQXIhzzK0LFoElWnZw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3079.jpnprd01.prod.outlook.com (2603:1096:604:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 01:22:19 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 01:22:19 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYWElmndJywNP+LUaiiBtBnwHkL6z/7IeAgAAXkICAAHrfgIAAZb2AgACUCgA=
Date:   Tue, 26 Apr 2022 01:22:19 +0000
Message-ID: <626757B2.70002@fujitsu.com>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YmYLVfZC3h8l7XY1@casper.infradead.org> <62661F19.3020805@fujitsu.com>
 <20220425112947.higk7uawxkcdcjgj@wittgenstein>
 <Ymbbg3XbN17l3Jir@casper.infradead.org>
In-Reply-To: <Ymbbg3XbN17l3Jir@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfc9d891-1a69-4c19-abdb-08da27233535
x-ms-traffictypediagnostic: OSBPR01MB3079:EE_
x-microsoft-antispam-prvs: <OSBPR01MB30790A7044B956D17D06898BFDFB9@OSBPR01MB3079.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4X9RzInvSCWlh3nygoPsDXQ/9duwemIsymdq/5aWr68a33CAEj3olTKHBVRWhjl/ZLWijSgLFz1w3WEBF1n/CtKidwacJ4rU0io+Kwa1iodaOhRlxHE2IPhXbZsqCu1viHC0qjQpQ/kaGe01m6eQUh3T4TP56nPfc3dV70yVOFrZTCknmpYuPFHA/hLvFgJ7B0yiyDr1qQMetYjlNK2ZUokq/1HMDi0ruLPc5VY961ja1He+nFRRvGqJy2ApkfyS/TEpbTc/e4EogKTcbCqWjHpAIIQO3L0raAo25spiajijE/5zqDp2icPJupZNGyW1kmzN4xOIConzMASYLm6A2BNXTDU7W6ijhytHJ2QrwLjdGrtfdSOpJnitcv4Ax9WpHWBCxBDNlKgMUtIjBFI/DnUFJAewz44pb8C78+U5G6DZZvHgp9BCbaodmq5Xu+xjsvzVf8PbTlMZIkFN4X48ALSVFAN8zV1h/IqJrIPNIogZ+EIE6yg9yvDe0I+p/faESrjmbloVxHbXc2+6fRGRifLbTD2iJH0sdmRlLqSeYvH1/OIQxY65X6x3z7H4dDqqeKCfFfXCQteJcCTXzdpZkILSzKc1L2N+2ApUvKJUjESfTCwm1n6MzVmPrgteNMhjpiERSNHrtyp0CmHsalH6Bx8AFBELPEhDDUzv85ayJ0u8Rly5dcO1Kcx1OXlFm+IYtyTU+7FFhGEx6THf6uEcPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(2616005)(186003)(6506007)(83380400001)(82960400001)(2906002)(6916009)(316002)(54906003)(33656002)(36756003)(86362001)(6486002)(508600001)(85182001)(91956017)(5660300002)(76116006)(71200400001)(26005)(4326008)(122000001)(8936002)(38100700002)(38070700005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SGdLbVJ4QzY5ZFk1Si9aZXpvTjdBaVBMK2s5ajBlS3UxS0dHU1cycjlQV2lu?=
 =?gb2312?B?dzJBK24vRXJNUVV5TEFiWjNtcFJMQTlPeDJML1VNbEFJRXhUYVUrT1FmUkhz?=
 =?gb2312?B?Tm5aaTJad1VENVpLTzJianlxUmxUU2wyQkcvQ3NSdFdxdk02amlldnUyQjdz?=
 =?gb2312?B?cFNtblFEODV0cHlaNEtNK2NXRTZmbHFsa0dvdmlkejZzbC9xTmV4NHlrUXhz?=
 =?gb2312?B?Skdjc3pJSk1mNjBJditkOHZWVXB1dVV1TnJxTlpPV0xDUllFbnVqRTRYSVZy?=
 =?gb2312?B?QitISGZVNzlDaTFNQmh0MFE5bFZRMmtoLzJuMkR2c0I2MVN4TjhBODJ1enNq?=
 =?gb2312?B?TjRtdWovRENmZzNMUlBPQzNCTDN3OXcraFhra1YxVVlJd0ZwbXBSOS9zalFa?=
 =?gb2312?B?WHlQRjYvVHdXc1RGV3V2OThKbUFYZE5kbGtsSVlCTSt5a282TWVmQ1BUUllD?=
 =?gb2312?B?YUFNaGFYVXhXRDdtTnZrSnJKZkxQdmJ5dmN6SzFBMjdVLzZpdCtFM1JOY204?=
 =?gb2312?B?aWpPUGRKbUgxU1hrYllBU05XZWNiK0J5ckFTajNwdFh6dnJueUc3L1kycFhP?=
 =?gb2312?B?RmsxUWV5bGxuSjhUVFZyRXhLdGJzQ0FCZjJSQjZ2cXltamg5VFQrRHo2Zk0w?=
 =?gb2312?B?MXp4L01zTXVKRVo2UFROVVFnTk9nOWVISjFrTlBld3FJSHp2RWEzSi9IRHBq?=
 =?gb2312?B?a2VFZWl5V2Q4YXdHVGNJSmJaZ1JlRERuZnhSY3FKMW1GMFRGV2Q5NjZFSkxB?=
 =?gb2312?B?MFJhOHlBTzNySFNVaWRNRXFjS1MzbVNqZkRqK05Ham9rRDhFZDJEOERDZEpo?=
 =?gb2312?B?VjNFTkhXbGlSS2Y5cVFRcDZsbGVQV050V3RWQnJVdENrOUpZYmlmRVREa3lG?=
 =?gb2312?B?SU9ZT0hjcmtsYk5RYllYSnNkY0FieVY4aCtNTDl2TGxWUkFadHhEVHovY0VT?=
 =?gb2312?B?TENJWTdtTFNVM0plVlRHWnNqbjArSVFMajVFODVOV2hwVW1vSlIwL21KOTJm?=
 =?gb2312?B?SmlGTEJ3SG5CUWVjeTVsY0NpTGpFWmx3c2o4bk1ETzVCVktJa09nSkY3VklV?=
 =?gb2312?B?UGhHR1kwaEtQKzc3VTJlR040bnhqeEVoaDhtWEZsRmt4TDQxWkgybU1pZE84?=
 =?gb2312?B?aWdBanBDMzg4SlNrUDhCMXNRWnhYeDVMQWVqUVA5bUR1S2tKWUpqZEI5MjNy?=
 =?gb2312?B?ckIzRzgwVzZsRG9EVFQ5NWRRYTVldWVMRCsxazVZbUZsdVd6Q2JWL2c4T3BF?=
 =?gb2312?B?dlQ3TEdJdXZuUHRMWU56OTI1bEJEY2d6WEpFVXFPd2w1a2FoTUdFeit4YTVT?=
 =?gb2312?B?SW5QeVhCb09BdnRRU2cyWUV4UHJwL1BSZXlJN3NTL2lVVG44MWdSakdtK2xK?=
 =?gb2312?B?ZE5DM00xU1FZWlZTMDRCK3o3VGJxMXNIMEswdEVxRC9qYi82NzVzeEhPOHh3?=
 =?gb2312?B?Wjg2b0dIclVxazJEREl1MmYwU2ZHek1KOVN1VmdHU05zWFM5NzZjQnhOUzVi?=
 =?gb2312?B?cjhyaUkwN1VtWGo2YU82c29sZm1waDJhL05wbXRUWitNRkJVMW1JRnAxY2Vm?=
 =?gb2312?B?azRLRWZpNnRVR2hhN0NHMkhPRm0za0RQLzBNWFdPbFMzTXBsdTVuNWZHd0Fo?=
 =?gb2312?B?c2M1RWR6cVo5RVZGNVl0K2M2RmVmcncvc3BWNHBmdW1HNVlOdXpmVDNldVZw?=
 =?gb2312?B?TTRNUjF4VVpsMC9CQnFrK09QdGVmTCt3RjdtbUN6cjlPWTg0RWw4OUZCZE9i?=
 =?gb2312?B?cGRxK2kxdUo5d0FVdXo0dGhWaWg2aGs0VURiZkRVRVdGY2hFOHJtUjZoYUJ2?=
 =?gb2312?B?My8raTZ1aFB3Y2tlTU1ZUkNCbFJSbmZ2K3o0WURxR0YySDZwUHZseFRyT3Fv?=
 =?gb2312?B?NkVGUEF5UnlJZ3lGWHpBaXYwUmJrODJhYVRieW5TbU5wS2F4VHRYS2I1dFZh?=
 =?gb2312?B?bFZmQjhMVDRydUJjWFdkM2RWWnpFdXdMdGU4cythUWN6OXJ2SnBzdndOOFdt?=
 =?gb2312?B?eUhaUE11ZG9yL2N5UEhvWHVkemkzZUN1SFFZMDE3T0JwS1BtL2NmWHFZNEx0?=
 =?gb2312?B?eUpHK29MSEphVHpRKzBjdWhBTmZRYzVJNkVacXdaTzhlcE10RHpSNDYzTXZh?=
 =?gb2312?B?TTJnOGZETHQrQ0xkVUpLU3hac2FGNXFROU5Ba1NMbVZCemdZZ3U3ZXNQVW5R?=
 =?gb2312?B?eFYzZ2V3Vlc1cVdwcStGNHpHZDVLYU14SGlGYzlYaUtMSThHTlRDZzRjamR2?=
 =?gb2312?B?d2dpQVNNREZWSjk1YmYwQXJXWHpxaFRXRmV4a2FxUnZPbVNOUmxYOVVnS1Nk?=
 =?gb2312?B?K085Yno0Z2x5TUlhdEVCOGJlaVBVclZPYWVsZ0tac2JiazY3RkcrdXRiMi9U?=
 =?gb2312?Q?pMmusuy0ixwx8ZqOphr2nTXJDctQfuAP1o6It?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <63C4279288F710488956CA1D8ED7AFB1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc9d891-1a69-4c19-abdb-08da27233535
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 01:22:19.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhB36hs1L2/CcMmLPFYE69JCP4Iw/ZtjqvFfXGD9HixLcSaqUDl9hD+n1w+drjxu3OzgEFV4amrgFEcSwWDGUUIjj+sl1iDIOwKfYOaOiVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3079
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDE6MzMsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBNb24sIEFwciAy
NSwgMjAyMiBhdCAwMToyOTo0N1BNICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4+
IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDAzOjA4OjM2QU0gKzAwMDAsIHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20gd3JvdGU6DQo+Pj4gb24gMjAyMi80LzI1IDEwOjQ1LCBNYXR0aGV3IFdpbGNv
eCB3cm90ZToNCj4+Pj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6MDk6MzhBTSArMDgwMCwg
WWFuZyBYdSB3cm90ZToNCj4+Pj4+IFRoaXMgaGFzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0
IGNyZWF0ZSBhbmQgZXhwb3J0IGlub2RlX3NnaWRfc3RyaXANCj4+Pj4+IGFwaSBmb3IgdGhlIHN1
YnNlcXVlbnQgcGF0Y2guIFRoaXMgZnVuY3Rpb24gaXMgdXNlZCB0byBzdHJpcCBpbm9kZSdzDQo+
Pj4+PiBTX0lTR0lEIG1vZGUgd2hlbiBpbml0IGEgbmV3IGlub2RlLg0KPj4+Pg0KPj4+PiBXaHkg
d291bGQgeW91IGNhbGwgdGhpcyBpbm9kZV9zZ2lkX3N0cmlwKCkgaW5zdGVhZCBvZg0KPj4+PiBp
bm9kZV9zdHJpcF9zZ2lkKCk/DQo+Pj4NCj4+PiBCZWNhdXNlIEkgdHJlYXRlZCAiaW5vZGUgc2dp
ZChpbm9kZSdzIHNnaWQpIiBhcyBhIHdob2xlLg0KPj4+DQo+Pj4gaW5vZGVfc3RyaXBfc2dpZCBz
b3VuZHMgYWxzbyBvaywgYnV0IG5vdyBzZWVtcyBzdHJpcF9pbm9kZV9zZ2lkIHNlZW0NCj4+PiBt
b3JlIGNsZWFyIGJlY2F1c2Ugd2Ugc3RyaXAgaW5vZGUgc2dpZCBkZXBlbmQgb24gbm90IG9ubHkg
aW5vZGUncw0KPj4+IGNvbmRpdGlvbiBidXQgYWxzbyBkZXBlbmQgb24gcGFyZW50IGRpcmVjdG9y
eSdzIGNvbmRpdGlvbi4NCj4+Pg0KPj4+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXM/DQo+
Pj4NCj4+PiBwczogSSBjYW4gYWNlZXB0IHRoZSBhYm92ZSBzZXZlcmFsIHdheSwgc28gaWYgeW91
IGluc2lzdCwgSSBjYW4gY2hhbmdlDQo+Pj4gaXQgdG8gaW5vZGVfc3RyaXBfc2dpZC4NCj4+DQo+
PiBJIGFncmVlIHdpdGggV2lsbHkuIEkgdGhpbmsgaW5vZGVfc3RyaXBfc2dpZCgpIGlzIGJldHRl
ci4gSXQnbGwgYmUgaW4NCj4+IGdvb2QgY29tcGFueSBhczxvYmplY3Q+Xzx2ZXJiPl88d2hhdD8+
ICBpcyBwcmV0dHkgY29tbW9uOg0KPj4NCj4+IGlub2RlX3VwZGF0ZV9hdGltZSgpDQo+PiBpbm9k
ZV9pbml0X29uY2UoKQ0KPj4gaW5vZGVfaW5pdF9vd25lcigpDQo+PiBpbm9kZV9pbml0X2Vhcmx5
KCkNCj4+IGlub2RlX2FkZF9scnUoKQ0KPj4gaW5vZGVfbmVlZHNfc3luYygpDQo+PiBpbm9kZV9z
ZXRfZmxhZ3MoKQ0KPj4NCj4+IE1heWJlIG1vZGVfcmVtb3ZlX3NnaWQoKSBpcyBldmVuIGJldHRl
ciBiZWNhdXNlIGl0IG1ha2VzIGl0IGNsZWFyIHRoYXQNCj4+IHRoZSBjaGFuZ2UgaGFwcGVucyB0
byBAbW9kZSBhbmQgbm90IEBkaXIuIEJ1dCBJJ20gZmluZSB3aXRoDQo+PiBpbm9kZV9zdHJpcF9z
Z2lkKCkgb3IgaW5vZGVfcmVtb3ZlX3NnaWQoKSB0b28uDQo+DQo+IE9oISAgWWVzLCBtb2RlX3N0
cmlwX3NnaWQoKSBpcyBiZXR0ZXIuICBXZSdyZSBvcGVyYXRpbmcgb24gdGhlIG1vZGUsDQo+IG5v
dCB0aGUgaW5vZGUuDQoNCk9LLCBJIHdpbGwgdXNlIG1vZGVfc3RyaXBfc2dpZCgpLg0KDQo=
