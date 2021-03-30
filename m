Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35734F37F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhC3VaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50808 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhC3V2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNs0k130344;
        Tue, 30 Mar 2021 21:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=DSGc7PTDZdYXBU2D0khCKJfHd3zVnsm62bMxQv2PtyI=;
 b=DYOujjE9TSqj28AzJ6onyeR4SlGuObEMBmWCb1PG+lvHDDMMPCnrt1kyRboxEMaBJWry
 p/A85dbbz6P7rwYFaaSUO3+QFsqwhWwFNhOYg9Y8GB7BiLecN33+L9jWJ76E7frcltM1
 8R6diKMUcb2xw+3g7ayJ30q83wcu4JbYnYYIsuFanZx6Fth8p5BVqvOom/gcCwEqjCCu
 ftEdU9aOpr2lk+qcFC4bxJPwLcMtqSpuUZzuGG8TVKDs3NC7a2lzswRwyvyZAAwdECmb
 AY3Ud10ejOL81TRmFOETNIs+fFoxfvU377twTYSqh+L8PKcHzLtu7ONF4kpWXyjYKXne Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37mabqr8s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZb2124960;
        Tue, 30 Mar 2021 21:28:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 37mabnk8j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJGecd626mc2Sg1N/nTh/TvHl8Zbkj77pXPvag5XTzHI+Aybh5FZsmbDS1Yl9G9Gf2ZvdX+8YDmYbNeK14OXk5yBehQKvKHkEvV6vgb+6z3yt2W2w+lQ3uSMMsSOEfaOoEfklBrPU0HEQYekXHZc2xCMMkPEHuV3g8KF8Akh7Ql3Xn9dVzsmZ8QI59Ht8TdCEXxJXgqk8nYpOwqg4eyCSR9eWpBL38pWzeFc3IybcvS/ptkOu2FATrcGLwdoSKnFyvzbno3HEkbzBeYXqmMqS3quZIbQ6KYNHLp9IrWHWE2PCzP2+njux36q1botXtEr9oWN4aT1KAuyeg+dLEvchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSGc7PTDZdYXBU2D0khCKJfHd3zVnsm62bMxQv2PtyI=;
 b=hkp49QV3QL1lPx5ZAIXu6tl02tRs9IXqUz8gmTpGaenQss4KrZsbb7utyXAG4dk33zFyqwN9w4P6gWb1gmL16779QuwA3u3q+y3Xa/kn2XMtrkuiGKlx7wVPjpji3i7eTJWyuSRtmWNaIeXH1nhjgV7NcDc6b/2TkJMSgxahMnDgi+FffbGl58UBGB5OYEIxOpOUEaoyqo1XK2XffgygSynykJLRGi8c3wv14tc5GMKz3+C+APTawFe5fLoVMttARUHIJ1nlT7PqIn3u17AAV3R0Nf5FwGQXtqAb8vZukPxUFQhaDBsRi5aEZbZDubiHMRxMvvlkcmoy0ahKXI0Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSGc7PTDZdYXBU2D0khCKJfHd3zVnsm62bMxQv2PtyI=;
 b=zvE/kMrmF0LUlDTfZRycqNhPxiq/M398+re9ciBfNPKSeaiOoWCzhWRlxJz0qLZPG3KvMIzn+dh5wWVZ/m748/eZpkKpHmFU+whlR+9Z15ojjVmL0b5BrS4o5GGJmAMiWTg6iaEa/etfpubF9TgRYW4qtQ+vHlSj/ar1Fqxlf9Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:28:07 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:28:07 +0000
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
Subject: [RFC v2 43/43] PKRAM: improve index alignment of pkram_link entries
Date:   Tue, 30 Mar 2021 14:36:18 -0700
Message-Id: <1617140178-8773-44-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a8d607-5eee-4e19-2be3-08d8f3c2b59a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB526584919AE69859C98E95F5EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/QQ2mFjJdy9NMFDoLwwnFyudM5JzqRl07czgKAZQgitQ1g/RTdMQvK3Q02wZriGnUgfDkeAGP4WVCSBQQ2+kmzSG1umRHYOJ9Nz+AgzQpza/ylxtOoVIgIfmjHfA4KUKia0z3i/yO0c+2WZsmIyxlF1YPFZfj0B5oRpUx/FLU/V2SuPvSh6mYCSuV5X9RP6S4tPLNdnsR7xLb/iwkxkI0cPPvXQGZXDfAd3RYDN2KMDofqH/zDXluphojrDdVlVl7V+418d+VqGjdNoBaGGjihSScDgFrot33QJNl/qgEmJZmam7aOK51zZHXDGMyISzS84PmH5XQgdWBR/bXPN13zKCfjduwhkEpE7+UgyF4Ftpk9JW6tesBGPHK8fHxB3j4ozoNEBxWpsqsXQlIrsxF/DmXjOk7EHm+UJIwSnXlSNFcjXMoUu0ZNphefRTrpg6Rmc54LLzrFhAAI/KiqZhm9pu8Yw31Cse7er8/yD+oBHfOaaYZ6hJFppwUrVUe6nTj7e/LaLGrPzDYOqN3nUgnRN/eHISHufsqcoKbg6secCPwer2Ceardgie42/iuvl1k2wXy2bEHhRan00g7mOFttj/j3W/XbSCXGDsZTN3FX9GGai8om99LnPcJnVlajzFRu6w0IRLJsYKJ6iq6+Kpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qeYOuW09fv9SPRyrmJk0JkLH6S5er7zJmNH7MqnS7oQKgKOdy1GiSjDpzJil?=
 =?us-ascii?Q?IjUaBJyjIWf03Lhs2+QpRWhvM3ZRo2DTxG/IKPx8MKEwIsTwIpkTLEJidiS5?=
 =?us-ascii?Q?8PFoQYrnIt/4LhAjj29U7JeilHWGTS7eTxjfPB2cxn2qRZM9IKxonVMuOyIe?=
 =?us-ascii?Q?P+1sjcjx/5qkLKxjzAqfA+2o97NJ2oyNizxKcIhrdrtxuIcHJja5dghl0ic1?=
 =?us-ascii?Q?MM8D/7aYDinWoRVAPjGRev/g1jaw9tkr6NUvFmJrPiAs22wQ0kLkwFOA9YzA?=
 =?us-ascii?Q?imHD7SjFu5dLNn5pE1Gj5EMb+3ZGXvGeL5qObkKI0WSKFmRWZ5Mhg08jMksU?=
 =?us-ascii?Q?kc9nB1jXnATNq+qssEHME882ropMSn010Ba/Pd7xgYxiIwyliCH2z2R8cfzQ?=
 =?us-ascii?Q?1EpEk5GwbgNcRAgJC42sPDBXE7m0BTR9L9f7WIx1emqRWjXDi4H8gcmUCO+X?=
 =?us-ascii?Q?9ckudYNXD+UzkK7SEbwPgEOpjPbC/XkhDzSlQifYroPbHhikJZLPW6unQGwV?=
 =?us-ascii?Q?IOhl7DkFNg3Eq7RMGG3g7tdbI7d2bD8Ov8fL+nIegG9p+qteaNAENsOJf6DC?=
 =?us-ascii?Q?tHTFI6gwR262Y0+7URPxBMqKvYr1J9WSiOm4jrAswQrpMnP++65aTiW9mM6v?=
 =?us-ascii?Q?a1UxCjAVmoL8girVjxGesRv5K8Oit9drUiugd01J6OO5yCvF2Ds6MZSaDzwd?=
 =?us-ascii?Q?o5KVc0kaWHFUv2r4WAunAL9A+Sz/a2SQnVdyazxLGylPZej4QgsrJ+gTS48v?=
 =?us-ascii?Q?OZaSOLYdgnhKrtRCesFqc8O6PQCYtSXAb7k3KZlC5yLAqHC/gfMdbtsz2uRY?=
 =?us-ascii?Q?5q6adnmuA9zp0eztqjpBcIzeSKdTI76TaZze8PI0C6t0rD/F1SYVtpBRbvUA?=
 =?us-ascii?Q?DtOzGdNWgXWE3MQAlKFEoSiviKEiVC8u5bjaXL6/OVq/T2IVUZRli8R5NRYY?=
 =?us-ascii?Q?nGCFgkHbM6/CzGH5VusRwtnACq9jrzJtpWFzPh5jaMHQnu4UrVUaW+X/S6zq?=
 =?us-ascii?Q?zIsjHbw4uUg0dGY4+ZLjt5TGmg1h32o31S6etICxBVlIVWebOdnfkYidWAJ1?=
 =?us-ascii?Q?XrJNkMEizfjfaTHvYB31ipfshMQZ7h1zcpBYRgRNBUjrFeZ/KlKEtFZl2amV?=
 =?us-ascii?Q?d6s12wxMjefvSnlZNsUw+iNAj9ew0robRTQsVQ9D071Pwe9RoUHePhHZ0ypu?=
 =?us-ascii?Q?X7NmZWBiAx8i5ri+JPJNNL8SKV0TakkUYQKk6oy5DuOpxBYGlvIiF+nPc5Tt?=
 =?us-ascii?Q?snsN6nvNXHHtY2K345afOfdl3NevBuWIyjZtCQiB4QP6NqMTPVJwYfZ7z5p2?=
 =?us-ascii?Q?Qg/SXs8l/UL9idT7NZtenNoP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a8d607-5eee-4e19-2be3-08d8f3c2b59a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:28:07.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6c0Vc660uRerXcRqD49W4MZvBtUBknhiafKQGZhr51i/42P1Fr3OD+WCniVjMBm3Z0Q5Je8aV5rdCYNEDbXVU2rK+ISd2XsKTU4EWpv4OLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: BVK1iEZHg5ovKmvclLpOhn-Rb5_GIDS1
