Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E832618312
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiKCPmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKCPmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:42:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126613E3C;
        Thu,  3 Nov 2022 08:42:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FY0a9007655;
        Thu, 3 Nov 2022 15:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fxAU+KO3uMconJE/g3g8kkRVxAdEZwYV0zGrp5YbguE=;
 b=BXvZbIcLHYpEZ/pbSKvN/rsbku3WZw4aEQuJNLsdvYYUgrTSl1iDQAseACkLWysTOJaK
 oc+x+zu2F0byDQLN1zVl+MpPC6/uTblFkHB0pBNVg0/I2PYgZAFabatcSc7xAXvKJlLT
 iCAwsWZTF/0Zc8nNfFq5ksIvn04yA+X2okRhfG0wnW6TC4sBK5PH+LTB0/zyGigw9OHu
 uj3kqoIYUtpBYLBk23+SGH/92jKk+SuBnytBhvWiY2Ngb0LyYurvP7rn0Tl3qHoDo/Rq
 Xwg1A7F/rD6PIZt+sRPhio37nyrPi34lZcoXdhJBoPwaTfU+nsZToXCVLXa34klrhrtI +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2an43x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EoF6h029711;
        Thu, 3 Nov 2022 15:42:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6rde6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9E2IpiyZ725xisJSJwToP1Enj5yiHhRsdSQDIJmAPrp+2NL2oGnKfD0d3VY9YLfl96CL82ayT2ktMBIlMtc15/ZJ9XdfibUyPrybAn+ZSsIcQ1mfe3tpK/WADMgA7WNA3yufNnCN89SOgUC8VpWRLxaunriUd+U6v1/uHBZ8ORvFP88/Z0PG2BHugziZ3I8voQW7Qfb7sXw9mLuQ6msy19c+DT5HaGRry1p3E6IMmM1tc1FRmeDmrej+F9YCk2Xbdd253HP7Mwy+9Tw8XotY1iuGxo2pWSTVOBstAvnNX8QR/DwKiOjA+LHqJM00RJ2RKBOt4dqpDa1S2AdR2u5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxAU+KO3uMconJE/g3g8kkRVxAdEZwYV0zGrp5YbguE=;
 b=CsM40I7EsBbpneA3G/rUNzrjssObKRC9X6RnCmQ5ILQ5nzHXwLMkQPQ50N+zBgzmdgz68Qt07bo1V8sKswT8ioHMLBFdhwuYqNIyXX8JawDJlBRqJ2skNvfFszAhWTFB+Z+WJGmhC4BSxYoRrr6i1zMxpW5PGbgBfM+2Tq4ZpBwAq/R9bbDtQ/y5ctkiFc0ZPPJIO6UZs1JUt03mWVgxemaX3GHHy2NV84Vca3XMcxLmzybWdimfYyA4/u1bFElIKxfcq43zvfbi7me3hRF8OvrcVTxfIBNTfJre648ffjbcgy38Waf4NUBP96QOoKRUBUxHpimuY2hTuturNFPwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxAU+KO3uMconJE/g3g8kkRVxAdEZwYV0zGrp5YbguE=;
 b=eVHdWE02IN08zKKrutk4Rv4Fxb6BQAhkR4KhtybrZ34lAyHPlVseQDAQhDUDragedM+PNcgQ2CpTPs/nqguuuLYtjWyclz4+f4hYS7/zjoqZUIVCQKprAlLesXme1XPSa/hFQ4hpgzp199tzq4UckpqUljv5/EWB+TffTtVA3rc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 15:42:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 15:42:16 +0000
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
        LKML <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 6/9] nfsd: move nfsd4_change_attribute to nfsfh.c
