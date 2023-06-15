Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3989731EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjFORFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFORFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:05:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EDBE62;
        Thu, 15 Jun 2023 10:05:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJli0028523;
        Thu, 15 Jun 2023 17:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X7eJGWbZDbEU/kTdCSXlgIpo/epbK81OlFQ22oE2rdI=;
 b=zcA3V2aUcnTyGM5Yoc+8FZI+UtEtN7xMR1dHHSonUl1SRNzs7gIaKY14cfgFftZc96cn
 +h3gxIdmxBIGaKcMlfuCmZ003TpBSP3fxwtc1y1jM2q8VnhpJx7YZJIAFeoIljqyQ+U1
 jdJnFqWV1S57P/sGqr2crdcfnX9cIIUlmojGMnHmDFoXd8OGSnrdfQgUGbWJBz3R1rin
 BTfS+2f9UlEnt211OXnP3S8pG7glNI98VFByPpK5ZLLRY/PC76Ha+bNeKwAck3xHU2z0
 Ole8UyH2JHRr4FCik7kAK+hVGVciEkmCNAxwR0Eu4N1lJ66Hwjdt5xNhQZBY2ZMjxu59 Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3btnf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 17:05:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGV8qu012357;
        Thu, 15 Jun 2023 17:05:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmdfug3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 17:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwS1iirbSGvS59HuCLBtHIF0zdYXDwOFZo30wdkHzFXdBq3g+xwT3zFycMNBqTodE5VdpTj5S+zOSdmSbjuAEriv5/uH3bH7+kNWnJZWjCwZO0g30bhUDDqDxXvj29yxWRaABLPdwuF7MQgTVO1XYCa+bXy77XcYiwWmFnGWAjoLCYV2lJkJbG5HQ6amjyUip+hHnc5jzMPC5lsH/oCbPAiA7grrTv+B5Fs0f6drbgPaIq9FZ+fPguWmoim5VnKBLgLzON300VO9SMmWbrPSVdxY0P8jikcJSfgdisfMC0xbjHoQVmmm8bUsoww/mqbPBzRp8zW6f69yrqpQb+c3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7eJGWbZDbEU/kTdCSXlgIpo/epbK81OlFQ22oE2rdI=;
 b=X0bVG6h4hb7odyD/X7ABj0HuoZrX6iE7fHgVMeT3q1YwaeGFVZBxrgcw7N05M1ltCfDIGrKKkvRy5TtTKAFsGWGTaILMuR9gATFp89+DzSzowDUG9yQPZ4WtDIcdqK1dBtoJTi/1aCjeoW3HsT9k5c1Lw0Toebz1xpOLhvBy1kwkIkrwTrVyjZPjOb8+6Uqit4Pq2DFBJnCFn90Y49lqmcReRvJpipnHu147U8GrmLPEOZk909J5gl+bIPpA42NaLXzWGqwWspDDCcqW3mVvxI8WS1YpufSoaOudE4P0+dABxtyrdhgLweyVE0ndbLLr9OS7D5SFW2WVlnvXAhwPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7eJGWbZDbEU/kTdCSXlgIpo/epbK81OlFQ22oE2rdI=;
 b=pDqWoxG2BJlr9l/1kQK6Xgd20pGHvyvd6w8RLQbExMVIBv+IxuiKia1cxRMrOX8NsGMHl2xeVVcO7ef8/RK/jGTKAfRe7i9/axqTZnIdrLqntnTe7loYNp1WrDCi1F/ksq7DS3hWiKQ6mOVjAcn4vHpcHsaU8SbTs7b9VTzhmao=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB6343.namprd10.prod.outlook.com (2603:10b6:806:256::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 17:05:41 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 17:05:41 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/11] md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
