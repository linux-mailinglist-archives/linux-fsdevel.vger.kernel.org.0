Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180C4FC1EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbiDKQML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiDKQK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D8286DD;
        Mon, 11 Apr 2022 09:08:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFdIBW008887;
        Mon, 11 Apr 2022 16:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=EBwYbFR7kFlqsY1mcLiNY9ZzjsnJMqqxbeoLcYz5X30=;
 b=Of7Ztr0qsUDInaMRqkcBXp8jobpqJtjVv0jlrPeyrBa3CFeHkNTQxoWiw+78n2teIZsa
 IDPPYPKSygYNJGunuLoj8+oyoFrACBd+Ek8DdtDSCQRRgReyK2oqTMuVBThqyuyxkLba
 GohPGIcvOsQ8KIbPp/u1TDT5gM+Pf0r5EP3MrGqsw7m+tFmeqOtrp2qlN3IdcLBy50Nz
 JcsCFYMmSF4AQCPX2U9tMIjs+CfhvRASUJYiBVi59UyY4w+oKq1XNFFDTVvlm/XvANeW
 cdEgu3KFRO7VqkA3utX97ai3lLrDIjwhU6rXJS7LiwHdLUJNMpmBkM4QWejNYLsV5vIK wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2c761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1fmb009876;
        Mon, 11 Apr 2022 16:07:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k205yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5iNEZgCNWZv3lnnGZogl3mFs3ROK359ri+a4zVaW7yGYi9w7GTv1YnupQcudEpP+6OTcFCDWVG+4YpvFMePbfQNxAUimJ9jbWvYCbjk/EQEndK+9ffusVd/5yFzO9AnbEbC+2lKhtwlGtf9oId18c2oDTHCm78aZIgMU2atzdPrWWsLtggSSVRpfpwLc6yGoICHhvVduvK/ZrDs4UZHLuxx0xiwUxVNhtO/ILfZRfAm2UAMSgEBjTs1GngA1FrG5wK0jhkguO5iN5yeWXn/y+6NYlDTG6TlheIklHflxBXige1v1Zx8aN9XlfzTgojSM41Td70bM/Hgz16pB25tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBwYbFR7kFlqsY1mcLiNY9ZzjsnJMqqxbeoLcYz5X30=;
 b=N/mGuMv2sx7WAych35KQ/JpScU7XzPLM7BrTXoAVPPA4DuIQ0Xr3W3B661YYDsADid/jQaCrrAPE6qcW2JrLvKp9Zv0MS0+H4VbfjUUoTD0AQOAVB188KZSESwYm5spZIwfkPn54LyKTEbafFQkmjjaZ87AkmeAA19cIn5Hdl1lesOou/mm0uLKIERAg1MNSm0wWxo+7Ojn55ylbn1cvFKXrabgMG7gQD6nvoD+7K5rozqz3qhPH8rdaJrt96eMNqv5wQ5PepL08sqBOTWI0QYH9u+zkMFWCBb9qvEjltfv74nuAFKe5BQaywxBatczHqN8xlBq4m+eYVlSY/9vcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBwYbFR7kFlqsY1mcLiNY9ZzjsnJMqqxbeoLcYz5X30=;
 b=tZQg3Dn2acuPEOlDsYADKVzo3ztral9YPFpOehrqzzDHOE2k86WADPS4G/Xi7gE68S1lGWJ710qor+Z8lu5mjN2XsG0EBoXlM7uPV1zAIcL/27FgI1lJFNRHhZ0kJV51odKvzW82R4CcxO0B5PQ4zVNFbolYeZz/ZgrF2ecQlzI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:48 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:47 +0000
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
Subject: [PATCH v1 14/14] mm/mshare: Copy PTEs to host mm
Date:   Mon, 11 Apr 2022 10:05:58 -0600
Message-Id: <4834724ec012da591863371cf4423d1971771d99.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4293f8ed-62a3-447b-d33b-08da1bd56bbc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45643482873CD3EB1801C9CB86EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAkDE0/kKo10FuRLJ8g8c6m64dnkIHJ8zSzfDkPDcHvkj4x8AlyhvjUqL9AJthC3NwAiFrsA9Y1dJp3Da+pf/Y8deaoHzoC/76H9HEsduagD/7pPNyifC0yVrlihz8Vp5rhX7WoNcxZ0eK+7ZUGelJlX1nkcSNwG8DBVk3QXJ0Tez7hER7zExWManjg+pmM1WGqXkUhbazdaBzySXk8+XJCsAgdx84oxi5Lo2p68YIcge+9aBGGehRaagv9NaKYHs0XbkinGJ3jzghSpNtZI2d2H9NeiiXiy3/dh/cqcZT6AIX9CDcr/EytFwya1B1mHKQbXh+1sLLFEWXEm8wnmEhRlW15fAk8J64yp6T5VbeiXEyyLtoreY67qMFpSi0UQb6gWg1ef4stEosuLJ+Qw1SF+nJvCcyMoOLVjHK0Ws7n+VEk/b7YQX6WpRUxu0iMkoLI2oS8y81DhmFb/Jj2mkNcJirDJOWz8JGMxAMErzbKCGXSrfdbbvs5usOJdM/Oynr2FtyG5KfU65eqxNOfr3wbjU2EL1ZosdJahB0KXBamT75waoqewS+73mmQ3cu8Q8cXOdED02BajLZ3rh06cc/CvcCX/6+VP7CTpL0xiD4XRHKd3vlfYFXgNTUcwA0uPvGFf5H85/knSu/d5R0O3U0zLUpfumYF6wj1FghQ7Ub8dso5mMqLVioxkTtpapHMD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMc1Q8OPg79azsV4friK7ed/i+vRLNaKy5InFrS88t2HT+5k+e6/EtAzbRDF?=
 =?us-ascii?Q?8fwffQWmPWXzKVB7XNx+4nRrBuflhVSsbf3/t8svq5U5jqAAyeZEjUJgWoOX?=
 =?us-ascii?Q?kfLBemuKaD/hTxS7B6fBQ6H97UIbNgrvOGFs56+7Jk4Ly6snuIsj79ocCfkz?=
 =?us-ascii?Q?u+YnCjnK5o/0iWwe8efkHlr58PKIoHJ0cy/YqRuZqQzk+zcnTsiRk4Xe4ToL?=
 =?us-ascii?Q?7DK1swhq+gDIdBSRdD3SA+yl5SVDaM3SxTpQBp9TWUo6m4RcUEWeaVuL3Ym/?=
 =?us-ascii?Q?zPfLv19UTnWCLEAZ2/Yc+zTHSul2hZyY2YSxN55xiVbwBLfdl0QUjxPxl0Cb?=
 =?us-ascii?Q?WoIqWzDiMeOfVG05hPswVGPLxVD+Nxy6z/ffhcRpOgmPtCkxtuX1ijIPJtYX?=
 =?us-ascii?Q?4nqGWZwTLKggcg/f/lfAG4TmPfh8F3YDg4v++2xPhqAcWLkiHFc1PrZPX+ZN?=
 =?us-ascii?Q?1jH0wLvIr1etF5Et67sFTqq1MMLCyLAQIMRCkyYan/tJtsKQ61a72bfwySsm?=
 =?us-ascii?Q?5eKHI8qlAn4v9pX1iJL1MNJt2EIdnAXiTl5MpBRxKZp6eGsFWM7JJM6JXQBS?=
 =?us-ascii?Q?oTEoLt2aNym9c6h/TRL7y9xuq8g4V2VrdhI3RfgPMD8IReT54iTgOkxt0ZsR?=
 =?us-ascii?Q?exO8kiuUowry8nCHxduZ3uvv7hFDeSA5Cga+UkKmgjCWYgq/14He9PONWe7L?=
 =?us-ascii?Q?7sAMnFTGLi2xhI7cZyeAjaNO8Rai6nfphNbHtpOt77EjRUBPtwwulizNHARr?=
 =?us-ascii?Q?1xyWHtpH9X8/VxDdQ33vPXyS/xSss6VR56N5XO6DBEOlwIpAk/UBnqtPzLxC?=
 =?us-ascii?Q?BFJrj4D94Pb6OrWblj5UNFUXE8hfgQ01uUk9uCF9pyq5zySSYq3NRKH0btzN?=
 =?us-ascii?Q?saqACpWDAvpJNRkKNqHMUhZoWsrahj1xNzSWl2HB9VCVH2n3B7q7pm08exp6?=
 =?us-ascii?Q?rl9JsKRlfewPryPTdKn3Dwig2GxU/5SdApsQdzOY3JECbDZUNHAd5X1nvdY6?=
 =?us-ascii?Q?D3WVc3QmV7RyeqaKiyEdrXLaYygdI5U/RqwyhXGsps9t2wap2U8uwPzEp3pf?=
 =?us-ascii?Q?mzP//fPi5SoqEul5yDsiTgK6dtm9YjRXlTB5vHZmbu+BvjBns6D2YI2C9pM6?=
 =?us-ascii?Q?Rj6ITnQ9wQccczAL5t4uXyAE/0yTTdCCjWrfQ31zC/CYR+Q3DjpopT5MPe7B?=
 =?us-ascii?Q?8W8eCibaXVaHwzXDWdyT06GgmrSxqoPipA7+f6IFbAYZpyf3203u+stGQfPM?=
 =?us-ascii?Q?2dI45n3Ya6tAymdgqEgJFe1miZf5Jyr/REnsFZ4mkq0toVQPpeUDVJgsKWcp?=
 =?us-ascii?Q?h/boJvNLR4OT4fBOwtrF7WRQo+oZl1e0Jg7XeB8YZ5breHmjRodo55f7kJeR?=
 =?us-ascii?Q?KNJTYP816j0WtVh04MpZmyLe/SiawLUrrpOaF2G96oBvqjXOJ5+kkLeVsHXt?=
 =?us-ascii?Q?haHFJVYBIHJb1WS1ch/EZsLt/FdrSIpc71tqE5Jb3JW/nux4nnMBhNL8wgCf?=
 =?us-ascii?Q?KGa7oQTLmuqpZXcAgPnmECoZX7vKjW2/ebhQEg3n/vDJhmZedb6iorn6PwdG?=
 =?us-ascii?Q?UUfxKHOT0T+YLMthkDi7+6lfV8qH9VkmeVG1oU6urv3VKs+8MVqLBlznZeey?=
 =?us-ascii?Q?En37GS1U2vmxs6rYHf4SoF64jH0ZzmGt9uPSS0+rc8GUDzLFOoDm46u6l3Ed?=
 =?us-ascii?Q?wXteU10LvVkl/BQV48/I9x8o0C8n8JlGWc3F04coYiNxA6arKEZOUEzVX21Q?=
 =?us-ascii?Q?OQdxSnvaNabVHtViJ3ip3NRgrb5KS5Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4293f8ed-62a3-447b-d33b-08da1bd56bbc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:47.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhIqXH9kA2S7sz2YJN4k9E2UMzZUQX0IRvrOIiVHBxxWqvq2ruhF377w6DY574BxWhTc6aVklAip5amF1rI1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: YmET7za0myCBpngmRYmgaMFd_OlmKwVS
