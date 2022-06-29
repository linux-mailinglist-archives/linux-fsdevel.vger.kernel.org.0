Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F43560CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiF2W5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiF2W4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:56:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64203DDFC;
        Wed, 29 Jun 2022 15:56:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4x8U001225;
        Wed, 29 Jun 2022 22:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=k4/2YhLdBS9tev1sSbPolGI4EAMIPHCQyBefTWEkvns=;
 b=kHhDNWoidmnKRcjdu+IA812dy0fVOIQTSIhxE0NKU/hjTVi5Ysis+2vj51nHn97+ZsCb
 vvJjNjmxFAcz9pOMDIAM0fd+iLTEIee/RKsyfA+Abgtp2oprtj2GzyJA6DF7fQgb+7v1
 DefXNpifY44C5tB+FzEr3h/8fhrKTpg53IWWdIaRnibxgl5QbKgeBqV20pcszDdW94xv
 86K0DPIgAAV0SQ7WoqvDYzdfCpjWuqJzPO1nVpDA+9Im47r5AP7nfspZPsPvPh8/iGO0
 KkzyV52jKNbEEF4xVgJj5aN9BbqTUaPLQ3unT+RQhSLjZeh20GdwUwSv35h+sSkcB1ra tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0jnk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMeSQq031826;
        Wed, 29 Jun 2022 22:54:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt3h9r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdkVnai984M/Ac/DVu85f703S+GZ1JLJyLQRW+CsvnXw9cTMVHykAoxPxKE4iDIkE5YBievg5i0onPLkY5Fp/4VlJk/9hhjZvvSiKqgW3o/p4EXLppuolb65/TltWhxukZFXxxtDUjLhekKYmVRmEN7RV5RM6S6m+XmmLM2l9Vg5RAHcerPDkTQGW98DaSP90IoiuKWXxGYjIQcvR5xY8rOu2Ofs6U9dHMETngUuQfxK8BsUtsOvGixol20YLV63c6rGKNgLlcyIJsmOs4ukf5sWK6BPeuBDFOU6cdPzqgFYpPGR22vhlyZbrGcDNonLfd+LGJ49/9oUexxaw9bdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4/2YhLdBS9tev1sSbPolGI4EAMIPHCQyBefTWEkvns=;
 b=NriXGcRJKM2DUkTs/x2+Og97XllF+hVNe7dTny+mOssRaAtlB4CMisDt9XdRPBcZ6n13K28fpLlc5kzhr4EElRx9hBXruKs9ddjgVCrGkBe8LTeslUy8lSHoGRjCov43jWlb9jKXyq3n0/d1NKmYW4oX+PQiU57+BYmzhUG5gRqaffxgBmSiXmzad8cu8PRRgno+Wu//eZwz66dJ5HdWoCwik7IEdVxwnAYXbwOZScOrVvWRyCegXxEZDxaeRpyaNE3yAkDR9DEQGWwprHbeJKAQ+vmYgy3F+CgHwckO9ZxeARcCCwqPjyuwFuyVW/H/Zj2PXz6w9IVn9y17KZS9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4/2YhLdBS9tev1sSbPolGI4EAMIPHCQyBefTWEkvns=;
 b=bgovyXG2zYCbFgYKHPapiLBXX1U+UQ2/hrq/VPAN4UAC2NmtWyJknTwdc0gfF7ipjEUzX6RlI8OKLlJOUNKviueXmTqr7BHczBZYcIwX89ozKvD1wgnZq6VFya/kSusFGzKpUR3CZcp5hJCpTx2f3UP1YqdZtDtbZy/d85NDH3M=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:15 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:15 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v2 0/9] Add support for shared PTEs across processes
