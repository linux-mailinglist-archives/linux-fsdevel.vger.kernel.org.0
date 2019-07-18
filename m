Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6446D23F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfGRQnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 12:43:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388249AbfGRQnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:43:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IGgbET049742;
        Thu, 18 Jul 2019 12:43:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttustsud7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 12:43:31 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6IGhVX0052246;
        Thu, 18 Jul 2019 12:43:31 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttustsucm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 12:43:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6IGeMfn002703;
        Thu, 18 Jul 2019 16:43:30 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 2trtmrh27j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 16:43:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IGhSeD59507006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 16:43:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6053EBE058;
        Thu, 18 Jul 2019 16:43:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED650BE053;
        Thu, 18 Jul 2019 16:43:23 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 16:43:23 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-7-bauerman@linux.ibm.com> <20190718084456.GE24562@lst.de> <20190718150123.4230a00c.pasic@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-reply-to: <20190718150123.4230a00c.pasic@linux.ibm.com>
Date:   Thu, 18 Jul 2019 13:43:20 -0300
Message-ID: <87blxr47kn.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180175
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Halil Pasic <pasic@linux.ibm.com> writes:

> On Thu, 18 Jul 2019 10:44:56 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>
>> > -/* are we a protected virtualization guest? */
>> > -bool sev_active(void)
>> > -{
>> > -	return is_prot_virt_guest();
>> > -}
>> > -
>> >  bool force_dma_unencrypted(struct device *dev)
>> >  {
>> > -	return sev_active();
>> > +	return is_prot_virt_guest();
>> >  }
>> 
>> Do we want to keep the comment for force_dma_unencrypted?
>
> Yes we do. With the comment transferred:
>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks for your review.

Here is the new version. Should I send a new patch series with this
patch and the Reviewed-by on the other ones?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


From 1726205c73fb9e29feaa3d8909c5a1b0f2054c04 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Mon, 15 Jul 2019 20:50:43 -0300
Subject: [PATCH v4] s390/mm: Remove sev_active() function

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index ff813a56bc30..2542cbf7e2d1 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 static inline bool mem_encrypt_active(void) { return false; }
-extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78c319c5ce48..6c43a1ed1beb 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,14 +156,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 }
 
 /* are we a protected virtualization guest? */
-bool sev_active(void)
-{
-	return is_prot_virt_guest();
-}
-
 bool force_dma_unencrypted(struct device *dev)
 {
-	return sev_active();
+	return is_prot_virt_guest();
 }
 
 /* protected virtualization */
