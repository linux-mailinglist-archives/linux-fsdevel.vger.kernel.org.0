Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61537732067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 21:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjFOTiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFOTiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:38:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CA2953;
        Thu, 15 Jun 2023 12:38:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJdUM008812;
        Thu, 15 Jun 2023 19:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=x/20DFCp+GNzs8bQlfV7odWGY8MFFXonebB4p2ihyQsMp8vK49H/c6oEWnRCMo8V3LkJ
 VE05FqEdWIxTDqT1iHf2W7HbNiAdW5Vsw0dzb1zWQpjJ+LIOngXzTXUgXf+EEfMuNrpd
 SnGvNVOABhzD1CnlJhczIjNUqAkNOhBFRUm7qqIHmHftAbKRWaiYdVUWa6KHcHrq6Uh8
 CgjW3CyzQ0peD+I/DV8uF0wW5D1DqkRCcmoTTJDMky8tY8A3fhTdi9rQ4cVIRlyiNjtf
 OXTJFSNfMSQoebXpei9z8uWbF9JH6GHtu3LogXk/qD8Kk1G2xhyLqaPDjdurAz0ivoAA EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2atsk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:38:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FIMss6011376;
        Thu, 15 Jun 2023 19:38:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7ddqq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5CmREMo7wAGVECIm15Qph5soZfbXp5pCp4vnlprBb0WOLW00Ga0FGGnn6P9oeUE6KiuOXwKt6/McMZq7mZyOf1a/57HO5cGbmX6SJeE+9VxJILBpS+LPhLJ9q9NlIROFE17P7kHJKUgwAvVVLoEPGogH5Q1Pm6X3fKQI7kYgplpxwLrhZLV5Z04nyh49CVIvfcwySS7trbKSd75lUiJVkVCUAlqnlSmF6pSefV7GIlopP+xU+wZYNVd63GVTbh6MdFu0X0owvZMJlvrP0CgNN3NQgS7pizSkUXspTc0c10pWtqd1SztrWLe7Mvv15rRqbeEWY66cbjVCa8FRxEAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=QDLd2cOOYroXaYPR+qmhRaD1+K3fJg7kC4bhbjXOBeNtzP1Sv0KZ1mq9KBhZg5ihGt58PA2t8UYBSl/N11/b2fboiNh7PkPZ2rXOoVvOa5ZBL4wI8OscwT0KFHkR+lcCxJrvEjY3t+qri8h1OjEgGuoGxXjsRWKcMItrLH2OZ4UK4HXLwAalXzGY9ea8VDKaHDId6y3Bq1/LWtNvAT4v+eEg3ailnrUXYBMs3iysKkqeYFcoTLFyGdB6b0P5pnynpxDkLDono+6ofhgW46pxKfOAztMCj3R20sj2atrQ3TmTk+KLnUt5VxY7lfkBUFg5PG4JgB53QhT/qyrUhIIRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV+nbAC56s2SGgyEkI3CbRaMn5SGhSbtaQcuDXA33r8=;
 b=SwqY+JiHH5L0wTeYwnaJsItudYzeLx8gxZtS0tc9wMKeBHlgUpvaDUfg9ZnHtL04FG23sPzOUSOy2DGW9YcewGVrITLXl2//O37kgpPucRkBTiV3Q5YBpSJr8acfp3xYlrlEfSER0jzm45pg06/huOEJ2Kl65Djnn2cCWN6Qcbw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 19:37:59 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 19:37:59 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 11/11] md: deprecate bitmap file support
