Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE1507EA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358861AbiDTCIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358834AbiDTCIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF44B12603;
        Tue, 19 Apr 2022 19:05:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JMIjr8019340;
        Wed, 20 Apr 2022 02:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pfqG/zGcXQZRAJwpMqOoq8cK+cexVXIh4CKJuaKWLW8=;
 b=CAz/MRqRakGbBN+MHgh+JHEQxoqm3VGs2Hjc9STyHocIkqhgcXwMwu/IpuUBngvDW0v5
 dB3gajKdbC8YEqjJG1jClJ9d549mOLC003bSYirimsBkTYe4NqSdqgNflKQeB6cLpIUd
 HevM3U4xmXjAUPLfL24m6ZY3kuvtc9g7L//CspcmK6IUBzm8vBERtOC+YZ593KPJvHri
 eZzxrDEjnjNb0b5ZW4Rp30DhqjdfpUvJLyzG1Z9nOJELMdRZFWmwvMNyRfBzsm1d2G+W
 srnsRxBTMTLg+WMuBGcIjy9LL9Gn9ACPonEtyhD4NHA8/BmYYvyks7M+M2iGOmVLiyfm iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cqh39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20gfZ037457;
        Wed, 20 Apr 2022 02:05:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm843u6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7tGFqF62VZgvZN0YsSRPbnAlLhVR58GvfKh3DauD40ni1R4GOYInflQS+lEEs5K8vEfJgieFD09S4iXcK64DYWXJizhSo/vfX32McYOMztcXuphiIoZtNCbusiLOCelien2kytTFvSBt4Hj4BO42dkfCOUtVy+F8sVaSxAgK9Wm5jxSCorW+KI6aqKT3ySZTlZ/Z9YBu7E5UJVkj5+uwI6zA4DLS6TgVY1kQ5r3gmbaONh0/XJl4+YpLYdxMBj7maOoWnV7wO9o1sWobvK9NRt7HFwf6SIRrRU8jTdJIW1NZNKRdMy5pFYeZ8ytJ1lDFtpu6543WCzEKw2q4mOj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfqG/zGcXQZRAJwpMqOoq8cK+cexVXIh4CKJuaKWLW8=;
 b=KnOBBX9dttYxNN6JUyPUmowI6YSq4sQGeF6FLIXFydMUjMAkGaNsOouMKN3usZYT+myTFAlFEgCamHq0j2oqFAouannB5Vtudesv4EE+B+Q7XLdiCRb4ZPz+x37oFz7DFsoyRhorDKTKPPnzC5UkUrAx4UKXxt+nzenPPMvjl5cje18AwbjF8CesyCqiuDeHRSmMipy70oNx+06CKPlGuSSBZmt3nMEQokFECTytex+62tmPmkGVS2OVCQ4TA5GKOFPAFGpyTJrwi+NzMpxHPHMuCMQgGPpzQlcPGv8K67f5FEclSFA9F+qj7Rz2LcAKuYuvwRL19C9JkHJo/F3Rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfqG/zGcXQZRAJwpMqOoq8cK+cexVXIh4CKJuaKWLW8=;
 b=fmhXbeG6Astu/IjKqE++yEgtuf2BlKhHlZ5t70gIMouK+n0vJAUbqCAL7tUD2kSbPbw/x9YQq3vnoKLyQGiTDvAk1gfIJAWoRFX9Q95GrOf5Y7jHrzH9YI7MDqy6J1H3/qLij87HNKvjgmEqHRLHtqo1jaie/VuAQf9r2Z/DV8Q=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:07 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:07 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 3/7] mce: fix set_mce_nospec to always unmap the whole page
