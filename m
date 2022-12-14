Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1709564CCE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 16:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiLNPPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 10:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiLNPPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:15:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE2B879;
        Wed, 14 Dec 2022 07:15:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEFDxeU008494;
        Wed, 14 Dec 2022 15:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Kcd3VMaY1SwugKoDYfuYqOnAphk6F0GYuWMuzLbwwbY=;
 b=0NJADjR4RQemCjLBIArA2BHPKUL8vVKp0IigmYlCXm7Fx6Osso0/1Hv8biGbdIph2uo1
 fbn8I3XmizDJ8Do6fTJaN9/y0e064sRe9CDo0/zWyKGQcxLmmQ/E890Qyg/ORautaqVG
 WNmnxO81NvG5UHwEVkop+H7MSVBbiSNbu4vBH840CHCQRlhgJBAvbRZR8jAoILX4zZyk
 U/dzjN3h1XLPDfO1mxRlfOIT9/tYYQkP2TeTbQTMna3MqF6IRqiAXZa0ICzfKjfyrFrM
 o1xUKQLjyEuGl3r5Qqw24tmyMSgFByNrSwoV1NFDAAq4x5Mlqa0h0ama5AAfSb65xSZJ vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu2hm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 15:15:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEEDRjL025249;
        Wed, 14 Dec 2022 15:15:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyememch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 15:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM3LTBmYC5csFdsbgc3w5SRH38bO7wtia8CyCBttTOxO0GIz6DS58yfia6u8Z4VA+5fimoO+6klhJXA71+hGd5PCORvSnfXvRs0r9WXOswEi2tw46I9lT0Y7DMz/plCLA4ZSroWEeObfvfiCXBs72Ancb5abMAkCGyEyeBzhMc26lR00JgcLAySp8KYkSUTMBnWfyfKKmwOBlLzuLXjsJ2UITtF7ZeaMpC9J5CQPi6rwsmxzhZkiogJ3SBlTKx8paxETUo0stJp/LiQnE194DbX48ZnJ6MUjggpsV8Wv/M+5mN/3geyAPo//Z0z0KmxIsoU8HAsLtvuB+0UMhuV/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcd3VMaY1SwugKoDYfuYqOnAphk6F0GYuWMuzLbwwbY=;
 b=jK8k5+W1IwYPdZdTIrrMBuRcF5RlkTLN8u+sYp0PiCXdQk70grDGmboCQjrEJG9cJFgOAochxXgKMzx99ypOMP4G7H4cLdWQ4/40HMIajUq50F9cPymHZWxsVmcALcswziePp3X6EtMvFxG/wK7IE8Uyn4ZdBilemjQV+8l9EfFy4TbHc1+8txq7li2BOnKTpwqu51BhHqg0oQqO0S5ebo1+AlbFaQJyrnDtZpYTU950o1p6VB7HytMFTf9OpG0CHeFE6rFSq1bscaHDbuMFejF+OFGPTsCT9CGk6Ikw56243eBm+LkU1neUJaeP/b96H6mIq/MMCf8i9DkFyIJqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcd3VMaY1SwugKoDYfuYqOnAphk6F0GYuWMuzLbwwbY=;
 b=GzSqObsYiqBa6CcR0UGRktw7yRHuwjPGq0DU6YXA6QAPx2LlMruTObeXjsc8RMSQ3YhFWVXGSgFzrmxdX3kvt8VOFetmzXjQ7E2S+QdyijR4WMe+3sY8TtBegojLucu5eOy2L0+FKNiGUb5aAalmI/cdePrjhYPLuGnVo03Hiqw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 15:15:21 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 15:15:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
Thread-Topic: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
Thread-Index: AQHZD87isjNJtSzjWUmQcIhiw7etvA==
Date:   Wed, 14 Dec 2022 15:15:21 +0000
Message-ID: <C5BAFE20-5325-4DA8-B933-364E0A0E27D6@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
 <20221207084309.8499-3-richard@nod.at>
