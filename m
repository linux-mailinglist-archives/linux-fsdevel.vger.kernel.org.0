Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEBD732027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFOSiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFOSiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:38:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26134A7;
        Thu, 15 Jun 2023 11:38:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJgt8001324;
        Thu, 15 Jun 2023 18:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SiJN5e2fwxNQua51iLYX6WeUWiuzQXk2imXdP5XqdOc=;
 b=FVRofr9uuEPuHzlEI/njI0KsTfOchBz9dcVzdzmEFrv+qfK9MF+cnoZImlFgHDKsdjWo
 vEiaHNPTvgZ65tNqpQz2ldkwmB1wFreeD4Zn6HNsG2peGLexyZ8pePx/JM5P8RB+WQJ6
 Sc2Z41CjOvlldwBEtII2VcPSNFoDvs4ObD4EUgCE5pKOZmEOzgykC51dUk6lGIc+Km4z
 ZtIpI9bxEsGiCMIbqecAH2ZDGzId86YJY1fuydMaCEFzu5S70HtHQ4k79ohgTeb2ABVN
 nyLMtqxl0CGTTwJWCxcfApUrZynNokVjoQKcVJ+R/q0YVnZHH6xb9mWv+WqC5EUxl+RJ Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs22sny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:38:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FINwTh033596;
        Thu, 15 Jun 2023 18:38:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7af1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjIaYXOU5lXKJnDRpqZy5wjZpR8nmqwce7zdlg0QeJUlWqgXg3OKkZmrSaqUawohWzi0oSXm/6HGsAJPvWj2I3rmyW/1IiKSLy7Yv8YoIdLLSx446usqG4Ne3TOpAmRt6d/XPouzjjWeOFV/WG0obe3ESi16rmh+Q/AN6eUxSUZRa+ITQJUl3THsW3L14QHDdgHdTVjHBEmuXFmXJCWU6EMtwzq2Lf6HuuTRsXDcCqoS0TVgV6zvArY0G2R17LXmATWERjukQq5w0fnswBbsopwTcj2GkmrylipjpjWv7YWM4uqdZ9VScArdZI4tOG+ASjehAGww8LuQPLTCpa1YlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiJN5e2fwxNQua51iLYX6WeUWiuzQXk2imXdP5XqdOc=;
 b=iUQMWWediCLvBTwfQ6Vh9IRYEECvfESz0MVUWlEGOSwZH4NtOYoh4Y8WFrt9kHEqPDsmFerBdqPVV6aOoLNGEj/YrZ/nixCAOXVSqCv7M+y9keDQeo4kKfQENjiCZ0MpqF3d9CbWyEl3al9hEJFzITSEjGPoSmdmhfebgsYP2vudXOBT0nVkjgqIKD7sCwet7bhJdiu7+mFTDDsGl6JZ1tmPQxlDkuGGMaPdXLuy6WLfNNWy83NmvSv/ln0JHEs7ihq4sDIjeJ0g6ZOLH/UKKH3Maeu1g8q0XvUImiO46whuQ8mZQHl/2aTpPtWkRxJaXng/NKVImJlGp+sSP1KBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiJN5e2fwxNQua51iLYX6WeUWiuzQXk2imXdP5XqdOc=;
 b=iye3pg5MVJhCnmlINyPMhnC14DJWyCyetBd1Ykc9hmn9xFn8gSeeDztGNDrMzXef5ZfvtXQoEFkLfEoa5c5flLi8+WUrMMbhPZ5UI7h221K5bKC4LRBJRqDiUpPDS5LtpywI2oh/mcHTpN9yFfOf3I9hnh1vh/Gy4yQDaimbM9M=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SJ0PR10MB7690.namprd10.prod.outlook.com (2603:10b6:a03:51a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:38:09 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:38:09 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/11] md-bitmap: account for mddev->bitmap_info.offset in
 read_sb_page
Thread-Topic: [PATCH 08/11] md-bitmap: account for mddev->bitmap_info.offset
 in read_sb_page
