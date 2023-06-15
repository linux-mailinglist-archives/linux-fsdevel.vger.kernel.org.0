Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0F731FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjFOSOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjFOSOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:14:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F942971;
        Thu, 15 Jun 2023 11:13:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJd6X008799;
        Thu, 15 Jun 2023 18:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Am2H1tfVpBX3WsdR6C48oaVFcW7lg+wk31j9sk/viR0=;
 b=JqzUTMfloaJh1r1Qu3HThZxKHNMQKqcNk+YBTUzQFAZ8RU05c9QmioVBSrsPLU0LNQqh
 r94f6d8aJythVYsHe9n51uyZihG/iTWsa0odySxmK5/BI18Z8IZQuvENGwYOwH/KUshH
 EQoPlmNUjBLhmBPRocvEg6M23re/0gZVd7YMrdm2GT6ZNQp1ugVcTyOEQiZ0mr6EO1q5
 K4U4hKyKCxsZuRtM33gI0Ii6SoDM/rxFNQ1zbBSbp61AHTVFaLBzICDuwlF/gvmX9W1I
 ZWT63BQlzj5/UP5RpqNLC19X5C9TEh5zUhHfEVqYfaMP2QG5wKlAE63+iSr43QkprcU9 Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2atm3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:13:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGat8b012588;
        Thu, 15 Jun 2023 18:13:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmdj9kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr4lDUn8Y6626w08d1qes/S7gWFakzAGYIMzDYO74N/UNlhQH8hPQvyocRiyEyOPVHvspiUnM6m8f3RZHIja0PNnLwkpVeMvQjreYNZErwDBHTOe5IqtUca3iseTG6umXjCrotATFRQNBsFGGckgVsP/ifNn/ZcxzDlsIirvd56ViJuN0LdluQ2doOaUsPcKVqrckYcF0jmBNlsdVhV1MFrKqbpZBl1yWGCYudJgow2+SkZoYsDpKnGLqp4XxmcA7D8pLAYNOnUb7INwhM8wMfQLq3LLexnIwBsLR9s6Xl24lBZArCdZtGm9dTStT2aJMQlEMVGSvBUvJ/uU6hP1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am2H1tfVpBX3WsdR6C48oaVFcW7lg+wk31j9sk/viR0=;
 b=PDn34J8mot1aMi71bPopNrsNq1sT2H30WNUYj/Jc4MMXtAGWW95yt+WCQLRtI8/UtErADIQGomGjlI8dXe6hrhp8mHCybcPPsXj1wgyxMb77UzlwkbhEJ+XWKm/0Zc5xu3gd2Oav8Sn5Fa/Hf7R6k/Ln8viU18ou+Ad7ZdOz0FHZmFNXF+xcnHjwRLCYGTMoarneMQoBFxp9LFZ7V1w4kGQ6GtgDnVACsQGX+jFkWfdfl0Yb352OxZ7P62NGzS9iaThoyjprTuridHnbtA5nm+/yUxOLjGqUrYgqMNnuv8sCZYU61gl1go1oT5MdjM5y1k00e4aEyMUkmJkSxdSCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am2H1tfVpBX3WsdR6C48oaVFcW7lg+wk31j9sk/viR0=;
 b=trmyt/e9LuVflu4SE25FzTVJiHeXRUuIlCq82a65dmncM5XeCHbLg6WKmG4IKor7mKvuGcXvfp+22q7bJP1oSIS62slwaPU3pxWNlTxN9WVAMtjkLbcsnrGdol7JOSPnDT6snehvX1+YCpReNX0tlp5schYdP7RDTpEwkATrfww=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:13:44 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:13:44 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/11] md-bitmap: split file writes into a separate helper
Thread-Topic: [PATCH 04/11] md-bitmap: split file writes into a separate
 helper
