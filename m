Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58D350C4BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiDVXQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiDVXQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED217C53E;
        Fri, 22 Apr 2022 15:46:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MKYfTE024754;
        Fri, 22 Apr 2022 22:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5i4EI8sOaKYGMRiOgdA9u2QARmpRrMcnmSxVoY2LkP4=;
 b=o42ZWv7FyijEytwOduq6MN31/lLnucfsyGAtN3YXYsumbC90SjQtgbvFuJsehcGqm8Cz
 z9AOMo2+Ao7X5iWaMq7m2qt5kv6lhr0fwYTuiGRr7P2sWvO3m6MD3FgWp9jz/bU5n59G
 QBfoyxGtlri9u8x0EeezzFpg1pa1TfFRZPLj6FonoHdYPuWrCQlIK+xTHWeCTgfUAGw5
 S4oqbcn08kCFeZBjRhrT5KiyqN1nlKIaLSwl7QXdQKFC1DyvC184G6brOXOjZXIRdy9+
 CyXlO7stty4FfweIZh7QgegE70ovtFugAS8HfoVgO86sP8v8/iPNdvkyFFSdHM5Bxd9B dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9qdhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMeow6007324;
        Fri, 22 Apr 2022 22:46:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fk3awf5rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jluAnWkr8fi2PqjjvnKXsrrWeIhXNg1cIbR7gTi1b1Ond7nt0W6XXkCyUEgwlCU6E3Jetj+Z9/AmbDLz6RUbzziKyAg7PexfBXoHwULxc6Y3+tuVxYsGr2KucnEu87kHC0RcMbhFoly2Ga/2Q0ayaofzCFkUP2PtjqhR5yDEeSO86n6pgBF7uZGBM3DUEqwyqjUbXoABu/juBhpPKHmATI13qNYBz0dDdtI+oeyFTGIf+azeMp5CNEcItAThh5TOqNibMeXBsmB7IdumEf5dbjbFMFn7Eb/gZrxoB7bbuIYiwl65UsXqVb/RgxVIBTTgfpDvp/gqCgYwVeYBMVDI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i4EI8sOaKYGMRiOgdA9u2QARmpRrMcnmSxVoY2LkP4=;
 b=iqmwzZOq39FHh87Y0W0Zp/oSQZeSqYS2DBU0REqmWMEC3JVaGrchcj7v2yZx7XJ1lMKM7Ys6djICtkOS8oX4mTFCP+d7Ee5C9yTjMd6ljBlhykjz6nRJsWIrY3+yTAi9vQXe2mgKGm2bZoSwg18mGPjBHBgCnFk7Tb/Crtbc+H6xkqzIcM7Mb2AUY0RtleT06DXCweAZDTstpObm6b3O+U5aRGJ5XldE/6x/cIgTzUqIg4Lr+8mCevyy+jRPQGYaQ0kQn1Ho4JfzSDPypaaPXGQKaXkY6Gnjqx/ZsR5Wpfitn/hABPFLPx7k9/bp9NDm/J0ClSnXoQuVVj16KhWUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i4EI8sOaKYGMRiOgdA9u2QARmpRrMcnmSxVoY2LkP4=;
 b=SOcm6tvhKj2pnB9of0kbDYlTAQX105FLnDmvoQbW/h7nVoG9AYXiKBLe1EYjA7VwJ4LsF0W6t5KNSV5puvDRoOnnVR5WduWwLgYpIenDpLSnJhhgRY0PRXJbZls6Nw/g/yoNeukN1uODiXkL06pYAgoRajDk/0PNo2MqZ0EWMU0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:46:08 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:46:08 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 3/7] mce: fix set_mce_nospec to always unmap the whole page
