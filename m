Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1452C918
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 03:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiESBDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiESBDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 21:03:22 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E33579B9;
        Wed, 18 May 2022 18:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652922200; x=1684458200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H1Aa0xEs6TwNdliTu2wl02CxAcij36ySyDvIyH5s+H4=;
  b=vrwOjEwLbyDzoRWPhwExFHRE9kj2hLdonA6/el8WUdM9tMP0oq4O3vU8
   MEq9VmjqX4CScT+GS5ZBNlhvtyRTim+OhtNrt549JUeQYipC4/UycGNPK
   AaQZ/w/wEJPBCFFb4Mu8At/ofT4XwUO9/CiQWTPkWFv9a+4YMtEibUwhB
   YWM+BK6Vp4udLzHF+rVlL/G62px4VzR6pEcxJnrt4ujA/3NU80s5QjNm/
   ReXvkFRyUQsL2SVnwTJGqO5doa4g+k6ywz0vGAMeSA79FbN8pwJrWryXt
   /IPP1cMeFyqn1qyuIVBFltB9Zcl25O7ninqDejv3OJR4kBeykrCnNKKhR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="56481034"
X-IronPort-AV: E=Sophos;i="5.91,236,1647270000"; 
   d="scan'208";a="56481034"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:03:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb9PVCaBx9MH02QC9j/yi2pocJumGCoGYMNDIOl3/c7KIUWaXFMI3yq0KKLCJ0PkRAupu6OUDt6nqbXgUU0VZIolQENdvHAnkwHiAjTYsJXWxY5GuKGVrGYza2iYakB2AUynKNa5usQa+QmHl2iWhPCXjIGBya2k59MNFqcb2PyT4tU9a729I9aWBhSsdA/80aPBqasBly8Au3eJdQjZSusKLummdbspJUuz2YozHWLEbY5ZE7C+0jgldQ7PmwdlMI1b9xrtocc5E+XqBsfKavx104fTTnwF6ssdQN3UUsa2K+GyfnmCXK7mQ8zp9sw7tkKgScrPmeM0MP2bp+WLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Aa0xEs6TwNdliTu2wl02CxAcij36ySyDvIyH5s+H4=;
 b=T3Rkd8cVoLWILSwnBZtyirdIgkOGPZM01pmIctEZONotnOBW5G71kETdMauZniDa/uUsMmWqpRZgU+3MMZRy/8ViYTVNDwiTBBtlNb1Sfp8fcKEKk7IrN2MjoZgqExD61o0x4Z4HHkn8QvUH1mhr20/qrtuMCO5f+HJWpITvu7aCruqBZkC5SKrCQ0no9DUvFhlFnr7cpUwNPHxMb5CxrtPReg8ZqRxDcRtvYw9y7uTgF4oXdxxa8r/rivhmjjUtt7SXwwALrc5PYB+iX8FZprApa12qQcx/MLSo5sf2Ft0wJpkaJegt/DbUFa8k+oAyykx/ZFF4BQIPadejSg/TIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Aa0xEs6TwNdliTu2wl02CxAcij36ySyDvIyH5s+H4=;
 b=YP+uBxbniiLlXUERiFq/jI2VrYS9/3r6cUyyMHx6/33BnBdkfwXzzkvnjO5VrLxvik+njg93SxaK2AERZ7iJPYpK4eCnH9WyIjAUOalxAK9S+0x5vF7fPy1+8/6QEm7BgnfqkVWjIK+WAZQNS3YzU8WB4MmmVIDljOJgJwQ6PSo=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2409.jpnprd01.prod.outlook.com (2603:1096:404:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Thu, 19 May
 2022 01:03:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5df8:2861:34f:f50d]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5df8:2861:34f:f50d%6]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 01:03:12 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Topic: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Index: AQHYWVXfz8USQ3fGU0yVfe+Yu4r8bq0ElGOAgAAEnQCAABMuAP//9jmAgAAGhACAAAmjgIAAYR0AgCCDEYA=
Date:   Thu, 19 May 2022 01:03:12 +0000
Message-ID: <6285A58F.3070700@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk> <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
 <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
 <YmoOMz+3ul5uHclV@zeniv-ca.linux.org.uk>
 <20220428093434.yc7hjjplvicugfqs@wittgenstein>
