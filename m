Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7C34F348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhC3V2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50272 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhC3V1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULODtq130422;
        Tue, 30 Mar 2021 21:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dt+SOSW+qvDjw9EGYi/aMPFOqeWbXNmaL/IUeUDEBl0=;
 b=sxfMV2gK8EFvU5Ca2XMOD4ZSV7GNe1szMgEcivKtXSUMJzChHsBRZC7yP0GEf6ajD09O
 kLG0kmekrmNkP2Xbj5dQXCPI77ZmFJyMJI7MB8CVJuTTsCtnU33svOKEie9r7faOHk+e
 yaKmACbGRhvZLhhNQy5GfaJULu1hBB4eBtuZKPi/TjKPDwUTjDw7SD7VURcZX1/TP98H
 P6m0zJMiljvbltkZvJ7mx0k+jAvwa7x4by95vCETQMjTax/JeJhQZldiYu7sfA9FK+1x
 G0WbZSJHJ7jwf6kZa2XdYw9adWVCl8GZmvHmIgzNgIbxh8+Hchs2VPqxaHhXkXMilcIT 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqr8nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSjf105821;
        Tue, 30 Mar 2021 21:26:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 37mabkbc8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TajIFc8467NYNapoImDZZoOci8TtpbhhhHICXfLfd4tEmSd8BGm3E1cccrRqn/nvui+a2mGoFpuJcgPMaQHL1PDm8hag21cKSeLTCKJmct97ZGLlmKsaL2vSEiMFthaD+f5sXRVX5TLr4hpN0bts2eSBHAVxtiQRNLJZVjlB7E//k7TbqiWF2SojPCHWFiOfTbXF/Tdx84gS9c0EH23PInQ8udS2lc2ddX/3Nkx4YHPXfxEZYHAhFlRrzAHl7FRAuMHhjX3U/AYNS0aUejRZHRMzDR9Com0hCWz8VyxlNsHGkpLLUjxrdcZl+BUeDpgRb5lhPMJoZFxhBqTLUq5wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt+SOSW+qvDjw9EGYi/aMPFOqeWbXNmaL/IUeUDEBl0=;
 b=meo4NdmbZjWFz2xffsrAduIsH8VX6C+jW2LVr8ySNPESLezVvjzLq39UmvlVwR0iPHQc3/24xVMVB8qopS0WGGxGok/4/guSBy/xu1lOH8dyHXnruENap6s688mB/g4t+Cp1OL6UkGLrYf5hI1pMOdpflG3hA5jzbCf7epmIFHfgeEmTRSRNa8EiGvq7n7/gdzVhsbCRS60mgc04a76kdKxNPctVdCFpRdjIS53RYuo7TGLKRizhgxEBAI4UoAoHNq3q76EcoxgUtxYkH1nxyUoKFvAfwvraYx2DZfYj+dYGjCteD8QUnNDRjIJ+1tbrrqwRus72UilEG4W930Xg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt+SOSW+qvDjw9EGYi/aMPFOqeWbXNmaL/IUeUDEBl0=;
 b=erLFKn51C18b2dYYlJhDP6k6miQSeNLbWuLGr8q4W624/ir7EBYQL25NPUsL6MQqc2PF8y9jufJTwlzu2l9FeOAUCpmIvNM6Lx4lLA7zoV4RtF+cZ47wdE1NnOnx8Js4uZtIyFWaI+Ab6ghHjnCwbEd/kKd1smLqOzNEcaMYTZQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:26:00 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:00 +0000
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
Subject: [RFC v2 14/43] PKRAM: prevent inadvertent use of a stale superblock
Date:   Tue, 30 Mar 2021 14:35:49 -0700
Message-Id: <1617140178-8773-15-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14222a83-9557-4da9-593c-08d8f3c26a26
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613531E4C3CA1FFEA47C1C1EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgRLE1Yo2yqsravy1bOac6QeOOvVW2tUsh0IHd25Z3AHz5eGQwCwthf1wUlj9OJYc1SRpYoM7W3dOVD1c6o9xkE5MDG9azzPwhQZFeIv1XHoHqy09L/+KssKI1mC7giefSBtJG5w3Y8uJLppQ+8FwwRZ2IHXbyqhEYmmc8DgPLxOErOjCm+E3JFnLlQsUvbShYIa/CONWL8G2t2JYRpn8Bvm08uny9y9KjbRxgzidS+Q9DyMAZjXnpK/DTQF6Ean0cwA8Ow88YqYjz+nDJIZ6HUHfiP3dBD1YUK6m/cmb2ja3fUhHD2v1VhmH3tJLo/lZcTZSluGDba5vsqsJU56SZX0Te4WSAKnRLLwfuerjMCdV7WBpbyhr3q29XmMSrKVpXLyoKujw5wQ2K6UfUC9jE5khnwl4Bz9Tc3bfxORhJvcMthU4MBlPI+C/09Axh/1J+OFgheKs5xp2dN3+wKeZzScbChzN4G3E6nFGNJH/YytA2nmQZMZrGoV936n9sOcQZuGztyxZXPttfjve+9Hhm/NjamB6bTT+7BgD4da07i6MSgV9JT+LZIbnlxu67HdRohP/X2ZoA+6ztj2E0Op/OFUrC0XxBwBX2qN11ktfwl4Qj3xDWnfIV9aQwJCkNa9X2qRmxoGpkW89et2aeP2iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1dBGyObA1efgYcXbkoAxhpm2DfdBDE8+UZOP0lnslGvOjYSofYx3kcAqYASZ?=
 =?us-ascii?Q?90RDw3tV5Gq1wDKXiZN7dp0uVJPSUUw9n+5+E6vDYTcyNDUbJTqWizCDxzun?=
 =?us-ascii?Q?3ZAlN/ZtTJS/fjjZB4uwT4MFsJ6Xhh5GQy+y2rtW0XoRoQLt8WQE3F2ZoZmH?=
 =?us-ascii?Q?OG+Q3Ir1+VkWf4YqkC4C5mpq7DPuofAuumat1zqE7iM9sn4VHUYraCBLQX4H?=
 =?us-ascii?Q?xuXJ0e6kz1dk6HXkBmKZ///4V/yhxjeKob3L+P+x3FC0GdlVXQ5oWphD5Qtk?=
 =?us-ascii?Q?FBx8klJeD5GFJ1TMJVc3YVQG1hqZ4FUW3PEobZQfxdZbU9cfzERR9sbZ1Xxq?=
 =?us-ascii?Q?pO5QtNwskPfmHSeG/GWHaJa4BJoyyT9/Ew0/AAXuGjm/IrjNu6kQ0DckKPEv?=
 =?us-ascii?Q?xnzfj8ovRZam0ZzBNIAaQNSYgeW224fh4BIihfVlv5vfD2cnDn+O8ZzB4wkb?=
 =?us-ascii?Q?nJs1d+kIirS80BoPi35OEXxr41aCPU/02PJ9ARuipOFbTpNNFXSY3jyy3W37?=
 =?us-ascii?Q?1P9KHCTXXYwFPnkX0B/Aab4LoJpZU+XXJy6A9rGt3rD0JRYBMWOBQcT8VBW7?=
 =?us-ascii?Q?eYh3nByTRyhW4mmBLJ6Vm9t6JroV8YEkJQ5+GzQyErX65wbU+8VkmxE2biIv?=
 =?us-ascii?Q?j3Y5/FD3rsSLznwdNvuCfmlYG9o4oLSbxp5cXgiqjuBbEmQIVhjYHNsO4Vas?=
 =?us-ascii?Q?5yyEbkuLOc2N9W5Ru9S+FRKX61whPqHLXJLo03FqJ/vTDfmY9j19RihxqBmQ?=
 =?us-ascii?Q?Ip03/ZqnUBKdW3qKPsNUtWXv5a2WMAnjfsoEWy13U7eVRjY3nuV0zKVlY4hR?=
 =?us-ascii?Q?OZVSa9Zm1rJNuTBuCtI4x1exNCNjD/xRNeaBAM2x2WkD9RM2hsaeXOx6Yy04?=
 =?us-ascii?Q?BwbvNd6CDEtVMGLLS48DZrr5NsAI4zGtKPKJpk+16Iap3NacGV5neKp2bmbu?=
 =?us-ascii?Q?VYNEu+UBoNqcWv1PHts+w+8vkYziEq4huRm74pd2UvJaKcmujhcDuhgMLEIF?=
 =?us-ascii?Q?29T1+ODddFduLsSMrqNj8kgqB9UwtSD3Gtw/TIVRi7DNnELHyDnsDA7KLQDt?=
 =?us-ascii?Q?TOfYioS/lzh36sAZGQ6vdJI5KmXujugnIHNICoQBsl+Q6/Guz0FCPgSYP2q2?=
 =?us-ascii?Q?ycWLFNrq0ODSxhXMaHsqZClMjEkRZZAN96BOxI1RLvp4ZEkG3j88CBMEWODX?=
 =?us-ascii?Q?L4t4fdJwsNzjVmZHv7NHcA/OAWhH+MScHquVUn1FlDRw/PJmYEipK8Mo9Qs5?=
 =?us-ascii?Q?+K+HXnndOMF3YoONzDX2J0mwNEZmECKZkVekhGxoY1UJWUgwXhBjwAnk45LL?=
 =?us-ascii?Q?H7a3xicZFpTomIv82YKcLCMT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14222a83-9557-4da9-593c-08d8f3c26a26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:00.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqA8PVSMvy/lgup76xFu6yCJc3WA9Q9jmDDNdqDorIPF5YvWhy7EfSWQMSlpJqrOOceA0EmKmvz9s57u3XEf/gCaPz/8Q+TrRhjGe2USx14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: xGdJ571s29Ex_rL6pWeLSAxpiCct7jYm
