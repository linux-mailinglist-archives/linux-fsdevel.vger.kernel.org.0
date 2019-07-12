Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0EC66676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 07:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGLFlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 01:41:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbfGLFlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:41:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C5ahno021691
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 01:41:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpj35meh8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 01:41:12 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 12 Jul 2019 06:41:11 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 06:41:07 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6C5f5vh40042908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 05:41:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ECDB112061;
        Fri, 12 Jul 2019 05:41:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2586A112064;
        Fri, 12 Jul 2019 05:41:01 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.149.188])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 05:41:00 +0000 (GMT)
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
Subject: [PATCH 0/3] Remove x86-specific code from generic headers
Date:   Fri, 12 Jul 2019 02:36:28 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071205-0060-0000-0000-0000035D6D9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011413; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230955; UDB=6.00648415; IPR=6.01012239;
 MB=3.00027687; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 05:41:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071205-0061-0000-0000-00004A1B8F54
Message-Id: <20190712053631.9814-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120058
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Both powerpc¹ and s390² are adding <asm/mem_encrypt.h> headers. Currently,
they have to supply definitions for functions and macros which only have a
meaning on x86: sme_me_mask, sme_active() and sev_active().

Christoph Hellwig made a suggestion to "clean up the Kconfig and generic
headers bits for memory encryption so that we don't need all this
boilerplate code", and this is what this series does.

After this patch set, this is powerpc's <asm/mem_encrypt.h>:

    #ifndef _ASM_POWERPC_MEM_ENCRYPT_H
    #define _ASM_POWERPC_MEM_ENCRYPT_H

    #include <asm/svm.h>

    static inline bool mem_encrypt_active(void)
    {
	    return is_secure_guest();
    }

    static inline bool force_dma_unencrypted(struct device *dev)
    {
	    return is_secure_guest();
    }

    int set_memory_encrypted(unsigned long addr, int numpages);
    int set_memory_decrypted(unsigned long addr, int numpages);

    #endif /* _ASM_POWERPC_MEM_ENCRYPT_H */

I don't have a way to test SME nor SEV, so the patches have only been build
tested. They assume the presence of the following two commits:

Commit 4eb5fec31e61 ("fs/proc/vmcore: Enable dumping of encrypted memory
when SEV was active"), which is now in Linus' master branch;

Commit e67a5ed1f86f ("dma-direct: Force unencrypted DMA under SME for
certain DMA masks"), which is in dma-mapping/for-next and comes from this
patch:

https://lore.kernel.org/linux-iommu/10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com/

Thiago Jung Bauermann (3):
  x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to arch/Kconfig
  DMA mapping: Move SME handling to x86-specific files
  fs/core/vmcore: Move sev_active() reference to x86 arch code

 arch/Kconfig                       |  3 +++
 arch/x86/Kconfig                   |  5 ++---
 arch/x86/include/asm/dma-mapping.h |  7 +++++++
 arch/x86/include/asm/mem_encrypt.h | 10 ++++++++++
 arch/x86/kernel/crash_dump_64.c    |  5 +++++
 fs/proc/vmcore.c                   |  8 ++++----
 include/linux/crash_dump.h         | 14 ++++++++++++++
 include/linux/mem_encrypt.h        | 15 +--------------
 kernel/dma/Kconfig                 |  3 +++
 kernel/dma/mapping.c               |  4 ++--
 kernel/dma/swiotlb.c               |  3 +--
 11 files changed, 52 insertions(+), 25 deletions(-)

-- 

¹ https://lore.kernel.org/linuxppc-dev/20190521044912.1375-12-bauerman@linux.ibm.com/
² https://lore.kernel.org/kvm/20190612111236.99538-2-pasic@linux.ibm.com/

