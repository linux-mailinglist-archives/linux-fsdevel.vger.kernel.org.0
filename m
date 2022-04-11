Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B264FC1DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbiDKQKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbiDKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9E6574;
        Mon, 11 Apr 2022 09:07:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BEbCeu006846;
        Mon, 11 Apr 2022 16:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=RMrjpdZVMuKH6iGTSdQT19btiD9AINjP7U0Hso/baEY=;
 b=m7dYV4zO4K+OQiMbAEBS61aGqqGfqVKxgTP2YVSxh13cEOiy0mvpZlsvAECGCabGnbuI
 LDalC2tQTtDjLcSytRM15XiC39C/jd3WMnTr/JTXptBVvumlH9Bg7iG2mmbn2Hi0DzpJ
 J5kI6BbbzPjDlsKThq++WIhJjxl7E7O9v1cW/NRGJy5YNzAi6+pOPzuHyZFvgjLTga3u
 D6jlBZeOYgFgQDyLtS8kl93hp1ge280OxX4PEAuYE8InEtmBR8ztWeaZZBWxAPjFG8YB
 YWBb4VfcHrmVlqo8k8lhYCZeMGip3BeRzcLJpJdHvRxkA8KOH3lFkDHYbmuXCUAh7nzm xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs47dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG0NYF016212;
        Mon, 11 Apr 2022 16:07:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck11rxdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqFSzDtxLX96PAOZKyX1CVLoSozBjsJgCgdIJEOSvrcmbj0YO+Z0h/Xwo7aaC7O2R+iK9AbNt0kSz2w0k0lJDuKpuxjxU9d0xI7r1IPDfVbHP3Z3YiD21wkXdwh9/L+moNSVi1V7Uob/R0BFg3+5+RhQF8jg7+ugHmpnyBlPVhunTc8bM1WZ299f8gzYMyrADL6qP7AKpBe2BWAfL8o14PZjHTjrG665BF1x2MSWmzssCBDLvo3464EwabLxzM9Dk0X9abMPCdLshOWf4i1YcHZcyK3IMemWzGuJOW7T+JoJdAJsX/OFKekAwg/pQiqT4eYOpOUeznN1oYdOI8Jpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMrjpdZVMuKH6iGTSdQT19btiD9AINjP7U0Hso/baEY=;
 b=JCfudasCBFN3ThyvyFp5h0bHHY+siTDSUXYoNFETbHjxn+vXbNj6A+GQE65lv/RpMCzoXLGOze2JhCD+4h+MF+4BMCHc3f6DdDFMGG8zR9d9yj1xs3yP3cdrQUsU676xyHmxyQRGp1TvHPVwaN42c2dL/aJpNjGwSnBrLiXTfHUGOqu9RSqZH5zXPvILwb0g1zFpzaU85mt96XSK56Z6MDfuJwN14RWMSRM2eZj155pe/k8k6fTssQ2x00Li6EtEHELt0YI5jhJrJrliE9XZYON6Z433b7SE7AxeHGe1UdvOddfC2SK5i/7t+1XTdZxdVJPESot51FmTKY3cl+Z5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMrjpdZVMuKH6iGTSdQT19btiD9AINjP7U0Hso/baEY=;
 b=GlKeUfPzEmW/1yUJQOfSMtc0qYGMQVKilHrKH9IU9p+Jn0E/w1gf0QxgLeAB4NCno1uxuacr0vPqs5kGz8BZxMzkWl89sArPh7rZkwApCUIN28bU6dWk/iCNdzm6HEVNdtzcsL0PVeeM6McgXxKHYf4h3Qy3ttgwABp0nYj//rI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:16 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:16 +0000
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
Subject: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using mshare
Date:   Mon, 11 Apr 2022 10:05:52 -0600
Message-Id: <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fbeaf0-bec7-4287-d798-08da1bd558f1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4564C4835E6160A06FD0AAEC86EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olSYWcOwGp0jZ3WzFb6wxcHTXYxZL3Mg1dWzHUWEyTE6mjirFLTk/H7J6XdtitF8nPBSQv6oRgLgsaZM5z669rNT3A5ce6UO3XDPwzXroLzomIPo+fIIJcFxUzLmGDUKPEg9fQbU/cb4VLCJc8Q3JG6Ixmk07S1+WADh6iRz/EvRtZp5Jgs+Oms9dJw2pvBdPgY3H4eCUuQMBeRaHfzmsib3lDYMglA/0s1PQbokOmvFchiQVfGiO+8MvOlrZOZMfQcMAp7g7jh4sD6DltSLBrAq73CkGOLCSgPjX5njlEpBWDHPKlgVjS4HV0FRmTjzHYfQMdK9SJoeRO96w7XSYjy6V9e6HRELRYlTcJV7VSghI0lMZCNng8NSI+CJJs+wqsz1dfL/WFEz9E4o2wUADpQyMhtW4Pv7H5TG65R5lrB2g5P/7Pq6kd1syMDiR7SHDTZ8r5aJftz2EwKCz5Ntw9LB9Hd2jY+U5cehsEGbr4s22TDXCMH66QPxPQXJOkX6RzznNdSYHzZq9qyTY16ny23L/G+4V6wdOPLtx8N/52gvauGgvi4H9gJJaubFYmMNrdmV2kxD9eJu/vigdwCbWZcexP6BCm6x+/RLK/7kQJY1qKwEnY+6cPCFoKX1ZUMGkWT9nO5Zh9IU3lwfzjkeGDPb57yALIbKxPoQALz6PnTztUX570c7oWVBtYubedSVwTpVqXTowa1sjlCfV0SF8/waOruN1p4lUIDKKXQI65Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qnQ2HkgRtSHw96YvDitoO7BB/i+uVq1GDWw8Wl71KtKVzUCgBnYQYLkFKdtB?=
 =?us-ascii?Q?lZBQJ2ElxrrdtEuvJpHjNnbspGvPzN2z2GYpq/sTcq00ODmcy2SzphVQmIGO?=
 =?us-ascii?Q?uh/HorC4FlCRv0jM9pqfEVllHn5T2ATm0kQgTtPh16Bj1u4YOVYScr6/AWty?=
 =?us-ascii?Q?Jm9HUzYqRPN7f//HSkq8YTApUcnhCIm6sck0rMYXMNpqvMzh7DKfsIpV6uVo?=
 =?us-ascii?Q?ddcKFaF2ZX57V+gff3MKuqE8j5qxjJQKdlCogf2vIDIzGoH6ycEtXB1Ysftd?=
 =?us-ascii?Q?sCJfJtaAhimUGBpKq7obG9fNIUghL6YtQ/6epdto1sPBnutt5tLXRceMh+Cr?=
 =?us-ascii?Q?rMm7E4mYnXN92k7tX7h7oQBbkoD9K8CxdVYHe7FmlNUgYLXFxEO9gmIXpoVZ?=
 =?us-ascii?Q?zrwvnw6sChtRpByt/YJdPzdtGLX0Oh1WGbbGknm2XgJIiXSZpDoqRvG8xfvX?=
 =?us-ascii?Q?2eeYI6V9ABbnz4hqjgpEgFzIE21E0pyxTUb6x4uMztaT5fSOUJdvUHMgnbsG?=
 =?us-ascii?Q?n1M/ig7hFs8z3upDDq+LkutvWN/XhreK3IuinNmESUGA3WHalUPNpD1waw8A?=
 =?us-ascii?Q?tnGynQ1ccK6z1FGjZKq8yW1eRcoyxfuA9bFFq2yXxsVV0/lvHKvf1PSuQU/K?=
 =?us-ascii?Q?yHo2nXyBR+ThNdKXz5KAjXKrLPewF9xSHfj2od08uQy6qXFfEe0wVCYSu2aU?=
 =?us-ascii?Q?/hbt28yThansHsBi9W7KygCKRHc54/Mk4cfdiyZjNEIL4bwXf9dNjoaPk8Gg?=
 =?us-ascii?Q?p5con+LWZc29meq60Kz9wf0z/5Qm+9Qj00mxKuE6G6ZCmgmUhpjBXS7cT+8A?=
 =?us-ascii?Q?7dOwniRqNXRGhfYj1/XooJiJw5j41RwRPIQcMi2dUgSEz+SKJUQpPsR52kMl?=
 =?us-ascii?Q?V3N1nujQ0Alf3/C+aLrCXblsb6IwjC2kwLiahCr5UzcQjr9/9Qg9QxMghPIN?=
 =?us-ascii?Q?BRykM460ETnux5vNoi6scxuHnVS7C0kdWQiodRrO8Oh05Gjw5epq1s9PnNd0?=
 =?us-ascii?Q?S+J11kZh5E24mEAKfygLotJmC0GbDewtVyccPYsZWbA9C5k+3JAnH0B93Y/G?=
 =?us-ascii?Q?aS2yXU5yylV4OTsvFfViuyA8gHmHXNCmpfrRSCNT0ErPy6Dlp6KREyeFhtn7?=
 =?us-ascii?Q?QWSIpLb5HI7wGXjMZ8WW2e/hSt4OuvXun9pk9NQJ5/El+vXllOi4MC5gN2vp?=
 =?us-ascii?Q?w2j0jche1lT1mT2vFGJ6azMJyTj6aNzST57wreJDyA15aSRPMcP3ia2LjgUH?=
 =?us-ascii?Q?BwV0/4V9d2KaG/ztWQiwaVvHgx9K0eJNZR9PLyqwmIsmIe7s6veqalwesjfy?=
 =?us-ascii?Q?G+i/CtkSlfIrLEtaFira4pAOzwRSl820+OFpcbspMwNDBEessaqNXdKLbgAy?=
 =?us-ascii?Q?XwBpI9BXTA6FRAysvVUxaAjPj2AU8oAkNvtVEGXHXy7jdvN0eUtuLPJIbhpZ?=
 =?us-ascii?Q?AQNCtm8qMew/uPM6f1ubMX8PNzpRNSPDQIWjOB6U45X4LKYuIdNshhEuYQNf?=
 =?us-ascii?Q?PWZf9GXACibxdN+ngJfHgP8oVLTE+mGcDZrqgfeN8N08grrzCmGx65VSO0MS?=
 =?us-ascii?Q?QcAxmT/lUKTZS0rHteLBBzZyvpIGKqNw8D+3I22MAop7jBG4EfbHRSqaGR+5?=
 =?us-ascii?Q?8Uq9/8E5+AZO36KCL0B1AXXRgmTGQIVCEm+Momwvv+Wh1w5ZqNsX9fTJ8fYA?=
 =?us-ascii?Q?6d63/lMqkXOmK/WD53Ni/fXoqOQDNlJifew2Sx2Le2MqsjlEAfrWutJZTI57?=
 =?us-ascii?Q?q4i7jdc/ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fbeaf0-bec7-4287-d798-08da1bd558f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:16.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7856OagrOlvoUl4fdqcNydL+FpPx7kRhIF2nCetOdtcWC2KwQJ/IHp9C1mNEL75s9jxhr5qOYEaWL64CsC+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=803
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: mAenxAXbAm2vzM-cAcETcPD9evHGiO0m
X-Proofpoint-GUID: mAenxAXbAm2vzM-cAcETcPD9evHGiO0m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds basic page table sharing across tasks by making
mshare syscall. It does this by creating a new mm_struct which
hosts the shared vmas and page tables. This mm_struct is
maintained as long as there is at least one task using the mshare'd
range. It is cleaned up by the last mshare_unlink syscall.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h |   2 +
 mm/memory.c   |  35 ++++++++++
 mm/mshare.c   | 190 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 214 insertions(+), 13 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cf50a471384e..68f82f0f8b66 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,6 +718,8 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
