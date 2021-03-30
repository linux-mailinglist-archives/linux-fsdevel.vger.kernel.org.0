Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9934F340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhC3V2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhC3V1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULONSq011485;
        Tue, 30 Mar 2021 21:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=iIHVwFGw8Hz4nPO94qn6qgFMWA5G5Zwf49ErfeTVY9E=;
 b=JTpiO6DMbvoKG8eguxDIhXRyMsonYM+E16hk2ZYy/qgvxEVcLukBoZmz+ylDo1DA0ZWR
 IlQCTKuM2+JTedKeld8UYu4+eD1eRo/ej1QJVmoSOEWbhQ9coivvdRGvSGK+fz0KPUcM
 AFANppaXbT3VcoobTtWot2zuM/rml7qBdsjPqsr8MSxqPzzVw4ZH1gEz+txEtsLUn2UH
 jdjz5AF7QmOj6HaCIiHeysIlJlQwdI1qRXsQaQvwjPBF7lsIcuiTA+C7LrD070OOjoK2
 +WgwLN5pToKlJme91LM/ln5KLVzpru9/uiDdpBg2ldBWrP7I1EpnthLTAjmW+SMho8MV 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37mab3g8xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZ6i125105;
        Tue, 30 Mar 2021 21:26:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 37mabnk7kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjH8gSdCgRie1mmCVSZnw+udxcwwTMFq80xLq6EJSTabhW0ovlY+oC+14rbV/o4cDzHTlaNdvF+FU03w+JaUYWy+cBx9ADehz+CG5gs6qtb+l23jQNDbqJL01FANQsZXl78QuHBSggvyErDeX6gw6nwksS7mqVGqbjLfArAKiUacsHn1LMnQTMiQMsFDCALNS688y83o8qO67Aa+L6BFfy8dkNzCZoy1bX9UdlDmxaplQ1EId1x8lZkrUivkBKGungNLZMzO67a4oqA2gFrL61gyS2LuvRiolw7jBUQXu2T39TM4GWeLRCaE6O1Cnrx644Y/7O6h8666F8ANmh3xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIHVwFGw8Hz4nPO94qn6qgFMWA5G5Zwf49ErfeTVY9E=;
 b=fa3AvMdmCmqzy6nIJzcjsLJtU+j4mTjQwUD9AGc5EtqjSdSJpMV4FN8QQB7rViCjV1BiSnrG5fAEmvYRFw9oaDm7h2ROiD4umRtyWRODtHlzKk54JtefDC9epNPpwJMXSlMiZ3TRICNjvv3dF/PCu6ST0wrZng/UwzKU/SwrMWudDiMpfyt6b6f0CXYrQk7jriegmx/tsmdwVtZvEpnvnui2n/v7xW4LCKIFxT4X6aAVTJZymDkZHvVFpNsmU9/WUz8tIKZmDOXy33Bm7iRc3smwxgXXGaovTlmcriJq2utpV2exxDJRNt7bNC6N2HyvLyNsq2pjcYvuPag0hE/+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIHVwFGw8Hz4nPO94qn6qgFMWA5G5Zwf49ErfeTVY9E=;
 b=CEjGhAoJh55zK0CubDhGEgtPDu0WULptoLN7HOismRTgbbJMF4RUXY5tVKrzbEo+C2GpHNbKlvVMDMzkaegkVX+V5N1Fm39ApUcctvJXsgm4J5t4gyvsBzZSk+n8iXSJG/kSdSy+raQokT/6kIn417Z3TbZFWRKxtpj+C4NZBJs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:43 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:43 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 24/43] mm: shmem: enable saving to PKRAM
