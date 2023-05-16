Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4670420E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 02:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbjEPAGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjEPAGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 20:06:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495A7AAD;
        Mon, 15 May 2023 17:06:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsMp8009859;
        Tue, 16 May 2023 00:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fMtro6Be9ILHpgiNw4I7vaYT6KqUq4ebPZCPoj5/TGQ=;
 b=yI1ngn32JcBntQNh1HijnRsgrQdOci+PRVVaQmphpespffBNaJp736FIaOvhPAlHDrR0
 hcZ05zr+UlCU3UJdXaTnYux9cSqmS0MNDGh5JT9dJ+4gCycfNW6v2b5J0AFhNK65wadp
 8NrVfWXLUVZ8byF1ZYjh7f3VjiOlF0U5hXeXKO/ioahaywDzBRPljK9QBKi0Sv8YeJOi
 AhcHBo3WoGJ9PMZ/D3stvBbw6qGSvpZZ2X6v5L5mYSvq1LlhDZpjInlBPqG+4sts8MAG
 jzkLi8fmNuXF8O7zE9LmU3rdmg6/xdiwt6Pb19AsbvUtJAY5qiSJppuvuPWS6ci57dM8 lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb13ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 00:06:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMUDqq023314;
        Tue, 16 May 2023 00:06:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1033hu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 00:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+nkUJtUrxAMBdmDKrLsxfEsKJnlSnPU55SFPd/4QmtC74/yOvNP+frv8fLX03B7/RpBcbc7du7X60fkxBmMOE5me30egmeuLgoZe9NDmKPJFdVaZF7Ve0xlo66cvYVVb5h/cdZquEIMDCLSdSGlNd1qvIpvWqJb5FL3aA9qmj1P0TFcXNDrRWMAUcj3NiCmwRhHftO0ib0ycpz2OgX91r++zIdQ0ZTzFgPJORyNNTg9sj9fnbCcEeqE04E30ttXmtC/8paU8nEvhTOooWziNubpFD4PbK2gHbUfBQ7DL+haRaGUmvkYdp6SkIeoDHmFo9VeKziGMc/VUWp7rMCs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMtro6Be9ILHpgiNw4I7vaYT6KqUq4ebPZCPoj5/TGQ=;
 b=jzwzbTNIHcw6iMVpDFmFdi786nIlK/zE1776yM0n1jsB3MRx6azf+LNIhZ6hHQj+HG/Yf6Pt7n5RqraskrFYdhSJeazFaTzxFrUjUvCmXAi6ni7D9kung/VgobsKhYu3ijF1VuMBrGRMBUyyfR0k2Sm8qs6FnUDIATdmI7WWdQyKHX8SA81wO+HW9RHZkN4nqU47XqL1eTYXrNBoLopdgNZ3fGgbb2Su0+jLioWuRqpqPOIu1J27UgFqtdjC/I2tSk7ecysrFre+T0x0INoaS398GgZtsyJslZa5KP2l3JRy6p5HMyMmLPC5cWNZPjYHv0C+ldm8lc43DTsgvrgDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMtro6Be9ILHpgiNw4I7vaYT6KqUq4ebPZCPoj5/TGQ=;
 b=ZTzxGgXaHpyVSENyCQfSsZcc5Gt2ERWy7Tkc0ZEkIi2Z3eu0yk3oPQ0af+TNvGUZNNKgJz9gzZzt7j+nv16Mx3xiFzxu3wCM96LLTsMYyb8UrwqyFZVLcwaHTK3WDx1SdEsvtxvhgbEoBI8sowsvmyyCUHBhONBjsOppduSL9U4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 16 May
 2023 00:06:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:06:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZhsMdl94xHU6uH0e1krYB7i5sMK9bpMSAgAADSgCAAAjFgIAAFC4AgAADRoCAABUPAIAAFTwAgAAUboA=
Date:   Tue, 16 May 2023 00:06:39 +0000
Message-ID: <D970A651-1D60-4019-8E91-A1791D3AAF6F@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
 <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
 <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
 <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
 <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
 <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
 <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
