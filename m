Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB34732066
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjFOTiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOTiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:38:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90AE2954;
        Thu, 15 Jun 2023 12:38:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJcqa008778;
        Thu, 15 Jun 2023 19:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=zuJXPoQVSqWZU+SFjxXJ9QHGGNHchG4TjWRHAMfuleN0YckpPi1cnr6iE/QQBTX62BDz
 yp6xBmNqPDkS3/J/EJLVA/HKvTMGwZbFmrDNJ412hlaw1IL2v6Ut/XOuJ0wV5WagY2z2
 SjbC43aH1vnc2L5NsiuKpwng8kKLNaHmDwQDmOuDt+wxETVjRNC/AoOaqI7DqpSvIeIG
 45PB9ZUw1t+Tl/14TeV2exq/1JuEz9q41IN1qrGENrfhTZEy17oknRhiWmF8RBx1x6pf
 1th4P7L+tz8IJ+mefPaNL0dm9yAzMYo7DysUo8j2HcZ/pxnEK3tYp5+bSJWxY001F/gH CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2atsjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:38:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FIMss5011376;
        Thu, 15 Jun 2023 19:38:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7ddqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRqExcOC8iPnuKiAIgxHkvKD4a0etVnVv2bbAoZQYIgzn5DAkgtk1+LPwcR6RSCzYczuiROUq6ugN1Q+bJHQMzACs0LBQEZRJ61oiWXEec+SNNA9I6Rqw4oh8uBAuhUgVWD/sj2WIkHYJBqsIEFfEC/s6UCcQG8/U5pUA5aUvavhKF0SwpadtItLCdhk0plzWk4Bdraf8Lzp1AI6ZusdaaxMZQN0efrJ6X3pdrn8C+76CLP06kSuXuJtf6YJv6f5XQ3GWAcSgIg/ztn/ZqjN+J0w9zzVX+fbbBwW/hAPfmUCYlK/VSzaJfn3r4nDCESidZItT9PU153cXH51jk83Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=iPF8TKVQSm+eq6kY+vq1ItKAJmbw2unPbg8VriIZTLfvAcRN41vPRTHWuiMbkYKypvWInRz7JUeGtjaOcQubhSeGcU8LIIUNNLs+v3dY1NPjbGzzrvenSQQAesRqs3+4MVSMWIh0ApzdxUIQRuwYzlZYVU+fK3RHvV8S+9aW9s4hLeauan+FXvWjLMbcoQRhK+yMoeES3fxWZ83SDm7SvHnKG/hYswd+Zr/8QgZSnK7U3NUy5XiTmNp+iVPd3enYmczSFGihxFg2iJmh3uKx9St8HpaiVAOfDJk5fki+GSPe4mqQeY6lYadVVI3/133fP324ASlRS3/uPmCQE7Cr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=kVDpwxkcbNd4XgIkkytLIkOJzaT4w3plBN/Aqo2vrRHl4ghLzu5g68yIb1QHhMJnJvXHkqV7vtHF1Mw4QfdctbuKfu1I34up8GwXjD5oFjzb4q5sgeB/n/0fKIAdzcJ0r9szaG3PUIAjrN7mSaeRvCi5TctcMoZjuQdmsDkWaz4=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 19:37:57 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 19:37:57 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 11/11] md: deprecate bitmap file support
