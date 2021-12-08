Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2B46D8E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhLHQyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhLHQyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:54:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B0C0617A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 08:51:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x6so10511742edr.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Dec 2021 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dto8X3c8dkt8cAuGIAikbVN54E5STCRsv0et+8KXh8=;
        b=XL0p0g2mnaxR5sNE/l+nWe28s9d3M1czmNdZvqDzJYOtI9OUtCjctzb75KHJ13Fmgf
         kxjEdIK6lI5Iqihs3D3DF1KbxA+pGkY3myenSVWEXzC6cVMdvOBIHdUDtJwxbbLH0hJC
         ZuyS2FQBQqB3Fj+cUfkE/veQZzqrEAWYRJ0AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dto8X3c8dkt8cAuGIAikbVN54E5STCRsv0et+8KXh8=;
        b=fcRm9g0sv0QoB7fdf95PENcRzZGxg8hdjeysBcBmyl0zw5mQGGHo6Rk1EPCjYpw3Mq
         c6n07VvxUGBL5Fp1uhKU6IFMfvHN6mEyd8+a/ZwDt4a2IGtWV8r+DHRAPEoWyj4oy6d8
         HJkrKROumQ1ifvlradHabgQgQKMwqNJQafNAeImo/r6zWAb2qvOwbGEppvyqaYUQptZt
         Qw8UhKXnplnMFFB9khikSboqhQxQ1DsxxP9kVeccYtjtEWlKl0qQNd1zkxFr22UGfSma
         KrlUxdSvVIAhBdmZAxofa8uUtbC+MkI0Ei88qZx9b5xwm/kdQZFhdxRa1QODwjmPoUUd
         H//g==
X-Gm-Message-State: AOAM531dtTOvXt8mpECYLddGE3Syo5Akmit/obHhk/X9RE8ADWbTRivz
        e1NXcExK5d9ZEWQxXj/N2zrl7qOdiRGI8s08Qqc=
X-Google-Smtp-Source: ABdhPJywfCEpTv0gDbuEiJi4LJ0ElvkWDSp1DbQs8KFxgfiuXHmmWJZSMQZW9/O9SpR4DTOzeW8kag==
X-Received: by 2002:a17:906:80b:: with SMTP id e11mr9147627ejd.20.1638982270952;
        Wed, 08 Dec 2021 08:51:10 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id s4sm1830950ejn.25.2021.12.08.08.51.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:51:10 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2195999wme.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Dec 2021 08:51:09 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr16865226wmg.152.1638982258068;
 Wed, 08 Dec 2021 08:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-3-arnd@kernel.org>
 <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com> <CAK8P3a3Uy0k+SnWYqz7FMsQsu14VzivMJcjGDRBLv17adFYywA@mail.gmail.com>
In-Reply-To: <CAK8P3a3Uy0k+SnWYqz7FMsQsu14VzivMJcjGDRBLv17adFYywA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Dec 2021 08:50:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgX8ZU8eQuegqFYdJ7VciZqNWTdfsM-=ugEWJWchTnw7A@mail.gmail.com>
Message-ID: <CAHk-=wgX8ZU8eQuegqFYdJ7VciZqNWTdfsM-=ugEWJWchTnw7A@mail.gmail.com>
Subject: Re: [RFC 2/3] headers: introduce linux/struct_types.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2021 at 12:56 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> For the added headers, do you have a preference for whether to try grouping
> them logically or not? I could either split them out individually into many new
> headers (xarray_types.h, idr_types.h, percpu_rwsem_types.h, rwsem_types.h,
> ...), or combine some of them when they define related types.

So I'd really like to have some logical grouping. I'd rather have ten
smaller headers that each have one logical grouping than one "put
random core kernel structs in this one".

 The reason I reacted fairly strongly against this "struct_types.h"
patch is that I quite often end up looking up some exact type
definition and the associated initializers etc. It's admittedly seldom
stuff that is this core (it tends to be some random odder type), but
just to give a concrete example, that <linux/mutex.h> change was an
example of something I really dislike.

Moving just the type definition away, particularly when it then
depends on various kernel config options, and having the core
initializer macros and functions somewhere different from where the
type is defined is really nasty when you're looking at some type
definition details.

(The mutex one is just an example: all the locking structures had the
same pattern).

I realize that the locking structs are also exactly the ones that are
then often embedded in other structures, so I understand why they were
so prominent in that patch. But at the same time, I think that is how
C header files work - it has many upsides, but it certainly also has
that problematic downside of having to get the header inclusion right
without recursion etc.

So instead of trying to split out things like the structures
associated with locking, I'd rather aim to

 (a) try to make sure that the locking headers are always
self-contained enough that there is never any issue with including
them, and recursion isn't an issue.

 (b) I think it might be better to try to instead split out the more
specialized and high-level structures, and try to declare _those_
separately

optimally for (b) is to not declare them at all: in many situations
you really just want the header file for some function pointer
declaration, and doing a forward declaration with just "struct
super_block;" in the generic header file might be the right thing.

Then the relatively few places that actually care what 'struct
super_block' looks like could include <linux/superblock.h> or
whatever.

Because a big portion of our code probably does want to include
<linux/fs.h>, but is not AT ALL interested in how 'struct super_block'
actually is laid out. The fact that you want declarations for
functions that take a pointer to it doesn't matter, for them it's
enough to have that forward-declaration of "this is a valid struct,
you don't care what it looks like".

So I think I would be much more interested in _that_ kind of patch:
instead of trying to collect truly core types in one (or a few) header
files, try to see if all those random other types could not be split
out into their own patches.

And yes, yes, I realize that 'struct super_block' is actually actively
used by inline functions in <linux/fs.h>, so they actually require
that declaration as it stands now. But those functions are generally
fairly specialized, and they could go along with the structure
definition into the <superblock.h> header. And maybe some of them
shouldn't be inline functions at all - we often end up having
unnecessariyl big and complex headers just because it was easier to
add an inline function (or expand a trivial one) than it was to just
make a function declaration and then move the code into a separate C
file.

(This is also why sometimes macros are more convenient than inline
functions - they don't need the context. So sometimes the answer for
trivial helper functions is to just turn then into macros instead).

Hmm?

               Linus