Date:   Tue, 19 Apr 2022 20:04:31 -0600
Message-Id: <20220420020435.90326-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6adfec80-fc94-488b-3273-08da2272310d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4557:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4557DE7701433DFF61BD329DF3F59@SJ0PR10MB4557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0EZ7qVzDyGm4SN7QbkJX3QPlNFx7OFl4bVD1MvoEOeJh2CUxRTv8NXj7b+nGw4u/6AldsTBL4Op3PKcfjLx5DtaGUeTmNK25ECiztk+0PD3f85VInXlB66zHBaAOHP/qJfbfxCjKd4Qz7Uy+W+HLnKiPjsM59qTsuVL534WYPwUwbQuBt7lLG2bPau75HENH8aAIqVGGQaDS9NyXFTpEHIBP0gbx7j4EAhe4kq7tps7Jpv59hUF1YwZLSq9SMdygS33L6uIrJ9U8PfxqGGgcET7c2qCD1EaqHm+VPv2AvwbrucO8vcAZhNYWLkdBIBVXb6ZsLRCXPw/4FOLegg7D21KzorfMrIz6HDZQydAhKVnHOW7dFg2078JQbOBqMuERcED286PzbzgiL6HSOJoBsEzFngUf3lgZbyLfXevCWU54UAS9B1nEsHZ+jpv7gB5H8zNYjl0lzQ7PYyM+T6bFijneRWUQ07mcwwyDxtbWlajOco6L3EEJDxRigj2P2qEQTnMHadWyf4YGTg24+6byhcPhVT+hBnvQ4n8ufvmf7ZCQQQi7tWOo+r4pCsfsjDpIsOMiR5Eb+bcS6GnES8zabr6kp90HK1E+DMmeosa9aqVE6Re1xcLwLJDz5ljhIr4Vl6v7riVBViVTl5NaRCeiEyMTRrRzhf4cOpZZGl1R0qz9CJ009GUxin4e3tLTLyNF4Urvk/cuNj4i1d//ZQPHNsGFPAOTh+6c80GXHA4XDGr8P0wp2Fzr5gdqwaW53M//SLyHy9qjQaEWpKUjuOJkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(83380400001)(86362001)(4326008)(66556008)(316002)(2906002)(508600001)(1076003)(36756003)(66946007)(186003)(44832011)(966005)(6486002)(6512007)(8676002)(2616005)(921005)(7416002)(6666004)(52116002)(38100700002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njyXFplh4wCi5RkjeR3COAycVHMfYaddYyhOoWfjvqarCBMoouyDKjriuEcL?=
 =?us-ascii?Q?cqFLSLLEtFNwaULbJNgAG1hKnuOadX9xYQv1XVNug4hCVOpZhL161q0amtAB?=
 =?us-ascii?Q?lYucv6K/O3dgsLFtO722veXMXXXUzgvYOODZmImVk+B480z4aMrTPTGY+/Zm?=
 =?us-ascii?Q?DK0DCwJ1e+Fw/KkoOdm+VR/YO+GTC+AtWYOQoZQ8lRLSVNz27Es7rq2IKb+r?=
 =?us-ascii?Q?81bjlSYAzCamqSFSCeEGlrhpjow9jZSVC3N8yL+iH0bpiOvGWmr8VR2bcSZ4?=
 =?us-ascii?Q?kQCDUkIAVwwKeMtMRq60/k8ZxLB4o4H6gx65x+e2FzLkmlN4AWucFDM4D/4S?=
 =?us-ascii?Q?n9XVMCN0raeqdCa54DFgV9f8VEu2qwTGCi3SDd1rqunpU2I+XfK3GQJ2YOxb?=
 =?us-ascii?Q?fnVIB5anPc1G/bAbABfYHOXTUgsEYIQi0EOEU+wtPeN2gj+UB47NwjYgTaiV?=
 =?us-ascii?Q?jPlR84P626w/UoTCoYX+lmkH4X8pIxpSiRsQXLhK5F0hoB6WPDcyc5pQMlnI?=
 =?us-ascii?Q?JZlD0cYMWVfy8zwrwFdKV8dEYB1oVoH8Amsx82rzkyvcWlepWMwY+9nmB3nU?=
 =?us-ascii?Q?evnOC+Bh228hJPtsR3esm0+bvnMw6FSnBP2ail1jCDuHlTnoSsJsKNsFatQG?=
 =?us-ascii?Q?zpsSY5LFx25fQjYs8KXwjTYlabhth4XlbitxYOt4ViJQ7N7hfqrMV7loB7Dp?=
 =?us-ascii?Q?1LtN+AC5PVrzm3237VyaNbEXThw2lvc8jwV9S5W3+P3pEayKajjimybKPN8k?=
 =?us-ascii?Q?M+/0QU9cmtr0nW1kHYdKRqLgx3luXjHHdVT/uRhuq7dHne+xihyiHSQg1KYU?=
 =?us-ascii?Q?r2XKXlwoGfTuAns5smZAlwDOy0hfDNt3h9V9/vH4qz0rN0qchNnEM5JftmeO?=
 =?us-ascii?Q?f48meoygv+9c2bGTcwiYEd4V+WPpRVn/MraUDrwsHjJhSLio6J33ce3U/ETC?=
 =?us-ascii?Q?WOquahWNyUx5XZGxJAJpEsE60b/7+QRooG963/2QJ34Hp9ZYpNVRsbtQe4v6?=
 =?us-ascii?Q?01iO1Y71unZmkLSilJRUhfAxQS44vbntggQI8Hz5D+PakNqAathnzD5GEFvb?=
 =?us-ascii?Q?WMb71cjyPLbzVy8JPnC2CWDbkOO9R+IQ6d4QbAmLEZpQOK9JMaQyceZU2bJN?=
 =?us-ascii?Q?wRcrkm6CuSwyKPaYzp/IA/B54J4sew8TZToK6jkmPL/JM9c+B8PD3Xsr28tQ?=
 =?us-ascii?Q?nOv8IDZi7ZaODUDQX3nc79huXRSYT8MWTOQ1AOtqeuIV/nWCNv+qWyiwoaVB?=
 =?us-ascii?Q?qoGzNmOzUCUHowgZnyUZsZyPvmyyEK1g8InBurt88RKDHT9cjr1rkP4hZJvC?=
 =?us-ascii?Q?Va5paYlO+mb6dZEyWeB1YgT0+KUGDLSFWMq/ScEL0dv+dGZqqqX1qLR8ELAF?=
 =?us-ascii?Q?D1vDyY6kTGLXmsdsGWmUjGWEHmA+zlBAZuWq3MQmyt8HulAX/D6EMqFoGQWp?=
 =?us-ascii?Q?cZyUIb/fWzFvTxQmpCmNuPqUp74VkfprCAGEldWdQWRM2ciDZYXXM9HCZNjX?=
 =?us-ascii?Q?RrSUGSTmB6leEKiEGQA1YCZXKUOaz9kLQZRjgF0eLbbMY657jNpCh0gtEjq6?=
 =?us-ascii?Q?kRR7D8W5c/mb6/a8cTVyG/rosv+UM+mmur+MqnuJXuA3i+t4lIhpGUViaqfe?=
 =?us-ascii?Q?a8UzpJG30issXwVP8AZXGYqzCOFyn6OhdTuhIAAcsoBQOQflXQIC4/o2jmDb?=
 =?us-ascii?Q?oWL7Vd4EUckawQIa3X1BL00y26zX9zlPa25XmyYpVaywaA6CiNYJsKJuxgI3?=
 =?us-ascii?Q?lhwg6gOdzdmols0uB3DvJxu1jNNdRM0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adfec80-fc94-488b-3273-08da2272310d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:05:07.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1V1mNgbn0HPaJh4P6cwJ20FaU8jBrBKvnamyUQxw9bvOt/i55somunXICquW/cC+jntPxI6sSxytpsfFmxR+nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200008