+			unsigned long *addrp);
 static inline bool vma_is_shared(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_SHARED_PT;
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..c77c0d643ea8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4776,6 +4776,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -4785,6 +4786,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -4802,6 +4812,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	else
 		ret = __handle_mm_fault(vma, address, flags);
 
+	/*
+	 * Release the read lock on shared VMA's parent mm unless
+	 * __handle_mm_fault released the lock already.
+	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
+	 * it released mmap lock. If lock was released, that implies
+	 * the lock would have been released on task's original mm if
+	 * this were not a shared PTE vma. To keep lock state consistent,
+	 * make sure to release the lock on task's original mm
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if (!(ret & VM_FAULT_RETRY)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		if (release_mmlock)
+			mmap_read_unlock(current->mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mshare.c b/mm/mshare.c
index cd2f7ad24d9d..d1896adcb00f 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,18 +17,49 @@
 #include <linux/pseudo_fs.h>
 #include <linux/fileattr.h>
 #include <linux/refcount.h>
+#include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
 
 struct mshare_data {
-	struct mm_struct *mm;
+	struct mm_struct *mm, *host_mm;
 	mode_t mode;
 	refcount_t refcnt;
 };
 
 static struct super_block *msharefs_sb;
 
+/* Returns holding the host mm's lock for read.  Caller must release. */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
+{
+	struct vm_area_struct *vma, *guest = *vmap;
+	struct mshare_data *info = guest->vm_private_data;
+	struct mm_struct *host_mm = info->mm;
+	unsigned long host_addr;
+	pgd_t *pgd, *guest_pgd;
+
+	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
+	pgd = pgd_offset(host_mm, host_addr);
+	guest_pgd = pgd_offset(current->mm, *addrp);
+	if (!pgd_same(*guest_pgd, *pgd)) {
+		set_pgd(guest_pgd, *pgd);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	mmap_read_lock(host_mm);
+	vma = find_vma(host_mm, host_addr);
+
+	/* XXX: expand stack? */
+	if (vma && vma->vm_start > host_addr)
+		vma = NULL;
+
+	*vmap = vma;
+	return 0;
+}
+
 static void
 msharefs_evict_inode(struct inode *inode)
 {
@@ -169,11 +200,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
 	struct mshare_data *info;
-	struct mm_struct *mm;
 	struct filename *fname = getname(name);
 	struct dentry *dentry;
 	struct inode *inode;
 	struct qstr namestr;
+	struct vm_area_struct *vma, *next, *new_vma;
+	struct mm_struct *new_mm;
+	unsigned long end;
 	int err = PTR_ERR(fname);
 
 	/*
@@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if (IS_ERR(fname))
 		goto err_out;
 
+	end = addr + len;
+
 	/*
 	 * Does this mshare entry exist already? If it does, calling
 	 * mshare with O_EXCL|O_CREAT is an error
@@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
+		inode = d_inode(dentry);
 		err = -EEXIST;
 		dput(dentry);
 		goto err_unlock_inode;
 	}
 
 	if (dentry) {
+		unsigned long mapaddr, prot = PROT_NONE;
+
 		inode = d_inode(dentry);
 		if (inode == NULL) {
+			mmap_write_unlock(current->mm);
 			err = -EINVAL;
 			goto err_out;
 		}
 		info = inode->i_private;
-		refcount_inc(&info->refcnt);
 		dput(dentry);
+
+		/*
+		 * Map in the address range as anonymous mappings
+		 */
+		oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
+		if (oflag & O_RDONLY)
+			prot |= PROT_READ;
+		else if (oflag & O_WRONLY)
+			prot |= PROT_WRITE;
+		else if (oflag & O_RDWR)
+			prot |= (PROT_READ | PROT_WRITE);
+		mapaddr = vm_mmap(NULL, addr, len, prot,
+				MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
+		if (IS_ERR((void *)mapaddr)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		refcount_inc(&info->refcnt);
+
+		/*
+		 * Now that we have mmap'd the mshare'd range, update vma
+		 * flags and vm_mm pointer for this mshare'd range.
+		 */
+		mmap_write_lock(current->mm);
+		vma = find_vma(current->mm, addr);
+		if (vma && vma->vm_start < addr) {
+			mmap_write_unlock(current->mm);
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		while (vma && vma->vm_start < (addr + len)) {
+			vma->vm_private_data = info;
+			vma->vm_mm = info->mm;
+			vma->vm_flags |= VM_SHARED_PT;
+			next = vma->vm_next;
+			vma = next;
+		}
 	} else {
-		mm = mm_alloc();
-		if (!mm)
+		unsigned long myaddr;
+		struct mm_struct *old_mm;
+
+		old_mm = current->mm;
+		new_mm = mm_alloc();
+		if (!new_mm)
 			return -ENOMEM;
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			err = -ENOMEM;
 			goto err_relmm;
 		}
-		mm->mmap_base = addr;
-		mm->task_size = addr + len;
-		if (!mm->task_size)
-			mm->task_size--;
-		info->mm = mm;
+		new_mm->mmap_base = addr;
+		new_mm->task_size = addr + len;
+		if (!new_mm->task_size)
+			new_mm->task_size--;
+		info->mm = new_mm;
+		info->host_mm = old_mm;
 		info->mode = mode;
 		refcount_set(&info->refcnt, 1);
+
+		/*
+		 * VMAs for this address range may or may not exist.
+		 * If VMAs exist, they should be marked as shared at
+		 * this point and page table info should be copied
+		 * over to newly created mm_struct. TODO: If VMAs do not
+		 * exist, create them and mark them as shared.
+		 */
+		mmap_write_lock(old_mm);
+		vma = find_vma_intersection(old_mm, addr, end);
+		if (!vma) {
+			err = -EINVAL;
+			goto unlock;
+		}
+		/*
+		 * TODO: If the currently allocated VMA goes beyond the
+		 * mshare'd range, this VMA needs to be split.
+		 *
+		 * Double check that source VMAs do not extend outside
+		 * the range
+		 */
+		vma = find_vma(old_mm, addr + len);
+		if (vma && vma->vm_start < (addr + len)) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		vma = find_vma(old_mm, addr);
+		if (vma && vma->vm_start < addr) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		mmap_write_lock(new_mm);
+		while (vma && vma->vm_start < (addr + len)) {
+			/*
+			 * Copy this vma over to host mm
+			 */
+			vma->vm_private_data = info;
+			vma->vm_mm = new_mm;
+			vma->vm_flags |= VM_SHARED_PT;
+			new_vma = vm_area_dup(vma);
+			if (!new_vma) {
+				err = -ENOMEM;
+				goto unlock;
+			}
+			err = insert_vm_struct(new_mm, new_vma);
+			if (err)
+				goto unlock;
+
+			vma = vma->vm_next;
+		}
+		mmap_write_unlock(new_mm);
+
 		err = mshare_file_create(fname, oflag, info);
 		if (err)
-			goto err_relinfo;
+			goto unlock;
+
+		/*
+		 * Copy over current PTEs
+		 */
+		myaddr = addr;
+		while (myaddr < new_mm->task_size) {
+			*pgd_offset(new_mm, myaddr) = *pgd_offset(old_mm, myaddr);
+			myaddr += PGDIR_SIZE;
+		}
+		/*
+		 * TODO: Free the corresponding page table in calling
+		 * process
+		 */
 	}
 
+	mmap_write_unlock(current->mm);
 	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
-err_relinfo:
+unlock:
+	mmap_write_unlock(current->mm);
 	kfree(info);
 err_relmm:
-	mmput(mm);
+	mmput(new_mm);
 err_unlock_inode:
 	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
@@ -294,11 +445,24 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 
 	/*
 	 * Is this the last reference?
+	 * TODO: permission checks are needed before proceeding
 	 */
 	if (refcount_dec_and_test(&info->refcnt)) {
 		simple_unlink(d_inode(msharefs_sb->s_root), dentry);
 		d_drop(dentry);
 		d_delete(dentry);
+		/*
+		 * TODO: Release all physical pages allocated for this
+		 * mshare range and release associated page table. If
+		 * the final unlink happens from the process that created
+		 * mshare'd range, do we return page tables and pages to
+		 * that process so the creating process can continue using
+		 * the address range it had chosen to mshare at some
+		 * point?
+		 *
+		 * TODO: unmap shared vmas from every task that is using
+		 * this mshare'd range.
+		 */
 		mmput(info->mm);
 		kfree(info);
 	} else {
-- 
2.32.0

