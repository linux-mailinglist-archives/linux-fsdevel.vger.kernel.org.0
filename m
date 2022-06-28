Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5755F17B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiF1WgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiF1WgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:36:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396113A1B3;
        Tue, 28 Jun 2022 15:36:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SMXxI9010882;
        Tue, 28 Jun 2022 22:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fKRRoohzVnLLA2Qt6bYGg3TsXf0dche67MUjsTdqqtE=;
 b=dpodxTemPS6sCb1nARpC2lytR3uSlmxt+IxdT/i7TUAgpv9W/SKiTFIaLv6ABASLlp2u
 99WB34gqF8pfmQDWrndymAqeLOAUsfQITmkNjkzdutER1Sd7QgThhkUtY+eppZ42nc8s
 4Ta4rDjgp4qeEYJ7l9TIGof6dGo//kbRLszGb0ws7tJl/w8gW8o8K/KZHv9oeAHC6Vpo
 oBdujC1V4CLNKSyEdWZvCNSXIj8zBuEHB3OGsUb88YX/7sjpdQZeMO0F0qUIEgAsjCEW
 t2VY9fbnRunfbj9QLQRLzfd+H07m5UVFKp8Jhqg2lpbCuq/iSKJQN+3b97A6olM0c4B0 Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52fj15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 22:35:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SMZTs1013701;
        Tue, 28 Jun 2022 22:35:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt28dq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 22:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNjAnjhCKm/zp52E5Uhl3pzm+M1pxmKGrZdqtDBNRu5hlRgv6oc2DgeoHe2mV9GApZAnLuzryLVzZMwKxXoFt2hmeJKpIa17s2L79N5+Fb7usUY67AhmkhRIzmhSW5bqvmUTERqPzwPJnEJC8wIWpYk8jPX6w1MJQYIFqLBO+k8HBlNr7FAR5il18ZXIr6Mi6vCdpv1YFYNhmResZy6pKYZUp3sWcGa8EiLdDBHPHKR5RoTtz1bZKGcAn2Dm7btVGUFRoLmt6QJx/IfX6SCxxjHNBKn7htTASfoEWN7t8RK5w5zsAmSeb1KfmbPlkakClSQVkAT2HSpUe0c9lbZNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKRRoohzVnLLA2Qt6bYGg3TsXf0dche67MUjsTdqqtE=;
 b=EuwyM9u/iz+phF7TUNe7jB/hDp2/d9yJtpDun/0vdcNnkPN2NhCiKnwD+FIsaZ/C7q9+3lyAMT58N3z19xRV0TC4hzprL0rBukOZumS7atEHnzD9oexHaqYPRpYzFZ+Ubjln97KC+5C3N638bIln8LmMpkPnrv/mMNpr+xhhN4ij2Sa8AvBz8TjjoMKP3SruBwMrCB8mdiBdXoROJ50Kskk/STP+y9GFBTJBrfY5dV3RfRH3LWHlxcEzkGYGU7OsR2dQAUaUNg6vVUNdkamZmXpyQ8Qrh4Tn3aRTWHon1lmB1AN/RIp0AjQRZhcmqgbU5rP0NTVibD4wfypnhhxYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKRRoohzVnLLA2Qt6bYGg3TsXf0dche67MUjsTdqqtE=;
 b=cgtrIx3KMxV8LX5vaPMDTzFESHNF6pWf9CEk/wxm2a+daVj90WuVlNNrqMi+mqnxJ6lw8I4lRpB6VpzHX/+z/hUTn5UCKmt0EWpCSqR4Ch/LcMTkU8g+wae8wHpRLtIHJpDS+Hr/gkwi9p3qQNOIcM6JXmvu4rYkzTc8QVTpRI0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 22:35:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 22:35:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Topic: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Index: AQHYf3xEYb3JC5iP2UakViwbS7bjd61lf+CA
