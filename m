Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43E334F372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhC3V3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhC3V2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP4EC145279;
        Tue, 30 Mar 2021 21:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=GZb4CKpxRwLNdd15u2UORaRNMHAWzMb1KyTaA8tHhy4=;
 b=mqRWvebD0I6wpyEJqjoYSO8ruKRCQ2WYAgSR7o2rieUPFL73AlwFyiDhp+Nsxokp/Imh
 3ncEXPYbHcwOEDa6ZxM6IoocCjFw7GEQmCupqbf1xG7Ts+L7Xpj/++kRQ5KDYM8TCk7c
 5BzUa/PyACJGKlUxAASVTzHrOX3nM97c11OWl9J7QRTv73MeVL34bWOIcndQvpxJ4Xai
 i3c8GfmK1bEIV+A7Ex/DNmb+fvkZEbzSJ6ra00Mjlv0SA3zyt+noK95y8xoB98TU+y8D
 MpQRWK9BUamAmjF1aI+vNp/FQ7f4FiKVHK/Ic457Kh0liVFRyyuFWGvgD4wZtRrxvJPu vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37mad9r8j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPRHc105743;
        Tue, 30 Mar 2021 21:27:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 37mabkbd9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpI7jMc0Uc59Tx4VVJWOS2ZbVjg+g6Bei4PNGcCGVu1f60bEPUiIy9pQnk/QCq6OmrM9o8/uY4d+D0Mqx29mGsTXS3e+mpwi8fEroLtqn+1DYlBMMlSRRTiRutfmiA2sMATCAacJgBuGIhBZqBzTxKFUQPsanblezIsvTkRSm+ke21WpKLDw2mZavGjrSYjf6jvpI9+7m3cAapcy+aA54C+RtLf70N+aCdMG0mBk5ZODiURD8JiaSciPIxzrOh6kdNvNVrpv5hH6Re41oOz5feWiXSjk5TX5URnD097KxZvnnxhNmUR+lpVx6Jwhrv3umsZsRCME3XiSVMIm7+QaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZb4CKpxRwLNdd15u2UORaRNMHAWzMb1KyTaA8tHhy4=;
 b=IIWNU6qCAlygsm08rB+7/Ed+wSdU8SaGDu0nAfL2YEQNtCl4Su0qfoNc2ebopyhguXHBMF+zaz0K8BY9Z0Wx6T13JXnRp6XmvwMqQAxx3gNG/fZ4Lygmid8D1ZExaWKI2KwhuxiOMcrnwyYsKEnN8qYmGk1TZjAecFVL+rq+Cr0lis1PeLD8v0QRR+6ldCxklJT2GceMVTA6VjrG9XJhxgzkJC/hbuz53iiuiDVY4opV5j2yyWgfMvpOxmw8snAvZ8rpXlkDornU5tCEvXZ3sCMPabp7l9jvo/3CfoliYRR5DoBAO4XPFvM5cHDERMJZBQwrWK6+bgIcSfWoOxa5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZb4CKpxRwLNdd15u2UORaRNMHAWzMb1KyTaA8tHhy4=;
 b=KVzuITmvTMKqMWq2Lo+tOy0nMXa2xnpi41r3QpF0KuC2KazTOpaq+v1JfCTX53FH1PkZylSkDeqkKoTkJ26MMNz3oZy09Pf7M6OBCuXXVkzRCE88PJhAaPg+yJE7qgoYf29jVeYKP6iiqI2R+VqA8A7ioRwgqdycdOtQzJ57EKE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:36 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:36 +0000
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
Subject: [RFC v2 36/43] PKRAM: add support for loading pages in bulk
Date:   Tue, 30 Mar 2021 14:36:11 -0700
Message-Id: <1617140178-8773-37-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24a46131-2667-4eca-bd58-08d8f3c2a375
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB52650E5C2C3AF4C0E7D8D806EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze00x5J0RiFSrqhD7dupwIb+f6ZKYyOFV3N+LvLIFVqoCG1dITM/qHKqfghXQhMPt2/79wPVTt+lO8/Ynb8OzkFMRLyDu/gsgPXhZn0pjTqik8J1WPHbIV8bnArwxDmdMPXQxSYhWpsuPY7wRp1+n02JgF4JTy/stdbxFAM++zsGOxyacPB7ceI2Gd5DX9fP8LfmeHwJSCLw8u/vpQ5LibS6E9bv6PzZ47O/+8i5RWLHuQPO1o5Plhz+uj1lQCAfR4cENh9T6On9zI4DHXbhH4c44s2DBAum36WW9LZ5NlY56QFxRvMlvxRA6AQVcEsBCF3rk5TRCcNi1eyNMBqKBOA3qQpUH/CYpe6EM3yIY1DwwtMI4iUey7Hznq4K4t6fFeCAlEyai92iknWRG046ZuaUVklZsNkIfTBRUWCcXXaaXTJRYieopK7IOi6ku2YcoGc4adyNaWKfzAahM8uHv2oBDWtgAml5M3xMu3xOIXR2Q/uUvjt9SjMwEHPRNj9dqZMTOsJNJYtV3a0TuzlBVsOxfY2rCcSToTdZkeEAm/k14zMZsL86rN6Ta598k6GTCPAnr5N2TCVJt8sfauwtyRWy2up0wXNQ00uuOgtRWNBIsflyazJ1z2Shh26JgVNeAXN/t0In/58pGJhVDM3nqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KVjdA1n0AV1WT4Gc9zYDX932WmIDW4OxC/dMk1b/ZEo+yW8GNbJDQvCV6tML?=
 =?us-ascii?Q?DtUew+84kmjj5HhojABgL6+TDMD7YJAuW3n//FUkmuJLmZW5u2N/7o+NPm75?=
 =?us-ascii?Q?GeAa+CpcebQ2cdbQD199rfWBWlnwiQaATF4SuatK5wYwPRxTSD/vrcqUoD9Z?=
 =?us-ascii?Q?IFjp6Nuf93nLuCswGwSPrbB7OflpfaFX982uOV20KyWViUT4YnA+U8P79Ve4?=
 =?us-ascii?Q?BMuka/qm/pKbKaEhr7JwsNeiJvRA6asuosOeK+UoZW0KIIdnK6adCVjjozji?=
 =?us-ascii?Q?d6q5xcCkG2EFsaebyUk8tSoT8Dk0xXFcEb/YHnPZcA4NY8KVPb2ZGjCzh7Td?=
 =?us-ascii?Q?ha0jYkgnDt6DNOQrHodneKPmNA/kIb2HJ2JdQbW6mBFzOJYsttuI6T5ycoi1?=
 =?us-ascii?Q?1CQo7M5vuNPRSpFdEvSwqmA0kuk1qsGircgPfSGx1ohTvD3CWgrPdYwkCZKV?=
 =?us-ascii?Q?jw8fu1O41DWQh62ncYcdprsSBDhYj9Gxgwu+KVqUiSIVle4TKJ6ob4KvkO8S?=
 =?us-ascii?Q?9crINQS7rXkUK3IjIUI2Wtn7CU2NsLOAud7wiWKFx/usrU8vDFcyM/AeS/e4?=
 =?us-ascii?Q?5s4nmAwAuWmv2k00frGZPNksMEtZEgouHGhio2ZFxzhrMnoZCLfJBZmGe4JZ?=
 =?us-ascii?Q?N3vej2zQRg38Gu9R4G9h+D7SxStNZFaUPD7rpLSOf97r2WmwhBPHD1VIFJAk?=
 =?us-ascii?Q?p7m1ux5PiLKqNTgT50KaxS0Mv2jiPRMEYVK/wxaHY8rhQw1MYTqjSoE7qTwL?=
 =?us-ascii?Q?Ev2jRurgEOFZPfyugayEFHqZjbo3Yj12JX3d9+rTLB9D/9dffGT+TY14JRij?=
 =?us-ascii?Q?El65CiYpmAXmJr7M0nW6xyJZPNY4sIQsza8pleSSuJqrPfjlVshPHeDpvuAn?=
 =?us-ascii?Q?AlBEhVPyp8hpCnWt2ZHvl61WSbkf+XzG+snAWxLq0jiyJ8doMPohYllsfbk8?=
 =?us-ascii?Q?E2+WPX12txBCTt57216AD6NBXRsWlauux5fuCcfL2Hg+aQOKht/ClaQ7v4xT?=
 =?us-ascii?Q?KA9LHiP1FUQgmcS70yP2sRnytA175oSK8pm4vRTdkxFxnzzI4uXrkZ/sHMqb?=
 =?us-ascii?Q?38fcyi9f0d3Yikp1d69ONwJs7rRkbWnV9SH5lJbUlS7VOxXdswwezJGvgRVs?=
 =?us-ascii?Q?rVYQMNHcGgdjJrTcm2X4JFcYMn2sk5h4dbQKk4nb/jrkoiIvp+UagRkfxSrr?=
 =?us-ascii?Q?945MLY6rKAIHUaS5GMSEEUpHVpQegmX15nvR8fUik4Jno/r1c4yeSbkF9WUW?=
 =?us-ascii?Q?w4gHqw/GDdUGA+OLrgoDR7mhkrvv9K8I45ZaQ3qSS9jCfcnMzXdvjsJUS8cO?=
 =?us-ascii?Q?VU/SC49yk4Y14ziK3Hxzuc3P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a46131-2667-4eca-bd58-08d8f3c2a375
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:36.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx6J6g8oVLew/mQ8rJaDTzvnXWq/48/0rAOX9+LEMTljwfQjPw5etuyKfCHmYIAB0PMLZzJjvJnqf5wjVmT5chP31MsYhY5/736jHrAzTAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: N85R9sVWvAIJVK2_WzLDZcyc4B5qvzPL
X-Proofpoint-GUID: N85R9sVWvAIJVK2_WzLDZcyc4B5qvzPL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a new API function, pkram_load_file_pages(), to support
loading pages in bulk.  A caller provided buffer not smaller than
PKRAM_PAGES_BUFSIZE is populated with pages pointers that are contiguous
by their original mapping index values.  The number of pages in the buffer
and the mapping index of the first page are provided to the caller.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  4 ++++
 mm/pkram.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 977cf45a1bcf..ca46e5eafe71 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -96,6 +96,10 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 int pkram_save_file_page(struct pkram_access *pa, struct page *page);
 struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index);
 
