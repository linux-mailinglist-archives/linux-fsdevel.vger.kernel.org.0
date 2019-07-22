Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1470CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 00:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbfGVWbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 18:31:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39294 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfGVWbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:31:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so18334452pgi.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2019 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6t6Z8yaBFYoLHYTxv5eDMWvXoAnvu95Bt2xJR7LIXPM=;
        b=Pbqc45wUlOY+YQt8+tSNpR+Cy6b3vnFhYwUa9M0evgqUef7NsHugFBm+TCmFklkAQH
         /1lrgZc1GAgvI4D0R8SZOkah3X6ZV5+9yK4hR1+P74j8LxSFoEWTibbwplmZTPC/CN6J
         CYgHBM2VUAJ4iwonvfOrv7/nFN03R96MD9MhaJ7IY1fqBOMtGMDM4zDdufDEjOTvMaCY
         7svj3GjmBdASH8FN7s+NOxJSOa/i5DqzWQUHmgUS274UJhAHDbRAGIXUC22gLI2OvU69
         zPfYScJFPjUqVHvxdjR/3qAKP+Pi6GaNPjDX3yguwdNPbSjWNDcNmixX7XdD79jAV0Q0
         oEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6t6Z8yaBFYoLHYTxv5eDMWvXoAnvu95Bt2xJR7LIXPM=;
        b=Bx83LMx2BJn1pPwtrY4r9VFC9Pd7cyqtFxyntSDBjvpf8KgG6sVRmXM4eP7gBzhu2H
         P+ngwxb0S+xcZiLzhEhOP5ermCc4tB1lnVx6oIUUOXariAC7RXqW0SPHtvHCyjh6x6Xb
         +L6FUylRyfDQXn0NLT8sDC2Fyc92FW6cgXmp8FQ+aIOgxAyb8t9IDGm2DgKEhOQqrU6x
         VSfMHZzR9vdAbY/TGFfCazKLlFenwD5gQ3C6jc7VVqkcIFemtreodxDqbCpXCn2+zVHr
         0Q/xdiiQLG+0nUTvyfkbm2oWfWMRt4qdynmvjcWqiI5IV3rGIdkoHm1si/czvceXYl88
         nxRQ==
X-Gm-Message-State: APjAAAUMPi9+hEvyGLQAaKeYeZvk8uwojvYDSf88vWkTUEsclw+FPs5w
        zVdn7S7VydwDrkc4DuwwrZZL0C5zPFp3Qn8okO+L9Q==
X-Google-Smtp-Source: APXvYqyO0RsU5hJiKN1UBBMLEqs8dzVSGIuLzMYi1uVToZEbJ6XuzYxALmxwq0bVMsvtqwjv25P0M3jBSrq2d1nPCNQ=
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr2499024pfn.185.1563834660552;
 Mon, 22 Jul 2019 15:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
In-Reply-To: <20190722200347.261D3218C9@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 22 Jul 2019 15:30:49 -0700
Message-ID: <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-18 17:08:34)
> > On Thu, Jul 18, 2019 at 12:22:33PM -0700, Brendan Higgins wrote:
> >
> > I started poking around with your suggestion while we are waiting. A
> > couple early observations:
> >
> > 1) It is actually easier to do than I previously thought and will probably
> >    help with getting more of the planned TAP output stuff working.
> >
> >    That being said, this is still a pretty substantial undertaking and
> >    will likely take *at least* a week to implement and properly review.
> >    Assuming everything goes extremely well (no unexpected issues on my
> >    end, very responsive reviewers, etc).
> >
> > 2) It *will* eliminate the need for kunit_stream.
> >
> > 3) ...but, it *will not* eliminate the need for string_stream.
> >
> > Based on my early observations, I do think it is worth doing, but I
> > don't think it is worth trying to make it in this patchset (unless I
> > have already missed the window, or it is going to be open for a while):
>
> The merge window is over. Typically code needs to be settled a few weeks
> before it opens (i.e. around -rc4 or -rc5) for most maintainers to pick
> up patches for the next merge window.

Yeah, it closed on Sunday, right?

I thought we might be able to squeak in since it was *mostly* settled,
and Shuah sent me an email two weeks ago which I interpreted to mean
she was still willing to take it.

In any case, it doesn't matter now.

