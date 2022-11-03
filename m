Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29948618461
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKCQ2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKCQ1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:27:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B581CB28
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 09:27:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so2075284pfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbc9/7qEOtavwLw8LQp9XE09/9bhelNZbWmBfVDGw/4=;
        b=nRKfJ4QQ3+p6c+xIQjyLkoMwJvMnwYkAuaPcWumPlxJnVKcvToJsNiOAGYenmja0Sy
         0RoJkXdIm/TX+G8gnDZ+obkXWdspQdCFRI8jyQ0Jbs1WkCbaBSCKMFWUKWu6G3aYiNf+
         UQS/IMoncWgX6OOaPRMaCTiHd4UobAg5+BLo68MES2g/g2g52drNelqM/o5S6rL276vQ
         59B9YcfdRSBbO8RH0qvr4sgiqXAKyJqC46UCoo6fS3cz6SnqinDkZiU40iLNXr90+JsU
         JTENrIEpqr75AzmQXB9iCQJUqbZTKhHGlXw36gDu1kRfRLSYiBKX6y1lz/w+ys/ieg8s
         2YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qbc9/7qEOtavwLw8LQp9XE09/9bhelNZbWmBfVDGw/4=;
        b=mByyuf5RJjfKlQDAXAw1nMQjOhVvJcQ+3HiK3hYb0koLdzQb5GAEX1YmsQKI3UcBQj
         qnjwhi/agmNtJEqqj2OWKiCph6vPAsOBoT01VPMXSXAbLUQrafZjpcHUgg4f+1tYewV1
         VgejHFPnUkX+W79sF+Nz0VqcgLhhsgAqA/O3V7s3NBO1sA0Xy6wsUgYbKg+2TKy/1Zav
         wtXl9IrG23FaN2l/sOU8QaSw14iCias5hl881jOxumGFOMoioN6vI9PCdbfyx3YSI0Xu
         Y/s3wcgo8eRh+Jnf0hXeD7OTc7jQHZOg89WPdzoIxWXBR9UvvI1Z9dZuZgsunkkv4iLZ
         ll+A==
X-Gm-Message-State: ACrzQf3d9obqh8YVQuMqE2i5xjeEcG59FuYrMD5YBJBtyVdsAWg+PfQx
        Zrbh0DxXpJQ+KMmv84vge5xw00I4pCZxdsxV7Owwhg==
X-Google-Smtp-Source: AMsMyM7LsxnGFqh+M0E5h18/S54Hm40LIPJDB0peNXRc06g8NnvtmJDyMzFqlwvdks3WF/JqPmHtsXk2TpzQtF/OoJ8=
X-Received: by 2002:a63:c4c:0:b0:46f:e243:503a with SMTP id
 12-20020a630c4c000000b0046fe243503amr14314192pgm.483.1667492842447; Thu, 03
 Nov 2022 09:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <CAGtprH_MiCxT2xSxD2UrM4M+ghL0V=XEZzEX4Fo5wQKV4fAL4w@mail.gmail.com>
 <20221021134711.GA3607894@chaop.bj.intel.com> <Y1LGRvVaWwHS+Zna@google.com> <20221024145928.66uehsokp7bpa2st@box.shutemov.name>
In-Reply-To: <20221024145928.66uehsokp7bpa2st@box.shutemov.name>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 3 Nov 2022 21:57:11 +0530
Message-ID: <CAGtprH95A_1Xwaf9uCS6VX6Vi8jTTeewS1WYOwC6bFk5kq9G+g@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 8:30 PM Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:18:14PM +0000, Sean Christopherson wrote:
> > On Fri, Oct 21, 2022, Chao Peng wrote:
> > > >
> > > > In the context of userspace inaccessible memfd, what would be a
> > > > suggested way to enforce NUMA memory policy for physical memory
> > > > allocation? mbind[1] won't work here in absence of virtual address
> > > > range.
> > >
> > > How about set_mempolicy():
> > > https://www.man7.org/linux/man-pages/man2/set_mempolicy.2.html
> >
> > Andy Lutomirski brought this up in an off-list discussion way back when the whole
> > private-fd thing was first being proposed.
> >
> >   : The current Linux NUMA APIs (mbind, move_pages) work on virtual addresses.  If
> >   : we want to support them for TDX private memory, we either need TDX private
> >   : memory to have an HVA or we need file-based equivalents. Arguably we should add
> >   : fmove_pages and fbind syscalls anyway, since the current API is quite awkward
> >   : even for tools like numactl.
>
> Yeah, we definitely have gaps in API wrt NUMA, but I don't think it be
> addressed in the initial submission.
>
> BTW, it is not regression comparing to old KVM slots, if the memory is
> backed by memfd or other file:
>
> MBIND(2)
>        The  specified policy will be ignored for any MAP_SHARED mappings in the
>        specified memory range.  Rather the pages will be allocated according to
>        the  memory  policy  of the thread that caused the page to be allocated.
>        Again, this may not be the thread that called mbind().
>
> It is not clear how to define fbind(2) semantics, considering that multiple
> processes may compete for the same region of page cache.
>
> Should it be per-inode or per-fd? Or maybe per-range in inode/fd?
>

David's analysis on mempolicy with shmem seems to be right. set_policy
on virtual address range does seem to change the shared policy for the
inode irrespective of the mapping type.

Maybe having a way to set numa policy per-range in the inode would be
at par with what we can do today via mbind on virtual address ranges.



> fmove_pages(2) should be relatively straight forward, since it is
> best-effort and does not guarantee that the page will note be moved
> somewhare else just after return from the syscall.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