Date:   Tue, 28 Jun 2022 22:35:54 +0000
Message-ID: <CF45DA56-C7C7-434C-A985-A0FE08703F8D@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230200.21248.15108802355330895562.stgit@noble.brown>
In-Reply-To: <165516230200.21248.15108802355330895562.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c5040ad-dd48-4792-c989-08da59568ff9
x-ms-traffictypediagnostic: BYAPR10MB2456:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxbBTCYLEmy0RDZ5NI3e+wjvsaqzRaVG8WTPRzvWdYof6DM1q/L18FQrPRvuwwmN9OgStHCp+rG+/VbjZiF1x0CW+lVaMgZlUnvkRLR2RaKW2EuRNLykRm/RhaQ4VNJ9CU7KyJZ0bWQpFRRWpaQYzoVE42Fj+6Cq52Ijw3DxoLTnBrM1KdsgOjoTWYsB9Hczlm7t3gROADGXwN/t0MDzAVuEb4f4poLX6dVegxp/sbjffBQ3qgZdwoIrI2hMzomZclvzMNsDPVZEZ7mcIcG8ZlUag4zeeUgFvJJGhnSf46HzF7w+gmYF6kWUjI/6leU+zQ74Kr3wGQlYey9nGugnuF+0A/x2bf9fzOGV6tHyZAkiM32j4BAXKiWLgD/RF6jdRyll/oG7Y9m9pg/HRopCB5SkOCvOm1uOnxex72K56KW+WkbtZFsAQq6982PKW0PkeeAQE0gQNn9BlK+L2GxlmRxQ7vZIyftCal8Yrdgqki5nKfDiMbBwvg+1+Ex4uG+9wH1bGAakBnHWQPioh0PHxsAABMfrhZpkxuswuOg7qzavERy6s4pjwnz5+fVsE2zgliMRCp9sVb7hUM5T7PvnM/+4TBgmdfOGbjraaWSlVj/l5pF/MM6wsVU2rfo71dNOTa1nL/IdF1tS3beUddOOcQvaJAOhVzEyem+TNJGQrKnEzuN7EPHN174AKnsBeeM5XiVTkjaPihb2tPpRwmVPTGkvvsrnsxV2dZBpxr/u8Ou1715V73qnRGGr3n0+ClWFfwytG7V9MDsWAvfZvNvbjo59XqQK9T9cbtoCj3p8r83DExSbYZoR+6+uVVRGUet+ou0LfHPf5QlwGCvx0bi4fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39860400002)(376002)(366004)(478600001)(33656002)(316002)(54906003)(66476007)(38070700005)(36756003)(6486002)(2616005)(6916009)(5660300002)(2906002)(122000001)(30864003)(66556008)(86362001)(4326008)(6512007)(91956017)(26005)(8936002)(76116006)(6506007)(186003)(53546011)(8676002)(71200400001)(66946007)(38100700002)(66446008)(83380400001)(64756008)(41300700001)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aw/8I/GKVZeLh2zOvETD6KNUOGs/xhBcKV/PlniTLD5NnlfdS6ODCprNf9TN?=
 =?us-ascii?Q?mKfYtXiQ561+7+N6IJwtMTLABn3C97p7ihpe1ybHMqkuTa5hRcrKSRx5NJZJ?=
 =?us-ascii?Q?qyRP2eO7ZfEyd8XqBxaNldxQlNn+SANKJhKUG2ExC7SHKApAvmt1HNs8+0aF?=
 =?us-ascii?Q?gD5PHkJPv3Sm4iq9GjL0lmUjmFx/p3cyG9lMlbSfQE7oIa4JNjDvNTAOyhFz?=
 =?us-ascii?Q?h9KYQfqx7j+qszDDln4BFI9jRQDALtxcjZ7DVxliQY/5Pqb5ImfNGPv5tkDG?=
 =?us-ascii?Q?F9e/W+f32OBPB1e8mCM7YB4Y18BAAjggy2swrLOYNnAgEQynIgMtX9suWVFx?=
 =?us-ascii?Q?B1HHYV2Jw7vs2uuumOhFQA980XqbzndfBxrGYOJvob7sWbrZOBuf1yMyYDrM?=
 =?us-ascii?Q?BUSFXGPNTMwq42nUcHF4VsBshQgq1zCBIPR0ivtJcrY3S4oE7IhmmLvNK3pU?=
 =?us-ascii?Q?H+9ZJS7lhCx2U9hTGpZBu4kbLxYd6PYDVPDk2j2h8GYUwNISUde8yBM+g3cM?=
 =?us-ascii?Q?6WBvf2hr32Q+wL/+8tWwFvaj2pGi9iQmpj6KJ4GY49D2FYKhp6t7QS840Ct2?=
 =?us-ascii?Q?6xI3JEFhE8QOXO8ALzR6BjsdmeLMET+mYGvjOk1Qe+GU4B7MAW4rs8j4ZaLM?=
 =?us-ascii?Q?ignSiIQj82S8TNbaMFKimQb35Gebh8bBWwJbrTrLqhbtkbmFOrxNK3ZAUtK1?=
 =?us-ascii?Q?M5cgb8bpU+3cWTsyUr+y7RHTf+0wZmCXEJ27nhaRE8IsR9mmFckajUbneGQp?=
 =?us-ascii?Q?e3Xe7N4ognXmTfPYm7IVQ0LtwUVSp3qQgRN2ojBJEQSwav14F3JaUUpjVdeB?=
 =?us-ascii?Q?mLmMj6pXYoUzeJfAI5Yz0QxUBzVYRs/5sfrLpKmGSB1EYYTcO4MuixYD6wK1?=
 =?us-ascii?Q?5OzBfxYjQ6jCgZIC8pYN8hmRgc469U9hgz+mwjwwqA7ZlFICEY1XE/Ftp74H?=
 =?us-ascii?Q?FrRHdf2NEtfuppduSYVfwqJqgj1E7vAubtU1haotCY1GRDhkmhKjNinXebX0?=
 =?us-ascii?Q?ecActXrQ9CamSfZ4tpQCSuocByJXtSU+ZrOOBzebbRoTudI1kHiSmReA0o2e?=
 =?us-ascii?Q?i5fpD9p1yETzhQGO6W9gfaY3HjavuxkSSaUCuyBeI7P81fPmuLAe5+yzRcQV?=
 =?us-ascii?Q?hQ66SJFUItnK2oOfXS/G028sOlCJc+eu/rH7PMx7PCRdl32qMIzPBOGzMluj?=
 =?us-ascii?Q?Gvq7GHwx7+N2MpIJrA+bUUJ/gPSja8p51qu4ITceCSr0OTvESiOmEmKZ5S9X?=
 =?us-ascii?Q?fjaBXyKqEEAgMwAY6Yjv85Dja0dOY9PUGX/e8idIvXdryvyOtIr2wjkM6ky0?=
 =?us-ascii?Q?vuzwiHHCS/LZG2o0Pe0EEmPMOXtqdmvPXLF/Vs8Lopcu4mivgKA6qoymwCvx?=
 =?us-ascii?Q?9hlioQ+YyiLDEBYez0ftfjlik0GeXZDOscBeaMSHKWs6C3xLa/9JgsiyWZ9G?=
 =?us-ascii?Q?nQA2BDlt5nwIF6FCn/rqWzWv4sKgMQBW46bRJ7kQgr8+/CeM//BjE7FTMlQS?=
 =?us-ascii?Q?dNp5IwndJRf8dE63Pm577Yq2jiJxYVWKcGgNNX3GaCqKHe401hNm0uoslY2v?=
 =?us-ascii?Q?cL5oGLTNsTFJkWuR0f7YYko8+XXoQD/vliRHbBtc8uUPybVCnDZRjjE5J09M?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <136633CAD8BB644CB389D262DB6B7705@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5040ad-dd48-4792-c989-08da59568ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 22:35:54.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqQGHpZqyk/003qZsrwqe81+QPql1E9uLwEuaCL0BK7/fOlHm47Kl7LS6yGvy32afzHSHXsuVYhEBizUrlKBaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280089
