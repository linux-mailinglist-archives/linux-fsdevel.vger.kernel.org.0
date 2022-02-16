Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1166F4B7DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 03:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiBPCZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 21:25:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiBPCZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:25:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADBD5DDC;
        Tue, 15 Feb 2022 18:25:13 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FNJDVh003066;
        Wed, 16 Feb 2022 02:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=zqkVjp6UB6/qnQ3lZMsbL9o7Thw5QgPye+w46YLdq78=;
 b=ucw+aPxCkBnTVVMFdcl0Nh5EbAJCUi6AolZtjD3apBNEF3Kkx68IyFGtoOqgJbxl6686
 ZUkAE67aEQcL5APj5VJBh2wbT0iWmeCj4cujNJLrlAOg0hRKurnZAwiMmAu3awKpLviy
 OPNo7nQXyvWqVL5m/PpedwOQILbDs8hn/+8DWi7K4EoAuWOgWgSIqLgwuj88AT0aA3dF
 nt16OZWIVkvmZYrGOLn2E9hOFazjUx6tIzaT/eOJ+BDq+evRHs5RID018H+fKMxxoSOO
 tgNhp/VundYJVDA2HLZ1GcVszxslQsjueR8CnwiNhTVcfTghkls8oQBMCSwCktwywg80 fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9084a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 02:25:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21G2LSaE026864;
        Wed, 16 Feb 2022 02:24:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3e8nkxjprt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 02:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ext6eU2MHtRDsjQ1ucQt/GY2zXCPupt0Hu4NzU5QYvlBteW0nBwxQlSUAHw4nNdM5L50EVzhSfA5aFWtAgb67lhg5KGci789f+mASjtmYB/jg9vCtYeiKVhWHhX4nAo1UWRf8r4+h1FnNA9rdQw6r12S+dnhOhy//8ocHGSVvYXyWe+geUIpdhcyccYJoIl4QL8M28/ErKqDWWGNaahR3fu2CWddKqcSOJ1xh/n9kqrNWO7jX/tQbOiH5MqzNz2cbWOneuKQpB6FF65WlqxZ0xN7gr6CRRuNaKVLcmwZSmlOT9E8oDD8iNnybg1g+MzSNnFV90d+p6Fsx/Sy4sVe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqkVjp6UB6/qnQ3lZMsbL9o7Thw5QgPye+w46YLdq78=;
 b=SmRlADDrB7IROrS9XIL/ExYQW4e2IdRvckxnpi3X1LgX+f3vrOhS/00cT8jAQ21WUP5ujxVA3uZ+0ALJYpLU4QA4gzBpBESQtPoHR8pXoq0CRoIwYbLi0nMiKTY3LY5wMdVGc0h5SOVX744YhvgGyha5XwNkRmUpx8KgQSxR4oWpq8Wr/ak4SRxDPNwDFgu/fBlPo2um90pUZgQSMyk2P0SBCfgE2pvMbxLn8fgByPk+UyGz+24wEe2B6H9zYYGI/PDOMwqIYYOrAKzicEraDTtJBHMlq66pvsUcLX11GlG736QB1NsvepOkXivX+GSyw8i7aLcggQ3Kt4778jtBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqkVjp6UB6/qnQ3lZMsbL9o7Thw5QgPye+w46YLdq78=;
 b=m3c8dd5ZPQFzsz42dtIa52wpYdr56rUOaFcBPt+YlOU4GRrls53I6Skr7jsmw0qPR3GmE0jkJLGTUkKLp0s0kNBod8hs8B+DgeFQCLKzGAjbxK7R8mFAdPHjdetNrds5McDVdd+C+7jXQXGi/CndUK+sCgNByNNvZJu+a+MmfxM=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 02:24:57 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 02:24:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 1/4] dcache: sweep cached negative dentries to the
 end of list of siblings
In-Reply-To: <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
 <20220209231406.187668-2-stephen.s.brennan@oracle.com>
 <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