> > I do think it will make things much cleaner, but I don't think it will
> > achieve your desired goal of getting rid of an unstructured
> > {kunit|string}_stream style interface; it just adds a layer on top of it
> > that makes it harder to misuse.
>
> Ok.
>
> >
> > I attached a patch of what I have so far at the end of this email so you
> > can see what I am talking about. And of course, if you agree with my
> > assessment, so we can start working on it as a future patch.
> >
> > A couple things in regard to the patch I attached:
> >
> > 1) I wrote it pretty quickly so there are almost definitely mistakes.
> >    You should consider it RFC. I did verify it compiles though.
> >
> > 2) Also, I did use kunit_stream in writing it: all occurences should be
> >    pretty easy to replace with string_stream; nevertheless, the reason
> >    for this is just to make it easier to play with the current APIs. I
> >    wanted to have something working before I went through a big tedious
> >    refactoring. So sorry if it causes any confusion.
> >
> > 3) I also based the patch on all the KUnit patches I have queued up
> >    (includes things like mocking and such) since I want to see how this
> >    serialization thing will work with mocks and matchers and things like
> >    that.
>
> Great!
>
> >
> > From 53d475d3d56afcf92b452c6d347dbedfa1a17d34 Mon Sep 17 00:00:00 2001
> > From: Brendan Higgins <brendanhiggins@google.com>
> > Date: Thu, 18 Jul 2019 16:08:52 -0700
> > Subject: [PATCH v1] DO NOT MERGE: started playing around with the
> >  serialization api
> >
> > ---
> >  include/kunit/assert.h | 130 ++++++++++++++++++++++++++++++
> >  include/kunit/mock.h   |   4 +
> >  kunit/Makefile         |   3 +-
> >  kunit/assert.c         | 179 +++++++++++++++++++++++++++++++++++++++++
> >  kunit/mock.c           |   6 +-
> >  5 files changed, 318 insertions(+), 4 deletions(-)
> >  create mode 100644 include/kunit/assert.h
> >  create mode 100644 kunit/assert.c
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > new file mode 100644
> > index 0000000000000..e054fdff4642f
> > --- /dev/null
> > +++ b/include/kunit/assert.h
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Assertion and expectation serialization API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_ASSERT_H
> > +#define _KUNIT_ASSERT_H
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/mock.h>
> > +
> > +enum kunit_assert_type {
> > +       KUNIT_ASSERTION,
> > +       KUNIT_EXPECTATION,
> > +};
> > +
> > +struct kunit_assert {
> > +       enum kunit_assert_type type;
> > +       const char *line;
> > +       const char *file;
> > +       struct va_format message;
> > +       void (*format)(struct kunit_assert *assert,
> > +                      struct kunit_stream *stream);
>
> Would passing in the test help too?

Yeah, it would probably be good to put one in `struct kunit_assert`.

> > +};
> > +
> > +void kunit_base_assert_format(struct kunit_assert *assert,
> > +                             struct kunit_stream *stream);
> > +
> > +void kunit_assert_print_msg(struct kunit_assert *assert,
> > +                           struct kunit_stream *stream);
> > +
> > +struct kunit_unary_assert {
> > +       struct kunit_assert assert;
> > +       const char *condition;
> > +       bool expected_true;
> > +};
> > +
> > +void kunit_unary_assert_format(struct kunit_assert *assert,
> > +                              struct kunit_stream *stream);
> > +
> > +struct kunit_ptr_not_err_assert {
> > +       struct kunit_assert assert;
> > +       const char *text;
> > +       void *value;
> > +};
> > +
> > +void kunit_ptr_not_err_assert_format(struct kunit_assert *assert,
> > +                                    struct kunit_stream *stream);
> > +
> > +struct kunit_binary_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       long long left_value;
> > +       const char *right_text;
> > +       long long right_value;
> > +};
> > +
> > +void kunit_binary_assert_format(struct kunit_assert *assert,
> > +                               struct kunit_stream *stream);
> > +
> > +struct kunit_binary_ptr_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       void *left_value;
> > +       const char *right_text;
> > +       void *right_value;
> > +};
> > +
> > +void kunit_binary_ptr_assert_format(struct kunit_assert *assert,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_binary_str_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       const char *left_value;
> > +       const char *right_text;
> > +       const char *right_value;
> > +};
> > +
> > +void kunit_binary_str_assert_format(struct kunit_assert *assert,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_mock_assert {
> > +       struct kunit_assert assert;
> > +};
> > +
> > +struct kunit_mock_no_expectations {
> > +       struct kunit_mock_assert assert;
> > +};
>
> What's the purpose of making a wrapper struct with no other members?
> Just to make a different struct for some sort of type checking? I guess
> it's OK but I don't think it will be very useful in practice.

Yeah, just for typing purposes. I don't mind integrating this into the
current patchset and then deciding if we want it or not.

> > +
> > +struct kunit_mock_declaration {
> > +       const char *function_name;
> > +       const char **type_names;
> > +       const void **params;
> > +       int len;
> > +};
> > +
> > +void kunit_mock_declaration_format(struct kunit_mock_declaration *declaration,
> > +                                  struct kunit_stream *stream);
> > +
> > +struct kunit_matcher_result {
> > +       struct kunit_assert assert;
> > +};
> > +
> > +struct kunit_mock_failed_match {
> > +       struct list_head node;
> > +       const char *expectation_text;
> > +       struct kunit_matcher_result *matcher_list;
>
> Minor nitpick: this code could use some const sprinkling.

Will do.

> > +       size_t matcher_list_len;
> > +};
> > +
> > +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_mock_no_match {
> > +       struct kunit_mock_assert assert;
> > +       struct kunit_mock_declaration declaration;
> > +       struct list_head failed_match_list;
> > +};
> > +
> > +void kunit_mock_no_match_format(struct kunit_assert *assert,
> > +                               struct kunit_stream *stream);
> > +
> > +#endif /*  _KUNIT_ASSERT_H */
> > diff --git a/kunit/assert.c b/kunit/assert.c
> > new file mode 100644
> > index 0000000000000..75bb6922a994e
> > --- /dev/null
> > +++ b/kunit/assert.c
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Assertion and expectation serialization API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +#include <kunit/assert.h>
> > +
> > +void kunit_base_assert_format(struct kunit_assert *assert,
> > +                             struct kunit_stream *stream)
> > +{
> > +       const char *expect_or_assert;
> > +
> > +       if (assert->type == KUNIT_EXPECTATION)
> > +               expect_or_assert = "EXPECTATION";
> > +       else
> > +               expect_or_assert = "ASSERTION";
>
> Make this is a switch statement so we can have the compiler complain if
> an enum is missing.

Nice call! I didn't know the compiler warned about that. Will fix.

> > +
> > +       kunit_stream_add(stream, "%s FAILED at %s:%s\n",
> > +                        expect_or_assert, assert->file, assert->line);
> > +}
> > +
> > +void kunit_assert_print_msg(struct kunit_assert *assert,
> > +                           struct kunit_stream *stream)
> > +{
> > +       if (assert->message.fmt)
> > +               kunit_stream_add(stream, "\n%pV", &assert->message);
> > +}
> > +
> [...]
> > +
> > +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
> > +                                   struct kunit_stream *stream)
> > +{
> > +       struct kunit_matcher_result *result;
> > +       size_t i;
> > +
> > +       kunit_stream_add(stream,
> > +                        "Tried expectation: %s, but\n",
> > +                        match->expectation_text);
> > +       for (i = 0; i < match->matcher_list_len; i++) {
> > +               result = &match->matcher_list[i];
> > +               kunit_stream_add(stream, "\t");
> > +               result->assert.format(&result->assert, stream);
> > +               kunit_stream_add(stream, "\n");
> > +       }
>
> What's the calling context of the assertions and expectations? I still
> don't like the fact that string stream needs to allocate buffers and
> throw them into a list somewhere because the calling context matters
> there.

The calling context is the same as before, which is anywhere.

> I'd prefer we just wrote directly to the console/log via printk
> instead. That way things are simple because we use the existing
> buffering path of printk, but maybe there's some benefit to the string
> stream that I don't see? Right now it looks like it builds a string and
> then dumps it to printk so I'm sort of lost what the benefit is over
> just writing directly with printk.

It's just buffering it so the whole string gets printed uninterrupted.
If we were to print out piecemeal to printk, couldn't we have another
call to printk come in causing it to garble the KUnit message we are
in the middle of printing?

> Maybe it's this part that you wrote up above?
>
> > > Nevertheless, I think the debate over the usefulness of the
> > > string_stream and kunit_stream are separate topics. Even if we made
> > > kunit_stream more structured, I am pretty sure I would want to use
> > > string_stream or some variation for constructing the message.
>
> Why do we need string_stream to construct the message? Can't we just
> print it as we process it?

See preceding comment.
