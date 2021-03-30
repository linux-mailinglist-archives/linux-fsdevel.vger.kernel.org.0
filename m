Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0379E34F317
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhC3V1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhC3V05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPCo4145310;
        Tue, 30 Mar 2021 21:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Vf2+P//blblnbGasvOJNQrK5gTSuHjVLlcP/vpjWUaU=;
 b=fnSM/zFJTQ6Mmg6wdLZyg/cpTjVEaSaDUSpgU/W/FIOJL3Nmn6MiFPbbsIOJ6TUz14Ah
 jsoMMCipAMPI8FyhmHUWgH6GnzS4WvsaXqlIBcr0uo5txabLtUNZKVfoeuTCu6U265Ms
 loleFHVrlRY7/Znboo7T//Dz0Kkvl8cZQSOy0MwMiB6ghYVTMVgkY9VoXtqSsWd2BaAG
 F/LSWThaTBGyku2cqDHZMSMV9ZvuixiIHCO2CChEbEWL1zvN+Cp2xRcOA5q7h7Ftp6hu
 0D6A5ZTt6obsbOpnVHuR8pF5H4aNnrgFAudYujR5YW358fWG5FGHJepybwtYRnF0kMWR MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37mad9r8dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOnTX184142;
        Tue, 30 Mar 2021 21:25:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 37mac7u3tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abZeMY/d7PKe2eglcqbMO5q3GS6EFRsE59MjbCZZoQJnXB/B8QUX4YCiUpUQxooKNQUSlQtkaksD9+FXPCZy69yQHLoCoyMTUk9uMYGqGvXaw/Whj1+ahbfHnvJaelv4CEsHDNrnyHQ3o5/GVQogVOz/Wto9FvepkspFad3Q1GiH4wvO27qs6VqUrw9c//65NMvdZpJwy/r3UwsPmh5D3Id/AlbEgwzWi/O7sFX2TpUrDLBhF0ZM3+cM03CDOG+VJQybxrfawwajbCK8S5fjaAv6iEsx+eMK6SntMPD/YbARwyqFZVrNRsEv1hnltwqvHliQqllp4Sy9TnS89zbibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf2+P//blblnbGasvOJNQrK5gTSuHjVLlcP/vpjWUaU=;
 b=a/M103EdwCNm6/+Xcc5Gr0AWP9FT62Iovw9J4hHuGZmc093O3CIxMoKNYG4NrNxVl1AvUA7TAcCd0a00nIaQiA935Syf+wUHox8lHZ4A+5CWiYqGvQFBNaRXT5hb7+BrwCEApKFPkNfBIZ0R6KmWMv8r3bRNt9aYULo5m12UWMGzGMBY5geYWCwbzohQQn5wzPeV1B56FG8AxKROs66HiKrQo/f/xpzF30lnlUK9BUUvx3BsEhOSXbvvZLnn+N6PNlf/Qp/JugJmKZ6SsSjDxxlowO4iZ+9Kt1EBhpZupwp32JPWL8PW7P1hjiATkrYg9ySruKbnjtc79y5O6C+tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf2+P//blblnbGasvOJNQrK5gTSuHjVLlcP/vpjWUaU=;
 b=fdAUq0t43618EDfGIXEypCchQ8T6SYZ6lBAFQigpHF4+1YwQ3BTmjZ9gyXu+/P0cv6dRTldSe+POwyUfHix8TNdsxzbyW+5Ko0veGw64axHDmy51EtR2XFW4wOD3287wAYSGw36FiXgz5GcDRAVnTpXVaCDYpx+XqbYFf/RgB1o=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:08 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:08 +0000
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
Subject: [RFC v2 02/43] mm: PKRAM: implement node load and save functions
Date:   Tue, 30 Mar 2021 14:35:37 -0700
Message-Id: <1617140178-8773-3-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d6137b-6f76-42e7-02ef-08d8f3c24b1f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3120432C5C480472CF922F06EC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYlF3OqMu5RtbmKD2rIG1RW68YQ+3Fc06VmpZBAiaeMxjsFFUkg2fMOcgdjHTzu8rB4IqUkx6nZcBVvpNJGDR82SiDnM5pNKn3ElOZoiZiA+iq+NMe4A3T1C5tHLXVg9aVQJA15dV9o4dmoLEX4pnTrcLjEnmhQ71/Gdjcbf3yjSZ8M2JorhGRHuGWfSm9ETl60G8EnIzRJkZ7POW9lhzldWcwXL+yASUGHh9e9Tm21tgcJ7jDkaKugYCdZ1WYv4KEM41caWFs/fPugyCeFC10N5p1e4sTZTqus+Frz7Ru7iSOYp9zomRdfM5+an/+uDUDALP3O2NIkF1dyLehrf7BXi6X13MsbJqFAt6jeopl/pIYp3YCAJKTGB7QyIuBMW4ldVT5nQrLu223uDLaEvA/MmoxDOm5/6CX95CmgkAcUpvVxTuOUfUCjEx7ltkA5v9arr2KQ5fsVQojU8wTU2yYwDRVUcFXynp6Q62M2tMAfljTbALHAP8R/sqFFtlLS+Lije7OH8cqGz4jiD0kND2PUBXJfIZ+XU1nwPocQ/fK6mbyp+Db85wE59t/6fZEPbmBDSSBfWBx7W34iq/iB8lkmYKC5cPLmu7jOPeMtYH/HRpXc0vIJjHr4KsRPQ3tvPJLKK2rMWD76xgMdF7qNmCbgPUXHtgn2v6Xzg5+N3fja2qGIdvaKVGxdWvKPNUCs/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zJxwS9HiYyHMdrKuRmK59Gd45ShubpZlA52qktc8NNGNcTgrKXOnTENM+6i/?=
 =?us-ascii?Q?wccGKfRRYS148Kh6oRTahFCY+4aZaaaQRpCydQ1FWRJ8SZslTtv//+kRQ+iV?=
 =?us-ascii?Q?nTiAt+7wOuoeywifwQ9c7/mIB7o9yWN8WZz7DLaGmjmkP31PJexp/ioFf4bM?=
 =?us-ascii?Q?V2SDj4yX15QKtqbr/9PIa5h838YpsxlNN98X9zVfvht1ndMzFka2b/urUfB0?=
 =?us-ascii?Q?d6K/Y6EtDerkTRRC3D2CMKqgoOcMcq5DCRKLovN3ItaWiM11EVboPMwomGDS?=
 =?us-ascii?Q?9PeKVc88i1cMAj/cKUK1GayEedJOpyPOtKbRtRByjcfrskhOiPFBf6USpNVF?=
 =?us-ascii?Q?BGiOarZOMg1Xu8tsHrd7DP8c96UjZKJMjNGWLbSZm1pDxC1ou90CvheXUnLs?=
 =?us-ascii?Q?4gDfUdhsRrYmYWCZ3zl6Uh+qKYwIhEcWX2AQZHniYxBxq72/IiRtD01nfwAQ?=
 =?us-ascii?Q?mI8t2Ap6bFMlcst4LnUTyHDVw9HcidYnJDq4/HTLf0mOdbFoKN5mwyJJyOza?=
 =?us-ascii?Q?/UIQXAcifGtcPWPNrx1wGCjxb5qaG8hUykobaPTApAUwJJs2ats4dqfbpaDh?=
 =?us-ascii?Q?XMnnTG3bMNOAfXJNjMFxUnFEgCyniZaycMx0wkI2gA6c5n0r/ysldE7pm75C?=
 =?us-ascii?Q?CXl/LsAlMGq3V097o3xwsP5NfHylx6HHcL8Pz6lHYDTJBuI1vr5s5fcOuUaZ?=
 =?us-ascii?Q?1UkrrULEcw11e3aEVnG6UpgcOsx9zD6kp3LfGllx/Ygw5h8hHQ323zSOkZWg?=
 =?us-ascii?Q?j87AqBRPNXF80L/A5dtl4XR6UyASMeR4O3Io74f/Cby0tPgyF7eXwiJgTW/v?=
 =?us-ascii?Q?i2pzoZA0xpX2QUHWHsGl7xDTBQhc+ZWUtkJjDVfViROHiJybmmCoP1YkRiXr?=
 =?us-ascii?Q?2w0J+PF0XAvCZA9dZc9mFf8eNFp7JY+UixdIBz8pAnm98JrQjV5RH+P7GaQN?=
 =?us-ascii?Q?U3VJ+2XxEWos1uhYKM3kA+cWBgjQTWvqX6Ujc5Ke9phHvm7tdp3WQs6y4gZv?=
 =?us-ascii?Q?NQPRUBDmkYfu1Qpt+TT9qXGxApW8mlR0YAOw9uaRb1yIPDzXezOOfeDgRDBc?=
 =?us-ascii?Q?Oouuhy9CgsYjia2C7j44NnfSF66wF8kyCZ3LKah3E3dauaX7/qqtfNPwjdNm?=
 =?us-ascii?Q?iGSj2f2Vp+jDsCmbzN0Niqj4XI/FBpy5edXl/1boqCifVK2hdd1Ehmr+vMjV?=
 =?us-ascii?Q?v0y7g14SZpvytCTdLPRWdiTA+1WBY9sDfgMylS5Y/aJHPK6MdqY0Gkl2ljiQ?=
 =?us-ascii?Q?CEUMtjZvZ0GNjTlQqrUpDDq7I8wnt4FF01HGm+fI1TnsR58FdWtQtD7zl6SM?=
 =?us-ascii?Q?XMH2cuWtHzw2eevBFg6vYZQl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d6137b-6f76-42e7-02ef-08d8f3c24b1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:08.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuz81d8cXglpzvaU+wVP5EFoY1bFVsLIyncjDlwr//SoCfn32dFk1QavSm0QTevT285AxzlDgNYRq9KVfComYSmlgZKJe6Tlg4Tde723mc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: kE4H91EIaDeftWTmgNuk0X_566WalKes
