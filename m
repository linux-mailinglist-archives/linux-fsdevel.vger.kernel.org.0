Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8534F32D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhC3V1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49990 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhC3V1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNipW130302;
        Tue, 30 Mar 2021 21:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=yDLRLnFTPQdctAMZcnaA/yaqg3MDXIWikseBX1dUNEY=;
 b=DgsQHnDDCS6pEshRFyMtvkwK3Wa0oBdlzobJFg1w+FCLaMY5brkw4jeaXwAA+b0n+Ew1
 Oc/GDsy2U3G0FEkHcI7O9GEALMEN06cQfZak8HgrxSIdOKXDVLYAqEv68nOkLZpvPe2v
 6dqg/TnLPC8gtWnP4WW762EbnB5u0gVSVO34idsfQLSy9mKLV1ix7ZUlkNIk9be/cxnx
 MJoVI8wpvok0a2pJHAPNJnt3SWi0a2OO0T0l7nvVbbiOm9j1QFgvCcuSaeNV8XSrIFRl
 JbLEfiLJ/HlAEdu5A50dBlVlX34qirLur2pOCiSsn0AFs94Hw8H31ygoy8OTlx6eOM2T Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37mabqr8p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOnOa184080;
        Tue, 30 Mar 2021 21:26:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 37mac7u4jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9aIyh+rzc8JG5NcLpgVyBk0+dmxAkmNEidhBIFjLAIiyNiPj0xTGplcPM6Z8rDFLCnCP0zbELWP1zdiuWCLyiPt+gJ9YIVT7EZzG/hFFX6kNJevQ6fNZujn33DyJJmGh1TeTCePQpwNtzTzLG1JBk/W7pe1gYbjr0RZnk7T/7Bj8PylmMZbfOetHtxQUd7dA/pyROrUXihIaeoeIpbRxYair54yr6or0Kc75yeD4efbwUehMNcw1pMXBw80Pxue8CH7rgmSIdqjEBOeSswbkoi6UoaoXaphJXMMEh85DoS4cFm7cTy6WRqXq8J/wWMdZjhvMVC2Xp0p2zIQVOh6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDLRLnFTPQdctAMZcnaA/yaqg3MDXIWikseBX1dUNEY=;
 b=NokgA0AwQQZPdYMsVQIYdI7pCYtRTKH/qP6zq2mt+tL7yP44dGiIID4Et+zpg0RVAztycob6b9Dw2ocf7DXKEuz7LFp/tjRgsZgrlrEPRbXKF/qdkf7lcssXACu6kZ7eA3f+cvG2GxhJFCnkpZqDsHzNuC0z73O5onN2bPH4ZntZ0BQiK/sVisf2ZpCf0dJweooctxpFgHgxUOyj9xALalzyPZHxPJdLVnAn2kx6E+RtX1tURHouqBDkLU/yKK4TqPwRQUjdSmU/6FXyQYKN1Fy9nUqfT0ozCDRCZTjwbhFlc6+EUoZcJHSoUQaHfhGOS2TcH9AJITeQHeAGZj2wMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDLRLnFTPQdctAMZcnaA/yaqg3MDXIWikseBX1dUNEY=;
 b=cpiWQRYER8WlZKIptvBBW5ajuylUdnkkiNfuAytYDCYNNpgtQoehPy3klXpMtgM1CkIgmD+4vDZB3hhC1C8EgveS7bFunDe96+F5iH34tlqJdj85CVxX+gTwZcZLCujwXpjKb586bwosxnnUTt0ht1fhMtWfcXjdw+ZYNexi9qs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:22 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:22 +0000
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
Subject: [RFC v2 19/43] mm: PKRAM: allow preserved memory to be freed from userspace
Date:   Tue, 30 Mar 2021 14:35:54 -0700
Message-Id: <1617140178-8773-20-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0fe7fd5-ae02-4534-9153-08d8f3c276f7
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3600C3B9423FFDA2C5AE12F1EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrdhDpxsUyxEkpnXeE8OhuoScRXECCtbqVJiYrESeCo0cfVsoxYmH9MP2sPUT474FhW7tSkcoRkQI+vp8bHbEJXsOjjphF7oU7Me3xpQUd6/veknLq84+6Btt82i+NQhBBi29b1UkYmwFMMhmga4IktFjh4JmcStVoWyoQbV9GsC35g4J4uVYwicr0gaRrJDH6hcyS2P9tFKggC43qrWkmaI1mwSdf8k+jFuTI83FLmwKAo1huC+lFxoigDp2vDuMOA1wETPOtObOJWGoV1VgsE23X4sBGz0EiRksyFoAi0ezsqJJQ9C6//TvM9AbuEiK//yVENHtHdchhEWle14HEBqEgAHMzBwjooEBFaVTV0YqBkK87NZp1drVUC+CJjsR55SPkj+NeCMhLwLFXX2k+KUmdm7zqKalNrbxbbR7yNETwjnCUFE+CGrIZQLJ3fub86D9AbV3cdhlRx6EQhK7McDydGmqYfshERAz6ur5VQllGgWUwDeAmPjlcfsCzG09XPpuX8R8EQBS07wppxTnphDcjmeYjxMrd98POeRO1voR6EPI1CQOu3DRxo/irH2WGdRnVrE7YQhLDgAwxsJJbk7tzL3bLUVQMjLuUqIGZdmWRJZ7QJD3dMLy28eg5rapeYSa4vb1Iiaq8zDLwIsCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zGgcDEKHqfeVCT6VOZzkY6o7Q/fGlOllFxgjhXVxYC/1UsKgvTjjTR/d1Ylm?=
 =?us-ascii?Q?ezhecaPUG3qGttqpq1Ty9yQCSaMPyHFX1soNRESq5DCim+r52YmKQy30ZhIF?=
 =?us-ascii?Q?qS0EnoX9MnuO0cz+lApazd6tubMLHLqs8ZEozAo7584lpWyy5PqJWIi9eaPo?=
 =?us-ascii?Q?0U/mmGbegw8rT1rS8rXrMpXzqm9HA0B9T1YsS77RL4u6xh/XybYUd5p9MUCq?=
 =?us-ascii?Q?PsU/5jJxceBbjfeCG0/bbE/2iEw1CK153wfl4r9aGVjq89u88BdR+H8Z688C?=
 =?us-ascii?Q?a7j6CJZ1KvlrCmNf4F5b+7DzYX64Um34HG1l4SEX5W1fiOgTiMZPjmnEhreo?=
 =?us-ascii?Q?i4VEOG2kEj5SWWmOODKh4YyWfGCQTag+zHmcdPXyI0rgk/FloyzzIsFpmgoL?=
 =?us-ascii?Q?FLp3nze4xrNMUvGE31pCOumGEmMyHkyNCcF5XRnlGilXeuVtqQSr57VCmIU0?=
 =?us-ascii?Q?vof5O/6+h/7bx9PFdy9QXWPL6sxeFdQXp1f4WPZxsiJouM3EEUSdnVRjvskF?=
 =?us-ascii?Q?dp6MfaYWrogUaNd5RdgguAHrUzlF2aZjOGfHkixZft/PBZFpfTNVzDKxGuva?=
 =?us-ascii?Q?cxyEIdMKQZGpjrOKp9LMutjn2kZz8yLi2xpgl6sXKpXyEcCmLXuh0MUkbSZZ?=
 =?us-ascii?Q?L04yBDv3i+xVLuMjyveycI4WsSUwnkVaBBHX/UjjaZbUIiWwMsW8bz129ASS?=
 =?us-ascii?Q?hWiSCnNPOxhe7VxR8DC7xT+gr+mD6HagljJrImhyEO5wL51dWn84RjDnkKnj?=
 =?us-ascii?Q?UCrF414MtT7eHpNbZ5Rbmhbd7ZhPpEIV8D/IJdR+Ip3OGMLK/ZF+hQrTA1AE?=
 =?us-ascii?Q?9MTkNJ2T9NpmTdezWHyN1TYjeoQbX0cawAJOLhqesxcwAiUMGpJpyyil+cKy?=
 =?us-ascii?Q?RblrV71yVMuO+awQYGheBDSvGJuwOGpMO+8PwIkPDbyzU1Ewg0UKS5POpab4?=
 =?us-ascii?Q?3Z5B0v9p2YiSGmPL9T6Kgypl9+aUNPLR9Gj30aqAcMidSDGhXHpXMJn9KQmD?=
 =?us-ascii?Q?GBOBBvrBUfC7TXGDzGNAi0W86lHhyedNEiiHDX9sJ2e3jVNy7ughbmBKpV+t?=
 =?us-ascii?Q?YxFdvIEHP6dJl8nf6dDvCTzCcmWFVKLcEDkOG5wChojzx0uid1JcbLihdDxG?=
 =?us-ascii?Q?/vGfR/Bzvy+NxsDB/4wbfgdtwbIlMSOke8EVMtyg4bPevP7+lmLMMo7ENXQ0?=
 =?us-ascii?Q?0Wqm4RWfiCTHpT2yV4H28t/BHGnafQIOV358WkMK/w957Rn+Bxs94F3gFJM5?=
 =?us-ascii?Q?1JOVJ+S5KmDHGLUFIfHbZNJp56kBQUof5GPFKX8dToECca0NqpKvE9XZAqRp?=
 =?us-ascii?Q?JxFJR5guZPuLJszhY3qcdIRp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe7fd5-ae02-4534-9153-08d8f3c276f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:21.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjI0o54wg1wET4H4pvLmJOFxn9DvnTgp++5XWTRmE/7EHsrdO/He/08Z3hnGMUYO54Bd6PAmaC4mY0LgnDHmId/vxePsT3oAz7DXLwMJeV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: pMc0HMVeS0xDmcIluKiakYKWipZMKCXj