In-Reply-To: <20220428093434.yc7hjjplvicugfqs@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12898e87-88d6-4b88-46e2-08da3933590e
x-ms-traffictypediagnostic: TY2PR01MB2409:EE_
x-microsoft-antispam-prvs: <TY2PR01MB24091F8E3E8A0FC89A87EA50FDD09@TY2PR01MB2409.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfLQGWcal6SoA+r4bpo3pVfhKtoS8khM9CzrRN2yhooTaCazYJlL0qVwaez/sU04P7o3HaiVOzWBOvTX/7XzzMUQKZ9+ezUzzwABvjofqk4UEaDtetBtgZU0Y2iiwRV7efC7+ZNYiy/iB01iBofPMul1R1H0h9r82eOzMDlnzBSp7DLx6ATSlIuaOf0ANKbfX3dFrHh0QdkiYiFZKhQAcK9s7USMsdMgd4DGnGkN7u4+PyNHVwF7fNS9kjSg8iCFjU9GUEsdlK8tY9eFQqF1ftrIRCsavgcReO1dH+D/qU1fkXLscc25ceTnoFoAu+wFKdXE5NAV5qFVlIfZrPYD20oEUs8mEElvlbTgC8tUfy7uilQfo2cDbg8WIxmdZA6z5624JUodXBorp0uBwE6Q8sYSP3WUNvmKnvZF7o0DFSVpKEjvIyRLdVQWN6e/NvGG/k5H9GFtCEo6ynijmj+Cbjh29MficsAJyn/1ePDaeeDZ+uZzNoXBISAnVFdhF2LnyPpFDOYPGmjCkivDuFXlA33BDoXvlFVF1qTN2xb3y31AMxAoWh+7eoVRIz+pVqZxN4gUTKKDVMezzGffbZpCaMo/u4QnCMhlq2mc4XZno0OM/m5ISEwWhkTZBxoyZ76Xu85gxue6EGOZJvB2LUHs9fk0IlLOC6PPNDPAN1KrVW8msrLKknwiInGmNp8LqqsP1UsJp5cXyJmYeLRAUI/WiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(86362001)(122000001)(83380400001)(2906002)(38100700002)(82960400001)(186003)(316002)(6512007)(87266011)(6916009)(5660300002)(508600001)(7416002)(6486002)(71200400001)(66476007)(64756008)(2616005)(36756003)(8676002)(76116006)(66946007)(6506007)(26005)(54906003)(8936002)(91956017)(66556008)(4326008)(85182001)(33656002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9QRHpzTTFZa3hlWHBQMVBYYmhweDdLeWdiSkV6S0c2dW12dVJZSkNZTkhF?=
 =?utf-8?B?aGdlaFQrdE9oeUVnZmo3cFdlSTBYYm9lMFVtYkhLK3F4ZitaVUtwZU8xbXRM?=
 =?utf-8?B?K0NLaHB0VWpWNmVWa25Ua0YvOW1keUNqZmdIR1JMNDFoMkJJV3VOUTVGbm1Y?=
 =?utf-8?B?dHpTd1crZWNVczF4ZS9hQ3ZLQVFPRTNzZDFLOG9aLzJsY2d0Q3ZMTldBYXY3?=
 =?utf-8?B?cTZ3RVBQN3U0N2l6bUNrdWVwdEZOajR3czg5WnQ2aDVjbXVZU1NyS3hKOUZ0?=
 =?utf-8?B?OExXL21nK0U4Wk9zSFRGdE42dERPT2dPQ1M1NTEyZ3l4eVRpa3F2YjJOZjEz?=
 =?utf-8?B?R0d4cEVPSDFacEVPTDFyUHg5RGo4KzBTbWJCYU13Tmd3cTVjeGtZUGx0RmMr?=
 =?utf-8?B?MEdyTWxMVUx1RS8ybXNENVRFc3FWYjBnMEoxbk1xdTB2em5tdEpzb09uTXdC?=
 =?utf-8?B?dUluU1p2TEN0UGFoL2YvbDhFV2NIcndhbzBIc0xUSmNnWFROUWpNcXpuZjFp?=
 =?utf-8?B?WStSMEJLNXJlLzhUeFZ2TUZ3L2JoSXBtd3Y0NkZXMWNPcnFqT2hkclQvdFRE?=
 =?utf-8?B?aWpKYmJISkVOaVJITDFHVGg4MGpJMGt1UFcyRlRNR1NmbU9nYjNCWkZFZ2ti?=
 =?utf-8?B?RlJLQUJBM3k2cmg2bElCeE8zRnF2Q0hxMFJzWDhUQ0dNa2lubWsyWDVsbkFm?=
 =?utf-8?B?UWFRTE0yS0w2SlF0U0tPZFFYMW82cTZjTjJEa3h2ejRHWlFaSUl4MXlORDJP?=
 =?utf-8?B?V3NHcHRJRHF2bHBueFVWeVo3YVhLcEpSUDc5S1FjZFZtRmZDcXpCRERTNFpW?=
 =?utf-8?B?Mm1VKzdWWkErQzYyUXFCLy9FeENjNGtBd1dhbXh2dG15YW8xbGphQ1AzMVJl?=
 =?utf-8?B?bGxYa3FmWWZ1aVJyMnpuaHdicmNKMzNpYm83NXplajlOeUtqbTV6U0t1SmNE?=
 =?utf-8?B?bnM3b2lvSURucVZWRkl6L1V2dVZBRHhSNjdxYitIS2hRd1FUTzR2czBaSkdn?=
 =?utf-8?B?U2NQLzZVSFBnd1VnWnl2dU9kSUdDSm1uT2g0U1JoNU5ObGM5YWVLOWtneGl4?=
 =?utf-8?B?VVBxNzdpWS9SS3JuU0U3bzJJWTB3dWpoWlFmazV5dHBBRUpvVkwwbWsyVXVn?=
 =?utf-8?B?U29NVGVKS0JBMno3WkRBOUJRMkFsbHlCejI2MlBnWEhURGJyN2ZwcHFTejFs?=
 =?utf-8?B?djFENWFKRStjbDM2c0VrL2dOdnNOUnpXU2lneVVIY0JYNG5JRDdJU3Y0SUhP?=
 =?utf-8?B?UXdSLyt1VjhBalZUY3Iya0Nud0M0dll4NWw5RmlSMWJ5WkJXWUxpT09PZ0FZ?=
 =?utf-8?B?UVFCRjRVc2FxU1M0eW5BUkp0L2UrakZHc05WUlVaclNPeFEvcHRLS3RySWNr?=
 =?utf-8?B?M1pkNU9xNGRqZUM2eWZqMWpzLzg4blNmTVlHejFLelo1MERidzQybHJTYmRn?=
 =?utf-8?B?K0RQUWJnOEZiTVI1L1ZGK3FlNk03dFAyL2J2NjRnMlUrN2lIUjNnRFZJS3lG?=
 =?utf-8?B?N2V5ZmlrNjZHWWFySkt6QzJ2U05GWWxMaGpwVWloN0UxSWxKaitqbEZtNkVu?=
 =?utf-8?B?NUcyVUMwdTBWYVNVZERyWThvbHJQcVE1SCsrVXIwdG9YWkI2TEtDLytFSG84?=
 =?utf-8?B?TVdFRVFOQ0lVR1ZGZkYyK09hZUxZcmxQL0R5dTdnVDQvTXNCeTUxTVNxeGx0?=
 =?utf-8?B?aEdVTXc5Qm9GRWVDVFhaWXEwZmZ0bmhLSGo4Y2xpNWEwQlh1cGYxR0pGSHhP?=
 =?utf-8?B?QWFPWTQ3WDJYZ0V5Nndra3VyUlJiOC91a1RpZDNwdERTK3pFd0lzYWx6c3lp?=
 =?utf-8?B?UjZuZUdGZUZhLzI1Tlp3VG9ucDZSR1M3dXhzWnpMeHBKb2NIc1FWazMwUW9y?=
 =?utf-8?B?UUJmTzVmSndQMGIzajN0cjNxU2ZoV0REVzlGbFNJQWVaeXhIZTYvcTFlLzJw?=
 =?utf-8?B?TjhjMnlXN1U2OWJTZWpMNjhwdXd0SkpGY3VqMm5WUWJhSkdIWE5WY0JyOXJ4?=
 =?utf-8?B?QlhTWE1xd1FoK1BUWjhlZysxVUpmeUF4UnR0SVUzNmx2Rjl6MVgxYi9na1ht?=
 =?utf-8?B?Q2hWd2dKYkRSK25ZMlpWSXpSSElSQzBzYUpzSEJrR0xvQWV3RW1kNTB4cDJu?=
 =?utf-8?B?WjZFTjhEWXZPNnR1Z1k3T2tNY0NZQzJkN2k0N1NONFo4WVNWVWlRcmh3TTB5?=
 =?utf-8?B?TFVXZ3ZpL2w5cjQ5WDJGcTYvYWRlVk5yMVFXd0JTWmVFaDNDV3B5dWpHSnd6?=
 =?utf-8?B?Z0k1aG1UQmxobWtCVzhrRkpiTm1RbDYyNi9XZW1JSW1OS1RRbjQ1TnhEMGN4?=
 =?utf-8?B?Q09obkNrZW5DZ1ZYMGlkV050WEtjcmI0eTgxLzlOZkdsN0VqbDFKd0p3Mlk3?=
 =?utf-8?Q?noU2jqbH0kmg1/tY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B8C6BB9AAFDA14A907A9DC70AD5D725@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12898e87-88d6-4b88-46e2-08da3933590e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 01:03:12.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvC0UB6v5NNNFISl61UF4bQ70AH/N2tlxGAIyi382Y+O5HA0nJpbhSyj7V/ETRobAlo+NYT/2oiLIMGmxxC5J0sNovC21I1YyBKQK9Uhgec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2409
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI4IDE3OjM0LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjgsIDIwMjIgYXQgMDM6NDY6NTlBTSArMDAwMCwgQWwgVmlybyB3cm90ZToNCj4+IE9uIFRo
dSwgQXByIDI4LCAyMDIyIGF0IDAzOjEyOjMwQU0gKzAwMDAsIEFsIFZpcm8gd3JvdGU6DQo+Pg0K
Pj4+PiBOb3RlLCBCVFcsIHRoYXQgd2hpbGUgWEZTIGhhcyBpbm9kZV9mc3VpZF9zZXQoKSBvbiB0
aGUgbm9uLWlub2RlX2luaXRfb3duZXIoKQ0KPj4+PiBwYXRoLCBpdCBkb2Vzbid0IGhhdmUgaW5v
ZGVfZnNnaWRfc2V0KCkgdGhlcmUuICBTYW1lIGdvZXMgZm9yIGV4dDQsIHdoaWxlDQo+Pj4+IGV4
dDIgZG9lc24ndCBib3RoZXIgd2l0aCBlaXRoZXIgaW4gc3VjaCBjYXNlLi4uDQo+Pj4+DQo+Pj4+
IExldCdzIHRyeSB0byBzZXBhcmF0ZSB0aGUgaXNzdWVzIGhlcmUuICBKYW5uLCBjb3VsZCB5b3Ug
ZXhwbGFpbiB3aGF0IG1ha2VzDQo+Pj4+IGVtcHR5IHNnaWQgZmlsZXMgZGFuZ2Vyb3VzPw0KPj4+
DQo+Pj4gRm91bmQgdGhlIG9yaWdpbmFsIHRocmVhZCBpbiBvbGQgbWFpbGJveCwgYW5kIHRoZSBt
ZXRob2Qgb2YgYXZvaWRpbmcgdGhlDQo+Pj4gU0dJRCByZW1vdmFsIG9uIG1vZGlmaWNhdGlvbiBp
cyB1c2FibGUuICBXaGljaCBhbnN3ZXJzIHRoZSBxdWVzdGlvbiBhYm92ZS4uLg0KPj4NCj4+IE9L
LCB3aGF0IGRvIHdlIHdhbnQgZm9yIGdycGlkIG1vdW50cz8gIEFzaWRlIG9mICJkb24ndCBmb3Jn
ZXQgaW5vZGVfZnN1aWRfc2V0KCksDQo+PiBwbGVhc2UiLCB0aGF0IGlzLiAgV2UgZG9uJ3Qgd2Fu
dCBpbm9kZV9mc2dpZF9zZXQoKSB0aGVyZSAod2hhdGV2ZXIgd2VudCBmb3INCj4+IHRoZSBwYXJl
bnQgZGlyZWN0b3J5IHNob3VsZCBiZSB0aGUgcmlnaHQgdmFsdWUgZm9yIHRoZSBjaGlsZCkuICBT
YW1lICJzdHJpcA0KPg0KPiBFeGFjdGx5LiBZb3Ugc291bmRlZCBwdXp6bGVkIHdoeSB3ZSBkb24n
dCBjYWxsIHRoYXQgaW4gYW4gZWFybGllciBtYWlsLg0KPg0KPj4gU0dJRCBmcm9tIG5vbi1kaXJl
Y3RvcnkgY2hpbGQsIHVubGVzcyB3ZSBhcmUgaW4gdGhlIHJlc3VsdGluZyBncm91cCI/DQo+DQo+
IEhvbmVzdGx5LCBJIHRoaW5rIHdlIHNob3VsZCB0cnkgYW5kIHNlZSBpZiB3ZSBjYW4ndCB1c2Ug
dGhlIHNhbWUgc2V0Z2lkDQo+IGluaGVyaXRhbmNlIGVuZm9yY2VtZW50IG9mIHRoZSBuZXcgbW9k
ZV9zdHJpcF9zZ2lkKCkgaGVscGVyIGZvciB0aGUNCj4gZ3JwaWQgbW91bnQgb3B0aW9uIGFzIHdl
bGwuIElvdywganVzdCBkb24ndCBnaXZlIHRoZSBncnBpZCBtb3VudCBvcHRpb24NCj4gYSBzZXBh
cmF0ZSBzZXRnaWQgdHJlYXRtZW50IGFuZCB0cnkgaXQgd2l0aCB0aGUgY3VycmVudCBhcHByb2Fj
aC4NCj4NCj4gSXQnbGwgYWxsb3cgdXMgdG8gbW92ZSB0aGluZ3MgaW50byB2ZnMgcHJvcGVyIHdo
aWNoIEkgdGhpbmsgaXMgYSByb2J1c3QNCj4gc29sdXRpb24gd2l0aCBjbGVhciBzZW1hbnRpY3Mu
IEl0IGFsc28gZ2l2ZXMgdXMgYSB1bmlmb3JtIG9yZGVyaW5nIHdydA0KPiB0byB1bWFzayBzdHJp
cHBpbmcgYW5kIFBPU0lYIEFDTHMuDQo+DQo+IFllcywgYXMgd2UndmUgcG9pbnRlZCBvdXQgaW4g
dGhlIHRocmVhZCB0aGlzIGNhcnJpZXMgYSBub24temVybw0KPiByZWdyZXNzaW9uIHJpc2suIEJ1
dCBzbyBkb2VzIHRoZSB3aG9sZSBwYXRjaCBzZXJpZXMuIEJ1dCB0aGlzIG1pZ2h0IGVuZA0KPiB1
cCBiZWluZyBhIGJpZyB3aW4gc2VjdXJpdHkgd2lzZSBhbmQgbWFrZXMgbWFpbnRlbmFuY2Ugd2F5
IGVhc2llciBnb2luZw0KPiBmb3J3YXJkLg0KPg0KPiBUaGUgY3VycmVudCBzZXRnaWQgc2l0dWF0
aW9uIGlzIHRob3JvdWdobHkgbWVzc3kgdGhvdWdoIGFuZCB3ZSBrZWVwDQo+IHBsdWdnaW5nIGhv
bGVzLiBFdmVuIHdyaXRpbmcgdGVzdHMgZm9yIHRoZSBjdXJyZW50IHNpdHVhdGlvbiBpcyBhbg0K
PiBhbG1vc3QgaGVyY3VsZWFuIHRhc2sgbGV0IGFsb25lIHJldmlld2luZyBpdC4NCg0KU29ycnkg
Zm9yIHRoZSBsYXRlIHJlcGx5Lg0KSSBhbSBhZ3JlZSB3aXRoIHRoZXNlLiBTbyB3aGF0IHNob3Vs
ZCBJIGRvIGluIG5leHQgc3RlcD8NCg0KcHM6SSBhbHNvIHRoaW5rIEkgbWF5IHNlbmQgdGVzdCBj
YXNlIHRvIHhmc3Rlc3RzIGZvciBwb3NpeCBhY2wgYW5kIHVtYXNrIA0KQVNBUCwgdGhlbiB4ZnN0
ZXN0cyBjYW4gbWVyZ2UgdGhlc2UgdGVzdCBhbmQgc28gbW9yZSBwZW9wbGUgd2lsbCBub3RpY2Ug
DQp0aGlzIHByb2JsZW0uDQo=