X-Proofpoint-GUID: kE4H91EIaDeftWTmgNuk0X_566WalKes
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preserved memory is divided into nodes which can be saved and loaded
independently of each other. PKRAM nodes are kept on a list and
identified by unique names. Whenever a save operation is initiated by
calling pkram_prepare_save(), a new node is created and linked to the
list. When the save operation has been committed by calling
pkram_finish_save(), the node becomes loadable. A load operation can be
then initiated by calling pkram_prepare_load() which deletes the node
from the list and prepares the corresponding stream for loading data
from it. After the load has been finished, the pkram_finish_load()
function must be called to free the node. Nodes are also deleted when a
save operation is discarded, i.e. pkram_discard_save() is called instead
of pkram_finish_save().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   8 ++-
 mm/pkram.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a575da2d6c79..01055a876450 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 
+struct pkram_node;
+
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
@@ -14,7 +16,11 @@ enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,  /* No data types configured */
 };
 
-struct pkram_stream;
+struct pkram_stream {
+	gfp_t gfp_mask;
+	struct pkram_node *node;
+};
+
 struct pkram_access;
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 59e4661b2fb7..21976df6e0ea 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,16 +2,85 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
+/*
+ * Preserved memory is divided into nodes that can be saved or loaded
+ * independently of each other. The nodes are identified by unique name
+ * strings.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_node {
+	__u32	flags;
+
+	__u8	name[PKRAM_NAME_MAX];
+};
+
+#define PKRAM_SAVE		1
+#define PKRAM_LOAD		2
+#define PKRAM_ACCMODE_MASK	3
+
+static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
+static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
+
+static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
+{
+	return alloc_page(gfp_mask);
+}
+
+static inline void pkram_free_page(void *addr)
+{
+	free_page((unsigned long)addr);
+}
+
+static inline void pkram_insert_node(struct pkram_node *node)
+{
+	list_add(&virt_to_page(node)->lru, &pkram_nodes);
+}
+
+static inline void pkram_delete_node(struct pkram_node *node)
+{
+	list_del(&virt_to_page(node)->lru);
+}
+
+static struct pkram_node *pkram_find_node(const char *name)
+{
+	struct page *page;
+	struct pkram_node *node;
+
+	list_for_each_entry(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (strcmp(node->name, name) == 0)
+			return node;
+	}
+	return NULL;
+}
+
+static void pkram_stream_init(struct pkram_stream *ps,
+			     struct pkram_node *node, gfp_t gfp_mask)
+{
+	memset(ps, 0, sizeof(*ps));
+	ps->gfp_mask = gfp_mask;
+	ps->node = node;
+}
+
 /**
  * Create a preserved memory node with name @name and initialize stream @ps
  * for saving data to it.
  *
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
+ * Error values:
+ *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
+ *	%ENOMEM: insufficient memory available
+ *	%EEXIST: node with specified name already exists
+ *
  * Returns 0 on success, -errno on failure.
  *
  * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
@@ -19,7 +88,34 @@
  */
 int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
 {
-	return -ENOSYS;
+	struct page *page;
+	struct pkram_node *node;
+	int err = 0;
+
+	if (strlen(name) >= PKRAM_NAME_MAX)
+		return -ENAMETOOLONG;
+
+	page = pkram_alloc_page(gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	node = page_address(page);
+
+	node->flags = PKRAM_SAVE;
+	strcpy(node->name, name);
+
+	mutex_lock(&pkram_mutex);
+	if (!pkram_find_node(name))
+		pkram_insert_node(node);
+	else
+		err = -EEXIST;
+	mutex_unlock(&pkram_mutex);
+	if (err) {
+		pkram_free_page(node);
+		return err;
+	}
+
+	pkram_stream_init(ps, node, gfp_mask);
+	return 0;
 }
 
 /**
@@ -50,7 +146,12 @@ void pkram_finish_save_obj(struct pkram_stream *ps)
  */
 void pkram_finish_save(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	smp_wmb();
+	node->flags &= ~PKRAM_ACCMODE_MASK;
 }
 
 /**
@@ -60,7 +161,15 @@ void pkram_finish_save(struct pkram_stream *ps)
  */
 void pkram_discard_save(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	mutex_lock(&pkram_mutex);
+	pkram_delete_node(node);
+	mutex_unlock(&pkram_mutex);
+
+	pkram_free_page(node);
 }
 
 /**
@@ -69,11 +178,36 @@ void pkram_discard_save(struct pkram_stream *ps)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOENT: node with specified name does not exist
+ *	%EBUSY: save to required node has not finished yet
+ *
  * After the load has finished, pkram_finish_load() is to be called.
  */
 int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 {
-	return -ENOSYS;
+	struct pkram_node *node;
+	int err = 0;
+
+	mutex_lock(&pkram_mutex);
+	node = pkram_find_node(name);
+	if (!node) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	if (node->flags & PKRAM_ACCMODE_MASK) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	pkram_delete_node(node);
+out_unlock:
+	mutex_unlock(&pkram_mutex);
+	if (err)
+		return err;
+
+	node->flags |= PKRAM_LOAD;
+	pkram_stream_init(ps, node, 0);
+	return 0;
 }
 
 /**
@@ -106,7 +240,11 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(node);
 }
 
 /**
-- 
1.8.3.1

