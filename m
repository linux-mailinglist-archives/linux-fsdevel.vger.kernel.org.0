Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9704FF291
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiDMIul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiDMIuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:50:39 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5A50470;
        Wed, 13 Apr 2022 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649839699; x=1681375699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PcpqxX60KgqbOApc+2tFfymNWi9qsca/7equ13HyS7E=;
  b=Yy9lUkhkYXeRaNYTAJ/+I+F94ezCCUWUAEt6uEbN/l+LfYBy/U2zcHKl
   HMOeGySyNPFkI4IAQ2NLzduCV6dh3+XhJLnpS8iGWcjOwnvGIOGMU4msP
   kOFkras8fbM7ty2lURPk+lcCxaDxAVpU/niZbfiRR+WwscQN/GH+FHuNn
   yFTlapowvv0JEJiIBtZGh+tlAcJ0ohK15BVEpMSRjjcnb9vRb8xKLDZj4
   XZJJt9rb6+nnqSIlHcKdfCMHrMukgiYE1wfHYckIT+iiGSVuQVNlMAFZB
   sxG8T8QVW1ClPIM8D2DUz15DuALhklFCzrQo2C4VH/dinMoVk1DW3fUlV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="62099129"
X-IronPort-AV: E=Sophos;i="5.90,256,1643641200"; 
   d="scan'208";a="62099129"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 17:48:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix3BJgF4OMYcVOEw4Ni/0DILD8SG8oQwkHl/U/Az/5YOkvoIY11iaY+8mTnfiZ41XNxmNUFAZu9FTCJKsCBPsgGjsTd72SXU5OUnLdk0ArkL7PMqIltyKOMuu1frhM5m0aoRPKPxoKzeJUEMLbS7eqmPjQ7I+Uiadye6hz81uv8vkz3hTG+i9NACPzP0Xd4jTQ0ADn856gcNuRcPmp87pJweukq9wf8bgNWjW4DoLUz8uXNDJXnjGEW2gzvG3X67+yrNrNV1EHNG7WPuViTV0KlrRfRtbJsPYTPQ4YKdvH8EfT1FIJg9j9dFlPgm1sDM0Ju8zTobv2eqJFKt9z1WiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcpqxX60KgqbOApc+2tFfymNWi9qsca/7equ13HyS7E=;
 b=gqEc7wK1QJzlp1kGtC/yDznjD2ySr7Wxz1gZbQgCGbICRK9jgK/xHS8SJ7snyYPUJpCsm9VqA2HVEQ/HKTUBJ3ETJifFEJB3KEa8UdJYLZ8EeVWRZEM4Yp2t1/QjJ2pyn6K+jztyeYDHlSreDD7CFiNz62Ut9dT4qorp/RHfCu5apjeBju22xpywNsISiU3mnzvFwlqnz6CCdrsocrsipJLDQvkWGTB0Otrnpr5EtKVtz1sPXPRvjyMnR+qw8sz8OEM1LDE02J5LqYl1PN7UsI6bBKt3biO5zcvagd24IxVuzaQwnyNSZiP6MbXLo7ZAJ0wthfBKsK44rcph/P9A5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcpqxX60KgqbOApc+2tFfymNWi9qsca/7equ13HyS7E=;
 b=QqDwapHxCOHgAmy2EpUrp8/bujb5JD6p4yMKxYjWGsrQTOyc2Ze7Mof1M6UEyhrDTZvprH2uospIucY4bo8Bzj7pDZOfwgmrap1CKed4sTwkRrcnZ+07aCZ9gz32NtZQxCtlVb/AYFFcQQqCak92dSU2zLGA3NdR2kPfnL048iE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB6679.jpnprd01.prod.outlook.com (2603:1096:604:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Wed, 13 Apr
 2022 08:48:11 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 08:48:11 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] idmapped-mounts: Add open with O_TMPFILE operation
 in setgid test
