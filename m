Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3AC40461D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352555AbhIIH0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 03:26:42 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:37307 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhIIH0l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:26:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H4rBd5z43z9sWc;
        Thu,  9 Sep 2021 09:25:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tI4gb1MB9n_o; Thu,  9 Sep 2021 09:25:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H4rBd4d9gz9sWb;
        Thu,  9 Sep 2021 09:25:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 837618B77E;
        Thu,  9 Sep 2021 09:25:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id D01rvl7fvhrg; Thu,  9 Sep 2021 09:25:29 +0200 (CEST)
Received: from po9476vm.idsi0.si.c-s.fr (po22017.idsi0.si.c-s.fr [192.168.7.20])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CE478B77D;
        Thu,  9 Sep 2021 09:25:27 +0200 (CEST)
Subject: Re: [PATCH v3 8/8] treewide: Replace the use of mem_encrypt_active()
 with cc_platform_has()
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a9d9a6a7-b3b3-570c-ef3d-2f5f0b61eb0b@csgroup.eu>
Date:   Thu, 9 Sep 2021 07:25:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/21 10:58 PM, Tom Lendacky wrote:
> 
> diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
> index ba9dab07c1be..2f26b8fc8d29 100644
> --- a/arch/powerpc/include/asm/mem_encrypt.h
> +++ b/arch/powerpc/include/asm/mem_encrypt.h
> @@ -10,11 +10,6 @@
>   
>   #include <asm/svm.h>
>   
> -static inline bool mem_encrypt_active(void)
> -{
> -	return is_secure_guest();
> -}
> -
>   static inline bool force_dma_unencrypted(struct device *dev)
>   {
>   	return is_secure_guest();
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 87f001b4c4e4..c083ecbbae4d 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/mm.h>
>   #include <linux/memblock.h>
> +#include <linux/cc_platform.h>
>   #include <asm/machdep.h>
>   #include <asm/svm.h>
>   #include <asm/swiotlb.h>
> @@ -63,7 +64,7 @@ void __init svm_swiotlb_init(void)
>   
>   int set_memory_encrypted(unsigned long addr, int numpages)
>   {
> -	if (!mem_encrypt_active())
> +	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>   		return 0;
>   
>   	if (!PAGE_ALIGNED(addr))
> @@ -76,7 +77,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>   
>   int set_memory_decrypted(unsigned long addr, int numpages)
>   {
> -	if (!mem_encrypt_active())
> +	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>   		return 0;
>   
>   	if (!PAGE_ALIGNED(addr))

This change unnecessarily complexifies the two functions. This is due to 
cc_platform_has() being out-line. It should really remain inline.

Before the change we got:

0000000000000000 <.set_memory_encrypted>:
    0:	7d 20 00 a6 	mfmsr   r9
    4:	75 29 00 40 	andis.  r9,r9,64
    8:	41 82 00 48 	beq     50 <.set_memory_encrypted+0x50>
    c:	78 69 04 20 	clrldi  r9,r3,48
   10:	2c 29 00 00 	cmpdi   r9,0
   14:	40 82 00 4c 	bne     60 <.set_memory_encrypted+0x60>
   18:	7c 08 02 a6 	mflr    r0
   1c:	7c 85 23 78 	mr      r5,r4
   20:	78 64 85 02 	rldicl  r4,r3,48,20
   24:	61 23 f1 34 	ori     r3,r9,61748
   28:	f8 01 00 10 	std     r0,16(r1)
   2c:	f8 21 ff 91 	stdu    r1,-112(r1)
   30:	48 00 00 01 	bl      30 <.set_memory_encrypted+0x30>
			30: R_PPC64_REL24	.ucall_norets
   34:	60 00 00 00 	nop
   38:	38 60 00 00 	li      r3,0
   3c:	38 21 00 70 	addi    r1,r1,112
   40:	e8 01 00 10 	ld      r0,16(r1)
   44:	7c 08 03 a6 	mtlr    r0
   48:	4e 80 00 20 	blr
   50:	38 60 00 00 	li      r3,0
   54:	4e 80 00 20 	blr
   60:	38 60 ff ea 	li      r3,-22
   64:	4e 80 00 20 	blr

After the change we get:

0000000000000000 <.set_memory_encrypted>:
    0:	7c 08 02 a6 	mflr    r0
    4:	fb c1 ff f0 	std     r30,-16(r1)
    8:	fb e1 ff f8 	std     r31,-8(r1)
    c:	7c 7f 1b 78 	mr      r31,r3
   10:	38 60 00 00 	li      r3,0
   14:	7c 9e 23 78 	mr      r30,r4
   18:	f8 01 00 10 	std     r0,16(r1)
   1c:	f8 21 ff 81 	stdu    r1,-128(r1)
   20:	48 00 00 01 	bl      20 <.set_memory_encrypted+0x20>
			20: R_PPC64_REL24	.cc_platform_has
   24:	60 00 00 00 	nop
   28:	2c 23 00 00 	cmpdi   r3,0
   2c:	41 82 00 44 	beq     70 <.set_memory_encrypted+0x70>
   30:	7b e9 04 20 	clrldi  r9,r31,48
   34:	2c 29 00 00 	cmpdi   r9,0
   38:	40 82 00 58 	bne     90 <.set_memory_encrypted+0x90>
   3c:	38 60 00 00 	li      r3,0
   40:	7f c5 f3 78 	mr      r5,r30
   44:	7b e4 85 02 	rldicl  r4,r31,48,20
   48:	60 63 f1 34 	ori     r3,r3,61748
   4c:	48 00 00 01 	bl      4c <.set_memory_encrypted+0x4c>
			4c: R_PPC64_REL24	.ucall_norets
   50:	60 00 00 00 	nop
   54:	38 60 00 00 	li      r3,0
   58:	38 21 00 80 	addi    r1,r1,128
   5c:	e8 01 00 10 	ld      r0,16(r1)
   60:	eb c1 ff f0 	ld      r30,-16(r1)
   64:	eb e1 ff f8 	ld      r31,-8(r1)
   68:	7c 08 03 a6 	mtlr    r0
   6c:	4e 80 00 20 	blr
   70:	38 21 00 80 	addi    r1,r1,128
   74:	38 60 00 00 	li      r3,0
   78:	e8 01 00 10 	ld      r0,16(r1)
   7c:	eb c1 ff f0 	ld      r30,-16(r1)
   80:	eb e1 ff f8 	ld      r31,-8(r1)
   84:	7c 08 03 a6 	mtlr    r0
   88:	4e 80 00 20 	blr
   90:	38 60 ff ea 	li      r3,-22
   94:	4b ff ff c4 	b       58 <.set_memory_encrypted+0x58>

