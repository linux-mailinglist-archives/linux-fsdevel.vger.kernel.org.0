Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C0618328
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKCPoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKCPoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:44:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068871145;
        Thu,  3 Nov 2022 08:44:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FYOwI005729;
        Thu, 3 Nov 2022 15:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UpDhQNSCLWsP9RD4ICu7pfRekRPsgH+PK+FF+nyOCJo=;
 b=V7GjQuXtTsDU6qvbzp2Kr+chzBcudORJxW/VUNFQEiw0S0cIN2egWUU65uRu1TVsdvRQ
 D75DqDsekAwzKgVdlWHPfrpCaSjTdsx8RaIG9AB2wVTzxc60RLrSna7Iqa0ijIE+eSIM
 Q5VE9A2ge7OzGA+QceFYT6nsoWMFfW4TW+bBenthVc3QyP+J1VTKJ5pWOP/Pc/W5JkRn
 29AinPC4P3+r6jC91klhwZU6E7BwSsCfIP0FwIWgYnENWSu8XMRTeVRbuG36E5UhL/2Z
 zoxdpev7vO5V7mJtJ9bIr4fbaaMoa8tP3/JDvB+rPezMpMZajGnK9XCBwdTPiA5wiIOG Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1dgd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:43:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3F8LEF001299;
        Thu, 3 Nov 2022 15:43:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6rysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaCg11hOa9dwKEVJyLf4WKTob2SK9fu2GX78hL/b2j+G5S1bGI3yJCitagdbOQ7ro7edKhbpjwpxwEjxzTmUndykBQSJhNsT4W+2R9EXYvN8SB/Rw2jwDkz4QXsY1QTqQE+Sd4krGr7F7MlkG5cBqGTEtRnyx5w7GwlxRodWXPNy5ETvOcu12VZ7HEz9s0lIcJhzLMI8TDVS6W/QHfgCFMvhYi7uHrOsenaEmV1j1Ga7eYtBQGupwJ1GWRWeNOUR8k356rwRFBzAqZz6hDOnM+KR2XclL1NIRvzCNPTvmMeE4VsHUraR3NeNjFZ0pRFLaAxBcNmdupc8iEhukoM8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpDhQNSCLWsP9RD4ICu7pfRekRPsgH+PK+FF+nyOCJo=;
 b=HTAZ3+ZCdSAVmsVjNwPpNT1Lh1W4wWw4wI/a2t1JumYDEcRgus87vSsCIBFN9sPdQQvy4K2Ex54GfpruvMlXCXNQQVDm3q80a3et95Q+R8CgmQZKIEB7p1q0LT415hO01pEdURPwRicLXm1GTpMZnWI9QwFY6QIFxN2zgd3dW76DyRCDn1rxSRIJyPB+RsmJDKP7/Zwq85yur/YfUdT0EDoytoolDFfkNHL/0+p4W15yELCK4uKZKwsutA5X3wjF27RR3MO+8fPaZxvGw8c44GLMp66QxTDfDI48X8EXPsl3Td9vWq9CIiamaSk4unvm6tcNJTi4mTuZfdHbSgub9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpDhQNSCLWsP9RD4ICu7pfRekRPsgH+PK+FF+nyOCJo=;
 b=ZLLtAASs8Nos8vKAjwUSq6mqDkAays+7/DAc+Eg9lY/HznvgGTb2XcYWT36ld4Qqo7R92PNhkPjlVI3DCrP87I71yqBXnGo/q15AT3kZl76u3NNHrhMb0rwguPK/Owt8wPHf4TVh/R+Skki2KeASErL43cNR3Uq5CH6ApxrlSh0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 15:43:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 15:43:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, Bruce Fields <bfields@fieldses.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 8/9] nfsd: remove fetch_iversion export operation
