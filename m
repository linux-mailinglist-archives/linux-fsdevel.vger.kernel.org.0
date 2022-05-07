Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E80F51E5DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383812AbiEGJQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiEGJQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 05:16:08 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8D5710E;
        Sat,  7 May 2022 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651914742; x=1683450742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SqGvNp5MdWTugrpDJ3gPgMf3Lh8/trltJzYHMQtWHFY=;
  b=D+zKrLbX8LTLkHYr6+vAsgTzYK0bT4h79x2aoz+C60NT079wKCWIXzGf
   7+hAXlq7wzhJe+I6wlHk8Gv7S0ySJZRBhZWbYOIhflQspF9bnZ0zjKFIL
   VAYaD66IN52suIbYbbkgBBWq8OPy6ykxnXXFoNNwfo+rR2Y0wBy3cnWQ/
   UJVsuxBLNm630AApK2+yOaFNDKwIg+pwtPhNXYkfqTuBbW/dNBWdbc2NR
   Ae6NxIcWCPMCZ5kNd6FEt4d9dtDEP/O0POWN9rbQHuz5YZnI+MRm1KgcC
   w1uU8OY/idvY16rz230JtIZHh5KLnIjIkIiEQqfLxFS2SZBVTwOjJlb/p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="56561811"
X-IronPort-AV: E=Sophos;i="5.91,206,1647270000"; 
   d="scan'208";a="56561811"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 18:12:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr/jdGBlY2/z07BFDceOAU3BdQcWVqroYRlJ/r8FwYpwv0EOviu91E2rlISBVjxhGAi2yo63aTWsL1eUOH3OORXAoN6fENF/N0RdmefH7+/xqmXtQgErM/AG2tBif590NSY+dFPMPZMVFzdKqbn2mJiy2NmPmViHYaK9Je884orI7H0PICyfgNGfxzPLT3o+oTk/5LRE+sF79pp0DWfVtpb6pAzV0vKeHNNLz7HoONkMG6k87XUhO70243zQf5tO8S553qZHSnECu5j6AVoJDV8TwIEL15r0Qrss48UZXiNAsbcaetspyV1HSzm6LKk86J4FMJURGlPOoug9wvwvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqGvNp5MdWTugrpDJ3gPgMf3Lh8/trltJzYHMQtWHFY=;
 b=SDaWnImMmgAXJS+AvE2LtZNekilnCpKtKLRC8kH4U6UkYMdwobljfMnWWuDOuauB1by6kxX3h1ECsjalIieLWOr7jbfUNRUU5408L1qL3Vj3Lp1n8jdg0tp88EVPAN+0YCkZh3w05zmRMoLrBH8EU4DL6+5EevE2t+wZDQwn6w7ajmdKZgOWk6WBiQ+f8jm1pcMezq4SaSNmFwMn9SoPIm5Ars8fHJNpBGPDFNwVceDLv4EW0TYwTdxBZRejVwk8EX4ObidcFFkrlAB7wpFk0+mNIZmmEoNTld8PHsN0YLAerICw2IfiuXJH7dOj0q0b3WbQsPR1LwvG+hXQbrPVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqGvNp5MdWTugrpDJ3gPgMf3Lh8/trltJzYHMQtWHFY=;
 b=TC+sfWawQ2vMUKThQgCybyltH17CAGaw7wir/Kz0ZhkmDlNK10CeVmQxEMn3Rsgs6bY4HR4SLYvv7C95ZBBFygYq7s7C0m1veSt8eTiRNGw2PmBBXqXJHz1oP+FzvRGJNPxQeGIACEQqJ48ulf1Vxb9udwG2OGlxlRD3BRWytMA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6885.jpnprd01.prod.outlook.com (2603:1096:604:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Sat, 7 May
 2022 09:12:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5%7]) with mapi id 15.20.5227.021; Sat, 7 May 2022
 09:12:13 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Thread-Topic: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Thread-Index: AQHYTljA7n6MB3+pbU6sBga2TGnr2a0S2UaAgABpgICAABaUgA==