+#define PKRAM_PAGES_BUFSIZE	PAGE_SIZE
+
+int pkram_load_file_pages(struct pkram_access *pa, struct page *pages[], unsigned int *nr_pages, unsigned long *index);
+
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index 382ccf6f789f..b63b2a3958e7 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1099,6 +1099,52 @@ struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
 }
 
 /**
+ * Load pages from the preserved memory node and object associated with
+ * pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_load() and pkram_prepare_load_obj() and access initialized
+ * with PKRAM_ACCESS().
+ * The page entries of a single pkram_link are processed, and @pages is
+ * populated with the page pointers.  @nr_pages is set to the number of
+ * pages, and @index is set to the mapping index of the first page.
+ *
+ * Returns 0 if one or more pages are loaded or -ENODATA if there are no
+ * pages to load.
+ *
+ * The pages loaded have an incremented refcount either because the page
+ * was initialized with a refcount of 1 at boot or because the page was
+ * subsequently preserved which increased the refcount.
+ */
+int pkram_load_file_pages(struct pkram_access *pa, struct page *pages[], unsigned int *nr_pages, unsigned long *index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link;
+	int nr_entries = 0;
+	int i, ret;
+
+	ret = pkram_next_link(pds, &link);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		unsigned long p = link->entry[i];
+
+		if (!p)
+			break;
+
+		pages[i] = __pkram_prep_load_page(p);
+		nr_entries++;
+	}
+
+	*nr_pages = nr_entries;
+	*index = link->index;
+
+	pkram_free_page(link);
+	pds->link = NULL;
+
+	return 0;
+}
+
+/**
  * Copy @count bytes from @buf to the preserved memory node and object
  * associated with pkram stream access @pa. The stream must have been
  * initialized with pkram_prepare_save() and pkram_prepare_save_obj()
-- 
1.8.3.1

