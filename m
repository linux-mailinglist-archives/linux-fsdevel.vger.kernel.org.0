Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB850F7C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbiDZJGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiDZJFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:05:15 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B0FAD82;
        Tue, 26 Apr 2022 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650962648; x=1682498648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t95jc1bceFloO5fEH1oFsytGCunnmxJmuFCsZ6q0Dxw=;
  b=dsUY0hb1NoEqSwKiqrdKkeZOnXCCo0ZepTohZclnX1igz0u0N3c/T7FC
   wYsS08OfHaEy3o+9Mmr1JBh9dzh+EeJKoUwZNA+vd/alra52qEFssCnhu
   LVk2ls3g4aywECqxUQWh5AuwN5idW3IJZAs1luqGMhrJXxNTG+HIocTFf
   TdXF6SRkFroha6Sd4qdDT5GPHGXyX4++VhaaecgDdpzUQKsaNnM/XQ6bk
   IirbrZ3w+azrxgdRxWae7Dbw2vyh7bUnpLe0CWRakNeqmE3esP2WeaUek
   Z7MgthWYDbPvgFEaNWCXTizI1aIiCayVUpa3fwsj3XAih5C4P2WkpqAIn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="54509685"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="54509685"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:44:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW+6UrJ4J/ciyuR4xq2LDIYMN5tv6O0snCACjqEeKWAmzK2g9QHCO2SUTmpzIDb7XWsKlqLZmjocayB8i+Wrx5M1xVwzh5eb7JmfzFPyLJsdYewJC10Iutiq88JT7fsgyVtYJMwm2hdak2IdBf3bBsyrGwVt9oxT2i64Ijw5fxv82YQCk4cpjF1TCAc87lCDlSORHDz595vl2runlTmXWGvYcdJ30wzw7Efe7zmMneBBamrKz3TDMOMEUmbKAz7QG8xDxp8pdPSEQXs0vLI/g3H0dCA1g6vAw5Si39lU2kpmzkGMtZlFA3XaPNKEmWZEnjZL3+Lo65yxme4VJdXf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t95jc1bceFloO5fEH1oFsytGCunnmxJmuFCsZ6q0Dxw=;
 b=FDN9+foKGLO3//ev4YkjyvXg4IGzBXKaIzwuNIE1WDXSlurX3T9agLNdiWsaAwy10wPemSmJlbrFb9RmheQqwpKJnc3Z9Tg6Xmp0C5gGReV9ca01qzgiluIfmuJjkbilX9Nu1zKR729FY1VEb4it64Vaec5YKwR+m0CrM1HcpaO2iVoPX3LevvM/Q2bwx6TdlyRy8l4Fa6pjm0KTIVK3cGLqZYVKx1CPbm0B057qRszorEwyrNrPpUAvp8hoe47JItXiLNJC7NCGS8WoOrkRH4jVtkD1hHZh2v3Ozh5PmNWsJcXFR8QaBIhDr6WDZ5rqi57q04aiodxxbN+37McswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t95jc1bceFloO5fEH1oFsytGCunnmxJmuFCsZ6q0Dxw=;
 b=W12wtT/Oj2ysdbAtfZJeyq1edfq8kQ9jVxM6Oe/fDUz+8PdoOuvgm+a6kRTDTfXp+vVM3l4mN5UaiZTQpHgp7lt9DvvdzL+vR8g2TK1K+JymOIBe/Cm0nZlnG5FJ4ZW6he9+9vYQeUTSCQ/426qMK0jMwXO/iZrfMJWDBV3HrD8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB2543.jpnprd01.prod.outlook.com (2603:1096:404:7f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 08:44:00 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:44:00 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v7 4/4] ceph: Remove S_ISGID stripping code in
 ceph_finish_async_create
Thread-Topic: [PATCH v7 4/4] ceph: Remove S_ISGID stripping code in
 ceph_finish_async_create
