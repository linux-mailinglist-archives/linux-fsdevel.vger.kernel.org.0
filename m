Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3184F6667B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfGLFlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 01:41:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfGLFlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:41:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C5alPh129542;
        Fri, 12 Jul 2019 01:41:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpjd5ujb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 01:41:13 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6C5eu4U142040;
        Fri, 12 Jul 2019 01:41:12 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpjd5ujaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 01:41:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6C5dpi9015276;
        Fri, 12 Jul 2019 05:41:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2tjk979fjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 05:41:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6C5fAaM52232636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 05:41:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 562AF112061;
        Fri, 12 Jul 2019 05:41:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8FC9112064;
        Fri, 12 Jul 2019 05:41:05 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.149.188])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 05:41:05 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     x86@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/3] x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to arch/Kconfig
Date:   Fri, 12 Jul 2019 02:36:29 -0300
Message-Id: <20190712053631.9814-2-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712053631.9814-1-bauerman@linux.ibm.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120058
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

powerpc and s390 are going to use this feature as well, so put it in a
generic location.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328eada0..4ef3499d4480 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -927,6 +927,9 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config ARCH_HAS_MEM_ENCRYPT
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 12e02a8f9de7..7f4d28da8fe3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,6 +67,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
@@ -1500,9 +1501,6 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
-config ARCH_HAS_MEM_ENCRYPT
-	def_bool y
-
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
