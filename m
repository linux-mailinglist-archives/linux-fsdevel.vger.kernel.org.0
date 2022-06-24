Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE45559C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiFXOpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiFXOoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:44:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525467E62;
        Fri, 24 Jun 2022 07:43:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODhuTV018555;
        Fri, 24 Jun 2022 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0dNvnSL//YF/NCZSouwqAVISxUgfeMvQxFnHW/743g0=;
 b=V9848RhYffsuoh0nkswss5EfmCqk++Os+D/rCPtdqigyTqCEFbZZCZKA1dJklRjhQ1CV
 3ahCA7WA2ldK54MJxbh5KuWowkBLOlSh+O8+KSIwHhWPL4dPh54yLjTsaaWxPRhfPIqK
 w0DRLni7VZ58UldKHj/adbaNRwVYUud1KDLbFZpxvndKa/lzFJvPgTxh06tZL+twTE+r
 VWPCvS2SHXyKMJ6+pRZxlOZ11EqTWQSJgbQrtRLXV9CiyhX3+7uoK5sZb762sqGDJoab
 dsN130LJDOoD6zu1qvkYLn1O4x2PUIALfGoTjVBp/x8ckRTC1dxoVUp7qfxk00IJ9OfM 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g264tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEf69m008077;
        Fri, 24 Jun 2022 14:43:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5fnta3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLbj5jqjcoDu1B0qkggrJ7xUvh/k28jjoE3I+0ph1MAFEULxqkvv/UoQwD60pWLfwo2KXb6GKME8LWML6dikFhkul01MkH9FaTwVYKykIwX9bf4JuCTUGV5JKd+YBQ88QudaVd+O3B15vAhtxgSixLio3opK6y2NggMjdQz46lWp4pm0mTteeCuYy2+lkYawQ8+rZeuAMGW6I46lqt7dIuSUMFe6libC0ri/STIdmV0uYaQpflrwT5N5CXP9RExg2rL6QGfMgrfuBy1bWRUTmSRKDzTGhYLtIuq1TXUIIwzPi4GK5DKx03EgDb/pAvj40vgJU+4NoM/DlSCWGZp1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dNvnSL//YF/NCZSouwqAVISxUgfeMvQxFnHW/743g0=;
 b=GvIfP12smiILNhh7mLrygLzfkJ9QMmapHjjCQ7PVY29ej+Z0O8iKKKbS9jMowmjHQiEVZQa4alAG2eeLZKO6Y9lemVncuHfxTi6/Zgx99kH2G4Q/2OzFXAojH3FO17hNRT2yZCUurUgUPzO9ulF8zNKfgDBgT7tuni3UIc32M7oQdKI3/M9QGsu4rQJLbVBbdCLrQ5oWS9UhJmrmam83cKi9ihZorgftoZav6HPgKtdP7y3rRgWE7ychWEeh5TedSLaRUosYCjZ8+jKI03xxK4jL26ofSgkAuAPuc9xTjilidbwsDl+rlFDHClnFUG/7Dc7vMb1WyQQp5nmYgpJmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dNvnSL//YF/NCZSouwqAVISxUgfeMvQxFnHW/743g0=;
 b=dHHtuB3VCcmnjcLt6fNfzjuu3RDyh9sp2x0cmB9OumTTohk+P2V353p2G3+WLvjestExKJJMxZdnvLEmRoKL11QRoJmRN7/pDHZwqe+SPyDQZ51KVPBNhqndfK2lKmtQQoLF+NmcHbN7TtoNHtGrJhLiEX/pGFPSKysvrg1ZyQw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:43:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:43:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Topic: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Index: AQHYf3xEYb3JC5iP2UakViwbS7bjd61esoSA