Thread-Index: AQHZn1WvVSWHBDoGoEOPL6s55vFiBK+MK4WA
Date:   Thu, 15 Jun 2023 18:13:44 +0000
Message-ID: <DDCBAAEC-DA33-451B-BCE3-CC627559AC4B@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-5-hch@lst.de>
In-Reply-To: <20230615064840.629492-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|PH0PR10MB4519:EE_
x-ms-office365-filtering-correlation-id: 62a4286c-97ed-4b5a-53b7-08db6dcc41d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EioRAU7/2D3FgZZPAbnr/2JxS118fZXBA5FVK6sDsl03l5oyNXxi20V47P+tGyy9knAAOpnVATKNG0zVMwCX9Na1ew/zrW2aLODoWbxkBy4Rw7bb4XgXJrBlqxPmw+C4skOiTYsFWgFJ1Zx5VmJfvT24WaL9W3BZ/zwjHVgFQY4A9qEU1SqR6ltZb4jsx7xE6YDUpaynXhj0J7UA+kqVo4J+D0HXO1MYbue+NoiqeF+GfV3KTqaFK4vyCxyOaYpivf5MuSjPIp+vn4Us75SGMftiQSgOD0xGQAytcWeAAhwLNGMgNo+5j4Ox366VBktG0cLtfVU/mdNP8R5KodiVeGp54M/MJWbkC4nhStXxLcwddVC9lchyXBLKjI8JfB5vQq5MidQ8Ak4WvVl09mc4XxcbQqkBR99LqfzId/+aUtC3UH0J+Hp0nGwpk/KG2OxpY5asG/v7P2gn4TeiNbxWxDe33mhHJUYNDzb03wUJpqLnzBoM2cy8YNyRlBQ+iq9XrzI7cfb+JaS+zgMBI8wj3tkl4uXl+/qx0IXYiLufjd6YSwd6raFKiG2A8IIUVoaiPcW82xoQCpqcQAT5AcD7ghvApBrYAugCEG3ppPVb4aNyIkRa/i2NiBOE7dTica7lgIdajMN0Rwuyb6L1/rjnWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(4326008)(6916009)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(316002)(36756003)(54906003)(186003)(86362001)(53546011)(26005)(6512007)(38070700005)(6506007)(33656002)(6486002)(71200400001)(478600001)(38100700002)(2616005)(122000001)(83380400001)(44832011)(8936002)(2906002)(5660300002)(8676002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lM6znqs+YtRPC3Yhf6rTqR7ENOiwS1UfIUcSXZFWz6eXE4wkX90gh8ZqugHb?=
 =?us-ascii?Q?Wq7+LdCW+8U28S8logpjjPkanQgLhcGn7IH9tupoFu10fSl9VRs/w9vZKyiG?=
 =?us-ascii?Q?EHPYh2PwPslnNJW9v+U3/9WNnbcU3Wef2oXuMCniCbgz+6NO6A3pPKMvD6pa?=
 =?us-ascii?Q?cER5jWtY7/DZkJ2otc98Y5I6Pf9nyICHQLj20LCPAL+Yx/cIs1Z60UmtBrBd?=
 =?us-ascii?Q?4YJm/Yz9n5r/NMc8CDEUdIWv9N9639vrB4CGzH4c9aro76q4mejPbm0g6tR+?=
 =?us-ascii?Q?/4UDL0pfb7weqt+rtnNzd3qp2TzPB+mwX9NQzNMfxqDCZiLcArer3QLYmKCv?=
 =?us-ascii?Q?AqhkVHUN8gC/nTBj/PGCo0sOsxOPPaCvUmUd2JvDOSOH25zugtl/BU4Zp3Wm?=
 =?us-ascii?Q?Ojn2ox06yWAjplHNrFyNxM+ZMZqstbWnURaC5AgeXohGuT8VQICZBSF/JwZm?=
 =?us-ascii?Q?a8PgZY6SW3AWdEp6kdUCjH6OaZTc//ECdZH6Uix4FYgKqpDCDVL8GizCbQD8?=
 =?us-ascii?Q?q0By6qttZ1oomz0S18KD4gEs6tX0wlJr/osnlUdKjBepehyv++uJOdqWha8S?=
 =?us-ascii?Q?RuDrotI7F8X51r8XDrUlVLuY2De5CSHkojiSMfY0sTWCyUHPGKl+J7dRc3U9?=
 =?us-ascii?Q?wMO5vyTBX8c8oyuZveDZSKJXO+hnM3k1KTZE+jF6HvjtE/ZKNnCh4rYarumC?=
 =?us-ascii?Q?hBmxPMeAgm0NFvTQ9xdQNsUA6p7g9qJ49ZNtyWFeDmgGfoqcvs0lqqRGZ3Jg?=
 =?us-ascii?Q?lPIIOBsZgrg0JORSkkRPmQCxxWLTVdBqsDPdCRnIBdPdydgdbgidDzBflV3E?=
 =?us-ascii?Q?tXeO5Lah8tDxufhoyj9iH5GeaNYedWMpk7KmlUFSuGlIvoQdL3Iz2Q3f1KFM?=
 =?us-ascii?Q?zaA41rityGSnYN2PK8jvc98QEQT1Q8FOhbQ2XKEzp+arbrnkaTa86cuK/VNo?=
 =?us-ascii?Q?UiO8MoUDPiI9MjgcLJ1jJIlFjJwIRcwzTIVrgOnHOzw2qcpvg6liHKzxtaoj?=
 =?us-ascii?Q?aczMsveTefbI1aKkTB0kt4TuN+JUiG+nY6A3Oo1gbe4HMs54I7GsKVIVrELn?=
 =?us-ascii?Q?g7qGQVot1s4y9es+MKuKDlf3FqedA/mWZBuZmRVnOKoRXAFpR6iaHqJHx+Lj?=
 =?us-ascii?Q?Hs4lUjnzb6Vd2afbH522xMT/zr57WuMqZwLqu09lqDttFwlnmc0JFs/0LEw+?=
 =?us-ascii?Q?+3UZyqfZBZmVOBezhkdCxT2Y2YZLoh+FIMWISsPiwKaZz3DQduydUOF5Wur8?=
 =?us-ascii?Q?/N13edO26lSUdRFQPwEBBq6QZq2O3kiE1f5u2eayADLgVLAbInddM72CdpS6?=
 =?us-ascii?Q?w9N21lPkXxCkdkCXbdrfKv/meDfn58GQNSnu3b8gBgiwRcrAXOBsuD4dDNR3?=
 =?us-ascii?Q?4KsVPauig7Ebz/mHfpM1vZsrX5mW4Xk9WvUVcNkRIXBKLYflkeXrOWlPFNuq?=
 =?us-ascii?Q?moVWY5UzwWQ5B6D6Bq7f/JINpfPbQJ8RN+xxi6g/wkuNLfYIWxA20HWuVLlQ?=
 =?us-ascii?Q?Itm4lLtc/MSX2X+lx1iqHc6yLMX0svPORi9c8MQzW+zKpU8x6fa9eGA/zt2T?=
 =?us-ascii?Q?UW4sE9Knf7vopd2XvlrpZslsg4sCx+52BpvaB/iGcRLwqG0DxLmQIEV8s3s5?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F2977A3D354024094A1DB9CBFA7E0CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LiIM5cI64wtGciN5zK2Fk2fv6M04mKDmrAUbbfJBDGSEMPx3o5fHSqnu/jXRAo/D2pVlRbBDHAygTrqmIbt89IViwgsQejfoNhh6Kj7AEvgDwteQ35CWTOGuR+rANTUSDnwhpIxD4NHT3lkqUrh6/Qhj2yuiu7WHsNCAjn3KEQqDE7c/tQwJ+y1i1cpshASwyX5FknnkPz8gaOBPZH7Ir3RDabK6/bss7A3uwPif17V+w5GoagvEs82LTMUCrRV1MSHdagzQUniNQ0/G7BI51Q+P/4X/p/PRh9C0mbgW8SorRlOpGlSACOjZKIvueL+4SRRuqSMsbETNaEJniU4hLuzetghBktZLaZ9DX+tHnZPMphlDF899FHV4X5KGQMCd/RzPt/IWD9rgyeUKnD8erSSsdi8d942BZ5W1LL+o1A1mrDf4k02K4I04RPwv2dAJzAt/+4vCnvIuEA0e6o9bJG+at4FbsAQpkkVjiY6zBV+XMc34w9xs6Xod4hm4zv0dIrSwKlJ1d9LNzq30L6mBw3CglmCJl4arS4DFSjbQG5f5jjKzOAhvddAMP0008B2qn3ft4bOhuA2TpugFeQ8p6qHEyv7j+t1KkhPawtVeWfWhxO2DY6B2KXoIoIQGoYikCIZsnR1kk/KpRYDA71X4lq6K/+yHSFyv3HwjOVEnuAOv6NwoN5Gt5PNOnvGk3o0QKtpE/wsg/zIeLpMGvUqqB3N+0J3K+0JwPtR5y7LIPS2FeMLY/IuptidpO3FCx4GFf0sx72W3M/6YVZ9QUMEZjdJo3axjce6nDlUZ8kwdFZOjjx5jjMfqchci3JKtEv8T
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a4286c-97ed-4b5a-53b7-08db6dcc41d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:13:44.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujdkSPH3cugkoUD5CuKnnhglZo3DuuI3iYmTNLVvMXwHjtnybkcZ2Z4kx17XRZv22j5kmS/Cw7gTs/wtr1O03on2xRv50TG9uAeM0dw+jKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150157
X-Proofpoint-ORIG-GUID: SmS2eA0XezaRz9evj6thBC1xOcfoulI1
X-Proofpoint-GUID: SmS2eA0XezaRz9evj6thBC1xOcfoulI1
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
> Split the file write code out of write_page into a separate helper.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 48 +++++++++++++++++++++---------------------
> 1 file changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index e4b466522d4e74..46fbcfc9d1fcac 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -296,33 +296,22 @@ static void write_sb_page(struct bitmap *bitmap, st=
ruct page *page, int wait)
> }
>=20
> static void md_bitmap_file_kick(struct bitmap *bitmap);
> -/*
> - * write out a page to a file
> - */
> -static void write_page(struct bitmap *bitmap, struct page *page, int wai=
t)
> -{
> - struct buffer_head *bh;
>=20
> - if (bitmap->storage.file =3D=3D NULL) {
> - write_sb_page(bitmap, page, wait);
> - } else {
> -
> - bh =3D page_buffers(page);
> -
> - while (bh && bh->b_blocknr) {
> - atomic_inc(&bitmap->pending_writes);
> - set_buffer_locked(bh);
> - set_buffer_mapped(bh);
> - submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
> - bh =3D bh->b_this_page;
> - }
> +static void write_file_page(struct bitmap *bitmap, struct page *page, in=
t wait)
> +{
> + struct buffer_head *bh =3D page_buffers(page);
>=20
> - if (wait)
> - wait_event(bitmap->write_wait,
> -   atomic_read(&bitmap->pending_writes)=3D=3D0);
> + while (bh && bh->b_blocknr) {
> + atomic_inc(&bitmap->pending_writes);
> + set_buffer_locked(bh);
> + set_buffer_mapped(bh);
> + submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
> + bh =3D bh->b_this_page;
> }
> - if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
> - md_bitmap_file_kick(bitmap);
> +
> + if (wait)
> + wait_event(bitmap->write_wait,
> +   atomic_read(&bitmap->pending_writes) =3D=3D 0);
> }
>=20
> static void end_bitmap_write(struct buffer_head *bh, int uptodate)
> @@ -429,6 +418,17 @@ static int read_page(struct file *file, unsigned lon=
g index,
>  * bitmap file superblock operations
>  */
>=20
> +/*
> + * write out a page to a file
> + */
> +static void write_page(struct bitmap *bitmap, struct page *page, int wai=
t)
> +{
> + if (bitmap->storage.file)
> + write_file_page(bitmap, page, wait);
> + else
> + write_sb_page(bitmap, page, wait);
> +}
> +
> /*
>  * md_bitmap_wait_writes() should be called before writing any bitmap
>  * blocks, to ensure previous writes, particularly from
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

