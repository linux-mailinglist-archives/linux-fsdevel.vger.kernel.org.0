Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCC34F35D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhC3V2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33500 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhC3V2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPOZr123006;
        Tue, 30 Mar 2021 21:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=O9v53orIHWVFA1t6PmlxKgAQW3yTqWCLxZiYmn97ZuU=;
 b=CGTjQF+Q/1/OBf5CjVdoeaL1RTUkR7Id+JWZAW56Xg30WsQVzJzmKsxnbZ/W9A5ZfXlI
 jILcTP9twgjc2n1nYtJjtw+cHeOxsWAxDextN0aLQOFCPPUv4sN992hMvF2cD+aOiMXb
 q7CY3Up8yg2Rm6pTuNtFwComwRShTh+zPhX8II8T/Fu4JRWLose/gM2cPZUoWjKDed3l
 HyU5A5CSDPgtULVxVYi732DboztuyumKOQg3Pd0O+FSlvVrkH1ZC/uvIrgXiX5uSPxMI
 9VRMhOO3E5vXF43EpGAorEpm5Eyscuvfcq0hhQz0kOoHlH7zVMi4fn+mbZbrzdXBR8iB 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37mafv084p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOaCI149646;
        Tue, 30 Mar 2021 21:27:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by userp3020.oracle.com with ESMTP id 37mac4kg35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfkdpaSjZM6RIzLgs3S46Hg5PPjaxtZiNfvlj6qbtd35PM8kBWubErF5dgpK07yvA8TGtoXSvSmP3ERjuPmiLa9oFgiJWqC0b+ZAShFvbg8rYFVxt63Ed6ITa/TKL+4Z+khUgdtqRpd/QjB+qzlBPJDw6l3unyJ4DGwVOKXrK2DJH1OQodT1bnzLQ/qQ4gLnfus0Y6pEHZOpf4u0cShhWs6ihiFs1Y4G7x2QFBzjUdFxTjWdA0Xq5XI3GXyRpQfAtElOfU9lnCDAztDdI8UZsTf5KJrAjInb2vLVTDVhYP+85KNG0GCf+lIB22zVu+D2l2bgnE9UapSMntSsf9KSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9v53orIHWVFA1t6PmlxKgAQW3yTqWCLxZiYmn97ZuU=;
 b=Qm/Lo12QMZqOn2vPeIG+P2zxwfZVgUzWCJr6o3g0DC7p+HMRE55//6jfa0m6pxiEHv+nHYEfp3xIFrwJAz9FNDc4ri6NeH4xqfUSp97oI6b0C0I6Ga7gmDONpRSxn6+cVS6jZkMR5EmAVMA3ub1VfO+l3A5FTWXGpo32rXkdtmftjqsvABxZVqqguOaHm3RRhsQDtEPO+yPOfoIJ3nF4a49+RTBX0hxD3JcLjx1+xQDtvya8yjxaoYCBHjzKR+ev9StyIutfO+gbZBSqp2T4VZPJrB49hjfZjGGT6DS8KNa5alNJKb9sO7F9mAksColJsynv3BYA2V4+pGVP2C4SRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9v53orIHWVFA1t6PmlxKgAQW3yTqWCLxZiYmn97ZuU=;
 b=vY+8PIq7zd2XwB2RFhaezVEgmSWAkFUS9M5gWg4Ci5admvH3ERwYsujcdpuNNOdQgXq9GDY0ne3O6Jjdq1hbJytLcsNRll4ei7h9I9vHP1wWQDeXQ7muEClMXvo3DAbpXgFYZbKKFrCQNUY1hpBMQu/ue/wE9XNztSXHe2wuh9Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:28 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:28 +0000
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
Subject: [RFC v2 34/43] shmem: PKRAM: multithread preserving and restoring shmem pages
Date:   Tue, 30 Mar 2021 14:36:09 -0700
Message-Id: <1617140178-8773-35-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5208b1b-b954-451f-3045-08d8f3c29e57
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679BFF61F846ADF33371490EC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Crl+KjBU0BGmpJaLt1bVcgmKAhrXorItGUvhvG4ToYPpqtL9OET9zvTfBeFeou+QzwsxBnvEBJLWpd9eUb3lpysWObfFxyQUKmKobEeCGMwz58ZWHM8pyKkLr7AcMOJZwZI4RBlWOhNKLvJc/+TX5fUGiE/U7GRZIvE3vvMcrmvLMSk1DoxInerxgvaXVnpuzF3GtoKylTNF8xBDWojNLTsPsH/YumtExKavVpVslxE+/1ZaI31gwC77KZuZiyc9aaKUJFhK+OK+szAjgN/BQsP2z3p9PNCS11MCfLQsaj5lyzyFUMNqejG8kg3iWtNKDC5Oc3JdE/phA1uZGfG6cNtw5WKPpq+8uzSNeGbYaAF9FNk+ZHWeBjlsal7R5SKi5M1LSdQrrOCzfzy4JNaTafsgjhy4kKWKP2O+VDp+KALc7sCSYy3RBfsadkgiE6yQq2oTARFUcA5f/O79tw0OXyUC/NuqiTc3DmWg71DQ8BNhUWEP29rHsSio+7Qecf6jdZZBf/Rv0EnREdjWbMflCa+0ejhSTYIzG1ivPt7b9+Jubd1CAsi1pBjGVuArGqrtFLwhCWZeBN4Zen5Nh0aRX1A2Dh1YDFl43HhL+aLrEjIbaRdE7El65EcEkQsgoxENZAJaKQw4++V74SptEwAEfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6666004)(4326008)(86362001)(52116002)(186003)(478600001)(36756003)(5660300002)(7416002)(26005)(66946007)(66556008)(7696005)(2616005)(16526019)(8676002)(316002)(2906002)(66476007)(956004)(38100700001)(6486002)(7406005)(8936002)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xfLrXmkQncPnVFrxt4kMdivBqHo7YnvxsNl3+n0mBq/gb1MYjMf5owjilYKR?=
 =?us-ascii?Q?yi/OqSV84CarHL0d3LQRgRBdO37D3K8yl7tOaaUT5qfbQa6BhH6JPeTriRHD?=
 =?us-ascii?Q?JxCdnl8kwXNVdlvHWH1mskb7IRgAvGALvRP2/8jMopWb4A9otGBCkLSYs/ob?=
 =?us-ascii?Q?/wxsd1l1KV6s4TgOKP4AhXXVQ09yc1MQZkhB3fZtBalW098fHEIKbxXywHHi?=
 =?us-ascii?Q?k5nwJjg7sJZpN2HXF47BzXpcE7wgUhICPO5ify1yWeV8bVAJRMjdp745/R9u?=
 =?us-ascii?Q?tORovvN9Y07vA+sd7/SWE8DhG85aClsh2oeVzjfvThSNOpR1XFaUyA69rXpH?=
 =?us-ascii?Q?Pfw5c2ySHtf/Rt/kSoTBztMTOQLSOYnAX81WY2EuSS+VW1Yvi2ZYJLq5uWFv?=
 =?us-ascii?Q?QymM9HKuSIGmT40vLSEeqMyreIPFvmwWYcB/tDKY7jw0nWLUQPZxMI1ccjKJ?=
 =?us-ascii?Q?0qQq/Nv55uMdkewb7htLKuWxiZdKhW7vmyvNuJCwmykgYyxL45O0XCxSpEip?=
 =?us-ascii?Q?Mby/sZN2AuuLq5zQHrkDDqYAgdE5ZXU8m6RbxYU/87I8kSWvjzR4b7XVYaEX?=
 =?us-ascii?Q?WgExjGuyfN1rau+t67bjeXL78HakjfIpZkaBfGkqPpxG/VgYE3pyzVNySubS?=
 =?us-ascii?Q?70JxZp1YthgWhSIWWVCoqKSYuf+wpTejifS0Pktrni2Ejaxss6yED4CrLf4K?=
 =?us-ascii?Q?Nyt4Fjo0u9Eiv79VD7S0NdX67JJSS1aehlZKrHYNa6xNRJPGvQwFhfNUNeMk?=
 =?us-ascii?Q?beusu3Ipu4Qzt8GPJmsfsCKlMxehbS/N3H2s17l6cEPViDEPqrnjttC3z75+?=
 =?us-ascii?Q?vSeXkUaI7UCAGyN2cbMFOjHZuYhh0i3IXjEJO7m4hAVmHPAk3gGhQ3ACLk+v?=
 =?us-ascii?Q?tr3wj/XAwG/3qwsFioNcTubZljcYuFFJdhSqXyPe9qD4jRnvzj3NTkTiW2Jc?=
 =?us-ascii?Q?hhlnSaH2aHpnJ1T6hV8IaAbrBHbRJSUKKB8CvIFm44IN90vw8zlFddQEaQRA?=
 =?us-ascii?Q?knL30zD+sGhVDOsa7+QeWjskGFmw8acJGa6fMF3I27wG+25Rzq4XG6RUanf9?=
 =?us-ascii?Q?15xL+hXm1gqFckf1f9O9+XuhoDqpn4xjy0AzlpLimFQN9xwH2eLNs76zaMoN?=
 =?us-ascii?Q?rV1MX9Eywqmj+k8ug/U/NojM+bbdwhTt6zCyhEgWDClq049NkYbSByT8eHLo?=
 =?us-ascii?Q?KyN3avKBRXJveKb9X5tV8eppwkQz9W9TvHAj/BhDnTOUff8uCFLn5lqK3UlO?=
 =?us-ascii?Q?3gastAJh8LGMW5F733MIHQ4dtn+3V+y21cFhn1adTP9HZ5fmyCRd9jMljwrJ?=
 =?us-ascii?Q?IG1sK9F1o1NeZYVqDBZVbO0E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5208b1b-b954-451f-3045-08d8f3c29e57
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:28.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+Aneg7LPZmZkwsnhN9dZGCDtD6R/LgH2qFbKZCYKXfM7uIYPgCVEvFI98q1eTOmMWsqWbu9QUyGOs05tYgpmPrb3vEf5hhOqGS+uA/YnaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: oDW_VUMVb_UCVg6X3iKbZPfCVZqVSO45
X-Proofpoint-GUID: oDW_VUMVb_UCVg6X3iKbZPfCVZqVSO45
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Improve performance by multithreading the work to preserve and restore
shmem pages.

