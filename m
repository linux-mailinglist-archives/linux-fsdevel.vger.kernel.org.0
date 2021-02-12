Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340D31A824
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBLWzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLWwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:52:36 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9542AC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 14:51:55 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o15so665037ilt.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 14:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzDlzPzKU3YheI9b/NibUr3Erv08+T00iefc2m4bYp0=;
        b=Wr+212K+q+ykejSfO/y9AhAJc3j57hC3tdALgV+si3kpw3k2H7yiMirkDqF8javOti
         riEmedN1Oy/IM2jPVlR/EuOuGaY94jZoBwUo3d4hWk3TEId5RBE6LY0gXh4FOCDVsjTh
         hUz8UgFAirqegSXWX8/zBc3FI9fUhMAttLB7uHN/s2+bSN5iQUtaEFHMh79qCQ/SWdvX
         VIN01kyYrEOVrxxgnLx1siMvwRkUwvvZBgjNqsOqQG5BY/n7HqPpm8o8Q15a5/MXwPBH
         RQ+c9I1kHWYlRwskUJwHY1604M1pux9k0qZm0DkoTfanMnFLr49VaQDd4f2xAmMdSigq
         fVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzDlzPzKU3YheI9b/NibUr3Erv08+T00iefc2m4bYp0=;
        b=EH6xY0OW1NoaTsy1mQOwi/XrdvsJREQzL2li6AIbLs5dnayhQhvE7lmrEZvNV5hTf3
         5vWf0uPAOpglOBZ3t6/TPvt5APh7Fzaqi8seMT2I3BN4Kem4oiWGPhJmR9cYHySMn6qJ
         AfXQv6FPuboh2UMAkOVK+F/iPyYj3fpTW5K/U0VmdnJ7BS1gaxNp8298NmA2j7v0tv7T
         xc2cNrvmE34Dmjp6QpDlgSt+nHCuxa/Ohjgpm665Tdb8D2NBudfXgT0WjVO7sYQ0HyK8
         fcZHD5LXOX3LMjTzhOg/U9s8nn1YQNvK4ywrsXR4zBamgLnBcM3Yxzav8022+IdEQ7Nb
         0fJA==
X-Gm-Message-State: AOAM532KTmRnA1rKeRzheqMtCZmFZ6aqrb0FCOUWnGPK7YnfOp8Fk0IC
        IynWphiY4DogKwlvdj5p3uAXkOo7zmmIpZ68VWY2XQ==
X-Google-Smtp-Source: ABdhPJx4W/jPwkcvJUmsDFbwpNoqSBD2q79ZnTQnQpwYiHcRi7sa3C6YNswuFZ1IosenLe6nyfZr7Y+WuK1axMIwALc=
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr4196424ilu.165.1613170314792;
 Fri, 12 Feb 2021 14:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com> <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
 <20210212222145.GB2858050@casper.infradead.org> <20210212224405.GF3171@xz-x1>
In-Reply-To: <20210212224405.GF3171@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 12 Feb 2021 14:51:17 -0800
Message-ID: <CAJHvVcgiD5OwFVK0Mgy-XDxM2PGCLkOJSCLLSF2Z8bYrf5BTJg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 2:44 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Feb 12, 2021 at 10:21:45PM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 11, 2021 at 11:28:09AM -0800, Axel Rasmussen wrote:
> > > Ah, I had added this just after VM_UFFD_WP, without noticing that this
> > > would be sharing a bit with VM_LOCKED. That seems like not such a
> > > great idea.
> > >
> > > I don't see another unused bit, and I don't see some other obvious
> > > candidate to share with. So, the solution that comes to mind is
> >
> > it'd be even better if you didn't use the last unused bit for UFFD_WP.
> > not sure how feasible that is, but you can see we're really short on
> > bits here.
>
> UFFD_WP is used now for anonymouse already.. And the support for hugetlbfs and
> shmem is in rfc stage on the list.
>
> Is it possible to use CONFIG_ARCH_USES_HIGH_VMA_FLAGS here?  So far uffd-wp is
> only working for 64 bit x86 too due to enlarged pte space.  Maybe we can also
> let minor mode to only support 64 bit hosts.

At least for my / Google's purposes, I don't care about 32-bit support
for this feature. I do care about both x86_64 and arm64, though. So
it's a possibility.

Alternatively, the "it's an API feature not a registration mode"
approach I sent in my v6 also works for me, although it has some
drawbacks.

Another option is, would it be terrible to add an extra u16 or u32 for
UFFD flags to vm_area_struct (say within vm_userfaultfd_ctx)?
Historically we've already added a pointer, so maybe an extra say 16
bits isn't so bad? This would avoid using *any* VM_* flags for UFFD,
even VM_UFFD_MISSING could be in this new flag field.

>
> Thanks,
>
> --
> Peter Xu
>
