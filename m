Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022715F0DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiI3Ofk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiI3Ofg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:35:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8F5F3C5F;
        Fri, 30 Sep 2022 07:35:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UEPISk006710;
        Fri, 30 Sep 2022 14:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P0p3CqF27kmvEp+oBYw50TcPSBfmv5jweZahKFF3KNE=;
 b=nA22tkWQF11oB5K64MKA+dM0XakkqIprr4rG3RVjPPuBORLq0ywCMZeisuZWTdA7temB
 FWv+aniQPoAmP4Sj1xsafNa6A1MpIbKtun45Ujvqn0xDiE5g33gayRVB1ONbgUHqt6fm
 1MMTz/smvJzTXKEnR/vv53uVc+KG2edjti638dXGQ/r4JkPCzAZRhti3TOgTRCcn0WvM
 O6ZXF+SUcXQj704QHQ/h03o9H5+RJaAQNd8rQhJrQu2Jt1mEW8V2nD5VeZslTEotgh/v
 JdUGrTDHQJTunaegswusCSD4qKQZG/7Yk0rZHaif2JOYNwlzlKuedzCqVmyS4TvJXo/f nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpy7k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 14:34:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UDgtPA017959;
        Fri, 30 Sep 2022 14:34:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuddqmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 14:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCYAPbwCJuL7A4H4udFIP2bz5bo4MAoF7PYJxM6rtS7nQNoYN4npCQvWnmLS0Q1kf7SOs7VM5Oe2gvS3x7Ibj+NWhrdf7EznRqpbzvhyWld7o4i9MCAk8Xkn9Bcx/IxFlS2/da6nmie6vWddnBfkB2ySwx1pbBpqGpZxla6jtBb/an2MfL1az1X+qj8M93LgFyGufjlOGhA1+UL9zORMZ7lU3QmivEvvYxAicFJokVLNDe+Qb8axvIHxwCSjjtbiFsYkSEKvG+VkosmSPY5gQSZ8OTUuIkugFAxmS/EEI4bQ8oYVaQSigpc9wXkyAjTvqMCLGdnY53LTZAT64+2+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0p3CqF27kmvEp+oBYw50TcPSBfmv5jweZahKFF3KNE=;
 b=M59L0oL97EJQujrRHXJXa3AQBTTSbFIcXtwDlK4HCEdtf/598QwwhTUBAaxkqyLmsSTm0OE1WzVcPa2KQJlwk4pXPeVk1pMXuQT3FTJxiQipUEewm6zjPDDB/fco84Wx+pjm1gIvcjzrlm+vMOpXhQAD49aEKxXoLVpxWOJcrgn6C5RoOs0Mj4D42q3hQZ0DlHvIf5PCDqTnPGPUD5vMlNuy+gl2bbV3KzYjX6la77C3cnFsaXk16D9a74YEf+X12SZ17E0vrbvlyBEc03Sgm3XqFCEQbW1JzleSqzoxjWFNmTTC9SZ66RA+ADDCx0cyjD+AmYSWJNkMYMiPnuoytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0p3CqF27kmvEp+oBYw50TcPSBfmv5jweZahKFF3KNE=;
 b=gxkTxn2l9Dl0B1tyeoLrWsim+LZconVTxK4H7lXp2wH0SPi4RgYMtv0C/S6oCgg5NX1OqN3hMgLymjPMgcsuZGaskVSvGpZob5YFEutGFweGhQ64vm2X4rSA5cgtFHSG40oFX9dTuQdPSojnhght62Z5f60tymZGLUHUtpqyGmk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 14:34:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:34:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch i_version
Thread-Topic: [PATCH v6 6/9] nfsd: use the getattr operation to fetch
 i_version
Thread-Index: AQHY1L5ywUre48g23kmtI4qfGBpQE634ChoA
Date:   Fri, 30 Sep 2022 14:34:51 +0000
Message-ID: <D7DAB33E-BB23-45A9-BE2C-DBF9B5D62EF8@oracle.com>
References: <20220930111840.10695-1-jlayton@kernel.org>
 <20220930111840.10695-7-jlayton@kernel.org>