X-Proofpoint-GUID: UxkRw9DjDw10CDqnaLswESvNY_1l1MtI
X-Proofpoint-ORIG-GUID: UxkRw9DjDw10CDqnaLswESvNY_1l1MtI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The set_memory_uc() approach doesn't work well in all cases.
As Dan pointed out when "The VMM unmapped the bad page from
guest physical space and passed the machine check to the guest."
"The guest gets virtual #MC on an access to that page. When
the guest tries to do set_memory_uc() and instructs cpa_flush()
to do clean caches that results in taking another fault / exception
perhaps because the VMM unmapped the page from the guest."

Since the driver has special knowledge to handle NP or UC,
mark the poisoned page with NP and let driver handle it when
it comes down to repair.

Please refer to discussions here for more details.
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Now since poisoned page is marked as not-present, in order to
avoid writing to a not-present page and trigger kernel Oops,
also fix pmem_do_write().

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/core.c |  6 +++---
 arch/x86/mm/pat/set_memory.c   | 23 +++++++++++------------
 drivers/nvdimm/pmem.c          | 30 +++++++-----------------------
 include/linux/set_memory.h     |  4 ++--
 4 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e..fa67bb9d1afe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -579,7 +579,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	pfn = mce->addr >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1316,7 +1316,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 		sync_core();
 		return;
 	}
