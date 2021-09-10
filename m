Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FFF406DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhIJPDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 11:03:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPDf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:03:35 -0400
Received: from zn.tnic (p200300ec2f0f0700e42ce33fe8cf6a79.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:e42c:e33f:e8cf:6a79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93BC61EC0277;
        Fri, 10 Sep 2021 17:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631286138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=40kPdt7aP/VJYkQyMREfQyPgJ8o6qpk6K8Mxu6v6cSc=;
        b=mZ0JcBF56mTU6V0YTC61tZbPl8X0LCaqV1t+QlhEk3mjWHgSHZF5dXkxFXSXhGUION3Odd
        8c/8BBNjWwb218w1V8+ZjDkG7xQbIB2escJ8cg5SbXRf2ClULwId1eDLbmvqpxW7H+B37m
        j71cPf0I4R1mC5Q61ol+StbImh1Vte8=
Date:   Fri, 10 Sep 2021 17:02:10 +0200
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
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/8] mm: Introduce a function to check for
 confidential computing features
Message-ID: <YTtzcoFdi7Ond8Kt@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:58:33PM -0500, Tom Lendacky wrote:
> In prep for other confidential computing technologies, introduce a generic

preparation

> helper function, cc_platform_has(), that can be used to check for specific
> active confidential computing attributes, like memory encryption. This is
> intended to eliminate having to add multiple technology-specific checks to
> the code (e.g. if (sev_active() || tdx_active())).

...

> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> new file mode 100644
> index 000000000000..253f3ea66cd8
> --- /dev/null
> +++ b/include/linux/cc_platform.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _CC_PLATFORM_H

	_LINUX_CC_PLATFORM_H

> +#define _CC_PLATFORM_H

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
