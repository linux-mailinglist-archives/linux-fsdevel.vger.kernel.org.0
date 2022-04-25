Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AD50D761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiDYDNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 23:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiDYDMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:12:54 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Apr 2022 20:09:50 PDT
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF656E4D2;
        Sun, 24 Apr 2022 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650856191; x=1682392191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HhTxj13s4T6CkAvXZAcaqqtubOssTKRulBp4bVDyssc=;
  b=jJs1DAgScJcCxsYj4qc+Nm0Guf5/GkQ5sJcSPiGgbZY7Cu2owngy/avX
   A/OxFDGj1B9VvGdyIQS/GH97UknRIrdUuJ46zDJHvDaAEqsV45tBFU2kf
   sgoKhuUzeRIehc7m32HQU8T0+esEkQtwIKy3BlKGuq1tbsEVFt4JXUNiD
   nnThMJhaQtCxbkZWbPAFrGEuLKx78RVsPNV7nT13njPzDxCtG5Qke1fm3
   S1yjmBzg2ZltIg4pf9vi6dzWQzeG6v2mRwiLHj2wJ/3/DjS4MVH7HZ7EL
   nqIfZTS0QX8zFuberbnbgpcMAyo/ZqlFqpzLyaDFyt1TjP4gF9ZCDayLd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="54877405"
