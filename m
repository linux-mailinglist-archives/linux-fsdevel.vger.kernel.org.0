Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3386C32C503
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376870AbhCDAS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355948AbhCCHKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:10:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20AC0611C3;
        Tue,  2 Mar 2021 23:07:48 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p16so24617900ioj.4;
        Tue, 02 Mar 2021 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNYushJ4IWTnKiNlA6uxw3aB11xV6vt4WNl5w++LRI4=;
        b=Q+lwFQ+OjwpL3KnX4xtFxAK/n4+dweLyKWz2FBz0HqUOgZVbsR91nUlRJ72tFtufb9
         RznLBNgJgW41kDBMIRJBRNnpa8omF1SxIk38PUz1Gep7XIdMDRtaHwWPVaw8sApHQsFY
         YHG7+d8vxSlsZVgSgHqtYCFhkF1AiDMB/N2egeVRaM64wqxWwesSQH4veygbYiahNptu
         qBLrombWEFFfZGlgswxsBDM15fpNjnhghwwnYZu1s4WcmSacrV1LZO85A/TLAKOybu/Y
         bW2FPXrGuaTCF7kJl75QP1isFZzepoWnUaHGZMzd/W5TWlIBQZgss/sNQJSgk7fbNkn9
         W/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNYushJ4IWTnKiNlA6uxw3aB11xV6vt4WNl5w++LRI4=;
        b=G8tslZ2WooTlC7zPiki6EeoBU8lOQzqgCt8d4Lj0uQ4G0b9eneF5v1NF6YlEzBTyBv
         lx7r3ECutZ4IEGk6BUtn28t3yEr0rM2dOFA7kYE2+D/LxWUFOIkr5doTD2ISnd9pEcgR
         VFHKp6XGC7gpSTp76Nz3+70qp9y0iBS5X6E1CR6Ji45fycemZDSRKhsgzvRtFP8lkOql
         IZSDHUTPnAeifu1iiPJJxBwbHfuTKBVxjds5YkSlm+iSNk97SYsov14GLgU8W/TbgT6w
         9hmMP8JN6kWCYfFRblY42uEuraqNSJpksRTqCRS7U8bi5uw67E4HuLGYF+kyQaCc5ygf
         tjhA==
X-Gm-Message-State: AOAM532cGeKBwaPMe+qb9g/gU2brdr5gY44VEXnQn+GpFKRmobj7z2kk
        5iODEhUPR/Lf0czmnEJZRQHhhkkoyLiGLQ+LmicziCy9y28Kuw==
X-Google-Smtp-Source: ABdhPJxkA/AyfdY7zt1Pa3cTNDqZOv8L1w+P+dlt9kl/jHHAhJR+2zH87pUlOvmMZRyuqpnqzaJO50ICAWbfEyZbbyk=
X-Received: by 2002:a02:cf0f:: with SMTP id q15mr24850790jar.23.1614755267598;
 Tue, 02 Mar 2021 23:07:47 -0800 (PST)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <CAHk-=wjVWMnH2LfFNnXcf6=WuU1RyLa_cgTEOqnViHiqDrqQjg@mail.gmail.com>
In-Reply-To: <CAHk-=wjVWMnH2LfFNnXcf6=WuU1RyLa_cgTEOqnViHiqDrqQjg@mail.gmail.com>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Tue, 2 Mar 2021 23:07:36 -0800
Message-ID: <CALCv0x1-zWOXNDntm8+C6BwHdM5Ykda2jxuwoChnrTX2TuOOPg@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 10:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 1, 2021 at 11:59 PM Ilya Lipnitskiy
> <ilya.lipnitskiy@gmail.com> wrote:
> >
> > Good to know. Some more digging and I can say that we hit this error
> > when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> > vm_normal_page returns NULL, zap_pte_range does not decrement
> > MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
> > usable, but special? Or am I totally off the mark here?
>
> PFN 0 should be usable - depending on architecture, of course - and
> shouldn't even be special in any way.
>
> is_zero_pfn(pfn) is *not* meant to test for pfn being 0 - it's meant
> to test for the pfn pointing to the special zero-filled page. The two
> _could_ be the same thing, of course, but generally are not (h8300
> seems to say "we use pfn 0 as the zero page" if I read things right).
>
> In fact, there can be many zero-filled pages - architectures with
> virtually mapped caches that want cache coloring have multiple
> contiguous zero-filled pages and then map in the right one based on
> virtual address. I'm not sure why it would matter (the zero-page is
> always mapped read-only, so any physical aliases should be a
> non-issue), but whatever..
>
> > Here is the (optimized) stack trace when the counter does not get decremented:
> > [<8015b078>] vm_normal_page+0x114/0x1a8
>
> Yes, if "is_zero_pfn()" returns true, then it won't be considered a
> normal page, and is not refcounted.
>
> But that should only trigger for pfn == zero_pfn, and zero_pfn should
> be initialized to
>
>     zero_pfn = page_to_pfn(ZERO_PAGE(0));
>
> so it _sounds_ like you possibly have something odd going on with ZERO_PAGE.
Thanks for explaining this - I have figured out that zero_pfn gets set
a little late (see other response for details). Until init_zero_pfn()
is called, zero_pfn==0, after - zero_pfn==5120. Seems somewhat bad,
unless my system is breaking rules by checking zero_pfn before it was
initialized ;)
>
> Yes, one architecture does actually make pfn 0 _be_ the zero page, but
> you said MIPS, and that does do the page coloring games, and has
>
>    #define ZERO_PAGE(vaddr) \
>         (virt_to_page((void *)(empty_zero_page + (((unsigned
> long)(vaddr)) & zero_page_mask))))
>
> where zero_page_mask is the page colorign mask, and empty_zero_page is
> allocated in setup_zero_pages() fairly early in mem_init() (again, it
> allocates multiple pages depending on the page ordering - see that
> horrible virtual cache thing with cpu_has_vce).
>
> So PFN 0 shouldn't be an issue at all.
>
> Of course, since you said this was an embedded MIPS platform, maybe
> it's one of the broken ones with virtual caches and cpu_has_vce is
> set. I'm not sure how much testing that has gotten lately. MOST of the
> later MIPS architectures walked away from the pure virtual cache
> setups.
FWIW, here is the CPU info from my platform, and cpu_has_vce is not set:

system type             : MediaTek MT7621 ver:1 eco:3
machine                 : Ubiquiti EdgeRouter X
processor               : 0
cpu model               : MIPS 1004Kc V2.15
BogoMIPS                : 581.63
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0ffc,
0x0ffc, 0x0ffb, 0x0ffb]
isa                     : mips1 mips2 mips32r1 mips32r2
ASEs implemented        : mips16 dsp mt
Options implemented     : tlb 4kex 4k_cache prefetch mcheck ejtag llsc
pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets    : 1
kscratch registers      : 0
package                 : 0
core                    : 0
VPE                     : 0
VCED exceptions         : not available
VCEI exceptions         : not available

>
>               Linus
Ilya