Thread-Topic: [PATCH 01/11] md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
Thread-Index: AQHZn1WvXfKXe/witEWpLutEojdziq+MGIEA
Date:   Thu, 15 Jun 2023 17:05:41 +0000
Message-ID: <8205E93F-7959-47B8-AB76-B9A65579AB1F@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-2-hch@lst.de>
In-Reply-To: <20230615064840.629492-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|SA1PR10MB6343:EE_
x-ms-office365-filtering-correlation-id: 69f26d06-7399-4ad0-23f7-08db6dc2c02d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncKpx2q3S9opIRIduuHqBi4YjPV4MKbC91ZLXJzKUphSPYzNUJ2TFwGHgQtS9nlebLERm78WpfRckVVtBEScG9uovHjEncNFOBolqo1Q8WqHtFuSFzR9jmhkQUlCH19XnX3ZKTgc68PGhOgldeec9tBAMYYX3T4oY97qgZSHoVD/PfUHTR2r2bTxq+j4A26i4Z4Xaqa+U6wI9W+iAakeU9KkSn95Ko6sRuuY1yZTc/W06eXuEZW6tZOO0jNBxPem5OdMO0euU+/J9qlyqloG1RJnshW28+Yo/Yw8NUzZL/1El8pY+tVfsS7B+Qbgf6txJQNKUe+d+sw++byLjPoeiW/wvTnXktgVTKDfQug2So6ENnOP66otaIw382JovM/b/l1pKZakF/DhDPPVy6wXELZYqu6hgrAK3yYB+5isvSxgyhsvY/ZFzJd+wFd1siMySPshl6SVevUNYYoYZG141A5FSqZbkVgfsAeXhT3FioC6pE/OiTVm1eTx5tXNfvAOjpotd2UMvC/kZ/Bhymmyd7+25GEVt9Xj6U3Hm45JP18u6RTQZRyjw0tBFfDVjZdsf8p6tAW8rO+tAstUIP6npyM7nT0nhHQjn75jS9VnwT3kWRkLpiCiS1ay25/A24hYdHW5okZP+0AVFpmM2ZMluw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(8936002)(66476007)(38100700002)(44832011)(5660300002)(4326008)(6916009)(41300700001)(76116006)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(122000001)(38070700005)(2906002)(54906003)(316002)(478600001)(86362001)(71200400001)(6506007)(6486002)(186003)(33656002)(26005)(53546011)(2616005)(6512007)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O9TWBRG4qdusRGXSKCBGQFAa4qP1SMkcG1LxvTKCTZn4S+Sh0i4tTW90CoT9?=
 =?us-ascii?Q?PbwcTVl8SDuWLClVrgUVkEEmSGe0TqHW50jdJQ0codo/3ohRhHttnZIx3+M0?=
 =?us-ascii?Q?D9RGjBd2U++m0cbdrW6HS+UJq3NMeD5cE9KIAOXQPxnvhdRgIT3MSk1fJBlc?=
 =?us-ascii?Q?ZQT+jxTSeZbDAoYrV3ZiAl9nH8fryl3Tn7AqylZerZq1Xe0wWH62KoZLminV?=
 =?us-ascii?Q?otgUX9OVHp17XtybwcmmAOcsle1lqHUh2tDH5HO3Uc4CDX8HiCdUhBS9TcOk?=
 =?us-ascii?Q?ngf6rszi287uefaFhpsJeasQZ4pRNM/j5TSWdvwE2kqM0v55KID8cuFTGxh3?=
 =?us-ascii?Q?YwiE2v4IoixnISoJ5RmKnco8RYv77Z0gOGgcBdwiNBR5c9FVsF68yvjN4idY?=
 =?us-ascii?Q?nQ55CzPkYTC31Wx0WXY7lq4FOpLSJ6BaiH6QXbAYF3ooSC5W2m5i4WuBavpq?=
 =?us-ascii?Q?T+5zH+QuOc6h84nwQoMCYzzOIYx7p7/4PRzRgeCE3q9b5fbe0G1zB+s7OFrn?=
 =?us-ascii?Q?G2xbpEblbjSH639xRN/16wxWgd+c7OF9RZyu4SZpj6A6y3a7XCXaYj6jCeQm?=
 =?us-ascii?Q?rY5pi8+XVj5iRSmrKPpNEas+Wta/98So88OrKhYI1MZcWOmQ42PIERO6Ql5m?=
 =?us-ascii?Q?r42IiGGHBNbBb6DUJNK6LYH5fSRhsy5Av69U/C25rGzCUakv6NbpvLoDS667?=
 =?us-ascii?Q?7ctSAFsatwxRQPP2MNy3tJUitPUqOKtbTPOKrGKIbfumuwWg+zbnfMTRouWh?=
 =?us-ascii?Q?na7ef/CtIlEywLQTYjdCqpF9dsLgz41NoRPvhoTjyn0/tTKy8NZiLhJjB2tS?=
 =?us-ascii?Q?jxT2/zkn9mhyBNzSuzNxfx9dZ1mQHQufD0FU8VE2hZpnBk6bBoqhw8tzhKi6?=
 =?us-ascii?Q?MmR+bzg7LmoS2Kmf2qP4DBJXsDbHTL5pU91YNQreUO/NYbkBFWJoDVd18DoB?=
 =?us-ascii?Q?7YDrDuVUyIUH0caMv82yGNuJQNlwMoXXKewjak7+lnXu6seV0VZCMcngiEHp?=
 =?us-ascii?Q?OIbV62cfTr9wH7osNfL1ljXWm9hXViZvoCy42IVg2SqhnK26iV2JizQziJlc?=
 =?us-ascii?Q?F1m3GtE7/uDfMzVoco0pogyZ8QYwzXvUCi9cDD1FJ3t8ORwbvAl+kHpDrDz9?=
 =?us-ascii?Q?RvVG7yJRUTStFptdgodDfuSKTqGa1yltNBWYx6v0hWuBxYHWlQRQcWs1+CN/?=
 =?us-ascii?Q?xzgsC2XtIzQNNrRGt4eoIJTOhKCHJcSIQ6qsfNYCYsK49NAG4CrFmcnM4Bsc?=
 =?us-ascii?Q?JTXowCC6Hji1FS/ONhhm2BTgDrg8wbfTgTuqsjwG8ITpheCdsDVRBfAWEWPm?=
 =?us-ascii?Q?b0mgFx8HC2jF2FHRvPlnLM9zP7g6XP0TEfknFqRXB+fkAukuOYRWFSosMzcy?=
 =?us-ascii?Q?0XRIJv6JFF+bm12SoLjUJYiKfuR05WESSR9WSzSBulAv79S0m3870Bfzrcwn?=
 =?us-ascii?Q?JqGpq4bRkotkvCOqisKE7y3rkMiibZtB4awjUkSMflN4ARumY+5wT7vZIcBP?=
 =?us-ascii?Q?TEO+JsO3YwOI/JFB0SnLJ0rMHz9QR4/1iyyGrAXAdDkrPoq6umxa57P6abpK?=
 =?us-ascii?Q?fxmScFs9CH/iiCRDK6iF8JNanvaZJVMeTgblxbcmQDkJOG2TkeTuEt8Auu8O?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0213E8C2F0596345A090EC6F4CAA9E08@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wz3C8sH/MsOxy2TKB0aUtaVfLBhQY1UQys3cc/YjzSQw6Z/X3QphfFKvWzs62N0Iuaah9+A/w4ikUFlDMMiw1dwi/S1Da/KBzp8QTKExdElbD8iA3S/zKCKuHLBYcCg+DC7xJvpqIrYMZdc6jKvMgex4kvXNa2H+3Ljh1/Dfhwg+ENg8bEnt7QEdsbqF0mezzVTEU96aWt75B/yuI/SVr8ScElZ1ow2Ob2Jip3zc7YUysM1pbxCxOZaZL0QwKNt+9mCxZxYKxguYuVryU3WeN0eHdmPhC6bZyqI9huleGscSYb2mrkodw9MJ5l9CeMROjGTsPyTB5LmaGluvsxRBpNXkwmlA+vDipZ3TghZkKrjaPsmLzn7pwSTf+4T2CxyhMsTXtR8UAQEROHGO+0KCfWG5jCmFc5THVx8xu7NoBRCKaW/8xyPLcewDCabc0HZKZGZLMhMwkmTfQ3qNjtlmLnQ996GE/C+TXW7lrebJKL3S8l53Lx+nKwFbMUwzT252+xnX7tGKOH7WB5+yhg0uGuGL6oHD3wtnXbUMZqbAS19J8h+aJvX9rJg2e0HU2PE8uf8dyIjZaYgwVcrVxsVulrbs+AP17R1CppXbxquXBq5DFdI/OArtfT7bV1Nt9GJ71Q8UzPVM108RoiRHFnXYo9Vbvow9IHN7oKhyMRyz0VkiDA1u37b2KfFWe9ebt9XBgNUZVv1aTwy4WiXfSvKztNx7exYEJQN/loWNAiM7rWTi/PWpH7nrOSrFpTyt7f6dfbXxyjir8nRiIlTOpJqXfPlCcqHw+vQTN6SJ3ENC/nIiomjKcF99NYRx4yTn7xOb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f26d06-7399-4ad0-23f7-08db6dc2c02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 17:05:41.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FxVzu7e0cgSTScFge+VN4bkRBcPspm7a3qwYqqWiw0AgXgr2fWMs9Yqw5m+NOstDCZM+Y6xdJpA3Biwb/I76ddc2xJlBnxVy/rrQ+IBs/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_13,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150149
