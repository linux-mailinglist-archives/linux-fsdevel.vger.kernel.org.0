Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7358D3EEAD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhHQKWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhHQKWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:22:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6FC061764;
        Tue, 17 Aug 2021 03:22:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1175001ae0093e4550657c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:1ae0:93e:4550:657c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8E41EC054F;
        Tue, 17 Aug 2021 12:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629195715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1X4BsSgXR6fbLSuR6qMW32reDmK7N3Yo2urSU0QF5lM=;
        b=lpCfJRL3J/Wnm269L3OKoCHONoluPmlzJfJpOhctCqjqZucjxjgrEhfFU+dBCsYrUX9hdD
        65itruzBqAaQO/sR4O6+e9rxfZKSO3QhoNUJVkUBsFIiKAtYdX2I4937fDaEHZuSoyKC/2
        aUmz92C0im7LBiW9dGwuZuH6T9Or6uo=
Date:   Tue, 17 Aug 2021 12:22:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 09/12] mm: Remove the now unused mem_encrypt_active()
 function
Message-ID: <YRuN6QhdIQtlluUh@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:28AM -0500, Tom Lendacky wrote:
> The mem_encrypt_active() function has been replaced by prot_guest_has(),
> so remove the implementation.
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  include/linux/mem_encrypt.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 5c4a18a91f89..ae4526389261 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -16,10 +16,6 @@
>  
>  #include <asm/mem_encrypt.h>
>  
> -#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
> -
> -static inline bool mem_encrypt_active(void) { return false; }
> -
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> -- 

This one wants to be part of the previous patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