Date:   Tue, 30 Mar 2021 14:35:59 -0700
Message-Id: <1617140178-8773-25-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7886cb2-de28-43b2-cc99-08d8f3c283d8
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB36004335FA047B3D9DFE3DC7EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XDtgVOcaCtewfyPd3nD5Zh8/ZEkKJ24ET60qIW5re+QNVLE7aukJsMqDCikOjLbEkKXrOcXFAkUaqOK/JWQkk9cY8qXz5mqejAY5CSrl8xfjl7RUhdWSErZei3UdtxIODRWhXTll0pF56JavF69+ld4WhD5D9dFpxmSWWV46qy6USt1J8fSho5eI3b2zideFwVGh03x03qjTgUAfqgI7R//bPhZhF1O/CdAJWurLOVUvD2lvKpVXSjpnd3PoLRHLRmpWjn7wA5iSZrm87Jle8ybxnnKDcgUtSPLu8kKqvEjgHh5xFiRriarRb4M9TPhRxC7tByNQ+OdNKHygrM6x9dS3QkexhJ6ZGKdI2lIaCDc/RnFqqLRn6NrtG281z8gGiXnbHvTk+77Jc2uL01s4YqZUrAAHOlY4Qi13mS7khh3NrmPCAuuGHnlSnUEjKJSOmJ/gnq4BT77uNvDCHQNcaPrbEugE0lkWx+eMmBB7nnHjVTgIUJQKFyp8lzQk1arf/HuRZMHhbUWWu60MYHvpbiawtRElbf4LdKevAP0oo5NS3ZX4m8xcrNAP7GiZ/2263LYI34soFPJ/mNhsa6GmiP139ixPA5bL2vNUd7hQwP9a4H+MbPUZMaJEILVNmjW1DOZEANh+FcTHGqMuIqyFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(30864003)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p+HWCO/tdpLOxZDV/aTkIb2lwjmuPLrR9HzHMwEVwZgXzUhEpxwFHWvTqRko?=
 =?us-ascii?Q?pWu9OYX3EO7yDSCPhGKiJXU0tIaDEXTTjjrmHrBp0zlns9gmRv2h5RHRSHdy?=
 =?us-ascii?Q?aP8MlRKFZrSC66UaxYIBuXwTJ6cPkeLLdonmOOQCZ3cOM2kEiDgA/pXUS3HS?=
 =?us-ascii?Q?S1WobyaK5Ne/zNvXIHaSqZzummHnOgKm3UtMZZtSlwH+a1FhvtOHLwHvdkG+?=
 =?us-ascii?Q?XMlyBum8jIVTPWOusiqAzk/KQCI+7YTPdttWRhCgo1ETfLEVbL3CSVpnj4zq?=
 =?us-ascii?Q?XgoTUdxJTwZp0IrIfmLO7rgyo5mGACFReO6rpOtghmwDkJTgvAHFMtUEZYTH?=
 =?us-ascii?Q?9CpVz5O5rZw/ncXRrGL8KngOXFKgVpqlpGjnnwp4eDf6auBFqD7hvBmZycnP?=
 =?us-ascii?Q?J+AmeyFaSwLkP0H3LN0BOt9IODBFCims7NNNZlpwgVKIter1qcu+YyHcmcW5?=
 =?us-ascii?Q?DFHFB4wlmW2s+2JilKJpNbDUgEZN4n7SoIaPxGJj4Xl9mNyqA9K99RT4H2Uz?=
 =?us-ascii?Q?BwrkVEIFTdnGTJmZLIiFo56agFnX2S3riZ1B4lEs3sfDIzYfwIYWB9qF+Mqf?=
 =?us-ascii?Q?CRFy1UkAMmpeLzvnmW+kQFcUoceO4nvEnGEALsBUkaqeQyiNMpON44QvdZUr?=
 =?us-ascii?Q?Klmzn2Hj2U+Pelvih6L6IAHovju7vvOMPYmYNvEJNlZTxo9tPGDIKyhr0tov?=
 =?us-ascii?Q?RKvU21el/jzoJlzv12BshnepelwDktC68wXDVJUewGpUiEmNVwcXjdw2S+4U?=
 =?us-ascii?Q?KcGPthNBXeubJuij9oGVKzi62jGtPZvrqmH0iz7FSlWez1imLGm2TX5KlIIU?=
 =?us-ascii?Q?/Lt/6z9A2X5R21D0gCev4UL0W6j3yNnb4ve5bzFGDJ4x1ek2IGLloQs6l0So?=
 =?us-ascii?Q?s+cyM7e7PJRjhc0r97sb7SEwqU6M50RENA6jJ8/7CCQ0+FuO1pJIUL9BdanQ?=
 =?us-ascii?Q?KqQ0cUSC/xyrj60958E/A34+xALqovpKoqjNfFWzYjYMSw99Tze6WQ5RQZ77?=
 =?us-ascii?Q?5fiEgK9qYKay6CnF7Tojb4AihzCU/Fh/cYfLn2f60fw84lWR9Kg4o4ayelfM?=
 =?us-ascii?Q?6CEf5s9TryZhQ3YeI6tNFfAQsgmfovNR6PmSvqbuTr2rNkwToMcwWagiyuI5?=
 =?us-ascii?Q?vMK7CcIgAiw4t2jRXSlAErXdDzoo6PIACtl4Jwn4TwOix8Of1rMt7ISVoC7j?=
 =?us-ascii?Q?pJBzfCOrPGE9U50Ke/S898ADIThRX41xhz71Fw2Gz5aQWLvXEabkicamVW2g?=
 =?us-ascii?Q?6VHbFF6NRcwxDyTXeW+208JFIneHSHrxiQizenyoDI4xXgnpwuu9nYtYeO6s?=
 =?us-ascii?Q?rSBH588HLDApz5RAiysTm/VB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7886cb2-de28-43b2-cc99-08d8f3c283d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:43.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV7BCEcSF5NeEKmW7S8qRqF2tHrSzrYDMctgvqAcbFOpqM5GpdFIb2aarZ8+zwiAcQIdMO4CIAPypBpXA/xH+RH+c3GuoFZOQvyr2PMLXJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: OCI1vSQ_yZwsHEH_uu2XogfVI8mhSB1V