Thread-Topic: [PATCH 11/11] md: deprecate bitmap file support
Thread-Index: AQHZn1XBM1I5HQtYQUaurI39tBTuha+MQwwA
Date:   Thu, 15 Jun 2023 19:37:57 +0000
Message-ID: <C3A47F11-89DF-49E6-8499-B1524D879212@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-12-hch@lst.de>
In-Reply-To: <20230615064840.629492-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CH2PR10MB4389:EE_
x-ms-office365-filtering-correlation-id: d21f6489-b943-449e-dc17-08db6dd80597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odnb27y5uVf0C4NGrAvI+gHpVk9sD9hY8EoAu0IkeT8rV5GZJ/ipZoCh922j2/bWxDhtbFmSN3GWapNBX6jb0/oa9eivLD2mWFJ750T5E8VevTjBLjDD1dJoBry5ogPywpNFXE9pbE8c55FSyMzS7Vl6b+oNn+vihkONEwzqhTVBP7/Jw4CmXQ6NKCJ9ZOZgGjDFLT4JBcCknQfRONxJmqB0wo52LprCDxi3+cZty69WXMy79Eizw0RrdEs8syrDdsr+vF46opSYOPa9DR8xBpHoqBAEZ5Xk+eFlqUlQC+0q7IGdM2fQwuvCJr0Ho5iaRDz0ZSeKqA4UKt4Y28+8kK+18v5ZaPNzGv0DdbPXp1A6uX0w7qWKewyiaQA6wYEm38vrynoY1thMFVypxU6jpW29lfX1eXIgVrSUZ2Pxzrb1f3K+ejTVVBszS9KBzX6mymlTmlDwJENtWIM3zPyRo3yzyltKV2E0VzIqQRDlzXf+SM6jOGIaQLBqE9Vmbfl9n0ocibO/8Oyj21daRTdwjleAmnBRoZC7ZIYV9vAz446+HULzzJXh1K1R5+i5QzhOVQr+ETN21AjLOt5FP0H2V7xbdpvwh8BRnAIOhdiuGqbwHa48KdplFrcTVbe19Ps2gN3AUCnIgt9lYPdjxGB2Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(36756003)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(41300700001)(8676002)(6486002)(8936002)(4326008)(54906003)(316002)(5660300002)(44832011)(6506007)(53546011)(6512007)(186003)(26005)(2906002)(2616005)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(66946007)(6916009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vms34ObHufYoLCIIupu4NQj4rGw8yurL3TlCAjai3qugg25eeTBopMWMlTV8?=
 =?us-ascii?Q?Eji6mT3dHQynB/TMBmvkL1tFZQUdK2SZJNi2eLxQXoQmRiS9yTNN1fb1PvW7?=
 =?us-ascii?Q?imZZEoetB2xOtZDQclcjJlNBTf+lLR1qYN/NZPwVz4YVGfs342rpEQW5zku7?=
 =?us-ascii?Q?B5B7RjcqGkivlSyqNvoZ/FVYM53SWLZmrO8ZpunrlyNMWD5Zr8y1S4T9NkOJ?=
 =?us-ascii?Q?/vuOjw1WmCgsdHxJdU4m2wsbAVbiMhkVBOp72//GQ1PU1GDv4ABPOdMutv8p?=
 =?us-ascii?Q?oBAzX3skfpDDQoQtaSvVS9lSEjivEIHM7Vcs3YSHCpeKS67Qc6uYiYM+yx7+?=
 =?us-ascii?Q?c7YRVWax1ioU6X+oP2gw4nYDcMyOKNpmPJ6V6/ir1F2y/doM7OrvNyEWoIAI?=
 =?us-ascii?Q?QWYf6iBIYmmDl/8M1bizU1vOgEoXhMQPV1tW6u++ouo0a4V32owiEBY7kZCo?=
 =?us-ascii?Q?Ruwsfurzn7Gh6ANw9trKGx7MrHjRdYG4iTH/FU7HHEpk0/7jQp17ID+I/EAO?=
 =?us-ascii?Q?m1yRiaMH2Tp2yxJs4YDVpDnWbgZIbUOlqb+Mmkt5FDLDUV8a/g6gTnmohmoq?=
 =?us-ascii?Q?S8+TizyNw0Y/ZkHFNKR+wS6LJKuKYXw2GtoeDhQEMtkYlsZFlt3uiDCT9/0S?=
 =?us-ascii?Q?9Bdv/kH64u/Dvok6G49A3lGoVao4Xr4/z+7otJpNKVo4ny6SzWTipCnK3RH3?=
 =?us-ascii?Q?wS1OL8cXxOm4iU1UVC3kojLIuAiI30PV3MPgwkB9P5PdaJm1Q+hNF59WMhXw?=
 =?us-ascii?Q?hKvtDyqYest5GK8vID+bMfIC0oCtMY2LQekJs+ar5jVqYxxOJgAwLqe/7QEo?=
 =?us-ascii?Q?V79K+hY/2fI3VRk+xssfHwu7WY1fVtFhaZNl5H8qwqAFAczYoexZaiPYlKeo?=
 =?us-ascii?Q?veIDEAwer6jbCXApND7m1y+K7chIdhXtVOs9ru7p1N8UnwwiftmLRPelIfLj?=
 =?us-ascii?Q?Sqd09R+FuumeyQuwYsTSzCazbwGs7Tc617gTRARZqQJb0yT7Bqfkhsb4BgcD?=
 =?us-ascii?Q?/mry7kAC2u5oDE/bF78WwQ+KL2ORHou9DGKoJuU+1NElInLxq0DHnXLYJJgq?=
 =?us-ascii?Q?JM8kafgJrYhA2ounGvkKuQ2E2SLH+iVGpmjaxbL/cRkX6lrdZS89+lUF06QQ?=
 =?us-ascii?Q?d9trYDn8YcHoVPl1Gqmm3iEpSV9Zc7pS5sejpPGpSNHag3kUNGEMs699y2Mh?=
 =?us-ascii?Q?UnH3J3MoIVgGIRpca1KB9q0GgA/5QMxp0bh4RfPOpT3JRYSqtBDpKO1RGGzn?=
 =?us-ascii?Q?cUjQlj72VJZy1YgeoQdwTBHmNdhBO+kCretRH3Y5+cl4mrwLBwnTT0gf3Vct?=
 =?us-ascii?Q?8QlBfYAMJDwJ/EfpuGiogEuHZoC5LdZUmvYny+djuBnlLscsGQqBlvZ6KDOc?=
 =?us-ascii?Q?m6AhNUmPblP0tRNqtFG2xzS8a2Ny/cIi3gPtds2rMuoTkGJpC/PNU2HHGDy9?=
 =?us-ascii?Q?DPuSAaiHNMkDWGbP/Fr8qZAyi6RRiBztHm8ZggNXnAwot7Po/ofbr2qV3wiB?=
 =?us-ascii?Q?GqrUFBSl5Um61XTXt1r1vc46ztlK9/meq8e/ZN5x2WCwdfG9tUz5p0mxS+k6?=
 =?us-ascii?Q?gax2Y3RU+wkIlWbJqM5rSgH2jmRuVdKq8J04xKSIk9tYBYSuIJfNzpksQMTB?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E797569DB7DA3F4D94D5D0DD9E154797@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QQn+ZNLc7euxaVlP7nI3XsKnQkSLvDXg32X23K0BSIfXkiK7+Z7YUxrWbI/sJ7RClA2LQXhPoNxc1mwnxh/q6Yycsuke9/QD5Hg/HfD9i9sRoqroARYi1t2QSrQcnCABxiJfNMOpbN/g+xUKA+GhK/Cp2ZEaaxIg8IsDZnVMdR7j2KCMOlvPekzl01/hF3zHtVExHhJe3ShjfBeuQkiRd05o6XYGPoa5WQUbWe+6uuu96He+jHf05D0OV/FBA79X4u6wFsrTbCK2CIPV19uknaGgN+dcNt4EbeFYmP6nS8b4cs/VcHJHcbV2lJDqwEqejcHL9jUoUI7krnHrUdE1GIBUTlcAtq9FtDT5dHPWDhVEfO4ElR5b9xzfjQvViFBgafAQ0wpeocW8TgUfR3RCCrFnktJZCD5x5jWO/WP0KzWwHef9EMpdoVLX5T9T4+FlYJeEFJv21JdLjKxGnBFKTTcECzWu0KMvRhze1UL1ld5CTs8hpK0v7iqP1l5qy7Ss+vADjhLEKTD9MPpVlSgtGX1CREGl9fdDLoYCJD6O5ES0vDwEXrTWUAuXSDcwSoe2OcFwfo9OlWwTaK8DoMK885koQAqKs4ZU68QDxLsK2J7OCRUcuNSMu6DDyk4PvXj1XjrnP3OOg4FcbnBKX9F7DWoiRTndqdTcVagUxIajnDETHk+GBHaneJZZzoQ0bf89UVoOE4UdbuEOJrb4Pe0v+WMNGheVmR2zCm69vLFOD6jfisq+zcN6OwTETZ9lFyacNyExDWJ2jAXNK0/jjnT6+QN68lmpW27epDtOZpWKlb7N71CwmIdJ8Y66tnP80C7O
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21f6489-b943-449e-dc17-08db6dd80597
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 19:37:57.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VId31BRghnwEHi0DmofhFhXd27GcRpoR69DZAW3ngFJQN/UTk7lY/VXCLzI4chI1HmF8IwH/d9YGxOW8rFJNxikK7UxBSAqRlyI3l76dm/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_15,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150168
X-Proofpoint-ORIG-GUID: 4OoputmD8Yd3hl_gx2yHbo1dRkzszUCI
X-Proofpoint-GUID: 4OoputmD8Yd3hl_gx2yHbo1dRkzszUCI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 14, 2023, at 11:48 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> The support for bitmaps on files is a very bad idea abusing various kerne=
l
> APIs, and fundamentally requires the file to not be on the actual array
> without a way to check that this is actually the case.  Add a deprecation
> warning to see if we might be able to eventually drop it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/Kconfig | 2 +-
> drivers/md/md.c    | 2 ++
> 2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 9712ab9bcba52e..444517d1a2336a 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -51,7 +51,7 @@ config MD_AUTODETECT
>  If unsure, say Y.
>=20
> config MD_BITMAP_FILE
> - bool "MD bitmap file support"
> + bool "MD bitmap file support (deprecated)"
> default y
> help
>  If you say Y here, support for write intent bitmaps in files on an
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c9fcefaf9c073b..d04a91295edf9d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7026,6 +7026,8 @@ static int set_bitmap_file(struct mddev *mddev, int=
 fd)
> mdname(mddev));
> return -EINVAL;
> }
> + pr_warn("%s: using deprecated bitmap file support\n",
> + mdname(mddev));
>=20
> f =3D fget(fd);
>=20
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

