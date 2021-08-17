Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532293EEAE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhHQKYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhHQKYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:24:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62276C061764;
        Tue, 17 Aug 2021 03:23:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1175001ae0093e4550657c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:1ae0:93e:4550:657c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E877F1EC054F;
        Tue, 17 Aug 2021 12:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629195817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Csx6qMQ9tYxKXODnTqqy9INSyiSA4fz5PX+qeCGcp5A=;
        b=YgCBygy59k77z7qZ7LHn5qOpfV9ZlexZ1tHoBM0ivnx8WK+2yZqUDXV0bYg0Ohi2078H4O
        bI8rlObYY+j7XTyrWjgNUAogvhZhdmbZxaA6xcDGifp7QJ4sCtvbaAn+xxjJgKDYYXFnPy
        YU+zZ7nzxnjerZbCDMSW1zWt3xLorVs=
Date:   Tue, 17 Aug 2021 12:24:20 +0200
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
Message-ID: <YRuOVOdxOZm0S86j@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
 <YRuN6QhdIQtlluUh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRuN6QhdIQtlluUh@zn.tnic>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:22:33PM +0200, Borislav Petkov wrote:
> This one wants to be part of the previous patch.

... and the three following patches too - the treewide patch does a
single atomic :) replacement and that's it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
