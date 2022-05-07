Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3D51E310
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 03:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442883AbiEGBh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389512AbiEGBh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 21:37:27 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C45DBC7;
        Fri,  6 May 2022 18:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651887223; x=1683423223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AfI7AvfmgBK0J6O/AvkKj28CE5p/VdRdrBKCXJIjo5Q=;
  b=r71bXQzymX9QwqYcktyx9Q22wc67CK5qFwFrkQ0Ed3L6Xu4zwaeAwDoD
   7weXT6HOx25BiKZdVSu77SGuO5gFA+JN8X/J+m3lFn9404p3seqGeSt2+
   f2921pjqAQdzOBSZZ4f4ExInhDghx6nAdFrlp9y6gNQkjezA4XhOaf0sr
   Zkm7FcwH2eqn0WNw5KguRxy2Ul1G2jRLq+ylZYAIEdOEe043U3c/22iyW
   Zfr9+DxlwY73/tK14aNn+PBllsZOyRltxWGHy46KANQWOm6BDCpFmDI61
   dwTHdprehNFqRWB9UXjSaPFwa1C0YzY2+CE3Xavvdc8J84mjXp7ki3cHS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="63376387"
X-IronPort-AV: E=Sophos;i="5.91,205,1647270000"; 
   d="scan'208";a="63376387"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 10:33:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7giWHnTz5yZqZntY4bPOnLWlxX0R/V+UziaWCF6Y9YOk5wuKsQi0YVpPivTBAcEdhJ2l9UNeHvWUj3A550I0dOdUWZQwCqAjp8DeBio1QktKg+/XvKQkndAc00VrHOp7tF/Qtq6laL00haN1aXWAEoK4VPQPVX4LgVsk0POEwUW2hFPuNUBJxdnS8lRSRhQeM4Wq5qq0hDTqyvJbwolndQFzUfdt/s5L8LiHaIVztBM0orNJvnBu9u+t2aKPIJJOvOkoZh3Dh7KZsLauxOl1e8h1DfdGpTzc7Rhjc+jdYyeD8XH73bRRrfiAecAya8IOPzrrf3f7GdxS9GY3+fv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfI7AvfmgBK0J6O/AvkKj28CE5p/VdRdrBKCXJIjo5Q=;
 b=iVLNYijbsRvvwJRisU3m/foDh/em54V6h8uAfcAG9nquAx+sl2BA90gHyou7H0Qn7hn95icdOYMDOZZ0D2hbB/7+nLVZDYAQAsovmws/ipuP3A/F2FqlVaLyF5T+9puTWxERZ3K5G4k7aT0hSI+zF+XvK3H+8Vqi+h9OhDQBugTdHkiJZOfmAuXqu88XeZXPK+yySzPBT5dppaDCutLDN+baKs/Rgz6XSAN2GnX6kGsADi64qlV8yD3ykP1wykgMFC43ZvKXcGybZfRJk5zOTIUDq1iDv4dTnXOoKsM3ueYrAZ0zIIpngcPLjTEBGevfkJyihI+U7c2LuikJaRQx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfI7AvfmgBK0J6O/AvkKj28CE5p/VdRdrBKCXJIjo5Q=;
 b=Q8VQp/GzAvip2AUiWKunmmCFpIJEfa7cHqf/waq4WtO6KdGnOVY++MFfGh4PJCIOlPCtZ+/eeIg5RirHdUE3gVu4hbRVgO0Sn+PFf2DaMgUBLt4ZbId3B3XEFO4RwCf7y9kCamuPW7f5cR0q2HhAk+OI3qCersM5tpe1z5ukAxE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Sat, 7 May
 2022 01:33:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29f4:d377:6e85:ea51]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29f4:d377:6e85:ea51%6]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 01:33:33 +0000
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
Thread-Index: AQHYTljA7n6MB3+pbU6sBga2TGnr2a0S2UaA
Date:   Sat, 7 May 2022 01:33:33 +0000
Message-ID: <6275DAB9.5030700@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8c32034-e683-41ed-4bba-08da2fc99942
x-ms-traffictypediagnostic: TYCPR01MB5581:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5581346C195EFF1524F48313FDC49@TYCPR01MB5581.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oY2EfNpn7k8MUGpEPb50Uj/QKMeuhdAM30oywGiIeCXadxLRBst0vr6DLVA9V89ClswePVWn8Jz3N701O6EePZceExn7Yfy+A7leoleodvS5fdlYOtl/z8qdYvGQqxeptK6c29zQDwY60JeLy/TnYNY1YkPM062xk7FLj1W8eUttwp1V61ZVKmjfGq6YeHU397Dh+VhVtn1yzMkcAYhrqMPU5T4Y1hIRSrN/AywJhI0sxqrRyOKuvOl34LReIswrqT2YJA0PUmxR+w1UlFGzAYFWswZn43qrFDfEg+/qvtMwRGnvccRH8vs9ruL8UPVV61w5Tg0NlPeJk82v5uJqQgYoX9136ndrcpwHO0HyHg5/ZYALj7AY8hoJT98t6qKH4UjkbQRfMz2cg0bvNIq7iwXVUOdhZCoR+bbbXzRon+6TNSZAVcWOp+LhbQl+XVdl8l1lK593gNrLALlZuhwm0rNYpQtePqOMOtBrdMR8D+31omWDdxcCbCaeKmoXj77cao/GXZBk54jJT4Kpr0MdKZeP45J/ueVpcAPSRXVLZG5BHQe7RlHgO+nG590Un5jT3hDnN3bdKLI1min1y71vvjdagxSsewcDLQVG28dEQUP+CNXwDnr/J5mfbPSU2pBk4T7e2cXjm6iMlM1x2GtdIXWGZDnQ3cM5qnHrVJPrVQSm0keaPC6ffF7/EIy9QEZH0DmfwnUxgwnK7C1KxFn+lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(76116006)(71200400001)(66446008)(8676002)(4326008)(66476007)(66556008)(66946007)(38100700002)(6486002)(508600001)(86362001)(122000001)(5660300002)(316002)(54906003)(38070700005)(6916009)(91956017)(82960400001)(8936002)(2616005)(83380400001)(186003)(85182001)(26005)(6512007)(36756003)(33656002)(2906002)(6506007)(87266011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZUI4a1YyUTVlSk02S0h4U0JTN1RDN0lYYTFSTTROa3FLeDdlLzV4QTMwQ2tF?=
 =?gb2312?B?VllPKzBUcklDdGlRaGordEtUV1h4dFpxUWdaNG56bjI5R1ZJWnJHUkdTdFFC?=
 =?gb2312?B?a2phYnFPd1ZPdzY4RzgwWDc4SndtZlNKQkg0SVpEL3orZ2hpbHBnVW5CUVJ0?=
 =?gb2312?B?TG90ek5BVXhkWTBtb0ZKOXBnVTF4WFRWOHdPUnYwQWR6QXl2SVdVdGEzQ2x5?=
 =?gb2312?B?NGxvNVhKYS9xMUh0YUFzWWh1OVhCQ3lvTmFaVjNFQkEwVmZYMGJmQk5lWW5L?=
 =?gb2312?B?NGRHRHg2S3dYWkkrZWdIWXh4SjhTK2pkR1UyaDVTenU4WDZIbjRDbjlmSHI4?=
 =?gb2312?B?bFNpVWZaNWw5RkUzeFJXYTREcVphVkxoeDJjSm5MQnJsMEtPblNwYWFJdGxQ?=
 =?gb2312?B?dThGcFZadUNWUWtPUm9nRDFEUnMyUkt6cnJZYitwN2FJeEZKSllxZFBkbkJG?=
 =?gb2312?B?T1B5UU5Bc21OYW9iVThzSUVRL3pKbnJlR1VHVUMwczdtenpuejdWWFJ1OElM?=
 =?gb2312?B?SGFzckhmcG1JMXFuVW1zRElkOVY5Z2JRdGNBc3daVWhsKzlLOERmcmJHRlgw?=
 =?gb2312?B?NWhNRk93aDNnZngwL0xrdk81bU01MFU5blVPSTZYRURiQkEvWTVseHJ4TkpC?=
 =?gb2312?B?alp4cGlrb2Yyb1ExL1M5U1BhM01iRGNqalBrVXp4bHhwZlp4OTJUbGZ0aEpj?=
 =?gb2312?B?UDdZMzVweXR4SVpzeU1IM2VScGR4dCtTcEJjamJtcGxhSUhCZENXeFcwV0gx?=
 =?gb2312?B?RHVtWHdMMVcvMHJiUEV0RGczL2xUWWZwa1hiRlVHSFBldnczQm5wRHJ0bkQ0?=
 =?gb2312?B?c1JXRXNWMnpoUnhNUXFMOXBERytKQnpHUk05OFgzSlZpVEY4ZEtzMFljWnFn?=
 =?gb2312?B?NmFoMzZqK3JtTzBTZXh2Z2RkdGFSSVFwRUhDSnR4SnM0YXE1aWFpU0MrM0R6?=
 =?gb2312?B?bXhZSXcyVjlBcGgxZWpENjdHQ2xCS2pwQ3h0aThRSTUwWkY4NjB6RG9kbzJw?=
 =?gb2312?B?OUNGYTNNSUFvQzR6TkhBMlB0ZGVWdW5yWGJxbklidDVCVlkyeFJTVjFYRjNM?=
 =?gb2312?B?ZUF2U1JNdHJzWEJITzdDRjFNTjdVYVR2ak9mTHRVenlrMU9NRkhsK3FTVjlW?=
 =?gb2312?B?Y29LM0tzeWZZcVczRTRybHNDZ0JOMkozMVRGQ0lUTWFaS3RiNjJlNnplMmNz?=
 =?gb2312?B?TlZzY1hpZ3hvNjJwMTBBdVhocDRPWHBiNmF2b2F1NFNBZkNMeGVLUnR4bXZX?=
 =?gb2312?B?U2h5SmRDUHEyYzFYanc5TGV3NXJncG1WK3hqeXJtWXFRWjFRSEhFM2pnSTdT?=
 =?gb2312?B?RjVZenYzMDVWZEpXakZBa1ZXUWRldVZwNVZjZC9FRVFrbEpLYVR3ZlBFM2VZ?=
 =?gb2312?B?RXlTcDgraTIybUdJQU1xZWErWWFXRFhzYkpsMnpPOWtIZ3p1QUQvWHloRlpu?=
 =?gb2312?B?V1VGVlNvbFdmdEVwdHVoZG9kS2dhSlhVL3dUaDZvdFBMak4xV3lkQmNJRHlN?=
 =?gb2312?B?aU5pbDdRNXZhV3BDS0l6NWdQaGdQbk82WmJBS1FNWThob1RhL1oxZ1BKdFJt?=
 =?gb2312?B?WUNSVDU2RHZuTzFWYjdwZHlwQU8xUXBUSGpVbEVCTC9nR0w2elZaQmJBb2ZO?=
 =?gb2312?B?RTBrS1paT2QwTXZ1WTBQS3FadXlFbGpJVUQwbmpkaERWVE44ckFscEVRUXJ4?=
 =?gb2312?B?MTlSYXpqc0JTQ09QcG9LWDJDU1BpSkc1WEhiSDdDZ2xjS0l3TVkwaE5vRDJC?=
 =?gb2312?B?QXpVNkJuVFdCamN0QXViVVRuNm04bzNiM0VnUjRRNitjOWdjTURHSTJqMjMw?=
 =?gb2312?B?UW4xeUpzVCtyNkk1ZTJ4VVQ4dVIrUlgzcWNEbVNPU0VNUm96UmIvZ0JoOU80?=
 =?gb2312?B?dURSTlJnMXIvNHZNREtkVFZ6MmhoRW16TTJzR2RpV041Wk81cmxFZFJmZmJn?=
 =?gb2312?B?U2xCVEJqemgxb3pPMWs5ZEJ6dUlWVUx4UDBXT1d3Z0hJdkdJZWRjUk1MbUV4?=
 =?gb2312?B?QmpoNUJOaDNwL0Z5eVVMNWdZTVlEekY1NGRVbnAybUFSWXViZG5pZkl5cmJn?=
 =?gb2312?B?TE5XaStnVkg5T2xjZk1GenlBUXM3OWxlTk9UMGdnUUhqU3lTbHJURDNvcFE3?=
 =?gb2312?B?cWZob0tRSGhENnd6a3BQejJDVGwvL1ZPcU41YzRUSXVHR1NCK3RLbTBEaG5z?=
 =?gb2312?B?NWRrV3l5dEM3aWt5eUdQaGRZOGd0WGRNT0xiZm5abmVzbFFaU2E4a1ArWWJK?=
 =?gb2312?B?OTBMLzNRV25jOUtLRitycFByZE9VSHBQanI3R1cySHo3c1dwdmlmYm4zOXhX?=
 =?gb2312?B?M3pZUmUybEpka25DZGJhK0w2L1ZiZ2k3dlpMbXcxVXV4Uko5cUFVMnBKaDhK?=
 =?gb2312?Q?hzhagDL/tSOmGBKk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <0A37064A9F5B2E4F8980E3E12FC00144@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c32034-e683-41ed-4bba-08da2fc99942
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 01:33:33.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDYGnwx9mcObvE5teZ7lL4zxopEzDjYxyMxL8vanUy40sYFXxYkSnEIMZIFOl3dmkeOd/fDmQ5iIpu6B6iai7OOeChJ7airbd4qsdnKTKxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5581
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgWm9ycm8NCg0KU2luY2UgIENocmlzdGlhbiBkb2Vzbid0IHNlbmQgIGEgbmV3IHBhdGNoc2V0
KGZvciByZW5hbWUgaWRtYXAtbW91bnQpDQpiYXNlZCBvbiBsYXN0ZXN0IHhmc3Rlc3RzLCBzaG91
bGQgSSBzZW5kIGEgdjQgcGF0Y2ggZm9yIHRoZSBmb2xsb3dpbmcNCnBhdGNoZXMgdG9kYXk/DQoi
aWRtYXBwZWQtbW91bnRzOiBSZXNldCBlcnJubyB0byB6ZXJvIGFmdGVyIGRldGVjdCBmc19hbGxv
d19pZG1hcCINCiIgaWRtYXBwZWQtbW91bnRzOiBBZGQgbWtub2RhdCBvcGVyYXRpb24gaW4gc2V0
Z2lkIHRlc3QiDQoiaWRtYXBwZWQtbW91bnRzOiBBZGQgb3BlbiB3aXRoIE9fVE1QRklMRSBvcGVy
YXRpb24gaW4gc2V0Z2lkIHRlc3QiDQoNClNvIHlvdSBjYW4gbWVyZ2UgdGhlc2UgdGhyZWUgcGF0
Y2hlcyBpZiB5b3UgcGxhbiB0byBhbm5vdW5jZSBhIG5ldw0KeGZzdGVzdHMgdmVyc2lvbiBpbiB0
aGlzIHdlZWtlbmQuDQoNCldoYXQgZG8geW91IHRoaW5rIGFib3V0IGl0Pw0KDQpCZXN0IFJlZ2Fy
ZHMNCllhbmcgWHUNCj4gSWYgd2UgcnVuIGNhc2Ugb24gb2xkIGtlcm5lbCB0aGF0IGRvZXNuJ3Qg
c3VwcG9ydCBtb3VudF9zZXRhdHRyIGFuZA0KPiB0aGVuIGZhaWwgb24gb3VyIG93biBmdW5jdGlv
biBiZWZvcmUgY2FsbCBpc19zZXRnaWQvaXNfc2V0dWlkIGZ1bmN0aW9uDQo+IHRvIHJlc2V0IGVy
cm5vLCBydW5fdGVzdCB3aWxsIHByaW50ICJGdW5jdGlvbiBub3QgaW1wbGVtZW50IiBlcnJvci4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4N
Cj4gLS0tDQo+ICAgc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyB8IDIgKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
c3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyBiL3NyYy9pZG1hcHBlZC1tb3Vu
dHMvaWRtYXBwZWQtbW91bnRzLmMNCj4gaW5kZXggNGNmNmMzYmIuLjhlNjQwNWM1IDEwMDY0NA0K
PiAtLS0gYS9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jDQo+ICsrKyBiL3Ny
Yy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91bnRzLmMNCj4gQEAgLTE0MDcwLDYgKzE0MDcw
LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gICAJCWRpZSgiZmFpbGVk
IHRvIG9wZW4gJXMiLCB0X21vdW50cG9pbnRfc2NyYXRjaCk7DQo+IA0KPiAgIAl0X2ZzX2FsbG93
X2lkbWFwID0gZnNfYWxsb3dfaWRtYXAoKTsNCj4gKwkvKiBkb24ndCBjb3B5IEVOT1NZUyBlcnJu
byB0byBjaGlsZCBwcm9jZXNzIG9uIG9sZGVyIGtlcm5lbCAqLw0KPiArCWVycm5vID0gMDsNCj4g
ICAJaWYgKHN1cHBvcnRlZCkgew0KPiAgIAkJLyoNCj4gICAJCSAqIENhbGxlciBqdXN0IHdhbnRz
IHRvIGtub3cgd2hldGhlciB0aGUgZmlsZXN5c3RlbSB3ZSdyZSBvbg0K