X-Proofpoint-GUID: YmET7za0myCBpngmRYmgaMFd_OlmKwVS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VMAs for shared addresses are hosted by a separate host mm. Copy over
original PTEs from the donor process to host mm so the PTEs are
maintained independent of donor process.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/mshare.c        | 14 +++++---------
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d9456d424202..78c22891a792 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1845,6 +1845,8 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
+int
+mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 			  struct mmu_notifier_range *range, pte_t **ptepp,
 			  pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/mm/memory.c b/mm/memory.c
index e7c5bc6f8836..9010d68f053a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1234,6 +1234,54 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return 0;
 }
 
+/*
+ * Copy PTEs for mshare'd pages.
+ * This code is based upon copy_page_range()
+ */
+int
+mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	unsigned long next;
+	unsigned long addr = src_vma->vm_start;
+	unsigned long end = src_vma->vm_end;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	struct mmu_notifier_range range;
+	int ret = 0;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
+				0, src_vma, src_mm, addr, end);
+	mmu_notifier_invalidate_range_start(&range);
+	/*
+	 * Disabling preemption is not needed for the write side, as
+	 * the read side doesn't spin, but goes to the mmap_lock.
+	 *
+	 * Use the raw variant of the seqcount_t write API to avoid
+	 * lockdep complaining about preemptibility.
+	 */
+	mmap_assert_write_locked(src_mm);
+	raw_write_seqcount_begin(&src_mm->write_protect_seq);
+
+	dst_pgd = pgd_offset(dst_mm, addr);
+	src_pgd = pgd_offset(src_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(src_pgd))
+			continue;
+		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
+					    addr, next))) {
+			ret = -ENOMEM;
+			break;
+		}
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+
+	raw_write_seqcount_end(&src_mm->write_protect_seq);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
diff --git a/mm/mshare.c b/mm/mshare.c
index fba31f3c190f..a399234bf106 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -385,7 +385,6 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			 * Copy this vma over to host mm
 			 */
 			vma->vm_private_data = info;
-			vma->vm_mm = new_mm;
 			vma->vm_flags |= VM_SHARED_PT;
 			new_vma = vm_area_dup(vma);
 			if (!new_vma) {
@@ -394,6 +393,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 				err = -ENOMEM;
 				goto free_info;
 			}
+			new_vma->vm_mm = new_mm;
 			err = insert_vm_struct(new_mm, new_vma);
 			if (err) {
 				mmap_write_unlock(new_mm);
@@ -402,17 +402,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 				goto free_info;
 			}
 
+			/* Copy over current PTEs */
+			err = mshare_copy_ptes(new_vma, vma);
+			if (err != 0)
+				goto free_info;
 			vma = vma->vm_next;
 		}
 
-		/*
-		 * Copy over current PTEs
-		 */
-		myaddr = addr;
-		while (myaddr < new_mm->task_size) {
-			*pgd_offset(new_mm, myaddr) = *pgd_offset(old_mm, myaddr);
-			myaddr += PGDIR_SIZE;
-		}
 		/*
 		 * TODO: Free the corresponding page table in calling
 		 * process
-- 
2.32.0