In-Reply-To: <20221207084309.8499-3-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|IA1PR10MB6122:EE_
x-ms-office365-filtering-correlation-id: 21f1f2fd-9c36-40c9-c8b2-08dadde6049a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwYijgMMZBXL7gNlWNLnqd9KZJdqkNHB6H8ftmD1YJ3+AI/sXSf1TuCbX4StN9iNKL8Lef7RL859W+yCmQllyF6MwZSF6bKocW1gbnmqA1RuQMqvZ8HEBOeSjY4z/9aLxiEKSLUndEUjy95HEGzhRX69IZRzEMlD/pyM64a4EQ4vbJoQMxUBDzT/qVVefZTvzyvXTsac1AWakrP8iv4LaYri109cA33WoijyUgbRPKyaxWT8cwWD6ur25QJM8UxyQnhCSeqrbw8Wppg6QQXO3uSJ9uR3dsha0kYnwMxEC0+ZN362tTf8IuVHwzX4i/lipgYZgGogxZU8ki4wcr1thD8NcgHgV52sbUyHJtPEps87tcG0KQHiLsxoAjbV4cZMzaW1n0OY/ljMTJgI3L1E5vn2NbSbFOVrCAui8f9oGjqWFkVN9eW7vUYfq+6/d+ukbLmh/oB9aOc6214xnHWfKHIyS4PLdVPqV0LCKR+uJznHs0vh/D+cDccbSkHPRBhO67FfXOWdje3j4liYExrFDonmqz1byuANrW0at9uylkfYS+Jqz3etFO8NGdmk5SZbgJEdu3p9n919lofPymf3tDMzvauBXR4M6sR0cPYRW+9VCFGPk6quw3TjV7Ghno2kDLw8/40HzK0dJN1xonfgxb5TyRsCSlXqraskPeCgq/bnrVxUahxaQ/6FpL3x5cjy3f7i4VzvPxMnhd+Lw6T3WWrI8qqkahphXDugh21KGNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(122000001)(6512007)(38070700005)(86362001)(33656002)(6486002)(38100700002)(110136005)(71200400001)(316002)(478600001)(54906003)(8936002)(66476007)(64756008)(2906002)(7416002)(66446008)(66946007)(76116006)(66556008)(41300700001)(91956017)(4326008)(5660300002)(8676002)(83380400001)(6506007)(186003)(53546011)(26005)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xk7+UzLjzdZ25szJuoPwYMvt+lLP97UiXkS5M+sbuvAQsTYRxbMpxwotKwRU?=
 =?us-ascii?Q?Xx1jLpUEA33bt3I/Hj8QjcxuwzgglF9f2wGeH32sKZkgYzcAocWfSufgl9/w?=
 =?us-ascii?Q?bgUR/O7M03I/4Z/bHXVFSM8lbPEMw0ObuOC6qrfz5HxoIyYe10gi1l+aY2ra?=
 =?us-ascii?Q?gQA2vE4Kr9T5PxlN4q+ypCNMjyBS/7wIO3dDMPneUqRW4PlAZaj2zyWDETfS?=
 =?us-ascii?Q?f2M5r1u6otBdTPiyBYTkWF92L3e5fUykRu3NK+uE0ONoJJr/lvgwLtSTK14K?=
 =?us-ascii?Q?50i14W3Q8l7N3E4MAScmF8qgw4p6VK3328fRF4lTjgEKZTtqtfIvD+BMa6Mt?=
 =?us-ascii?Q?UfvTM94gogZq+1EAlZlzr+6eAB5heD6nzu+9tPTwaZE3nAWych1VHMqiy/ri?=
 =?us-ascii?Q?I8R0aqdLF/JDesVkf2JJ65Fphg4qRXOA68k9p91OiKDduWcn0F+b89n7SIxT?=
 =?us-ascii?Q?k2sqUo6HloQIeR7uk8sr9YzKlvg5iY5uk8T2CMeHQYkiSAKMA/CN56z020LQ?=
 =?us-ascii?Q?pygBuWx3cxEwKhM0qFthWf7qX8KDkYPD85jYm8TPBbYGtcd4QVwE+EJi96Q0?=
 =?us-ascii?Q?bOVys892WrjhnQyD+zqX2ZqO0UMAdLbhRVPEhNmldSZyFwxbBg0mB5CZ2+WP?=
 =?us-ascii?Q?ge8HS5CPNQfCj3N+S6hJFdwfCxQts1m2Ezw+3Pylh0Zr/BV6gdYF+cAw8riE?=
 =?us-ascii?Q?0BiMdDNafu31NSFv01A8I55LPu5XmEnESgjfRj4VNeY/aizDIkHjxa6CLk72?=
 =?us-ascii?Q?wDp9vov30OCRohCaQv8OBb1PGRPhnf9E03TFNL5VjqiXNsTYzR8Qr5yx5nst?=
 =?us-ascii?Q?qbvz0pUxHHJGiZGtBhMX3zL5SrCGckD2n33vpgI1/MX3639FvIsmTpUNHwy2?=
 =?us-ascii?Q?5JDjqkAdJoHhV1Y3ykdz13ffsVkDui+m4tv15xkoumu0nbKGPUqIk+Kf/i7f?=
 =?us-ascii?Q?0KJ4xNdlcybBNkvsQ2eKlgwKhZd+oaGWcrmC3NXDI+aVGT0y0blluMzkLkh2?=
 =?us-ascii?Q?krmy4mmOoyBKD2SUw0D2Q/rZ4eCxn7UbppX+TdTOOo16mX2tAcgCIKyWIoAi?=
 =?us-ascii?Q?43JAOXGwTi8A9XghzQPrkBjNb8+7DFIBfakQqsZDieeS91iq79M5DYiGuE77?=
 =?us-ascii?Q?vjpdyoYc77AUJ6uFJ/4+REUyhAgnfRmrthE8bTaAS7tyiHC6CKdOFQII0d5w?=
 =?us-ascii?Q?8Me9sE9/8vkRes8YrZGiHBCqJx7eNMf1YI2VDpdzuv5BNaOcSMuaL8l8cV8i?=
 =?us-ascii?Q?GLoomA76JUxXO497kO+tCloAjtCQNgUfdeDwi90DpsrK+GXI23q/0CKfTEMU?=
 =?us-ascii?Q?QVN+R6P90JfckXLdU/OWKTjWLJZ2jlYL4Qsq47xnvKhZGv/lujCItaNFazVQ?=
 =?us-ascii?Q?GuVRvhsuP52dlwuQQvkHFRGgQCOd/G8BFp8YVDeBXrhqS/9IRuodDViKsNv6?=
 =?us-ascii?Q?cBlTQep8ByE8uNj0o73yKMNv01jdcow4Jn7YEtvGyBhc+yw+fjc4k0g3/Ur6?=
 =?us-ascii?Q?F7bbhSeQZJcT4e/tUyiQFseJ1Xen/s3n6dhTNpfZErjx856lahDGIW1ATiz+?=
 =?us-ascii?Q?mwCzL37lPBnvTpRP5pZt3rQ02ht/jbvTFSqg8jME7KuRZNxdh2QX35LK6230?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C479F86C1A280A43AFFF5E23F5384D9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f1f2fd-9c36-40c9-c8b2-08dadde6049a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 15:15:21.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwEczsci9EbAgVbQiLkhR+wsU7VkuRGQNbNhg5S/osnjsMh7tj+JTBCLCBJw5XQyZ2WCkiuaFa0baj7Ze6NPtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=955 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140121