Date:   Tue, 15 Feb 2022 18:24:53 -0800
Message-ID: <875ypf8s5m.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93b8d60c-345b-4e5a-d7b9-08d9f0f3862b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB134112A21ACE71C9E24E59FDDB359@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcgWYwhJ9Rb0dgxCsl25xRgdKhEQmwBgNerfPiToAzJs2VNNNrrSUqlzLqEi4nPodWqJ63SRpMeJMHeifcNxjsWS6NUFO6yqlwdtiRKrww/wiRgCsTAzgmc2oW2UjI6thrJjFc9Akce1ed3h8+thutDFMv+tMiSfSE8f2fovW9/B6xHUiUHe0xvSo3eVZCLRFE3Du38eoDdsMqp2g9JNZ/3eyiW2JifxiSnqp2Wl23vtudrfrq0KNWrsjwkiRKf2ODliAenhELiaFC8etHUKXyeV5f6FAVj05rpInkw1qaG1QBZBbUXUcpehiyG4UEhVAxS/Q0MeU9fuX9PY///6hzSEbBP8NX6lNs6Rs6gXsWQlFeJOKNt6cs4nU43uuViRH7M0cmLwVIBQVDV8JZboR+aYXpKWY3kytftBTGmEmN/1xvv6PdEm5qrRf9EqXZUVDniq8h+HVgXTeUrJGTyTsnMiVsMoag2UcPJ6MOoj0QdIX4myynf7+6PvPgDblCMYs8ySn8dl9KM9kXS5cQ3F5gkEsdf2AuW0ENaSEhqKs+B6AXeXwEkCh5U+bDuQbuFrdKo0k84CvthAhNRzWepBTbM3xw2b/QeT06m5crmk2looy4SB3np210vuvZBc+dMB7dMZQ4VZrGWJpycbu7aVx3vQsw1IAA09bbh52+2R7oKz9UETPOQAevJH3OOkYyhwQmZ2VS/+MP4NSq2TE7lpKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(6666004)(508600001)(6506007)(2906002)(52116002)(8936002)(26005)(6916009)(66946007)(316002)(54906003)(6512007)(38350700002)(83380400001)(86362001)(4326008)(38100700002)(66556008)(8676002)(186003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKClENC2BncHd/6WIDAhMYD6mJDTS1kfDv+9B+sIQVfiMvXqPFUiBN/+OYla?=
 =?us-ascii?Q?FdLwGGsJwXJsINxXqIEAC95Dxz/6i8gCspnDzjX92Ofq4Y5D8CeHQg1u1pzq?=
 =?us-ascii?Q?H1WX+2dEzNwdU9G+GEJxyVAEPv5IEH8X5Lo3kxz0ihlxXx9vPD0vh9tO1hlN?=
 =?us-ascii?Q?T/I0x8+iPSIahyItmLeAwsycKUFa7mhT5sIfUxmovo1bpW1Ly9EUFPhYpzMx?=
 =?us-ascii?Q?3lTJtkV/jgSXDfV7dQC7VNzFxf/OITjBqLFSNGrKr2SAWUVeiplNXW0UTwe0?=
 =?us-ascii?Q?TFuitlCcdcaFTSul8pDZ3TY3plH87Sp1n6vEUJ59AR8UKVa3KVOPemQYkhGT?=
 =?us-ascii?Q?0egkB8iP/cSY3mWQcz45rf58VRQ2YnCRl8P1r4DubInS164vzMD45Q7rc6yg?=
 =?us-ascii?Q?Zw/jWGLr225xdOPED7KYhHFSEVuDeEQ+G6BP3ipj3HuH04joB8vbR9mtWA+d?=
 =?us-ascii?Q?NnnicECeHSSTm7CWtMTMFBWe4Cf2FcEGZL+GU7W4vxqPnBOhvZgT4uqS3nF3?=
 =?us-ascii?Q?vjri2+okkCCIwxMiAioYKbw/3oDdTEaoZLGzBFVv9Y2VpbJ36jZTM2HfXk8N?=
 =?us-ascii?Q?ZOuwKliP3n7BdMYZG+LU3YmGOBcBn48CWvjYnOUUWRBwtJgSLrH0NWkf7EKx?=
 =?us-ascii?Q?pcjv6O4yR+w4DIuQDEXaMTuJa4kyiVcpJ0g2v5nTNqzBWHae5cU4otEubdAE?=
 =?us-ascii?Q?ULOwmGWR7tuhNFdMQutsDIGipfuB5QZrSmIHp0ttLKaf4cCLhauASm9Z78rk?=
 =?us-ascii?Q?oLru2NOAcn10eh75MFGmoLmibUCdIdB31B4eFaa0L2uyvLL02O17vj8OqYxU?=
 =?us-ascii?Q?GC/Offt5q/3qZ0cP5vk9QmoPheYlwgMYZChT0aWBQZIdj7GDgVo/Yr7X4Niq?=
 =?us-ascii?Q?pmBfILPCYoKsmglNbeqNgSHPpzAim4wnz/vXvOA2jkWiHwsL2DJeBfJu5TuQ?=
 =?us-ascii?Q?ZgmBA+0IwbiALn3/TaXa3YUDp3RPTYgg7erwP7Q/WPxXa070ziQ6Vzg8AAgf?=
 =?us-ascii?Q?3pwgpdGGj3L8xAp++Thnp3FMdPB0jYzy6FjtyjfvnrSMQ277u/B7lh2Ni44X?=
 =?us-ascii?Q?j3xz+pRZl4ugebwm7IJrFa/z6JznAZpxotTfigyH7VKwdTb9Fa6Bu6zi3MFs?=
 =?us-ascii?Q?9+aXBzQnIe0a5IhQRTTWZaPXtvPnTuFsGgTMM0e2smp5QO8qc1ryOkgoi/bP?=
 =?us-ascii?Q?H13ymmYFp1TionRoIBo9VJbsxvbszbFoY8FgLQ8nFmgMD9dILeGJKz62Upmp?=
 =?us-ascii?Q?NkGHFVZW9Ds+vHEXxjGZg3qP1meu867oVmdMawiMEn11g5V7UwiZ3LTUq991?=
 =?us-ascii?Q?j5vZEZPlXvwCPkZAzGhH8xRC1cJ3d/m0STp+tfLABGXskA5UVq/94q7YqC6V?=
 =?us-ascii?Q?0E2b6yezlvbd5VCm+SRenDpX/doklZCYLFzEDLk+jGWpkDwBws3MkKAt7AYd?=
 =?us-ascii?Q?EVyntyHwIexHiqFGIJh7M6Zs9Qb0achm8bGn2fYGpAZzd/JVKTJY+SiAiAJ6?=
 =?us-ascii?Q?Vwmq7qD3HdCxMkZRAYKLOeUgmShLx7CTFNq4Bj/bns7nfPT5wo0thzroMLzw?=
 =?us-ascii?Q?Ke+jNXxtJ/QsYRRPXGI4k0BOBbkrcVublDSD8QMvhYC4NJ28uvDfFzeqTb3D?=
 =?us-ascii?Q?5x2xj+FYEY6RbyxAIcVRxbGP25XNU3Ne5qLcDksq1TanrhqTULkYlnJBgK4h?=
 =?us-ascii?Q?MkksZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b8d60c-345b-4e5a-d7b9-08d9f0f3862b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 02:24:57.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULZcByx0OTPLPEEALODiJjyXfTFi5zm7Cx6M+43PB8OA+uv2hixatA1ExFBzD+2kCunzzp9/rkvYGlhNud4+CCMZmU6XRnO1rJUONZqC+3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160010
