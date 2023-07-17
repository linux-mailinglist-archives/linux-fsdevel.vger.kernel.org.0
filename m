Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DA755AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 06:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGQEng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 00:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQEne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:43:34 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B331E52
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jul 2023 21:43:32 -0700 (PDT)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H4d1wT027175;
        Mon, 17 Jul 2023 04:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=3BU/WH5D8O5pE5um5Tr5MeADzI4/MYYYYwsosWZ7m2g=;
 b=mfaqNxVMpRfP7Dh+rv/8p5F9RBlfWQaP95E39x173jUO0iKAIve+gxj5mO1zLy/EJomZ
 nmq9Y1mgh0zBoQtXJjPOI3EAbKqXmUbi1Id6UAAKRqje2Op+W9ykbn0wFKl6tgdjhVjw
 HL2Tr+R/SU02pQKy1YAzlTn7BjOUVeWTjDx2v4E8ouBS6SFeg1nMpwJQB9siL/8+saBy
 4h+3VTpMcWymc1jugEaNerVgx90ZvWemT6y+jlUaAenJVhi8gO4fSq4dIv3KhZourMmx
 eW/oGuYpVARG5zpX9Ig9GRsoj9Gc4uWSR48JBTzk/W7AX0V8M2xJaPNV4+oexEYOruAH 9Q== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3runq213h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 04:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmP4DyvaYCFxkJ1tWQ306b4qdVJct/r0SYMn5h3aksm6WHX9gf5GWX9HUo7MXTNLhC5weSvF0n6VOKof9DTxXkpGeOZH5pu3mfBD25cSnKRg9gb7sjZvtlYBOcl9Q/blCHYaq0maW4a8gz7xbi52lj0kCEuIRtcWJvEJlvQIO8AnEpPue2LOeStr811qKzGB4+7yoQwpr7KaukJwlWGjhHnqqs6Gm+yEUawqt68cR8r8V9LUYdidADbxmZSEkv0UgkSShulAKS+DBvpO9g3wtW3zKtdfDH81h32V6SzaBhEL2102RoO3J6AUfdAcEfbcffUSiLEgInoHv1pTSc+vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BU/WH5D8O5pE5um5Tr5MeADzI4/MYYYYwsosWZ7m2g=;
 b=WUQp93sBtk3KAbVp8j6kDWD5LHnFNSWjufx/ltIEguNCnrPnl72Pu5KCzfemtdWzd+2EN/Sf4TPjYXe4JvAVJmZwJx5bJvUjR0s3wPdpvGSLSSGIIeu2VABBzkR4k5qHEQXldy7SbviynotFEoytE7/791epb20zEN7HlaTKRdnDcwBAUzlhvFxZ6XJZaefIXmxvHPo7+xbI8v+z6RB3hVZhvQkvum12/Mw9u3WuBRItkdK9iKGXBxCHUwPW7PLh42MF7FTG2TX2OMhskMKKNa075ScOW5SvftoVnEBpQsll4LDClTuzxeH4BH7QFlyT7ksqHwwA7hJI0h5InAziIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6955.apcprd04.prod.outlook.com (2603:1096:400:339::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.36; Mon, 17 Jul
 2023 04:43:03 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::dcf3:bf0e:267b:4745]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::dcf3:bf0e:267b:4745%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 04:43:03 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxim Suhanov <dfirblog@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: RE: [PATCH] exfat: check if filename entries exceeds max filename
 length
Thread-Topic: [PATCH] exfat: check if filename entries exceeds max filename
 length
