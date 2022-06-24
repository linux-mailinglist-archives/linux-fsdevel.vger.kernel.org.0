Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98966559CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiFXOrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiFXOpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:45:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95179284;
        Fri, 24 Jun 2022 07:43:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODhsdH005123;
        Fri, 24 Jun 2022 14:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VLysCT56esfR2BiL9OWLpovHDwIOa7l1sqb6A9OFAIo=;
 b=jh0CUBBlMvRNLJKrST40by6134imEhL/CYlz6pKnsgmSUTfu4CIlvXwB8L43fsS73GVm
 AzLvwBi/ubYzNyp8AnXIF6kry2c72GKhlb5TRr+gmX/UODMWI+w8NJCiAIY8NGJ8K6GZ
 aySLdODf3Se/V8TQn98OsRNP3CFFRHjDO+wcZJoklmndV6E8q8Ytf5AsbzV0cMXicmuA
 fVRBrxPEAHy7lL1hmLpbvcJhatd5FvtilEmnHG6SOYAXaw34NOnf6qKbT3RQ/nt3BQex
 txMGAGH7rc+wI8DKGdZthZEnYoPE43DQ180EC6eQFSzD5R6e8vkSlm6uYxImxQOd/Xrf AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at61dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEedQ2013653;
        Fri, 24 Jun 2022 14:43:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth90k09p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrUeioltHlKCpQtbDvOPsGrQ4/LxC1JOn7VFOx/IifUcp/NzrLpRBshwqZKVgSab8kRPwKXNcPQAnJep4AHXztsVDgs5Neci0OXD7lBNAbHX7eyWtuxsi9qJrBat984RuzUQmCiR9r36HpIAN9KLBj/b9wWoeagQ/lx4LvbGkoEQoqjM/Nvq00OWDs6N9DIpNviG0rg9HVR0ohv0TUAGhworwBzWub48cCsIw6XMC1B3bMD4x95xHKmjaEph8rnq90+VPnQunJRCeaERs9Pf919GbaWeAFhwCi9vb+Gj47PVjupOuFqDK8UzjUpUoL9ibazWqK+qlc/e0tqqzrxxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLysCT56esfR2BiL9OWLpovHDwIOa7l1sqb6A9OFAIo=;
 b=YvpCZypBong23n/o/1QZHVitmiC8KGISRH1UwDHzd4ehJORqE6qYnaE41G9aoA5b7qKLevSlEV5+4WccOUN42635a/x9+zO+LU/SsI13azhYAgP+GUEPq2barP+FCIkalJxY4LXiMewqAEhXf6wOCb+clkGkJud6dTp3ZNA78Kjl78AEVqW7V5PbTvW5MMk5p/9YfA+A3OCsRVLtqWOllnWE7PSLnjVWTq190j0WRrnmzgybNI5WBUXQ8HG/rUtLsqN7IsctgIAAtfRQ7FAYdcqEVcycQMH4hM09RMaH9RWAgBaMGRM6ePvlb5Eqde6/S08hJaD6IoT4zH1lGMpNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLysCT56esfR2BiL9OWLpovHDwIOa7l1sqb6A9OFAIo=;
 b=o9skR2Ht7SV/3X+2zJ1EmyA38uI+FLxvEkmm+kfnjc33I8Yol5xjXzSdlBNioGMco+jrxn8h6BGMfUKwSq0xcbwBhtK91ZIb8/8fRtrzfAog5L4n+4GQxkNyMFvuNLEGAc32NADNNbHiQe/AX38KWfB7Quvu378IvyFII1SJucU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:43:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:43:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] nfsd: discard fh_locked flag and fh_lock/fh_unlock