When preserving pages each thread saves non-overlapping ranges of a file
to a pkram_obj until all pages are preserved.

When restoring pages each thread loads pages using a local pkram_access.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index e52722b3a709..354c2b58962c 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -115,6 +115,7 @@ static int save_file_content_range(struct pkram_access *pa,
 }
 
 struct shmem_pkram_arg {
+	int *error;
 	struct pkram_stream *ps;
 	struct address_space *mapping;
 	struct mm_struct *mm;
@@ -137,6 +138,16 @@ static int get_save_range(unsigned long max, atomic64_t *next, unsigned long *st
 	return 0;
 }
 
+/* Completion tracking for save_file_content_thr() threads */
+static atomic_t pkram_save_n_undone;
+static DECLARE_COMPLETION(pkram_save_all_done_comp);
+
+static inline void pkram_save_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_save_n_undone))
+		complete(&pkram_save_all_done_comp);
+}
+
 static int do_save_file_content(struct pkram_stream *ps,
 				struct address_space *mapping,
 				atomic64_t *next)
@@ -160,11 +171,40 @@ static int do_save_file_content(struct pkram_stream *ps,
 	return ret;
 }
 
-static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int save_file_content_thr(void *data)
 {
-	struct shmem_pkram_arg arg = { ps, mapping, NULL, ATOMIC64_INIT(0) };
- 
-	return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+	struct shmem_pkram_arg *arg = data;
+	int ret;
+
+	ret = do_save_file_content(arg->ps, arg->mapping, &arg->next);
+	if (ret && !*arg->error)
+		*arg->error = ret;
+
+	pkram_save_report_one_done();
+	return 0;
+}
+
+static int shmem_pkram_max_threads = 16;
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+ {
+	int err = 0;
+	struct shmem_pkram_arg arg = { &err, ps, mapping, NULL, ATOMIC64_INIT(0) };
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(shmem_pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+
+	atomic_set(&pkram_save_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(save_file_content_thr, &arg, "pkram_save%d", thr);
+
+	wait_for_completion(&pkram_save_all_done_comp);
+
+	return err;
 }
 
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
@@ -275,7 +315,17 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
+/* Completion tracking for load_file_content_thr() threads */
+static atomic_t pkram_load_n_undone;
+static DECLARE_COMPLETION(pkram_load_all_done_comp);
+
+static inline void pkram_load_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_load_n_undone))
+		complete(&pkram_load_all_done_comp);
+}
+
+static int do_load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
 	unsigned long index;
@@ -296,6 +346,40 @@ static int load_file_content(struct pkram_stream *ps, struct address_space *mapp
 	return err;
 }
 
+static int load_file_content_thr(void *data)
+{
+	struct shmem_pkram_arg *arg = data;
+	int ret;
+
+	ret = do_load_file_content(arg->ps, arg->mapping, arg->mm);
+	if (ret && !*arg->error)
+		*arg->error = ret;
+
+	pkram_load_report_one_done();
+	return 0;
+}
+
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
+{
+	int err = 0;
+	struct shmem_pkram_arg arg = { &err, ps, mapping, mm };
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(shmem_pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_load_file_content(ps, mapping, mm);
+
+	atomic_set(&pkram_load_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(load_file_content_thr, &arg, "pkram_load%d", thr);
+
+	wait_for_completion(&pkram_load_all_done_comp);
+
+	return err;
+}
+
 static int load_file(struct dentry *parent, struct pkram_stream *ps,
 		     char *buf, size_t bufsize)
 {
-- 
1.8.3.1

