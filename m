Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4134F357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhC3V2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhC3V2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULQ0SJ145826;
        Tue, 30 Mar 2021 21:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=h/B1IVNXrZ1tOavAPYPL5lfgzoSvevvaYjown85Jdf4=;
 b=sEmEYLEOSB2eK0tgqiP25aOBz5/4oHsGRviOHUNcRXFpNIafm/jqUMqqAS+6CS2myUZI
 lZ8Uk2L4ORjXD7yMBikjTfEZfzuoRWe9HkuoP7tQ2uTY3Q+MfJL8zXnOAfstCLqn6lsF
 3T9Gff2V8sxY3M0C0XCSvChiYFWZn56C92ao4QYTPz7W3yC3MWqQJcEmQUpqjolM23HC
 7lHFOc0D9ALF7iVVSetbpKMD+JRM4DH7qVSLNMF1zA8AgK2DxdI+pkUZIT+uURHQmhsX
 bF8NYNmc4N1LxuqdiVLltHUo6I0v8wfdtLjXALQZr1354/6iaFhEz0O3uO+xrWmA0xeX +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37mad9r8h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSbs105924;
        Tue, 30 Mar 2021 21:27:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 37mabkbd08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDGtJPkEb4jlTuWKNvTtqzoWGXRagOm2GevqP6FX5OeeyNq/7l+MGg6qJxzqsg7aP5QyUlxzfYvW20wYhHWWKyBZnrpMTaGtS8XNgeuO6Vhp03t5FDRUhT3x29yu2lzKTvJ+1/MpL46pGlIMBMofZPtt37AYOlrN1g70/DhZ4zgeCdiVZwrInYtw/lLY7c62dwdZwtUym0HFU2f4beaI9EBWO5MUrGDk4s5hQpVNPpeNtbqYLt5egAs/hF1+Aw8VuEri+hT9if77uMGKLATLtUTuiWd/vNgIX9KtorfI1land+NU091SxLWo24CKpyrE9KRlONo9qGjxnLCrgNNawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/B1IVNXrZ1tOavAPYPL5lfgzoSvevvaYjown85Jdf4=;
 b=eQDS/2QXMojiehU6ENEceLC7Zh8ZIMBkRVN04PfHFOC1E5z8MpXhBsdn8XFwmmncEVsVoODjnmCipc8jSQdFN8hB7sTuH+pEPTpk/1VDGicEPIrV4pmJiERqECK0rIuWlLH+9TeOowaWSOXG22d5wOzY4nk9IvjzapV0QZuNzD0i3hBnQI21faa7LqU3H3CNDqXCUrBXnXvXupesf8s463ysxPuY/QCsK1WAd7yOEji8bHYw8Vwe5DJt23jKKtGn6N+XvdOoqCyY6mBY0exwqQC5WGWmTldWEb9B5mDm1IfF0UQWtqqjWo+BmCdX8L8VGfLVYdoFE/jJeszixS65Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/B1IVNXrZ1tOavAPYPL5lfgzoSvevvaYjown85Jdf4=;
 b=X/+3VZ+ul2SJSibVDiK9pXWuACFOgW+6MZ4NdCMdpNLDuj9wfyWXIiJjxg+s2G4n7C2gzHvj6DHEYUCl65+IOnsOj6uOf0bGD5IE+CUsi2GtPVtAn0/VL8i3dSq8jJCsvs5XITPj+yTOmCczQuT84rRxVYbxY9xrqECg+mXaj0I=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:09 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:09 +0000
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
Subject: [RFC v2 30/43] memblock: PKRAM: mark memblocks that contain preserved pages
Date:   Tue, 30 Mar 2021 14:36:05 -0700
Message-Id: <1617140178-8773-31-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d691f5c6-3b36-4679-71c7-08d8f3c29344
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679F78F4A3BACDDE16B0724EC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhReXnxPgfP1TzqPJBGTGVO+x4PSyB+cORTisG/QF6H+YRIGmur6uKqA76ksK4yNPhGZjKqstAX5CcjcTnW6Gro98FFRJUKCvjkonVzLXu/5qVb2489ElPPlbQ1wRroByr6e6wAgr+Xi4Xv4m2ORcLG6o4+bSOvGJQeXKbKZ63LJq/vBgXXa3povI/6oQaXb01jhhr5lCDxDsHK9HbdAi6e/MG6F+CWhgZrJWfGXEPQnl1ii+5M7143kRCiRryDwHBYE64JKM9lqtozfhjDJZbBHXN4a4Alaon1A7n/5+RhzW95YCHBFS/3mgryYHytEgujUrwbadYEzR90jM2QByGusOHxaoo85HGtVPOrxsf75BEJ/j4gKGFGrioPQId4v3WC6NLSCo7ZIAolost7DHkCiSQC7ehgaskD+tVrEt6P4r3ZiuLd0fOM+1ppGxBbhdVzzdEs+Z6qU0ROm+rG227LeeQe3FRqPG1sz+ajLDdmadQFwNfPzxSRiPs9MN+7WwHdbMnpuYRw0kO8fLIYHyS9zbPs9tIoSbRgD/9nLIkPSUzNApFbZEFrUmgb2FCbkCpvqIO4/h1w52KhI85udX+pgVsWoGkA+UkryxMLV7VIgd/8K0tYM2MqYuMPODP9FB7FvRmK7+GyXbSJku3K3tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(956004)(2906002)(66476007)(16526019)(8676002)(316002)(2616005)(7406005)(8936002)(44832011)(83380400001)(38100700001)(6486002)(26005)(66946007)(66556008)(7416002)(186003)(4326008)(86362001)(52116002)(36756003)(5660300002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B+gHDkJChqsAllPqar+wwNO4a3qv+smcGlKlLU3mF1sEK+yTG0ntJOWmwRil?=
 =?us-ascii?Q?tMnAp2OdWnZ1IYHgHWCIZeJ2VZsd1D5qYHYORQUTai/NSPO1ycjoA3IeOkz3?=
 =?us-ascii?Q?AGhoVh74kg2gmyHXeldZz9oCLozwF6sf8iEvEVWbZY9AJyOylRlKgyrmcrbx?=
 =?us-ascii?Q?WcPfYaTznICZW7U2F0YozkI94+83pvwGTbnjtWT5EaRCYqflUEWBf7hZlxVp?=
 =?us-ascii?Q?suCM8IXAJtVjQoOOfAMYEZpUbRfM8h2Nk34QSPcrxhVwmf6K2IYLJrn73/SA?=
 =?us-ascii?Q?2EcHq7ZMiBaQ2EcX8D0tq80PptLsWNjQ9Q1NuuQqGDoOX3rPWLbQ7nWXw6EV?=
 =?us-ascii?Q?EY0hF33ofUbO/bqsvkGW4wUDtD3il9LDYBaPJl+OVQGLDqktcIpzdkl5ERSE?=
 =?us-ascii?Q?ciK9OCqcGsG6PelRZy+YB2RD48qpl6N8sgDQVaq8ohnKWNCZARIQO4C69+uw?=
 =?us-ascii?Q?GyL1g465xMuq1Q7d944eSnqfJk7jjeJ1KHz5WI8iwdU/aSWpDdvirsw/kt+C?=
 =?us-ascii?Q?yPT/iKgy38qvtXARyzMrp4sIkOrGv4eAeYPuAiFcvXUvw4lb0poabdQ0o4Jq?=
 =?us-ascii?Q?o/69CYL6Ew7TC1lTOFMWYAB8TWHCMxRry17oeFrJdvp9DGEM2olEYENhAYEZ?=
 =?us-ascii?Q?QjgxfIBCY3grHNPrYgr4vSEv5NGpKLA1XjnWLqrqT867Bg9iKFNPLe7pF1qO?=
 =?us-ascii?Q?Ita46SI4IB8FikJ3dFdCINkfKZseo8KwUS9niID9tSq6qYiGHeIEy4HHi46p?=
 =?us-ascii?Q?O+8o59QK4hMfrYkkdGheGES8BbCKYIeYBrYWA4oSS4K//JNA7+8fCaq2HW2k?=
 =?us-ascii?Q?ZJfeNYTkoDdb33q9OltWiB938fBWX5IGnb6D2EAKDKzsSWgFQED0RKKiSaqa?=
 =?us-ascii?Q?2Rws8ST7qQSteWhoBg0dgXY9CHZKbDav6BPDjc9nEq4A2UMaUs6zVeRX14bC?=
 =?us-ascii?Q?8PK3PrxAQWEeTHSF0yCyKB/FDUnxCA24j91eXiMIFcgslm+tgd2MRE18/EEl?=
 =?us-ascii?Q?z/wdS8wtlyhP56IDcxAm4d0fD5rTKK45vngn+gywgA1Kh1G3qscU152JkfR4?=
 =?us-ascii?Q?5TiWFvYXMODl47WolKAGI2lunOKIyRBi4D3ZnWcf0UEzjBjIHhOuZ2f7SEKx?=
 =?us-ascii?Q?wQg0+ijeL+/bIC1aLCdhC+V1zWTNAdgMinoq3o0Sqby2V3h0eJC3pEwFmSNO?=
 =?us-ascii?Q?VfTAtjSnsd7SkbtF6ebYyj9v2jWValvYNRgVzpnqx1WJBzd8M1RHkGV055Eb?=
 =?us-ascii?Q?asuBMXlfUInTkF9z9wpKu0pauND4bIHd+p6xeKkqGFfRntbqPHCp0ymykmFZ?=
 =?us-ascii?Q?TdSxPtMSfF18nIMcraUKgn/L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d691f5c6-3b36-4679-71c7-08d8f3c29344
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:09.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ukU4hnqe0r+rMIv7qE+SWLBE6zWuVyAJCTsQkSHmOqDgxrixueTJptFhiJQu1VNpXLlCWEIdEimUIqxYJnUOTAZBAMoB/ANO7svWYsT2Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: vjRxetZm2Z7TMBnOp4p4piIPyhwcci8w
X-Proofpoint-GUID: vjRxetZm2Z7TMBnOp4p4piIPyhwcci8w
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To support deferred initialization of page structs for preserved pages,
separate memblocks containing preserved pages by setting a new flag
when adding them to the memblock reserved list.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memblock.h | 6 ++++++
 mm/pkram.c               | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d13e3cd938b4..39c53d08d9f7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -37,6 +37,7 @@ enum memblock_flags {
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_PRESERVED	= 0x8,	/* preserved pages region */
 };
 
 /**
@@ -248,6 +249,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_preserved(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PRESERVED;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/pkram.c b/mm/pkram.c
index b8d6b549fa6c..08144c18d425 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1607,6 +1607,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 		} else if (pkr->base + pkr->size <= r->base) {
 			rgn->base = pkr->base;
 			rgn->size = pkr->size;
+			rgn->flags = MEMBLOCK_PRESERVED;
 			memblock_set_region_node(rgn, MAX_NUMNODES);
 
 			nr_preserved +=  (rgn->size >> PAGE_SHIFT);
@@ -1636,6 +1637,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 		rgn = &new->regions[k];
 		rgn->base = pkr->base;
 		rgn->size = pkr->size;
+		rgn->flags = MEMBLOCK_PRESERVED;
 		memblock_set_region_node(rgn, MAX_NUMNODES);
 
 		nr_preserved += (rgn->size >> PAGE_SHIFT);
-- 
1.8.3.1