In-Reply-To: <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6132:EE_
x-ms-office365-filtering-correlation-id: 4eda0ef9-8638-4ae3-8331-08db55a16c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hQsOJ2yAE8BpTCdfP9W43FM/7mRyEtWJ5kg7KZtQupYnGFGbChb+J9J2xboKbo3MUaZGEBag3AkHBPpdfG/4Dn4/EZE0BhMuTG6Ou4tPafGjPfEd3rX0JFCWHNMyME6bDB47HUdpt4qOdsJUC4TB6aUADnBYjAEs1LpHeQ/K7UiyXZB3nLvTrDPwlf8se4Ethu8kKtHgTSEoghd9iZqgGlKqqnAWcpGTXRyI2YHOGLSnQoqYa8k9MGxd5NXaz237B/SQ4yt+fOYjvH6B91YoJqlQCkYrHCKAX4uVNYs7wdv7oDqosLFCbIBZhqLRpkwCuo+UwrFC5k0amXjhDPoh7piW8ihfxvlEH8Q4NcvYVFRK+nU8kwQMb/46MenoIvsCKNRNRV7Gu5AChrpUV38n77Fxqhn/VO5gwX3vBJ6zWpl61ETOABLcCtFmcD4HvU0gTmZIHKAXsowfu69biUuk+OArjBWrJmWQ7xoURYkqNarfKxYRs9yHqgw0hu9Fuq6rDfgHEYzvKrdmPkxayDPIC+XzLh9ps28ekJsZPqbE03338RAaV8GIUqFGxQxQTSiOUReNq078eyTX4gSXaPamA6lN00S+oZcqqZ6IkRaQGChZjje3FCSwZZNt/TM2y6IDJnINjF6pNMUIW14fCFLnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(316002)(86362001)(33656002)(122000001)(91956017)(64756008)(2616005)(76116006)(186003)(6506007)(66946007)(36756003)(66556008)(66446008)(38070700005)(53546011)(66476007)(6512007)(26005)(2906002)(6916009)(5660300002)(4326008)(8936002)(8676002)(71200400001)(6486002)(478600001)(54906003)(38100700002)(83380400001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0VWUWxpRlgvcGFTTml6QUJBNlBPOTU4eEtxNmdFMjdLVXd0dlA0RzlUejVz?=
 =?utf-8?B?elJkbi9uTDl1L3pxcm0wRlFPYUIzMkZjSVFsTkhGOFlveU1TTWR5Y3NzajFX?=
 =?utf-8?B?STFQK2IzWS9vS3BkNkNLY0llNTErN2ZBUVMrVnpZY1NjNnp3Y1ZYSG1TV0d4?=
 =?utf-8?B?VFl6NmQ4U2dydkRSS3kwSXhPZjhJbS9rQXhGVjNMTXhZZEpPMi9SL1o3VUlR?=
 =?utf-8?B?VG56VFozbFVpem1lbTdrUUZqeGE4R3NZaXZUSDArY1Uyajd5UjJNQzl3d1h0?=
 =?utf-8?B?U3hlTlVKQWgwblZLYnA4bzVyc3F1SVRKWFpoTDhwMUl2NS9VSWR2VjQ2bWta?=
 =?utf-8?B?RXVQNG04MmVoZmNYcWFSSFY3L0tMa3ZVenF4V1BVaitFYVcvOFlMV3JCaUha?=
 =?utf-8?B?dDR3azlVOEZEV0R4S0liWFFKbHR4Q1VpL1NNZ0w5amtEcjdWTmpOME9ZYzUv?=
 =?utf-8?B?aW9KOEdRSEQ2MHorRlRGTDFVS1pIN1g1by9hRjdxbUljLzdIVjZKYUJpZ0hO?=
 =?utf-8?B?ekFsMFAvR0cyNXg4QXNWeCtVd3NmUWJMNFY3WFRnbW9ydFRBUENzK3RmNldr?=
 =?utf-8?B?T0J1YTlqZ09mZi91d2NOZDgwTHlNZk41SzlXOStYZmJqRHpmVm02MWFDNjBa?=
 =?utf-8?B?bzQ5eXkvY241V2hmMkxWRG4veUFDdWYvcEtBUERGWHFVRExiTG1UbG5XeHdy?=
 =?utf-8?B?K0x4SnFzb0hkWnpabG5RR0RTZUtKc3VKT1JPN1lrOEZGNFIvaERHUFMwQ0F6?=
 =?utf-8?B?d2V1WjRKRzIxcmRYL2NjWGtZelo2Y2tOcUtpYlhHTmdxYnFDNS9CMVM5Z1Ro?=
 =?utf-8?B?cDlLY1VBKy9xekg2b0RJRXNQY214N1R0aEhLblZFSDFmWlprM3RKREF5MmN3?=
 =?utf-8?B?Z25pTTRWUEYzMHBENjd0dkI3NjNmTWFTTnNtdXljaFdUNHNqeTlsOHZDTTYz?=
 =?utf-8?B?ZTRWN2psUmxDS2NodHZaNUNwVzROTWdkWnhBaDJJYm1nQXRYUWpHZVFxZ2RD?=
 =?utf-8?B?a1hKZkU3TDFTVFdxQjNCelNrQXdFV3k5Q2Z3aXpacWZIOTlnckoyVmhrcjhP?=
 =?utf-8?B?bzl3KzNBQjlBb29iNGZCVmNmOGxyLys0cEMyYnJJWXlKTVBHRTJuVlJiMFpz?=
 =?utf-8?B?VlZkcGNGMnlFYWlKL2xxM21sS05ucE9EYU9FNjVjL1hTMllHK3BEOVRqNWVU?=
 =?utf-8?B?bWdDVE0raTFPSjhDOXFETVhEcStJWTUxWVJjTEJPYVkrbGpaN2dNSVc0MGpw?=
 =?utf-8?B?S0JKY2RrQ3Q0aHZFV1d2K1pwOEUyY3pad3Y1ZWh6NUdlZFdXVHF6U2VNczFI?=
 =?utf-8?B?WXpuS0UwbGFZSGk2Z1RzQkVBU0pQa3liSTIrckduc05wdHhvbmdOdWpleldV?=
 =?utf-8?B?WU4wV0Vjci9iOVFJRHM5TVVpUjk3eFFNM0daZEQzNVNnK2U1STRVV2tSQ1RG?=
 =?utf-8?B?ckUrT1dORjMwd2NUNGlHWjVGK3lzZXRhSWdJMFB6cUhtRC9aWEEzN1NOdlNm?=
 =?utf-8?B?TEJ0WFJaQ04vQ0NVb245RGY2cTR6eHNqQ0xLRXVnVWdaU1RmSklBSk1rdHh4?=
 =?utf-8?B?ZjJNcXNyTWRxWHhpdW1Xd0xqMXpiNmNGbEJpUDFHYU5NYkxiTGZ5c3B3SEQx?=
 =?utf-8?B?QVJldnMrSjRGejZWaXVqRWIrVTJDQ0ZIbk10TWh5cFdkSzR4NUVjdWE0OEpS?=
 =?utf-8?B?QjFROW5MWGkvcThvM3NEdGFQUHoxRGVva1dZRHJGVUFJWHl4bzhNRkhZYUNX?=
 =?utf-8?B?VmlicmRkZDNBSWFyeE5Wb3I2WjBMYndmUkpzTGNiU0JZbnJwRnc3dWFjUHpi?=
 =?utf-8?B?NkswSTI2cmhHSG1YdTFLN1pncDVla0hNVXdwU2MyQW5ZUDJqcmZHWGtlNllS?=
 =?utf-8?B?R2w5dG9zOEsvWnBJRHRiS3R5V2g2OTRtZ3FuVW9TM2VLT283MmJYRXVBWGlB?=
 =?utf-8?B?S3lLUnBPdUZzYkRaSGxIVWk3eE1qSFhUU3hWczRXaVJIb2h4dVc2dGx3VTNG?=
 =?utf-8?B?ek1tY29QdkxFb09JbUZjTXJwZ1dRcUc0NlJ4U3JtTjZXNEloY1F1UkNPakdH?=
 =?utf-8?B?bHhrazl2bHhVNjZRMnJuSkVpaTgwU2tFbHhjR3RveGpMSmhzMzlPK1BEaWFP?=
 =?utf-8?B?blJPOGZsNDhEU3B3ZnBHeXNUUTdVM2dTUXFCUDlvL0ZIYWdZMDdRNkxUdkhO?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A923B3523AB94E4FB6B43AE2D2326D32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WI9C6cTgShe/2PzkeFi1ymkP4LGxI+LpmeaOqVsb2dYIJi8G1r2tW+R2d/pcb6HtlrkFhtBNg9SLDNARMZJ+HWzXyNfmG7DSLJ8hSivklXygVPOr1irw35ErklXIBYPyid/diYfpdUZJ/7zz5TxLUnxbeACummYZc9cHSx2tpkT53UqLmoC2fDV7rh6dzxtOwV+Jw/zEwsL97c2PhiuPFvcMRJ6SAYSqa1krK8wIh4JSg0wU2iwMp2GxufwL5uCaSKSFKewDmaSA7p5Eh1gpfAl0Vu1phHBCsITzpAAhHDvLjMg5Nwkfooys9+IjAFZ/Rjgt/o9zk1+5SJK7VXWzb300vhBxi9kB1yDNlenpvbyWKi14DmTnr1t8d5irwDPlATNXUEZK7f/7hKq+Sx2Rx3I9ZWw18hnmwDJ95HKp8MM1VR+4O8eV9RL98vwr3yeIm2Q9yJste4IuETz7eAH5FB29SPpv95tlqnyzEuJD1Jz17q7VMz0Uqhb5WN24oxd0HsEe2Vc6u/iy65MVZPeF+yQDGmEApNPkzG+LpDDa+6g9U1Exxbyxkj3DD5hta86W3rB0i0F6+VVci3OC3tkXt38/VvJDIQJJdbT5h0MPN9sQYBe6aNN0FOlEMmnmJ8b4ozYVCUHMI8LbUize2/0Hryhzxz/huE1kKXqgqj28I/ixKSmhOYRPQbPZy4Jhl2vTFl/70KAecFBIDzDtvkvPH/vMAMGNCMYGsWgJG+0DENKPouxR+hOzupDgxCgB1eIC9zA2uIwfCr5AJA2i0PbOmCs5khFT/mgS9N3PF3axzRTgpmAOact8dE8wyPYjYKB2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eda0ef9-8638-4ae3-8331-08db55a16c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 00:06:39.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdKsm+vV7ecJat/hMXRrIxKOoFbLTiYFy6gRainA/krRnpLblKLbRkO439JCA+HV9JIk6AgCw0c+sbPeDPcLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150198
X-Proofpoint-GUID: D_qNRxd1sftFnULfazc3tRcB_2Jlam7O
X-Proofpoint-ORIG-GUID: D_qNRxd1sftFnULfazc3tRcB_2Jlam7O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gTWF5IDE1LCAyMDIzLCBhdCA2OjUzIFBNLCBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjAyMy0wNS0xNSBhdCAyMTozNyArMDAw
MCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gTWF5IDE1LCAyMDIzLCBhdCA0
OjIxIFBNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+
PiBPbiBNb24sIDIwMjMtMDUtMTUgYXQgMTY6MTAgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdy
b3RlOg0KPj4+PiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAyOjU44oCvUE0gSmVmZiBMYXl0b24g
PGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIE1vbiwgMjAyMy0w
NS0xNSBhdCAxMToyNiAtMDcwMCwgZGFpLm5nb0BvcmFjbGUuY29tIHdyb3RlOg0KPj4+Pj4+IE9u
IDUvMTUvMjMgMTE6MTQgQU0sIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPj4+Pj4+PiBPbiBT
dW4sIE1heSAxNCwgMjAyMyBhdCA4OjU24oCvUE0gRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29t
PiB3cm90ZToNCj4+Pj4+Pj4+IElmIHRoZSBHRVRBVFRSIHJlcXVlc3Qgb24gYSBmaWxlIHRoYXQg
aGFzIHdyaXRlIGRlbGVnYXRpb24gaW4gZWZmZWN0DQo+Pj4+Pj4+PiBhbmQgdGhlIHJlcXVlc3Qg
YXR0cmlidXRlcyBpbmNsdWRlIHRoZSBjaGFuZ2UgaW5mbyBhbmQgc2l6ZSBhdHRyaWJ1dGUNCj4+
Pj4+Pj4+IHRoZW4gdGhlIHJlcXVlc3QgaXMgaGFuZGxlZCBhcyBiZWxvdzoNCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gU2VydmVyIHNlbmRzIENCX0dFVEFUVFIgdG8gY2xpZW50IHRvIGdldCB0aGUgbGF0
ZXN0IGNoYW5nZSBpbmZvIGFuZCBmaWxlDQo+Pj4+Pj4+PiBzaXplLiBJZiB0aGVzZSB2YWx1ZXMg
YXJlIHRoZSBzYW1lIGFzIHRoZSBzZXJ2ZXIncyBjYWNoZWQgdmFsdWVzIHRoZW4NCj4+Pj4+Pj4+
IHRoZSBHRVRBVFRSIHByb2NlZWRzIGFzIG5vcm1hbC4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSWYg
ZWl0aGVyIHRoZSBjaGFuZ2UgaW5mbyBvciBmaWxlIHNpemUgaXMgZGlmZmVyZW50IGZyb20gdGhl
IHNlcnZlcidzDQo+Pj4+Pj4+PiBjYWNoZWQgdmFsdWVzLCBvciB0aGUgZmlsZSB3YXMgYWxyZWFk
eSBtYXJrZWQgYXMgbW9kaWZpZWQsIHRoZW46DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+ICAgLiB1cGRh
dGUgdGltZV9tb2RpZnkgYW5kIHRpbWVfbWV0YWRhdGEgaW50byBmaWxlJ3MgbWV0YWRhdGENCj4+
Pj4+Pj4+ICAgICB3aXRoIGN1cnJlbnQgdGltZQ0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAgIC4gZW5j
b2RlIEdFVEFUVFIgYXMgbm9ybWFsIGV4Y2VwdCB0aGUgZmlsZSBzaXplIGlzIGVuY29kZWQgd2l0
aA0KPj4+Pj4+Pj4gICAgIHRoZSB2YWx1ZSByZXR1cm5lZCBmcm9tIENCX0dFVEFUVFINCj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4gICAuIG1hcmsgdGhlIGZpbGUgYXMgbW9kaWZpZWQNCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gSWYgdGhlIENCX0dFVEFUVFIgZmFpbHMgZm9yIGFueSByZWFzb25zLCB0aGUgZGVs
ZWdhdGlvbiBpcyByZWNhbGxlZA0KPj4+Pj4+Pj4gYW5kIE5GUzRFUlJfREVMQVkgaXMgcmV0dXJu
ZWQgZm9yIHRoZSBHRVRBVFRSLg0KPj4+Pj4+PiBIaSBEYWksDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBJ
J20gY3VyaW91cyB3aGF0IGRvZXMgdGhlIHNlcnZlciBnYWluIGJ5IGltcGxlbWVudGluZyBoYW5k
bGluZyBvZg0KPj4+Pj4+PiBHRVRBVFRSIHdpdGggZGVsZWdhdGlvbnM/IEFzIGZhciBhcyBJIGNh
biB0ZWxsIGl0IGlzIG5vdCBzdHJpY3RseQ0KPj4+Pj4+PiByZXF1aXJlZCBieSB0aGUgUkZDKHMp
LiBXaGVuIHRoZSBmaWxlIGlzIGJlaW5nIHdyaXR0ZW4gYW55IGF0dGVtcHQgYXQNCj4+Pj4+Pj4g
cXVlcnlpbmcgaXRzIGF0dHJpYnV0ZSBpcyBpbW1lZGlhdGVseSBzdGFsZS4NCj4+Pj4+PiANCj4+
Pj4+PiBZZXMsIHlvdSdyZSByaWdodCB0aGF0IGhhbmRsaW5nIG9mIEdFVEFUVFIgd2l0aCBkZWxl
Z2F0aW9ucyBpcyBub3QNCj4+Pj4+PiByZXF1aXJlZCBieSB0aGUgc3BlYy4gVGhlIG9ubHkgYmVu
ZWZpdCBJIHNlZSBpcyB0aGF0IHRoZSBzZXJ2ZXINCj4+Pj4+PiBwcm92aWRlcyBhIG1vcmUgYWNj
dXJhdGUgc3RhdGUgb2YgdGhlIGZpbGUgYXMgd2hldGhlciB0aGUgZmlsZSBoYXMNCj4+Pj4+PiBi
ZWVuIGNoYW5nZWQvdXBkYXRlZCBzaW5jZSB0aGUgY2xpZW50J3MgbGFzdCBHRVRBVFRSLiBUaGlz
IGFsbG93cw0KPj4+Pj4+IHRoZSBhcHAgb24gdGhlIGNsaWVudCB0byB0YWtlIGFwcHJvcHJpYXRl
IGFjdGlvbiAod2hhdGV2ZXIgdGhhdA0KPj4+Pj4+IG1pZ2h0IGJlKSB3aGVuIHNoYXJpbmcgZmls
ZXMgYW1vbmcgbXVsdGlwbGUgY2xpZW50cy4NCj4+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+
PiANCj4+Pj4+IEZyb20gUkZDIDg4ODEgMTAuNC4zOg0KPj4+Pj4gDQo+Pj4+PiAiSXQgc2hvdWxk
IGJlIG5vdGVkIHRoYXQgdGhlIHNlcnZlciBpcyB1bmRlciBubyBvYmxpZ2F0aW9uIHRvIHVzZQ0K
Pj4+Pj4gQ0JfR0VUQVRUUiwgYW5kIHRoZXJlZm9yZSB0aGUgc2VydmVyIE1BWSBzaW1wbHkgcmVj
YWxsIHRoZSBkZWxlZ2F0aW9uIHRvDQo+Pj4+PiBhdm9pZCBpdHMgdXNlLiINCj4+Pj4gDQo+Pj4+
IFRoaXMgaXMgYSAiTUFZIiB3aGljaCBtZWFucyB0aGUgc2VydmVyIGNhbiBjaG9vc2UgdG8gbm90
IHRvIGFuZCBqdXN0DQo+Pj4+IHJldHVybiB0aGUgaW5mbyBpdCBjdXJyZW50bHkgaGFzIHdpdGhv
dXQgcmVjYWxsaW5nIGEgZGVsZWdhdGlvbi4NCj4+Pj4gDQo+Pj4+IA0KPj4+IA0KPj4+IFRoYXQn
cyBub3QgYXQgYWxsIGhvdyBJIHJlYWQgdGhhdC4gVG8gbWUsIGl0IHNvdW5kcyBsaWtlIGl0J3Mg
c2F5aW5nDQo+Pj4gdGhhdCB0aGUgb25seSBhbHRlcm5hdGl2ZSB0byBpbXBsZW1lbnRpbmcgQ0Jf
R0VUQVRUUiBpcyB0byByZWNhbGwgdGhlDQo+Pj4gZGVsZWdhdGlvbi4gSWYgdGhhdCdzIG5vdCB0
aGUgY2FzZSwgdGhlbiB3ZSBzaG91bGQgY2xhcmlmeSB0aGF0IGluIHRoZQ0KPj4+IHNwZWMuDQo+
PiANCj4+IFRoZSBtZWFuaW5nIG9mIE1BWSBpcyBzcGVsbGVkIG91dCBpbiBSRkMgMjExOS4gTUFZ
IGRvZXMgbm90IG1lYW4NCj4+ICJ0aGUgb25seSBhbHRlcm5hdGl2ZSIuIEkgcmVhZCB0aGlzIHN0
YXRlbWVudCBhcyBhbGVydGluZyBjbGllbnQNCj4+IGltcGxlbWVudGVycyB0aGF0IGEgY29tcGxp
YW50IHNlcnZlciBpcyBwZXJtaXR0ZWQgdG8gc2tpcA0KPj4gQ0JfR0VUQVRUUiwgc2ltcGx5IGJ5
IHJlY2FsbGluZyB0aGUgZGVsZWdhdGlvbi4gVGVjaG5pY2FsbHkNCj4+IHNwZWFraW5nIHRoaXMg
Y29tcGxpYW5jZSBzdGF0ZW1lbnQgZG9lcyBub3Qgb3RoZXJ3aXNlIHJlc3RyaWN0DQo+PiBzZXJ2
ZXIgYmVoYXZpb3IsIHRob3VnaCB0aGUgYXV0aG9yIG1pZ2h0IGhhdmUgaGFkIHNvbWV0aGluZyBl
bHNlDQo+PiBpbiBtaW5kLg0KPj4gDQo+PiBJJ20gbGVlcnkgb2YgdGhlIGNvbXBsZXhpdHkgdGhh
dCBDQl9HRVRBVFRSIGFkZHMgdG8gTkZTRCBhbmQNCj4+IHRoZSBwcm90b2NvbC4gSW4gYWRkaXRp
b24sIHNlY3Rpb24gMTAuNCBpcyByaWRkbGVkIHdpdGggZXJyb3JzLA0KPj4gYWxiZWl0IG1pbm9y
IG9uZXM7IHRoYXQgc3VnZ2VzdHMgdGhpcyBwYXJ0IG9mIHRoZSBwcm90b2NvbCBpcw0KPj4gbm90
IHdlbGwtcmV2aWV3ZWQuDQo+PiANCj4+IEl0J3Mgbm90IGFwcGFyZW50IGhvdyBtdWNoIGdhaW4g
aXMgcHJvdmlkZWQgYnkgQ0JfR0VUQVRUUi4NCj4+IElJUkMgTkZTRCBjYW4gcmVjYWxsIGEgZGVs
ZWdhdGlvbiBvbiB0aGUgc2FtZSBuZnNkIHRocmVhZCBhcyBhbg0KPj4gaW5jb21pbmcgcmVxdWVz
dCwgc28gdGhlIHR1cm5hcm91bmQgZm9yIGEgcmVjYWxsIGZyb20gYSBsb2NhbA0KPj4gY2xpZW50
IGlzIGdvaW5nIHRvIGJlIHF1aWNrLg0KPj4gDQo+PiBJdCB3b3VsZCBiZSBnb29kIHRvIGtub3cg
aG93IG1hbnkgb3RoZXIgc2VydmVyIGltcGxlbWVudGF0aW9ucw0KPj4gc3VwcG9ydCBDQl9HRVRB
VFRSLg0KPiANCj4+IEknbSByYXRoZXIgbGVhbmluZyB0b3dhcmRzIHBvc3Rwb25pbmcgMy80IGFu
ZCA0LzQgYW5kIGluc3RlYWQNCj4+IHRha2luZyBhIG1vcmUgaW5jcmVtZW50YWwgYXBwcm9hY2gu
IExldCdzIGdldCB0aGUgYmFzaWMgV3JpdGUNCj4+IGRlbGVnYXRpb24gc3VwcG9ydCBpbiwgYW5k
IHBvc3NpYmx5IGFkZCBhIGNvdW50ZXIgb3IgdHdvIHRvDQo+PiBmaW5kIG91dCBob3cgb2Z0ZW4g
YSBHRVRBVFRSIG9uIGEgd3JpdGUtZGVsZWdhdGVkIGZpbGUgcmVzdWx0cw0KPj4gaW4gYSBkZWxl
Z2F0aW9uIHJlY2FsbC4NCj4+IA0KPj4gV2UgY2FuIHRoZW4gdGFrZSBzb21lIHRpbWUgdG8gZGlz
YW1iaWd1YXRlIHRoZSBzcGVjIGxhbmd1YWdlIGFuZA0KPj4gbG9vayBhdCBvdGhlciBpbXBsZW1l
bnRhdGlvbnMgdG8gc2VlIGlmIHRoaXMgZXh0cmEgcHJvdG9jb2wgaXMNCj4+IHJlYWxseSBvZiB2
YWx1ZS4NCj4+IA0KPj4gSSB0aGluayBpdCB3b3VsZCBiZSBnb29kIHRvIHVuZGVyc3RhbmQgd2hl
dGhlciBXcml0ZSBkZWxlZ2F0aW9uDQo+PiB3aXRob3V0IENCX0dFVEFUVFIgY2FuIHJlc3VsdCBp
biBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gKHNheSwNCj4+IGJlY2F1c2UgdGhlIHNlcnZlciBp
cyByZWNhbGxpbmcgZGVsZWdhdGlvbnMgbW9yZSBvZnRlbiBmb3IgYQ0KPj4gZ2l2ZW4gd29ya2xv
YWQpLg0KPiANCj4gR2FuZXNoYSBoYXMgaGFkIHdyaXRlIGRlbGVnYXRpb24gYW5kIENCX0dFVEFU
VFIgc3VwcG9ydCBmb3IgeWVhcnMuDQoNCkRvZXMgT25UQVAgc3VwcG9ydCB3cml0ZSBkZWxlZ2F0
aW9uPyBJIGhlYXJkIGEgcnVtb3IgTmV0QXBwDQpkaXNhYmxlZCBpdCBiZWNhdXNlIG9mIHRoZSB2
b2x1bWUgb2YgY3VzdG9tZXIgY2FsbHMgaW52b2x2aW5nDQpkZWxlZ2F0aW9uIHdpdGggdGhlIExp
bnV4IGNsaWVudCwgYnV0IHRoYXQgY291bGQgYmUgb2xkIG5ld3MuDQoNCkhvdyBhYm91dCBTb2xh
cmlzPyBNeSBjbG9zZSBjb250YWN0IHdpdGggdGhlIFNvbGFyaXMgTkZTIHRlYW0NCmFzIHRoZSBM
aW51eCBORlMgY2xpZW50IGltcGxlbWVudGF0aW9uIG1hdHVyZWQgaGFzIGNvbG9yZWQgbXkNCmV4
cGVyaWVuY2Ugd2l0aCB3cml0ZSBkZWxlZ2F0aW9uLiBJdCBpcyBjb21wbGV4IGFuZCBzdWJ0bGUu
DQoNCg0KPiBJc24ndCBDQl9HRVRBVFRSIHRoZSBtYWluIGJlbmVmaXQgb2YgYSB3cml0ZSBkZWxl
Z2F0aW9uIGluIHRoZSBmaXJzdA0KPiBwbGFjZT8gQSB3cml0ZSBkZWxlZyBkb2Vzbid0IHJlYWxs
eSBnaXZlIGFueSBiZW5lZml0IG90aGVyd2lzZSwgYXMgeW91DQo+IGNhbiBidWZmZXIgd3JpdGVz
IGFueXdheSB3aXRob3V0IG9uZS4NCj4gDQo+IEFJVUksIHRoZSBwb2ludCBvZiBhIHdyaXRlIGRl
bGVnYXRpb24gaXMgdG8gYWxsb3cgb3RoZXIgY2xpZW50cyAoYW5kDQo+IHBvdGVudGlhbGx5IHRo
ZSBzZXJ2ZXIpIHRvIGdldCB1cCB0byBkYXRlIGluZm9ybWF0aW9uIG9uIGZpbGUgc2l6ZXMgYW5k
DQo+IGNoYW5nZSBhdHRyIHdoZW4gdGhlcmUgaXMgYSBzaW5nbGUsIGFjdGl2ZSB3cml0ZXIuDQoN
ClRoZSBiZW5lZml0cyBvZiB3cml0ZSBkZWxlZ2F0aW9uIGRlcGVuZCBvbiB0aGUgY2xpZW50IGlt
cGxlbWVudGF0aW9uDQphbmQgdGhlIHdvcmtsb2FkLiBBIGNsaWVudCBtYXkgdXNlIGEgd3JpdGUg
ZGVsZWdhdGlvbiB0byBpbmRpY2F0ZQ0KdGhhdCBpdCBjYW4gaGFuZGxlIGxvY2tpbmcgcmVxdWVz
dHMgZm9yIGEgZmlsZSBsb2NhbGx5LCBmb3IgZXhhbXBsZS4NCg0KDQo+IFdpdGhvdXQgQ0JfR0VU
QVRUUiwgeW91ciBmaXJzdCBzdGF0KCkgYWdhaW5zdCB0aGUgZmlsZSB3aWxsIGdpdmUgeW91DQo+
IGZhaXJseSB1cCB0byBkYXRlIGluZm8gKHNpbmNlIHlvdSdsbCBoYXZlIHRvIHJlY2FsbCB0aGUg
ZGVsZWdhdGlvbiksIGJ1dA0KPiB0aGVuIHlvdSdsbCBiZSBiYWNrIHRvIHRoZSBzZXJ2ZXIganVz
dCByZXBvcnRpbmcgdGhlIHNpemUgYW5kIGNoYW5nZQ0KPiBhdHRyIHRoYXQgaXQgaGFzIGF0IHRo
ZSB0aW1lLg0KDQpXaGljaCBpcyB0aGUgY3VycmVudCBiZWhhdmlvciwgeWVzPyBBcyBsb25nIGFz
IGJlaGF2aW9yIGlzIG5vdA0KcmVncmVzc2luZywgSSBkb24ndCBmb3Jlc2VlIGEgcHJvYmxlbSB3
aXRoIGRvaW5nIENCX0dFVEFUVFIgaW4gNi42DQpvciBsYXRlci4NCg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=
