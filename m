Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A534F330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhC3V1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhC3V1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOpH2011615;
        Tue, 30 Mar 2021 21:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=YBKqO6Kx+Py25onm/mOZ3eSPATqB2W3PO6LpaRw3oII=;
 b=fbYtdKja6TrrQl5ReDicXI9cPnZAmilTBO96wqt/zEZMbl+7mmluKDqCi+1aj+quejkW
 kKeN8fVjhdtsMnPyzmku3XdMWsg7SfvFoH1t07ys40KokFPTZ9N/Xj3oU9VCgXFfDwK1
 GKWd7N9ATb6SZJdea9qQHVJN63msNLwYbEuc++OqobyGxTCUOUCGd1gyMmW/qj5o15dp
 3mfMOx5t1iTcq9IoCTPbSIvFtd/YtRenRxDyf0XUTkrojDpJ6QfGG8ZYZC7Nj80R3PQQ
 1pDsQD4GvoVhl1VvwpIKknEB2s/0HzwTNP9GkmKrCCrJEmEGGHXny/x72/qyZTNLHWJj YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37mab3g8x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSCV105888;
        Tue, 30 Mar 2021 21:26:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 37mabkbcm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAEFID0p4Xb3YzDO31ZpGboq9p6x6uOFB4bYMiMsj3v11y9CElnWJUGmyzRzzmUmjdhWc7yKe4Zx0dOuiHpE/TgGjujmg3dcR/scXzXbkWZ/N+CVFTTeVZuc7FLz6NdzdpunXQf251wBfWMRalSB0W18KMLsZld98I0cknknoyhsfq5bcAHeojbq5ol2dG/pOXYLOu8O0vGxMRSAhCcdU1CPgZsF0nQXnIPwJMW6WS93R/Sow3IYSjjGQ0UIECDfhfibTcJ8Q97Swcux/FDKfWummZG1vF8pTFBvgV1SPLGHkfXvlCmHy13D7jyJgcoXaPSw5yrABFcQeyEXgqCfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBKqO6Kx+Py25onm/mOZ3eSPATqB2W3PO6LpaRw3oII=;
 b=PW54++o4wZI5T5ZtBm1AWTxTu9kYYGUo41VkuT8TX4iJWbPBAJp8ZmiCN04H+nRWieP2APJadHpKLKMGruPAshlwpRxTED+6V+tN61ZpjJgT+ReOY7SyHwtywKZkm7VX+MzbPDuyisQa2SdMDzWAJS395z2TYOnSQ4OpRfcpDI8jPLta3Zotw4n+tI+kgTcb1s+0E3fvif8Qmr2Spu42rXjzXu9xo3fD6Ti/6gdaxnELEQK/czld2yTzMCsiIb4qAfhz7ma8QFMRvc7BMa8X3itPszBoX6LLclUQ3+bmJp7NSI+15RFCN2ic4A6pZEXnMfIj8Urtbe+DGylePxp0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBKqO6Kx+Py25onm/mOZ3eSPATqB2W3PO6LpaRw3oII=;
 b=h0Qk7RaaA7/MH88q13mk2TcsYf0wIOgZ7ignkJJfMU4UFhhlUCqOA+QcO7iQVjf8sfPiCp+ArOG3KgaXwmQkzUBaGD6sOkWntwvCarEXyk5Z8Js/rUk7I+vc9OmpuMVdC6LipXRC5eRSgohfBGJvwmCxum7YnC68COUnlF+Ifa0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:35 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:35 +0000
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
Subject: [RFC v2 22/43] x86/boot/compressed/64: use 1GB pages for mappings
Date:   Tue, 30 Mar 2021 14:35:57 -0700
Message-Id: <1617140178-8773-23-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9c3f303-e67a-4ef8-9b9c-08d8f3c27ec0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB360089672D89483555678A82EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4c1Sux/vcaNySDgicY6EUOa0TwPMT3PgL+M8zbgWFqmaWw8xhpmaPl7ZMdsff9Qr/315bGzA2/bHeEhCGwNoKY4rIb1n1Q2EUaGVTS+Xkmz52OBTVzEYbm2X1+qDx0tkBLgt8yEBG/uCyHf48oKtpoShhTXzL9PCai8QmYknK/NequQMJNGFmOp9Ka/NLtvEH5Nr0Iw7Zft8dQib3f1otfA1UeS9Xgj+y3MD6GYdvkwJtC3tfeItjk1rdFgRv19+JPfLHa/XUahTmIGvjMfWfeCXfVl9I5/hhVbZRuO17HiRvmvU13kLhC60OVT+FCSk08kX7Nq+p4+DfG9imSbuXyUXY/jFS2liNZZgyu6JMqD945zMZJoxp45VT+AhlO1ADsWegl2oRqjd9xzx1WrpHbmuL4CI63rkcZW1heu3NXl0fCS6anHCcCuRoDDmbkfivuebizrVOuCpX6D4Y6GOvNfHzDdyI5aiPNNcxJDM1NjoBeqQVlnwG53MvOd6/AKzfR/jRGt2dXRLF/cqJCDS8orSoy1x9vTvL3MNjk6hCa2l4/TgeDBMlvLlQ5mS2Mj/8E9SJH19fuiDK8BPywYv0V8VX/lhuxr+ExAb5cOn1QLEz4E+OQfmLWaOochMF7KuhjX36iALNaL+Vnj1d7GbbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4jQ05CVbj5B00CojA9dhvXU3syqH4rCtyBCLplhAYbxiI9FWTPBFITNl5H+/?=
 =?us-ascii?Q?X+uNIe9Smi9UQDKPakPHghgO+t72RioFeOdsqptcfxCunkFDq1d12ffDmDB6?=
 =?us-ascii?Q?RS5U3YPKfh/Z1ek4VcGquc/wrYkmbQQLrGSu7U2Y42NvmMB+qF1MMbEuBsQ0?=
 =?us-ascii?Q?o2LDJ0v3w9SM06ooIHgVZGL0rzu+1xE/A+NO0mJ6/aUH1W9fqXL2KWXL/wGu?=
 =?us-ascii?Q?qTzBqOfBDMNRCgaAQLez/6VTN0O9ce1MzxtOny9iXLrO7xKIvt/dKE8DyPCF?=
 =?us-ascii?Q?VZD+RnSO2nmRRWHIOA/osNMxUvfJvkW9UyDH7EPTxxd1Zivw9NA6oKUnZMR8?=
 =?us-ascii?Q?gE/IEjdTLXCJZk8VCpyC2RWykYyndR4bAX56an769jg9mjf1mZFbN7UXq5nq?=
 =?us-ascii?Q?8vzqFCNsT0SspMID0YRJXqSRVoYcrQbplFLmjG0+9EC+LZsb/23s8/VxDMg8?=
 =?us-ascii?Q?N47ghcrV/a2OVeF24pA/3FRaXdwKnYJc8Xn/zrsGk16x4byWIjF/I+Zd/Mjb?=
 =?us-ascii?Q?ya+edXjIx0bNelLDWTgtQTpebD/pyKhIftoPnx1VG+tuBtqoJ6k+V9YAgDbd?=
 =?us-ascii?Q?riMKDQKa1+Q8vjidBGfHFudu302gJ1fkqxaKGrFwdc9/LcqpOJCqLuZteor8?=
 =?us-ascii?Q?+gNNMViBzdOh3CzUXU4FCrivDhYfBqLiXwgDsbFQW7KRSjnAlJGobm++WtVR?=
 =?us-ascii?Q?rX8drPaRo3j+01OlMOzVuRoMXAIs8FQaTImCojj0K9QqMy0GCFnEu9sInnqO?=
 =?us-ascii?Q?Z7P8BXXNzsAdu2pbITg8C7CMBujczNlKv8GpQVAp+jQPlQG1KvloSg141QFM?=
 =?us-ascii?Q?1PDsMHQ1VIx8RcHXkYYZpuyY+ZK+xNQtXeXqHji3aTQcFm4Nv0M0qs88V9cd?=
 =?us-ascii?Q?wyBf9sJ1NKTCb9lZ4ATizAhD0yBilwv6OZypadQhjli8KGLQ3dDuJnKTXeen?=
 =?us-ascii?Q?HHosUUADFQi8fvXMQY7U7Fe32V5A6QDpJ94VR10Hdelal2rOq9xWpdNeKyoR?=
 =?us-ascii?Q?+SVa+tTjL+/iWDjUQpSTkQ7tZ4vY6cqwY3SytKI2GgWK6cElgX6FaivmAxc8?=
 =?us-ascii?Q?m6bA9/iUEvQWLQ3jFueQRbVOa3CpIHT1tXwSblPcCtrFJa0InXNPQ/2n5O4L?=
 =?us-ascii?Q?eXpgTSkoXNVbxFowvc7P2OqQMQ3ZCydMny7ulxQZFc0UiWBHaB4Byjut3q5o?=
 =?us-ascii?Q?i+az8uKlHuvSUBS7nXLq2RqE53WT/xWlCB/vLtDFEV+hwhHpNG4fBkb3aIrP?=
 =?us-ascii?Q?2ZyJX078Ndij3ZdKTGlFJBv4HsBNc+ESFHGtUifzw+zfx2M1u+t96sT9xOSP?=
 =?us-ascii?Q?34eLVBjEk4hccXwHn/cg+//p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c3f303-e67a-4ef8-9b9c-08d8f3c27ec0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:35.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwAHgAHOCXXBPVIbNDCeLsN/qYVGykYFmyMzjwRbf45eb4K0cLFI6/yt2E1iuLTIC6udAb4kLERlSunJlaQ9adTiVorRVuL+6V9BsRfhNbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: j7RGzK128KWgKUwJZCfOSoqy471JPzep
