Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4CC413912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhIURs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhIURs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:48:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C035C061574;
        Tue, 21 Sep 2021 10:47:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0600329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 746911EC0345;
        Tue, 21 Sep 2021 19:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632246441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Pv/DqLbn5krQkfgrrH2g5wknVz1I55labSKboEsUGSc=;
        b=ICGDEBkQOXOtvX4oj9gLk4HRR4i+JmA+w21a5R5Xi1PZp209y1bcslBK22jtpCHUOsc4bU
        LSOP3yCawLAOD9sDuEbS363bK+pYy6ALcZgCukrJ/yEpf5U57oeFLjS9+b2ZXJHSmQP3/J
        ZoRIqL1GWc7QneVzHnFpO5G9Rs488yE=
Date:   Tue, 21 Sep 2021 19:47:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <YUoao0LlqQ6+uBrq@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:04:58PM -0500, Tom Lendacky wrote:
> Looks like instrumentation during early boot. I worked with Boris offline to
> exclude arch/x86/kernel/cc_platform.c from some of the instrumentation and
> that allowed an allyesconfig to boot.

And here's the lineup I have so far, I'd appreciate it if ppc and s390 folks
could run it too:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc2-cc

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
