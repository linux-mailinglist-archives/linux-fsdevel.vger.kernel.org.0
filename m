Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB434F33B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhC3V15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32894 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhC3V1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPNHP123003;
        Tue, 30 Mar 2021 21:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=HcxrisHJNwMExf/6GDpp3V1z8lwkTPHuB9X7hKqwaM4=;
 b=vpxaSNbJ04gbCyBPF9HgFdczaY0g2X4y9uxH1CkGCR1ZkK5FgrWHYdSQL+0G1o6U9A4L
 GLtT6DR1Ri19KT5OUEs5r7dKfm+FznNhbJV1d4Q31Gg0BxySczR8H9oU6y/F0K/mQjKd
 U1w3e+WEXQf0ac6GEFhsZAXyAegLfPIW+zapREbsH71gDjk9uGFZq85k5eSxhot7Bgwf
 QVgng/Whvu6ksuP2s2tu7Rc1mthMSsYrgAgdgxBpe3BKwgGAlP+xN9rvoLEfHao2qa/S
 6h49KfBjm2EDZYCojigC8F+5KPHEmuVeMkUOd2bYo2t8Kk75bmAuLd8MUkJSnfVxbRI/ nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37mafv0834-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSF0105832;
        Tue, 30 Mar 2021 21:26:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 37mabkbcn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5ZRT+xC2PqaFyzvEM5DDFDfyytRqUj8WRW8O4W8NEktbzdcpnS+twS0WQpTX9TxDpWAxr0zty/mKVJE6UOGVGDEqRJo0US2dvDJ7+7Yxy3XJexbbAqSMHMbW6ibfk71Xbl2ObtDYzLU5JqQcrQFGDr+n24w9Ntwyrch8hxn2tWm+qJAN5cLuA7415dJhIORrdyJ29d7nipFfNQN9pmo1R+JEU3RDomSAGTJLrBBrj/amEoXEssxrs0tKAS3cI+snl+6gAE+QDzJVSkKACCqed3DR3Uom9TXDY2IVk6nQIpuzDJuqdnQd6qyyf75LacCa3yf1tOJEQNQmIy7elss5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcxrisHJNwMExf/6GDpp3V1z8lwkTPHuB9X7hKqwaM4=;
 b=FKX3w+g+2XA0zP2JNVTE0LRA3Z65QoJ6SU/H3JWZ/pHu20paXkT06RbahEM8er8Eg02766RNQ0YDgfhMJ4gtowqXjYWp+z9O3P+UU3+wo5I3z2GDDgZAVGAOD1+MCECpQVHaJhSwxx/u/8h3W3ukwoGBgyjSMOt8jpb9Q96T8MfLJfjBQ3M4AaIirsDJJoA4S8uwQzt/Cyf8f+CSiOk5PkDD9n48+ROlWR40KZ5sE9UKOYvgVe8N8xds5zx939HsjQRY7xnu0N9oX2wrn9jZmDiQR1Of1ao6L5p2SsshO2b/9hrOSsgyFL2H3UdffL7NWBhCSTKaXzsFBfaWzvptHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcxrisHJNwMExf/6GDpp3V1z8lwkTPHuB9X7hKqwaM4=;
 b=lRWTU9GT/tke+Fxy6NNT/40OombVb4bE32B/sDDb651Qf/LZZWaewW3f1MxBovq2vR+9ShXgV0zIu4M9HvDqGhh+gVHpxAo/wUheIjX3IOGUqv+Prxjq8eX181kRlG8RZkJ1QxvOkxA8pgpF61fENSwdUul28E3BcJA5I4gy3F0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:39 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:39 +0000
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
Subject: [RFC v2 23/43] mm: shmem: introduce shmem_insert_page
Date:   Tue, 30 Mar 2021 14:35:58 -0700
Message-Id: <1617140178-8773-24-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77817601-b231-4393-4bca-08d8f3c2814f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3600C50544ACA4453690991AEC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tGswkQLs6YU2oQixQMoXLtWctdtmxi9FiDSJHZ64p3HjVeVOg2J4UII2cqUCJnoFzrCTiy6aM4gm/jUGOCldzlLn2BbM0LZJvkSCGpchYRqmfmD+KwbQ4i9+4OXsvb/SxnOI3wi+pSRkqkAsRJK/QvySvcHbPkyeJxHijmIW/g1c8Do/FWRL3fS1IX7ouX7Y6knwgocZx59ddP9U6W4j6c2h2jQDO14n1L9ID2Zgc4otEexVj+Srq9g2j66yZTtefQfrruCNqockds0YZF3a/40kFJ3FawYTOhzfgUPqln5cDhPdNd1xBw10I3L7R6Z81tcBLKKUkptwqMxjGRkSeN+B5XjzANYbGzcFg2QnrZpivU5ZY9amqISVNMjipjVZ/lRtyGeWqmQr/IT6vs8rLEBgv5q7S4vf3zPZRh5mQe1g1w4R6CjcJ0uFn1BU/cFrycSsAQ/sVjEYcNSS50vKac2tpgUFpC+mgjExMXQxmX1mD58oYKCKTSloGneZau6aR8lgIgukNGYxBbgrG2YGldLNgaCjaI923WG1j9bEs09tLWKd+nyONRAIK2PU9hatc+Cw9G6HFBFRr/xTCHQrTS67wHgJTB8E0Z7heyzxTqFgpRQwH2riJeZQuJaT2n6hzxUFR6LduDlnNx/yhhYXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pUHzou8cLL7/F394BGoKtNuYtGmDdyVkKYzh6lXTo70QolTadnilEYNEloaT?=
 =?us-ascii?Q?vgET/QMQq06b1bVf7rX64KBx0AUicArdYlVZ12mFfnKY5uXOHuNcKw0LRfk7?=
 =?us-ascii?Q?8bCEmTxJOqNNevxyHtPJxSwCBmNdt3Vqujbi4q6EXiPPF605ypCJvxZXaUHj?=
 =?us-ascii?Q?riqWZPLQTaWOE3DiK9gVwdBOkhRD5uraqz0sjd9cMsjYvfYryNuTC/k+0Mo2?=
 =?us-ascii?Q?gVSsSppKvYKii2bPbLFd/ASzbiblHSjm9cMDPHLIsVz/N9TtuKJDW+l4nNFc?=
 =?us-ascii?Q?+c+jTIp/Qzifxru2EciI8mQw84FalhJjgmqImXUVSlNoiTVh3mR3I1aGS1PK?=
 =?us-ascii?Q?74/7pb+bkop7ExpQuWD69jNSFQE6fErwt3DAqvoMzwvzwdNUMIHoxt2f/R76?=
 =?us-ascii?Q?nH2iwGtkMDKyRK/qyXp58Qvhtjodq5ycUCOeLIK/wO4YP8HYLZPTt1ZR1fWb?=
 =?us-ascii?Q?Ds1ZtBX2n27ooKYgsGWpjD7WNjd6r/77FeAZzBWx/PodD1UdGx3Y5kAVXhbU?=
 =?us-ascii?Q?nYptLOFRJQ212wErFQLqssNdi2dRcCyiOHS5bSAg2RX/ECQMiP8LCkV8b4Jl?=
 =?us-ascii?Q?b77sMEAS3AZxvvsT8/T5OgrktEKpf+QScKEB3Y5D0l8ZDFl63FkwQBFy5SSs?=
 =?us-ascii?Q?IQB4OF+8KFH0Pygj9zJghh4uIdWSgc97r0aU2GyW+oUPlSBr2SsEzIIkFCRU?=
 =?us-ascii?Q?vJylCExVmGxASaWGqs9uwb8qOg2T8O75KS7BWyoqDJM3EfG01heQ+PVnSjQ5?=
 =?us-ascii?Q?0LdxvAswxjJisx8oA6mckQVHvQ/CZbcBMvsi7FvEMHgdcXcfCUBv0lYVxtSl?=
 =?us-ascii?Q?HYsoNI/7W7HVPcC2nWtu5KwE895tTqryCB25UIOT2Ci/tHue3xKkfD4xknvZ?=
 =?us-ascii?Q?PUca/SDM8E9OQD6JymX+xgnXcjv/eAQKawvUTfKmY3bXSKc+f48fouHe4YlG?=
 =?us-ascii?Q?caksnHwEOFa9TiQk15Zz2LoiY2R4T48fUUnxLV+IFoeU+gqcOcJSp0tjoXqi?=
 =?us-ascii?Q?w/z30aG+JTwUZSrwTwYOCL+Bz1ONhokAZN5+XmglcVohM3BMpxo8phfF2yD2?=
 =?us-ascii?Q?exMlJDcddCqkkM6Jhg32mKNC8vpDttUjKhdfxwr2/GJeHUSlS+HyGWAnOY5a?=
 =?us-ascii?Q?HIwrpSNLuLJDab2Lpj8jl5li6/1rzJymi9hAiD2XbwVVoEs5UjhYAx3hNHgY?=
 =?us-ascii?Q?6/+kqMPN0JwTfaRhIF2t3PwzE5mTWODhVsbrCW7CZ+jJfoxOAYz5qJx97gX9?=
 =?us-ascii?Q?PDBW6iaqr3+OoWoQovi9K0NcMzA4gwHqzecnWwQC2SEi9jJ+1j2ogLUDED+l?=
 =?us-ascii?Q?YggEkKjyqvMpVGM5L9/z/1Pd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77817601-b231-4393-4bca-08d8f3c2814f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:39.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ju3TOPG4cYJtIETQ0GvjFtHioeyehDOJ5ANK3lnCUh1f0QEZZQEiMPoYdppHvIBeuRBakqYEgEKPf4d/Sf5OzeNmuh8I+CHNk/I/3GzKg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 9vmOTQlOURLpy9Dd4IiOIVEZT7tso4_M
