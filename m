Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF37559CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiFXOrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiFXOpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:45:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAA77FE5;
        Fri, 24 Jun 2022 07:43:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODhuTa018555;
        Fri, 24 Jun 2022 14:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1EaZ3SzXz+9Ry39nA53D4VKpSw6mb8TeVzJh2ql4uWI=;
 b=MqadSBcsRzGNSNLbKzkAUdrhDJkpxggcN4uNtU0nSyEqLeyfy+y5aSxqOgG/LbrbL9ip
 JH4FnXzW4IehQLAqtjwI7vQE1UPMdAd9z73mMzx2sYgNrKCwsJimigBKYcUebI+IJJEU
 EKTkLUL17w3irhThQ1ef7jFLQ+b8MM8+WwMw3ep53sc+wPjV7SjlP2PgiEXQQZuE4C9+
 DfrdorSJPcjF43PZ3JLBGp6L0LNoPPtezZHy0zbRvAa0AwHU9AOe3KtQFLDEnM3j04km
 6X86KFY4BgV/9+BjpKK9hEjBfRC91DkrXR5Ugihr2cRBZIARWGkaCdKIMx13wnxYtms7 Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g264tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEf5TS008040;
        Fri, 24 Jun 2022 14:43:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5fntek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeQyBs+dVXljYuilP4t4Cgaksd7/ByQKFiNpbwDGKGShIijeOTqHfR9UcztVu2pMI7uGP067k8wLvTC9dGiiJsIeqPXZOUymTCzFvsvaYKqkXdCLeqHSN649kBwC0zXAsIWQLbNKPBlrGP39g/H1seuOJxNnwPyEnXEwarBaq8WNDxvTlEFDFCyP0XeY/PtqxAW6LIgLS3P5sSlex3qHpp5XGIlMOpRVCiAAE7hy4zebDsJBbNXWOF699dSpDy0IRAk8YtBrq0aRbRYC1ToryKnzHylW2G38GhpnUXTNvcT+zaTUKvLUC8FGM+k0F62+7nL8H7FRq3AgNAYpPmQLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EaZ3SzXz+9Ry39nA53D4VKpSw6mb8TeVzJh2ql4uWI=;
 b=ILH3YH5kxBq4Fgv1SdtmM32nGrJUNvIMq2Hu7iacpGM020pKoOIbTQIl2QPeanPYWy+BLj+eFs8GoNHgNI929/WfqAaIe29TdTT3FgYCKwhmmoPXzQe6Qdiq+ySd1+8lpBRdQ5I8QTLTseUwlzAu4YitFc8gBwnV3KGnfZL1QBjS7MnK0f9KbfVADV+e8Eo1GU4NzWny3imDawVpgtX2W6q5WR77jbFUFkBfBJT6hIxOhB/vUgADzlfZN55B3ITRQJceveBEYjxaV4wE5BIAznPoW/IpsQcEsvEkGWWQcrdWKpiXcnSuoRJ/ehoWMWo/vFeBsPdFgxpCJhHC4RP5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EaZ3SzXz+9Ry39nA53D4VKpSw6mb8TeVzJh2ql4uWI=;
 b=ElxjCDopoZiYLDOGRwRIJ81HdOIw+OREG/aPzDTUOeBW/RWML7ao6j5mrhNURrzJ3t/VcD2qjxDQDoUYf+Pjc82Jg0zskvD/vNPdWrVgM3CxYjvWPhFOrSVNWaV/vYBUIiyEqc2Ay/CmWjdgIukIov0Pvu71HYbE41cKjzTndxY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:43:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:43:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] nfsd: use (un)lock_inode instead of fh_(un)lock