Thread-Index: AQHZn1W2xVQGx04fvEa8Mds3FewYh6+MMlcA
Date:   Thu, 15 Jun 2023 18:38:09 +0000
Message-ID: <3FC3CF6D-580B-43F3-A218-06EED80F68C7@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-9-hch@lst.de>
In-Reply-To: <20230615064840.629492-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|SJ0PR10MB7690:EE_
x-ms-office365-filtering-correlation-id: e0b504f6-a573-4bc2-3da1-08db6dcfab0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XHaYEMIerxJ793cDCftjr4ybzurSjrDtsAgnd77vSmJeFnJW791dqgbmhOVxG6fzkDB+iglWY4ISte9WRFe2V7pqCgi8eIRIokfioh7Xy7ZiL/WIYtR6+kWp5CkfqMTxWNPUPi5UDviJGD+STJvrUF+xDNKCUUAirbWXzVrfQCUfsP0P3QZqfxn62Enme2UJarR/HbpROeK24BfsIa0+pHu0hwiNG90JuGP5l6822rj0Mb5DUgMUserSFiDbB8M0icz60+oOOU9jWfrCVOtr7PDShAQ8J1b0POVVNcGatuJiDK4FSpU3M/BWCo1LO5dQUtlo0bWIYQZflfVRmIcacYVrfyPXGa6lWSWw6je6hcH+VE+eQG6XVbBeJ+RDb7AhW/bkIzmBdnhONQti0RddbkBzR6Id1h5+E6TT7xVMUyi31yHY6h+YtdTHMNrOGjrTs3ckCozuycbsGDnc65rSRp0xg1WPGEQJVYWXvbzdL5+Oc8unsrua4aPZ9FrHZJQpRezTGmvdOu2G/BCCgNqeuxeEmWB0OEyNb6W+DpD+kaWan6yOsv5KNpvcqWU11HBktElOvN0BC9Szch3MVcU5Xr95qYA1zNifWTWN3pOsG9zA4tgySvfK4XSMHLY76eYNsOJn1TKdwz8BbMeahq9AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(38100700002)(122000001)(2616005)(53546011)(83380400001)(6506007)(186003)(2906002)(26005)(6512007)(44832011)(38070700005)(478600001)(64756008)(66556008)(6916009)(66946007)(66476007)(316002)(33656002)(71200400001)(8936002)(6486002)(66446008)(8676002)(41300700001)(86362001)(36756003)(76116006)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXUBAEq6WwRiUejlHM4WDRQPWHhTReRNe/s9/JIXAf0CItRc6es0B8QD3xKp?=
 =?us-ascii?Q?07SmbeuvHpKFZdVOCEIcbqpKKMVY7V53OCMy8RvHFOIm/XVujCA3eI8Ih9uL?=
 =?us-ascii?Q?X1VOGWviSrXFBeKOTePbDm9dwNsxNg3P2Grt6+1MhXkVqggBj0Nvfvz+8uIL?=
 =?us-ascii?Q?SOMmdFRPlMMtEE/zgd+JfeEpN1Hj34pNvVtAH1RT/lHFl/Tdueyqy2+m2pVT?=
 =?us-ascii?Q?3Fm3spSpG1aQ36T8Zarzc3rTfXo1Ls9RscJjSkKn3/zEAOBKkwcT9+mVkyb2?=
 =?us-ascii?Q?PYFv3Ttr+pw0mrSwMgYpezsmzft4qEwvDop5/XA0TwRukzN3oNnz/kra4X+1?=
 =?us-ascii?Q?UsdItCJeAu5cgu1MmT3KUNisa4Av5rOyW2T6RI7YmeTKn25BYnu5hAASvoYZ?=
 =?us-ascii?Q?/pfCJU4KeDwYKg7tpdiPt/OtMcQ/xfy3bVdgCjVAt39cOmznPYgUEveDip2y?=
 =?us-ascii?Q?7zckzriHvSKf36dD3uBmqFt57w+ErOc6pm1SBMvFxk/JEWE69f0OnK1ikUb6?=
 =?us-ascii?Q?W46owVlIFMw1n3B0pWhRdPN+pyBI2o2M/qDJYM7DlmdmEF3Q9i5JMo7MGJTC?=
 =?us-ascii?Q?RtLeMKqmAHYViWBONdprIPohxarTLfam03AilbIz0BI0PTvMuPc4ejyfpUc6?=
 =?us-ascii?Q?OtABBJka5MvlhJZzRKRaXoaBym3FZ/UOuZsI7g9wOnxdzT8WXz2qjX00y8px?=
 =?us-ascii?Q?PxOWoCgrNhA6ZOlue+bommMblCCpuJZeZc9vUIMGx14HFlSP8Mzs4YzZcVWQ?=
 =?us-ascii?Q?8TeZPlJnoIG64urbxFR2fpaHK9hauguejmjqu/IVGmAXvKGzZ7SAxFuThvsq?=
 =?us-ascii?Q?RS3QTMhCDVTdHqxJoYg50nOii9kXp+wtwzOmLzfSiYNsXNyUOFOORREqOIqL?=
 =?us-ascii?Q?T9Pmmt2Jy/d/WjYqAtfbjOCOfLyRLErWmkHae6d8zYTrNla3UDJd/mtIhHVF?=
 =?us-ascii?Q?hNk543gQGh4AONVOlN2Q+MVnEsPchhTjXLChvC3dN/A27ou4J1XyAcqt+SGT?=
 =?us-ascii?Q?cQle7OkGOtrhc+cLaHkZCjD+Jrganq0eX2laGJKJj6wqfA7nFU1VMbF3ZnLT?=
 =?us-ascii?Q?w1qVSuBJbbW4LqnQ+Y8Ojenagi6FDFIQ1opdmFas2gM6Ia78Me+BlVu+fTI9?=
 =?us-ascii?Q?GHqbLxHUPdE0jHy7PCG33zm9rmhnSqVfF8VnB75qmhV1KxyikJAgQKwwN2Mi?=
 =?us-ascii?Q?gnLM9CT1hH10BC3pHHhvxoeBTLPDWoAxWvZHJ5C7bzaTrvv2Wf9lvDvk798t?=
 =?us-ascii?Q?3gv9yAebzg882DIuwizcpPcSViBt6HmY44ZOw/Jy6ao+1Ptgm+BtEhIF0Ce1?=
 =?us-ascii?Q?9FNK74jC8qflbJgFrmSGE0mTsbjLxE9MJOekIWtcMdkBRjHR6HcMPARJl1vN?=
 =?us-ascii?Q?QzuIcEVrMJs0Q4D3Ebi/JW7C7EQUhBy51glWsQ7+mhG1pG1810BatVFrVJQK?=
 =?us-ascii?Q?PlQ+W9V3dWFOojMhaWNao5GpOVdICagzNTJuIf/hoAO6Wnl5XbmRUlENkmlC?=
 =?us-ascii?Q?Z0AcyyUYzekxE14j95tV112HXS2HIlFnTC16CLz5aswKJup+uUK7/UN+iBNY?=
 =?us-ascii?Q?QBApVK6Qcpk1JYFsU7dLySyQ/8dV6TBE2hlds19V+V2Q63b7fqCCQAKFlIxR?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5A153D6F73E3541B0C0A7C0C4BD0CB4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V52JuSYxJ1B17mx2r60kt3/PeV3zB28ZhJT1NAY/DCthjTHUhXEjTphuaWB5OAvNDSba/VdWMsz9MeLN66QA8KcwXesHV8JvHZkQqaCxK1RhHqzBXB7zu1iIWgsq9CWWkJZoBVYGTnc4YfrbD3a+BTZ8paQw5CC81Mkx0BxwZolKGUuNmfbvZq/CGCfPk1wY6+OTKCNcU7nESFoiEsCNSyh4b5172UxpS8V/RWKi/M+47eRkQlgYYEhwGGvF5qHaB0GMqCR+2x67XyThnrubuXXABjnscd8YxXqPAeWK6VHdhWdWE0hzmbsFb/H6rg15LN/hLbdV8pyJw5/C0WAAJfYtctGacShY0PzGAYyN1S6wH7UeNTHV1KJeVWPNjVGAemPVgcpGCCy4aUysJB8rTSw9IkJn4ncFHKixIi1YW2WsQxKmGM228Mgkhl0llll98PdSveu/rSS6VRtM7NJn1ShZIlu5XdadV0zmQ/l0gvdzNZ2LL8ki9H6/jEGkeIXcumv5NWQDMO0Px5Zep66Ann6U0WGQkQ8GFw0pxzpQ7iG2/SG3uX6HJuAXlyjLOHUR6XvDsw2qQBShi6d4eGqVAhmq1eaxCRoLXVK9gGpaWhvizXWN5kN99flJ92ciMqjrAbXzPN1yfPT6UctQOvDB3xVTRH9Iq9pPPib4X9dUJ8VG+X5+tJ9ZPFpzQG8dcvzuKOz08RgPm0T/RD+gmdsbPEcec85AnWl+8UrEOLTraBdV00Jvtv/wtIWNV9ZF6a9o4u6mFuX0t3zfIMKAnTQ/MQUL+zKLQIeMSRehYtCFJkjgsJD2NsnYVKh9Var0YcjG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b504f6-a573-4bc2-3da1-08db6dcfab0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:38:09.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JL7JUTgYONvO/GQJ/W1Ln8JSy+OblDRHNbK9lJM64tyrpc1Jz4mliKm/WokRnO1YAZoEd7s2PT35Ld6n8+b+gdHffTKWLR6VD81yWkzL84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_15,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150160