X-Proofpoint-ORIG-GUID: E2blMiX9w6WCEeISV9cyNTA-0zDmxzxR
X-Proofpoint-GUID: E2blMiX9w6WCEeISV9cyNTA-0zDmxzxR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 13, 2022, at 7:18 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> Rather than getting write access, locking the directory, and performing
> a lookup, use
>  filename_create_one_len() for create, or
>  lookup_hash_update_len() for delete
> which combines all these steps and handles shared locking for concurrent
> updates where appropriate.
>=20
> As we don't use fh_lock() we need to call fh_fill_pre_attrs()
> explicitly.  However if we only get a shared lock, then the pre/post
> attributes won't be atomic, so we need to ensure that fh know that,
> and doesn't try to encode wcc attrs either.
>=20
> Note that there is only one filesystem that allows shared locks for
> create/unlink and that is NFS (for re-export).  NFS does support atomic
> pre/post attributes, so there is no loss in not providing them.
>=20
> When some other filesystem supports concurrent updates, we might need to
> consider if the pre/post attributes are more important than the
> parallelism.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |   31 +++++-------
> fs/nfsd/nfs4proc.c |   32 +++++-------
> fs/nfsd/nfsfh.c    |    7 ++-
> fs/nfsd/nfsfh.h    |    4 +-
> fs/nfsd/nfsproc.c  |   29 +++++------
> fs/nfsd/vfs.c      |  134 +++++++++++++++++++++++------------------------=
-----
> 6 files changed, 105 insertions(+), 132 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 981a3a7a6e16..0fdbb9504a87 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -231,12 +231,14 @@ static __be32
> nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  struct svc_fh *resfhp, struct nfsd3_createargs *argp)
> {
> +	struct path path;
> 	struct iattr *iap =3D &argp->attrs;
> -	struct dentry *parent, *child;
> +	struct dentry *child;
> 	__u32 v_mtime, v_atime;
> 	struct inode *inode;
> 	__be32 status;
> 	int host_err;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	if (isdotent(argp->name, argp->len))
> 		return nfserr_exist;
> @@ -247,20 +249,15 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	if (status !=3D nfs_ok)
> 		return status;
>=20
> -	parent =3D fhp->fh_dentry;
> -	inode =3D d_inode(parent);
> +	path.dentry =3D fhp->fh_dentry;
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
> +	inode =3D d_inode(path.dentry);
>=20
> -	host_err =3D fh_want_write(fhp);
> -	if (host_err)
> -		return nfserrno(host_err);
> +	child =3D filename_create_one_len(argp->name, argp->len,
> +					&path, 0, &wq);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> -
> -	child =3D lookup_one_len(argp->name, parent, argp->len);
> -	if (IS_ERR(child)) {
> -		status =3D nfserrno(PTR_ERR(child));
> -		goto out;
> -	}
> +	if (IS_ERR(child))
> +		return nfserrno(PTR_ERR(child));
>=20
> 	if (d_really_is_negative(child)) {
> 		status =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
> @@ -311,6 +308,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>=20
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
> +	fh_fill_pre_attrs(fhp, (child->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0);
>=20
> 	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true)=
;
> 	if (host_err < 0) {
> @@ -332,12 +330,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>=20
> set_attr:
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> -
> +	fh_fill_post_attrs(fhp);
> out:
> -	fh_unlock(fhp);
> -	if (child && !IS_ERR(child))
> -		dput(child);
> -	fh_drop_write(fhp);
> +	done_path_update(&path, child, &wq);
> 	return status;
> }
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3895eb52d2b1..71a4b8ef77f0 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -285,12 +285,13 @@ static __be32
> nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  struct svc_fh *resfhp, struct nfsd4_open *open)
> {
> +	struct path path;
> 	struct iattr *iap =3D &open->op_iattr;
> -	struct dentry *parent, *child;
> +	struct dentry *child;
> 	__u32 v_mtime, v_atime;
> 	struct inode *inode;
> 	__be32 status;
> -	int host_err;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	if (isdotent(open->op_fname, open->op_fnamelen))
> 		return nfserr_exist;
> @@ -300,20 +301,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	status =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
> 	if (status !=3D nfs_ok)
> 		return status;
> -	parent =3D fhp->fh_dentry;
> -	inode =3D d_inode(parent);
>=20
> -	host_err =3D fh_want_write(fhp);
> -	if (host_err)
> -		return nfserrno(host_err);
> +	path.dentry =3D fhp->fh_dentry;
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
> +	inode =3D d_inode(path.dentry);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	child =3D filename_create_one_len(open->op_fname,
> +					open->op_fnamelen,
> +					&path, 0, &wq);
>=20
> -	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> -	if (IS_ERR(child)) {
> -		status =3D nfserrno(PTR_ERR(child));
> -		goto out;
> -	}
> +	if (IS_ERR(child))
> +		return nfserrno(PTR_ERR(child));
>=20
> 	if (d_really_is_negative(child)) {
> 		status =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
> @@ -386,6 +384,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> +	fh_fill_pre_attrs(fhp, (child->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0);
> 	status =3D nfsd4_vfs_create(fhp, child, open);
> 	if (status !=3D nfs_ok)
> 		goto out;
> @@ -405,12 +404,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>=20
> set_attr:
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> -
> +	fh_fill_post_attrs(fhp);
> out:
> -	fh_unlock(fhp);
> -	if (child && !IS_ERR(child))
> -		dput(child);
> -	fh_drop_write(fhp);
> +	done_path_update(&path, child, &wq);
> 	return status;
> }
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c29baa03dfaf..a50db688c60d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -616,7 +616,7 @@ fh_update(struct svc_fh *fhp)
>  * @fhp: file handle to be updated
>  *
>  */
> -void fh_fill_pre_attrs(struct svc_fh *fhp)
> +void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic)

Hi Neil, just noticed this:

  CC [M]  fs/nfsd/nfsfh.o
  CHECK   /home/cel/src/linux/linux/fs/nfsd/nfsfh.c
/home/cel/src/linux/linux/fs/nfsd/nfsfh.c:621: warning: Function parameter =
or member 'atomic' not described in 'fh_fill_pre_attrs'

And... do you intend to repost this series with the supplemental
fixes applied?

Should we come up with a plan to merge these during the next
window, or do you feel more work is needed?


> {
> 	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
> 	struct inode *inode;
> @@ -626,6 +626,11 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> 		return;
>=20
> +	if (!atomic) {
> +		fhp->fh_no_atomic_attr =3D true;
> +		fhp->fh_no_wcc =3D true;
> +	}
> +
> 	inode =3D d_inode(fhp->fh_dentry);
> 	err =3D fh_getattr(fhp, &stat);
> 	if (err) {
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index fb9d358a267e..ecc57fd3fd67 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -320,7 +320,7 @@ static inline u64 nfsd4_change_attribute(struct kstat=
 *stat,
> 		return time_to_chattr(&stat->ctime);
> }
>=20
> -extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> +extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
> extern void fh_fill_post_attrs(struct svc_fh *fhp);
>=20
>=20
> @@ -347,7 +347,7 @@ fh_lock_nested(struct svc_fh *fhp, unsigned int subcl=
ass)
>=20
> 	inode =3D d_inode(dentry);
> 	inode_lock_nested(inode, subclass);
> -	fh_fill_pre_attrs(fhp);
> +	fh_fill_pre_attrs(fhp, true);
> 	fhp->fh_locked =3D true;
> }
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index fcdab8a8a41f..2dccf77634e8 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -255,6 +255,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> static __be32
> nfsd_proc_create(struct svc_rqst *rqstp)
> {
> +	struct path path;
> 	struct nfsd_createargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
> 	svc_fh		*dirfhp =3D &argp->fh;
> @@ -263,8 +264,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	struct inode	*inode;
> 	struct dentry	*dchild;
> 	int		type, mode;
> -	int		hosterr;
> 	dev_t		rdev =3D 0, wanted =3D new_decode_dev(attr->ia_size);
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	dprintk("nfsd: CREATE   %s %.*s\n",
> 		SVCFH_fmt(dirfhp), argp->len, argp->name);
> @@ -279,17 +280,13 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	resp->status =3D nfserr_exist;
> 	if (isdotent(argp->name, argp->len))
> 		goto done;
> -	hosterr =3D fh_want_write(dirfhp);
> -	if (hosterr) {
> -		resp->status =3D nfserrno(hosterr);
> -		goto done;
> -	}
>=20
> -	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> -	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> +	path.dentry =3D dirfhp->fh_dentry;
> +	path.mnt =3D dirfhp->fh_export->ex_path.mnt;
> +	dchild =3D filename_create_one_len(argp->name, argp->len, &path, 0, &wq=
);
> 	if (IS_ERR(dchild)) {
> 		resp->status =3D nfserrno(PTR_ERR(dchild));
> -		goto out_unlock;
> +		goto out_done;
> 	}
> 	fh_init(newfhp, NFS_FHSIZE);
> 	resp->status =3D fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
> @@ -298,7 +295,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	dput(dchild);
> 	if (resp->status) {
> 		if (resp->status !=3D nfserr_noent)
> -			goto out_unlock;
> +			goto out_done;
> 		/*
> 		 * If the new file handle wasn't verified, we can't tell
> 		 * whether the file exists or not. Time to bail ...
> @@ -307,7 +304,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		if (!newfhp->fh_dentry) {
> 			printk(KERN_WARNING=20
> 				"nfsd_proc_create: file handle not verified\n");
> -			goto out_unlock;
> +			goto out_done;
> 		}
> 	}
>=20
> @@ -341,7 +338,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 								 newfhp->fh_dentry,
> 								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
> 					if (resp->status && resp->status !=3D nfserr_rofs)
> -						goto out_unlock;
> +						goto out_done;
> 				}
> 			} else
> 				type =3D S_IFREG;
> @@ -378,7 +375,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		/* Make sure the type and device matches */
> 		resp->status =3D nfserr_exist;
> 		if (inode && inode_wrong_type(inode, type))
> -			goto out_unlock;
> +			goto out_done;
> 	}
>=20
> 	resp->status =3D nfs_ok;
> @@ -400,10 +397,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 						    (time64_t)0);
> 	}
>=20
> -out_unlock:
> -	/* We don't really need to unlock, as fh_put does it. */
> -	fh_unlock(dirfhp);
> -	fh_drop_write(dirfhp);
> +out_done:
> +	done_path_update(&path, dchild, &wq);
> done:
> 	fh_put(dirfhp);
> 	if (resp->status !=3D nfs_ok)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 840e3af63a6f..6cdd5e407600 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1274,12 +1274,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> 	dirp =3D d_inode(dentry);
>=20
> 	dchild =3D dget(resfhp->fh_dentry);
> -	if (!fhp->fh_locked) {
> -		WARN_ONCE(1, "nfsd_create: parent %pd2 not locked!\n",
> -				dentry);
> -		err =3D nfserr_io;
> -		goto out;
> -	}
>=20
> 	err =3D nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
> 	if (err)
> @@ -1362,9 +1356,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 		char *fname, int flen, struct iattr *iap,
> 		int type, dev_t rdev, struct svc_fh *resfhp)
> {
> -	struct dentry	*dentry, *dchild =3D NULL;
> +	struct path	path;
> +	struct dentry	*dchild =3D NULL;
> 	__be32		err;
> 	int		host_err;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	if (isdotent(fname, flen))
> 		return nfserr_exist;
> @@ -1373,27 +1369,22 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> 	if (err)
> 		return err;
>=20
> -	dentry =3D fhp->fh_dentry;
> -
> -	host_err =3D fh_want_write(fhp);
> -	if (host_err)
> -		return nfserrno(host_err);
> +	path.dentry =3D fhp->fh_dentry;
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> -	dchild =3D lookup_one_len(fname, dentry, flen);
> +	dchild =3D filename_create_one_len(fname, flen, &path, 0, &wq);
> 	host_err =3D PTR_ERR(dchild);
> 	if (IS_ERR(dchild))
> 		return nfserrno(host_err);
> 	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> -	/*
> -	 * We unconditionally drop our ref to dchild as fh_compose will have
> -	 * already grabbed its own ref for it.
> -	 */
> -	dput(dchild);
> -	if (err)
> -		return err;
> -	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> -					rdev, resfhp);
> +	if (!err) {
> +		fh_fill_pre_attrs(fhp, (dchild->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0)=
;
> +		err =3D nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> +					 rdev, resfhp);
> +		fh_fill_post_attrs(fhp);
> +	}
> +	done_path_update(&path, dchild, &wq);
> +	return err;
> }
>=20
> /*
> @@ -1441,15 +1432,17 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *buf, int *lenp)
> __be32
> nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 				char *fname, int flen,
> -				char *path,
> +				char *lpath,
> 				struct svc_fh *resfhp)
> {
> -	struct dentry	*dentry, *dnew;
> +	struct path	path;
> +	struct dentry	*dnew;
> 	__be32		err, cerr;
> 	int		host_err;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	err =3D nfserr_noent;
> -	if (!flen || path[0] =3D=3D '\0')
> +	if (!flen || lpath[0] =3D=3D '\0')
> 		goto out;
> 	err =3D nfserr_exist;
> 	if (isdotent(fname, flen))
> @@ -1459,28 +1452,28 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> 	if (err)
> 		goto out;
>=20
> -	host_err =3D fh_want_write(fhp);
> -	if (host_err)
> -		goto out_nfserr;
> +	path.dentry =3D fhp->fh_dentry;
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
>=20
> -	fh_lock(fhp);
> -	dentry =3D fhp->fh_dentry;
> -	dnew =3D lookup_one_len(fname, dentry, flen);
> +	dnew =3D filename_create_one_len(fname, flen, &path, 0, &wq);
> 	host_err =3D PTR_ERR(dnew);
> 	if (IS_ERR(dnew))
> 		goto out_nfserr;
>=20
> -	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> +	fh_fill_pre_attrs(fhp, (dnew->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0);
> +	host_err =3D vfs_symlink(mnt_user_ns(path.mnt), d_inode(path.dentry),
> +			       dnew, lpath);
> 	err =3D nfserrno(host_err);
> -	fh_unlock(fhp);
> 	if (!err)
> 		err =3D nfserrno(commit_metadata(fhp));
>=20
> -	fh_drop_write(fhp);
> +	fh_fill_post_attrs(fhp);
>=20
> 	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> -	dput(dnew);
> -	if (err=3D=3D0) err =3D cerr;
> +	if (err=3D=3D0)
> +		err =3D cerr;
> +
> +	done_path_update(&path, dnew, &wq);
> out:
> 	return err;
>=20
> @@ -1497,10 +1490,12 @@ __be32
> nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
> 				char *name, int len, struct svc_fh *tfhp)
> {
> -	struct dentry	*ddir, *dnew, *dold;
> +	struct path	path;
> +	struct dentry	*dold, *dnew;
> 	struct inode	*dirp;
> 	__be32		err;
> 	int		host_err;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
> 	if (err)
> @@ -1518,17 +1513,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> 	if (isdotent(name, len))
> 		goto out;
>=20
> -	host_err =3D fh_want_write(tfhp);
> -	if (host_err) {
> -		err =3D nfserrno(host_err);
> -		goto out;
> -	}
> -
> -	fh_lock_nested(ffhp, I_MUTEX_PARENT);
> -	ddir =3D ffhp->fh_dentry;
> -	dirp =3D d_inode(ddir);
> +	path.dentry =3D ffhp->fh_dentry;
> +	path.mnt =3D ffhp->fh_export->ex_path.mnt;
> +	dirp =3D d_inode(path.dentry);
>=20
> -	dnew =3D lookup_one_len(name, ddir, len);
> +	dnew =3D filename_create_one_len(name, len, &path, 0, &wq);
> 	host_err =3D PTR_ERR(dnew);
> 	if (IS_ERR(dnew))
> 		goto out_nfserr;
> @@ -1537,9 +1526,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
>=20
> 	err =3D nfserr_noent;
> 	if (d_really_is_negative(dold))
> -		goto out_dput;
> +		goto out_done;
> +	fh_fill_pre_attrs(ffhp, (dnew->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0);
> 	host_err =3D vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
> -	fh_unlock(ffhp);
> +
> 	if (!host_err) {
> 		err =3D nfserrno(commit_metadata(ffhp));
> 		if (!err)
> @@ -1550,17 +1540,15 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> 		else
> 			err =3D nfserrno(host_err);
> 	}
> -out_dput:
> -	dput(dnew);
> -out_unlock:
> -	fh_unlock(ffhp);
> -	fh_drop_write(tfhp);
> +out_done:
> +	fh_fill_post_attrs(ffhp);
> +	done_path_update(&path, dnew, &wq);
> out:
> 	return err;
>=20
> out_nfserr:
> 	err =3D nfserrno(host_err);
> -	goto out_unlock;
> +	goto out;
> }
>=20
> static void
> @@ -1625,8 +1613,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
> 	 * so do it by hand */
> 	trap =3D lock_rename(tdentry, fdentry);
> 	ffhp->fh_locked =3D tfhp->fh_locked =3D true;
> -	fh_fill_pre_attrs(ffhp);
> -	fh_fill_pre_attrs(tfhp);
> +	fh_fill_pre_attrs(ffhp, true);
> +	fh_fill_pre_attrs(tfhp, true);
>=20
> 	odentry =3D lookup_one_len(fname, fdentry, flen);
> 	host_err =3D PTR_ERR(odentry);
> @@ -1717,11 +1705,13 @@ __be32
> nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
> 				char *fname, int flen)
> {
> -	struct dentry	*dentry, *rdentry;
> +	struct dentry	*rdentry;
> 	struct inode	*dirp;
> 	struct inode	*rinode;
> 	__be32		err;
> 	int		host_err;
> +	struct path	path;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>=20
> 	err =3D nfserr_acces;
> 	if (!flen || isdotent(fname, flen))
> @@ -1730,24 +1720,18 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> 	if (err)
> 		goto out;
>=20
> -	host_err =3D fh_want_write(fhp);
> -	if (host_err)
> -		goto out_nfserr;
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
> +	path.dentry =3D fhp->fh_dentry;
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> -	dentry =3D fhp->fh_dentry;
> -	dirp =3D d_inode(dentry);
> +	rdentry =3D lookup_hash_update_len(fname, flen, &path, 0, &wq);
> +	dirp =3D d_inode(path.dentry);
>=20
> -	rdentry =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(rdentry);
> 	if (IS_ERR(rdentry))
> -		goto out_drop_write;
> +		goto out_nfserr;
> +
> +	fh_fill_pre_attrs(fhp, (rdentry->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0)=
;
>=20
> -	if (d_really_is_negative(rdentry)) {
> -		dput(rdentry);
> -		host_err =3D -ENOENT;
> -		goto out_drop_write;
> -	}
> 	rinode =3D d_inode(rdentry);
> 	ihold(rinode);
>=20
> @@ -1761,15 +1745,13 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> 	} else {
> 		host_err =3D vfs_rmdir(&init_user_ns, dirp, rdentry);
> 	}
> +	fh_fill_post_attrs(fhp);
>=20
> -	fh_unlock(fhp);
> +	done_path_update(&path, rdentry, &wq);
> 	if (!host_err)
> 		host_err =3D commit_metadata(fhp);
> -	dput(rdentry);
> 	iput(rinode);    /* truncate the inode here */
>=20
> -out_drop_write:
> -	fh_drop_write(fhp);
> out_nfserr:
> 	if (host_err =3D=3D -EBUSY) {
> 		/* name is mounted-on. There is no perfect
>=20
>=20

--
Chuck Lever