Date:   Fri, 24 Jun 2022 14:43:20 +0000
Message-ID: <8F16D957-F43A-4E5B-AA28-AAFCF43222E2@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230200.21248.15108802355330895562.stgit@noble.brown>
In-Reply-To: <165516230200.21248.15108802355330895562.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0997ef48-a8af-4587-4eb9-08da55efe1dd
x-ms-traffictypediagnostic: DM6PR10MB4236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNA0XVZNG60hmK2Lu8+8QalYq73sqyrLgoHqCsofwJwX5SvIwozn9HaVOjJ0TdDtxCZ15n57prS3SvrHtImfTDiIuAm5Hdt/3EF57LX3fS2DpX6IKRJ8yUnhzJY7OgRx2Anel177hkUYlKM7qo6G0SIu0V9NHo1mIz5X1yX9RiWPxAuBo4qNenTqbqgMB/iHE9CmYo/gaL/7sIm3TmySDUqYjDgbyh+aQDnSpNxlB5KjRHPugjYMbmQrBHJu4uetKmss1IQuon9sBwXzRtjy8rpbtiTXqi3bCxftJraXFXKpniR2JEB/8UGfNcsXfEcsl+S2h9x4d1wiN63+qZc4nf1xaVEp6yBlP8/EIU+aBCueojlCzhlL5DmIyWu7jYXtGlR/wYSpSLnwpXKhsorNxOIk/ujCK90D8IslRoJJEgkmfBXpNa2NMr6mYOHKJoDTyKg1u2InWFJ85secZXm1M172/5a6hRNWPKjzGjCLYrb4igaO2LyIPJ45jEjcFbZGwLmzHvKVMZeLKMimR3ne1YRwcPr6hC6GRKBmNqojCSxOG64JGQAfMWot9yNIuJxetMTJqgQgCcDWox+s4WFKcmZgh0KfmVrbDrD6feGivOJLzMFRQ8IcQvc62bxVzrfobTaKtQc1F01C2l/tfAmA6CouRQA/GX0UvXILuVp/K3CiLBSmApbTDV05PbkJUJHQYABk3DjFPGGq+ChNYNwHW2LnrrOtw5lV720nUwRdoV1ql1cSvWl7UMgq0j65XrNABIzAsLarOkYzL5bzMv8KY0RrCoquQ1U0Fb8m9k5/HsdjaLblWHKnVN3aIJBCAwB/EHA7xMy/6NIZeqQ1k3aQFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(6506007)(6486002)(38070700005)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(33656002)(8936002)(41300700001)(30864003)(2906002)(36756003)(91956017)(6916009)(76116006)(5660300002)(4326008)(66946007)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(186003)(86362001)(6512007)(38100700002)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vrKHfTlYjGg7szIA/ynmJhkuHjLsmGpZnPeT+U7+6yJ6b3CWoZt+iYcMyXQY?=
 =?us-ascii?Q?8Sy5OeL8QqsEXVYA8lQVWhHloSJbjgPE7bfgI7sZZXRLBXg1TV4OffxKeYtr?=
 =?us-ascii?Q?AE9Sib0EXiAH8nSdubCZT5seM0gqO1pJYhb49vTsAjvWJlcARbrvFZKvJ89n?=
 =?us-ascii?Q?h8bh5LfVCDRPggOmuu94tIdsBn+o5lX0ouhVjDeZawiO70rHsXyaGwMKPwnx?=
 =?us-ascii?Q?CsA7fDr8tez3V4DrcA7m/vEa1MW/AtBqJtv0bPLvkVThPNlVs/NDJfZXcofn?=
 =?us-ascii?Q?Xto/cGNRsnAoxEFqS9GhaY41ZrDcuZ4DPp9oaSW7YLze5uXQ+gCf6aqAxMiO?=
 =?us-ascii?Q?dw5QwTwemFcdOCqJYaU39cJe62v8kPnb3Fkp7uors1BTQqgxLHFr6uXwBths?=
 =?us-ascii?Q?LeLykMEoVxGCkhUdAwSDmAOiaYRHnuXZkr0U5sJ9uNgtuyCYXCVqMbj3oglh?=
 =?us-ascii?Q?uhPHPER64l6dPBqj1GVMNKHK0FxYXBnghLmhGYDq6mCSx1/2SSzs5Fhc8BI0?=
 =?us-ascii?Q?dpeQEvG0AOPmGYaOni76A0EbEW1ir/A1+xuTE7wNcgMQa18G6lROnDakrkVL?=
 =?us-ascii?Q?GPdsTPLA6z5K4jpO2yXmKhM4SXGS+92VbLeYztVMLxshFURtecHPOqoq2Nim?=
 =?us-ascii?Q?Pz8f3h+NoXLXQnwXVWQWgcgaPNCgA5b2kondi9e2Epw720jn7Tt2h8s8+FsF?=
 =?us-ascii?Q?RLL3iEnn9b60ZLL1Bi8HV/0CFtNcg22eyKF0GjCNmYqfEucQ6Dipg7iQ9+DA?=
 =?us-ascii?Q?2UAHMDVsP8nbGSVIBDVoeiDWw/sWE0B1y0nxoAs6SZBjiBdSiDdsoQn54b7y?=
 =?us-ascii?Q?ASObFPxesZdLpZk9mjpJnrI50F8FXKX3QBUI67eLGdbjqZRHijWPjYP79MEC?=
 =?us-ascii?Q?DEmCtayGDx5GTb9nkTJbXyK7CuPIGlqnkOe9xJ6mFUzXNwuVyQSssdlBDd/G?=
 =?us-ascii?Q?G0wA+iXH+n3K/YP6OKO4FA9v1LGXzR1Acty3s4npWs0mQgxujQ/vZP0n/BTe?=
 =?us-ascii?Q?sAXR6AgY8l+Dn2magqXGJuh1g9dn7/w8sZF3bHOdxLoo1bx9bgQ2Wd24FsHL?=
 =?us-ascii?Q?fasF1Vwv97O7MAA+3Bc81a9lHQB12QT5zRprWi9IGPx8AfWlQxGGRA9/ghhS?=
 =?us-ascii?Q?ewaavut7a0RMoatEJU1SebsMw9RtB0ilZhUreOV+aikCI4mCvw809yt14kCu?=
 =?us-ascii?Q?EF9LWwthImVe11c0klVeSkzG5KU2eHEE/RwUWKuoXxUNIaerLzSYjI9CkJze?=
 =?us-ascii?Q?pVda6PxPt9KgAkpDc64+5W/Q3cGT0Z3xB8jUNy4RPXYnQQrRvJNR3WBwEm68?=
 =?us-ascii?Q?vhiXDvbCaKl0QCKwoR6GD2ziMADqb4gV3brFsBfIoytXQwHD3Y94EX06RvWI?=
 =?us-ascii?Q?ToiS4jR78Io0zqAsEo8/qlIkI9FHPAdwwK36ka7kiX7OHVRycpyOm1DwFZxc?=
 =?us-ascii?Q?x1GXJYBqOkgD+02xMJfpdmP8/JnmRrjbQJ7auS8kaOfLDyb5LkJoMdkwCG46?=
 =?us-ascii?Q?e3tdgvq2x+Uav87jlWMRnz80kzbIoGErFlLBYHM1/z+0LnriCekldRHWah5P?=
 =?us-ascii?Q?EBFSIZnOPzzX+Nq6IQEMhMrY/uF2+CUwNOd2OcQHJkiIF1aLyUKSzIZBR7Xq?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C3CE784915F5846B0B6FF3CC4F58937@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997ef48-a8af-4587-4eb9-08da55efe1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:43:20.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3emAJekJ9hilwnC1GG6tvj08Rdwy/efL9AdKWeddf+SjBIGRiAcySZZXtiFWqRJ0aqG9Oh1XcPmjvCAFZX7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240057
X-Proofpoint-GUID: uooqAnChH2R5DNildEmQHK31XcNHK_gL
X-Proofpoint-ORIG-GUID: uooqAnChH2R5DNildEmQHK31XcNHK_gL
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

Should this be "NFS does /not/ support atomic pre/post ..." ?


> When some other filesystem supports concurrent updates, we might need to
> consider if the pre/post attributes are more important than the
> parallelism.

My impression is that pre/post attributes in NFSv3 have not
turned out to be as useful as their inventors predicted.

I think this is mostly a "switch to the new API" patch, so

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


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

Nit: I'd prefer sticking with the reverse christmas tree
style for variable declarations. Same in other patches
that touch NFSD.


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

Ditto.


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

Ditto.


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

Ditto.


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

Ditto.


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

Ditto.


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



