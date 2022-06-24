Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95B559C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiFXOpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiFXOoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:44:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9806B8D1;
        Fri, 24 Jun 2022 07:43:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODi8Yo031768;
        Fri, 24 Jun 2022 14:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nQpH0Hg2eBxY3i7uK5bm4q0p2hiOw8uIwB5sTlCG3no=;
 b=O8nsgQQkDPAedUI82bmK1W+07NJH+zn2S2M39/50ZVvjQ1A43GxwsPd6i3gwLqB9WMct
 vqRsFGiYSJdHRTL78icrFw8VZv0QEX0elv6ACrAcNHAS1F07gl31s60Xh4pPqy/FYDza
 bhNOrPUZIvQTRmol3v1YSDGVIXDgqpXyhbORI8kLCM/G+8le7xaOfnlaRZGBArDYifV3
 1FeHtvhLoc/+iOxPYcH0TbveK8kArhZc/8wSvBot++8icK29D+UF98fedwTiIASIHcbV
 CX1+Fl8yLQkkuqZ5Qwqcspfws2Hacn7X3gFjjsk0NfFbecB0iodyUGG+FnWEBJBuWKU0 ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u609x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEejTK017258;
        Fri, 24 Jun 2022 14:43:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3ye9v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+ciXjTopxOT+Ad0iUDxTK6L9DoY6keCiv92rbzeBhJnsNVbWNkwZIcVr6DnK6Rjt5H1Y4//4EOP5cOixCWZddcY3mpPsGV4GZZxuKLdzZFki09a9n3aCWIh0ti+3/hV1XGQKv0vDeOdcvydfAe11UduHPVGo38xcM7Jhwe0lVzFAeIC4kx+AuNwquaIDMQ1lWfQcxNRSPF8aNHDGQRfsoRMAhD8MFBl+pABcqL70r+c/jH0gU+V98i4jTfW1F/arrjJG96TYaXB4tFL1StTziXEE9MGBnLf8MOP8jgKqhyjq65l2lDu7S550tW7WE16MZd9HQZeceJDyYtgCPx1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQpH0Hg2eBxY3i7uK5bm4q0p2hiOw8uIwB5sTlCG3no=;
 b=XJGedjsxXqtxHT02xvrlwYMVfZtVm8FMPX+Ig5+5GH1leB7/x1UutULT0AZu+x4A2xhLuyJYzCmCeEP4Nle+0UOm9eS2QI83S2okTZGVDO+Aee1ND1YpspOqhV1rn2L2rcN3OFU8dIXqTuYYroSSw9UIwmCn77UOPNr4yM8hAQcszBxpepTjLtOU2OTfvLaY+TjxkWubf4aG23Tm9FeSrXX8N/KEm58ADQU/ogsWogFCOi+xsVnZ6+saweV6jXhNHaXOTz5OZQoUYvicYAEy7S2oYu71mzBtME/fHgSve90D3XO2IztBFm1YwCMMJuxSXo1FMHGUIWnH3s19BmPJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQpH0Hg2eBxY3i7uK5bm4q0p2hiOw8uIwB5sTlCG3no=;
 b=rWz2DPMw+qeug+2L9y7eKM8qU9wohyvcKSAewTQo/Rt0GGQ9euRuS6mmioLW6Glaz0yqUP5c4lVhGwsNuAJtQuuJ9SsdQe1Y7RAZAjF5qROSEWsLQob5myaR3wVkb8VUSsLUpZNBwEMBCR9RsFx/RNAAm+ZhwdjIUReyiBoMI7M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:43:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:43:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/12] nfsd: support concurrent renames.