Thread-Topic: [PATCH 11/12] nfsd: use (un)lock_inode instead of fh_(un)lock
Thread-Index: AQHYf3xf15U4Wz2DJE6TlDfjf90TK61espYA
Date:   Fri, 24 Jun 2022 14:43:34 +0000
Message-ID: <A212C730-34BE-4B00-818C-0C01FDF86E1E@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230203.21248.2885738961424931868.stgit@noble.brown>
In-Reply-To: <165516230203.21248.2885738961424931868.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fae662d4-4292-415d-cf5d-08da55efea69
x-ms-traffictypediagnostic: DM6PR10MB4236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wli5CQMWOXTS8os4rRf0ByJq83UXJHAU7GNv7AUUzorG4/YRJItIwwKcdtY0hkkJhQA85bPyXgSXBAbk1plxyqZYyIEkOJ4C6tdYQcb4qJjqaSDKXcmoGnXyPIcdUskPj0DwN1zQ/A/npFA5hWxcjAUH7DUkAUIa6tyyyXhDgcGvX1But214Mpja/zXN7IvLYCshP7+8iDAA00qB4QUiQHo99kbjj2QsMOakZ2jWZFjUZF7HyjkiO61L2MEu9DIdb/XLnhp+P+Bgk33WcP0hN8KMqWeW28hHZds/LHzZGIlbWi+8yvhpJuN54Noatb2+9MbbRO8cj82sVMIfu4xtr6jk8zDaJ7UadojthH4G54JV3ubp2XoBPGtGAk+df5OOHHnxbjKsY5KAidi9yj/kAYdCaZMKkOlJps32SFkOfmJhemKCK74jOCc3ii4yqBEh1aNVMoELJ8W04qrkGuau9M19YMIioVF1vGZeGkSID3zUGTGVmP1vs0L5XXhwAaS2jjPOEzVHn2H9KYXS02QfzSg0gzOugPIy+Op7qYByxD0HHlR8+V0fGBz4nUj/QrpZ2cCrrlTfzuhkHdzLo1w+v5+7/TNoNzWVdfoCKbnD5u7IQV6089D1/gVp9TAbCmGoLhXkGT4flqvmHXfywWoabRh4FgEO7z7kFEMzYv+Rewk2a6u38n5Nlei2dHQxkb7K7Qm9/WnQdj16tUDdrY2wR0Xnd34KDNtAy0QlQVlUjGRplnQKOz7eTk6mcOLj1bMhWnmB6ZLc3BxMtUFhuTD24bQZ9FCDq5qJpL3fkwrRxzXQVcUqRf9NIdH7XwIwILzPGoDix2xXe/zdPFV/ycpBAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(6506007)(6486002)(38070700005)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(33656002)(8936002)(41300700001)(30864003)(2906002)(36756003)(91956017)(6916009)(76116006)(5660300002)(4326008)(66946007)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(186003)(86362001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uujyo7JAhxNbzKrCzGVZNUULuwPt3tVPY89atoTtihW64Exo2uxtA3QkAuU6?=
 =?us-ascii?Q?3L0WtgzSkZUpQA+1Q+VuCnDsFrQDN5MN7efPzcoeeBtp4uLwz/PAZ5ZhxaDz?=
 =?us-ascii?Q?Rj69MaqHVcgS9tu2Z75i7KNDQGBmRnRGAEhnx/wUsF6UU+PKi9JDX97JJ7gA?=
 =?us-ascii?Q?AXuvDyxBY8tCvZeDA1mmaMgDMHwY7bHd1VBPDQQbyPUuQb5fnYkotXgO3XkI?=
 =?us-ascii?Q?uoWvt4ZJxTVevyuHFqM6YoLraDHqsOLgcSqrN0JdPNaE59NbzYZelGcsmTpt?=
 =?us-ascii?Q?6U4Aw8NGftbXJiDhScL//+RO8E06o6xkR/FgQY2eu4VsBSNGsM8WaAQafkqf?=
 =?us-ascii?Q?vXMqyDtIynlNhDQj1XdCh87NQF3vCDs2FCAqLAFMFG5uq/tUGrrAFIUPbVm0?=
 =?us-ascii?Q?CUSEEUzf31yi7CkDx+I8aCjo3u9vbwioY1KSgdeBKrSXOKG43rDfrAGprkHw?=
 =?us-ascii?Q?K7EDrCXNMeCV0C4yCVBmlTg8G73YYvKLJwP8XY6TD8oHFl11WSJy6Dr64itq?=
 =?us-ascii?Q?z/2ZI9e2ravB4FHV87ETBkt9drb2nzDlD18dWjRIZCIEYTR3HjNzxceETNkQ?=
 =?us-ascii?Q?uJj6io8dBjT2OL02dXOAimm5bAqJFroUODZFDrrdziH+Qbo3a129MFmb6q+Y?=
 =?us-ascii?Q?JJQ5IM2UuyiAyEnKWYylntoK4Z10sLDOfqRpF+MM/8amm9qRZGk+S7zrf9WA?=
 =?us-ascii?Q?3A81L+Z2FKzTJp+eR0RfRgx2t6JV+lXu3fWx4pDvK/YaGhAA7Cnp3g/iiMUn?=
 =?us-ascii?Q?2qDhYMyi0RASyUDbogYjokte8zQSg6VmMtQVG8vbNNPeAh636TrUNWBACxU7?=
 =?us-ascii?Q?KzHdPkJlYSju7yG4kYy9skhJg5TmmCWWkKb6i5PO+C2/GZrvib0jFS2BHklO?=
 =?us-ascii?Q?JH0HwP19+ejtXMLGn9aszzIDcOip7aswN9Cgg87vLoeXi4WhrDNnad/jTn+K?=
 =?us-ascii?Q?3Ftmdkw0kfuMk/P5WIfcMe61plWxSQgDeQyoVpvI+j+Errw8fx8YoWGW1NdJ?=
 =?us-ascii?Q?fTEzBJWi0rwfi3rPbUjXoLpN94KR+lx4/70cwVW0n57U3M/FdX2afW2baiMT?=
 =?us-ascii?Q?pvXalOaFzijw3I4gZmS9z8dEfXdtlgy8uHHOCN3s07jSPqCIrmTnSwtLqI3E?=
 =?us-ascii?Q?9HG6Yhny3AjmejIDfL3LdzG8Z1b2DguJdV6aWhqtnT/xneP4bwejn/0uaqxf?=
 =?us-ascii?Q?crdKBuqwT9VPlgMYhPFGw3Gix3A0l/pMUsB0IWKCABterHAAMmjdhIg+CF+d?=
 =?us-ascii?Q?cHbv2tuqrHg5oLIOoF+266emitb7h25KkQHyOxB8ztMLvep6zdl3om/q4Vf6?=
 =?us-ascii?Q?J6JJ1b0leacqsDsO0A8/zR07GnwiT6UMlvhVCPhQSulmZkHiMzojtbE7JsyI?=
 =?us-ascii?Q?oHF6mziYI0Fg8Nvf7l5bIJYji6gKDlw+/ew1IzKLr6VcRmjeD4kznltEy/NL?=
 =?us-ascii?Q?JGNcWTs72Bl1AQzkv9865eIK1nfnyJjYelODsDZz4tDMLSgiZMnQVocxKZnh?=
 =?us-ascii?Q?2YFMWc0MzH+l8bvK/BSYRSIfS1aqTRBimHgvQSc4b6KX84PujRaYG5nQWYZG?=
 =?us-ascii?Q?wckyfTw13+Yt2YV8SAZDoZnxttKbxH3NMBDupBGfh4mZxeqvthgJrRvG4+BD?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D227A061C972F4BAFBD4B8679915A27@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae662d4-4292-415d-cf5d-08da55efea69
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:43:34.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hT8Stf55VGvu9OruFhkMOnXnnhVfh7MDFwzoLtL2YKEskiwdOEcfCrbxiKVFyB3b33s/is4usKqo5fhHNbrkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=843 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240057
X-Proofpoint-GUID: 9Nypuz1MeuLDY8m4zRpux4WI-bueThvo
X-Proofpoint-ORIG-GUID: 9Nypuz1MeuLDY8m4zRpux4WI-bueThvo
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
> Except for the xattr changes, these callers don't need to save pre/post
> attrs, so use a simple lock/unlock.
>=20
> For the xattr changes, make the saving of pre/post explicit rather than
> requiring a comment.
>=20
> Also many fh_unlock() are not needed.

This patch does three different (though related) things. I prefer to
instead see three patches:

- One that changes the xattr code, as described
- One that cleans up unneeded fh_unlock calls, with an explanation of
  why that is safe to do
- One that replaces fh_lock() with inode_lock (or inode_lock_nested,
  see below).


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs2acl.c   |    6 +++---
> fs/nfsd/nfs3acl.c   |    4 ++--
> fs/nfsd/nfs3proc.c  |    4 ----
> fs/nfsd/nfs4acl.c   |    7 +++----
> fs/nfsd/nfs4proc.c  |    2 --
> fs/nfsd/nfs4state.c |    8 ++++----
> fs/nfsd/nfsfh.c     |    1 -
> fs/nfsd/nfsfh.h     |    8 --------
> fs/nfsd/vfs.c       |   26 ++++++++++++--------------
> 9 files changed, 24 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index b5760801d377..9edd3c1a30fb 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	if (error)
> 		goto out_errno;
>=20
> -	fh_lock(fh);
> +	inode_lock(inode);

fh_lock() uses inode_lock_nested(). If the above hunk is the
correct substitution, the patch description should explain why
that is correct. Otherwise, shall we use inode_lock_nested()
here too?

Likewise throughout.


> 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> 			      argp->acl_access);
> @@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	if (error)
> 		goto out_drop_lock;
>=20
> -	fh_unlock(fh);
> +	inode_unlock(inode);
>=20
> 	fh_drop_write(fh);
>=20
> @@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	return rpc_success;
>=20
> out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
> 	fh_drop_write(fh);
> out_errno:
> 	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 35b2ebda14da..9446c6743664 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> 	if (error)
> 		goto out_errno;
>=20
> -	fh_lock(fh);
> +	inode_lock(inode);
>=20
> 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> 			      argp->acl_access);
> @@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> 			      argp->acl_default);
>=20
> out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
> 	fh_drop_write(fh);
> out_errno:
> 	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index d85b110d58dd..7bb07c7e6ee8 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -374,7 +374,6 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> 				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> 	return rpc_success;
> }
>=20
> @@ -449,7 +448,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
> 	type =3D nfs3_ftypes[argp->ftype];
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> 				   &argp->attrs, type, rdev, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> out:
> 	return rpc_success;
> }
> @@ -472,7 +470,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
> 	fh_copy(&resp->fh, &argp->fh);
> 	resp->status =3D nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
> 				   argp->name, argp->len);
> -	fh_unlock(&resp->fh);
> 	return rpc_success;
> }
>=20
> @@ -493,7 +490,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
> 	fh_copy(&resp->fh, &argp->fh);
> 	resp->status =3D nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
> 				   argp->name, argp->len);
> -	fh_unlock(&resp->fh);
> 	return rpc_success;
> }
>=20
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index eaa3a0cf38f1..7bcc6dc0f762 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -779,19 +779,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 	if (host_error < 0)
> 		goto out_nfserr;
>=20
> -	fh_lock(fhp);
> +	inode_lock(inode);
>=20
> 	host_error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl=
);
> 	if (host_error < 0)
> 		goto out_drop_lock;
>=20
> -	if (S_ISDIR(inode->i_mode)) {
> +	if (S_ISDIR(inode->i_mode))
> 		host_error =3D set_posix_acl(&init_user_ns, inode,
> 					   ACL_TYPE_DEFAULT, dpacl);
> -	}
>=20
> out_drop_lock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>=20
> 	posix_acl_release(pacl);
> 	posix_acl_release(dpacl);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 79434e29b63f..d6defaf5a77a 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -860,7 +860,6 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> 				create->cr_bmval);
>=20
> -	fh_unlock(&cstate->current_fh);
> 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
> 	fh_dup2(&cstate->current_fh, &resfh);
> out:
> @@ -1040,7 +1039,6 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> 	status =3D nfsd_unlink(rqstp, &cstate->current_fh, 0,
> 			     remove->rm_name, remove->rm_namelen);
> 	if (!status) {
> -		fh_unlock(&cstate->current_fh);
> 		set_change_info(&remove->rm_cinfo, &cstate->current_fh);
> 	}
> 	return status;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..cb664c61b546 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7321,21 +7321,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, =
struct file_lock *lock)
> {
> 	struct nfsd_file *nf;
> +	struct inode *inode =3D fhp->fh_dentry->d_inode;
> 	__be32 err;
>=20
> 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> 	if (err)
> 		return err;
> -	fh_lock(fhp); /* to block new leases till after test_lock: */
> -	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> -							NFSD_MAY_READ));
> +	inode_lock(inode); /* to block new leases till after test_lock: */
> +	err =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> 	if (err)
> 		goto out;
> 	lock->fl_file =3D nf->nf_file;
> 	err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
> 	lock->fl_file =3D NULL;
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	nfsd_file_put(nf);
> 	return err;
> }
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index a50db688c60d..ae270e4f921f 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -685,7 +685,6 @@ fh_put(struct svc_fh *fhp)
> 	struct dentry * dentry =3D fhp->fh_dentry;
> 	struct svc_export * exp =3D fhp->fh_export;
> 	if (dentry) {
> -		fh_unlock(fhp);
> 		fhp->fh_dentry =3D NULL;
> 		dput(dentry);
> 		fh_clear_pre_post_attrs(fhp);
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index ecc57fd3fd67..c5061cdb1016 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -323,14 +323,6 @@ static inline u64 nfsd4_change_attribute(struct ksta=
t *stat,
> extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
> extern void fh_fill_post_attrs(struct svc_fh *fhp);
>=20
> -
> -/*
> - * Lock a file handle/inode
> - * NOTE: both fh_lock and fh_unlock are done "by hand" in
> - * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
> - * so, any changes here should be reflected there.
> - */
> -
> static inline void
> fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
> {
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4c2e431100ba..f2f4868618bb 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -253,7 +253,6 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  * returned. Otherwise the covered directory is returned.
>  * NOTE: this mountpoint crossing is not supported properly by all
>  *   clients and is explicitly disallowed for NFSv3
> - *      NeilBrown <neilb@cse.unsw.edu.au>
>  */
> __be32
> nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> @@ -434,7 +433,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> 			return err;
> 	}
>=20
> -	fh_lock(fhp);
> +	inode_lock(inode);
> 	if (size_change) {
> 		/*
> 		 * RFC5661, Section 18.30.4:
> @@ -470,7 +469,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> 	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
>=20
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (size_change)
> 		put_write_access(inode);
> out:
> @@ -2123,12 +2122,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char **bufp,
> }
>=20
> /*
> - * Removexattr and setxattr need to call fh_lock to both lock the inode
> - * and set the change attribute. Since the top-level vfs_removexattr
> - * and vfs_setxattr calls already do their own inode_lock calls, call
> - * the _locked variant. Pass in a NULL pointer for delegated_inode,
> - * and let the client deal with NFS4ERR_DELAY (same as with e.g.
> - * setattr and remove).
> + * Pass in a NULL pointer for delegated_inode, and let the client deal
> + * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
>  */
> __be32
> nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
> @@ -2144,12 +2139,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, char *name)
> 	if (ret)
> 		return nfserrno(ret);
>=20
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp, true);
>=20
> 	ret =3D __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
> 				       name, NULL);
>=20
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
> 	fh_drop_write(fhp);
>=20
> 	return nfsd_xattr_errno(ret);
> @@ -2169,12 +2166,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *name,
> 	ret =3D fh_want_write(fhp);
> 	if (ret)
> 		return nfserrno(ret);
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp, true);
>=20
> 	ret =3D __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
> 				    len, flags, NULL);
> -
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
> 	fh_drop_write(fhp);
>=20
> 	return nfsd_xattr_errno(ret);
>=20
>=20

--
Chuck Lever



