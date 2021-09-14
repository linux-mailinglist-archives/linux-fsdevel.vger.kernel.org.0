Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5041540B248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhINO5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhINO5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:57:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627DC061574;
        Tue, 14 Sep 2021 07:56:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1048001ab509412f10df56.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:1ab5:941:2f10:df56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AA951EC04D1;
        Tue, 14 Sep 2021 16:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631631379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fC6oRVekYYeOWo6Ou3mRPO8RAeBaCtshKbuZA0gycas=;
        b=DjTjeMWi1aTZkXxq8Lf9KyX6WC0t0Xl9olO8XFqhK7E+qGjzzzpMJxBPFDqtXa7lxuvLMF
        BJZxFO3MGqQdmfuJdFwoNpN1Q2f2YF1GOFt4ptUcVjuOWJnOJOQqL4VXuXLUK8z4I3mRHF
        ddNSSmZuSk4r3r8c6iL+tcOt78DT0h0=
Date:   Tue, 14 Sep 2021 16:56:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-graphics-maintainer@vmware.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YUC4CW02tqEttZZJ@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
 <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:47:41PM +0200, Christophe Leroy wrote:
> Yes, see https://lore.kernel.org/linuxppc-dev/20210914123919.58203eef@canb.auug.org.au/T/#t

Aha, more compiler magic stuff ;-\

Oh well, I guess that fix will land upstream soon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
