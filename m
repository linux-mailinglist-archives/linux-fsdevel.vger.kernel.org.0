Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A283943F28D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJ1WSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhJ1WSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:18:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06BC061570;
        Thu, 28 Oct 2021 15:16:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n67so10111875iod.9;
        Thu, 28 Oct 2021 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg70L5/px9IrBTtKlC6NDcYo4kfwnEG9jTpOWhVqPcc=;
        b=eLMlkR3CrL/8PKVzyYVcuncnEdxnsfxn3riWgN8oKOQlGwnX+UChUbaymKEw6taCnn
         T8Axfv4krveNN1JwPJ8iFTOlfd102NDBwnWrreHYu4O3lJvrvpNe2/UNEdxrzQ9SIEC2
         QLoTJw49KEGspkcIbfmZwhQPQnQHmI3RwBeznARr6NdRUey/+TThUWIxW9Sln8YZy4R8
         11VLzJvcLrKyWixt2PgLtCOpiAI3GIufYgiUdKrBvJwerHJEVjKfl6H+d48ohmeM6LH4
         qI+q4pHyEmmlq/Z2OQHtWTRygZ3gz8XwduyZ/uS8/ZOuJq5JPvoIFBAGbgx8he4F1Sb8
         u0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg70L5/px9IrBTtKlC6NDcYo4kfwnEG9jTpOWhVqPcc=;
        b=L/DRI1oulBjkW6Rq0CXcppn/FcluXqjQE4oIn+JLyA9t33m+qKb4OViuIQ33dYX60R
         001EoHXE37qWdx8gTzPi/MvP+0UN/jAjz+UphTB6PZu3DbBt97J7/d40RZsSwzJgNY9Y
         GlpuQqpzwLP1og4EplBOkxjh+GGeA8a4mHRYSjO25pI0T8fnxwcquDvChSlXldFec5Pj
         aXNAtzx5fmVOUO2Xdgh5oHpuTy2tlACb16SX/iqb7ULhgL5EJF1XngfyP0dIWs6/kPWa
         PMH60Ova2gDyBmJBWgGGUgLIqd0lij4W3MPqKDzSOmjHjD3ktpaD9GfSy10g9NwErib2
         0PWQ==
X-Gm-Message-State: AOAM530S+Uu4ldN9l126Q2om5ocMNGKP6+14NOqQf4mbs13MQ1WCrDvO
        fYNvgKUlK8dRx3MS1sKF12BqYVFquYkUq8daKII=
X-Google-Smtp-Source: ABdhPJwQxQk+UInDEwQGMzT3vtIBaThPNMfpgrXChu4UuLq9KZI3dYCJq/rt6DgOPhDRcNVWlcfUbesD2a/U+JO29i0=
X-Received: by 2002:a05:6602:736:: with SMTP id g22mr5165002iox.139.1635459366944;
 Thu, 28 Oct 2021 15:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com> <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com> <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
 <YXsUNMWFpmT1eQcX@arm.com>
In-Reply-To: <YXsUNMWFpmT1eQcX@arm.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 29 Oct 2021 00:15:55 +0200
Message-ID: <CAHpGcMLeiXSjCJGY6SCJJ=bdNOspHLHofmTE8aC_sZtfHRG5ZA@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Do., 28. Okt. 2021 um 23:21 Uhr schrieb Catalin Marinas
<catalin.marinas@arm.com>:
> One last try on this path before I switch to the other options.
>
> On Wed, Oct 27, 2021 at 02:14:48PM -0700, Linus Torvalds wrote:
> > On Wed, Oct 27, 2021 at 12:13 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > As an alternative, you mentioned earlier that a per-thread fault status
> > > was not feasible on x86 due to races. Was this only for the hw poison
> > > case? I think the uaccess is slightly different.
> >
> > It's not x86-specific, it's very generic.
> >
> > If we set some flag in the per-thread status, we'll need to be careful
> > about not overwriting it if we then have a subsequent NMI that _also_
> > takes a (completely unrelated) page fault - before we then read the
> > per-thread flag.
> >
> > Think 'perf' and fetching backtraces etc.
> >
> > Note that the NMI page fault can easily also be a pointer coloring
> > fault on arm64, for exactly the same reason that whatever original
> > copy_from_user() code was. So this is not a "oh, pointer coloring
> > faults are different". They have the same re-entrancy issue.
> >
> > And both the "pagefault_disable" and "fault happens in interrupt
> > context" cases are also the exact same 'faulthandler_disabled()'
> > thing. So even at fault time they look very similar.
>
> They do look fairly similar but we should have the information in the
> fault handler to distinguish: not a page fault (pte permission or p*d
> translation), in_task(), user address, fixup handler. But I agree the
> logic looks fragile.
>
> I think for nested contexts we can save the uaccess fault state on
> exception entry, restore it on return. Or (needs some thinking on
> atomicity) save it in a local variable. The high-level API would look
> something like:
>
>         unsigned long uaccess_flags;    /* we could use TIF_ flags */
>
>         uaccess_flags = begin_retriable_uaccess();
>         copied = copy_page_from_iter_atomic(...);
>         retry = end_retriable_uaccess(uaccess_flags);
>         ...
>
>         if (!retry)
>                 break;
>
> I think we'd need a TIF flag to mark the retriable region and another to
> track whether a non-recoverable fault occurred. It needs prototyping.
>
> Anyway, if you don't like this approach, I'll look at error codes being
> returned but rather than changing all copy_from_user() etc., introduce a
> new API that returns different error codes depending on the fault
> (e.g -EFAULT vs -EACCES). We already have copy_from_user_nofault(), we'd
> need something for the iov_iter stuff to use in the fs code.

We won't need any of that on the filesystem read and write paths. The
two cases there are buffered and direct I/O:

* In the buffered I/O case, the copying happens with page faults
disabled, at a byte granularity. If that returns a short result, we
need to enable page faults, check if the exact address that failed
still fails (in which case we have a sub-page fault),  fault in the
pages, disable page faults again, and repeat. No probing for sub-page
faults beyond the first byte of the fault-in address is needed.
Functions fault_in_{readable,writeable} implicitly have this behavior;
for fault_in_safe_writeable() the choice we have is to either add
probing of the first byte for sub-page faults to this function or
force callers to do that probing separately. At this point, I'd vote
for the former.

* In the direct I/O case, the copying happens while we're holding page
references, so the only page faults that can occur during copying are
sub-page faults. When iomap_dio_rw or its legacy counterpart is called
with page faults disabled, we need to make sure that the caller can
distinguish between page faults triggered during
bio_iov_iter_get_pages() and during the copying, but that's a separate
problem. (At the moment, when iomap_dio_rw fails with -EFAULT, the
caller *cannot* distinguish between a bio_iov_iter_get_pages failure
and a failure during synchronous copying, but that could be fixed by
returning unique error codes from iomap_dio_rw.)

So as far as I can see, the only problematic case we're left with is
copying bigger than byte-size chunks with page faults disabled when we
don't know whether the underlying pages are resident or not. My guess
would be that in this case, if the copying fails, it would be
perfectly acceptable to explicitly probe the entire chunk for sub-page
faults.

Thanks,
Andreas