Date:   Wed, 29 Jun 2022 16:53:51 -0600
Message-Id: <cover.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::6) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83446223-bc13-4fd4-86c2-08da5a224a9c
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFTzbNnHT1BMo8eCycGLxfhHfdgDCIuAttu5X1cDTJuAZl72jNMm4puYDq+zbGTPctxvNcUByRvfYNz42LprzvirUMNgdMOB6VJkI0PYzg4BenYXIykh/y38GiGNkS1ZtgPsFkXC/yD1FJYV3qsdhvjaWXlSDa0+9kvNezPzJLMZKD8X+Df/xlDxcbAmwbbjtt13j2ZJld5Mk//QCZREyLsTqdnn3SiFGSJ4GAbo2FB7g3zwOmHN+xOQKqJR7o9SkkH3qwcUBTdlaQrPmKowWym5vg+KUFXvP/FX/ehO1ayRGPlH4WuMjCtxebdiJXxwGS9S6G/l24hoUp6akJVTVf0c1EpmAz9taY5lX2X76km7M0qmw/ASCbizaa3fNjJ0b1GA36gwNVucxDO3xkEmU+DTCIXL9BOObL14W//i1LKy2kSyVaHUex44M3t4v+cNrjAAiGAGBWO6HXCJ/aJMdPKSQ1Pgz2Nusjz05CsffkbGmDQ96DkCZ6wosuEUg5KeaFUH448L0wyP46vGl0rbPu3++mrvc6kVDf4c0o2LeeX53aBijbgi9/6YwlG5F0yoIQ3Xvvz7/nXGkjKZoM+/JaPurGZlrMEZ8nwiiEErexJDi3X2EpY4eNJAM0L6EB4WRYdLYgIyiQK/oU9VRgl49IB/GjvJDkwSVT6r7kRni5uvqOiRkBmDZMW3vZzSqXt3mEmf3QIsi9p05OQlT7MbW1tNveaH5S3s+FaSLYkqvYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CO7ZgKH5GtLZDNRpWsD8B3zniBDieUvMWutb/jFgQq8Bw0/T63DA9B3sAMvP?=
 =?us-ascii?Q?s43DbH6rCx3/adykX4A40fiHfim+KuDU6rWwGcpK3T2dhPeaAmwhki55LXe8?=
 =?us-ascii?Q?wvG9ztpcibSjdDA0y8F7ERYJECyZd4M/LyjkenBB7gzKXrS7OVRQeuT7awxM?=
 =?us-ascii?Q?WMrIgwKu/osWvZllfrD4izbkuKfeyHhlb5mlHbCmK36E75APnUMMwFysiix/?=
 =?us-ascii?Q?kZw0baALAtIKQNS4Hrz6n94tJqrzDzlUM7J/ONK5LYnmKGBQnc/AORcTbnpq?=
 =?us-ascii?Q?G6djbY9JkaTyuf1bYipboy14YxnI8wsBuEuRLZ3eLaJfDIKhmH/hPIsVQDfm?=
 =?us-ascii?Q?AOcf6qA2JKHBSXWeoWxT0EFTKNNOhtc0UWzhb0rvsIzjkwJqNt/hu/aR36Pb?=
 =?us-ascii?Q?G43iYeVZeqXCrrLGckNwziDzhvKOezFszdSXSh0G6tNBK7OXNNKsdw//k+2y?=
 =?us-ascii?Q?BOUwqoLTO2uvWVhciPx2Vl4+01Cj9VRgeat+AO1E9k7TV9ivg9jYOGozZ2Ra?=
 =?us-ascii?Q?frpwhw8uYr3bJaVSVWDYZFCzezyzBWA8bkaXmxAU7wJ4e5vXcsuqDIk262uQ?=
 =?us-ascii?Q?U/PZvm0lRLv1hL9TUolgIE0Xp4mJWJF1tUOUSQuwIK6PDfyL6vz2reb0pQNZ?=
 =?us-ascii?Q?VYJRX8abJjIewAAXviwwNfzRmAc5HcslgKtPLnQ6oKss0OYmpfAcjATXGT5e?=
 =?us-ascii?Q?xOnFid+AfERsQVRGaATwk1MS2b/hDzKwAPquFFnNftZHxbAPZQOBT1gjo8U7?=
 =?us-ascii?Q?TNjN0JYEBVsE49RUKYgkQ3uX/w1gbXjGRwYKCBO2Xrerv70iqD1chnkoZhDU?=
 =?us-ascii?Q?6mZsvgOcqcNVNfXBjfw6n1kALZWPnw0DtAbTB0Qo9wW3gQxzl3zrQbpB2JBg?=
 =?us-ascii?Q?sJDwnhlVUFOsxh4z2fZcw0zkE8t/Ypezm/3V3p7trALR4ZjxMsfFSemX5Qui?=
 =?us-ascii?Q?CpJ6UFsRL3HSmRusgnmNUQ5omjXKj0ITl69xfS0JmV6a3NogD2mJsaKBzQgs?=
 =?us-ascii?Q?0I+eXuVfS4L3ExtoA8l7UzT59GW9rAGywC4EM3+5vQJeHt0RnmCEgxqGMwj0?=
 =?us-ascii?Q?VQ4s4nbPzvAq3bYnsCClWbqHCVWi+FFKNQ42oMpWs4T83xYV6AYr8nVftN6a?=
 =?us-ascii?Q?9kCT0tZMtUfIWr8uAgoMc8Kc7w0PyBACSXNQ2blkyUBGLNfxOdDHDTgos7aO?=
 =?us-ascii?Q?yb2kvB/LafYKv+LX2mlnrfmqXf1shXcgos00JDEdO40vR7gAu2azE5RVWFUE?=
 =?us-ascii?Q?5L1KHWWN0WJ/qW3+OucGp2Ul3e2DUnQDmxJMhJPPm1lPL46AwN1CORbng8h+?=
 =?us-ascii?Q?NNbNpI1yCZgOhVq3Cx5LH8Ozq9fPhXJUmNVTWK17TEoAHHazdQfwo7iHsVL+?=
 =?us-ascii?Q?a7KfROo876GC1Kdu7VvYjXZ8aovcfKHI6hWiFy/Z0hX/rLA4TGcHqAdrrdM5?=
 =?us-ascii?Q?JCQi4aentZC/2vo3pj/eOG4ZTxolZZeUYhinMOSKvLyl1JshX8uUeBEOysiT?=
 =?us-ascii?Q?TAE7JfgsS1DEkA9GLLhI2U5VGSDo0kS+a1VRoa/QGN9bVk7+M3fTFrRptYKw?=
 =?us-ascii?Q?zfpZW24GZXyDAho+s8zAWVy/Sm9PSTY+1FHT6A49thPnvVz+8V7cO0SzIS9g?=
 =?us-ascii?Q?B5xKjVURuuSKg+xMMaB21A/u6gLzhLclCHOp05QbwHrJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83446223-bc13-4fd4-86c2-08da5a224a9c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:15.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI2C198obZPpCcVlFDbokqyVdNKEoW2qn3l53PV4iQGH9Md2w6Mi3W+28iyllD9YcExooW7MzwspgIkXgEjCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=382 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290078