Thread-Index: AQHYWRx3JYMYTHu+i0eywY61JZ2MMa0ByD2AgAAqNgA=
Date:   Tue, 26 Apr 2022 08:43:59 +0000
Message-ID: <6267BF2E.70504@fujitsu.com>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650946792-9545-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426071413.75mgcayybdb3cwgw@wittgenstein>
In-Reply-To: <20220426071413.75mgcayybdb3cwgw@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63e42a81-11aa-4433-df50-08da2760e8ac
x-ms-traffictypediagnostic: TYAPR01MB2543:EE_
x-microsoft-antispam-prvs: <TYAPR01MB254338EC64A092D69D903661FDFB9@TYAPR01MB2543.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5xXviBcrnAER3ta+HMpUdnEpqY4bV0FawGeo/FbnQsYHJwLpr5SpTDxiCn+yjvTikqEb0hH2QGQJQjIr72zmqdUbCgrR0ltYEDd92L5iQO+AEXNwWRK5GU/HsnlowkZ6SYHeFxwY1cTuqAggw2KRZkn6M7HIkSIa0e9YLAL/BaGMQNhF5tmLl86o70cAYYKlgcdgAvuCb5eurF+AQCPqS1Zs6GTseiCA5xeOUvcixN4/q6WZ2ISOxymemEsgisDd8TVOKJWFa8lgrp6Y6i+3Wwvdeyeo8NDwO1fIOTCNKvVTfrP/UVPeWjvm8uZr8Zrg6nSvokS7HGoB/c0bZzuKdakFywwIq3fenFd6mUc44zvpSp9Tn6nyxHylxRa93ya1J3/Wk+bqkyAreyNvtCxvX2/kKbqTPSqTglzR4T2OO979xASr+vbgBgWBK//VFLM6npHtR24VJoro4jTXW/E35TXp+ykLvOS25rfWxo8ZIRcqVY4AHMY4KB1fxiUHr6R+oMcoG8BZYo5DE4nfqtSBrELei59hmMXgUq/zIjzSq39xJPeeJ44+cg8Hp33QbFAOAnUomnxUuwrbtFG8QbVSrOgMj8KnE9SNRO+8CqsmF20A4AQ79addGdNg+rJ2Dbyt60iQFghFrsjIRuWfDIrwaW8rn8KfbLfGbg8JcspOJy+6ntmli7yFI4tT2rYLMKMK5dw+TA8UEOaMO9oFPWIaZg8/Ru9g4zMZcvTuZp1Vno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(508600001)(5660300002)(8936002)(85182001)(36756003)(6486002)(316002)(83380400001)(2616005)(6916009)(45080400002)(38070700005)(38100700002)(122000001)(64756008)(66946007)(54906003)(66556008)(66476007)(33656002)(2906002)(82960400001)(91956017)(76116006)(66446008)(86362001)(26005)(71200400001)(6506007)(8676002)(6512007)(4326008)(168613001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdGd2ZiT3RQNmhmMStUSjZEeUZqRWwrcWFMWEtCREV3TkdaT3ZOeHJiWG9O?=
 =?utf-8?B?YzBrTTVtazFyQWNiV2FHdm4rdFVlRitJYURUU3RwcCt6TE5hN0JFMTVVRXRs?=
 =?utf-8?B?WXZhNXozVEh0cjlDZGxCbnpQbHFVQUxoRWk5WDZWdEZmWFFoNU1RTUM4N21M?=
 =?utf-8?B?dHlkWTdYUExJK3EzcVV1aWd4TmY5SmdxYVU2cEVqWGRWWXdPTURXcGVmdEhy?=
 =?utf-8?B?UHc3VUFrNmRBZVdhbHJYZzQyZ3h5R21XWStSOFJRM0xTOE1mM080TStuR0JF?=
 =?utf-8?B?aDVkRGhCNTVONWFrNnM4SmoydHpBN3lqZ01kSGg0NDZ0cHJsYzk2NGZtOFp1?=
 =?utf-8?B?ck1JcGRWN28vNkhzWDRrcTRXbUwvcGI3Tk9Hc2F5TURYRXdRRUFTWk1rN2dE?=
 =?utf-8?B?SHFncFdzWkJtR000ZG1FL2RYdG45bEpUb2REMG9EZTdrNm9kS0pZYTBqMCtI?=
 =?utf-8?B?cWZ0TDNFK3pESTNLaEM5SXJLSDVOd3d5aGZqRHNXSlUybEdIblRhWFVaVjdE?=
 =?utf-8?B?TWtHTFpTUkQwMUF5N1VETWprR1VjdVJjVmdGVHRJdTJwM0RFWTdzQnFTcEVv?=
 =?utf-8?B?UGgwdFZ4MEdka25iZGpCRzJNZksva3JoSzl6QzBtdmt3eG1ZaEVHbjE1WFBF?=
 =?utf-8?B?V2lOdWNHU2pXVFVyUzV1Uitrc2phRXREenVlcEIrUGl0RlpiZXZabUNjOVhj?=
 =?utf-8?B?RmorNDN6UUEyMFpJYkNUYUlKK0pTVHgrUUpZcUwzd0JjQ012Z2VhTlJEa0Zy?=
 =?utf-8?B?alAwZEswTklsU25rNElDVzZnK1JMZVZOc0pCcGJCSnBQRVoxZ1lVdzM1eXFo?=
 =?utf-8?B?L2trSkRSVnoyZCtZeWpTTmpKb21RMHplVTRPdTlac0pSZEhhWmZDbGFvOTBN?=
 =?utf-8?B?T2VSYU9oZTBqTWFxK3dCUmRRWGlYeE13MjYrV3BYcVYxNGFEUDdPc0xab0VT?=
 =?utf-8?B?VUVOaVpSWkJoWThXcUo2WWMydWczS1FBL29JenZvN25pNks1ZWVZVXdDa2E0?=
 =?utf-8?B?WnEwNHc4YlRGTWpIL1ZwbEF1ME04TEpmTzZzMVMvY2s4amtHZUdNZ2poN3Rw?=
 =?utf-8?B?c0NtUks1TUprRS9SNmdlSTBzYURPdE90MHI2cDQzYVhUV1p1dXRIRE1ET21F?=
 =?utf-8?B?NFJ3TC9ZWE5qeThLZkJQd3BxeEtucmtUemtMU2lNcGJlNGE5Q04zWTh3Ylpy?=
 =?utf-8?B?clYweXErRWJoOGFMUVpXZFNuODBRL3hQOFNBM3paM2RpQ3J0ZVFkYk03U3Vm?=
 =?utf-8?B?VGlDUlNQMXh5SUkvZ3lLbmlwM0tudWI1UG5oenNEUFNXUFFaQkF1M2ZCa1J2?=
 =?utf-8?B?MEJybHN3bTMxT3NXYXUwWXM2Zm5BUWNMWGp0dEU1Vy9Ic2JWbVFWVTJSbUJQ?=
 =?utf-8?B?V1c2UllpQ0llaThzNWVEWHhiRnpYb2lSMzAxa1dkcUdjSFptOWk0alp2NUcz?=
 =?utf-8?B?Ym5OUTBJK21hL1l5UjNiNnRkM1l2RDZ5ZmNoSjJHaXc0blpqRVVtVjg4aTV4?=
 =?utf-8?B?YXZ6QkNTdXR3K0JJMWIvZHQyUksvY2xSTHUvWnBDbmhtSmNtby9KTXQ0L091?=
 =?utf-8?B?VnBTSG9adFlxNk9mZ3ZpOGFFdjBRbTFvdnBmTndxSDlXNUh5RlZod1R3Zk5i?=
 =?utf-8?B?Z1pLUDB5WXg0YUJXZGwzTkNid3BCRzducFAzMEpjSlM5amU1U09nTWo3ZE1l?=
 =?utf-8?B?MnhtenEwQ0xONXRTeVRCWnhrWFNCd1pSZTdNNTBZMUcwYTU1eVBpNzlSYm4r?=
 =?utf-8?B?bTVCT1RvUkczeWU4VnN6dGgzbGdRRFo1MFNlb0txek5INDhaZVhMMUZEalBu?=
 =?utf-8?B?QlVKbFVBaVBVZlJzTTdidDRVQlBNNWhMZElIWEdJak9nSWtGSjg1TXNQbFAw?=
 =?utf-8?B?dDNoTnBndE9zQUNaM1pvai9CRmpId05aRDVFdStEKzdzZjRHSFA2T2U0Y1JY?=
 =?utf-8?B?bFhYeFRISEhvRldYdVBVdEpWVGllQ2JFTmg4QjdVeGkyY1JqK01JUkJVNnpk?=
 =?utf-8?B?USt5NzNMY1pVSGpCVnlJTEdhM25VTWlFY3AzRlZ1ZWwrZjBSK0JiMVQ2OC9R?=
 =?utf-8?B?elFMWkNhM24ydTdFam44cEVFSUt4M0RTbDUvTHlyYUI4dVJORk1iYVlWR2tq?=
 =?utf-8?B?Wk03RU5oalVxT1NQelJzdDN6Zi9kc0NjUGxMRHlORUZudWNyTGpEUld1cU1I?=
 =?utf-8?B?NmZKNkF3MmZIVVJTekpXcFVCaENIR2ZucjR6WHRZUitNZVJrUzZxTVQ2b0xY?=
 =?utf-8?B?VzVzNktmY2NONUltWmFBanQ5SFhTcVByOS9aRWVDWGlyMTR1NktvNU5mSVlh?=
 =?utf-8?B?bnhpVm1paGF1RFJlYVNNd1BORXdSb1ZqSjJTby96eGRFT0RoNDQzVXFNSm4x?=
 =?utf-8?Q?4+Tbg/iWP01nvIc5zecX7FF79FjHB6jeAZBnR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF2F14146E887419C770F199FD265F9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e42a81-11aa-4433-df50-08da2760e8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 08:44:00.0177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v93P38/u6ntFx552dFy9UjTDbNiAXZu+wlcUC0GWmKLqPPRAS68tmPLj5zUqY+pGs9W33wNjf40+aKS3pCK+ZLgBlDR4NBfRRX/LAwQ6sG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2543
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDE1OjE0LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMTI6MTk6NTJQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFByZXZp
b3VzIHBhdGNoZXMgbW92ZWQgc2dpZCBzdHJpcHBpbmcgZXhjbHVzaXZlbHkgaW50byB0aGUgdmZz
LiBTbw0KPj4gbWFudWFsIHNnaWQgc3RyaXBwaW5nIGJ5IHRoZSBmaWxlc3lzdGVtIGlzbid0IG5l
ZWRlZCBhbnltb3JlLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBYaXVibyBMaTx4aXVibGlAcmVkaGF0
LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoTWljcm9zb2Z0KTxicmF1
bmVyQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4NCj4gU2luY2UgdGhpcyBpcyBhIHZlcnkgc2Vuc2l0aXZl
IHBhdGNoIHNlcmllcyBJIHRoaW5rIHdlIG5lZWQgdG8gYmUNCj4gYW5ub3lpbmdseSBwZWRhbnRp
YyBhYm91dCB0aGUgY29tbWl0IG1lc3NhZ2VzLiBUaGlzIGlzIHJlYWxseSBvbmx5DQo+IG5lY2Vz
c2FyeSBiZWNhdXNlIG9mIHRoZSBuYXR1cmUgb2YgdGhlc2UgY2hhbmdlcyBzbyB5b3UnbGwgZm9y
Z2l2ZSBtZQ0KPiBmb3IgYmVpbmcgcmVhbGx5IGFubm95aW5nIGFib3V0IHRoaXMuIEhlcmUncyB3
aGF0IEknZCBjaGFuZ2UgdGhlIGNvbW1pdA0KPiBtZXNzYWdlcyB0bzoNCj4NCj4gY2VwaDogcmVs
eSBvbiB2ZnMgZm9yIHNldGdpZCBzdHJpcHBpbmcNCj4NCj4gTm93IHRoYXQgd2UgZmluaXNoZWQg
bW92aW5nIHNldGdpZCBzdHJpcHBpbmcgZm9yIHJlZ3VsYXIgZmlsZXMgaW4gc2V0Z2lkDQo+IGRp
cmVjdG9yaWVzIGludG8gdGhlIHZmcywgaW5kaXZpZHVhbCBmaWxlc3lzdGVtIGRvbid0IG5lZWQg
dG8gbWFudWFsbHkNCj4gc3RyaXAgdGhlIHNldGdpZCBiaXQgYW55bW9yZS4gRHJvcCB0aGUgbm93
IHVubmVlZGVkIGNvZGUgZnJvbSBjZXBoLg0KDQpUaGlzIHNlZW1zIGJldHRlciwgdGhhbmtzLg0K
Pg0KPg0KPj4gICBmcy9jZXBoL2ZpbGUuYyB8IDQgLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
NCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9maWxlLmMgYi9mcy9j
ZXBoL2ZpbGUuYw0KPj4gaW5kZXggNmM5ZTgzN2FhMWQzLi44ZTNiOTk4NTMzMzMgMTAwNjQ0DQo+
PiAtLS0gYS9mcy9jZXBoL2ZpbGUuYw0KPj4gKysrIGIvZnMvY2VwaC9maWxlLmMNCj4+IEBAIC02
NTEsMTAgKzY1MSw2IEBAIHN0YXRpYyBpbnQgY2VwaF9maW5pc2hfYXN5bmNfY3JlYXRlKHN0cnVj
dCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+PiAgIAkJLyogRGlyZWN0b3Jp
ZXMgYWx3YXlzIGluaGVyaXQgdGhlIHNldGdpZCBiaXQuICovDQo+PiAgIAkJaWYgKFNfSVNESVIo
bW9kZSkpDQo+PiAgIAkJCW1vZGUgfD0gU19JU0dJRDsNCj4NCj4gKEZyYW5rbHksIHRoaXMgaWRl
YWxseSBzaG91bGRuJ3QgYmUgbmVjZXNzYXJ5IGFzIHdlbGwsIGkuZS4gaXQnZCBiZQ0KPiBncmVh
dCBpZiB0aGF0IHBhcnQgd291bGQndmUgYmVlbiBkb25lIGJ5IHRoZSB2ZnMgYWxyZWFkeSB0b28g
YnV0IGl0J3MNCj4gbm90IGFzIHNlY3VyaXR5IHNlbnNpdGl2ZSBhcyBzZXRnaWQgc3RyaXBwaW5n
IGZvciByZWd1bGFyIGZpbGVzLikNCg0KTWF5YmUgd2UgY2FuIGp1c3QgYWRkIG1vZGVfYWRkX3Nn
aWQgYXBpIGludG8gdmZzX3ByZXBhcmVfbW9kZSBpbiB0aGUgDQpmdXR1cmUgb3Igb25seSBqdXN0
IGFkZCBtb2RlX2FkZF9zZ2lkIGludG8gZG9fbWtkaXJhdD8NCg0Kc3RhdGljIGlubGluZSB1bW9k
ZV90IHZmc19wcmVwYXJlX21vZGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLA0K
CQkJCSAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90IG1vZGUpDQp7DQoJbW9kZSA9
IG1vZGVfc3RyaXBfc2dpZChtbnRfdXNlcm5zLCBkaXIsIG1vZGUpOw0KDQoJaWYgKCFJU19QT1NJ
WEFDTChkaXIpKQ0KCQltb2RlICY9IH5jdXJyZW50X3VtYXNrKCk7DQoNCiAgICAgICAgbW9kZSA9
IG1vZGVfYWRkX3NnaWQoZGlyLCBtb2RlKQ0KDQogICAgICAgIHJldHVybiBtb2RlOw0KfQ0KDQpm
cy9pbm9kZS5jDQp1bW9kZXQgbW9kZV9hZGRfc2dpZChjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwg
dW1vZGVfdCBtb2RlKQ0Kew0KCWlmIChkaXIgJiYgZGlyLT5pX21vZGUgJiBTX0lTR0lEICYmIFNf
SVNESVIobW9kZSkpDQoJCSBtb2RlIHw9IFNfSVNHSUQ7DQoNCglyZXR1cm4gbW9kZTsJCQ0KfQ0K
DQoNClRoZW4gd2UgY2FuIHJlbW92ZSAgIm1vZGUgfD0gU19JU0dJRCIgY29kZSBpbiBpbm9kZV9p
bml0X293bmVyIGFmdGVyIHdlIA0KY2hlY2sgYWxsIHBsYWNlcyBjYWxsZWQgaW5vZGVfaW5pdF9v
d25lci4NCg0KQnV0IG5vdywgbGV0J3MgZmluaXNoZWQgU19JU0dJRCBzdHJpcHBpbmcgcGF0Y2hz
ZXQgZmlyc3RseS4NCg==