X-IronPort-AV: E=Sophos;i="5.90,287,1643641200"; 
   d="scan'208";a="54877405"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 12:08:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SENSiS+WRbCQrZeghqixgzULLDY7Zgp8OTqEOXQ5J1dO2PAM13dzC/UgIZk/zUkUi8U8YSqAEo2QJZyO8KkT49iHMYQSIeYXJ6H20SzBESYytmlOfeq9lU6pCgQFjwFEucI+090HTIHE4RgpgBE/H+3cRkiZ8o9LB/rOOQopPOK27TWF+dHSH6+4Lik9iv0/0vvKX522zM1p2Gd4PorCFnr1UJKJhc9uucBE8/nEOV+QjqbojkURgm7Rh3c3CCCzmwcFgwdBfsTT7Myo/mOud9e5eKPJriaT+eVPTzfWfnlnBWcLb+cfjQuaKoQmcmMhCsvJY+eZIGYbp5kQjL8OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhTxj13s4T6CkAvXZAcaqqtubOssTKRulBp4bVDyssc=;
 b=TxOVpHQhT+1LJV9Cbee8y8zusrX7UgXs42r9Oh9D1tvnwcSQnT/sSzJj8gIWO06k7Hoh5lXciStxY/iJk8JNsdxO1lhxtzzvvhfb/v970yUDCziOUb+8OAJMS0zCbdq+GjYstSyyu/PCqUpokra2FSXwyaUheSdPiqv7t0hfpPMO4/tqRtCSkt28ny+bUGym2/FRs5L8qXueGudv9mLI0sgWjkspZvU4g/0VeHwZKSybDkcRZQVax7vJxvmVW62aPfVTUwhwbe6g2Aci+BxqGbbcAfV4Lkpnvz8gnbtd1cwk1XPPho2R6go7pY+wtS47EBiDy3aSBq1DWoAP0T2PLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhTxj13s4T6CkAvXZAcaqqtubOssTKRulBp4bVDyssc=;
 b=GqZ9Fv9vYb0XeEln2Ou8O+gIQ3k4xc4am0mxw4zesvDkvR5bmfx79xBR8CRMtaEiDTbX4WTd3nu5ZlT16n6mghSaSTVmXhFsVjH9TKMn+Uuro8lUurgNwAt8xT+WRQzYjIh7sEp1K+sP3OVq+18rfpvefZYpGRH2Iu/FI2gLHyg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3846.jpnprd01.prod.outlook.com (2603:1096:604:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 03:08:36 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 03:08:36 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYWElmndJywNP+LUaiiBtBnwHkL6z/7IeAgAAXkIA=
Date:   Mon, 25 Apr 2022 03:08:36 +0000
Message-ID: <62661F19.3020805@fujitsu.com>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YmYLVfZC3h8l7XY1@casper.infradead.org>
In-Reply-To: <YmYLVfZC3h8l7XY1@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fd9b6d6-fcea-4a75-233d-08da2668e377
x-ms-traffictypediagnostic: OSBPR01MB3846:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3846A1B209372A8617DE5DD1FDF89@OSBPR01MB3846.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqX1LffdaiUBM2LEw3ADpLMx6wE2gO7U8hvKnN4crCFoABNioXJs2xgTO44XOYXlPXKIpMDcAjuWD6MJVQprG4mkzqw45Tp65Q7VO3cN6rraNNPWfFYRKlorPdKjBPP5//KHRGzh+g7mbpN/v99y1WLOkYcaEdp6QiLj+Oe/X70nHWouFbWokl0gkoqPARXmlz31QzL6xYLRoh4p1AVR0JRsJ4y9+7MyvuN3MC4Xa1Qb/3s7rENYF/GAcj8lRYUWhLxLel6nWj2ws3G0PgmQa0jJgC6becIsLcfi5NVG7XC/yWxvL7lsLO5RdKXJRnBJjELvRbBZZDgOROQWaASEuCEx4dDjXwsDhSH1fohgB6grj9Hdo96HUTEZJxL8Mm+ZHeGUFE5LFAdQ05OQWmm1Zz0jtXFHEOM4ldsjwrz0Nq34c8y4Qa8/VxDFM/xOc8zggavPqcGwCQFYDbLdgtjhCI+/l6fmfL35SVsF/DKfcOnHiSAILqOe6a//Z/aCaFHcXmjWzD3T2OKW1JSIbJ3+swD2pN3J44EeVZ/0Z4NV+xIZ2WPUmtttDzJbiFAcVsDYdFZRKrfnYq16nhmZ81RGsTpF4gwxidP4Swzx1vtVebbNx2eIzfJly4iBa9Cb6aRGT2eWypDzXimbd3DogBMbQ8hwfBL4yjjiG8iWIx/eVIaok183/Q3W26975IeQX5Ofyp/7OWnxPv0RqjItbebusQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(82960400001)(122000001)(4326008)(66446008)(66556008)(2616005)(91956017)(6512007)(76116006)(5660300002)(66946007)(8936002)(4744005)(86362001)(38070700005)(2906002)(38100700002)(508600001)(6486002)(71200400001)(316002)(87266011)(64756008)(8676002)(66476007)(54906003)(6916009)(186003)(6506007)(85182001)(36756003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d25KTmJRVktEVVlQMHBON0xKciszY21TWTRIWVdwK1J4R2kwUzVqMmQyMVN5?=
 =?gb2312?B?ckJZY1RjYVd5b05mTTk3eTNJTFAvRXFuUnRKVUs3d3J2M1NuN0JmN3FTdGNx?=
 =?gb2312?B?T050WWtmZ2p1ekRia0hCTGtNbzBOKy9kUnMzY3hVWlNTazhRSmJFbFduUHZI?=
 =?gb2312?B?cjdNZk8vTlZTbVA2Qnp0ZG1QUm9mK1lCVUdyU0lEMzNmNDU0L1liTUxOTks2?=
 =?gb2312?B?amQrRHNKb01KaTBiZUwzZ2g2UkFHYWtjUGRrc3VMeWVUclY0Q0FZQmhKcFhm?=
 =?gb2312?B?cGFZd3BNdWErdmNteGRMSGEyL2h1c1cwb0JKSjhmWGlEWUxYaUR3eFFjSFZF?=
 =?gb2312?B?NjVkZ3VaVTZWaURraWhsbnlhbkhkK2k5UUZrRW9vWFpiSmtVSkl6bWdwbnU5?=
 =?gb2312?B?QmhWUyszWlhnYTZnOFo4Wkx5ckdOWXBWRU9xMmdwUE00K0pCa0FVLzgyYTBI?=
 =?gb2312?B?TDV1Qk10S2J6a3VhMzIvbkowTWhFaXlHZUt2UGl0NHRoTlI0SG1WR3JPQlQv?=
 =?gb2312?B?ajc5dnlvbmRybzFvUlZKajNHYndkNzM2MmcydENZMEZSeTA3VXczOExyYWxt?=
 =?gb2312?B?ZlpMVUlvL0h4MEpHOTFCeGV6akhtcXJkRzhHRitwNU96OU5HYVRwcGUrd2RZ?=
 =?gb2312?B?c3kxbnpxSUpXN24vNmxBRk5HQ2ZlbzNyMmYyTWM2VjNKTkgvbU9TaUMrejhM?=
 =?gb2312?B?eVo4bVZiL3YyWm1lWk05OE1FeTV6d3A5Rkc1alhibHRma3BYS0JGTkRyclRK?=
 =?gb2312?B?OGJsVEZxK3ZTc1JVV2V1bEEvS3pVSUcxaXJqUWRzdkRWa1VSQy9BTVhiZ0VH?=
 =?gb2312?B?U2tDSkxrenZsdGFTWm1YcllNT3A4bXY1ZFoxb1d2S2QvdlB1UTJPMXZjelNB?=
 =?gb2312?B?N0w1SlQyVWd1VEs2S1ljRWJ2VzNlMC9mS1g4UWF4d3pCYktFamYrbEhmWlJn?=
 =?gb2312?B?cGVIei9aR3hCeU1wRnltWWloVmd3aGQyY2Z5WHpRTjFDMkpKMWp4VFpRUkR0?=
 =?gb2312?B?Z01NbUlvOEhJM1BHdzBQRU1xOGx2YXVLcTByT2NSTmlzRjJUUGlxZ1NMTXly?=
 =?gb2312?B?eVNuajZIT200SWZWS0xkODgyUlBrdjQrRTY4bmU2dXdPZW04L0YwcW9wODM4?=
 =?gb2312?B?bHdpcm1DMFIrZlMyZGtubzNUc09ocG5YK0pnVEVWVFcyRzA3dG1lbjNrNW9R?=
 =?gb2312?B?MnUvQUlCUUEwUkxZZ3ExTjlXR2lZMXZZQ0RwajVDS2JUNmRCRjVXS3BEalJD?=
 =?gb2312?B?UldwTnhDbFZ6MnNLdzV6Y0w1cXBsQmdHeDZLOVpJNFRpbkk5Q3N4TFhydS9k?=
 =?gb2312?B?T1ZLMlR6NEhWUStzNElwRGVvKzBndldkUmg2UDFyQkgzM3FsR2tXY0NDSVNj?=
 =?gb2312?B?NlF1Ty81SjVmMUJ5QlhtUUtCQ0g0TVl0WU1RSTc3dGx2cnVKcW1FdnZLS2dq?=
 =?gb2312?B?Qmt3MldTcjVYcnNtckZEc0djbVN1K2k4bEpJc3RRSVUrUmJxNHFTSkNDNlR1?=
 =?gb2312?B?SjV4OWlxQ2NXQW54TXNZaDZYbHp4Q2NXVXRDSEdvSDVYdHdScm5OMGtWY1Rv?=
 =?gb2312?B?MmxBbG5VbktIYm1HZGUyV05WM3pEdTV0R2VsRUp5SXB5bHNFeStSYTZIcUxC?=
 =?gb2312?B?ak9rY2tld2pFc09OVnllQTlrQjQzdE8xVXJBVFZJU3B3RTM2SnF4dlpLbHVi?=
 =?gb2312?B?ZHhtbzhGZU9iZHMvVUZMRkRDQy8xUVB3N2VoZHhLelhXRVRmaHgwSGZRaGkv?=
 =?gb2312?B?SVViTzdGTThzSXZSV1FjWFRUUE9ZOWVDQmFzOFhCOEZkQXNDYmhyeksyM0pM?=
 =?gb2312?B?WjEyVWVBMy9iRUU5bHU4cTRRVkpPYi8zTXRCLzgrYTNaRkthME8zSFFHd1Iz?=
 =?gb2312?B?YXJraFBIRE13WVNkMVJrL2FxejliOG41QzdFWVhSV0FyZWkwVnd5UWt0S1Bp?=
 =?gb2312?B?OUVYL0hVNU5Gb09PRVRTZHl3WFJGQXlxT3ByTzBtOWZwMHNUK1pqZW5Xbi9p?=
 =?gb2312?B?QklMR1g4QWg4T1lhMHZEb1BQbkZyOEFZSHZYaVU5QU9COVpsU29mSk9LeDc5?=
 =?gb2312?B?RlJrUEZwNitveDIxRjMvUlJZTDZDRVRIQmZTV3dYOXZwNlhjY3RvSDdXSDJX?=
 =?gb2312?B?WldIYk1lNWhnQ1FheVFjWWVRRE5IYk1ReUtKcEU5eGI2MjFFdHA0UlQ3Vlpw?=
 =?gb2312?B?RkRwSi9UN0JKOFVjWk9RdHpFQXRBSllPU0ZmakptenhHSzgwUk5XTGN2c21o?=
 =?gb2312?B?Q0E5dUcyQ2hXMkxUMEpsTU5xWXUza1VncUtwWWhnYzhkZXlZUVR5UVBISUdJ?=
 =?gb2312?B?VEZubk9RMXpTSDJNRlQzMnB4QVUzb1hES1BuSlMyQWY1OTd6Q28vRlhBSjZ0?=
 =?gb2312?Q?erCsU8bpRSfi9AIo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <0BFA17BD1578754E858750BFADF9AF1B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd9b6d6-fcea-4a75-233d-08da2668e377
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 03:08:36.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ecoIIVfAKzBQ04nelFAGt7PgItVOWrfgBg3HHYBg4m82uS6DP2BaUFQlh9WxHB9q6A/JDag0bzprnuRBiE9WxZ1E93mCH/YMYjFPpmswOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3846
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI1IDEwOjQ1LCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gTW9uLCBBcHIg
MjUsIDIwMjIgYXQgMTE6MDk6MzhBTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRoaXMgaGFz
IG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0IGNyZWF0ZSBhbmQgZXhwb3J0IGlub2RlX3NnaWRf
c3RyaXANCj4+IGFwaSBmb3IgdGhlIHN1YnNlcXVlbnQgcGF0Y2guIFRoaXMgZnVuY3Rpb24gaXMg
dXNlZCB0byBzdHJpcCBpbm9kZSdzDQo+PiBTX0lTR0lEIG1vZGUgd2hlbiBpbml0IGEgbmV3IGlu
b2RlLg0KPg0KPiBXaHkgd291bGQgeW91IGNhbGwgdGhpcyBpbm9kZV9zZ2lkX3N0cmlwKCkgaW5z
dGVhZCBvZg0KPiBpbm9kZV9zdHJpcF9zZ2lkKCk/DQoNCkJlY2F1c2UgSSB0cmVhdGVkICJpbm9k
ZSBzZ2lkKGlub2RlJ3Mgc2dpZCkiIGFzIGEgd2hvbGUuDQoNCmlub2RlX3N0cmlwX3NnaWQgc291
bmRzIGFsc28gb2ssIGJ1dCBub3cgc2VlbXMgc3RyaXBfaW5vZGVfc2dpZCBzZWVtIA0KbW9yZSBj
bGVhciBiZWNhdXNlIHdlIHN0cmlwIGlub2RlIHNnaWQgZGVwZW5kIG9uIG5vdCBvbmx5IGlub2Rl
J3MgDQpjb25kaXRpb24gYnV0IGFsc28gZGVwZW5kIG9uIHBhcmVudCBkaXJlY3RvcnkncyBjb25k
aXRpb24uDQoNCldoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXM/DQoNCnBzOiBJIGNhbiBhY2Vl
cHQgdGhlIGFib3ZlIHNldmVyYWwgd2F5LCBzbyBpZiB5b3UgaW5zaXN0LCBJIGNhbiBjaGFuZ2Ug
DQppdCB0byBpbm9kZV9zdHJpcF9zZ2lkLg0KDQo=