X-Proofpoint-GUID: GV7kbqvo5QZDONBe6Gu4Pt4GmdqAaWwU
X-Proofpoint-ORIG-GUID: GV7kbqvo5QZDONBe6Gu4Pt4GmdqAaWwU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Memory pages shared between processes require a page table entry
(PTE) for each process. Each of these PTE consumes consume some of
the memory and as long as number of mappings being maintained is
small enough, this space consumed by page tables is not
objectionable. When very few memory pages are shared between
processes, the number of page table entries (PTEs) to maintain is
mostly constrained by the number of pages of memory on the system.
As the number of shared pages and the number of times pages are
shared goes up, amount of memory consumed by page tables starts to
become significant. This issue does not apply to threads. Any number
of threads can share the same pages inside a process while sharing
the same PTEs. Extending this same model to sharing pages across
processes can eliminate this issue for sharing across processes as
well.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is only 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, amount of memory saved is very significant.

This patch series implements a mechanism in kernel to allow
userspace processes to opt into sharing PTEs. It adds a new
in-memory filesystem - msharefs. A file created on msharefs creates
a new shared region where all processes sharing that region will
share the PTEs as well. A process can create a new file on msharefs
and then mmap it which assigns a starting address and size to this
mshare'd region. Another process that has the right permission to
open the file on msharefs can then mmap this file in its address
space at same virtual address and size and share this region through
shared PTEs. An unlink() on the file marks the mshare'd region for
deletion once there are no more users of the region. When the mshare
region is deleted, all the pages used by the region are freed.