Thread-Topic: [PATCH v3 3/5] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Thread-Index: AQHYTljK8sWn4CDMO0Or1rGEhMQg3qztflyAgAAcZQA=
Date:   Wed, 13 Apr 2022 08:48:11 +0000
Message-ID: <62569C96.3080207@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220413080733.6sz3tssi4wo3jc67@wittgenstein>
In-Reply-To: <20220413080733.6sz3tssi4wo3jc67@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f8591fb-4d44-4e01-3371-08da1d2a5728
x-ms-traffictypediagnostic: OSZPR01MB6679:EE_
x-microsoft-antispam-prvs: <OSZPR01MB6679F99D9964F497442B1868FDEC9@OSZPR01MB6679.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmB0vH3UIthPwbEscZ/xSPxTBz6t0teQjB+KDXL+O+xDYlatHSDpaOGBkjjWazgunw+sJ+Aoac8KyQDnrwtVVlaSkXhtXXa9fVDBh7alUAbu0AgspJ/LrlWaPRSxDjUJ3f9rTKJhpElhX37Te8JxotoCpHFJt5xW4Q4XvmeB53RaYa9XKT3yRTxNhzrQwR0dHQLhagtjV+9ZTV+XOeAwS00aHP7ycIPtJPodHhMej131QDDoYOVyT4ScPjk+QpOZuxK4Kb/lN0tENSoTu2XfQDP5SWCnEU1R1sPLepRBvyZp2SsNuNGlchT8NbWcDrTZT6t8m/CK0Fjppyyaagfo8y/oM1mTvdXCFmJcMKpfv7+hM69o168SkTTlCygcsqz18Pt6G9gnPv5FBLr/xRGZVx0BvXPsG826IX8IjvjAp0cHLsN5JF0Ne21qd8CT89I4N5MxcyRJCgKX54o22h48ZiK6/NuldDOs+iY0z1AoaaHEQ64x8UX9+d5Yxh2aSjsjZI4T8GpIJjL/XQmwuiIkXldK04f/5PKfvdwy8KPrm+AVcfvGLDJyaP1M/YCEffLmP5pittM6bJovE6gsvWVmUtxHiDz5YD2D5rifhLVEa+Le0f3dHjfYPEthn7YFmYShXHg8/WBczD0lKadC7k7+BMjc+sF6uahbCOh8INxACsLgihRUkRntkNyziP1kWtCl948Fn9VD6S4UUvnjxvWstQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38070700005)(33656002)(71200400001)(2906002)(38100700002)(6916009)(122000001)(82960400001)(316002)(54906003)(91956017)(8936002)(83380400001)(5660300002)(4326008)(85182001)(8676002)(36756003)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(2616005)(26005)(45080400002)(186003)(6506007)(508600001)(6486002)(87266011)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBRUWtNb0J3YVFIcXpBNG42V0N6QTdWQStNbmxrN2txdHNRRnZ3NzdCNkJj?=
 =?utf-8?B?V25sSGZHbWFWTFVPZEJRZlIvbUhNUzFZVlJEc3AyN1pFOUdZbzM3WFNsUnNI?=
 =?utf-8?B?OUpRWEdJYWhkb29aMkpiSnV2V0VmSlI0QXkrZER0T1M1bTdYMnkwZEVkbDhH?=
 =?utf-8?B?b3pQcDF6RXhpdnNlY1NtV1RuQWduTVFkQXBMVTkweU9PL3VJRVMxMC93MDVw?=
 =?utf-8?B?cEQ5Z01oemcwcThpZjNicFdWUVRGSGViL1BCUUVMTUgxNGlabDJud1ZjaGs3?=
 =?utf-8?B?RU9KdzRPMHRHbkFHYUliamRyUmlRT21pODdIQnE3bThSTzdMbjk3NW9mSFMx?=
 =?utf-8?B?THRHSHBoeWtXckVsR3VVYmdYVHFNVHh3aWhOOFZsV3d6QWpjb25rODNOYXVo?=
 =?utf-8?B?cGIya2R2SDAzWGNHS3VkMFg0NUFKalJqZEJCKzBMYnllMzRzYlNQSDgxTUxT?=
 =?utf-8?B?MWhzcGlmREExTW1LVjFndFNpRGtwTDcxT3hFTVFMeTIvTldzck9MYVBxY2Iz?=
 =?utf-8?B?ZThRdW1wMWNaMVdjR25XekhHenJnbWd0aTMxNzhCSk1MUlBZbkR6MFFDZWtm?=
 =?utf-8?B?MjBaVjJEOVhPSDRzUWR1RDA5TmpEYmRWdjBRU2hSdFBLZUFxbm5tbm45dnNT?=
 =?utf-8?B?VUpBeWkrZVk0cFFmOENlOXlodzVMMGtXRjN2SnRPTTJyRVhOZEVicnV1RjQy?=
 =?utf-8?B?VXM0SVQrY0JsQ0w2dDVqbk1XNzI1LzU3WXdqMjlmcGhJMDY3OGxJOUpmU2Fh?=
 =?utf-8?B?b3lqSmdRYU9OeUVWVmZ3a3hDNnRRdElIcFZMN0NWUFVYZXJNVVZET08vWkU2?=
 =?utf-8?B?SndOMXIvY3Y0RFUwNGx3UmhyMjJQYThlMUpHK2M5cXRxS29FL0dxVHF4N0Jp?=
 =?utf-8?B?M1hsYjJJT3UveUc1dTlyRXdIU2RKTGxiTmJGUTdlWTdkWC8wRTk2Um9VeXVR?=
 =?utf-8?B?U29wcHN3eThvZTN3d01Xdk00L1R1THc4OTRIelBKMURZQzdtSjZpYUg0T1JI?=
 =?utf-8?B?RjJsV2pNaXJWb2phUHpZL1Z6K3lhZGdmVTB3MmFlSFIzUXNWVnhYSU9TYW1T?=
 =?utf-8?B?aWh2SUN6ZC92RTQwNkJaVDlSK1IxcVNxV0xsd3FlUkNaQVJMc2VWWGs3V3Fr?=
 =?utf-8?B?ODQ2WGNXSEFDSkoyeWIxdlNjcEVpUkxmTWJNRWRROU9JT3ZuYVZPTlU2WWM3?=
 =?utf-8?B?Vyt3akw4d1B1RStHTGtZcmNTYWtQVU9mcDRKUzQ3d3hXaWdtNDFSZEpBamdZ?=
 =?utf-8?B?NDluMFRBcnQ4SjFZOGNVQ0w5d1BBdk5MRk5rUEs4N2RYSjIxT1NJWWRYSVFR?=
 =?utf-8?B?MnM4UGhscmovK1ZZUmVVbGFqeG8xMSs4bVhvbWhMS294VVUxT01EbHRVZTdi?=
 =?utf-8?B?WUpOUHNJaWIrTkdNQ29sQmRTMnR3VzRVV2FNS0lVQ2w4bkVhMVhCTmNUWlJu?=
 =?utf-8?B?c3FsTmRKUDhDMmpHYmx2RVhUc3pKdUxiTlNTZm96Yk5hemJleFRLMkVaZ0FF?=
 =?utf-8?B?SmNxdldqekMyektaTWdPMkR0UHVkZ0M5Y3IwOEdnRFgzeGJpdHoxUXlpZGNH?=
 =?utf-8?B?cEZKVUZFdWFOczR5ME43MHM4aG56K1B3NmtmdDQ5OHE4dExKWmt3NDU0RFZK?=
 =?utf-8?B?QkYvNFlqbm5MRlBFeGZESktzaVY5WVk4aGM0a1VvSENtcnBabmQ0d0xFdWdS?=
 =?utf-8?B?aEt5R2oxWkxONHh3K3NMNjZ1NWpkYkVPNnhZN25zb1dLVVA2M2dsRXp5Yi9O?=
 =?utf-8?B?emtMQUJrelB1d1hoSFV1WUtQTDZvb2ZnaWpaRU92cndadTN1WkVuYXlHcWdJ?=
 =?utf-8?B?Zis0aXNyMWhNc3ZjNVlWZGZaRGRmZ01XSHJQS2tIK3Q5b1laQlNiODljYi9E?=
 =?utf-8?B?YVJBQU5WLzI4a25jVHg5Um1YbkovL3hHdnpGNStnNDZXeUhnOFpBSG9uUVdx?=
 =?utf-8?B?OTRwRlRiVkhBKzBoR0NwWldacHMrbHdNZXgxNXRTZlhuaE5NU0xxaDB5K3Ju?=
 =?utf-8?B?bCtSTXd1cVpnN3JvaGZuekp4V3V2V1dZTytHb2hzUEtmelVxeWZVNkZMa2ZI?=
 =?utf-8?B?ck16L0tWKzloL01NcWhlYzZBeVJhdy9xc0xXdXBHK3RnMDlETU5ucndFenMr?=
 =?utf-8?B?SXNCTDhsUyt3S3Qza1k2d0FCb09BUEo4U3A5elYrZzZjTTh1WGdWamJ0YlI2?=
 =?utf-8?B?T3FRcjdrNTZ1SlpSb2J6Sm8zVEdWVG5KM2twMlBwU0xaYTFhQ2ExMkxlZU1H?=
 =?utf-8?B?dVNkcTE5aTkzUFdrVjRlZ1NEd0YvZVhTS0xobUdoVjMzOTU4UGpkaDRrUE1F?=
 =?utf-8?B?bmpncXE5dHBTc3dhVFR6eGpneHBTL1hPQWFiSWNTL043MjJDQW9VeUU3S0dP?=
 =?utf-8?Q?7leirOk4sHqt2qmMxC9anZIB7WDXQ/WeeYdKR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A813A3E4C9B8F949816C894F699E5BE4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8591fb-4d44-4e01-3371-08da1d2a5728
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 08:48:11.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaOq4VkSWdnvwxFV6E5NK1PGpQ6C0ExPLAeWqyYjpCsKyxIcpZBVH/4qCS5z7kNKaMQauBB7BQLOS58KORdAp2HtQvLPW1EKIUxdI/MDHjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6679
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzEzIDE2OjA3LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTIsIDIwMjIgYXQgMDc6MzM6NDRQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IHdlIGNhbiBjcmVhdGUgdGVtcCBmaWxlIGJ5IHVzaW5nIE9fVE1QRklMRSBmbGFnIGFuZCBmaWxl
c3lzdGVtIGRyaXZlciBhbHNvDQo+PiBoYXMgdGhpcyBhcGksIHdlIHNob3VsZCBhbHNvIGNoZWNr
IHRoaXMgb3BlcmF0aW9uIHdoZXRoZXIgc3RyaXAgU19JU0dJRC4NCj4+DQo+PiBSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1pY3Jvc29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0KPj4g
U2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+PiAgIHNyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91bnRzLmMgfCAxNDggKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0OCBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91
bnRzLmMgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiBpbmRleCA2
MTdmNTZlMC4uMDJmOTE1NTggMTAwNjQ0DQo+PiAtLS0gYS9zcmMvaWRtYXBwZWQtbW91bnRzL2lk
bWFwcGVkLW1vdW50cy5jDQo+PiArKysgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1v
dW50cy5jDQo+PiBAQCAtNTEsNiArNTEsNyBAQA0KPj4gICAjZGVmaW5lIEZJTEUxX1JFTkFNRSAi
ZmlsZTFfcmVuYW1lIg0KPj4gICAjZGVmaW5lIEZJTEUyICJmaWxlMiINCj4+ICAgI2RlZmluZSBG
SUxFMl9SRU5BTUUgImZpbGUyX3JlbmFtZSINCj4+ICsjZGVmaW5lIEZJTEUzICJmaWxlMyINCj4+
ICAgI2RlZmluZSBESVIxICJkaXIxIg0KPj4gICAjZGVmaW5lIERJUjIgImRpcjIiDQo+PiAgICNk
ZWZpbmUgRElSMyAiZGlyMyINCj4+IEBAIC0zMzcsNiArMzM4LDI0IEBAIG91dDoNCj4+ICAgCXJl
dHVybiBmcmV0Ow0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBib29sIG9wZW5hdF90bXBmaWxlX3N1
cHBvcnRlZChpbnQgZGlyZmQpDQo+PiArew0KPj4gKwlpbnQgZmQgPSAtMTsNCj4+ICsNCj4+ICsJ
ZmQgPSBvcGVuYXQoZGlyZmQsICIuIiwgT19UTVBGSUxFIHwgT19SRFdSLCBTX0lYR1JQIHwgU19J
U0dJRCk7DQo+PiArCWlmIChmZCA9PSAtMSkgew0KPj4gKwkJaWYgKGVycm5vID09IEVOT1RTVVAp
DQo+PiArCQkJcmV0dXJuIGZhbHNlOw0KPj4gKwkJZWxzZQ0KPj4gKwkJCXJldHVybiBsb2dfZXJy
bm8oZmFsc2UsICJmYWlsdXJlOiBjcmVhdGUiKTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoY2xv
c2UoZmQpKQ0KPj4gKwkJbG9nX3N0ZGVycigiZmFpbHVyZTogY2xvc2UiKTsNCj4+ICsNCj4+ICsJ
cmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gICAvKiBfX2V4cGVjdGVkX3VpZF9naWQgLSBj
aGVjayB3aGV0aGVyIGZpbGUgaXMgb3duZWQgYnkgdGhlIHByb3ZpZGVkIHVpZCBhbmQgZ2lkICov
DQo+PiAgIHN0YXRpYyBib29sIF9fZXhwZWN0ZWRfdWlkX2dpZChpbnQgZGZkLCBjb25zdCBjaGFy
ICpwYXRoLCBpbnQgZmxhZ3MsDQo+PiAgIAkJCSAgICAgICB1aWRfdCBleHBlY3RlZF91aWQsIGdp
ZF90IGV4cGVjdGVkX2dpZCwgYm9vbCBsb2cpDQo+PiBAQCAtNzg0MSw3ICs3ODYwLDEwIEBAIHN0
YXRpYyBpbnQgc2V0Z2lkX2NyZWF0ZSh2b2lkKQ0KPj4gICB7DQo+PiAgIAlpbnQgZnJldCA9IC0x
Ow0KPj4gICAJaW50IGZpbGUxX2ZkID0gLUVCQURGOw0KPj4gKwlpbnQgdG1wZmlsZV9mZCA9IC1F
QkFERjsNCj4+ICAgCXBpZF90IHBpZDsNCj4+ICsJYm9vbCBzdXBwb3J0ZWQgPSBmYWxzZTsNCj4+
ICsJY2hhciBwYXRoW1BBVEhfTUFYXTsNCj4+DQo+PiAgIAlpZiAoIWNhcHNfc3VwcG9ydGVkKCkp
DQo+PiAgIAkJcmV0dXJuIDA7DQo+PiBAQCAtNzg2Niw2ICs3ODg4LDggQEAgc3RhdGljIGludCBz
ZXRnaWRfY3JlYXRlKHZvaWQpDQo+PiAgIAkJZ290byBvdXQ7DQo+PiAgIAl9DQo+Pg0KPj4gKwlz
dXBwb3J0ZWQgPSBvcGVuYXRfdG1wZmlsZV9zdXBwb3J0ZWQodF9kaXIxX2ZkKTsNCj4+ICsNCj4+
ICAgCXBpZCA9IGZvcmsoKTsNCj4+ICAgCWlmIChwaWQ8ICAwKSB7DQo+PiAgIAkJbG9nX3N0ZGVy
cigiZmFpbHVyZTogZm9yayIpOw0KPj4gQEAgLTc5MjksNiArNzk1MywyNSBAQCBzdGF0aWMgaW50
IHNldGdpZF9jcmVhdGUodm9pZCkNCj4+ICAgCQlpZiAodW5saW5rYXQodF9kaXIxX2ZkLCBDSFJE
RVYxLCAwKSkNCj4+ICAgCQkJZGllKCJmYWlsdXJlOiBkZWxldGUiKTsNCj4+DQo+PiArCQkvKiBj
cmVhdGUgdG1wZmlsZSB2aWEgZmlsZXN5c3RlbSB0bXBmaWxlIGFwaSAqLw0KPj4gKwkJaWYgKHN1
cHBvcnRlZCkgew0KPj4gKwkJCXRtcGZpbGVfZmQgPSBvcGVuYXQodF9kaXIxX2ZkLCAiLiIsIE9f
VE1QRklMRSB8IE9fUkRXUiwgU19JWEdSUCB8IFNfSVNHSUQpOw0KPj4gKwkJCWlmICh0bXBmaWxl
X2ZkPCAgMCkNCj4+ICsJCQkJZGllKCJmYWlsdXJlOiBjcmVhdGUiKTsNCj4+ICsJCQkvKiBsaW5r
IHRoZSB0ZW1wb3JhcnkgZmlsZSBpbnRvIHRoZSBmaWxlc3lzdGVtLCBtYWtpbmcgaXQgcGVybWFu
ZW50ICovDQo+PiArCQkJc25wcmludGYocGF0aCwgUEFUSF9NQVgsICAiL3Byb2Mvc2VsZi9mZC8l
ZCIsIHRtcGZpbGVfZmQpOw0KPj4gKwkJCWlmIChsaW5rYXQoQVRfRkRDV0QsIHBhdGgsIHRfZGly
MV9mZCwgRklMRTMsIEFUX1NZTUxJTktfRk9MTE9XKSkNCj4+ICsJCQkJZGllKCJmYWlsdXJlOiBs
aW5rYXQiKTsNCj4NCj4gRndpdywgSSBkb24ndCB0aGluayB5b3UgbmVlZCB0aGF0IHNucHJpbnRm
KCkgZGFuY2UgYXMgeW91IHNob3VsZCBiZSBhYmxlDQo+IHRvIHVzZSBBVF9FTVBUWV9QQVRIOg0K
Pg0KPiBpZiAobGlua2F0KGZkLCAiIiwgdF9kaXIxX2ZkLCBGSUxFMywgQVRfRU1QVFlfUEFUSCkp
DQo+DQo+IGZvciB0aGlzLg0KT2gsIFllcywgaXQgd29ya3Mgd2VsbC4gVGhhbmtzLg0KDQpwczpJ
IGFsc28gdXNlIHRoaXMgd2F5IGJ1dCBmYWlsZWQgYmVmb3JlKEkgdXNlZCB3cm9uZyBhcmd1bWVu
dCBOVUxMIA0KaW5zdGVhZCBvZiAiIiB3aGVuIHNlZSBvcGVuKDIpIG1hbi1wYWdlcyApIC4NCg0K
QmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo=