X-Proofpoint-ORIG-GUID: Bs2Az3BC9072V3Crga_-E9pj9CrUnadh
X-Proofpoint-GUID: Bs2Az3BC9072V3Crga_-E9pj9CrUnadh
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
> This function is only used by NFSD to cross mount points.
> If a mount point is of type auto mount, follow_down() will
> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
> to have ->d_automount() called when NFSD walks down the
> mount tree.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> fs/namei.c            | 6 +++---
> fs/nfsd/vfs.c         | 6 +++++-
> include/linux/namei.h | 2 +-
> 3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 578c2110df02..a6bb6863bf0c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1458,11 +1458,11 @@ EXPORT_SYMBOL(follow_down_one);
>  * point, the filesystem owning that dentry may be queried as to whether =
the
>  * caller is permitted to proceed or not.
>  */
> -int follow_down(struct path *path)
> +int follow_down(struct path *path, unsigned int flags)
> {
> 	struct vfsmount *mnt =3D path->mnt;
> 	bool jumped;
> -	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
> +	int ret =3D traverse_mounts(path, &jumped, NULL, flags);
>=20
> 	if (path->mnt !=3D mnt)
> 		mntput(mnt);
> @@ -2864,7 +2864,7 @@ int path_pts(struct path *path)
>=20
> 	path->dentry =3D child;
> 	dput(parent);
> -	follow_down(path);
> +	follow_down(path, 0);
> 	return 0;
> }
> #endif
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 157f0df0e93a..ced04fc2b947 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -63,9 +63,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry *=
*dpp,
> 	struct dentry *dentry =3D *dpp;
> 	struct path path =3D {.mnt =3D mntget(exp->ex_path.mnt),
> 			    .dentry =3D dget(dentry)};
> +	unsigned int follow_flags =3D 0;
> 	int err =3D 0;
>=20
> -	err =3D follow_down(&path);
> +	if (exp->ex_flags & NFSEXP_CROSSMOUNT)
> +		follow_flags =3D LOOKUP_AUTOMOUNT;
> +
> +	err =3D follow_down(&path, follow_flags);
> 	if (err < 0)
> 		goto out;
> 	if (path.mnt =3D=3D exp->ex_path.mnt && path.dentry =3D=3D dentry &&
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 00fee52df842..6f96db73a70a 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -77,7 +77,7 @@ struct dentry *lookup_one_positive_unlocked(struct user=
_namespace *mnt_userns,
> 					    struct dentry *base, int len);
>=20
> extern int follow_down_one(struct path *);
> -extern int follow_down(struct path *);
> +extern int follow_down(struct path *, unsigned int flags);
> extern int follow_up(struct path *);
>=20
> extern struct dentry *lock_rename(struct dentry *, struct dentry *);
> --=20
> 2.26.2
>=20

I plan to take this through the nfsd tree, thus this one needs
an Ack from the VFS maintainer(s).


--
Chuck Lever