X-Proofpoint-GUID: j7RGzK128KWgKUwJZCfOSoqy471JPzep
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pkram kaslr code can incur multiple page faults when it walks its
preserved ranges list called via mem_avoid_overlap().  The multiple
faults can easily end up using up the small number of pages available
to be allocated for page table pages.

This patch hacks things so that mappings are 1GB which results in the need
for far fewer page table pages.  As is this breaks AMD SEV-ES which expects
the mappings to be 2M.  This could possibly be fixed by updating split
code to split 1GB page if the aren't any other issues with using 1GB
mappings.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..6ff02da4cc1a 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -95,8 +95,8 @@ static void add_identity_map(unsigned long start, unsigned long end)
 	int ret;
 
 	/* Align boundary to 2M. */
-	start = round_down(start, PMD_SIZE);
-	end = round_up(end, PMD_SIZE);
+	start = round_down(start, PUD_SIZE);
+	end = round_up(end, PUD_SIZE);
 	if (start >= end)
 		return;
 
@@ -119,6 +119,7 @@ void initialize_identity_maps(void *rmode)
 	mapping_info.context = &pgt_data;
 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
 	mapping_info.kernpg_flag = _KERNPG_TABLE;
+	mapping_info.direct_gbpages = true;
 
 	/*
 	 * It should be impossible for this not to already be true,
@@ -329,8 +330,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
+	address   &= PUD_MASK;
+	end        = address + PUD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
-- 
1.8.3.1