In-Reply-To: <20220930111840.10695-7-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6277:EE_
x-ms-office365-filtering-correlation-id: 3d4599b0-8048-4479-7a2f-08daa2f0ef59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2XOfuXmbkeLITVXLVYWt6qg/iIOjYYR6a2Kk6Os/QiLeYgu5X0fG3wZ5kjh5HhZGxaRBjAqR7C8scUxxZ+vIyU6V1HDdxdfv9gaJPi5CpINejzzw/rl/U2f0tP4SShlwFhFzsQpev3bGEKB50noJgrodGy1D6EKHsByDQK0xWuzl4cfSeKHGMRGxBY77kd85x0OGQOt1+FlR4z2CcF68tHxD9HUXT0bxb5pX71zHK+w0dpofdsNlaZsZfro4W3QtQOQgcybBAwWW8YtmlLyOATE/G5PBUJYTtErcxgw7Wjt2zJSZajN5hEBnnJ8f+FOWDhF12+v8NGkpTrSrhqOsfmfkJAoGAU0H8JEMLf1E6FcRuYJx/Awbo76W7iyZofKUlweBcHxtpCIgsxGBK5O37wJVI+q4ADUGjZA0DE8M05rx+j9ou9VMnDHTqV1e6ugDT482JqLdjNRe9KhEaB1XFvnr8qxKewoBaTHcA2erXBxr3QCbiDobDmQKmDIiZ9jeieFtrpfy5MKb5vqR14vXy96gftSRRZlOy56MB7qEuReIKrkkBvQWASZB4z0KFoZohcocSUCJTIyNdknosqiLH4SHL14QosJEcsr0POXQzg+PtCWo+aLwYpanfWYfdwq6OEyK3uNXRHDNC1wHouIKjkZ9UsMZSPTXQNFoxivtHVp/6w1VZC6orv+DQe9G2zp+QpXHPN6G73/2K8dhH4kCoGdwf5vHAoiKClDyTlctNrmBbOBC7mC0eRT6KVy7w91sSAbUKjUFnnYvGYyUEpoXz95NrJw8889ssZeZ5J60CreivFHuMmUd+KveZq+YnEAsaZ9Odu7sJtwtmDUock9ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(316002)(6916009)(66476007)(66446008)(66556008)(66946007)(91956017)(76116006)(122000001)(478600001)(6486002)(86362001)(54906003)(2906002)(36756003)(38070700005)(33656002)(8676002)(64756008)(4326008)(5660300002)(41300700001)(7416002)(8936002)(38100700002)(66899015)(2616005)(186003)(6506007)(6512007)(26005)(53546011)(83380400001)(71200400001)(60764002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cp9jVdQCJ9/XQSWjqaom+5Sb7+6jIxv3hpUC4RTyQ9trSXva72R6rcdf5QNX?=
 =?us-ascii?Q?l/d4/pFDpABEjA/TqBpU8EqOBvKQlPk4Jea7/eldY/NlQnDMfDqoD6/7NeIq?=
 =?us-ascii?Q?cjtJkcZ7raXoHTcdEVCYmaepuQXRX1tfkMbWpMVIh2heTsRcCq0z1HPHNcbf?=
 =?us-ascii?Q?qp6uOY2idmSgG84ca/YGVBIYRXaCvVqM5XVuaagzyPpHRU9nr1QE0DvGV4X6?=
 =?us-ascii?Q?IcUVfrO8aRv1D6ftA5G3gbRIGkcZj/slX5wMicCr5+8aANRZob/9TCyA336Z?=
 =?us-ascii?Q?pfsl7kKg/OdtRarmaYwYA5bhhXMHAsoLELuUjWabKKQ3rQCcElAOrkV7hBxM?=
 =?us-ascii?Q?xdJII5kShAyXSRd+1T3ZUUTHk4RxEUhMNkYVfaRobeze0IOLefFHqEQvwpih?=
 =?us-ascii?Q?OqmnrqcE9IlSXL1NHIlGe/QHwLrCXZ7mfMNr7kFeQOFowY2ajtwvawA4Wo6b?=
 =?us-ascii?Q?QlKzFtQxdkGuRUgoCfWPrButvPoYlUf1RplQW20lpUK3fgpmFtFx3UjTSLP+?=
 =?us-ascii?Q?2ot3og8EuNraDztZrgx5PvHuc4UIQ1+3cbUGMYppt8f8RPER4GA6jvdDAhL+?=
 =?us-ascii?Q?Ur/kTmSSkb5L48w+BKqqnsYctTgFYaHGG7CbC1j6ZceVosjHGzsuKxeCsNrq?=
 =?us-ascii?Q?vNOc3mKeMd03Qktp9GzI5d3g7aJvveOJcF2tTBwdD26OYC8SWqFKAq6iSdjQ?=
 =?us-ascii?Q?+Bv+L63vsvGcBnePGmzd5LlVTkMQmpnC5k0rChVdPrrHU/DnoyHvMWLmBOXG?=
 =?us-ascii?Q?nB6ooxGBcNSQ+uzN7N4EC/hoYZ/nBKPqQgQci+O62zJp19jUU5kkq6qEFQ3e?=
 =?us-ascii?Q?wqZgEE5vQPPDfKgP1rO4EZSMr/q2yxIFu6oYxzSq0MU14ahMNa8LWOyiskFs?=
 =?us-ascii?Q?pMKLaVtNp411OvNqTsjXMKMjuff6I4jduhnsgDP5Dwxz3l2SNyJK940h3Vgg?=
 =?us-ascii?Q?HZW1Ih8iIP2uN0Yb5bWl8D90ejA4SLgHKULwBZw9ABGkcbiqNftKcXas41Ke?=
 =?us-ascii?Q?8Ae92CkT9Rw+rTTkHVKOeiGYmvh6CiqxlJ8iTSHS8WdyQ+KydRCrnUssTr8d?=
 =?us-ascii?Q?1VWUxy5zHUXLN8VcTSunX66tzqZqvuBv5cfabsG5qIX2C15cfOUShj5rqcCh?=
 =?us-ascii?Q?kmWieAgepUPBngrJRNJFMc2n7G3abBhAtw45W0Ws3h61xUhageVmiDn67QJs?=
 =?us-ascii?Q?0QGsZQkVxuqa8aA7apbHx9MZBp/+04w/CDZPymYGyIhAfL6YBoSddcANR7gF?=
 =?us-ascii?Q?89Qrmi9e1rRaDfp/cj870jScb3Px+PDY1xIo+Q9s+EmqVxTFzu3jARO/eI6w?=
 =?us-ascii?Q?dKzgBvRzB19B4/Ja0ZBaNTx/v1ZRIA82qxz9Vqo8Y4JdjYmH/TPz05KckWoX?=
 =?us-ascii?Q?uyoD3RMnfMuKMU/wm7TLvlddPjR1eV97dsfklPCamBrOBkrp2eTwPU7n6Yjl?=
 =?us-ascii?Q?Nn0wWvXDyijDJoebQxMHiQTQDlZM0pFFqRJ+f0QvKE1VCcMduMAHiOGCeLBn?=
 =?us-ascii?Q?QhpGnuDSpKVxEuoEXoqsf+kFV3PaQOSASG/GeOwmtP7nh8J9gDrIL5uCmn3m?=
 =?us-ascii?Q?3HzQVv2cO5qp9W90Z0ANrymzP4VNLnbBkmfhnyT93rMLz2Xj8QpX7JMH3i6L?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2BD3DAE1880034C91863493DD45C930@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4599b0-8048-4479-7a2f-08daa2f0ef59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 14:34:51.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6vBc3/+Su5Vak1tkp3s7ngfEVWzRvkGR+M+rIM/8m9rXHYAYNPTjutlyab5Btq2dJl4WPRO7btEmbHslfRMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300092
X-Proofpoint-ORIG-GUID: _ywEfQGLKIXz_EJ4n2aborOp7oVNR36d
X-Proofpoint-GUID: _ywEfQGLKIXz_EJ4n2aborOp7oVNR36d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 30, 2022, at 7:18 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Now that we can call into vfs_getattr to get the i_version field, use
> that facility to fetch it instead of doing it in nfsd4_change_attribute.
>=20
> Neil also pointed out recently that IS_I_VERSION directory operations
> are always logged,

^logged^synchronous maybe?

> and so we only need to mitigate the rollback problem
> on regular files. Also, we don't need to factor in the ctime when
> reexporting NFS or Ceph.
>=20
> Set the STATX_VERSION (and BTIME) bits in the request when we're dealing
> with a v4 request. Then, instead of looking at IS_I_VERSION when
> generating the change attr, look at the result mask and only use it if
> STATX_VERSION is set. With this change, we can drop the fetch_iversion
> export operation as well.
>=20
> Move nfsd4_change_attribute into nfsfh.c, and change it to only factor
> in the ctime if it's a regular file and the fs doesn't advertise
> STATX_ATTR_VERSION_MONOTONIC.

This patch is doing some heavy lifting. I'd prefer to see it split
up to improve bisectability:

1. Move nfsd4_change_attribute() to fs/nfsd/nfsfh.c -- no functional change=
s

2. Change nfsd4_change_attribute() and vfs_getattr() call sites

3. Eliminate .fetch_iversion


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfs/export.c          |  7 -------
> fs/nfsd/nfs4xdr.c        |  4 +++-
> fs/nfsd/nfsfh.c          | 40 ++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/nfsfh.h          | 29 +----------------------------
> fs/nfsd/vfs.h            |  7 ++++++-
> include/linux/exportfs.h |  1 -
> 6 files changed, 50 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 01596f2d0a1e..1a9d5aa51dfb 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
> 	return parent;
> }
>=20
> -static u64 nfs_fetch_iversion(struct inode *inode)
> -{
> -	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
> -	return inode_peek_iversion_raw(inode);
> -}
> -
> const struct export_operations nfs_export_ops =3D {
> 	.encode_fh =3D nfs_encode_fh,
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> -	.fetch_iversion =3D nfs_fetch_iversion,
> 	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> 		EXPORT_OP_NOATOMIC_ATTR,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..779c009314c6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2869,7 +2869,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 			goto out;
> 	}
>=20
> -	err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_S=
TAT);
> +	err =3D vfs_getattr(&path, &stat,
> +			  STATX_BASIC_STATS | STATX_BTIME | STATX_VERSION,
> +			  AT_STATX_SYNC_AS_STAT);
> 	if (err)
> 		goto out_nfserr;
> 	if (!(stat.result_mask & STATX_BTIME))
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index a5b71526cee0..9168bc657378 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> 		stat.mtime =3D inode->i_mtime;
> 		stat.ctime =3D inode->i_ctime;
> 		stat.size  =3D inode->i_size;
> +		if (v4 && IS_I_VERSION(inode)) {
> +			stat.version =3D inode_query_iversion(inode);
> +			stat.result_mask |=3D STATX_VERSION;
> +		}
> 	}
> 	if (v4)
> 		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> @@ -665,6 +669,8 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> 	if (err) {
> 		fhp->fh_post_saved =3D false;
> 		fhp->fh_post_attr.ctime =3D inode->i_ctime;
> +		if (v4 && IS_I_VERSION(inode))
> +			fhp->fh_post_attr.version =3D inode_query_iversion(inode);

Since fh_fill_post_attrs() calls nfsd4_change_attribute() as its
next step, don't you need to set STATX_VERSION here too?

I kind of hate the way we're handling both NFSv3 and NFSv4 post_attr
here, it's pretty difficult to reason about.


> 	} else
> 		fhp->fh_post_saved =3D true;
> 	if (v4)
> @@ -754,3 +760,37 @@ enum fsid_source fsid_source(const struct svc_fh *fh=
p)
> 		return FSIDSOURCE_UUID;
> 	return FSIDSOURCE_DEV;
> }
> +
> +/*
> + * We could use i_version alone as the change attribute.  However, i_ver=
sion
> + * can go backwards on a regular file after an unclean shutdown.  On its=
 own
> + * that doesn't necessarily cause a problem, but if i_version goes backw=
ards
> + * and then is incremented again it could reuse a value that was previou=
sly
> + * used before boot, and a client who queried the two values might incor=
rectly
> + * assume nothing changed.
> + *
> + * By using both ctime and the i_version counter we guarantee that as lo=
ng as
> + * time doesn't go backwards we never reuse an old value. If the filesys=
tem
> + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation is not =
needed.
> + *
> + * We only need to do this for regular files as well. For directories, w=
e
> + * assume that the new change attr is always logged to stable storage in=
 some
> + * fashion before the results can be seen.
> + */

