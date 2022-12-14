Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4642064CCDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 16:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiLNPJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 10:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiLNPJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:09:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027713F6D;
        Wed, 14 Dec 2022 07:09:36 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEF47pt019004;
        Wed, 14 Dec 2022 15:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=T6xOha0be92gQK75D7WxIU5etnmBMRiZNTFMYNWzpR0=;
 b=RMVCRoYTrPiCw26zhgjCkkSHA+I/+ligsNGUOS4QI15Aj3e1T3wnBY1tol5RfHrU4Jxb
 iZ4xOkH4kQLUTcmgkckHvw0GfqjqNeGxhee0Z2Ao2cXjkhtc7jwrQW091dLF2Jm52hG6
 UIPWI0bMChI2W/YbTo8m2qIXhFuXQ/nCCSHI3k1mgJroLVKiv12aM6umCmI84JMSL1Q6
 vmlMdNnFWXJuYGxh18xK8I8whOVDQKg8omoX0w/dk68qmPkkje1niOAS9CBXvuK4+1Br
 pw3cRf5Xz88c0w7Y7DhlkifJQOAOUArlMgqvZ4BnFcnFubj9ODz9HOXWtt4O974IZrGw VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex2g7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 15:09:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEEDv9E003995;
        Wed, 14 Dec 2022 15:09:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyew6nda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 15:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMcVZHdc6c8bbJpEIS5CjUdDrAfG0c8TcFsedX0V/q92v+t/RINbbJ4OHWicCReyFpbeOS32PUFyuHHmfH7twPKz7lsxFSmU2Tm78oE7Q4lT5Cal5GjNBYs6qZbBlIjjiucFSfVk16bMSDTeRB800TAkuhSJOZH6FFpLkvqDXlxmT5NJrZaLS3mKJBE+vg2YOSIJlwehMOvENohco1Qgw6wL/CdPW/7YJXz3bFvMiUo27/AS2IRtwg52bl9I1nWMMTaUYLV5icSy3HKA3eV3inW4eJnQJNnbkaumVr/IaHNYP0MrNUxcatLP/qUJPtwy18CU/yj4Sxh5OOeYJB131Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6xOha0be92gQK75D7WxIU5etnmBMRiZNTFMYNWzpR0=;
 b=ZXGnlhfxe7EGMnRYYBVUaUHptbh/icBWBqBSxJj7QLCgWAuCQ9GXJZr4r2hJ5oBDPj0nOkm6q/IZshQ4sNYa/mHIrRUA5m3W4qJjLjdBNZGvygwrLz7TqOgcp+VNGNkeHwvq1uNQoJ1gNKwLcVqjhKYnqCpIzz6HNakQtxm59wEj98GZw8Mev0jlq4pEfF7kOB0ZSZyhXpB1/efw+TLyXdEQX/k23lcfNlSXZl3r3DO+Qg6RvgwGiiOZrAkFcVwMhdIIcDTGGXqe1dyMrvg+qRLfm0kidnSbbkolqoTLlGTeEtWgvS5kStUHTcQK6q6xIFvM1GpStgNWbtqGt3gJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6xOha0be92gQK75D7WxIU5etnmBMRiZNTFMYNWzpR0=;
 b=AWi+VngwuZ3HJ0T0i+u4QrvGjpLpBIeQ6/Q3y7o0pNCMY2E8+7Zq22Wh8hjAPFZ4AA1Y2plemBXbeCPJAYxOpEhf27LUIzX8AZaa/XopCGz8Y77o5SWPq+x/Ha6qIRVbHRlGcnOz2Np4cljD1MbrtUSb+P/8tB+9d9ycgEk7bIc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 15:09:12 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 15:09:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Thread-Topic: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Thread-Index: AQHZChf9fDsgUtMhNUKtyOAuOArmha5th9sA
Date:   Wed, 14 Dec 2022 15:09:12 +0000
Message-ID: <92B44C88-61B5-4450-B027-60F9F7A614FF@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
 <20221207084309.8499-4-richard@nod.at>
