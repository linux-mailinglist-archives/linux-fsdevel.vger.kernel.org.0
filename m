Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1782A83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 06:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHFEts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 00:49:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfHFEts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:49:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x764kZLU010191
        for <linux-fsdevel@vger.kernel.org>; Tue, 6 Aug 2019 00:49:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u709rw01v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 00:49:46 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 6 Aug 2019 05:49:46 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Aug 2019 05:49:41 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x764nenF26083584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 04:49:40 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D757805E;
        Tue,  6 Aug 2019 04:49:40 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A33E7805F;
        Tue,  6 Aug 2019 04:49:35 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.207.254])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 04:49:34 +0000 (GMT)
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
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 0/6] Remove x86-specific code from generic headers
Date:   Tue,  6 Aug 2019 01:49:13 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080604-0004-0000-0000-00001532BE8E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011558; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242738; UDB=6.00655521; IPR=6.01024202;
 MB=3.00028060; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 04:49:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080604-0005-0000-0000-00008CC4ACEA
Message-Id: <20190806044919.10622-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This version has only a small change in the last patch as requested by
Christoph and Halil, and collects Reviewed-by's.

These patches are applied on top of v5.3-rc2.

I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
been build tested.

Changelog

Since v3:

- Patch "s390/mm: Remove sev_active() function"
  - Preserve comment from sev_active() in force_dma_unencrypted().
    Suggested by Christoph Hellwig.

Since v2:

- Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
  - Added "select ARCH_HAS_MEM_ENCRYPT" to config S390. Suggested by Janani.

- Patch "DMA mapping: Move SME handling to x86-specific files"
  - Split up into 3 new patches. Suggested by Christoph Hellwig.

- Patch "swiotlb: Remove call to sme_active()"
  - New patch.

- Patch "dma-mapping: Remove dma_check_mask()"
  - New patch.

- Patch "x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header"
  - New patch.
  - Removed export of sme_active symbol. Suggested by Christoph Hellwig.

- Patch "fs/core/vmcore: Move sev_active() reference to x86 arch code"
  - Removed export of sev_active symbol. Suggested by Christoph Hellwig.

- Patch "s390/mm: Remove sev_active() function"
  - New patch.

Since v1:

- Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
  - Remove definition of ARCH_HAS_MEM_ENCRYPT from s390/Kconfig as well.
  - Reworded patch title and message a little bit.

- Patch "DMA mapping: Move SME handling to x86-specific files"
  - Adapt s390's <asm/mem_encrypt.h> as well.
  - Remove dma_check_mask() from kernel/dma/mapping.c. Suggested by
    Christoph Hellwig.

Thiago Jung Bauermann (6):
  x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
  swiotlb: Remove call to sme_active()
  dma-mapping: Remove dma_check_mask()
  x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
  fs/core/vmcore: Move sev_active() reference to x86 arch code
  s390/mm: Remove sev_active() function

 arch/Kconfig                        |  3 +++
 arch/s390/Kconfig                   |  4 +---
 arch/s390/include/asm/mem_encrypt.h |  5 +----
 arch/s390/mm/init.c                 |  7 +------
 arch/x86/Kconfig                    |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 arch/x86/kernel/crash_dump_64.c     |  5 +++++
 arch/x86/mm/mem_encrypt.c           |  2 --
 fs/proc/vmcore.c                    |  8 ++++----
 include/linux/crash_dump.h          | 14 ++++++++++++++
 include/linux/mem_encrypt.h         | 15 +--------------
 kernel/dma/mapping.c                |  8 --------
 kernel/dma/swiotlb.c                |  3 +--
 13 files changed, 42 insertions(+), 46 deletions(-)