Thread-Topic: [PATCH 11/11] md: deprecate bitmap file support
Thread-Index: AQHZn1XBM1I5HQtYQUaurI39tBTuha+MQwwA
Date:   Thu, 15 Jun 2023 19:37:59 +0000
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
x-ms-office365-filtering-correlation-id: 8bba9b0b-cd5b-492a-a759-08db6dd80669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSZ9Qh7Lg7xgMouGS13pRnD6hbrJOkOjPs4LpQviIHftoVCQw5iZm1apW8k1G9rvyhJLWbuqHv9y8UGrWYzfNx+ewOlYBzQ/g/UlOQlHyPpRd+cwWA2ps2rgel28A18KYr4bv19aYmghFlrEYiO0UZtmYUsuC6enddCaa6giP/XONe26rXD/84zA2nIxLFGJ1W3EScVdMiZoYK7hH90tJ91gfPKdF2TvQh8dFwDszqnwwQL2Gh/gbFD0NmLDsdaoJAnSUTPF2uueQQ/g4dXr9/vBdABf4hMggZcFXEuNN/+Tg+n/sFjYwwnlUqAJU1qbRNXtrUqJ240SLyskYP3QmxAxmzHCd3EQ8zzKjG5HQVlED+Mhmv3WZlfjGuN+8ebk4OTsQ6anKtwkYSzmfJh61QGmrz2M+zpUxdCm7SSwjfYuGsxjYU+Mlz0aUges//se22E0jacH/S4zYA7PnGG5+9XWFlBmuZxCYi7n4SZO99xcQ/O3pdyM+1PFalrtqSG5qhSqM6tsEmXE3bGFiuQltMVV/F/YD75EyN+anXd4D/MlX0brIK/XgSTf31ObaEY6YUQlWTosNCJO1M5IMl5spmxVVWTzAjEUQfjo7ND6iJVtm9ljqQ/2cvQPWdSDPChhhDKu4lyuPLSax+54XqYHSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(36756003)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(41300700001)(8676002)(6486002)(8936002)(4326008)(54906003)(316002)(5660300002)(44832011)(6506007)(53546011)(6512007)(186003)(26005)(2906002)(2616005)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(66946007)(6916009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Acn+v/8bHr781JHZdwSjUWMp54oRcet2yQsd3xvvQ7Pu3U89jS9HIjzya5r7?=
 =?us-ascii?Q?Sppe8lINzlYZuRIEzqdlAg1z9zdpv5GS4+0HcGXDlvRiyvc//JPDrCgZsYrz?=
 =?us-ascii?Q?/4OSAM9G2EMXGN5iPA6zC/iFD60u7qQPZ8y4iy6Vw/5GboAYluictet9zZBs?=
 =?us-ascii?Q?9/0TSxHg/UPQF+1zC9huE4SJkbzLiMGmAEG4L8+jaQTAtxRpD3+AityOqH6K?=
 =?us-ascii?Q?4b5I0bh7eMeGEBaIkK4PPv9f3E+bHs3GH+/uqqACUUONgB2lQsPU8ecQim8H?=
 =?us-ascii?Q?J+CDJx7lOYIHH1Gw0ngDjvttLnW860W6Fo55UQj2sqd0EL2F6NyHQ1Q79Bj4?=
 =?us-ascii?Q?ND8RbWiD2BPpctHi4vgjpnReOM33kaBgpARVZJTD98KIt55SbAUY8kh9l1+6?=
 =?us-ascii?Q?TjanIVU2ljqbhuQBkxd7AqjzKKqTlrixqXp9PQp7DkEa20ml2cAU2+5DVlts?=
 =?us-ascii?Q?78Yl7MPzONpina4Hj6dBGzFli5Dd2cLG8yKqBRRcgGRbTZOHMxIBYgbuBhIu?=
 =?us-ascii?Q?VQePnaOQKyqTuPtEvpeKwN5o8RmiDC0SKpWNfKbslzSz6TmQCk/nvhbH7B0H?=
 =?us-ascii?Q?swAts8QNNPXSsk+iUa/8krnrbAxIp35RDfEr3GuZMUrYr+WUnqooDOkcRfRH?=
 =?us-ascii?Q?H2FK+A4toBxIbi18+5tIwvawaZRZXdN6EZ5l1gk3t/Cb4OSK+FosVda/uVkK?=
 =?us-ascii?Q?U7bS5M+L+WhD5gEHV3X4A/TLc/k+k47L8N35UPrOydjTLM2kAG/IROzizZov?=
 =?us-ascii?Q?UtJmyjPmMxNSaQ/L2Dn493OF51r+tFOVwMOpgn4nHIUP5rA0K3KfymnbAV3h?=
 =?us-ascii?Q?asq5pa86CPVttFXNTukZ7VY5EPerP/cbT0U7aOw1VfkucMit27b5JSdGdZiN?=
 =?us-ascii?Q?y6rm1LOwQ2XSguqgx75e9x0bb26hxFuMae3Kh9IZycNtv7LdevDECZE1J8Ps?=
 =?us-ascii?Q?iBE0NqRUbWNljBGCf6wqfic3P6dvnWQkLYI8+JGE4j+nQDuZYJ/t9o9Mif50?=
 =?us-ascii?Q?AHU2vi6KiUTBY2O83tRjlhsuFIHVyc3Ewhar3nvD3vIt+2uZLoXoQeHEZTtZ?=
 =?us-ascii?Q?jDaYgbZKCSKEB/PiLuEyoAuT+ppzp/aXE3dJftlhuTASGl2vHDi8ta6zplMs?=
 =?us-ascii?Q?TbH6fvy+0ReerRXHlZWuWs15mbCa3RT4dnqnMdVUtl4cbADOn8MIRjoyPwG6?=
 =?us-ascii?Q?QyQiwHSGeNibxSCLkx+9y0e88MIUbbgzXHM4jYuMVkOCoGItTi1ldQkviOZP?=
 =?us-ascii?Q?aP9vsO07AXl4gAyW4e4XMEaqsc/SzErN1yJOmH3UIIf/UE3h05ppJIzdX3QY?=
 =?us-ascii?Q?j0bXBUiiB1bcBPHyNtCvX2np0CbbElrD5rvVeFCkViLuLUFII9tSdJ499Ixf?=
 =?us-ascii?Q?wQHFyN9jatOIBltuf4GBtY08zuHcUXHWOXkm/nNZFp1t2LlWX6rI/2D2/EXo?=
 =?us-ascii?Q?ql74vkHgcjU8QJi6Zb07FqUyD13x5Z0GYZety4+57cQBQuYy0Y6cwHqNDylY?=
 =?us-ascii?Q?vo+TG9OzfQ4EVNOARNz4mUS7ECUoYct6LUXlCBigfEBnTgWBqCs5ZaCNONoQ?=
 =?us-ascii?Q?BYxRra8e37G9QCRLr+mKZy0bonkOksFYDF4Hb3ZzsYDlnmL8ShbyAUqMjiY+?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C733E9FF291E649805D068B50D06A01@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NjyLXUO9fRMU/SP3pr5eJrBuPScSW8iHOV3uLWJo7tdnhtPakm27ZjyJPVSoAqNYzlJgIDJY5NsGblPDuiqJvRDBGmtIcUYWzkIaxhsIGiTUby0dIrDq8K2AXaQhw3suDxaW7h8hP4pe9BMl+cfC1Vymx2UmP3zRhxMsB5pgJY0QWW6vCawmgQk5RZ9c6PCZgRFU4hARw3DtW5RTXR1Q3vKxuDJZ46b4q9L9q5Npz1HabxhA/GGXZUA2ztNmrINVRoxAUIzxtjF6e4EQU4bZihP4gYklVGlW6gSgNvRVyhNZYOA2KH1tMScn6esnyPAAGooWD3q124tpjKeDys5AzunCaCWd34NNcroR1Vt6hXPxCrSGM+Hf+Ay9V2GVlGoUwmjsX4PVwDcJMTASJ7bkk5shXx36L2ZEbDy9PvovBoJt4q0vztBvIFhD57dZZ01MPHAgb1i6/KmggJGWLC2nHZurF6TQ/5f9b6wWFj0XXHF74EM9AZ0iHHmip3nyfQCGQeyKuakq86umcdTHJgiovbIg24ETAEWEEtWI3vPye+KlATJq1VW0v+fwAiYV+8GtfSuhIzan3AFL0tg3Tpt6R+mMcDanAILs9r1POzzWx8y/az+tSmOBmn0r/ptUveUl4DbeFO83+9+ulKTCEl2mra2MgEpcekF6+WYzOhVlEFZdN/pns+weCa20Ypi38ng7gXDU8WMtCLTNovovLS7gHPk4N52xnbOgTAaRc/5INErlgoCK/iL3Y8M6TGxSFPno/JOLktR/nhK7wWCuNgM8WsjocXWkj/CNLEVUAlIdQEBrsHT3lMIjRaNXBFV9iz6N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bba9b0b-cd5b-492a-a759-08db6dd80669
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 19:37:59.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPwlSWHCXbCyhHbDvwYGyKTx1LvzKGZlqB7P/eIbeTOOBVV+1gxNn0Dg8Bi7ExDZLInVWjJwJCCvHaiUOv1TMnIAwuzSFDvmeQSxRjwGqhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_15,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150168
X-Proofpoint-ORIG-GUID: Ux6AGpiJ98b2yRJC7CLLDu6wF2noEYgD
X-Proofpoint-GUID: Ux6AGpiJ98b2yRJC7CLLDu6wF2noEYgD
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

