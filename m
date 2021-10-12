Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5242AB62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJLSBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLSBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:01:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC65C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t9so582803lfd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqSNsVOtXYPiifkp+lepAhAhHgqhsFkG1XDADIpg/Pc=;
        b=FY/BRNyYSoeaiJSrAAHQ3BrZLM0CaAv9w/dXHHjnPfLhtbC9gLNZ9O9rgLQDmfFZ9o
         8Mgo15NFVUl5gkJg7VmqhjBEsMkyCryU/OfNnkqXoLyp/rMiFDeur2O6jhe6h/s3zLwA
         o2kFQw8ViM/udeGTcQaOp6dV30r8PdS4IHCjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqSNsVOtXYPiifkp+lepAhAhHgqhsFkG1XDADIpg/Pc=;
        b=z8w2qkUGvtDbiQKa0mkthp6MbsLWHw6gjwS+uLUR3ApYd9QUDdw+a+GfArZcp7W0L9
         r0b8ha4CNPf4uNjkKkd4qXWWvnCy/q0J7j36sPatVIuZWi7yPqkJqnFBstStWhKMKh7U
         NQf7e2Jhr8BmLmJ7DYw2Bcy6TwJA06pTrqXE4PUqyvXDUdterSxKTebkOVj9ahpQLg+U
         HXVyKEUCogZ0FjVehyhpqzkJLKO3JfO8+/aZcMAoy29aC7NwTq8EcyE2XMypPPZQmVRA
         4A41bVs+x3Eq07R+sOFskF+iGLelcczHFWWUUKiDwD87x5mHqJ3oRG+9v6GhwjcN1NGI
         hwMA==
X-Gm-Message-State: AOAM530GCYn1CVHwn9Ah4friRbFy5REkkUH6L7m5RqoqzFD5rdt7HTiT
        VueXEE0zEMTOar6hcqAxroZ9Tr0MGXu3dKoD
X-Google-Smtp-Source: ABdhPJxCnxJj3hgn+oGfWAvUk7KUxd0+CvFtfasuYF8mGrR+y9fQ9az7zLp+Y67kY+OmQHAW8XSRuw==
X-Received: by 2002:a05:6512:a8e:: with SMTP id m14mr35526849lfu.575.1634061543874;
        Tue, 12 Oct 2021 10:59:03 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a6sm1177560ljd.67.2021.10.12.10.59.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:59:03 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x27so418134lfa.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:02 -0700 (PDT)
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr2835560lfg.150.1634061542163;
 Tue, 12 Oct 2021 10:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <YWXFagjRVdNanGSy@arm.com>
In-Reply-To: <YWXFagjRVdNanGSy@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Oct 2021 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
Message-ID: <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:27 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Apart from fault_in_pages_*(), there's also fault_in_user_writeable()
> called from the futex code which uses the GUP mechanism as the write
> would be destructive. It looks like it could potentially trigger the
> same infinite loop on -EFAULT.

Hmm.

I think the reason we do fault_in_user_writeable() using GUP is that

 (a) we can avoid the page fault overhead

 (b) we don't have any good "atomic_inc_user()" interface or similar
that could do a write with a zero increment or something like that.

We do have that "arch_futex_atomic_op_inuser()" thing, of course. It's
all kinds of crazy, but we *could* do

       arch_futex_atomic_op_inuser(FUTEX_OP_ADD, 0, &dummy, uaddr);

instead of doing the fault_in_user_writeable().

That might be a good idea anyway. I dunno.

But I agree other options exist:

> I wonder whether we should actually just disable tag checking around the
> problematic accesses. What these callers seem to have in common is using
> pagefault_disable/enable(). We could abuse this to disable tag checking
> or maybe in_atomic() when handling the exception to lazily disable such
> faults temporarily.

Hmm. That would work for MTE, but possibly be very inconvenient for
other situations.

> A more invasive change would be to return a different error for such
> faults like -EACCESS and treat them differently in the caller.

That's _really_ hard for things like "copy_to_user()", that isn't a
single operation, and is supposed to return the bytes left.

Adding another error return would be nasty.

We've had hacks like "squirrel away the actual error code in the task
structure", but that tends to be unmaintainable because we have
interrupts (and NMI's) doing their own possibly nested atomics, so
even disabling preemption won't actually fix some of the nesting
issues.

All of these things make me think that the proper fix ends up being to
make sure that our "fault_in_xyz()" functions simply should always
handle all faults.

Another option may be to teach the GUP code to actually check
architecture-specific sub-page ranges.

        Linus