X-Proofpoint-GUID: 9vmOTQlOURLpy9Dd4IiOIVEZT7tso4_M
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function inserts a page into a shmem file at a specified offset.
The page can be a regular PAGE_SIZE page or a transparent huge page.
If there is something at the offset (page or swap), the function fails.

The function will be used by the next patch.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  3 ++
 mm/shmem.c               | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f396588..3f0dd95efd46 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -103,6 +103,9 @@ enum sgp_type {
 extern int shmem_getpage(struct inode *inode, pgoff_t index,
 		struct page **pagep, enum sgp_type sgp);
 
+extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
+		pgoff_t index, struct page *page);
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..60e4f0ad23b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -755,6 +755,83 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
+		      struct page *page)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int err;
+	int nr;
+	pgoff_t hindex = index;
+	bool on_lru = PageLRU(page);
+
+	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
+	nr = thp_nr_pages(page);
+retry:
+	err = 0;
+	if (!shmem_inode_acct_block(inode, nr))
+		err = -ENOSPC;
+	if (err) {
+		int retry = 5;
+
+		/*
+		 * Try to reclaim some space by splitting a huge page
+		 * beyond i_size on the filesystem.
+		 */
+		while (retry--) {
+			int ret;
+
+			ret = shmem_unused_huge_shrink(sbinfo, NULL, 1);
+			if (ret == SHRINK_STOP)
+				break;
+			if (ret)
+				goto retry;
+		}
+		goto failed;
+	}
+
+	if (!on_lru) {
+		__SetPageLocked(page);
+		__SetPageSwapBacked(page);
+	} else {
+		lock_page(page);
+	}
+
+	hindex = round_down(index, nr);
+	__SetPageReferenced(page);
+
+	err = shmem_add_to_page_cache(page, mapping, hindex,
+				      NULL, gfp & GFP_RECLAIM_MASK, mm);
+	if (err)
+		goto out_unlock;
+
+	if (!on_lru)
+		lru_cache_add(page);
+
+	spin_lock(&info->lock);
+	info->alloced += nr;
+	inode->i_blocks += BLOCKS_PER_PAGE << thp_order(page);
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	set_page_dirty(page);
+
+	unlock_page(page);
+	return 0;
+
+out_unlock:
+	unlock_page(page);
+	shmem_inode_unacct_blocks(inode, nr);
+failed:
+	return err;
+}
+
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-- 
1.8.3.1