X-Proofpoint-GUID: gdcUmTJBQhVmv_R1uRTxNOJKYxHInSPY
X-Proofpoint-ORIG-GUID: gdcUmTJBQhVmv_R1uRTxNOJKYxHInSPY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Wed, Feb 09, 2022 at 03:14:03PM -0800, Stephen Brennan wrote:
>
>> +static void sweep_negative(struct dentry *dentry)
>> +{
>> +	struct dentry *parent;
>> +
>> +	rcu_read_lock();
>> +	parent = lock_parent(dentry);
>> +	if (!parent) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * If we did not hold a reference to dentry (as in the case of dput),
>> +	 * and dentry->d_lock was dropped in lock_parent(), then we could now be
>> +	 * holding onto a dead dentry. Be careful to check d_count and unlock
>> +	 * before dropping RCU lock, otherwise we could corrupt freed memory.
>> +	 */
>> +	if (!d_count(dentry) && d_is_negative(dentry) &&
>> +		!d_is_tail_negative(dentry)) {
>> +		dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
>> +		list_move_tail(&dentry->d_child, &parent->d_subdirs);
>> +	}
>> +
>> +	spin_unlock(&parent->d_lock);
>> +	spin_unlock(&dentry->d_lock);
>> +	rcu_read_unlock();
>> +}
>
> 	I'm not sure if it came up the last time you'd posted this series
> (and I apologize if it had and I forgot the explanation), but... consider
> the comment in dentry_unlist().  What's to prevent the race described there
> making d_walk() skip a part of tree, by replacing the "lseek moving cursor
> in just the wrong moment" with "dput moving the negative dentry right next
> to the one being killed to the tail of the list"?

