Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1A2C9F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 11:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgLAK34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 05:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgLAK3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:29:55 -0500
Received: from kernel.org (unknown [87.71.85.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194602080A;
        Tue,  1 Dec 2020 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606818554;
        bh=Ws6dR/OG3AOU58f5wZaP5SOr5YFu6occCl/egAoMHKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUadOkONZm3yl4vUgx4ptuiDtfj+cJiQNuA5oHKmXZxvGWy0g8QkVsFClkrV67HlY
         vRhIZcBu2BlL3N3eBSHPLP47jfJ1d1NpKcGqF/7pM3biCdU1ahEBnZj+ZAulT6sx2x
         QaOaVP9R5iZI2YknaXdnDtAwtqchPwXSObLcS3RA=
Date:   Tue, 1 Dec 2020 12:29:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201201102901.GF557259@kernel.org>
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Adrian,

On Tue, Dec 01, 2020 at 10:10:56AM +0100, John Paul Adrian Glaubitz wrote:
> Hi Mike!
> 
> On 11/17/20 7:23 AM, Mike Rapoport wrote:
> >> Apologies for the late reply. Is this still relevant for testing?
> >>
> >> I have already successfully tested v1 of the patch set, shall I test v2?
> > 
> > There were minor differences only for m68k between the versions. I've
> > verified them on ARAnyM but if you have a real machine a run there would
> > be nice.
> 
> I have just built a fresh kernel from the tip of Linus' tree and it boots
> fine on my RX-2600:
> 
> root@glendronach:~# uname -a
> Linux glendronach 5.10.0-rc6 #6 SMP Tue Dec 1 04:52:49 CET 2020 ia64 GNU/Linux
> root@glendronach:~#
> 
> No issues observed so far. Looking at the git log, it seems these changes haven't
> been merged for 5.10 yet. I assume they will be coming with 5.11?

These changes are in linux-mm tree (https://www.ozlabs.org/~akpm/mmotm/
with a mirror at https://github.com/hnaz/linux-mm)

I beleive they will be coming in 5.11.

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
> 

-- 
Sincerely yours,
Mike.