X-Proofpoint-GUID: 9PgC-cbPs06JfLa2RQS_xJVwvTLuUqYa
X-Proofpoint-ORIG-GUID: 9PgC-cbPs06JfLa2RQS_xJVwvTLuUqYa
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
> Diretly apply mddev->bitmap_info.offset to the sector number to read
> instead of doing that in both callers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index f4bff2dfe2fd8f..39ff75cc7a16ac 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -145,7 +145,8 @@ static int read_sb_page(struct mddev *mddev, loff_t o=
ffset,
> struct page *page, unsigned long index, int size)
> {
>=20
> - sector_t sector =3D offset + index * (PAGE_SIZE / SECTOR_SIZE);
> + sector_t sector =3D mddev->bitmap_info.offset + offset +
> + index * (PAGE_SIZE / SECTOR_SIZE);
> struct md_rdev *rdev;
>=20
> rdev_for_each(rdev, mddev) {
> @@ -593,7 +594,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
> unsigned long sectors_reserved =3D 0;
> int err =3D -EINVAL;
> struct page *sb_page;
> - loff_t offset =3D bitmap->mddev->bitmap_info.offset;
> + loff_t offset =3D 0;
>=20
> if (!bitmap->storage.file && !bitmap->mddev->bitmap_info.offset) {
> chunksize =3D 128 * 1024 * 1024;
> @@ -620,7 +621,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
> bm_blocks =3D ((bm_blocks+7) >> 3) + sizeof(bitmap_super_t);
> /* to 4k blocks */
> bm_blocks =3D DIV_ROUND_UP_SECTOR_T(bm_blocks, 4096);
> - offset =3D bitmap->mddev->bitmap_info.offset + (bitmap->cluster_slot * =
(bm_blocks << 3));
> + offset =3D bitmap->cluster_slot * (bm_blocks << 3);
> pr_debug("%s:%d bm slot: %d offset: %llu\n", __func__, __LINE__,
> bitmap->cluster_slot, offset);
> }
> @@ -632,10 +633,8 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
> err =3D read_file_page(bitmap->storage.file, 0,
> bitmap, bytes, sb_page);
> } else {
> - err =3D read_sb_page(bitmap->mddev,
> -   offset,
> -   sb_page,
> -   0, sizeof(bitmap_super_t));
> + err =3D read_sb_page(bitmap->mddev, offset, sb_page, 0,
> +   sizeof(bitmap_super_t));
> }
> if (err)
> return err;
> @@ -1127,8 +1126,8 @@ static int md_bitmap_init_from_disk(struct bitmap *=
bitmap, sector_t start)
> if (file)
> ret =3D read_file_page(file, i, bitmap, count, page);
> else
> - ret =3D read_sb_page(mddev, mddev->bitmap_info.offset,
> -   page, i + node_offset, count);
> + ret =3D read_sb_page(mddev, 0, page, i + node_offset,
> +   count);
> if (ret)
> goto err;
> }
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

