Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CA615468
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 22:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAVrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAVrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:47:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36B0101E0;
        Tue,  1 Nov 2022 14:47:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1LjGf9003350;
        Tue, 1 Nov 2022 21:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=LsHf4+HQMGjo6cO6VobfkCYtQsSAQ+fD2dads9KOjmc=;
 b=otcTyM/yjBke10+/XkWE4cKAsS/CZ7tjw+OYMtS+Uga9yB7RCcCg0Kzz1/Xyj2P6u+jL
 UrbOXvy9cvf+kJJ+LceKSGYkdR+OnEM2rkCLTxh1BaIIco1XN5kdHObnP3gWR+G63DcO
 1wjKH4EZJvn0xliZGmzhD7EO8uI19JORL2kh4RDjJtn0mmNXcM4QLcV4cPKGwi3kpErO
 F5jTE4mPj4olp7acDnP1KJ4ctNfGRA252zF7B9OPRTqqRPBm89sJdILl5N+ncDnOKCKW
 1L4bDrlimPD2BOuOqbFXle1xoRnM1gAGMBVrQkXPbGp+mSPgM8jhxZg5PHBICQ7aqPPE SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd7qmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:47:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KRFol002891;
        Tue, 1 Nov 2022 21:47:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmaxgc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3nLJZ9DUhDXP0PPI9UNv6dZEbzR1mMkIymj8cHcTIh968toRWUGUhy8Lk8SF8UmzNY1IlRqDDPYuarefYmNQKcl/FmlOmI5enBkYeNd4z90bxyUPCP/1AifsDVKLLT3DYIRmfkctPa13MKK8op9oOPGHnvDApvMlh0kb1Y50f+kvthde2nsueFxgnyDBW0Ehw0glLJrvevBqjPmedcPyoSzhWKAWE2iwxtgszeZ5yqMWuIfJp8GVP7qCkrZhrBPBUyVY76zWISox1iPGx9AOscTb3gbRVoCuiwYEBuE4ld+m4jm77/ucor2kzBWMOXtAvtQnlPk8ihhGXMxB1Iszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsHf4+HQMGjo6cO6VobfkCYtQsSAQ+fD2dads9KOjmc=;
 b=RD3k/keguw+00l51o9JBpGiVNLEAWRG0tWh+BCVJo9YdVTc9FYFGt/UZJ9EKuSB9O/UzxBh1x7za1FDHyZUj/di3rSrTo8Z1ll9G9N7LQN07y4qr0lG8+ilA8Jx3oI8nvb2EWaaGMLYmjS6JT/9cnvYpiKvkZGQ5vr8Hh1QxdKZaxQfTGOfdYybGEuNJXg2oSGBVLXQSMPOOsV+PPuX0YUDGXeid8dp92bIWt050Yy6R++1k5/zif58SiXNwVO8hY5hccAVO+3Ks25ed+QrTy7URpaEgxBzPg3m1gYIJCeThxYny0PW/moeDtGGr2n421CyG9b2LkYcISXC/G56I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsHf4+HQMGjo6cO6VobfkCYtQsSAQ+fD2dads9KOjmc=;
 b=V4DML/1tKb2Khf/EIBZdlfkd6yFJ1bZwk6nFN/TVe94ERTBvqu6yavDwfxFYoD9HFsBovoDRrTu5bhNXS6AERH09FFeYtOeRKYAFfnBz1T2qAgpIPjqsuwlfsrS0FEOBRRpSN8UslW2/pIFZASyOAQHm9gZiahgxH5PizHBAmH0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5241.namprd10.prod.outlook.com (2603:10b6:610:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 21:47:08 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 21:47:07 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
In-Reply-To: <Y0ikfeqm0ASZTR0g@ZenIV>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <Y0ikfeqm0ASZTR0g@ZenIV>
Date:   Tue, 01 Nov 2022 14:47:05 -0700
Message-ID: <871qqmgxeu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f70388-2d65-4413-9a26-08dabc529f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en1MEb20y9ylnICyLxLQZLdxWZwf2UhCTOpJUCBug/OEitNmvC92q2zkwdP0E+o6doOe+vA+TpyfEwnCLLhaRu3zTxO3PQcqImQ9KwtUkxNqYCH5y3u2Ne/Q2gN0fV2DsmHyrISzaRdqJF/r1rmurDJnBua8pbUwr290OaE7xIETRVy+UTdfcRgxB6rrekRlRyPYWls83dPTRTLU4SpccpEhcGmSLXpHYwndyyELHV1+94afA/hQ5F+yk6vgkXpBu6vX2n0qU9qu5g+K0wWJdo2QSF4y0EEG9LvR+Uv43tol4R2wDmsqRbGUDu5J1bAudnlF4DvFB5bLJlnU/UTsgOK5kHUatNDcH049mr68i0vx3vFPPtxqgoIVVgx7gyU7WbCIZY/pA63XkoGuZ3FChNtzODiERyUKJxXRcIN7vJ6aO5gxhf2p/l9/+jCYNyJfW4rRKMEiWAbJno8NfW5yI+E3tPF4ovxBy/+JGmYv1Z3u3C2CpQzfrZRhyT1+Lg5g/x9S7l/GQf1wd/udDDYQ3Q8dvyFLpdHzMdpOKduLIfeEDJyoSnKZ9H9XDhEbKidCL422nrSb0d/App2yIUC5DYyhPW5zq0ev9BpSpsKJhOngLeqomWj1ysYVKe/EUM4nPI1pych37dOWrbG/J6qmNYqdT1BLV2Ugwc32MZZECSz/VEH84ZDcyzud/FCUj27VPqt5ZAkrCOlfXvC0yMhijyHv55Hz4fQUq4nr6mBgvIb2QyMeMPIA1ReGTkr7xsQM3PD31OOqLv8OQMkvRVolyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(66899015)(66476007)(5660300002)(6486002)(966005)(478600001)(36756003)(66556008)(316002)(6916009)(54906003)(2906002)(66946007)(8936002)(41300700001)(6512007)(26005)(2616005)(6506007)(4326008)(8676002)(186003)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVzibjyJi3dqRZP/AHrnGn35+MCAgUWQRd+V/yO27erI8+j6st5WLRAjFTU3?=
 =?us-ascii?Q?6Q6epSLdkjTZupQRzi/Qy86dwL9CrQ/hg+UFpbGk2Prh4Sa0YRmOa9iY/kCR?=
 =?us-ascii?Q?Iby4fM06TNkDFxsUiRQyPBI9615bsLet2UqB39b2RtFquTLBundY10tyqxGV?=
 =?us-ascii?Q?oCLkhSnm7mLVOKSAh6L+n6xmrdV3ElIEcpl0qshp12cNeNoHraGE0BnDQWmE?=
 =?us-ascii?Q?Wye/c8S9Ail+Yo+ZwxUkDpEUHh9Twq1cWBb2dVby277tBzmTYP5ZvaMkACP6?=
 =?us-ascii?Q?fmpGN8QczOnsYIc31jYBun5brr6rgensiieSWFVRLxsV+h/cz6v3sCah2Koo?=
 =?us-ascii?Q?z737h2/X6OgULCqjkZjTL0pQ+oWKxKAWzvpbTXO1dmqJk525yAYO6EsE/MEf?=
 =?us-ascii?Q?eiOulAi1cjONdjsGLhsbQ4YizxJ9ndVe6Ym5J3ByHFHQgDrLx3XTctLEq/yY?=
 =?us-ascii?Q?lb9bm+DP9tjr6tJe5I1sbhB8bK7/kh8kBY7e+JmfyW4E3jGTZfeAU+XiToFi?=
 =?us-ascii?Q?95wkzEgDWq0GuEm7lNBuTrC8qGga4pkXNx8PRapUTJmBf3zr+Rwii3qrXYFT?=
 =?us-ascii?Q?KqgoL5ZCJlKsmclCu9z9/uxZyWaTiGWq5/x1aRiwAqIYOVIt0t6GSKjdi4Iw?=
 =?us-ascii?Q?uaompzvlYwSBcpfl2J07HHLeP8ZfGESrGDWZbzOXn8n5khlYPbhlts0k9QHd?=
 =?us-ascii?Q?cOMmPLfkhw1T0sVh0fXrbBlP3BJMF4hq/OnOcjN25wzAUhvNisopA5lo+lvj?=
 =?us-ascii?Q?oVzmZ2DB2QqyAgOmfBZukbGSHH9oTBryI4N9PoM8dLGdDX0TOXpJZoHR19Za?=
 =?us-ascii?Q?b2Yuy+p9Kf0SQ7JCSA+yVOB4cOk9nBFh8E77tOhy6tvTVXunSrpev+tJi+W4?=
 =?us-ascii?Q?s9PQ7i6QeZ9vDt3EcEYndiYOJvBsLElTRILblYS0GDwgiDk+WmAAotxDSx6R?=
 =?us-ascii?Q?bJPGJ4naV9ZldnZTwrC8E+NGDE3xT3HWmG5bGAqDNh2+Kq5LeAut2ZC3fJgL?=
 =?us-ascii?Q?rXwgR43ukn9uYk5XoIGEcAaDvXG/tA2q0+8GbJDsBJvPLTj9z/tj+61Z+WzZ?=
 =?us-ascii?Q?Gp0bSLHNa3Q/gINt29QVyibtFkqfJ1bIHdOhe7W/zQsAKIkchQkbXQLFOlkk?=
 =?us-ascii?Q?69v8nKncYXTJ6vWRe1QnBnhbG74bNCMHN/xF8Cu6A5BOfK3QHNm4VRL+TJyN?=
 =?us-ascii?Q?84qRRsxS9szNVdQ8+DKkuUal+5fJRSdmdc4Cw7JtB52uXHcbzLQeNE9B3jcO?=
 =?us-ascii?Q?vsmfi3+MTQSEQ7gPpGog6hkHmLF0CfWdsugt4IDFTDtRmMG4mynX3LpbaF8z?=
 =?us-ascii?Q?I++pcLGYcFHsfyo3qgaO4+9dSKH4uXN86J0zAu14BfGlrXKg+5OUacLY05DH?=
 =?us-ascii?Q?c7IMefev/Mcy2Ci/6y8nL/K4W7YZ4NzdS44re/9d8bxmrng9DWre9eIXntyV?=
 =?us-ascii?Q?XuzMCAXBG+1yekk5Q8rG2GvhEnxkIz0gzT14tSOLWUgN6YDs3VikQpJXMN2i?=
 =?us-ascii?Q?bA94zOIGiwvsHHcPtj8gi2LCiP/747f8G+e7dHyjAQcBRlFtBTX9L1ekI50L?=
 =?us-ascii?Q?6GZbQfd+VC+9azCAPVTeZ18K4YTbQPXdBaoRyKFSlYzfc4xBv/gw3R6YgcTz?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f70388-2d65-4413-9a26-08dabc529f86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 21:47:07.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6H5OFAEscotm9ES4sCDl0q24+UkuJCEXSCTsmHGiHekHsI6q13uoQwqQ3fINJXFRRZm27wWcLYbqCe9GrUuMy7bVpNDFzA1UqacTgh3fQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=777
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010149
X-Proofpoint-ORIG-GUID: BBohAMwJzTXdE77NrN5ooOkV94_lyOMt
X-Proofpoint-GUID: BBohAMwJzTXdE77NrN5ooOkV94_lyOMt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Thu, Oct 13, 2022 at 03:27:19PM -0700, Stephen Brennan wrote:
>
>> So I have two more narrowly scoped strategies to improve the situation. Both are
>> included in the hacky, awful patch below.
>> 
>> First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
>> is holding the spinlock for several seconds at a time. We can actually achieve
>> this via a cursor, the same way that simple_readdir() is implemented. I think
>> this might require moving the declaration of d_alloc_cursor() and maybe
>> exporting it. I had to #include fs/internal.h which is not ok.
>
> Er...  Won't that expose every filesystem to having to deal with cursors?
> Currently it's entirely up to the filesystem in question and I wouldn't
> be a dime on everyone being ready to cope with such surprises...

Hi Al,

I wanted to follow-up on this. Yeah, I didn't realize that this could
cause issues for some filesystems when I wrote it, since I hadn't
considered that rather few filesystems use dcache_readdir(), and so most
aren't prepared to encounter a cursor. Thanks for that catch.

I think I came up with a better solution, which you can see in context
in v3 [1]. The only change I have from the posting there is to eliminate
the unnecssary "child->d_parent != parent" check. So the new idea is to
take a reference to the current child and then go to sleep. That alone
should be enough to prevent dentry_kill() from removing the child from
its parent's list. However, it wouldn't prevent d_move() from moving it
to a new list, nor would it prevent it from moving along the list if it
were a cursor. However, in this situation, we also hold the parent
i_rwsem in write mode, which means that no concurrent rename or readdir
can happen. You can see my full analysis here [2]. So here's the new
approach, if you can call out anything I've missod or confirm that it's
sound, I'd really appreciate it!


/* Must be called with inode->i_rwsem in held in write mode */
static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
{
	struct dentry *child, *alias, *last_ref = NULL;
	alias = d_find_any_alias(inode);

	/*
	 * These lists can get very long, so we may need to sleep during
	 * iteration. Normally this would be impossible without a cursor,
	 * but since we have the inode locked exclusive, we're guaranteed
	 * that the directory won't be modified, so whichever dentry we
	 * pick to sleep on won't get moved.
	 */
	spin_lock(&alias->d_lock);
	list_for_each_entry(child, &alias->d_subdirs, d_child) {
		if (need_resched()) {
			/*
			 * We need to hold a reference while we sleep. But when
			 * we wake, dput() could free the dentry, invalidating
			 * the list pointers. We can't look at the list pointers
			 * until we re-lock the parent, and we can't dput() once
			 * we have the parent locked. So the solution is to hold
			 * onto our reference and free it the *next* time we drop
			 * alias->d_lock: either at the end of the function, or
			 * at the time of the next sleep.
			 */
			dget(child);
			spin_unlock(&alias->d_lock);
			dput(last_ref);
			last_ref = child;
			cond_resched();
			spin_lock(&alias->d_lock);
		}

		if (!child->d_inode)
			continue;

		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
		if (watched)
			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
		else
			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
		spin_unlock(&child->d_lock);
	}
	spin_unlock(&alias->d_lock);
	dput(last_ref);
	dput(alias);
	return watched;
}

Thanks,
Stephen

[1]: https://lore.kernel.org/linux-fsdevel/20221028001016.332663-4-stephen.s.brennan@oracle.com/
[2]: https://lore.kernel.org/linux-fsdevel/874jvigye9.fsf@oracle.com/