X-Proofpoint-GUID: BVK1iEZHg5ovKmvclLpOhn-Rb5_GIDS1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To take advantage of optimizations when adding pages to the page cache
via shmem_insert_pages(), improve the likelihood that the pages array
passed to shmem_insert_pages() starts on an aligned index.  Do this
when preserving pages by starting a new pkram_link page when the current
page is aligned and the next aligned page will not fit on the pkram_link
page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index b63b2a3958e7..3f43809c8a85 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -911,9 +911,20 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 {
 	struct pkram_data_stream *pds = &pa->pds;
 	struct pkram_link *link = pds->link;
+	int align, align_cnt;
+
+	if (PageTransHuge(page)) {
+		align = 1 << (HPAGE_PMD_ORDER + XA_CHUNK_SHIFT - (HPAGE_PMD_ORDER % XA_CHUNK_SHIFT));
+		align_cnt = align >> HPAGE_PMD_ORDER;
+	} else {
+		align = XA_CHUNK_SIZE;
+		align_cnt = XA_CHUNK_SIZE;
+	}
 
 	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
-	    index != pa->pages.next_index) {
+	    index != pa->pages.next_index ||
+	    (IS_ALIGNED(index, align) &&
+	    (pds->entry_idx + align_cnt > PKRAM_LINK_ENTRIES_MAX))) {
 		link = pkram_new_link(pds, pa->ps->gfp_mask);
 		if (!link)
 			return -ENOMEM;
-- 
1.8.3.1