Thread-Topic: [PATCH 12/12] nfsd: discard fh_locked flag and fh_lock/fh_unlock
Thread-Index: AQHYf3xis0/2f05McUa/bAXcSwIyY61espsA
Date:   Fri, 24 Jun 2022 14:43:39 +0000
Message-ID: <EC3027E3-04AA-4157-9B7B-3A3D623FDD7B@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230204.21248.4630581281540290265.stgit@noble.brown>
In-Reply-To: <165516230204.21248.4630581281540290265.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b9211f9-d285-4eab-d368-08da55efed2b
x-ms-traffictypediagnostic: DM6PR10MB4236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zss2NdSCt7uoU1T9tcT8eobtIjRr6rI8tpDbO0UnMoOTO7J/2s1ZCEh1vptk2SaFh6q+eEO+RSpdyMjfrqqb5xn3N5tToNMqj5ka1MmgASDi6b1B3tx48hEI6enfWro0A0B1GCeZRmYvmc2u0Un0re5zrG5yJZJOUswcQ8aL/DpROy+/Us6YGIlhBY5FvA2hhu4iNpsa+9w8TQfipnLk9X1hR/+SDLcvPZz2JpDg8pfjaHjIAqcnX+Y08chRC28uu+6wZzaks2Wxe51SvBFLEUpmVZFPfk1vl1FCg0617qVAvMUoUxnLN3QoAkwhc1xBEotLPbQ3kB8cu0eRngH2jGTD9tanOJ25eU7GGXR+H4yztG+ZGlZf+SZwFoib4Ag040ccmD2akv1mV6O4IcRz+lZx/6HTFltcTuH7Ux4ttndTsbwBNSc6HZtdZNgQ9Ywzbrgb0Gn7lnRtl09ffHFmMyBGudPT4DZSy1n9pg2vnURIJfDtV0Lu9+LbZzQ2jE/KGjUAG+wPV+3pljC1gtpAxuFBmzZGaMAaE/cILs5wsiO4daj6Jt2nGbynHotBdeuqyeZlLGNTLKWPdP11B3EgWuXCZkEhQue17W0fQl20OBgNZz4PqdIkqX0SrSY9Z8Y0l7aEwjDnRh5mJq24hzacWU+LkNbgN3MKecQVZzKr+EIiuW2JHL7L6PLmxgrJ5kw6V/6iWlX9MEOuXhZbfUo70+iHEmgAHCk/fHiwRX9CwUPYmmVdtc2oz0wv2douEXuIjogeARmCxb5WQMqSz/ropiW+/pDO8rQrg4qA+/aKC6+gpD1dvA+uplX/Ftu28JZ769Bwgim3V/jE+uPyKhKwJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(6506007)(6486002)(38070700005)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(33656002)(8936002)(41300700001)(2906002)(36756003)(91956017)(6916009)(76116006)(5660300002)(4326008)(66946007)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(186003)(86362001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NBs9KOwNOSosfniAWpoFhenHCD7NdqyuzEWIrcA1Yeh6vC1YILg0uZxku3cB?=
 =?us-ascii?Q?aE8Rowus+1TMjH4c1pf6fUvFS5LeOD2HjpYcoZXkuW25MHLpd/DxwUKUyGQ3?=
 =?us-ascii?Q?tcAOjDXzm4poD6vwXkbGjVDB/BfcrWI/3IDRPEesjF3maQ/BmNbd/yXZ1k7+?=
 =?us-ascii?Q?Rjfr3nSJRHPgkcj0sB3zXjAjrXmNzI0nEZJEFc5MprbtCZogjm/5P3xrSjQf?=
 =?us-ascii?Q?Ih+Nw3VaZ2tfJaBabyc7ZTy409dxkU878R75nMh82SQ22ueelovYPGtdmvEI?=
 =?us-ascii?Q?ix6azRuO0rJyJbnjCc2Skoh5BK7XHLzHWUcuh6wlgkK1WGX4d7+6WgnLDQ5k?=
 =?us-ascii?Q?TS1jW2JI49ojAWiZOkxTYjlNaAcRhd4eevAwmOxQcv0iuAcU02MTg41/lv+n?=
 =?us-ascii?Q?X4n0zp5kvxm1WRpEmXJKBkW1sbmCsqOmfhXti41FM6alddAkCRlhbowViyKq?=
 =?us-ascii?Q?YRiklNdNymntGLqp8nSVnxPc8EDeBfGqB8wwQHEag2TeITQy5azEJlt8wqPw?=
 =?us-ascii?Q?xawGkWcap3koJXAn+eWU+FhIDGzvZ/GvMZZ8nw9ea9m8daz+hvQXJPGVXHIh?=
 =?us-ascii?Q?kUJEzd6NEhEQb2NmhI/bdaPoYJ0Ay1wFPgLWlXHgjww3ZnQsWHiVilDBn/XP?=
 =?us-ascii?Q?tm8COqCwbv43Vn/OCGY0mQ26HPrOfnjBCTSpaoHN36E13MaGn+2hUWy/0YVd?=
 =?us-ascii?Q?J+0Las8OrAvgNRMjAyfPlarZYXqIYXIYGBwgYauYJ7nqcuKcne9bQuMxg9Fo?=
 =?us-ascii?Q?DZd9ybXgHE3QGA5BbAGMaiLxkSSWRBmNtYK+P9SI2s3heLr6g3bQAzo7i1WR?=
 =?us-ascii?Q?BVeZctAUmrPQh/TIEmXD2uxVJPMVV98w5q8YgpzqTbxLB+idbBCX2/bvH55B?=
 =?us-ascii?Q?xVT97+RevLBaS3ufBo4ms8bVB8wFwHVwRx9T2LI+Xpmhl/BeBo2aLKvGugR/?=
 =?us-ascii?Q?viUYa+4IRfLlJMDfLu4/9KxETnLPt0lNlku/oipOwCof9YqCntjvblb8rEWB?=
 =?us-ascii?Q?GStVS8dwI5NgWA4Tg19qmASePRxtbPmKmbgPkqLV7cHS1JYGzP5suZysPRbM?=
 =?us-ascii?Q?mWqbcpIjeFlSXfDhGkWNE/Oe17ke9tcZJObiwz5QGiKhWkqhSzLIGSam8LiQ?=
 =?us-ascii?Q?xQNiajowcbwBD6XByySmYXqUWnQC5c6p0boTYcNavLZki8NKDIWbwr7XevQH?=
 =?us-ascii?Q?VbYMW4/iPaVeGvSGXxCtkBnhLjKJ/0G6pWgfJMgT3jEvgeq1sziX95NP+mSR?=
 =?us-ascii?Q?9Br4yTF1sy0FUCuB0wN34Vf7P9fYmbOWH25TQCSSHVSL5Y33r/SQUMLjVuSN?=
 =?us-ascii?Q?DMvokNQmDJLlsuUHV7b2z3HhStBy9A178GvnCBuXykTM0S1F3UQKFjmFPsOS?=
 =?us-ascii?Q?m9/NGUwdh8rNnndVSnPNJxu7j/4M7NFAFxevWAv4VBM/Pg3Xcdb12bQ+CBvV?=
 =?us-ascii?Q?YKUEvPW6hBiDrM5ZronENWal3E7SzfjROFO4MTnGLTDp8woLKVYrzkNtsh3a?=
 =?us-ascii?Q?+fM+JHGZ5POAtoWJ2MBoejLOvqx0yStxdQ/wix2E/lYJmE/W7Xq26lhC8epD?=
 =?us-ascii?Q?O7A3uV1PqoM/1T+GGLk2L8gsifEjicoK3OSG169+s9pBJlixF0bix8xbGm9U?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D7D7C78724285409AAE392083455E3B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9211f9-d285-4eab-d368-08da55efed2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:43:39.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XRNxu5s/jntYXIq05D5f6KyY4qbPJ3lvvV2jwvWuGP9osC139nntfBEqlidAHGJ7JwcCgyYhBPAxGAK10XEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240057
X-Proofpoint-ORIG-GUID: 1Jt6NxIVcJxokht2eM1gzZNdEylL9ejX
X-Proofpoint-GUID: 1Jt6NxIVcJxokht2eM1gzZNdEylL9ejX
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
> fh_lock() and fh_unlock() are no longer used, so discard them.
> They are the only real users of ->fh_locked, so discard that too.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfsfh.c |    2 +-
> fs/nfsd/nfsfh.h |   48 ++++--------------------------------------------
> fs/nfsd/vfs.c   |    4 ----
> 3 files changed, 5 insertions(+), 49 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ae270e4f921f..a3dbe9f34c0e 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -548,7 +548,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp=
, struct dentry *dentry,
> 	if (ref_fh =3D=3D fhp)
> 		fh_put(ref_fh);
>=20
> -	if (fhp->fh_locked || fhp->fh_dentry) {
> +	if (fhp->fh_dentry) {
> 		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
> 		       dentry);
> 	}
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index c5061cdb1016..559912b1d794 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -81,7 +81,6 @@ typedef struct svc_fh {
> 	struct dentry *		fh_dentry;	/* validated dentry */
> 	struct svc_export *	fh_export;	/* export pointer */
>=20
> -	bool			fh_locked;	/* inode locked by us */
> 	bool			fh_want_write;	/* remount protection taken */
> 	bool			fh_no_wcc;	/* no wcc data needed */
> 	bool			fh_no_atomic_attr;
> @@ -93,7 +92,7 @@ typedef struct svc_fh {
> 	bool			fh_post_saved;	/* post-op attrs saved */
> 	bool			fh_pre_saved;	/* pre-op attrs saved */
>=20
> -	/* Pre-op attributes saved during fh_lock */
> +	/* Pre-op attributes saved when inode exclusively locked */
> 	__u64			fh_pre_size;	/* size before operation */
> 	struct timespec64	fh_pre_mtime;	/* mtime before oper */
> 	struct timespec64	fh_pre_ctime;	/* ctime before oper */
> @@ -103,7 +102,7 @@ typedef struct svc_fh {
> 	 */
> 	u64			fh_pre_change;
>=20
> -	/* Post-op attributes saved in fh_unlock */
> +	/* Post-op attributes saved in fh_fill_post_attrs() */
> 	struct kstat		fh_post_attr;	/* full attrs after operation */
> 	u64			fh_post_change; /* nfsv4 change; see above */
> } svc_fh;
> @@ -223,8 +222,8 @@ void	fh_put(struct svc_fh *);
> static __inline__ struct svc_fh *
> fh_copy(struct svc_fh *dst, struct svc_fh *src)
> {
> -	WARN_ON(src->fh_dentry || src->fh_locked);
> -		=09
> +	WARN_ON(src->fh_dentry);
> +
> 	*dst =3D *src;
> 	return dst;
> }
> @@ -323,43 +322,4 @@ static inline u64 nfsd4_change_attribute(struct ksta=
t *stat,
> extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
> extern void fh_fill_post_attrs(struct svc_fh *fhp);
>=20
> -static inline void
> -fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
> -{
> -	struct dentry	*dentry =3D fhp->fh_dentry;
> -	struct inode	*inode;
> -
> -	BUG_ON(!dentry);
> -
> -	if (fhp->fh_locked) {
> -		printk(KERN_WARNING "fh_lock: %pd2 already locked!\n",
> -			dentry);
> -		return;
> -	}
> -
> -	inode =3D d_inode(dentry);
> -	inode_lock_nested(inode, subclass);
> -	fh_fill_pre_attrs(fhp, true);
> -	fhp->fh_locked =3D true;
> -}
> -
> -static inline void
> -fh_lock(struct svc_fh *fhp)
> -{
> -	fh_lock_nested(fhp, I_MUTEX_NORMAL);
> -}
> -
> -/*
> - * Unlock a file handle/inode
> - */
> -static inline void
> -fh_unlock(struct svc_fh *fhp)
> -{
> -	if (fhp->fh_locked) {
> -		fh_fill_post_attrs(fhp);
> -		inode_unlock(d_inode(fhp->fh_dentry));
> -		fhp->fh_locked =3D false;
> -	}
> -}
> -
> #endif /* _LINUX_NFSD_NFSFH_H */
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f2f4868618bb..0e07b19a0289 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1623,14 +1623,11 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
> 		goto out;
> 	}
>=20
> -	/* cannot use fh_lock as we need deadlock protective ordering
> -	 * so do it by hand */
> 	trap =3D lock_rename_lookup_one(tdentry, fdentry, &ndentry, &odentry,
> 				      tname, tlen, fname, flen, 0, 0, &wq);
> 	host_err =3D PTR_ERR(trap);
> 	if (IS_ERR(trap))
> 		goto out_nfserr;
> -	ffhp->fh_locked =3D tfhp->fh_locked =3D true;
> 	fh_fill_pre_attrs(ffhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0)=
;
> 	fh_fill_pre_attrs(tfhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) =3D=3D 0)=
;
>=20
> @@ -1678,7 +1675,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
> 	}
>  out_unlock:
> 	unlock_rename_lookup(tdentry, fdentry, ndentry, odentry);
> -	ffhp->fh_locked =3D tfhp->fh_locked =3D false;
>  out_nfserr:
> 	err =3D nfserrno(host_err);
> 	fh_drop_write(ffhp);
>=20
>=20

--
Chuck Lever