X-Proofpoint-GUID: OCI1vSQ_yZwsHEH_uu2XogfVI8mhSB1V
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch illustrates how the PKRAM API can be used for preserving tmpfs.
Two options are added to tmpfs:
    The 'pkram=' option specifies the PKRAM node to load/save the
    filesystem tree from/to.
    The 'preserve' option initiates preservation of a read-only
    filesystem tree.

If the 'pkram=' options is passed on mount, shmem will look for the
corresponding PKRAM node and load the FS tree from it.

If the 'pkram=' options was passed on mount and the 'preserve' option is
passed on remount and the filesystem is read-only, shmem will save the
FS tree to the PKRAM node.

A typical usage scenario looks like:

 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # echo something > /mnt/smth
 # mount -o remount ro,preserve /mnt
 <possibly kexec>
 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # cat /mnt/smth

Each FS tree is saved into a PKRAM node, and each file is saved into a
PKRAM object. A byte stream written to the object is used for saving file
metadata (name, permissions, etc) while the page stream written to
the object accommodates file content pages and their offsets.

This implementation serves as a demonstration and therefore is
simplified: it supports only regular files in the root directory without
multiple hard links, and it does not save swapped out files and aborts if
any are found. However, it can be elaborated to fully support tmpfs.

Originally-by: Vladimir Davydov <vdavydov@parallels.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  24 +++
 mm/Makefile              |   2 +-
 mm/shmem.c               |  64 ++++++++
 mm/shmem_pkram.c         | 385 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 474 insertions(+), 1 deletion(-)
 create mode 100644 mm/shmem_pkram.c

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3f0dd95efd46..78149d702a62 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,11 @@ struct shmem_inode_info {
 	struct inode		vfs_inode;
 };
 
+#define SHMEM_PKRAM_NAME_MAX	128
+struct shmem_pkram_info {
+	char name[SHMEM_PKRAM_NAME_MAX];
+};
+
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
@@ -43,6 +48,8 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	struct shmem_pkram_info *pkram;
+	bool preserve;		    /* PKRAM-enabled data is preserved */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
@@ -106,6 +113,23 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
 