Thread-Index: AQHZtYqDNlrBbxByLEOrBUTdQHfR9a+9XY7Q
Date:   Mon, 17 Jul 2023 04:43:02 +0000
Message-ID: <PUZPR04MB6316739EDE3554E9EE25AE10813BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230713130310.8445-1-linkinjeon@kernel.org>
In-Reply-To: <20230713130310.8445-1-linkinjeon@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6955:EE_
x-ms-office365-filtering-correlation-id: 329e3c66-ea82-474b-09f7-08db86804e19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUj7z/F8UM9PNg2LDk8W7UoLtdAYr8kpuD5mIS8rQNOY4NAcxl53gMloiCatXlEEovdFI8BSbv5YsFmOeDKz+FXR+8p74a4mHB2gW0oezwlebDsPFXRTG6Z1yrmbsJaMXKbst6eVq3Csm5xJolFMGvr1jxUJZGKUjCiLZh6eiTwkwH2c//52DksJvCQhogCU0+rYrks+I/o8ZoehzKgtHmJ3n59DOz2vi59myD7ql1BD7ts+AuLKthE8sfCqlC+24lzqir7Zs1IgeRNpkCmddNjlmwZ4B3iNXj1+aJPSx1v2ewDhI8hHauhbJOmJtqUeL8J9e7T+LJT7pQy7VIia1QtVvl/3ceJAgZynJ9HnW9UbEjtxT7vLI9Zs8Ptubs0JoBpNhfEmrkAo7rXP5NAhTwOxlyCiAFoXQ5JRtW0+SQE9L2Q0I4+fQhfmqEjCiTHsWNWt+0fktdQF1+9YtXu5yDCgqIVX/5Pbcjs3zV/8xrtxxnSzehzYmW5sYQukdca+5GTiayobOO+wh6z3YNbV3WTJADehwSYNG/dmOxqC2K2WUsoP1iFFw3zYxHxW53MDHr+34H5u8CY1y+GUHIk60vrB0Q0NFZz7efu6lfkYvTsKzmKyl7iIch2yqQrBGjw0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(478600001)(110136005)(71200400001)(54906003)(7696005)(76116006)(66446008)(66476007)(4326008)(64756008)(66556008)(66946007)(9686003)(316002)(82960400001)(41300700001)(2906002)(122000001)(55016003)(33656002)(52536014)(8676002)(8936002)(38100700002)(26005)(186003)(6506007)(5660300002)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGczQk1lSDRScktYRUlidElvUjdGTE1VNDQrQlVqeE5jbHlxR2xJZkRpeVNm?=
 =?utf-8?B?b3oxRmJBcWtSdjR2dVBXUVlvY3Qxdjl6aHRYVm9sN1dLeTQ3bGt0Z2x2VlBZ?=
 =?utf-8?B?NVhNbU1DcUd0R1VON2lQWE81bTA4YzVaR2p2b25ickpmN0MyVjFHS29ZREtu?=
 =?utf-8?B?WjJ2Z1lDbG4vaVhsbmUzL0w1blFUVk84RG9UdnlVbCtHdlpOSTd0NXFTK2Vz?=
 =?utf-8?B?VHk4OFl4eGFRVjdsMk83VExWbm9TbGFpL1oweTZmWVdmV005eE9NSlYyWFRI?=
 =?utf-8?B?VzFCNmw5d2NXT2J4M1p2VUxoWU1vb1RTS3k3K09rVXRORVVRdjByMWRHaVdn?=
 =?utf-8?B?K2JwSXRZSjA4VDZHRTBDNHVjdWt0T1kzVEtIeDJuZFBUWk82UHZiTytsNjVP?=
 =?utf-8?B?Tm5jeDJPQWZDUU92M1JvN3p3djVXTDE5QSttbDRIZThUSjJ3M3JKMGU5d08y?=
 =?utf-8?B?UkluNlNlSjllQVIxZ0ZENXZWbEYyMTVuRDdMS0JnRlJqNXVYR2lkeXZMbG9i?=
 =?utf-8?B?bm1WOUJJKzRIQVgrOXFTM1dGNHZidWMzRE1KdTRkSWwxd3MwTHd6WjBzMXEv?=
 =?utf-8?B?YWdjTDF0elYwVGtjOUQ1Vi9iY3NDTlJKYjY0L0xqUmM5ZlVuZzc3WUJpRkU2?=
 =?utf-8?B?YkZ3RWlzeUN0MEZoQW1QSjVHUVd4M0NhRkYrZUY5Y0g2eWUxMm4xMFJqWlNP?=
 =?utf-8?B?MnJJc24wc3g2U2ZGS0xhTlF1VmdUWDRPODZBYnNRMHJwNWFBZnlKK2FmWTZS?=
 =?utf-8?B?NHlveStFY09RK2t4R2pKcWJtRithSWxsanlTM0JtM1g5K3FjSzRydER5ZG5O?=
 =?utf-8?B?WWxMVWdKRTNVZGUwSGk3SUo2SlZVeTlWbFdEcTgvM0hVU0tMT0lPSi9RTk9I?=
 =?utf-8?B?cDRjeDcrK2xyMTVFT3RnMS9rQUFqbHVlMnk1UFgvRjNQTmFhdDhQY2ZXY2NT?=
 =?utf-8?B?d0JwNEc4VnJWbEF4V2xVbXJsVGVubXl6MEYyU0pwZmZiZUk2cG93ejM5MW9K?=
 =?utf-8?B?akl4VHBQODB4amVocktGemE2TTc4aUpiZzE1QXFnRHFCSEVrVm9rRUgvcnJw?=
 =?utf-8?B?SE1XS1N6enhQdXZScXJUZXdjSWxydmNWMGNMMkx1YnFZcWZ0M1gwcFpENU15?=
 =?utf-8?B?c2xsSUd5NXMwK1FpS2JlRVBSZXZqYm9sMUp0OTVlaGV1YzkrTXRSNzhES3pW?=
 =?utf-8?B?MVMya1hvWWNqSXlHUVFCNUZxQkpXQmFmVW5iMENPaHZnb0tDNHN2czFQejFi?=
 =?utf-8?B?Y2RzQmQ4UDdNUUxJeXM5KzExRDNRNkd0OTkwYlB5aDJwdVI1b0NNN1g1Z1pu?=
 =?utf-8?B?MHNSRHNmekJmTGxZdXRrY2h5b2VreFVpV0NSRERGV3hac3pIMldselpBUHN6?=
 =?utf-8?B?RFdTYk5vL0ZYVlV3ZmhZY21iYzRsdmE5c09LTnZRdmhVOEpuWW1xYStLVE5r?=
 =?utf-8?B?czVhd2dhUlE0NmF2YUFTaTdVa05NZzkwR3hzV1IwVkJEVFA4WVdsenVuQll5?=
 =?utf-8?B?dkpYdzNVUjVRSUZidlJFWC9XZHFBVUxGUUx5Mi9ZSy84Tk9aNm5Ga2ZrdzIy?=
 =?utf-8?B?MU9tNGsrdWRkYkc1NDJhb3JJTGdaTEt2UmxHNEt6MmNZRGw5MjVkbE1GeStN?=
 =?utf-8?B?bTMybWZIVUgyVGxrMHFNL0dHTGR0SmF2RXVTL0FxZUdxQU5sMEt2Q2N2cTdh?=
 =?utf-8?B?dE1RRHdMWjM5NkhsVEE5cEh6NVJzeDVWbVNBSE9SYW5ZNnRRNzc5em85ekNk?=
 =?utf-8?B?V3ZkZlhwcmoyNzNsTkQwR24wb3ZDYzVzNDUwUmpMaUFZU2JmNVM1TUZHbkhU?=
 =?utf-8?B?SWhBYzR1ZUgrOFNSSkhoUWUyMHlFR0tFRUJSaTBUVjhBTDUzTnBHU0t2NFR2?=
 =?utf-8?B?NDhBeU5GaEM4cG1rREJ0OHlBUXJIdEZGUzUwWUx0SmZ4VndoUnhYMml4dXA1?=
 =?utf-8?B?N3k4YmRlNUlGRlh0SHFLNmU3ZkhuVHNUeFpsanVzUDJsZ0xrQXNudDRYdGU5?=
 =?utf-8?B?L3JNUkJPak1vcjZHSTVtRFA5SHB1Mm11LzVRVHQ2WU11REFMaXNZSEVieHNL?=
 =?utf-8?B?MTVHcFl6SlQ5UnpmaHlYR2FMTmF1S3djWUJaMUFyTEFOZXlTUkgvMytEM2Nx?=
 =?utf-8?Q?3i0kLkjHpzW2jqtAXa6LCb1XY?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gVqCFr6pS6Cb4P86xlhKDxdTfq9GZxJUOzFF6GWgrVZFHI1/k2/2viD6peaGMb7GF63wI2raFem6W9efQGuJM9kmhwDEakd/JqRq/W8sEliF/OZkSzZNApw5H3NRKw48GmfOFOp1xRelLB+jZNTSVapffVNImxcigYQKeIxLQfw+1ChIcc3JFjGLDt1g7UBM2iw7g1BzQEYZeMheR0+jhYN4Qag65YC6/3hr8c1Dktm4cvY/++XV3491rrEWGkFHPr45rbbVNTbi3BXm/vLUcPNQYMGIPm3oZ77JF/89S1NUZql/2ad0Y5lmSjYoc5kYJJGkBhc2GNmbeVIbvKHyH3xr3fq4efsNFs6y/uZ3XTjsingCmpjf5Dr8mWfO+Y9+7zMQmE80y/sl8mpcHvQlsVMMipZDB5n0niyPCuIWuTuOzzFSUOJj7az+0SrtwxuHP6o5cHof/EI3h34m9y1dfNiivFPPJJGayh+YnRVHxuLGBE8b2/8+P07aFuccVXGj6bYf420C5OJ22EHlr9Hm6c6ys8/2wV+50O3hrrOXClF0MJ8ACpZVV4wPZyc8tFym5k96GzcXSEL1k7rlY3y9Ms2HPkvsoNmURCvYZ7t0OI9bMMV3GR2T+qOkNIG7MEOlmmubJBXJbLzFTzJ5CboSIOjpm783ahgXOtVPcHYtC4C7puYxvo0gH6fyfqWoUU+1c7GsD85sPPowqtelHAeQwsuts8zeMrwlTFdYb4GAOVznzsqMf8JCr5sCsOsdbv54L0QPCkIfFA8HMSV+Lu69HmqyyRy7L5ZG5fxO6N1Z6Bn0Cugf7LFnIpOVclZ6xSrI0FioslzV050eVFEXvbC11d6csYrvvRGfvH/BZf1oPmd3otKirbS/21RP3HzUieAq
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329e3c66-ea82-474b-09f7-08db86804e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 04:43:02.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c95Wmf92aVzT+R0iEUGxuPKDyH77Wgff0iu+xAbtqXcH2mt24tSimcQ5c6RPxulFEQTeJnw9IOq6Zj3sS4K3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6955
X-Proofpoint-GUID: ZXsY0aiA1XDfbkGiqMIHqPwVcri7vP6W
X-Proofpoint-ORIG-GUID: ZXsY0aiA1XDfbkGiqMIHqPwVcri7vP6W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: ZXsY0aiA1XDfbkGiqMIHqPwVcri7vP6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_03,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IEZyb206IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDEzLCAyMDIzIDk6MDMgUE0NCj4gZXhmYXRfZXh0cmFjdF91bmlfbmFtZSBj
b3BpZXMgY2hhcmFjdGVycyBmcm9tIGEgZ2l2ZW4gZmlsZSBuYW1lIGVudHJ5IGludG8NCj4gdGhl
ICd1bmluYW1lJyB2YXJpYWJsZS4gVGhpcyB2YXJpYWJsZSBpcyBhY3R1YWxseSBkZWZpbmVkIG9u
IHRoZSBzdGFjayBvZiB0aGUNCj4gZXhmYXRfcmVhZGRpcigpIGZ1bmN0aW9uLiBBY2NvcmRpbmcg
dG8gdGhlIGRlZmluaXRpb24gb2YgdGhlICdleGZhdF91bmlfbmFtZScNCj4gdHlwZSwgdGhlIGZp
bGUgbmFtZSBzaG91bGQgYmUgbGltaXRlZCAyNTUgY2hhcmFjdGVycyAoKyBudWxsIHRlbWluYXRv
ciBzcGFjZSksDQo+IGJ1dCB0aGUgZXhmYXRfZ2V0X3VuaW5hbWVfZnJvbV9leHRfZW50cnkoKQ0K
PiBmdW5jdGlvbiBjYW4gd3JpdGUgbW9yZSBjaGFyYWN0ZXJzIGJlY2F1c2UgdGhlcmUgaXMgbm8g
Y2hlY2sgaWYgZmlsZW5hbWUNCj4gZW50cmllcyBleGNlZWRzIG1heCBmaWxlbmFtZSBsZW5ndGgu
IFRoaXMgcGF0Y2ggYWRkIHRoZSBjaGVjayBub3QgdG8gY29weQ0KPiBmaWxlbmFtZSBjaGFyYWN0
ZXJzIHdoZW4gZXhjZWVkaW5nIG1heCBmaWxlbmFtZSBsZW5ndGguDQoNClRoaXMgY2FzZSBpcyBu
b3QgY29tcGxpYW50IHdpdGggdGhlIGV4RkFUIGZpbGUgc3lzdGVtIHNwZWNpZmljYXRpb24sIEkg
dGhpbmsgaXQgaXMNCmJldHRlciB0byByZXR1cm4gYW4gZXJyb3IgYW5kIGxldCB0aGUgdXNlciBm
aXggaXQgd2l0aCBmc2NrLg0KVGhlIGN1cnJlbnQgZml4IG1heSByZXN1bHQgaW4gbXVsdGlwbGUg
ZmlsZXMgd2l0aCB0aGUgc2FtZSBuYW1lIGluIGEgZGlyZWN0b3J5LiANCg0KU3VjaCBhcywgdGhl
cmUgYXJlIGZpbGVzICQoZmlsZW5hbWUyNTUpIGFuZCBmaWxlcyAkKGZpbGVuYW1lMjU1KTEsICQo
ZmlsZW5hbWUyNTUpMi4uLg0KaW4gYSBkaXJlY3RvcnksIGJ1dCB0aGV5IHdpbGwgYWxsIGJlIGZv
dW5kIGFzICQoZmlsZW5hbWUyNTUpLg0KDQoNCg==