Thread-Topic: [PATCH v7 6/9] nfsd: move nfsd4_change_attribute to nfsfh.c
Thread-Index: AQHY4hdBdnRn2o/trUW2gl8SzYdhC64tcYOA
Date:   Thu, 3 Nov 2022 15:42:15 +0000
Message-ID: <732CF94B-CB0C-44E4-8292-F5E248B6560F@oracle.com>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-7-jlayton@kernel.org>
In-Reply-To: <20221017105709.10830-7-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6144:EE_
x-ms-office365-filtering-correlation-id: 54de6bc9-6d90-4e5f-3f0e-08dabdb1fbf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LfD6AAbXsA3eHvVrFOjfc/vhoQ0ex/Pyz6389jHS9kDLz1F23e3jp35P59Bg1BEWCBzJigQE8eQm06uXubhdepUpE+ajCYvFvd+cTLr8UzMRLiLBaljUyNuj8Xux3PLDPjRJABRDiea3z0AoitIeIT2vkNXpTixrvHJlKkOljomWNNMkW5DuBE92EwIb30Z8B+XJ57POE/JNdUSp5LdSTkHQdbTfesI2L79EFffKn+0wYCvgZqRhtAcd34uwhVpackKnykhqMBXX1/Kh3NeKe7MZxVFy+5eFlnplbmnPTzXRxMcq/0bFdx0RgkovBPm6EBfvj5/BiiGYNJEznphZfZjLfKCDsYv5gQx8pBjdTy/+8apnHMPHHHk1sjmi1E/TqPgFegTmm8YO9ienmoXG8lSouCf806ACEuMsZOZmoj6R77cd+k4cK23W02fYtyNs8fx0z85/cbjmeDucpnu1VYDC1OZ/iC28v4VckD64llv3ubM2Hes6qLeZozUxU7MBO+5qxfOuJs0sZxRk2NAS4P6QuCveEFX5INZk5bw6Dpj4b3d1l3opXo1fgRwLooCS36DEmk+8+GGv0KxmB6DQrwjASzoanJQ5R3Du5gC+DC6QeisxGSnbFfTCX2E7ZvxlN+48NKoi/TrI/mkYIUdNgqyjGZb3XWMrQ0WKPP/U6DNMayPO41M8diwsgxQSBpxsGOshuWJygOYavllvIxDHbbeCvbB52GlGDqd/kQYawqGUhZsj1mMUOFYbmdQ8POMJCySf0nYDBfCMbz/cfv0dbwGECL9kYBp03kkGjqB0i84Dh8AZyXpkYoC4cZxEUeOEDcYlYh83jUxXE6GHbi5Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(6916009)(2906002)(38070700005)(66476007)(7416002)(71200400001)(41300700001)(76116006)(91956017)(6506007)(6486002)(8936002)(66946007)(33656002)(86362001)(5660300002)(53546011)(66556008)(36756003)(8676002)(38100700002)(2616005)(478600001)(54906003)(6512007)(64756008)(26005)(122000001)(186003)(83380400001)(66446008)(316002)(4326008)(60764002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?abGmgR/UEV90rqSmOspPe8qmNAkahamH+nH6Z9RlT6xmfyi3q8VOqIyk41da?=
 =?us-ascii?Q?+5LceHyToz9k+stVZpkpbwDihwcYPiqGNImSJlaOrxzfo6xBxFY8L7kvPWjj?=
 =?us-ascii?Q?0wzqLMJPRCnrF9xAaWjeJpXJt34XS/cGrFQatoIiGhQLBu+b8yn8HHY5+0c+?=
 =?us-ascii?Q?RAuYWo8+DIPTskyOpPh/cYE6pcOM17uDCUE5z8ay19+PXMs5uGMwpH4NpMAv?=
 =?us-ascii?Q?ybxB6y9P8QeB5IjDCPY3ZOXbjIEGCgNlQZSXyiRYPApTZSfU8lWKv0SwvOHI?=
 =?us-ascii?Q?8kLwPHNTYBFhSfWetFNveIMYCuYRPUVSaxIdJG87rwqx5aEbOAB4HPVif/4T?=
 =?us-ascii?Q?UO91IWtYoK/Yei/feMBRWz0QsxCByR33HllxtSOCB/MZg0K9vS9tNNTq1+6U?=
 =?us-ascii?Q?NU559ssC5iIy9iNTpzjQujO0FXYE+ovKXsQZT52K651BUdNRxm7v9Q9yM97K?=
 =?us-ascii?Q?JX7dS88aICVEk9Eba0zPBNa6pAHT/Lur0Tmj7k3l7sY+PWLzh8BDMqE8x8io?=
 =?us-ascii?Q?REXh+UrIgxEE7FMskFQyeU1a84PrZe+631D/KYPdefBSgaI2HVpqVIMB24It?=
 =?us-ascii?Q?JqR5I1hzM3TVito5m6cNohib44G5IRCIKJCw7U5WZ6jkexDCe+c+6pTKvDZJ?=
 =?us-ascii?Q?olGCoPVJ3ozKLFfxYSdrm+YmSX4ihTZEJ7yL0ICEHuO4KLjOPYAgDYdM8Ytq?=
 =?us-ascii?Q?IKgG7CTgPdijPnl9vNiMFiZ0txU5+rBbfigYI05vL1fYGAq3l2q5cHPBlv8a?=
 =?us-ascii?Q?IYn83fleloVKxgTI7sjwoy0NFYTM18ZMTQR925N1/BBKg2vaHD1GAJV7DAMR?=
 =?us-ascii?Q?BzxEzlahMZTmVlz+axQvfQjyJ24We4ck91zeh7hHsmckqzWo5Qyy3Tv+Zmy6?=
 =?us-ascii?Q?o6gR6nXOieKFzkThFmk45mtBCo+VC4TeT92P50xbnyp8FpqAzmm3NCNuSc+s?=
 =?us-ascii?Q?Q8XnMvuei7bvlNPfkQ1mOW2LxpORjCq5AsL5Ur1Kn9KkaU0+31v9pFsAE2x2?=
 =?us-ascii?Q?YvmjNAdpI5ojWVnd0gY0oeppYhd6HhCP8vJj1xeZRv9ACLJXvrvl/169GC5R?=
 =?us-ascii?Q?hLnVDXL9A4pTULvdYhL4b7CnqtjVBjTACsuihZYk2nmXkdWd3UazRXtyqbtm?=
 =?us-ascii?Q?c5eyd/OlZaLVuHaQvOju5SuOhwFlW1HwIMXglXZD31VgaSCJ7AnmZ3YldnFW?=
 =?us-ascii?Q?102ZHuX0cmJrPkHTJGPcdOoCpefsbF1YedjoHCq3sdp4PZ6+rL1XPJSwB/3h?=
 =?us-ascii?Q?WUXKqMMjevVmcKdZZ2RsLtjAQXKw8aQFmbjgb4y8fYVlv0GI4sE90m3fpoGo?=
 =?us-ascii?Q?RY6C5ww/FxAQIEUERQ1vKbqswzzoQbHkgsTfEQV7ZmGpRDJOULMqAyTxcvv9?=
 =?us-ascii?Q?U5nQ9+8kYjvYXul8R+v8slUcf0ZJH9TUnGAXnOF0me8T1nTFrdLQmasw34S2?=
 =?us-ascii?Q?IgrFJK1zrbJZRpOO4tXEyqHFmzAhfrrR8q7spgbC6mbZk1FPaKmmYhAMmAGO?=
 =?us-ascii?Q?GtLi+79fHrGk/gsK2CCUC98P/CJifIxE0bhdGGqscCMfHYZQuQZErArsRtvh?=
 =?us-ascii?Q?SFEQ1R7CCUwrsPCyjWAPFMptmh/Fcjx9lWiHdKLo8P4DxMDAdOUQ+MJQ8673?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F01F2D9B0B0D4344BFEED4B60804205A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54de6bc9-6d90-4e5f-3f0e-08dabdb1fbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:42:15.9932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/hhV4nPXgNDBLv8lfAqgq3RvxeAFNYwn3qDAU7EhFjPcK5EyoCwK0fNpn0aaaS12iDh1jzvh8bRYDn2q0eAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030104
X-Proofpoint-ORIG-GUID: 9b5jv_YYu7nUuywBYPAT5lf6mS8X43Dk
X-Proofpoint-GUID: 9b5jv_YYu7nUuywBYPAT5lf6mS8X43Dk
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
> This is a pretty big function for inlining. Move it to being
> non-inlined.
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfsfh.c | 27 +++++++++++++++++++++++++++
> fs/nfsd/nfsfh.h | 29 +----------------------------
> 2 files changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index d73434200df9..7030d9209903 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -748,3 +748,30 @@ enum fsid_source fsid_source(const struct svc_fh *fh=
p)
> 		return FSIDSOURCE_UUID;
> 	return FSIDSOURCE_DEV;
> }
> +
> +/*
> + * We could use i_version alone as the change attribute.  However,
> + * i_version can go backwards after a reboot.  On its own that doesn't
> + * necessarily cause a problem, but if i_version goes backwards and then
> + * is incremented again it could reuse a value that was previously used
> + * before boot, and a client who queried the two values might
> + * incorrectly assume nothing changed.
> + *
> + * By using both ctime and the i_version counter we guarantee that as
> + * long as time doesn't go backwards we never reuse an old value.
> + */
> +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
> +{
> +	if (inode->i_sb->s_export_op->fetch_iversion)
> +		return inode->i_sb->s_export_op->fetch_iversion(inode);
> +	else if (IS_I_VERSION(inode)) {
> +		u64 chattr;
> +
> +		chattr =3D  stat->ctime.tv_sec;
> +		chattr <<=3D 30;
> +		chattr +=3D stat->ctime.tv_nsec;
> +		chattr +=3D inode_query_iversion(inode);
> +		return chattr;
> +	} else
> +		return time_to_chattr(&stat->ctime);
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
> --=20
> 2.37.3
>=20

--
Chuck Lever