Thread-Topic: [PATCH 09/12] nfsd: support concurrent renames.
Thread-Index: AQHYf3xXp6NQ/4zQBEydVnDMQfaA961esooA
Date:   Fri, 24 Jun 2022 14:43:24 +0000
Message-ID: <7FDF6A0F-CD8A-4813-A5CA-FC2D69E84F29@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230201.21248.13160043266041158437.stgit@noble.brown>
In-Reply-To: <165516230201.21248.13160043266041158437.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676b190a-8607-41e4-b1cc-08da55efe4c3
x-ms-traffictypediagnostic: DM6PR10MB4236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlc0G2thVvvIo1HMDUH67h7kfh/rehXtUVhdKmgDitS49fBMEslgJ0hYx/+pvOxoC14VTWcB6BUrIpSBMu+OE/yn7M728gLHKgwy/1/FRYVoEjdlBQ4Mg11XSiodAKSAQaXEAP0GVVaz9HTI4cyvUd6MvVYjXUNidPTDSH+pxzStMVH6D+KZuZTPsCy3YrZGou26RddLxkKpUqwXWy+F453Bm/nzY6vHeMGvOnc6xmr+YjsPa3g5qfi0JcbYDuFYLNn2qsXa7/u+hg5JOututRnVOds8tU/V5ybGrVaYJPhYHQ6nnuMxWoSyvVb54EhNi1HPicuyRdWiVZDYRAhxJW5dZPkjMPTZCPOUSHGQ0BX0vv5yjRgbQvB+KELk/STCcbSRF4PcdrmDSLNr/1ioFtr+ya+OBJrb9swCSOZ/2BWIz4Hi5cpoBR+VuSqGP4CRH1i44LQmV1ms8PS7RH2mLNt17g65EPNhH0bAZ62K/9hulS1Z0jenwa14gFrLFkzJz+Rug8ZPxtzrkKeYbUPaMq3fm6nnBZ2AmBnmb7gx8S0rOlkqZcfq+SbIFMX5hPeUsLNaThEQizQmVmKuWtqsbr8d9ta/KvpwjumoWRStn7nA12ivPfmDj9ctpJ6m1c5kbesEkqUhJgY1XQPa7pVHmdvmMPXQR7MoVuPHWH3Bm4cK812vxis5jVCiB048pob1S2+mVXz4armQY8dp6vjvR9cR1Ebarw33QXaoOJoawywODkr/LkFYlVycJziklnKnyCQYL53EExZZl1Sy/2OizUVOyGx27qdlUTFrYgkTZ7CHr7Tk+8zNFAL/BeY3HEmlVZ7Pf0z/ihqyPRl5b6B6sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(6506007)(6486002)(38070700005)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(33656002)(8936002)(41300700001)(2906002)(36756003)(91956017)(6916009)(76116006)(5660300002)(4326008)(66946007)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(186003)(86362001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w8n5q7Sq3bow+aqdPvi9Xad1t71XBrse32BAWmn3jqpF3aHTN07S3HVKK0cB?=
 =?us-ascii?Q?hPG7J0QWbZoIv1TqzjKfEPEQiEaum/ZmFFTnCDJqq6qmQknqMTPKlYgrWvms?=
 =?us-ascii?Q?64U2Q5TK6bol2WHlZSyg7gDO6xYRAJ2BeDDxdQ5vkkZ0sostIHJHETp3cpTm?=
 =?us-ascii?Q?hAayJUud35yYy8dYvC2KFC6gfsmFYiMJZTQxR2ziblsaAkkdX4tyUFazYlpq?=
 =?us-ascii?Q?WOXG4PNCm+1UvUUD1xgOoNX3PlVtysbPFaF+XY5icJJLTnPtR/tHz2Qz4u/D?=
 =?us-ascii?Q?EfV0uRsWH8p4M+mrWQSHmdFz2zLSaM1SgYvtXGRthUrsJxlHbFqH+tbu2x7w?=
 =?us-ascii?Q?DxRoXArRnN3LfH1z3WhekN4ecVcJblS/+/ry3L3WaN7w2YlqLQN+ZoDGk77C?=
 =?us-ascii?Q?Fkc9NwL70ytQO9w3ufMWR5hGoOHugVUQStcq+GWwt34DkhZ4+9mflLbW45CF?=
 =?us-ascii?Q?2Bgyv/yRov/RaDKxXrJZPqnm0Ncff1Km3q7zjlM4zLGNrYGKhYPEvPfGgDqx?=
 =?us-ascii?Q?CuUROnLnO8oPqRJwWtLraNvgL2EMGxzvQh0tN0W+4+cuCbBH4Ok+bDVD2hus?=
 =?us-ascii?Q?rYwYFrRYXsvt/jQJCO/RuySO5HHhrYGkiSA9DuP+MH4avtwhRx5MvBHgBZ//?=
 =?us-ascii?Q?y7xiEmbGJnK4jB1OBraqRpAoX5FoFxeWOKILxEsdh96txstZrvXO+EykgleO?=
 =?us-ascii?Q?2m+ZTCT6ewF9O5dptYJErd9p10WfhMhA0ykOYfrXUD1awigBeibPLNahgxet?=
 =?us-ascii?Q?e6acXY7Do1IjC1T9tE0QlR5+Y1PsnViDHzD7pDF6/mr5X8X2uNEdXB4BkNSA?=
 =?us-ascii?Q?FgRDBIrrpSu229xEiuco0v5Srovp6YOnoesb7r6nvXMu/DFBQsGWf0TEnlhp?=
 =?us-ascii?Q?yZ2uc9aJARQ/YcBMRk1IJMpISDNqxJmA8yCII0ArhYm1f6LAfujpFRcxFeEG?=
 =?us-ascii?Q?tSf3RcJKEfRpwB+N2iv2v5K+FuNT+GZx26RJG0SJXpaIPcO0QIvo/VB6EaMv?=
 =?us-ascii?Q?XWAuZZxeYc8iTnQMKpq+dCoLHZXbFywwEtq8jYYuGH+AcsbSzSzTK3JM7RYx?=
 =?us-ascii?Q?qCw3xe5nXUcgQlcIyEjwnt6+PHSFUObR/L2n2L5/oc/xcoIe3oq4rzalCrbZ?=
 =?us-ascii?Q?fYyifQPr0MJHRoCPwcjR53w1QIrRtyWRbwOvwQ4PWJ4YktNUE2lESmdVhEf9?=
 =?us-ascii?Q?okI6lDefk15U3D65ZKUIMb5ENuGYHbBysvfi0NhDBw2gBGx5fPXXaJ5SPrPM?=
 =?us-ascii?Q?kyBQ0L4MzD63m4m0SYgrMRwBSmYC9M1r1tFnSNhz5v+1qLMCCYdSrnOO4/5o?=
 =?us-ascii?Q?o581vVYDr6nrZcVL7dZsm4iJi33dr7v8lK7GvQnNHqauFqlpiZ1C4TI/ezpg?=
 =?us-ascii?Q?7uBS4qPA/Jx6A3JsjAC7Py08JVdJvwAmDFewyCpVcF6oYadetJaPdc1kCNAn?=
 =?us-ascii?Q?dX7R6XbTkZOhVSOTKws79hL6bM2lBzCkB5KvNaey+QR810xaIADkHWN/pFOT?=
 =?us-ascii?Q?I6iSyuOk4+MRr8IVBV0wFpfx9KeKbEgtV6+Yg2WspPELQul/1L61U/hm5zZP?=
 =?us-ascii?Q?z+STU/nEoWkYsFQWrQ9AzoDLyLAZEImDiE7KNzLBNUlhwl29h9GcWzSdqTKJ?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8DAABF01A5B6649B28E455E4F5BAAD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676b190a-8607-41e4-b1cc-08da55efe4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:43:24.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RN8dUr4DrgXB+3UcDuDQX6UqniWYZsHN7ezOgDjTwshjfbOJHq8bUvcUch1cAjoBiMxXxf6Qfbj/Bzfsv6AwAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240057
X-Proofpoint-GUID: a2f12PDYdL3nNOb7QEwcleMX3UgvIhgK
X-Proofpoint-ORIG-GUID: a2f12PDYdL3nNOb7QEwcleMX3UgvIhgK
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
> If the filesystem supports it, renames can now be concurrent with other
> updates.
> We use lock_rename_lookup_one() to do the appropriate locking in the
> right order and to look up the names.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/vfs.c |   49 +++++++++++++++++++------------------------------
> 1 file changed, 19 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6cdd5e407600..b0df216ab3e4 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1584,6 +1584,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
> 	__be32		err;
> 	int		host_err;
> 	bool		close_cached =3D false;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);