X-Proofpoint-GUID: xGdJ571s29Ex_rL6pWeLSAxpiCct7jYm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When pages have been saved to be preserved by the current boot, set
a magic number on the super block to be validated by the next kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index dab6657080bf..8670d1633a9d 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -22,6 +22,7 @@
 
 #include "internal.h"
 
+#define PKRAM_MAGIC		0x706B726D
 
 /*
  * Represents a reference to a data page saved to PKRAM.
@@ -112,6 +113,8 @@ struct pkram_region_list {
  * The structure occupies a memory page.
  */
 struct pkram_super_block {
+	__u32	magic;
+
 	__u64	node_pfn;		/* first element of the node list */
 	__u64	region_list_pfn;
 	__u64	nr_regions;
@@ -180,6 +183,11 @@ void __init pkram_reserve(void)
 		err = PTR_ERR(pkram_sb);
 		goto out;
 	}
+	if (pkram_sb->magic != PKRAM_MAGIC) {
+		pr_err("PKRAM: invalid super block\n");
+		err = -EINVAL;
+		goto out;
+	}
 	/* An empty pkram_sb is not an error */
 	if (!pkram_sb->node_pfn) {
 		pkram_sb = NULL;
@@ -993,6 +1001,7 @@ static void __pkram_reboot(void)
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
 	if (!err && node_pfn) {
+		pkram_sb->magic = PKRAM_MAGIC;
 		pkram_sb->node_pfn = node_pfn;
 		pkram_sb->region_list_pfn = rl_pfn;
 		pkram_sb->nr_regions = nr_regions;
-- 
1.8.3.1