In-Reply-To: <20221207084309.8499-4-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|DS0PR10MB6974:EE_
x-ms-office365-filtering-correlation-id: eae3a383-a789-42e4-15ef-08dadde528da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blvecmjHqSoiUDyYFPlUjDIt6jupazOpCu9vQ419eNmaOjp3P8Lkdez6T2bLIChMjY52UP0+u4NzzTT1vPa8TJFG3qtxZ0TQPZ7BaFtbdVOTIQK8UblHyqc15+n4p/CvQgMjRhh2KU8C+lBdLD7CtBnvAJVB6pSmYH4Aq3ADvra9mugoL04KwwZCegpAptTRLhhzj9cEiFf1zUVvJ7UIZdwsQr47/qM8zzMRzg79XxuVy0LoiZ9PWtzo2WB7DZ+yHjqpq/hW+y0J3qICBtk+1LN4MiOip3VU+niDkn/4JpIuOQZZjWX4P9yBPIMZAX2UJIcHb9EqR+3xohr3cedsQ4i0SAHsIjfJNxnsG/2e+010sJwa6+R99BrUY9hjI+Jcjs8hEirKU61emmZ+MKgsPYPBM0NBIcd+hUGlUxUAitZYbrxb7TEKN+ob4DWFk3e7T0yJAjqSbZNNVi3lUQfOJZf0sdsGbO6GyPm9NQv5WxrnxNdKk0KmMb091R7wVdNiWIm5+gyxNs3hNiR8fcVx9463gbGKQbq98lvHhQvY2cu090UTYVfd+vhV5fTuKEvqb951LDFlgxPzs9zR/tD45tiPpO0rP/7eOOWhuvzX3uSE68yRtYFhkuo4TJgvMBTELGGwDW1pI2FKOdZJraMuYK7qBa0GNuKiaR7ADbPzsxEOp6T327ocpl//gedexM/8kT9v/+vAD6zjkj9IdzVEqy7i7bjHleKtFmtBBODYAhE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(6512007)(6486002)(71200400001)(316002)(66946007)(54906003)(110136005)(26005)(66556008)(6506007)(4326008)(66476007)(64756008)(66446008)(91956017)(2616005)(53546011)(478600001)(186003)(76116006)(8676002)(8936002)(41300700001)(83380400001)(4744005)(5660300002)(7416002)(2906002)(33656002)(36756003)(122000001)(38100700002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xrlKzS/m/LxNVxxxrgcBNUY40cCEhmTimJXxJTfWVr7ocfhSYEquvdCJxcQe?=
 =?us-ascii?Q?4K9OLWyTrbqMNTxBta8AAHMlggrbTy54byM/tQw7H3rTpYLVSkgHcE/y3ilN?=
 =?us-ascii?Q?zjRI4YAJ3SSYkoeqa0B4rV364TW7KAa4DvDPXhXS/COL2MM14TNFr8ZdDZlc?=
 =?us-ascii?Q?IlGvkwLklWv0SOazVRt0F76QNsw3dA0XRYmdHrChNOdctjXEHvKSCjc2mcbP?=
 =?us-ascii?Q?acp5FdBJnGxBWB4/ueCvGmPxAu/mRS+8nhvl65KUt4uop6qnUB3QzDjeZd1X?=
 =?us-ascii?Q?jOQZTRHZ6TrPMaJxpm/UKZ/5YZwnyfImM4Ojg1N7CAPz2l6wTYB4voyi9XV1?=
 =?us-ascii?Q?LO+PQd+JmmdVIhMfGAZw8Fxgl1n7P9vJYdTU9joov8Qe/tKk1cDXTxdKGfB7?=
 =?us-ascii?Q?o59BkaCziV96cGis7RE+t7lGV9I34jAiNjWRcUr1CXCb6AUpvOAYvl4Gs5ek?=
 =?us-ascii?Q?5Oia0us9Ypmch3oWtI9OiIs1otUCgpgxYvfUPsRYgJO3iklsXQaK6KjuHVJN?=
 =?us-ascii?Q?2BbE7mVHnnefweQK7NYGYOB4WSGlkGJiZAqbqj9mk0G6sh4iPV4GpeiFAkEM?=
 =?us-ascii?Q?UkYTKBysJNhCntpb/CyL1/cvWcOtOqBmTIui0HtqGmCP2G4YzPCauKwIclxO?=
 =?us-ascii?Q?ZGntg/+a8912uI3T/fVNzVKh/IJ2Hb8jf38LVgcOyX/iSXPpa8DaOgNuHR0r?=
 =?us-ascii?Q?YSWSfxCsBoBHdOZ7vgttBPw+h87M+OjBMXDsm44YZIuXPrtbe2E4j00ELdN/?=
 =?us-ascii?Q?lmtnlFjvYfmngQfwyxYapXKaiTxCi1kLmsQDPWY2jtJ4Vsl8S0v01HRYBvN6?=
 =?us-ascii?Q?LuCJ4U3MXd4UuGQ5LoDOa2hohk/uQ1RtoehkSOgEqT1y4Bpy6vznXKHIPeb2?=
 =?us-ascii?Q?C51r+r+bdocmuBGdkOSdEsNvhd9PzM+WvITHmlvFlIQrcwRqS16gLHCObIlO?=
 =?us-ascii?Q?W6MaliK9+3Rcwdv7VLo6r5+aA37kU7wcjquRbc/13/z5WRQXC2pL1NJbym+r?=
 =?us-ascii?Q?taeYMGpVC7f3Hfi59FqvNKN5C2UDA8iWGEH4KllOhwDMh0lfutm00f5XD+bf?=
 =?us-ascii?Q?+jae2v9Kb+iZaYk8dDOLAcvI084II7L4we+a3eeZQCpPnnA+aMnBzgTO95PF?=
 =?us-ascii?Q?9lZlpJaZ4kx9sSWnrPQm6IRmZ0MvkqeoA7iwOM81n8MMXm/YP8R5Qr5pBkBw?=
 =?us-ascii?Q?mi9en7iXuitAUjBXliwEGmxjIYjzTNeh7sqbTlmZX4EyLMQQBKpiDsuyCWIx?=
 =?us-ascii?Q?1nP7HZRa4+Ozek9nj8x1xqjJOuu0QrtJ1Km29dDuir1XQGSWCIf3/oj5HRiS?=
 =?us-ascii?Q?74S5bRx96c3sFychuD+NMC/6wRhPepTVULSxvK0EZ8WFhzkLcdLEQA6ZR0wN?=
 =?us-ascii?Q?8pIfmsvLoy1XOJBiHtiP6FFi6pwRPJiHA0obsH2+oMSsAPWR8L+a9mQI5+M2?=
 =?us-ascii?Q?NhKToJb5hgDXcpu1qNzC2vjFzoDRrkT7wUJ85cf+3Sw0geR+e1ZasYzFDnPd?=
 =?us-ascii?Q?PZa/S038X5OfC6tffp9DBVwWQ12C59sau5LsaD/sooxJvvD3o4b5+oiKppm/?=
 =?us-ascii?Q?8z57PNRkChrDmumVu7oeB2jLpc4JetJlf4KmZ+zmJcZ+G4QtCYtovbXtP4MQ?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB3FCD4B09512C43A59F138EF848BAC8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3a383-a789-42e4-15ef-08dadde528da
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 15:09:12.8820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2nSujQR1/O/Z2HJxvD25FYykRCI1idEsdiR5BDoile9Js4SsgAlwaF/zARAuqrcmLO7og5UDJHmczOkS30aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140121
X-Proofpoint-GUID: 3nzQb0tYHnovcu9Cd1QfkEQlZoCuiRRe
X-Proofpoint-ORIG-GUID: 3nzQb0tYHnovcu9Cd1QfkEQlZoCuiRRe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
>=20
> Now with NFSD being able to cross into auto mounts,
> the check can be removed.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> fs/nfs/export.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 01596f2d0a1e..0a5ee1754d50 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -42,7 +42,7 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_l=
en, struct inode *parent)
> 	dprintk("%s: max fh len %d inode %p parent %p",
> 		__func__, *max_len, inode, parent);
>=20
> -	if (*max_len < len || IS_AUTOMOUNT(inode)) {
> +	if (*max_len < len) {
> 		dprintk("%s: fh len %d too small, required %d\n",
> 			__func__, *max_len, len);
> 		*max_len =3D len;
> --=20
> 2.26.2
>=20

I plan to take this through the nfsd tree, thus this one needs
an Ack from the NFS client maintainers.

--
Chuck Lever



