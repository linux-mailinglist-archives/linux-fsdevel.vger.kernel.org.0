Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F5E4DC98E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiCQPFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiCQPFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:05:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEEF1E92;
        Thu, 17 Mar 2022 08:04:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HDPNsN007230;
        Thu, 17 Mar 2022 15:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ik64H/ecLTE4CYkQ6DSm+05VOBZHhQGOvFPGVzFf8oc=;
 b=L4EfaKQoFuXjhN9XaRsiTFyDITi3rML42qVL1EFHDtMo0/zmtfkZDjm0BcjLiC+6KE1p
 6l6JV/GUR70v+2MDKqqQM9RPnU/1XpwNoB6MIAFHDPA+t94wIfPYP54nwoGb5PbhASxC
 TmyW1GMpvVqJvW6P+R9p8z8o2AZecoSizSxxE7CUv1DxbfCPRrkh/Ip0UARP3GtMDsh9
 ysoGcW57+/HU3KftrlEj4+EFFH6Y1o1Fq39vrqr5pXl/0AtfOuxIGEI/QJ5+upON7dgQ
 h1NYTFTPGcqYkj2FZNIDsmZsvLgUtcRFKl0m3FyJqWDBQuGy3fj0H+6JhjRZz58JdwKc Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rhach-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:04:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HEu7IF170902;
        Thu, 17 Mar 2022 15:04:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3et64mb3gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP4Nto3pgApRsuR2+35f4gSMkVaI8LqEEoRv5CsAihK/eUo7nvtKN2WF6mRen+CeKoB2mTPQFgtvD+9VrtU8v/EjoUouqJPt1PUpi7Wqnldws5/prYfGcZfrW/Wev4yoVlaWAqljhgdp4MgDNZKxe+QxTUL6BqU3I7gfq9CNVWVRgHzsbEd8HZRUE8ofcXYmW6h0Ci6a0wi2d3Q+0vPYGXr79lIxntc/w7uC+Mbe+XmZ3LKr8eO7Ql5YnTln9Z3ZkWBhYPNpm4FIeDUvPI9IMQtwd8xWVvnIiIyBviRLkydWmJNO2QgZGQsOW/KD5Q+R6y40D9cV6CZNIB+91BLUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik64H/ecLTE4CYkQ6DSm+05VOBZHhQGOvFPGVzFf8oc=;
 b=HUr9DGpHKZm67d/MJZboCMrcYx1ZABsBHJPJBskdzzcpY/oU+rQ59bytCVIPk7gDWpJIwk8guLqy3rUfWBqnIL9tVsP853OeIxctWiil03QZduMH/WCtqcbxLuwpbhZkRmUbO/t4r5+1SYlCA7WqsXEr2YEk7Y8Z+5KL/9uPgcqL9/2gJ9CCaCDMk+30dOQz7K3x5q5FvV8zIriSPhzwa6+IgpWIal+u/AF8qSrEBXsTYaJ6pPV5AWkuUGaC8j0FSRAwGA+3b0tEgvvDfzzYnpZrhu9nqIhnE/VHKt3oEqbiEHxigSp2OnflWElpEw2U2lJpm6Z8GBNSoHavnaSytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik64H/ecLTE4CYkQ6DSm+05VOBZHhQGOvFPGVzFf8oc=;
 b=UgJj14b9FmpPsuwLNH7ZadtR9DHLcVMc3KTxRar69tjhC8tVZET9UgmB6S42RGQ0wEQe2zH1xrFpj+yBelUeFEzU57DSzGJRDdMOtU4+TdSt13wwQkY4n4sfH9BUMok7u5Ro+UPe22pL8S56KdHfdbM59TxlDeTiPe58lAlVbaU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 15:04:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 15:04:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>, Dai Ngo <dai.ngo@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v17 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Topic: [PATCH RFC v17 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Index: AQHYOdLAmpfjykEdNkWH0VGWaQHNA6zDrNMA
Date:   Thu, 17 Mar 2022 15:04:02 +0000
Message-ID: <3273032A-27F8-4F80-AFAC-45A4F29B45D4@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1647503028-11966-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c01756e8-beb0-4670-2422-08da08275f7e
x-ms-traffictypediagnostic: CO1PR10MB4513:EE_
x-microsoft-antispam-prvs: <CO1PR10MB451328562A26120F6DED5EDD93129@CO1PR10MB4513.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLiwrYxZMPbISUImcBQQQ8LLL8mMJd0AAwHW6dOGGl5cn37ftnEoqi90P86FzDmNg3i+bSFQ9V4on6TJHQKS1X7DdfP+Fg0w30w9fhjdoRcOdsz8+ECx3slle0w2iHaNS5FR+sB96mL9RaOSpWA+WrYXaolGw/PS5Kwjjn1dyFiwhCrqCcPmyfIEWJo2kjfRJihAxqdTJebaEKZ1JvWUaJZtZA8Hi1ndHTCQV8OXJdT5xou+n06pXgta+QZVRV8zt6M+S8yFtrVnSt5tMEbjdVh9pX6nVqNpfuInGpsvbfpoNyTiKh1biwbiNdG3i/lwRHD2S7VTF0IzyeowmyBt35uZfVMVdHV5gDqF3wFQZkSws3jm8rpijisnlycSC/ZTzp2QecQ6//yIUpYcgOYaWZ3UKUO5ZUIDGToC21KLRvdWvpjCK9+gbatR22TFVAy6JNJPLnqQiUMNvP+AY0gnhie0J1ZO7x6zjux8NpFQfKniND+4A8qpFFNWoa0lJ6EacDyEYKOrR0kcVj0LVQ8PrBY+PVYjefYb2rLj219F+o0nsak7MpWt4TQt/WUvFU8FI8Q+zRmsZihVwwsvVWZj7XfNzHW3TMutngHLG5/sKMimsygsuuL4b0S72FVgwjGEPQrJCl80BKfUhy4NXlye9h0kFKw5rGhDwCRYwmh/CGDLoqGYiupOo6qYhiLxWbtpYku+vaw/aRwxHdRCgj3gAq3K58ykHG+oKWvaDI6rB38Xa8FPvjSnB1vp0ezPy4n/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(83380400001)(71200400001)(53546011)(2616005)(33656002)(6512007)(6506007)(38070700005)(8936002)(38100700002)(5660300002)(86362001)(6486002)(91956017)(66946007)(66556008)(8676002)(76116006)(508600001)(4326008)(66446008)(66476007)(64756008)(26005)(186003)(122000001)(316002)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/JuVRpuBaOdvWnWqDyjeYQ73ktvjw60pe/QtXhdDTnqe2nManexILyXQjzE?=
 =?us-ascii?Q?HR1pVeIMH3Dg5hUTCFcAzKEiQVw4YlEOLpqVLB90z38JBakhihFe/kbkuwMS?=
 =?us-ascii?Q?XXlPR+z5b9InWCieMoRWNSg8i3kgUr3Ig33gkYPDo+DC27xN6nJLKDrDIELe?=
 =?us-ascii?Q?mip66cpFLhzUW+iv7Uvs0VTZZy1ugQnLsaxlWpjcaDhJCV2/wXPWRJAHuHsp?=
 =?us-ascii?Q?d1kLwQm+LBlh+54G+0bk9/z26a1xbodei9r2MInjNqIilnwOhOBLC4ImU3Oo?=
 =?us-ascii?Q?Hx1NhzDPnldNjIsjHRVpM09reh1/M+qtdowKN8rwXD/bQmPHR/N2wDZ84Bp2?=
 =?us-ascii?Q?dXAG75nfGgsU0vH7VtELKPYvwVCB2VgdV+WlyImwry6rccukcnZ4O4Kr/mJa?=
 =?us-ascii?Q?RqoPEXesb2ZzgStziCpX4uKMKSQXxx2slbtZAmxcwUVavxqOfHcVqBdgz0yi?=
 =?us-ascii?Q?H/aBerAoJS4rpYQ9V680YDNWZSGEXzy4FlnjgcwlN5YeJmGtQxbrytPjU13d?=
 =?us-ascii?Q?NGZ7bZ8f+nffZvC/2S8a012AC4pf8gjfKhnHfTSr3SND1S3DEzL3paBeVR9J?=
 =?us-ascii?Q?biU+Ub4xII81hNErAGXXsKcwB4anKNcQsJDLieP8W7E6R9q3s5l+RyYThBHc?=
 =?us-ascii?Q?NGtfJxHq0gYntEYulGKjKqEwRd4Ktq92RxEoW1YEl71uHeGKrkai/atJ9Im+?=
 =?us-ascii?Q?BVnKy+DFW8V78eHgoQbjv3M+/gc9JEs2+DksxfRHbnwJgU2i0Asceiip2dxG?=
 =?us-ascii?Q?KQQPhdDuASN+5eGOV8VWiPJkQjMQtRhdCH1h9nWg23a1bKJZ4PaS1DFvV8L4?=
 =?us-ascii?Q?DfbKibMbgFW3L5ApyrMssTF5G3BfZu0hyxOOqyVf/BrspmaciwXlRTEVLi+V?=
 =?us-ascii?Q?B84sZ5Jvb0i4S8kQ3Z4FbvuOhYJ8JsLyf4TKJLpaOFZQzelb/t4hWMIt6Iql?=
 =?us-ascii?Q?/oWarOiS/OBg1j6IerTfZ8mfgRNTokO+rtUMUSfAbYeWOf0vgtudCCWNzj4c?=
 =?us-ascii?Q?/rObejFyk6a4IcG34y8eAv5XZOcmukWQbL5Rs7q5yQasZKecJgeCX+CwZD3N?=
 =?us-ascii?Q?F0j1oms3C8Gweb72ExmSvEs2KP2US3Ibf5JauVc1CtylW4GMbFT1gklrCJhh?=
 =?us-ascii?Q?ezMkggJ6V8LS2Ylfslkrf8HOJHrwFrXJg7sPMy/39rufT+MC1ick7KZeM+8W?=
 =?us-ascii?Q?P81McFyF4UtSFb8nCG+dkEeUbw4BiTPdAjdz2xF9X3uSEAA+P5q2kZlWm8Um?=
 =?us-ascii?Q?u5gF7DWzwZgzpGAdKVZKYvBS00VmabnHQcwLvuZ96dsC0UxELDZB9ld2RHYp?=
 =?us-ascii?Q?RvVVMb+lYMnU26egnEs6dMB34sC9aCDXNzjZChsEEotPt5IpWpqAkzxNPNy+?=
 =?us-ascii?Q?jRdnQd5uo1iwb9YiHFwB6UX5D88AvI32u0Ru8r4XX3lt60mwKYCiB9W9qp+S?=
 =?us-ascii?Q?4uzcNEMSzIiIAs827HU4ccHwMXukZPiaYl4AUIYTyrz2O6Yb43N/cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5A13FC569DA6E47BA5E8A20FE01C378@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01756e8-beb0-4670-2422-08da08275f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 15:04:02.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUDgmjNCLrA+yDsCRcOdJqwb8IkVDgXdPq12WDhcnGRSXir5K7Kf9jrf5bl74994bqkEc2fNeWOO+F+za/AqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170088
X-Proofpoint-GUID: 8U5xwNo0LJnd89qAitcNDYzvAiLhvl9K
X-Proofpoint-ORIG-GUID: 8U5xwNo0LJnd89qAitcNDYzvAiLhvl9K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Mar 17, 2022, at 3:43 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Hi Jeff, can we get an R-b or Acked from you for this one?


> ---
> fs/locks.c         | 28 ++++++++++++++++++++++++++++
> include/linux/fs.h |  7 +++++++
> 2 files changed, 35 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 050acf8b5110..53864eb99dc5 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
> }
> EXPORT_SYMBOL_GPL(locks_release_private);
>=20
> +/**
> + * locks_owner_has_blockers - Check for blocking lock requests
> + * @flctx: file lock context
> + * @owner: lock owner
> + *
> + * Return values:
> + *   %true: @owner has at least one blocker
> + *   %false: @owner has no blockers
> + */
> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +		fl_owner_t owner)
> +{
> +	struct file_lock *fl;
> +
> +	spin_lock(&flctx->flc_lock);
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		if (fl->fl_owner !=3D owner)
> +			continue;
> +		if (!list_empty(&fl->fl_blocked_requests)) {
> +			spin_unlock(&flctx->flc_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&flctx->flc_lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
> +
> /* Free a lock which is not in use. */
> void locks_free_lock(struct file_lock *fl)
> {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 831b20430d6e..2057a9df790f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifi=
er_block *);
> struct files_struct;
> extern void show_fd_locks(struct seq_file *f,
> 			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
> #else /* !CONFIG_FILE_LOCKING */
> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> 			      struct flock __user *user)
> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *f=
l, int arg,
> struct files_struct;
> static inline void show_fd_locks(struct seq_file *f,
> 			struct file *filp, struct files_struct *files) {}
> +static inline bool locks_owner_has_blockers(struct file_lock_context *fl=
ctx,
> +			fl_owner_t owner)
> +{
> +	return false;
> +}
> #endif /* !CONFIG_FILE_LOCKING */
>=20
> static inline struct inode *file_inode(const struct file *f)
> --=20
> 2.9.5
>=20

--
Chuck Lever