Let's make this a kdoc-style comment. Thanks!


> +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)

I'd prefer to use "const" pointers for both function parameters.


> +{
> +	u64 chattr;
> +
> +	if (stat->result_mask & STATX_VERSION) {
> +		chattr =3D stat->version;
> +
> +		if (S_ISREG(inode->i_mode) &&
> +		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
> +			chattr +=3D (u64)stat->ctime.tv_sec << 30;
> +			chattr +=3D stat->ctime.tv_nsec;
> +		}
> +	} else {
> +		chattr =3D time_to_chattr(&stat->ctime);
> +	}
> +	return chattr;
> +}
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index c3ae6414fc5c..4c223a7a91d4 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -291,34 +291,7 @@ static inline void fh_clear_pre_post_attrs(struct sv=
c_fh *fhp)
> 	fhp->fh_pre_saved =3D false;
> }
>=20
> -/*
> - * We could use i_version alone as the change attribute.  However,
> - * i_version can go backwards after a reboot.  On its own that doesn't
> - * necessarily cause a problem, but if i_version goes backwards and then
> - * is incremented again it could reuse a value that was previously used
> - * before boot, and a client who queried the two values might
> - * incorrectly assume nothing changed.
> - *
> - * By using both ctime and the i_version counter we guarantee that as
> - * long as time doesn't go backwards we never reuse an old value.
> - */
> -static inline u64 nfsd4_change_attribute(struct kstat *stat,
> -					 struct inode *inode)
> -{
> -	if (inode->i_sb->s_export_op->fetch_iversion)
> -		return inode->i_sb->s_export_op->fetch_iversion(inode);
> -	else if (IS_I_VERSION(inode)) {
> -		u64 chattr;
> -
> -		chattr =3D  stat->ctime.tv_sec;
> -		chattr <<=3D 30;
> -		chattr +=3D stat->ctime.tv_nsec;
> -		chattr +=3D inode_query_iversion(inode);
> -		return chattr;
> -	} else
> -		return time_to_chattr(&stat->ctime);
> -}
> -
> +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
> extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> extern void fh_fill_post_attrs(struct svc_fh *fhp);
> extern void fh_fill_both_attrs(struct svc_fh *fhp);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c95cd414b4bb..a905f59481ee 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -168,9 +168,14 @@ static inline void fh_drop_write(struct svc_fh *fh)
>=20
> static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *st=
at)
> {
> +	u32 request_mask =3D STATX_BASIC_STATS;

Reverse christmas tree, please.


> 	struct path p =3D {.mnt =3D fh->fh_export->ex_path.mnt,
> 			 .dentry =3D fh->fh_dentry};
> -	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
> +
> +	if (fh->fh_maxsize =3D=3D NFS4_FHSIZE)

Would it hurt to set BTIME and VERSION unconditionally?


> +		request_mask |=3D (STATX_BTIME | STATX_VERSION);
> +
> +	return nfserrno(vfs_getattr(&p, stat, request_mask,
> 				    AT_STATX_SYNC_AS_STAT));
> }
>=20
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index fe848901fcc3..9f4d4bcbf251 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -213,7 +213,6 @@ struct export_operations {
> 			  bool write, u32 *device_generation);
> 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> 			     int nr_iomaps, struct iattr *iattr);
> -	u64 (*fetch_iversion)(struct inode *);
> #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
> #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
> #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink =
*/
> --=20
> 2.37.3
>=20

--
Chuck Lever