X-Proofpoint-ORIG-GUID: GggNogG71pxadoSdr4Szefiz5XCqbSHc
X-Proofpoint-GUID: GggNogG71pxadoSdr4Szefiz5XCqbSHc
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
> Set BITMAP_WRITE_ERROR directly in write_sb_page instead of propagating
> the error to the caller and setting it there.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 21 ++++++++-------------
> 1 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 1ff712889a3b36..d8469720fac23f 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -279,22 +279,20 @@ static int __write_sb_page(struct md_rdev *rdev, st=
ruct bitmap *bitmap,
> return 0;
> }
>=20
> -static int write_sb_page(struct bitmap *bitmap, struct page *page, int w=
ait)
> +static void write_sb_page(struct bitmap *bitmap, struct page *page, int =
wait)
> {
> - struct md_rdev *rdev;
> struct mddev *mddev =3D bitmap->mddev;
> - int ret;
>=20
> do {
> - rdev =3D NULL;
> + struct md_rdev *rdev =3D NULL;
> +
> while ((rdev =3D next_active_rdev(rdev, mddev)) !=3D NULL) {
> - ret =3D __write_sb_page(rdev, bitmap, page);
> - if (ret)
> - return ret;
> + if (__write_sb_page(rdev, bitmap, page) < 0) {
> + set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
> + return;
> + }
> }
> } while (wait && md_super_wait(mddev) < 0);
> -
> - return 0;
> }
>=20
> static void md_bitmap_file_kick(struct bitmap *bitmap);
> @@ -306,10 +304,7 @@ static void write_page(struct bitmap *bitmap, struct=
 page *page, int wait)
> struct buffer_head *bh;
>=20
> if (bitmap->storage.file =3D=3D NULL) {
> - switch (write_sb_page(bitmap, page, wait)) {
> - case -EINVAL:
> - set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
> - }
> + write_sb_page(bitmap, page, wait);
> } else {
>=20
> bh =3D page_buffers(page);
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