X-Proofpoint-GUID: pMc0HMVeS0xDmcIluKiakYKWipZMKCXj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To free all space utilized for preserved memory, one can write 0 to
/sys/kernel/pkram. This will destroy all PKRAM nodes that are not
currently being read or written.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index dcf84ba785a7..8700fd77dc67 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -493,6 +493,32 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+/*
+ * Free all nodes that are not under operation.
+ */
+static void pkram_truncate(void)
+{
+	struct page *page, *tmp;
+	struct pkram_node *node;
+	LIST_HEAD(dispose);
+
+	mutex_lock(&pkram_mutex);
+	list_for_each_entry_safe(page, tmp, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (!(node->flags & PKRAM_ACCMODE_MASK))
+			list_move(&page->lru, &dispose);
+	}
+	mutex_unlock(&pkram_mutex);
+
+	while (!list_empty(&dispose)) {
+		page = list_first_entry(&dispose, struct page, lru);
+		list_del(&page->lru);
+		node = page_address(page);
+		pkram_truncate_node(node);
+		pkram_free_page(node);
+	}
+}
+
 static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
 {
 	__u64 link_pfn = page_to_pfn(virt_to_page(link));
@@ -1233,8 +1259,19 @@ static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
 	return sprintf(buf, "%lx\n", pfn);
 }
 
+static ssize_t store_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int val;
+
+	if (kstrtoint(buf, 0, &val) || val)
+		return -EINVAL;
+	pkram_truncate();
+	return count;
+}
+
 static struct kobj_attribute pkram_sb_pfn_attr =
-	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+	__ATTR(pkram, 0644, show_pkram_sb_pfn, store_pkram_sb_pfn);
 
 static struct attribute *pkram_attrs[] = {
 	&pkram_sb_pfn_attr.attr,
-- 
1.8.3.1