+#ifdef CONFIG_PKRAM
+extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
+extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
+			bool preserve);
+extern int shmem_save_pkram(struct super_block *sb);
+extern void shmem_load_pkram(struct super_block *sb);
+extern int shmem_release_pkram(struct super_block *sb);
+#else
+static inline int shmem_parse_pkram(const char *str,
+			struct shmem_pkram_info **pkram) { return 1; }
+static inline void shmem_show_pkram(struct seq_file *seq,
+			struct shmem_pkram_info *pkram, bool preserve) { }
+static inline int shmem_save_pkram(struct super_block *sb) { return 0; }
+static inline void shmem_load_pkram(struct super_block *sb) { }
+static inline int shmem_release_pkram(struct super_block *sb) { return 0; }
+#endif
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/Makefile b/mm/Makefile
index f5c0dd0a3707..a4e9dd5545df 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,4 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o shmem_pkram.o
diff --git a/mm/shmem.c b/mm/shmem.c
index 60e4f0ad23b9..c1c5760465f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -111,16 +111,20 @@ struct shmem_options {
 	unsigned long long blocks;
 	unsigned long long inodes;
 	struct mempolicy *mpol;
+	struct shmem_pkram_info *pkram;
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
 	bool full_inums;
+	bool preserve;
 	int huge;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_PKRAM 16
+#define SHMEM_SEEN_PRESERVE 32
 };
 
 #ifdef CONFIG_TMPFS
@@ -3441,6 +3445,8 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_pkram,
+	Opt_preserve,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3462,6 +3468,8 @@ enum shmem_param {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_string("pkram",		Opt_pkram),
+	fsparam_flag_no("preserve",	Opt_preserve),
 	{}
 };
 
@@ -3545,6 +3553,22 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_pkram:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			kfree(ctx->pkram);
+			if (shmem_parse_pkram(param->string, &ctx->pkram))
+				goto bad_value;
+			ctx->seen |= SHMEM_SEEN_PKRAM;
+			break;
+		}
+		goto unsupported_parameter;
+	case Opt_preserve:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			ctx->preserve = result.boolean;
+			ctx->seen |= SHMEM_SEEN_PRESERVE;
+			break;
+		}
+		goto unsupported_parameter;
 	}
 	return 0;
 
@@ -3641,6 +3665,41 @@ static int shmem_reconfigure(struct fs_context *fc)
 		err = "Current inum too high to switch to 32-bit inums";
 		goto out;
 	}
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		if (!sbinfo->pkram && !(ctx->seen & SHMEM_SEEN_PKRAM)) {
+			err = "Cannot set preserve/nopreserve. Not enabled for PKRAM";
+			goto out;
+		}
+		if (ctx->preserve && !(fc->sb_flags & SB_RDONLY)) {
+			err = "Cannot preserve. Filesystem must be read-only";
+			goto out;
+		}
+	}
+
+	if (ctx->pkram) {
+		kfree(sbinfo->pkram);
+		sbinfo->pkram = ctx->pkram;
+	}
+
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		int error;
+
+		if (!sbinfo->preserve && ctx->preserve) {
+			error = shmem_save_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to preserve";
+				goto out;
+			}
+			sbinfo->preserve = true;
+		} else if (sbinfo->preserve && !ctx->preserve) {
+			error = shmem_release_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to unpreserve";
+				goto out;
+			}
+			sbinfo->preserve = false;
+		}
+	}
 
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
@@ -3714,6 +3773,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
 	shmem_show_mpol(seq, sbinfo->mpol);
+	shmem_show_pkram(seq, sbinfo->pkram, sbinfo->preserve);
 	return 0;
 }
 
@@ -3726,6 +3786,7 @@ static void shmem_put_super(struct super_block *sb)
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+	kfree(sbinfo->pkram);
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3780,6 +3841,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
 	ctx->mpol = NULL;
