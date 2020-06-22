Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6575D2042FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbgFVVuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgFVVuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:50:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81602C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d12so2181378ply.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HO9AnfyoV6P1ml9RmfpxKfaeSgxzWVOaT2Vq3vNBOcc=;
        b=lnWs0M9bdocVBBBLhw+yUPaupQsgnQNFCJK+pJiVmZ07vNw8nK3vhTqTM7fjRtPrmQ
         BeXp8Y3BLVYRrEviTgHIDqlkTfPgwxk6+SKhwBh0lYzJXifq+81hLQjHZHXlwvYE7D3Z
         338rLHdodna0JLZ+58OXLxtuOD7htkoppjQHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HO9AnfyoV6P1ml9RmfpxKfaeSgxzWVOaT2Vq3vNBOcc=;
        b=Lu5yq1ARKKLfjXkESGAYcD+wjDNwVswJKy04pVIYH1FPh6p7hkaVeZOQL+mxjSfu/t
         UaErcADEkk2u1Is6eiHLOpiYcVfT7Nsa9eHLaHT6e1guAEDAqD20EkvvT3ATW68wU1yo
         y/VYkGCGaKZaNcQff0lHPY5BuZ0tRrWj8jeu9CKMJWj2ODvfLfw4US6jylN3zVt9FcSY
         9WMXl9anjs7WkClKOBbr01+3m7IU7Z0wNPAhsuCbIs4Dave252cSGjyqeanfWpJ7lszR
         F7+EMU9gNh7r7mnxs5pUISuptZfBazeviA20Gf3F2SFBSdU6DTPLnGDvWu0tGZ0SMJG8
         DVTQ==
X-Gm-Message-State: AOAM533mg+8ezyIBQGcsALRu4Rkmzkj++yZ1t2WdD8HeuO5gVM/ebD5l
        rYXfKuaJQvGjO/PDFH+Ki7KS0w==
X-Google-Smtp-Source: ABdhPJxa5Z82Hov2tfdjL/FmMAkdOj7Sb3arynM+T3CBUgUa49ZBQBQv4Q5BIBd9XVoezZqa3CUsJQ==
X-Received: by 2002:a17:90a:a405:: with SMTP id y5mr20189871pjp.15.1592862611014;
        Mon, 22 Jun 2020 14:50:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14sm428618pjf.32.2020.06.22.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:50:09 -0700 (PDT)
Date:   Mon, 22 Jun 2020 14:50:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rd.dunlab@gmail.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: mmotm 2020-06-20-21-36 uploaded (lkdtm/bugs.c)
Message-ID: <202006221445.36E03CCBE9@keescook>
References: <20200621043737.pb6JV%akpm@linux-foundation.org>
 <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:37:17AM -0700, Randy Dunlap wrote:
> On 6/20/20 9:37 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> drivers/misc/lkdtm/bugs.c has build errors when building UML for i386
> (allmodconfig or allyesconfig):
> 
> 
> In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
> ../arch/x86/um/asm/desc.h:7:0: warning: "LDT_empty" redefined
>  #define LDT_empty(info) (\
>  
> In file included from ../arch/um/include/asm/mmu.h:10:0,
>                  from ../include/linux/mm_types.h:18,
>                  from ../include/linux/sched/signal.h:13,
>                  from ../drivers/misc/lkdtm/bugs.c:11:
> ../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
>  #define LDT_empty(info) (_LDT_empty(info))

The LKDTM test landed a while ago:
b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")

and nothing has touched arch/x86/um/asm/desc.h nor
arch/x86/um/asm/mm_context.h in a while either.

Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?

-- 
Kees Cook
