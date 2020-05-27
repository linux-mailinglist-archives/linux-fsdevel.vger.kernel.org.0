Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072FE1E3B88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 10:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbgE0INp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbgE0INn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 04:13:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE0C061A0F;
        Wed, 27 May 2020 01:13:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so11443345pgn.5;
        Wed, 27 May 2020 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Pvjwk/n6XpSKsFU1yL/UyqSsSwArACV6a9IFuCvWoI=;
        b=g+OBuTNL+ZECp7gRenSfzoC/L0SIFQs2wUNgQ5XneQ49ve7MCXLFqHyaI1J9HP8hFF
         xZFvHdBiADmGYGqBL80SR5GtgLTUbXo9d3UfqDFFj0SLN/B5WFfGMlNyWLAR+tVbvYCz
         C4EDVhl4IEpe78El/g9Nz+dJDWkO/ABrWAn818mbecK+TzsU4h/qWOTh9KLV22jXIyGm
         SrUEFGzeyILWXpcIFBAIOJnIMer+3w8CniZCi5TVTCW1nLLYmDQxBwulWUNK49ca4BOt
         f5OAT0gMgdznpvyOENVsocczF2HFLHy6Oq37nWMHgKTV2N1Nl/lqod7kwe1GiYzM7JwH
         lhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Pvjwk/n6XpSKsFU1yL/UyqSsSwArACV6a9IFuCvWoI=;
        b=CXUBJSGpWgJeJ6a8EpV59EnrPC/772tdAEk75UNmc1vfxW/0ZK0Qwo4Qfu2k1nngOV
         +sx6mTU1n79x2TPPEU5EGsHWbMGhZP7kJ/W9fY7jxs5/c/qN6YrDKnaj3a34IEgUItqU
         LCYVwXIEshq1zvXGjZ6pU7RibTlBpIXjMwag39PNpz8Yk+LlJkLpoSLLCdLIkFepoTzh
         9JdXdDE3a0sT4DQg+cpOz4B/UOUSQ3/Pc8GIBlC4Uv4YP6nJciK4GdOaxzCsQFRJHJFW
         05lH80oY2XWTdjuYYyN78+eikHB5Sbo43it7IS1u1t80n9K3mqAKkMovHCyXplhMIWk0
         hGsg==
X-Gm-Message-State: AOAM5319miEgfaEWyJ0lROWGS39riThwJl/qp+I5r/jpIQY1DsLqQ3rt
        +MTtVba3WfQ8GIyjPAiSfa0=
X-Google-Smtp-Source: ABdhPJzbLRuMmxwJUPY5sv1El/ZdSk39d9IjzJRaDZ9+OJbVht9mTOUgNcWeTP5sLyuANVdm7nAJ8g==
X-Received: by 2002:a63:554e:: with SMTP id f14mr2850561pgm.191.1590567223153;
        Wed, 27 May 2020 01:13:43 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id gz19sm1568851pjb.33.2020.05.27.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:13:42 -0700 (PDT)
Date:   Wed, 27 May 2020 01:13:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] media: omap3isp: Shuffle cacheflush.h and include mm.h
Message-ID: <20200527081337.GA3506499@ubuntu-s3-xlarge-x86>
References: <20200515143646.3857579-7-hch@lst.de>
 <20200527043426.3242439-1-natechancellor@gmail.com>
 <CAMuHMdVSduTOi5bUgF9sLQdGADwyL1+qALWsKgin1TeOLGhAKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVSduTOi5bUgF9sLQdGADwyL1+qALWsKgin1TeOLGhAKQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Geert,

On Wed, May 27, 2020 at 09:02:51AM +0200, Geert Uytterhoeven wrote:
> Hi Nathan,
> 
> CC Laurent
> 
> On Wed, May 27, 2020 at 6:37 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > After mm.h was removed from the asm-generic version of cacheflush.h,
> > s390 allyesconfig shows several warnings of the following nature:
> >
> > In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
> >                  from drivers/media/platform/omap3isp/isp.c:42:
> > ./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
> > declared inside parameter list will not be visible outside of this
> > definition or declaration
> >
> > cacheflush.h does not include mm.h nor does it include any forward
> > declaration of these structures hence the warning. To avoid this,
> > include mm.h explicitly in this file and shuffle cacheflush.h below it.
> >
> > Fixes: 19c0054597a0 ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for your patch!
> 
> > I am aware the fixes tag is kind of irrelevant because that SHA will
> > change in the next linux-next revision and this will probably get folded
> > into the original patch anyways but still.
> >
> > The other solution would be to add forward declarations of these structs
> > to the top of cacheflush.h, I just chose to do what Christoph did in the
> > original patch. I am happy to do that instead if you all feel that is
> > better.
> 
> That actually looks like a better solution to me, as it would address the
> problem for all users.
> 
> >  drivers/media/platform/omap3isp/isp.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> > index a4ee6b86663e..54106a768e54 100644
> > --- a/drivers/media/platform/omap3isp/isp.c
> > +++ b/drivers/media/platform/omap3isp/isp.c
> > @@ -39,8 +39,6 @@
> >   *     Troy Laramy <t-laramy@ti.com>
> >   */
> >
> > -#include <asm/cacheflush.h>
> > -
> >  #include <linux/clk.h>
> >  #include <linux/clkdev.h>
> >  #include <linux/delay.h>
> > @@ -49,6 +47,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mfd/syscon.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/omap-iommu.h>
> >  #include <linux/platform_device.h>
> > @@ -58,6 +57,8 @@
> >  #include <linux/sched.h>
> >  #include <linux/vmalloc.h>
> >
> > +#include <asm/cacheflush.h>
> > +
> >  #ifdef CONFIG_ARM_DMA_USE_IOMMU
> >  #include <asm/dma-iommu.h>
> >  #endif
> 
> Why does this file need <asm/cacheflush.h> at all?
> It doesn't call any of the flush_*() functions, and seems to compile fine
> without (on arm32).
> 
> Perhaps it was included at the top intentionally, to override the definitions
> of copy_{to,from}_user_page()? Fortunately that doesn't seem to be the
> case, from a quick look at the assembler output.
> 
> So let's just remove the #include instead?

Sounds good to me. I can send a patch if needed or I suppose Andrew can
just make a small fixup patch for it. Let me know what I should do.

Cheers,
Nathan
