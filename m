Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DE731EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjFORGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFORGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:06:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44DC1721;
        Thu, 15 Jun 2023 10:06:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJ9C5004845;
        Thu, 15 Jun 2023 17:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5V74jxJk1lA1LTyfUqY+wGm5m3AF/VW1WLdqzv2wXpg=;
 b=zZng1oauV5CL9lAtVyLJN3AfoiLW/oY4sGDOvx9WstMvLGgE57Wf/xHRWdilZHgDNGwX
 LTYr/pcQGklXdxB/kBepBZarQyYnUfyL5HBlO8TVh5sFFbg2V4JYmINlLoIt9HM9RSer
 UadCRd6tYS2dQE3I5xK+eSJGi4k/Dl3uIt5NYP4AhKYXWtJOoexkbzPvoFJ6+ke5O/6C
 R0tpusBh0d/AqCn9dr1UoCsAJgfLZJU6QXcACZehuiGVylSpl93xCYO29zBlzbi5fAsP
 JsvUeSz77t44D2/aSEn7WWkruWQDljdEKDJWgSUgo9DE/A4FspV1s1gqR1mbbhVl7fux Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu2ewe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 17:05:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGZ4PS012563;
        Thu, 15 Jun 2023 17:05:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmdfuye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 17:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg8f9Aqa5BPSXS6bi7S9ZvPyYPzVLIpDDO0T1Qsk5PP2eWYwt9a69zWx3r1GCFnzrJcGaVb42O2/5C3l762T/wrsI1qIerWtjAe+bKuNuCs1Y//c/sXoy8SIyU+9z0V5ekDf47YlH47K5dIlSIv6I309Vxk3xHPm1DZWtMg1+VP9sLzkslUi7WcZyIvdA/cTj6umztVNv9ZU89NIXfrQxb5nRI9NvLbJuy5RRsgECtBp4l8bi3JxyskuQQHHMBHhaHDanFAjthfLw62LpH+Zq3CrTNuw3U8tPST/ZOIt1hfeCAEE+yZy+k2ZHAxdzrucbGJrRGD34BjxVT0FLSpcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V74jxJk1lA1LTyfUqY+wGm5m3AF/VW1WLdqzv2wXpg=;
 b=GLyJ/Uylg6C9bMSHLdg98PUe3yq1s4C2zS0kHSaVM/pHe1XyUWuN7c187Le7J+Y9h/j+y0u2kfMKSSNZQO+LgtAgXgqdGaFQz6yjwQ9nZtfwihYljDDWphdKkRrfYf27c9sjsiFA0IEF9molGZYdKdnN5uMG1Kyi5Ijgn32BILsQcOdgeoBxzH+UOUQL6wHXDkQ6Yc2MuVS03upafv5LzePmCP2dEP009qOfmpQZEYnK8ldwE6JkdvJGmH9k6f2opah+XTF9ntOM3W52bT2iPtKokqrKgDOWDYvFu34OhWpPVgOjRO2r2CDcTFS+mn5ept3fHiAF8SjO3f3/dfFyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V74jxJk1lA1LTyfUqY+wGm5m3AF/VW1WLdqzv2wXpg=;
 b=Lo1O7r7wF7rg5GDMQSKR/oVFyMTAfuKrrb+ErNIs5Kz8cS1BN6RQFR11VdX1QJINrwuROqz+8PLsLZ0Bj6t3cK8QYAchoD0oRV8ODXPuN1hYO/bIuhNRwUJTmlpRioqY7IJW9l8FNd8WaoGgrWj9nJkYdxYWEuNf7Hz/LrHlrGo=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB6343.namprd10.prod.outlook.com (2603:10b6:806:256::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 17:05:57 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 17:05:56 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/11] md-bitmap: initialize variables at declaration time
 in md_bitmap_file_unmap
Thread-Topic: [PATCH 02/11] md-bitmap: initialize variables at declaration
 time in md_bitmap_file_unmap