@@ -1342,7 +1342,7 @@ static void kill_me_never(struct callback_head *cb)
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 }
 
 static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 978cf5bd2ab6..e3a5e55f3e08 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1925,13 +1925,8 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
-int set_mce_nospec(unsigned long pfn, bool unmap)
+/* Prevent speculative access to a page by marking it not-present */
+int set_mce_nospec(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 	int rc;
@@ -1956,19 +1951,23 @@ int set_mce_nospec(unsigned long pfn, bool unmap)
 	 */
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
 
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
+	rc = set_memory_np(decoy_addr, 1);
 	if (rc)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
 }
 
+static int set_memory_present(unsigned long *addr, int numpages)
+{
+	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
 {
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+	unsigned long addr = (unsigned long) pfn_to_kaddr(pfn);
+
+	return set_memory_present(&addr, 1);
 }
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..4aa17132a557 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -158,36 +158,20 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
 {
-	blk_status_t rc = BLK_STS_OK;
-	bool bad_pmem = false;
 	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
-	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
-		bad_pmem = true;
+	if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {
+		blk_status_t rc = pmem_clear_poison(pmem, pmem_off, len);
+
+		if (rc != BLK_STS_OK)
+			return rc;
+	}
 
-	/*
-	 * Note that we write the data both before and after
-	 * clearing poison.  The write before clear poison
-	 * handles situations where the latest written data is
-	 * preserved and the clear poison operation simply marks
-	 * the address range as valid without changing the data.
-	 * In this case application software can assume that an
-	 * interrupted write will either return the new good
-	 * data or an error.
-	 *
-	 * However, if pmem_clear_poison() leaves the data in an
-	 * indeterminate state we need to perform the write
-	 * after clear poison.
-	 */
 	flush_dcache_page(page);
 	write_pmem(pmem_addr, page, page_off, len);
-	if (unlikely(bad_pmem)) {
-		rc = pmem_clear_poison(pmem, pmem_off, len);
-		write_pmem(pmem_addr, page, page_off, len);
-	}
 
-	return rc;
+	return BLK_STS_OK;
 }
 
 static void pmem_submit_bio(struct bio *bio)
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 683a6c3f7179..369769ce7399 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -43,10 +43,10 @@ static inline bool can_set_direct_map(void)
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifdef CONFIG_X86_64
-int set_mce_nospec(unsigned long pfn, bool unmap);
+int set_mce_nospec(unsigned long pfn);
 int clear_mce_nospec(unsigned long pfn);
 #else
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
+static inline int set_mce_nospec(unsigned long pfn)
 {
 	return 0;
 }
-- 
2.18.4