Date:   Fri, 22 Apr 2022 16:45:04 -0600
Message-Id: <20220422224508.440670-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220422224508.440670-1-jane.chu@oracle.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42d3d145-73c4-4cf1-ce75-08da24b1e41b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550258A3ED2DC1CE60D5046F3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2czr/Ny49kg38MYO4uc2+8AhMIQ+gMQ+QH2+Zo8lJbdIGeUYcX2jpoO2A5OzakCyh6TUsINcfaMsnv42bPO/KiAKXhfKMswv3k8hrGDe2/ey595IOfSINmCDxQCckhNglD4Y4ByX94JvyxnKCy2otC17XTMhE1xk4ygterNI6gNNcIH+UGNn0v0892OrLLl+7oNAOF00GndL8mPhMI3sWHOoGQujb2u2OGkfzjVNKyllsJYZvLL3nqIcRHmVjDK5zPA06ayPplW8iN+4MB7jOIomy9bZGJcGYAiSXBVh7i7XQltcrNICG2m2+TI0il73QsHdM86keVgPyaXnoh9TSBEN8wiYHjKpxzgbj3FtQGaoow8xNNyYevUbOmArLsQGoSRM5JLWIwukrJZAWOF2xuWLEcF9g0N7scaPjW//Ah4Fm/3EKezfdBhM5JB3hq/3ENFrvlMY9tqIUENFbaRTIDJHGMYbHahwfdLIEAZD5DuQuGrItmB9TLckAbtyVg9UQ9aTk68izemiAf6wsfw2/EBxR1XW6z7xeceEyW44FvCcmZznIACBT+ACLXmwZ9vTtE/EVetHZSyvSGXES5v0jzlfTpyNaY7+Vf+jSQW03WnSy49+0m59Mol0nap1QUal0s+IANL1Ph56vgPv2MU0lC2AL918ymFSRO6u5qKdo5kxUSds0JdnhC98K3MGOBq6xhgl1YW6rsKlA3CU/QW8SzDMxkcvEqOvlQDN1C6uSpTlylLypVzqWrLF+yMHrUvcBNkcXgnTPvDAYG2ZUUOOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6486002)(8936002)(508600001)(966005)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(44832011)(186003)(6512007)(1076003)(7416002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQDP6ygUGGVY3lsOF1Exdr5KAVlVXhWfO+DohmT3ra8tt6Ry3Xk72w9YmfZ1?=
 =?us-ascii?Q?xR3rT0Xp3Ps5JMr72l5zLYLeGJkHCJjzZdvMLXhiofsIOyy1kPHuocfQ+FPC?=
 =?us-ascii?Q?K3u5+dzYiPmf9dMAXb/6BpSrTet+DJI3utNNixcj1OTwJAut4l7XX3/eUTuw?=
 =?us-ascii?Q?uxiLQGuUu2BiSIuK2/Eu9yxWBiAkArk/GGzZ3yUl0Tsdjo6KC2J0l3ezgwN3?=
 =?us-ascii?Q?l+bIb3Q1lADNSIHqKHXzkrvCQduRa4GMP1D0Ma2XNbPMKtNq1sFxJtlChB3v?=
 =?us-ascii?Q?ME8O1Ygp+lmbpuWtVAc0RrWqApLbqZ0ma4FB0nesa61wFv1XpQca+MszMT+u?=
 =?us-ascii?Q?PRG2qd0fCQd9zFd7ND7FpOyuZpEyDGvIaQtq/8xY0e+CwtmEpHNOnJSCFzbx?=
 =?us-ascii?Q?WZhDOHGOA4bjpKPvzMSQy7h9rqZcN5T/O1UZcZxXDZa4xw8zINNvUiwP6g8e?=
 =?us-ascii?Q?WvZcnIfIBv+3K7p4Xt1Jph7973Nrv2iLeXch+PcBcTjsMw3IqPXJ+paMpaxc?=
 =?us-ascii?Q?MHEGFzG4jIjfpWluiGxr3yGZi3Uy6FEvO+q2TH2NQ6ixrf1kq1LK540d5dc3?=
 =?us-ascii?Q?QOM5GB6uk8SwoVgJAf+IRXAm6lcCcJzUZ00fRjza17k6UMnSIIbiaviMiKzg?=
 =?us-ascii?Q?S1JksXFIwaXEh/c9H3LC0M9t8QUhqt5H4rYmzD9AWbrC6Qd9rNntvA8HodyH?=
 =?us-ascii?Q?hEFZJnFQx4oqYhB0wEZF0e9oASlN86ncMh2YUupv3YxDvokXHooLaOKZQoWB?=
 =?us-ascii?Q?ntTPu3teFqRVSaw6+G15y0/G1jU38uLBBDh13L8rnB/YHzEmqcmpWmF6wCkX?=
 =?us-ascii?Q?b9LtLyMunasnMmpoFtupbmCk8urjrEjKQW4V54Dcurrm5h4V7UymCspnpLTC?=
 =?us-ascii?Q?yD0uZ2ste/NleFnlBKFzYvHRjOYDQjAYw3u/skS3wbahAg5GAtN8z23ImG0/?=
 =?us-ascii?Q?NDnnFTXflOsKXeTMcMQlqhmZDgO0p13/V7p7BnyIjIekErQ9/D4VisnDBpTi?=
 =?us-ascii?Q?OvkAr8aE2rvZF7NMrOq0cR3rh4DeqsUaXFZlXIezeOhdj2yq7UPq4H98Xepl?=
 =?us-ascii?Q?8xB+RZaFlhpije4U091UG4+0g03GwC0ES8hNZBCHlDCPms0m1Y6sEgHVmJvg?=
 =?us-ascii?Q?bZOLpWYoY+r8fxuMwHfkVad+gzG+u6srD7MO+1fUFpFZZKILks2U+Z0qiwtT?=
 =?us-ascii?Q?S9DPqNSL1hRRbgXHXnVe2XkwsOPSVzRUAl72cIURnz0GQkkpiyl4PtM/T/WA?=
 =?us-ascii?Q?7+HCO6o0UnRGoC1xe4OJt509XkNaYa6/n+M1ljqiVAB7+gYyAj+fw2Powspp?=
 =?us-ascii?Q?tJMrDrEmfGv0UN8eWcpOkYTdSIrEXCj3AbIOuYswvgrwD74KcCbgkzUm351s?=
 =?us-ascii?Q?p9l7cRZLyO8JrH3u5AyJNcbYbgAfj7m4yXI6VPQ4lb6rLsY/9+qF50MfIgA9?=
 =?us-ascii?Q?uqRy9bigpt2E9+pRSu7OabE7Vc37Cc67RzY9wYvrpUn0StU5oGgxZDEA0QoW?=
 =?us-ascii?Q?TXctlEcbpLFUz9C8A5N6QxxY8ErtUHgqc9pubWblWoAlJR4pt8TMGIf90Qz6?=
 =?us-ascii?Q?TbQiNs+FD86tNjmoCdYTf8yhJJgy8/Apiw+spmfwt18T1IKn5twGQ9ph8nLc?=
 =?us-ascii?Q?VjeKJSfB6bn1XY+Q4hp/eKR+fdAl7NlppPvYxVW5ApmehuQuZUIxTsi2w6NH?=
 =?us-ascii?Q?muRDRwbObCes8r1OPsrawFow4dBzgcUI9nKi/XbTR6Rx0i3jVZRq/EHcxwyZ?=
 =?us-ascii?Q?oXxt6EbL8c5nMMm/uU0cQhgtOVlnECU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d3d145-73c4-4cf1-ce75-08da24b1e41b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:46:08.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81wFhIi42M3MF1NItnJFifEdAi9RqflKJusbDcDAVkm00tRJVbSXmTOSpeLpqK8yhByQTXj2f3bejx1V8cTNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220095
X-Proofpoint-ORIG-GUID: ltflpv_vZac7y6wylVbHcJpzJSNlSvE6
X-Proofpoint-GUID: ltflpv_vZac7y6wylVbHcJpzJSNlSvE6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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

