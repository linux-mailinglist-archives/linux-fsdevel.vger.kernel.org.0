Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6930CFAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 00:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhBBXIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 18:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhBBXIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:08:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A78C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 15:07:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u17so23290545iow.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RjDL0WnIqmbAwIPgih8NIYCRBA1hoXGPmIcl2Uor2U=;
        b=AuP+ac8MX1RXW6/ifC8coTGHU3fL8jBHv6wyEbBQU82hvYBd6rit1rVBuByKBewk6o
         aitY6VN9x52QeiYxDvYduMCgBFy0sVnvHldPS8Kx/p3r2hpZu57PJXeSsBeIyrdtCKAi
         NX6tsa5fKw2/S5yNfEYlCEJp8r6bZqmtgybezkjKSCECCeCL2M57YNPijm4SyRSdtYhc
         GgEE2dulh2oay46x2vBcTeckCL9Qs1M4g9rpYye3Hd6ubyStkTMehMnvRb//Is7Qx1z1
         FSmnnm0YbPnxrkluWvRAA+Zzlovoga/x2e2e/d0zwMkPcrwM4MpRb+EDgbI6z5qT22uH
         8xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RjDL0WnIqmbAwIPgih8NIYCRBA1hoXGPmIcl2Uor2U=;
        b=cqM+ndok8id0DD6SHc0QOcLzAPIBVc0BIzuRyBhLVSyf4uJrLWhGkeqMoou9fRbiWC
         d/wNcY7FhxJIpzrON3VhyLK0DKdKmedkP6dEBjGjbQv8jzKIKocK273wacoU5a9h/zYt
         3MtpzHakLLf216iFpC2FiwgBEFbOomTDUJNzvu3eF+LslRei/m+cN8LwVzqn5hdbygxR
         njJVRQJSMgY5myuEzd7bGfacEudwGK+/zdpT5N+2wX9ZrGO5zIvKDr2T6uE6IIQj9/WG
         E8tcL/3ZgNwx1dFqXOtPwA2q/h/FQaxH4MR+fE0WsXIWkb5loqsRqjf63ILRQt35ZUa2
         2hZQ==
X-Gm-Message-State: AOAM530SvxLPH7gy24EPHKujLEoRks+YfdKqZq4NCczQmNg1DCC60Nh0
        RXgO1pfdD5I0h2O/CYLei1kC/N8KZPdMVkP7bh79bw==
X-Google-Smtp-Source: ABdhPJztP8LUhXfkazYWFZECOAUKSzySbZT98LdOhvVXwQEBFs1RSta8vgRMJnvF71MgjNkzFAYRV7eTijoN89AuLRw=
X-Received: by 2002:a05:6638:42:: with SMTP id a2mr439972jap.99.1612307270724;
 Tue, 02 Feb 2021 15:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-9-axelrasmussen@google.com> <20210201200654.GI260413@xz-x1>
In-Reply-To: <20210201200654.GI260413@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 2 Feb 2021 15:07:14 -0800
Message-ID: <CAJHvVci5r5L-ga4QS2WoZ2AqG3HJhBeg3TH6F6nAtu-PmK6+1g@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] userfaultfd: update documentation to describe
 minor fault handling
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:07 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 28, 2021 at 02:48:18PM -0800, Axel Rasmussen wrote:
> > Reword / reorganize things a little bit into "lists", so new features /
> > modes / ioctls can sort of just be appended.
> >
> > Describe how UFFDIO_REGISTER_MODE_MINOR and UFFDIO_CONTINUE can be used
> > to intercept and resolve minor faults. Make it clear that COPY and
> > ZEROPAGE are used for MISSING faults, whereas CONTINUE is used for MINOR
> > faults.
>
> Bare with me since I'm not native speaker.. but I'm pointing out things that
> reads odd to me.  Feel free to argue. :)

No worries, that is true for many people in the community. I'm happy
to reword to make things as clear as possible. :)

>
> [...]
>
> > +Resolving Userfaults
> > +--------------------
> > +
> > +There are three basic ways to resolve userfaults:
> > +
> > +- ``UFFDIO_COPY`` atomically copies some existing page contents from
> > +  userspace.
> > +
> > +- ``UFFDIO_ZEROPAGE`` atomically zeros the new page.
> > +
> > +- ``UFFDIO_CONTINUE`` maps an existing, previously-populated page.
> > +
> > +These operations are atomic in the sense that they guarantee nothing can
> > +see a half-populated page, since readers will keep userfaulting until the
> > +operation has finished.
> > +
> > +By default, these wake up userfaults blocked on the range in question.
> > +They support a ``UFFDIO_*_MODE_DONTWAKE`` ``mode`` flag, which indicates
> > +that waking will be done separately at some later time.
> > +
> > +Which of these are used depends on the kind of fault:
>
> Maybe:
>
> "We should choose the ioctl depending on the kind of the page fault, and what
>  we'd like to do with it:"
>
> ?
>
> > +
> > +- For ``UFFDIO_REGISTER_MODE_MISSING`` faults, a new page has to be
> > +  provided. This can be done with either ``UFFDIO_COPY`` or
>
> UFFDIO_ZEROPAGE does not need a new page.
>
> > +  ``UFFDIO_ZEROPAGE``. The default (non-userfaultfd) behavior would be to
> > +  provide a zero page, but in userfaultfd this is left up to userspace.
>
> "By default, kernel will provide a zero page for a missing fault.  With
>  userfaultfd, the userspace could decide which content to provide before the
>  faulted thread continues." ?
>
> > +
> > +- For ``UFFDIO_REGISTER_MODE_MINOR`` faults, an existing page already
>
> "page cache existed"?
>
> > +  exists. Userspace needs to ensure its contents are correct (if it needs
> > +  to be modified, by writing directly to the non-userfaultfd-registered
> > +  side of shared memory), and then issue ``UFFDIO_CONTINUE`` to resolve
> > +  the fault.
>
> "... Userspace can modify the page content before asking the faulted thread to
>  continue the fault with UFFDIO_CONTINUE ioctl." ?

I agree with all the comments; these areas can be clarified. I didn't
take the suggestions exactly as-is, but I did reword these parts in my
v4. Let me know if further changes would be useful.

>
> --
> Peter Xu
>
