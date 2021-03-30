Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE834F365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhC3V3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33516 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhC3V2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULObGB122825;
        Tue, 30 Mar 2021 21:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=v2KigxXcZE6xlJHQ8aE8ca0rwLVEP3O2wfEC7HbsMsc=;
 b=AkK8TuFiPJv0jHSk4n2XebcD44o3b65WbuJMMXQG1+tPElHSzlED3i+1IiaY/VDtlENu
 ddACSfleBxr2XJJsoSAhn36QVSHa1CltgoSeekLA0TgaShzOO0ZNHpwalGvMsgNKlSSs
 NkUPFW0OL8HtQ5Fs0Pfpb9I40WQ5Xj1vgSZrhMvCrIUVN5lsSUukY43hhosFM0X+H1kc
 +T+yOYecqzawllcpgfsm+XeTuFT+YfsD/Rszf/5lGu6SZ5WUaFfOp0sjzdhhA8GDIahm
 qdsag+XgDF8DUZ9krm1kQRH4OxPjZg/YcPu4qZb3HUvzxYvZ76oXsHohofcBz5w8bfXv yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37mafv084y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOZw2149611;
        Tue, 30 Mar 2021 21:27:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 37mac4kgfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx72bby8grU4JYVJckmq7gEECSGcbZMjIT01rs/10+otuUetNhI3dCHeLUGlfRdcUk++Dph1GAH4mypzfQwt2PO5llYOeMSCr7CPYG8F4mXt8zCnGrNl1d8QTsA/hoPSsvm8MroLzyczkY3M6XX0zJh2BdcDkFVLh2r1LJIUYOHhsnJdW8xiM8gAF6Usvu1U0gmIDcTHWACtsg0SRudxldl55bt9Xdc0Vmtodc6gBU/dfwc6Hmrw4XDNdKxfFoD4HJkiBIboSa8D+wxHRCs5a/ZT38ba0bKjyOUtFwTWdCwYZTIpnwSwbR8kF+zHhyNGqr2g0zmqSXmyNd9xPNZa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2KigxXcZE6xlJHQ8aE8ca0rwLVEP3O2wfEC7HbsMsc=;
 b=bar5iiuoypRROsFMFUNzzsTUdEmgaecKkJzvcGexMSyAjSMKZVgeYmtt2+Ux9FjkbP9wDDXn0KEwihynPl2BekCHFgF0Z8rdOEotgwe6tHT9kpIdEMKa6I1fJ7sUZ7bNpinc3JISTaqtcN6YOMOODLv5+k/ujfJSi1tgH8ISv9ZABwCF8cHenL7/0sMbD9PpI3znAFi6RKy04Bm2JUm4oJhRhYYTt4b2Gx3pLxZs6LSSyjrnYD5QkOuqxFS2Q11lZk1GgzD/pkiPK0CIlhgf7A9eS0GEJPTO8Yt1XongpZJuDYT6DFoM62iqWY2TC4mXuJI3Eht93Ot5zY+kjTeHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2KigxXcZE6xlJHQ8aE8ca0rwLVEP3O2wfEC7HbsMsc=;
 b=G/NSXdIBzxKG7dyPVZDlBpKV3+7TD2osDYN2fqQFo35JL+spDTFncJ+vrfj+JhYZAFGMe2J04obUXwJWL/+Aa3uAOkDHFADrCqFUjjO99FYsSEt0ucsfMYkuVHmQtWOYOQ6MN68RGdnJZpvjBuOj5JiITUG8i0tKZviWHq7ljhQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:41 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:41 +0000
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
Subject: [RFC v2 37/43] shmem: PKRAM: enable bulk loading of preserved pages into shmem
Date:   Tue, 30 Mar 2021 14:36:12 -0700
Message-Id: <1617140178-8773-38-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d5dfe61-72fe-468d-335c-08d8f3c2a60a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB52651A7F32254037C5AE56C9EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaqzA23g1sHDTw1RWvfLsh93CZni+lpTjwCS2rW4KXqKfVJ40qwWgrgBXejrbj/ab16qaeuOzDbGfI0KlywnmbKvA5FmqQniUgFLtfn4yWqwMtXlGSOyfp74R4Ty/LPmEhsXSQ5ZVvKhFRExBHLnLbfGLTdfOZQrgXktOZg/VKy5dpyNHZGfexli1ENo23oivUNrgiPRJiK7JKSKM45ugbAaAPDUWwSEoyYi9i3Hj9L95F4NUzoN1YM3Z7gLuyNlR5Kz4+uvaOMyxq02Xt1HO4f/h7crHIpwy4FTyVzi2zYeTNCblMOR9WPSoMn7NE9wpDsYV57PEuBfLOY4Wrfo7RbdIIdiXFPlPjZ8Bqg3zS2IAY0XY6tGZucgqX9AJyFWe+n0VWqJGpJonslLCA7bIgx/naP0h+92xCcMRpRVIwocyEh7v7BGcSDQz0Lq16Hvp1obJl8TERnSfr0e1eM8Jczt6DwzLeR+wh7sC+JY/kktxuXCfK/CEB6UofCszjL6IBjeFu7Ft3KaRwTZOoXAcIP3pc/qsFjUvtdgqCZ2pZ7+WyWMblWDFwZLLEyHZDglKIuwLJLwb/CiW4wrDD2dMT7VUUDEQaEWzLoqBJJxLqE2Hz1DBrH3rHsPlUa2pXZvUKLOg+9lJGe0brOro6/NdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N9EVpIVg77lhR38oyow4xGf926FI59UZgXkx2TyPq48ldarLcQ8JRZCasn64?=
 =?us-ascii?Q?lx1czalPGjTayajc3Lo1MDyS+WeHNndq/MKCP03/fxsjPOi3Y+PMboc8RY+3?=
 =?us-ascii?Q?jguZHGdkN88rhtooy9vnAncc5xxLjj/wBwEGYZ7jCtqrVYGrVVU8dgll59Dk?=
 =?us-ascii?Q?dG+myxO9h+olAttJ70s1B2m+WuxfYzReTZGZxQDGdp2a97wQ20Ma1xJhHRFG?=
 =?us-ascii?Q?hNj/tMmCv9wmToP4LwvIUIa0eg/bZcjnqoVoW/18i8JqchEy2cS6+YpNbWFP?=
 =?us-ascii?Q?AQL/OlekdUzTAhxj+GL8VXDiYMakVQX55KGgP1iRPg5o7OHLLvx5WGkJZRiz?=
 =?us-ascii?Q?2FFQqJ4xV8nCaEKuex8c1PYAMYFRuwsPA/rhVlw5FEvwOey3BUBxaRadXl4J?=
 =?us-ascii?Q?Q39NJDp45YQOcLHRhkTk3gadJQRgaECFG+xVte6PUIiltfBA+3YFmIELOu2+?=
 =?us-ascii?Q?lOZGF4d+NhMZEEZGhTZf62KugFOwqNe2+g2uVrPIaWCSsKjA4NB+AGBOF+G6?=
 =?us-ascii?Q?oIB9O71jwdUASxcbeCBYQpaZwJJv3+t4Fc37qWx+yUy9939US8ctCcclErD4?=
 =?us-ascii?Q?W1SqbbmNRs72vNrS5EuBsa5GBrq7zkn0AnsFgB0BIpgLm0/3fTHcxYSGTVdy?=
 =?us-ascii?Q?CItoJ56oZqJz/vjj55rInAlhB5xY8dafm55ydWmNmhD/WL8fX3jOLi1BxfAG?=
 =?us-ascii?Q?yAXweYi/OiXfn5ff/YxXZvCBs9UcjTpIW8A4/3Yy8RX4AG+L+EFL07He1tpR?=
 =?us-ascii?Q?Ash83UBlM4khxCQT4sI06LSM087rm0uqLvQO43eLEz/gS/kXwOc1lnVJ5dOI?=
 =?us-ascii?Q?PvUoHcTbCSuhgC/Q9XyGji/eh1o065UKxKL8AirtiSmcrGFDTRuNO1fD/uKh?=
 =?us-ascii?Q?ufDv+d+a+UmWfC6799/bfh74H6SLNgb4CqwIlJHsOd3agHLHjPYC52eMvVXC?=
 =?us-ascii?Q?jBPBX6oed6INNYKA1tcJviMsGERFZUp4hitVpzxO0yNZ//UYzlOUSMZbMWUh?=
 =?us-ascii?Q?dL8p3340PGK/UQfdR5Sz8Lbr0L4/VZq4mKVehGK9yf/x54U4Q/qUqImc8Nft?=
 =?us-ascii?Q?YJNJeZZSeAQP+bDhiQ8rNXSNY4zxNVa3TrreAO9MzOEl0JWPH2i2WVGMVBfn?=
 =?us-ascii?Q?AvC+/T32aT3XDow9vTo47GTCw6jgxfpbBxBr6l5MA8rdY/G1h1iCQGvmtvOc?=
 =?us-ascii?Q?FXc11zV60iMd7Qh61d1G6p1dTq0IWrpnIgEDKMUIh+R9J9k+ATjQt6K0rtXV?=
 =?us-ascii?Q?iW5Ihht+vxculzxRp/bN9/K/H77CYsFd+edITunBujbAIt3YQtMf//p51fqw?=
 =?us-ascii?Q?1P8rrO6AAvBDp7XuGS58RRiO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5dfe61-72fe-468d-335c-08d8f3c2a60a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:41.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDSMHUQvsM10K6U275XDFiCedDIDxbBBgLGuae5kD/YTS+COD3xO/tRNuBOxtlL3QRXOtb0ka2c93i/akR/EOt8PArGWdbpzP/iaWjUAcgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: def8N68OmN_oEfauHp9oC2IQSk7O-f2M
X-Proofpoint-GUID: def8N68OmN_oEfauHp9oC2IQSk7O-f2M
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make use of new interfaces for loading and inserting preserved pages
into a shmem file in bulk.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 354c2b58962c..24a1ebb4af59 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -328,20 +328,31 @@ static inline void pkram_load_report_one_done(void)
 static int do_load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
+	struct page **pages;
+	unsigned int nr_pages;
 	unsigned long index;
-	struct page *page;
-	int err = 0;
+	int i, err;
+
+	pages = kzalloc(PKRAM_PAGES_BUFSIZE, GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
 
 	do {
-		page = pkram_load_file_page(&pa, &index);
-		if (!page)
+		err = pkram_load_file_pages(&pa, pages, &nr_pages, &index);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
 			break;
+		}
+
+		err = shmem_insert_pages(mm, mapping->host, index, pages, nr_pages);
 
-		err = shmem_insert_page(mm, mapping->host, index, page);
-		put_page(page);
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
 		cond_resched();
 	} while (!err);
 
+	kfree(pages);
 	pkram_finish_access(&pa, err == 0);
 	return err;
 }
-- 
1.8.3.1