Ditto.


>=20
> 	err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
> 	if (err)
> @@ -1611,41 +1612,37 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>=20
> 	/* cannot use fh_lock as we need deadlock protective ordering
> 	 * so do it by hand */
> -	trap =3D lock_rename(tdentry, fdentry);
> -	ffhp->fh_locked =3D tfhp->fh_locked =3D true;
> -	fh_fill_pre_attrs(ffhp, true);
> -	fh_fill_pre_attrs(tfhp, true);
> -
> -	odentry =3D lookup_one_len(fname, fdentry, flen);
> -	host_err =3D PTR_ERR(odentry);
> -	if (IS_ERR(odentry))
> +	trap =3D lock_rename_lookup_one(tdentry, fdentry, &ndentry, &odentry,
> +				      tname, tlen, fname, flen, 0, 0, &wq);
> +	host_err =3D PTR_ERR(trap);
> +	if (IS_ERR(trap))
> 		goto out_nfserr;
> +	ffhp->fh_locked =3D tfhp->fh_locked =3D true;
> +	fh_fill_pre_attrs(ffhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0=
);
> +	fh_fill_pre_attrs(tfhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0=
);
>=20
> 	host_err =3D -ENOENT;
> 	if (d_really_is_negative(odentry))
> -		goto out_dput_old;
> +		goto out_unlock;
> 	host_err =3D -EINVAL;
> 	if (odentry =3D=3D trap)
> -		goto out_dput_old;
> +		goto out_unlock;
>=20
> -	ndentry =3D lookup_one_len(tname, tdentry, tlen);
> -	host_err =3D PTR_ERR(ndentry);
> -	if (IS_ERR(ndentry))
> -		goto out_dput_old;
> 	host_err =3D -ENOTEMPTY;
> 	if (ndentry =3D=3D trap)
> -		goto out_dput_new;
> +		goto out_unlock;
>=20
> 	host_err =3D -EXDEV;
> 	if (ffhp->fh_export->ex_path.mnt !=3D tfhp->fh_export->ex_path.mnt)
> -		goto out_dput_new;
> +		goto out_unlock;
> 	if (ffhp->fh_export->ex_path.dentry !=3D tfhp->fh_export->ex_path.dentry=
)
> -		goto out_dput_new;
> +		goto out_unlock;
>=20
> 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) =
&&
> 	    nfsd_has_cached_files(ndentry)) {
> 		close_cached =3D true;
> -		goto out_dput_old;
> +		dget(ndentry);
> +		goto out_unlock;
> 	} else {
> 		struct renamedata rd =3D {
> 			.old_mnt_userns	=3D &init_user_ns,
> @@ -1662,23 +1659,15 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
> 				host_err =3D commit_metadata(ffhp);
> 		}
> 	}
> - out_dput_new:
> -	dput(ndentry);
> - out_dput_old:
> -	dput(odentry);
> - out_nfserr:
> -	err =3D nfserrno(host_err);
> -	/*
> -	 * We cannot rely on fh_unlock on the two filehandles,
> -	 * as that would do the wrong thing if the two directories
> -	 * were the same, so again we do it by hand.
> -	 */
> 	if (!close_cached) {
> 		fh_fill_post_attrs(ffhp);
> 		fh_fill_post_attrs(tfhp);
> 	}
> -	unlock_rename(tdentry, fdentry);
> + out_unlock:
> +	unlock_rename_lookup(tdentry, fdentry, ndentry, odentry);
> 	ffhp->fh_locked =3D tfhp->fh_locked =3D false;
> + out_nfserr:
> +	err =3D nfserrno(host_err);
> 	fh_drop_write(ffhp);
>=20
> 	/*
>=20
>=20

--
Chuck Lever