API
===

mshare does not introduce a new API. It instead uses existing APIs
to implement page table sharing. The steps to use this feature are:

1. Mount msharefs on /sys/fs/mshare -
	mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. Start
   address for the region must be aligned to an address boundary and
   be a multiple of fixed size. This alignment and size requirement
   can be obtained by reading the file /sys/fs/mshare/mshare_info
   which returns a number in text format. mshare regions must be
   aligned to this boundary and be a multiple of this size.

3. For the process creating mshare region:
	a. Create a file on /sys/fs/mshare, for example -
		fd = open("/sys/fs/mshare/shareme",
				O_RDWR|O_CREAT|O_EXCL, 0600);
	
	b. mmap this file to establish starting address and size - 
		mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);

	c. Write and read to mshared region normally.

4. For processes attaching to mshare'd region:
	a. Open the file on msharefs, for example -
		fd = open("/sys/fs/mshare/shareme", O_RDWR);

	b. Get information about mshare'd region from the file:
		struct mshare_info {
			unsigned long start;
			unsigned long size;
		} m_info;

		read(fd, &m_info, sizeof(m_info));
	
	c. mmap the mshare'd region -
		mmap(m_info.start, m_info.size,
			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

5. To delete the mshare region -
		unlink("/sys/fs/mshare/shareme");



Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
	fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
	read(fd, req, 128);
	alignsize = atoi(req);
	close(fd);
	fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
	start = alignsize * 4;
	size = alignsize * 2;
        addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
                        MAP_SHARED | MAP_ANONYMOUS, 0, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        strncpy(addr, "Some random shared text",
			sizeof("Some random shared text"));
-----------------


Snippet of code that a consumer process would execute looks like:

-----------------
	struct mshare_info {
		unsigned long start;
		unsigned long size;
	} minfo;


        fd = open("/sys/fs/mshare/shareme", O_RDONLY);

        if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
                printf("INFO: %ld bytes shared at addr 0x%lx \n",
				minfo.size, minfo.start);

        addr = mmap(minfo.start, minfo.size, PROT_READ | PROT_WRITE,
			MAP_SHARED, fd, 0);

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
	printf("\nDone\n");

-----------------



v1 -> v2:
	- Eliminated mshare and mshare_unlink system calls and
	  replaced API with standard mmap and unlink (Based upon
	  v1 patch discussions and LSF/MM discussions)
	- All fd based API (based upon feedback and suggestions from
	  Andy Lutomirski, Eric Biederman, Kirill and others)
	- Added a file /sys/fs/mshare/mshare_info to provide
	  alignment and size requirement info (based upon feedback
	  from Dave Hansen, Mark Hemment and discussions at LSF/MM)
	- Addressed TODOs in v1
	- Added support for directories in msharefs
	- Added locks around any time vma is touched (Dave Hansen)
	- Eliminated the need to point vm_mm in original vmas to the
	  newly synthesized mshare mm
	- Ensured mmap_read_unlock is called for correct mm in
	  handle_mm_fault (Dave Hansen)

Khalid Aziz (9):
  mm: Add msharefs filesystem
  mm/mshare: pre-populate msharefs with information file
  mm/mshare: make msharefs writable and support directories
  mm/mshare: Add a read operation for msharefs files
  mm/mshare: Add vm flag for shared PTE
  mm/mshare: Add mmap operation
  mm/mshare: Add unlink and munmap support
  mm/mshare: Add basic page table sharing support
  mm/mshare: Enable mshare region mapping across processes

 Documentation/filesystems/msharefs.rst |  19 +
 include/linux/mm.h                     |  10 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/linux/magic.h             |   1 +
 include/uapi/linux/mman.h              |   5 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |   7 +
 mm/memory.c                            | 101 ++++-
 mm/mshare.c                            | 575 +++++++++++++++++++++++++
 9 files changed, 719 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

-- 
2.32.0