Thread-Index: AQHZn1WvTJADD9nT1kG8q/134bouQK+MGJUA
Date:   Thu, 15 Jun 2023 17:05:56 +0000
Message-ID: <4ECEA54E-F90E-406C-913A-3D345193FECC@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-3-hch@lst.de>
In-Reply-To: <20230615064840.629492-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|SA1PR10MB6343:EE_
x-ms-office365-filtering-correlation-id: a382870f-4e60-4c09-4281-08db6dc2c933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDvQkVW5GiIxJmXZyuqlxvPxQwVqNq1Yc55hhOcjKETwzFYw5l1QfJz1wtR9SepQGFfnlnQRKAy5Gpy1flqzezxSMYyNLILeUqtJaKDZTqmaxdfQ9c/rK/XbzSOIaqgfTcxgKOpX7HO4N86utCTSwWVDkNcz8Enoyzr+flHcjlKpSmrcsaVg3uasMnlAPeoE3O9/815hkQotbrDjJsNZllrCHLjPee65hqWAbMUkLszXQ7TyGmaTJMahv7PM/M47FyC5cNZSKxSl9bnGh4885Mn0HVhSqzk8vmn5/s6nBTZ7IPAYm6ocV/wMTuH5lozasbQ9YQprDcot4xeM2gkNsWvKVc55ITGq9mEQfwtWUc9hbsja6tv+iP7iP4X2JKVDOp6+OLudV08fvmBhV3J3QGbJdaqIk8Pz5V0+Ny5lwe+0olaWF4xWOy9sK22G8Xg9Fup7CWYF8irfIYACqZDjuylI23Zvf4lROzDbg1DBdeRIheB5tNS06MiKguf5rwwnY5oyikhbV5K3btslujy9P/QBVxGrafxX2MqqaAENECfLCKm/0ev5gAfbetXL2TJeBmy/VyyxYEfOcgLXJTFeFx5891OO8mqJjJvUV4SD7EU+dmiL5uocbsK0qx+DlqgBvi/L9Y9PAghM96EgSuj6hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(8936002)(66476007)(38100700002)(44832011)(5660300002)(4326008)(6916009)(41300700001)(76116006)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(122000001)(38070700005)(2906002)(54906003)(316002)(478600001)(86362001)(71200400001)(6506007)(6486002)(186003)(33656002)(26005)(53546011)(2616005)(6512007)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qHy7r8X45WDt/cQ+M4U4qJYzRnpRCbjGvMFfPnPqgNTsGMTpS60UaKJeh5Sp?=
 =?us-ascii?Q?+j0VmoA3jzJwj/1snRSg7orUyLkJJr6lgKE6q2VH80thIRjicv/D9k4mrCRx?=
 =?us-ascii?Q?xtu8/f5hAZbQb0xiiAVEZyzLSuTjZ2Wz7KsxOp80VuudHjynTFT7nFx3pZmB?=
 =?us-ascii?Q?xQrZntIPxECmqIX4G98ihgHLB/2RdHEQzcKEy9prWCMHKwHhM01SM8/zSiRu?=
 =?us-ascii?Q?akPvzxK1p1Q5DfTRCL/gPFHICZeAXQFAFy70KGoki7Eaq1YpvvdBqPgQJ89Y?=
 =?us-ascii?Q?35STUwFSqnxrbXqmCqf80AcGXVd7EgpZu1vEMgh7XxXvAeFpmTvar5zA2Qh7?=
 =?us-ascii?Q?fpf6vJnG0zXPMMIuaWe4iBrQ09BTSsDy5AZZRGQajpsYajLVEfa9FhJkPUYB?=
 =?us-ascii?Q?wBlkUnVwzmirxF1SzTKEzofCQ+aWeYkJ6ref1KVN1VnX9UKxuy9FVmx2zFPW?=
 =?us-ascii?Q?v2cSB1uYQ8ccC4z1qjWRTN2/sBak6QTDP5Z/7+1jRd7t7YZ/nHWIw8FASf2c?=
 =?us-ascii?Q?fMz6UwGVKktR5x1FkiAEzj6PrI5miyPMmVeT5TSqwz+02N6HLkq6UMVVFgyM?=
 =?us-ascii?Q?gdq4/evCdV7oeNJFxJVJt0x8VuFtRS75XN5nbIdCMoDDM+Xu19SCeqdcyk3L?=
 =?us-ascii?Q?CZWJVqv8mX96Szh1etooYqR4IEUSxu+ewvSAEbfoz6mNwEuGu85vsxBiZ9eF?=
 =?us-ascii?Q?3mhUxMbC8eYiCt3Arg0og5/C9rhCOhLM91dgBlzhEjtQzHrQrsnU0oxCQveT?=
 =?us-ascii?Q?FCXp2hMkZoCGrBkKV3KtdBfF1yZ0W680yuL6J1YMKPqf1SRUGaODJ+Ktkv0J?=
 =?us-ascii?Q?xHeokTwgVpfBtTEAtmrmmuPAJr0aiBf6LmfxVioP1yS4Nm5jopsLYU2bJo7F?=
 =?us-ascii?Q?L6+BNZArUHA3qcBZlC1ZHiTHqT9cWKIo0wbw/2PPZSp4I7+tEE6dQfIbcPBz?=
 =?us-ascii?Q?rSt+9GNq8sKX0oSrmS61fkmTo2FAR75Ox5cqplqtatSBcU80jLUOd91Wve5I?=
 =?us-ascii?Q?DIL1afAV7Qwy3ifuW4KsUUwk81lhVdnKFC78KJA8bJd17eW3CTUrNEq3qnr4?=
 =?us-ascii?Q?TMe8PT75FCIMTmkfGLIHDJmiQjhJCwojg3lTvFKPwVzSaG78ZJwtb164vm+e?=
 =?us-ascii?Q?gFcZJLu0CGvRX/S9UsUd8m3bqdwA33mNMqT4vv78QyIGcg4bMuipQL5btl4s?=
 =?us-ascii?Q?JkOFPqanrhSORBqrEhdsDMBeLiUNhHDERF+rgFOJLUBh8Z4X3Po7YNpYwRxN?=
 =?us-ascii?Q?MiTFQFVXyl1yydnn9AcWX0iAIcZgE7c3bHKPwEP/1r5nisHr2KVvphSdfql5?=
 =?us-ascii?Q?hRTxdmpEXwEiVAjJK9PseWGFfklqsjGTJCb59cMHSFCl/8Z11zEqFq/kIvin?=
 =?us-ascii?Q?riXDbtspv6Xu2gZ5ac+ly2n0gtel+qeLBBlnfd76Ouv7v4dS7OBswbsCkDIG?=
 =?us-ascii?Q?VMsH+lZlDeb4wbhrZpMVrot+ZzqSC/Y79bqULcoR46PTQLXPuPzg8PnESXko?=
 =?us-ascii?Q?/W/LwWjDTGGpfhelGXMc8l5Jr3IThmg1VpZPoTvm/ON7UZwm7h6o+jAI4KJx?=
 =?us-ascii?Q?/5p4Ys5yDyfHD0lwAXQKGdXs+az3MEtQjaGbHXE4R/yQRFd8i4cZzpAti5W4?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAF84975B4F45C4E83892E7C76F9114D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NcJ9TtiUeK3zr3VqNlCLDGllNoRCUOR+QxEknTvGoUvAQutsKLjzG+giOcfZpdNKlB82LC4IpRJD55XZZmUxOcRSib/EtnhCumScmEalY1PAQxe4tzTTSDY7gk06FybLQjfEROWQG0Xyy4NWF0d+QOSoKzM0jjQQh51lsFbRGPBsYOZ6Sv99/PiUNuNnn39hcyC1M9UuT83fBljsLoVS9EEseWhIuKXVD+Kc4ZB8EI0RqZqFYn1ALGskCdoPGG/wsLyuUm//3hgcP0EDLzNGYw3Sh3oUiQvKP57ShHW9QnRg6CKulCVACrWEVdxRjIep0ufLTnLfAev37sp5cf+RUkTZmiD/ICgUmrG2RV2wgl03u0cyoZNhIRYnJPsAlfh3U+0ZIm34fUht1imrTpnpS9cmCRjmWUczH2WfE1kNrb7kTB/XTdZ098eDTI0p1jnzuindAOqaaVG8xIEbzrL/SRDuickkeRHpKIxi58sqbGS3+HMy/44deU+Uk33LuaUj7u/wM8JhK5gNWUp/3XrkTfWO2HvvEm8N1ocJceTlshKEtKKk8NynE9y+eiWi/6nULRsCSQXUihOdeW+eEt94DXf5XRFh79L0h/cTHF7c9Tm6BGTLVazUEmJhpd+humpZJmBUFVul6FIPgmebE6V2RIe/kGzLpseB+Jk6fgIxVQhr7OLjpTooiTMlwq7slKhwH9IledgD2ggy/VDmVjIMc27MUKskeIkMXQlfKNjhoDu+aQRn4mUSbB+WVs4Gbj5sRyakbiX8/VbxPgBO+eX5ZThV8ZgJmBpPJ6QnxacuDirerLYIZPsqr7TI5WH05dgW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a382870f-4e60-4c09-4281-08db6dc2c933
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 17:05:56.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNJNXrpFBEj0JU0gNbXibCq8J/IQiDP8kjSyS65PV8/JtYv4XSje3eKwH4FnOSHTXlj+T5CKDl9qlDe+C7BedqxVxUTSbSePr/zNmBWDe64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_13,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150149
X-Proofpoint-GUID: SPVHG4-6mvsvGtzEAYsT3WwczGvujBNl
X-Proofpoint-ORIG-GUID: SPVHG4-6mvsvGtzEAYsT3WwczGvujBNl
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
> Just a small tidyup to prepare for bigger changes.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index d8469720fac23f..0b2d8933cbc75e 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -842,14 +842,10 @@ static int md_bitmap_storage_alloc(struct bitmap_st=
orage *store,
>=20
> static void md_bitmap_file_unmap(struct bitmap_storage *store)
> {
> - struct page **map, *sb_page;
> - int pages;
> - struct file *file;
> -
> - file =3D store->file;
> - map =3D store->filemap;
> - pages =3D store->file_pages;
> - sb_page =3D store->sb_page;
> + struct file *file =3D store->file;
> + struct page *sb_page =3D store->sb_page;
> + struct page **map =3D store->filemap;
> + int pages =3D store->file_pages;
>=20
> while (pages--)
> if (map[pages] !=3D sb_page) /* 0 is sb_page, release it below */
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

