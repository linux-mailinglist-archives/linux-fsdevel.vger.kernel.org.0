Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689F3DD5F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhHBMu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 08:50:29 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46189 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhHBMu2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:50:28 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 08:50:27 EDT
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gdd265BJvz9sTV;
        Mon,  2 Aug 2021 14:42:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hMLcQ9rc4PUn; Mon,  2 Aug 2021 14:42:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gdd253Z2xz9sRx;
        Mon,  2 Aug 2021 14:42:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F4668B770;
        Mon,  2 Aug 2021 14:42:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bydFCkI05YiT; Mon,  2 Aug 2021 14:42:37 +0200 (CEST)
Received: from [10.25.200.145] (po15451.idsi0.si.c-s.fr [10.25.200.145])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D4A988B763;
        Mon,  2 Aug 2021 14:42:36 +0200 (CEST)
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
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
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Daniel Vetter <daniel@ffwll.ch>, Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ab2b910b-cd2a-d63b-f080-987d0bb4b5a5@csgroup.eu>
Date:   Mon, 2 Aug 2021 14:42:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 28/07/2021 à 00:26, Tom Lendacky a écrit :
> Replace occurrences of mem_encrypt_active() with calls to prot_guest_has()
> with the PATTR_MEM_ENCRYPT attribute.


What about 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210730114231.23445-1-will@kernel.org/ ?

Christophe


> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/kernel/head64.c                | 4 ++--
>   arch/x86/mm/ioremap.c                   | 4 ++--
>   arch/x86/mm/mem_encrypt.c               | 5 ++---
>   arch/x86/mm/pat/set_memory.c            | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>   drivers/gpu/drm/drm_cache.c             | 4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c     | 6 +++---
>   drivers/iommu/amd/iommu.c               | 3 ++-
>   drivers/iommu/amd/iommu_v2.c            | 3 ++-
>   drivers/iommu/iommu.c                   | 3 ++-
>   fs/proc/vmcore.c                        | 6 +++---
>   kernel/dma/swiotlb.c                    | 4 ++--
>   13 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index de01903c3735..cafed6456d45 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -19,7 +19,7 @@
>   #include <linux/start_kernel.h>
>   #include <linux/io.h>
>   #include <linux/memblock.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   #include <linux/pgtable.h>
>   
>   #include <asm/processor.h>
> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 * there is no need to zero it after changing the memory encryption
>   	 * attribute.
>   	 */
> -	if (mem_encrypt_active()) {
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
>   		vaddr = (unsigned long)__start_bss_decrypted;
>   		vaddr_end = (unsigned long)__end_bss_decrypted;
>   		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 0f2d5ace5986..5e1c1f5cbbe8 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -693,7 +693,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>   bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
>   				 unsigned long flags)
>   {
> -	if (!mem_encrypt_active())
> +	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return true;
>   
>   	if (flags & MEMREMAP_ENC)
> @@ -723,7 +723,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>   {
>   	bool encrypted_prot;
>   
> -	if (!mem_encrypt_active())
> +	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return prot;
>   
>   	encrypted_prot = true;
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 451de8e84fce..0f1533dbe81c 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -364,8 +364,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>   /*
>    * SME and SEV are very similar but they are not the same, so there are
>    * times that the kernel will need to distinguish between SME and SEV. The
> - * sme_active() and sev_active() functions are used for this.  When a
> - * distinction isn't needed, the mem_encrypt_active() function can be used.
> + * sme_active() and sev_active() functions are used for this.
>    *
>    * The trampoline code is a good example for this requirement.  Before
>    * paging is activated, SME will access all memory as decrypted, but SEV
> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>   	 * The unused memory range was mapped decrypted, change the encryption
>   	 * attribute from decrypted to encrypted before freeing it.
>   	 */
> -	if (mem_encrypt_active()) {
> +	if (sme_me_mask) {
>   		r = set_memory_encrypted(vaddr, npages);
>   		if (r) {
>   			pr_warn("failed to free unused decrypted pages\n");
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index ad8a5c586a35..6925f2bb4be1 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -18,6 +18,7 @@
>   #include <linux/libnvdimm.h>
>   #include <linux/vmstat.h>
>   #include <linux/kernel.h>
> +#include <linux/protected_guest.h>
>   
>   #include <asm/e820/api.h>
>   #include <asm/processor.h>
> @@ -1986,7 +1987,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>   	int ret;
>   
>   	/* Nothing to do if memory encryption is not active */
> -	if (!mem_encrypt_active())
> +	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return 0;
>   
>   	/* Should not be working on unaligned addresses */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index abb928894eac..8407224717df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -38,6 +38,7 @@
>   #include <drm/drm_probe_helper.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/suspend.h>
> +#include <linux/protected_guest.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_irq.h"
> @@ -1239,7 +1240,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   	 * however, SME requires an indirect IOMMU mapping because the encryption
>   	 * bit is beyond the DMA mask of the chip.
>   	 */
> -	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT) &&
> +	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>   		dev_info(&pdev->dev,
>   			 "SME is not compatible with RAVEN\n");
>   		return -ENOTSUPP;
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 546599f19a93..4d01d44012fd 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -31,7 +31,7 @@
>   #include <linux/dma-buf-map.h>
>   #include <linux/export.h>
>   #include <linux/highmem.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   #include <xen/xen.h>
>   
>   #include <drm/drm_cache.h>
> @@ -204,7 +204,7 @@ bool drm_need_swiotlb(int dma_bits)
>   	 * Enforce dma_alloc_coherent when memory encryption is active as well
>   	 * for the same reasons as for Xen paravirtual hosts.
>   	 */
> -	if (mem_encrypt_active())
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return true;
>   
>   	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index dde8b35bb950..06ec95a650ba 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -29,7 +29,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   
>   #include <drm/ttm/ttm_range_manager.h>
>   #include <drm/drm_aperture.h>
> @@ -634,7 +634,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
>   		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
>   
>   	/* TTM currently doesn't fully support SEV encryption. */
> -	if (mem_encrypt_active())
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return -EINVAL;
>   
>   	if (vmw_force_coherent)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> index 3d08f5700bdb..0c70573d3dce 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -28,7 +28,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   
>   #include <asm/hypervisor.h>
>   
> @@ -153,7 +153,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
>   	unsigned long msg_len = strlen(msg);
>   
>   	/* HB port can't access encrypted memory. */
> -	if (hb && !mem_encrypt_active()) {
> +	if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
>   		unsigned long bp = channel->cookie_high;
>   
>   		si = (uintptr_t) msg;
> @@ -208,7 +208,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
>   	unsigned long si, di, eax, ebx, ecx, edx;
>   
>   	/* HB port can't access encrypted memory */
> -	if (hb && !mem_encrypt_active()) {
> +	if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
>   		unsigned long bp = channel->cookie_low;
>   
>   		si = channel->cookie_high;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 811a49a95d04..def63a8deab4 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -31,6 +31,7 @@
>   #include <linux/irqdomain.h>
>   #include <linux/percpu.h>
>   #include <linux/io-pgtable.h>
> +#include <linux/protected_guest.h>
>   #include <asm/irq_remapping.h>
>   #include <asm/io_apic.h>
>   #include <asm/apic.h>
> @@ -2178,7 +2179,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   	 * active, because some of those devices (AMD GPUs) don't have the
>   	 * encryption bit in their DMA-mask and require remapping.
>   	 */
> -	if (!mem_encrypt_active() && dev_data->iommu_v2)
> +	if (!prot_guest_has(PATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
>   		return IOMMU_DOMAIN_IDENTITY;
>   
>   	return 0;
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index f8d4ad421e07..ac359bc98523 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -16,6 +16,7 @@
>   #include <linux/wait.h>
>   #include <linux/pci.h>
>   #include <linux/gfp.h>
> +#include <linux/protected_guest.h>
>   
>   #include "amd_iommu.h"
>   
> @@ -741,7 +742,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>   	 * When memory encryption is active the device is likely not in a
>   	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
>   	 */
> -	if (mem_encrypt_active())
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT))
>   		return -ENODEV;
>   
>   	if (!amd_iommu_v2_supported())
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..ddbedb1b5b6b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -23,6 +23,7 @@
>   #include <linux/property.h>
>   #include <linux/fsl/mc.h>
>   #include <linux/module.h>
> +#include <linux/protected_guest.h>
>   #include <trace/events/iommu.h>
>   
>   static struct kset *iommu_group_kset;
> @@ -127,7 +128,7 @@ static int __init iommu_subsys_init(void)
>   		else
>   			iommu_set_default_translated(false);
>   
> -		if (iommu_default_passthrough() && mem_encrypt_active()) {
> +		if (iommu_default_passthrough() && prot_guest_has(PATTR_MEM_ENCRYPT)) {
>   			pr_info("Memory encryption detected - Disabling default IOMMU Passthrough\n");
>   			iommu_set_default_translated(false);
>   		}
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 9a15334da208..b466f543dc00 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -26,7 +26,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/pagemap.h>
>   #include <linux/uaccess.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   #include <asm/io.h>
>   #include "internal.h"
>   
> @@ -177,7 +177,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>    */
>   ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>   {
> -	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
> +	return read_from_oldmem(buf, count, ppos, 0, prot_guest_has(PATTR_MEM_ENCRYPT));
>   }
>   
>   /*
> @@ -378,7 +378,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
>   					    buflen);
>   			start = m->paddr + *fpos - m->offset;
>   			tmp = read_from_oldmem(buffer, tsz, &start,
> -					       userbuf, mem_encrypt_active());
> +					       userbuf, prot_guest_has(PATTR_MEM_ENCRYPT));
>   			if (tmp < 0)
>   				return tmp;
>   			buflen -= tsz;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e50df8d8f87e..2e8dee23a624 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -34,7 +34,7 @@
>   #include <linux/highmem.h>
>   #include <linux/gfp.h>
>   #include <linux/scatterlist.h>
> -#include <linux/mem_encrypt.h>
> +#include <linux/protected_guest.h>
>   #include <linux/set_memory.h>
>   #ifdef CONFIG_DEBUG_FS
>   #include <linux/debugfs.h>
> @@ -515,7 +515,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	if (!mem)
>   		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
>   
> -	if (mem_encrypt_active())
> +	if (prot_guest_has(PATTR_MEM_ENCRYPT))
>   		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
>   
>   	if (mapping_size > alloc_size) {
> 