Thread-Topic: [PATCH v7 8/9] nfsd: remove fetch_iversion export operation
Thread-Index: AQHY4hdEz9E5Fj2hi0iz4xQvGekkH64tcemA
Date:   Thu, 3 Nov 2022 15:43:42 +0000
Message-ID: <4D563C45-38A2-4755-BF06-7A30E0331541@oracle.com>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-9-jlayton@kernel.org>
In-Reply-To: <20221017105709.10830-9-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5700:EE_
x-ms-office365-filtering-correlation-id: 1985b75a-ae49-4eda-9c89-08dabdb22f6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLQn+5eAaq7EtZT/7oh67vPm9NWAue2YXJk0Cj0Xc35tLOOX3UlvS+Oret5BAQngmTyUjgzJm4Ytu6/ku8iV83yXPXexnd+vQoL3RtVwjo7C75SfhrnDihvQcCrRJpUfY+NxjfXp6fyumtxeWizJ9lGzxKEZHtaNpQa/wnfTgs9zWzpJEijCycsHGQ5ogCcJxpepeic0UGT3+QdUPv3yXoYx8VJjuuBTbVlQHPh+eKRhu6GegAL1X1Ky4UNKIuhHo0WJ4ac28cRLrmxjA28JRosP+kPP+ciC3lNqda9kkg63v5YfQtJhWJAkc0biiIYwQ2Njb7e82AWA80L47X9LXqltPQfxCokexiBC1KF9FCsrx7aOowvoYoPwqs6SKPnYtDuQM/DWySkMbJcuHvJV+gZ3j4moeO/Jw1YBqXc0UDJSvxWwXeZ8ux7LH8Lm2vnqeGxxIJ7T/kKliiTgMK5O+bbHq1ojlKT6zBenfKrDCDxn987/+mqqbC1jVwmTYU4WHbJwL3lNWjQaiWFgJkyrFccOVn3/TaSgpnrAKWRtNFvmgzYaH0mZdfli5g6YEbvEa5ikv/WLkhuqeNnbxfZznS5j4t8iIXrWPoOmZARvSqJDLQ04mKd28UaaErRRm+QZuHAiD5upVZaPiIpZ3DgAfz5AFMXTDtfJ64W+8CDvNDc4+aPYZiF9Ipiq3NUjn3mzqBKkEd/6OZu5pE/1XKhkApNTcOR5UJJWXvaABOAztXTSApDkN+jwHPcMOdx4EXFEzJ8dFD/cQpZUe2tOIqekrS4ak8RBg3CievSR/YE1Qi8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(64756008)(66446008)(8676002)(66556008)(4326008)(66476007)(86362001)(7416002)(66946007)(91956017)(41300700001)(5660300002)(8936002)(76116006)(71200400001)(478600001)(6506007)(6486002)(36756003)(2906002)(6512007)(122000001)(83380400001)(6916009)(316002)(38100700002)(33656002)(2616005)(38070700005)(26005)(54906003)(186003)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IIcHp4I3qeq0zP1dUlGaHf4CXd8dfuYGM9u7lYyid/sRsDjsLvayckYyPTjg?=
 =?us-ascii?Q?JcjuLfrKNqP41h+RAOs99q86dTkTlvnDqd9KFPwuyL/AdftmMw6a6qprfj8/?=
 =?us-ascii?Q?8mvFZ6NdubpgmHcJT/FU9/eWc5meZF9cKPvzAsLR8J5ujEJmXKft+80UVOso?=
 =?us-ascii?Q?SSLxbPe/MyF/64X3jA9jcfziuHL+IzhJ07CS4taVd4kN0uK+3CehloFe2ktI?=
 =?us-ascii?Q?Sk+GE6PJtPqTFBDAM4iPQiTPRgQBEZ/Mytw5RLeuGVqYcQcrc1UahT1wlTCX?=
 =?us-ascii?Q?KJhzaM/3Wc6RqqvjKcVbSN0pOLmA16MBoVzgG335to4OQJtasNEV3RJwgS2x?=
 =?us-ascii?Q?w7/S+41zJbMCkE2brmyq8cIchGuUQWPuF9ifyjzGSZoNK9IGOzszgoZt7ppq?=
 =?us-ascii?Q?R9WDu4ws+0R19XsbHwLJ1/MHoT3GH7gTa1gT1eb1sTbFrDXqdIO/90/AQVjK?=
 =?us-ascii?Q?Bm2q7JVUhNU5zZ3j+AWej9DKABV7FpIeL1UdWADZQ/ZkuUKQfqjZlflUwAnI?=
 =?us-ascii?Q?0Rj7/odpTPxDO6lkcHnr7b5XFRg3MGwkgtu+OWlSf+Z4iT8PKIrTtnhYAjra?=
 =?us-ascii?Q?nNV8rzQbU/WHfubkxfhnT3Fq8hplVIWLTo0D3KaGBuyef4HZOza3iH1DkNiM?=
 =?us-ascii?Q?f/f3TDAQYAwboMA7RrLxfJ1QxdmtICZ4Hqjmg1CGm0DfqBBXXluarWAWSE40?=
 =?us-ascii?Q?g//kEUFQlfWzTwhQnxxjgqnx6Bv03Sp28E0bcpjgKXDXu/M6azwKZw0KOlHx?=
 =?us-ascii?Q?QyiVnt1Kw9szM0c1Y9TBEIDGVwvUv87kPJ+dKrOemFJ+2SwRhojOeS6iFxEg?=
 =?us-ascii?Q?hyd+rHmOcQCVCpTmRsC5Nsvwdha90AvvDPvGuJtkaSlsPVXxeXaOD9XU4jCk?=
 =?us-ascii?Q?7HigPElW5SlZW1LqYHw74CAJ3XEIlxzMc84mw8m84uBxCvEmCRgr/UlXk3KV?=
 =?us-ascii?Q?gmBR0aDqkg4m/MVSJ/nfkFx9J4/L1cqm4PjD83IyGFZHeQ1fKRUaRE9/7M43?=
 =?us-ascii?Q?WFRySjoBIqhhnonPnKO1RzingExIawAzvi7t90oy0d2pKv5v+CU/qnlobjw/?=
 =?us-ascii?Q?Rsrkk1GnYnS4HCfTIT3cH5OzoIAOSLd/cwJdYk41ePRTeK/cEVeNDATkfjA1?=
 =?us-ascii?Q?q6y7PMdXRHuNKqOwa/qhqILRTyVpD0/XRYFdbWi2xvSH724iIKsHZLwnjsO0?=
 =?us-ascii?Q?mYR5mnzSlPJJCIeS5L0uCaTy3xkl12z/ct5X9PJu9VtCs7u/O1D7uYnVgE0t?=
 =?us-ascii?Q?wDJjQ2Vxv8hYojC+X7sERcrsVjXcXq++Js5qt8DCYV5E0Q0Y6W4ySETzpccF?=
 =?us-ascii?Q?tAVXKyeJY7fl4EZuGHpQy76C8sLx0DBHkG4Kt+B2UwSkCxXDSWY9MPEupoF2?=
 =?us-ascii?Q?bCEg/TacSpGj3OLR9kQGb3VcfC8n4F5AJkOFpWwoE6pMLdFfdlTO5sU7LxfU?=
 =?us-ascii?Q?w0uP39uDnzFJQAN2P0ymyPLGVf7RTGX6kD0nFeJzP2sWRej8ufxXm2+AZNOo?=
 =?us-ascii?Q?6qPCtiQWxB8oLtvjk6YGmDE4DRbhO9z3E39lWKlx2t8rfqgSIukM+W1WsRaH?=
 =?us-ascii?Q?XKAxto4MiJAQYMjgXtM4Sv4e3rDZmZKnWIb8JcXAn7OtXd2obl88WZpANiCD?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDC10AF60243CE4BAA0502B32F834E51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1985b75a-ae49-4eda-9c89-08dabdb22f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:43:42.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/q0D4NI7YMu8iH7G47TNCagTv/9DVyyDMR+lvnBgeqKGwojhFBVpNvPzCpUDARjwKBtSxbaDtwAVaOsRyPFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030104
X-Proofpoint-GUID: Pyr4_bRFeNYsY5qXCIKjfglc1h8rXG0I
X-Proofpoint-ORIG-GUID: Pyr4_bRFeNYsY5qXCIKjfglc1h8rXG0I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 17, 2022, at 6:57 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Now that the i_version counter is reported in struct kstat, there is no
> need for this export operation.
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfs/export.c          | 7 -------
> fs/nfsd/nfsfh.c          | 2 --
> include/linux/exportfs.h | 1 -
> 3 files changed, 10 deletions(-)
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
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 21b64ac97a06..9c1f697ffc72 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -777,8 +777,6 @@ u64 nfsd4_change_attribute(struct kstat *stat, struct=
 inode *inode)
> {
> 	u64 chattr;
>=20
> -	if (inode->i_sb->s_export_op->fetch_iversion)
> -		return inode->i_sb->s_export_op->fetch_iversion(inode);
> 	if (stat->result_mask & STATX_VERSION) {
> 		chattr =3D stat->version;
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