Date:   Sat, 7 May 2022 09:12:13 +0000
Message-ID: <62764629.5020005@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6275DAB9.5030700@fujitsu.com>
 <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
In-Reply-To: <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc7b4c99-ed11-4758-53e2-08da3009acca
x-ms-traffictypediagnostic: OS3PR01MB6885:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6885003AF43025BCB6B4F6BEFDC49@OS3PR01MB6885.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAiWJ1n/PC9A025QIeaH5iSrPUqRgbVC+AUYOA/uKs0V1Js1KXwHYxI1aVt8jbwvwxy3MOFdbHCAKtijxG6FdcyNEMaaDaasz7un9lKhtlz/wnE29EAi8jGxwicf9B2nLcXVG1F6ewTc5fArYZJ3RQEVNsQN5Xu6tbShJA77VR2dK5Cgar0ypjG2N68Pd/cHN09b480ArlNv6SXsCTZNJ0jQOQRLiZANWi0/0zmq2tPdz0/5h1kCqc912fPi1T3oRwSa9xwFM4XGuymgCZS1brWRsWAFLgkxrcmHoTp4QFrwIiOhsJ0w9IjYGJYvRE4ZtavZwESZv80na0redb8jSEL+uf48qKIP3mKQLov/ViQRQ/Jwl4VVNc6mA6DyHatKelzsVXxwGCHvSYaCPo3q+1ouceYg/jC9/QuKdYl4xKjT/Kdu7Mj5OXlkPX650+qvuz0K+R04ZREukMoVYDD3nspu+825ywvskK4Ci6KtMMA2tc0Zr85IlaA5iORNeJRnKRy1604ypIqswkJrc535w/vZta4iOSmgLFl5bPBVJs3vpghGx1NsvIgSWutpDfczTaqhqq2xOl7xYe9KYmGj+PQWcXD7HdSQjKc1YJr1oLrfJaVooBZCFqJBPGLxJnOg4pAiNivhKPmMB1mX/5fNyJM33U86jGotwFJYxuRoebD5E1UXVARtkWkSaNR2iXoJ+l8baHahdwRDzi/49XhoOTaBF8bZAKoM3lTM1rqqz7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(4326008)(8936002)(186003)(5660300002)(6486002)(38100700002)(8676002)(66476007)(91956017)(76116006)(508600001)(64756008)(66946007)(66556008)(82960400001)(2616005)(122000001)(71200400001)(2906002)(6506007)(85182001)(316002)(87266011)(54906003)(6916009)(26005)(6512007)(86362001)(36756003)(66446008)(83380400001)(62816006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dllhay9hVzVSVjBsUEptYnBzRVJ6RTNqc2VSRFR2R2xoNmRzQUxQVDZsL0ho?=
 =?utf-8?B?OGZlWkcxSXFwVmYrR28zdGVKSGJRd1VtaXQrMGNReVM2ZStFQ1BsZ2E4WGpq?=
 =?utf-8?B?UWFjN1h5N1YwYjRpV1dvb1lFdUlzVXNOdjk0bzlLeXpqU0pJYU43cEZmU0hI?=
 =?utf-8?B?OG1qc0I1S3RVbjBUQ0tER3B3RmZ3SHZVQ2JiVkpGd0poY2VzZVRQbjhTNXFu?=
 =?utf-8?B?Y21jc0VoS3ord0Ryb3A3a2xWam1sRk5YdzhPWnNVV2dibW9HZFp5V3BoWURY?=
 =?utf-8?B?QXVhK3EyRFV0dVdNcm5SdnZ4OURaOHdpejFlbkswcDFzd084Y2UwY3gweE5J?=
 =?utf-8?B?YVNyZW0wVkNHckpCREhQOURKb0c4MnM2Ykw1S01XdlF5Q0Y1M0NQSUFjWldz?=
 =?utf-8?B?MEhVcVZpendJVkw4SmN1eVMzdDhuUkxkenRrbmZCS1p0SGhHakVSY0paTjFR?=
 =?utf-8?B?S3dWQXIxTjgrUWI1RlhmOTk3NjVmaFNrbThubmc5RmhqNFNyaXMybHBIYzRa?=
 =?utf-8?B?c0FYSVRUN0x2SU9qUUVmWGw0UGgzWkU0WTFKMVV6d1FCaFozWEdmcjlqVHhZ?=
 =?utf-8?B?UUowVktFRkFjM3pxUlNUa1A3NmYzRVFWWC9rQi82OU5KOXVORURRbVJscDhp?=
 =?utf-8?B?aEhiU2Z6K1prcGdmYVd5dTh6cjNMNFFyY3F0VnpGQ3NMZHM2V0p3S1VON3Bx?=
 =?utf-8?B?VHV3QmhlWUcwVjRtcTBHM25YMG9CUjRyVzU0T05VQndXY1JGL2JvdUtmMFpZ?=
 =?utf-8?B?TWVPaWJHdExzV0M2cXYzczV0aFQ3ZVk3b3laQnhpeTFTdnhRQVVNbTAxK3BY?=
 =?utf-8?B?c00xQUp2Z2NiQVFoQ0pxeWhBa3dFbU5aYWtodU9IL3o2Y21zK01oSW1DcDhu?=
 =?utf-8?B?QnNtOTdiN1dDNkxSejk5ckY2WVU5TGoxTmdZVkttbE9mR1pNME9QZ25nWDlX?=
 =?utf-8?B?S2lqZG4xWlljV1BnckdNa21Ka1VvWGZEbEdwdXRsV2hKZmpDVGVibmNUUSt1?=
 =?utf-8?B?bndCZVhmYlBYQ1BRUlNDUWdUMktWTnl1eTQwMWJvRXdSUmo1bXNZUkxMOTJO?=
 =?utf-8?B?dEN6SEUra1RNQ0k4NmFiMWlzWFIxeVJMYUJ3Q0RRa3hhdUF0bkZKWkcyYXk3?=
 =?utf-8?B?S1lUdURmbEd1cUx6V3NNRXBMYzFZTkQ4SFRMM3l6RGw3LzJrWDBUVVM3c2gx?=
 =?utf-8?B?eGhIcWhiZXdhWWE3RFRmRVdrRlVJc0o3WGV4cXdwZ1Y2cUhtMDVoK3hsS3h1?=
 =?utf-8?B?YWpIcERmZTBTM0U4VzF3d0hQbzNaZzZyZ2Y2bWN4ZlVrdDAxR0dyRnhnTlRu?=
 =?utf-8?B?S1FCaTJxUkNDN3NXcjJ0eW13ekNudHcyZjJLVnFFNGZ4MXRkanlyMXlsT1NP?=
 =?utf-8?B?bSt3ZVFjaldkbk9ITFp6c25QNEMwMTdFM0ViTThpM2x3YnM1UzV1RSt5Rzlm?=
 =?utf-8?B?QXRWTTlHYUE2cHNST2FxYUcyRGRha09BN0kyNXNEbUQwR1VkRTgxTEZleVRX?=
 =?utf-8?B?TGg4eUZzV3BJbTFtQUFwMWF1QzZ1Nm5OYzBnem4rR1VHWXMzbmZhaGszL1FY?=
 =?utf-8?B?R1hwbm5xMDV6ejhRaHlBTlptNWJSNi9NY1ZaYkZUWUs4bTd2WnVuWkUycmp3?=
 =?utf-8?B?a25LekxZVDBtMnRGOGNTQTFPWElqMmxnK2x2ZEYrRk8vWmNkaldnUjBWVU0x?=
 =?utf-8?B?OE1KZWhyRUZVaWFaR0VnSFRrZVFsKzVWRkpxdTNJNXBQUjcrQUhPRXQxRUNp?=
 =?utf-8?B?NDM1MUg5Tlp6QnZhdk5TRHJPQnl2RXNJMGlXMk9RTW90cExOQ2h3Y0dXL0wr?=
 =?utf-8?B?dk9EcTl1N0htekpvdWM2YllwQ3BINkVhZFNVeWZ3dktDQ0crMDBRSjMxUWho?=
 =?utf-8?B?SGxoVmtKL2Jla2FlS2k3K0l3WFJwZkQ4QWdFSURJYnMwSXdkdG1nQUgwNW96?=
 =?utf-8?B?UUtlTzZ5TDVUYzFxYlhxL0NFUjRMd0RVUGRDbUNBV1ZRdjd4bFhVdFVudGRP?=
 =?utf-8?B?WVdUSGlEOXh2ZEw0TjcyN0F6MldoYUpOTjdsSmFhTlUwSE14N0hOYm94bm9O?=
 =?utf-8?B?cEZKbkx2NTV0OVpTMk8zYmtnMnZ0Z3VFSXlyRnBwWkd3bXFoS1M0WjhDRnhB?=
 =?utf-8?B?VUZDZE9WaWJtTFBURkpYK1ViRUNmb3JVMTc2bVlIZEoxUTVDYnhIdVdNME5K?=
 =?utf-8?B?aktMOGxkNGhTNWh5bDZCdkwvekx1M2ZManJjV21INHBqaWZNa0xqMnRVYm5h?=
 =?utf-8?B?Rzl1M2xBRjVRQTh4TXZNNEpoTmtCUUVIUkNMbEd1Y2ZVT1NWd2Y3Y2o5Z2RW?=
 =?utf-8?B?bHhRUWIyd2hJeklDQ2ZLVThieXRVVmVITExmajM2cmdwOG1iTHR4S0wrT1l0?=
 =?utf-8?Q?DijjJ8X6I+J0mIyWhwM2Pn2IS7SvGet+KckqU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05901519A6B7074E9118312813736A5B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7b4c99-ed11-4758-53e2-08da3009acca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 09:12:13.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a83/gkRslB9zoXvl+0UMGxD07zV9diQzX6S/F6EKd0HI+zrdT2WZUgRzGSa5/vTynwcP2hM0WggxqnWhJxXp1asLfzurbGovSpn1YBwdVMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6885
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi81LzcgMTY6NTIsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIFNhdCwgTWF5IDA3LCAy
MDIyIGF0IDAxOjMzOjMzQU0gKzAwMDAsIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gd3JvdGU6
DQo+PiBIaSBab3Jybw0KPj4NCj4+IFNpbmNlICBDaHJpc3RpYW4gZG9lc24ndCBzZW5kICBhIG5l
dyBwYXRjaHNldChmb3IgcmVuYW1lIGlkbWFwLW1vdW50KQ0KPj4gYmFzZWQgb24gbGFzdGVzdCB4
ZnN0ZXN0cywgc2hvdWxkIEkgc2VuZCBhIHY0IHBhdGNoIGZvciB0aGUgZm9sbG93aW5nDQo+PiBw
YXRjaGVzIHRvZGF5Pw0KPj4gImlkbWFwcGVkLW1vdW50czogUmVzZXQgZXJybm8gdG8gemVybyBh
ZnRlciBkZXRlY3QgZnNfYWxsb3dfaWRtYXAiDQo+PiAiIGlkbWFwcGVkLW1vdW50czogQWRkIG1r
bm9kYXQgb3BlcmF0aW9uIGluIHNldGdpZCB0ZXN0Ig0KPj4gImlkbWFwcGVkLW1vdW50czogQWRk
IG9wZW4gd2l0aCBPX1RNUEZJTEUgb3BlcmF0aW9uIGluIHNldGdpZCB0ZXN0Ig0KPj4NCj4+IFNv
IHlvdSBjYW4gbWVyZ2UgdGhlc2UgdGhyZWUgcGF0Y2hlcyBpZiB5b3UgcGxhbiB0byBhbm5vdW5j
ZSBhIG5ldw0KPj4geGZzdGVzdHMgdmVyc2lvbiBpbiB0aGlzIHdlZWtlbmQuDQo+Pg0KPj4gV2hh
dCBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/DQo+DQo+IFN1cmUsIHlvdSBjYW4gc2VuZCBWNCBvZiBw
YXRjaCAxLzUg772eIDMvNSAoYmFzZSBvbiBsYXRlc3QgZm9yLW5leHQgYnJhbmNoDQo+IHBsZWFz
ZSksIGFzIHRoZXkgaGF2ZSBiZWVuIHJldmlld2VkIGFuZCB0ZXN0ZWQuIENocmlzdGlhbidzIHBh
dGNoIChhYm91dA0KPiByZWZhY3RvciBpZG1hcHBlZCB0ZXN0aW5nKSBtaWdodCBuZWVkIG1vcmUg
cmV2aWV3LCBoZSBqdXN0IHNlbnQgaXQgb3V0IHRvDQo+IGdldCBzb21lIHJldmlldyBwb2ludHMg
SSB0aGluayAoY2MgQ2hyaXN0aWFuKS4NCj4NCj4gSWYgeW91J2QgbGlrZSB0byBjYXRjaCB1cCB0
aGUgcmVsZWFzZSBvZiB0aGlzIHdlZWtlbmQsIHBsZWFzZSBzZW5kIHlvdXINCj4gdjQgcGF0Y2gg
QVNBUC4gRHVlIHRvIEkgbmVlZCB0aW1lIHRvIGRvIHJlZ3Jlc3Npb24gdGVzdCBiZWZvcmUgcHVz
aGluZy4NCj4gSXQnbGwgd2FpdCBmb3IgbmV4dCB3ZWVrIGlmIHRvbyBsYXRlLg0KDQpPSy4gSSB3
aWxsIHNlbmQgdjQgcGF0Y2ggQVNBUCB0b2RheS4NCg0KPg0KPiBUaGFua3MsDQo+IFpvcnJvDQo+
DQo+Pg0KPj4gQmVzdCBSZWdhcmRzDQo+PiBZYW5nIFh1DQo+Pj4gSWYgd2UgcnVuIGNhc2Ugb24g
b2xkIGtlcm5lbCB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBtb3VudF9zZXRhdHRyIGFuZA0KPj4+IHRo
ZW4gZmFpbCBvbiBvdXIgb3duIGZ1bmN0aW9uIGJlZm9yZSBjYWxsIGlzX3NldGdpZC9pc19zZXR1
aWQgZnVuY3Rpb24NCj4+PiB0byByZXNldCBlcnJubywgcnVuX3Rlc3Qgd2lsbCBwcmludCAiRnVu
Y3Rpb24gbm90IGltcGxlbWVudCIgZXJyb3IuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBZYW5n
IFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgc3JjL2lkbWFw
cGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyB8IDIgKysNCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvc3JjL2lkbWFwcGVkLW1v
dW50cy9pZG1hcHBlZC1tb3VudHMuYyBiL3NyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91
bnRzLmMNCj4+PiBpbmRleCA0Y2Y2YzNiYi4uOGU2NDA1YzUgMTAwNjQ0DQo+Pj4gLS0tIGEvc3Jj
L2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4+ICsrKyBiL3NyYy9pZG1hcHBl
ZC1tb3VudHMvaWRtYXBwZWQtbW91bnRzLmMNCj4+PiBAQCAtMTQwNzAsNiArMTQwNzAsOCBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPj4+ICAgIAkJZGllKCJmYWlsZWQgdG8g
b3BlbiAlcyIsIHRfbW91bnRwb2ludF9zY3JhdGNoKTsNCj4+Pg0KPj4+ICAgIAl0X2ZzX2FsbG93
X2lkbWFwID0gZnNfYWxsb3dfaWRtYXAoKTsNCj4+PiArCS8qIGRvbid0IGNvcHkgRU5PU1lTIGVy
cm5vIHRvIGNoaWxkIHByb2Nlc3Mgb24gb2xkZXIga2VybmVsICovDQo+Pj4gKwllcnJubyA9IDA7
DQo+Pj4gICAgCWlmIChzdXBwb3J0ZWQpIHsNCj4+PiAgICAJCS8qDQo+Pj4gICAgCQkgKiBDYWxs
ZXIganVzdCB3YW50cyB0byBrbm93IHdoZXRoZXIgdGhlIGZpbGVzeXN0ZW0gd2UncmUgb24NCj4N
Cg==