This did not come up previously, so thanks for pointing this out.

>
> 	The race in question:
> d_walk() is leaving a subdirectory.  We are here:
>         rcu_read_lock();
> ascend:
>         if (this_parent != parent) {
>
> It isn't - we are not back to the root of tree being walked.
> At this point this_parent is the directory we'd just finished looking into.
>
>                 struct dentry *child = this_parent;
>                 this_parent = child->d_parent;
>
> ... and now child points to it, and this_parent points to its parent.
>
>                 spin_unlock(&child->d_lock);
>
> No locks held.  Another CPU gets through successful rmdir().  child gets
> unhashed and dropped.  It's off the ->d_subdirs of this_parent; its
> ->d_child.next is still pointing where it used to, and whatever it points
> to won't be physically freed until rcu_read_unlock().
>
> Moreover, in the meanwhile this next sibling (negative, pinned) got dput().
> And had been moved to the tail of the this_parent->d_subdirs.  Since
> its ->d_child.prev does *NOT* point to child (which is off-list, about to
> be freed shortly, etc.), child->d_dchild.next is not modified - it still
> points to that (now moved) sibling.

It seems to me that, if we had taken a reference on child by
incrementing the reference count prior to unlocking it, then
dentry_unlist could never have been called, since we would never have
made it into __dentry_kill. child would still be on the list, and any
cursor (or sweep_negative) list updates would now be reflected in
child->d_child.next. But dput is definitely not safe while holding a
lock on a parent dentry (even more so now thanks to my patch), so that
is out of the question.

Would dput_to_list be an appropriate solution to that issue? We can
maintain a dispose list in d_walk and then for any dput which really
drops the refcount to 0, we can handle them after d_walk is done. It
shouldn't be that many dentries anyway.

>
>                 spin_lock(&this_parent->d_lock);
> Got it.
>
>                 /* might go back up the wrong parent if we have had a rename. */
>                 if (need_seqretry(&rename_lock, seq))
>                         goto rename_retry;
>
> Nope, hadn't happened.
>
>                 /* go into the first sibling still alive */
>                 do {
>                         next = child->d_child.next;
> ... and this is the moved sibling, now in the end of the ->d_subdirs.
>
>                         if (next == &this_parent->d_subdirs)
>                                 goto ascend;
>
> No, it is not - it's the last element of the list, not its anchor.
>
>                         child = list_entry(next, struct dentry, d_child);
>
> Our moved negative dentry.
>
>                 } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
>
> Not killed, that one.
>                 rcu_read_unlock();
>                 goto resume;
>
> ... and since that sucker has no children, we proceed to look at it,
> ascend and now we are at the end of this_parent->d_subdirs.  And we
> ascend out of it, having entirely skipped all branches that used to
> be between the rmdir victim and the end of the parent's ->d_subdirs.
>
> What am I missing here?  Unlike the trick we used with cursors (see
> dentry_unlist()) we can't predict who won't get moved in this case...

I don't think you're missing anything, unfortunately. Maybe if my above
idea pans out, we could prevent this, but I suppose without that,
reordering dentries among the subdirs list, and d_walk, are opposing
features. The cursor trick is neat but not applicable here.

>
> Note that treating "child is has DCACHE_DENTRY_KILLED" same as we do
> for rename_lock mismatches would not work unless you grab the spinlock
> component of rename_lock every time dentry becomes positive.  Which
> is obviously not feasible (it's a system-wide lock and cacheline
> pingpong alone would hurt us very badly, not to mention the contention
> issues due to the frequency of grabbing it going up by several orders
> of magnitude).

You won't catch me advocating for a global lock like that :P

I'm going to keep looking into this, since some of our high-uptime
customer machines have steady workloads which just keep churning out
negative dentries, and they tend to be in a particular subdirectory. If
the machine has oodles of free memory then we just let them create
dentries like candy until something eventually topples over, and it
tends to be something like this.

Thanks,
Stephen
