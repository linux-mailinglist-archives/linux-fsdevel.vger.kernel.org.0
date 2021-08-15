Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1863EC99C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhHOOjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOOjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:39:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F42C061764;
        Sun, 15 Aug 2021 07:38:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26310039d0ba97aac93c10.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:3100:39d0:ba97:aac9:3c10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FF7A1EC0505;
        Sun, 15 Aug 2021 16:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629038311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jL5qXq5tPSUlQog/FJ5eZ1GT2YpJvvVnQmTTUk0cbrA=;
        b=Ynjh7QDJnobQuRzRBtXZMflPEf0vTQxZ/1e/DI2MnZmP0BU3+0pTK5ZZQ5Gk5RnrPuYHa6
        IdpdAyOEUiLJZd8HI6wSzceOtBbAWAY0K9LHdKOg+Qfc/RBmkhxNql4Enc7Gc4LTKOJnaI
        0ETWtaeGc2m89ri2xInjGo/yEh1iYis=
Date:   Sun, 15 Aug 2021 16:39:09 +0200
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YRknDQGUJJ/j9pth@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YRgUxyhoqVJ0Kxvt@zn.tnic>
 <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 15, 2021 at 08:53:31AM -0500, Tom Lendacky wrote:
> It's not a cross-vendor thing as opposed to a KVM or other hypervisor
> thing where the family doesn't have to be reported as AMD or HYGON.

What would be the use case? A HV starts a guest which is supposed to be
encrypted using the AMD's confidential guest technology but the HV tells
the guest that it is not running on an AMD SVM HV but something else?

Is that even an actual use case?

Or am I way off?

I know we have talked about this in the past but this still sounds
insane.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