+	sbinfo->pkram = ctx->pkram;
+	ctx->pkram = NULL;
 
 	spin_lock_init(&sbinfo->stat_lock);
 	if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
@@ -3809,6 +3872,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+	shmem_load_pkram(sb);
 	return 0;
 
 failed:
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
new file mode 100644
index 000000000000..904b1b861ce5
--- /dev/null
+++ b/mm/shmem_pkram.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/pkram.h>
+#include <linux/seq_file.h>
+#include <linux/shmem_fs.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+struct file_header {
+	__u32	mode;
+	kuid_t	uid;
+	kgid_t	gid;
+	__u32	namelen;
+	__u64	size;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+};
+
+int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram)
+{
+	struct shmem_pkram_info *new;
+	size_t len;
+
+	len = strlen(str);
+	if (!len || len >= SHMEM_PKRAM_NAME_MAX)
+		return 1;
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return 1;
+	strcpy(new->name, str);
+	*pkram = new;
+	return 0;
+}
+
+void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram, bool preserve)
+{
+	if (pkram) {
+		seq_printf(seq, ",pkram=%s", pkram->name);
+		seq_printf(seq, ",%s", preserve ? "preserve" : "nopreserve");
+	}
+}
+
+static int shmem_pkram_name(char *buf, size_t bufsize,
+			   struct shmem_sb_info *sbinfo)
+{
+	if (snprintf(buf, bufsize, "shmem-%s", sbinfo->pkram->name) >= bufsize)
+		return -ENAMETOOLONG;
+	return 0;
+}
+
+static int save_page(struct page *page, struct pkram_access *pa)
+{
+	int err = 0;
+
+	if (page)
+		err = pkram_save_file_page(pa, page);
+
+	return err;
+}
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	struct pagevec pvec;
+	unsigned long start, end;
+	int err = 0;
+	int i;
+
+	start = 0;
+	end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+	pagevec_init(&pvec);
+	for ( ; ; ) {
+		pvec.nr = find_get_pages_range(mapping, &start, end,
+					PAGEVEC_SIZE, pvec.pages);
+		if (!pvec.nr)
+			break;
+		for (i = 0; i < pagevec_count(&pvec); ) {
+			struct page *page = pvec.pages[i];
+
+			lock_page(page);
+			BUG_ON(page->mapping != mapping);
+			err = save_page(page, &pa);
+			if (PageCompound(page)) {
+				start = page->index + compound_nr(page);
+				i += compound_nr(page);
+			} else {
+				i++;
+			}
+
+			unlock_page(page);
+			if (err)
+				break;
+		}
+		pagevec_release(&pvec);
+		if (err || (start > end))
+			break;
+		cond_resched();
+	}
+
+	pkram_finish_access(&pa, err == 0);
+	return err;
+}
+
+static int save_file(struct dentry *dentry, struct pkram_stream *ps)
+{
+	PKRAM_ACCESS(pa_bytes, ps, bytes);
+	struct inode *inode = dentry->d_inode;
+	umode_t mode = inode->i_mode;
+	struct file_header hdr;
+	ssize_t ret;
+	int err;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(inode->i_nlink > 1))
+		return -EINVAL;
+
+	hdr.mode = mode;
+	hdr.uid = inode->i_uid;
+	hdr.gid = inode->i_gid;
+	hdr.namelen = dentry->d_name.len;
+	hdr.size = i_size_read(inode);
+	hdr.atime = timespec64_to_ns(&inode->i_atime);
+	hdr.mtime = timespec64_to_ns(&inode->i_mtime);
+	hdr.ctime = timespec64_to_ns(&inode->i_ctime);
+
+
+	ret = pkram_write(&pa_bytes, &hdr, sizeof(hdr));
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+	ret = pkram_write(&pa_bytes, dentry->d_name.name, dentry->d_name.len);
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+
+	err = save_file_content(ps, inode->i_mapping);
+out:
+	pkram_finish_access(&pa_bytes, err == 0);
+	return err;
+}
+
+static int save_tree(struct super_block *sb, struct pkram_stream *ps)
+{
+	struct dentry *dentry, *root = sb->s_root;
+	int err = 0;
+
+	inode_lock(d_inode(root));
+	spin_lock(&root->d_lock);
+	list_for_each_entry(dentry, &root->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		dget(dentry);
+		spin_unlock(&root->d_lock);
+
+		err = pkram_prepare_save_obj(ps, PKRAM_DATA_pages|PKRAM_DATA_bytes);
+		if (!err)
+			err = save_file(dentry, ps);
+		if (!err)
+			pkram_finish_save_obj(ps);
+		spin_lock(&root->d_lock);
+		dput(dentry);
+		if (err)
+			break;
+	}
+	spin_unlock(&root->d_lock);
+	inode_unlock(d_inode(root));
+
+	return err;
+}
+
+int shmem_save_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo || !sbinfo->pkram || is_kdump_kernel())
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_save(&ps, buf, GFP_KERNEL);
+	if (err)
+		goto out_free_buf;
+
+	err = save_tree(sb, &ps);
+	if (err)
+		goto out_discard_save;
+
+	pkram_finish_save(&ps);
+	goto out_free_buf;
+
+out_discard_save:
+	pkram_discard_save(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM save failed: %d\n", err);
+
+	return err;
+}
+
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	unsigned long index;
+	struct page *page;
+	int err = 0;
+
+	do {
+		page = pkram_load_file_page(&pa, &index);
+		if (!page)
+			break;
+
+		err = shmem_insert_page(current->mm, mapping->host, index, page);
+		put_page(page);
+		cond_resched();
+	} while (!err);
+
+	pkram_finish_access(&pa, err == 0);
+	return err;
+}
+
+static int load_file(struct dentry *parent, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	PKRAM_ACCESS(pa_bytes, ps, bytes);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file_header hdr;
+	size_t ret;
+	umode_t mode;
+	int namelen;
+	int err = -EINVAL;
+
+	ret = pkram_read(&pa_bytes, &hdr, sizeof(hdr));
+	if (ret != sizeof(hdr))
+		goto out;
+
+	mode = hdr.mode;
+	namelen = hdr.namelen;
+	if (!S_ISREG(mode) || namelen > bufsize)
+		goto out;
+	if (pkram_read(&pa_bytes, buf, namelen) != namelen)
+		goto out;
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+
+	dentry = lookup_one_len(buf, parent, namelen);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out_unlock;
+	}
+
+	err = vfs_create(&init_user_ns, parent->d_inode, dentry, mode, NULL);
+	dput(dentry); /* on success shmem pinned it */
+	if (err)
+		goto out_unlock;
+
+	inode = dentry->d_inode;
+	inode->i_mode = mode;
+	inode->i_uid = hdr.uid;
+	inode->i_gid = hdr.gid;
+	inode->i_atime = ns_to_timespec64(hdr.atime);
+	inode->i_mtime = ns_to_timespec64(hdr.mtime);
+	inode->i_ctime = ns_to_timespec64(hdr.ctime);
+	i_size_write(inode, hdr.size);
+
+	err = load_file_content(ps, inode->i_mapping);
+out_unlock:
+	inode_unlock(d_inode(parent));
+out:
+	pkram_finish_access(&pa_bytes, err == 0);
+	return err;
+}
+
+static int load_tree(struct super_block *sb, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	int err;
+
+	do {
+		err = pkram_prepare_load_obj(ps);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
+			break;
+		}
+		err = load_file(sb->s_root, ps, buf, PAGE_SIZE);
+		pkram_finish_load_obj(ps);
+	} while (!err);
+
+	return err;
+}
+
+void shmem_load_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&ps, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	err = load_tree(sb, &ps, buf, PAGE_SIZE);
+
+	pkram_finish_load(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+}
+
+int shmem_release_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&ps, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	pkram_finish_load(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+
+	return err;
+}
-- 
1.8.3.1

