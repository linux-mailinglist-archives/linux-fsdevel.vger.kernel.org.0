Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE970A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfGVUDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 16:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfGVUDt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:03:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261D3218C9;
        Mon, 22 Jul 2019 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563825827;
        bh=Wsa0RdtVEyOuADI16LfYypjcqEqgHKE0qCpoH+nyomM=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=iN2qJyphkqjtk5dxm7+fFAGNWCxb6gIkH3cXPJpWi5Jmp3HSj39EYhV46o7/9rmGv
         iWnRc0lUEISi2tmn4zfbyW0cIWtqWT2YGXGPIR7IxaSPAGqBl30dx57TR2E3V6YE0I
         CsYfxBQoaUdmaXFN0U0JdJFG/96pL0/7LL4INSNU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190719000834.GA3228@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org> <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com> <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com> <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com> <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com> <20190719000834.GA3228@google.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 13:03:46 -0700
Message-Id: <20190722200347.261D3218C9@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-18 17:08:34)
> On Thu, Jul 18, 2019 at 12:22:33PM -0700, Brendan Higgins wrote:
>
> I started poking around with your suggestion while we are waiting. A
> couple early observations:
>=20
> 1) It is actually easier to do than I previously thought and will probably
>    help with getting more of the planned TAP output stuff working.
>=20
>    That being said, this is still a pretty substantial undertaking and
>    will likely take *at least* a week to implement and properly review.
>    Assuming everything goes extremely well (no unexpected issues on my
>    end, very responsive reviewers, etc).
>=20
> 2) It *will* eliminate the need for kunit_stream.
>=20
> 3) ...but, it *will not* eliminate the need for string_stream.
>=20
> Based on my early observations, I do think it is worth doing, but I
> don't think it is worth trying to make it in this patchset (unless I
> have already missed the window, or it is going to be open for a while):

The merge window is over. Typically code needs to be settled a few weeks
before it opens (i.e. around -rc4 or -rc5) for most maintainers to pick
up patches for the next merge window.

> I do think it will make things much cleaner, but I don't think it will
> achieve your desired goal of getting rid of an unstructured
> {kunit|string}_stream style interface; it just adds a layer on top of it
> that makes it harder to misuse.

Ok.

>=20
> I attached a patch of what I have so far at the end of this email so you
> can see what I am talking about. And of course, if you agree with my
> assessment, so we can start working on it as a future patch.
>=20
> A couple things in regard to the patch I attached:
>=20
> 1) I wrote it pretty quickly so there are almost definitely mistakes.
>    You should consider it RFC. I did verify it compiles though.
>=20
> 2) Also, I did use kunit_stream in writing it: all occurences should be
>    pretty easy to replace with string_stream; nevertheless, the reason
>    for this is just to make it easier to play with the current APIs. I
>    wanted to have something working before I went through a big tedious
>    refactoring. So sorry if it causes any confusion.
>=20
> 3) I also based the patch on all the KUnit patches I have queued up
>    (includes things like mocking and such) since I want to see how this
>    serialization thing will work with mocks and matchers and things like
>    that.

Great!

>=20
> From 53d475d3d56afcf92b452c6d347dbedfa1a17d34 Mon Sep 17 00:00:00 2001
> From: Brendan Higgins <brendanhiggins@google.com>
> Date: Thu, 18 Jul 2019 16:08:52 -0700
> Subject: [PATCH v1] DO NOT MERGE: started playing around with the
>  serialization api
>=20
> ---
>  include/kunit/assert.h | 130 ++++++++++++++++++++++++++++++
>  include/kunit/mock.h   |   4 +
>  kunit/Makefile         |   3 +-
>  kunit/assert.c         | 179 +++++++++++++++++++++++++++++++++++++++++
>  kunit/mock.c           |   6 +-
>  5 files changed, 318 insertions(+), 4 deletions(-)
>  create mode 100644 include/kunit/assert.h
>  create mode 100644 kunit/assert.c
>=20
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> new file mode 100644
> index 0000000000000..e054fdff4642f
> --- /dev/null
> +++ b/include/kunit/assert.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Assertion and expectation serialization API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_ASSERT_H
> +#define _KUNIT_ASSERT_H
> +
> +#include <kunit/test.h>
> +#include <kunit/mock.h>
> +
> +enum kunit_assert_type {
> +       KUNIT_ASSERTION,
> +       KUNIT_EXPECTATION,
> +};
> +
> +struct kunit_assert {
> +       enum kunit_assert_type type;
> +       const char *line;
> +       const char *file;
> +       struct va_format message;
> +       void (*format)(struct kunit_assert *assert,
> +                      struct kunit_stream *stream);

Would passing in the test help too?

> +};
> +
> +void kunit_base_assert_format(struct kunit_assert *assert,
> +                             struct kunit_stream *stream);
> +
> +void kunit_assert_print_msg(struct kunit_assert *assert,
> +                           struct kunit_stream *stream);
> +
> +struct kunit_unary_assert {
> +       struct kunit_assert assert;
> +       const char *condition;
> +       bool expected_true;
> +};
> +
> +void kunit_unary_assert_format(struct kunit_assert *assert,
> +                              struct kunit_stream *stream);
> +
> +struct kunit_ptr_not_err_assert {
> +       struct kunit_assert assert;
> +       const char *text;
> +       void *value;
> +};
> +
> +void kunit_ptr_not_err_assert_format(struct kunit_assert *assert,
> +                                    struct kunit_stream *stream);
> +
> +struct kunit_binary_assert {
> +       struct kunit_assert assert;
> +       const char *operation;
> +       const char *left_text;
> +       long long left_value;
> +       const char *right_text;
> +       long long right_value;
> +};
> +
> +void kunit_binary_assert_format(struct kunit_assert *assert,
> +                               struct kunit_stream *stream);
> +
> +struct kunit_binary_ptr_assert {
> +       struct kunit_assert assert;
> +       const char *operation;
> +       const char *left_text;
> +       void *left_value;
> +       const char *right_text;
> +       void *right_value;
> +};
> +
> +void kunit_binary_ptr_assert_format(struct kunit_assert *assert,
> +                                   struct kunit_stream *stream);
> +
> +struct kunit_binary_str_assert {
> +       struct kunit_assert assert;
> +       const char *operation;
> +       const char *left_text;
> +       const char *left_value;
> +       const char *right_text;
> +       const char *right_value;
> +};
> +
> +void kunit_binary_str_assert_format(struct kunit_assert *assert,
> +                                   struct kunit_stream *stream);
> +
> +struct kunit_mock_assert {
> +       struct kunit_assert assert;
> +};
> +
> +struct kunit_mock_no_expectations {
> +       struct kunit_mock_assert assert;
> +};

What's the purpose of making a wrapper struct with no other members?
Just to make a different struct for some sort of type checking? I guess
it's OK but I don't think it will be very useful in practice.

> +
> +struct kunit_mock_declaration {
> +       const char *function_name;
> +       const char **type_names;
> +       const void **params;
> +       int len;
> +};
> +
> +void kunit_mock_declaration_format(struct kunit_mock_declaration *declar=
ation,
> +                                  struct kunit_stream *stream);
> +
> +struct kunit_matcher_result {
> +       struct kunit_assert assert;
> +};
> +
> +struct kunit_mock_failed_match {
> +       struct list_head node;
> +       const char *expectation_text;
> +       struct kunit_matcher_result *matcher_list;

Minor nitpick: this code could use some const sprinkling.

> +       size_t matcher_list_len;
> +};
> +
> +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *matc=
h,
> +                                   struct kunit_stream *stream);
> +
> +struct kunit_mock_no_match {
> +       struct kunit_mock_assert assert;
> +       struct kunit_mock_declaration declaration;
> +       struct list_head failed_match_list;
> +};
> +
> +void kunit_mock_no_match_format(struct kunit_assert *assert,
> +                               struct kunit_stream *stream);
> +
> +#endif /*  _KUNIT_ASSERT_H */
> diff --git a/kunit/assert.c b/kunit/assert.c
> new file mode 100644
> index 0000000000000..75bb6922a994e
> --- /dev/null
> +++ b/kunit/assert.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Assertion and expectation serialization API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +#include <kunit/assert.h>
> +
> +void kunit_base_assert_format(struct kunit_assert *assert,
> +                             struct kunit_stream *stream)
> +{
> +       const char *expect_or_assert;
> +
> +       if (assert->type =3D=3D KUNIT_EXPECTATION)
> +               expect_or_assert =3D "EXPECTATION";
> +       else
> +               expect_or_assert =3D "ASSERTION";

Make this is a switch statement so we can have the compiler complain if
an enum is missing.

> +
> +       kunit_stream_add(stream, "%s FAILED at %s:%s\n",
> +                        expect_or_assert, assert->file, assert->line);
> +}
> +
> +void kunit_assert_print_msg(struct kunit_assert *assert,
> +                           struct kunit_stream *stream)
> +{
> +       if (assert->message.fmt)
> +               kunit_stream_add(stream, "\n%pV", &assert->message);
> +}
> +
[...]
> +
> +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *matc=
h,
> +                                   struct kunit_stream *stream)
> +{
> +       struct kunit_matcher_result *result;
> +       size_t i;
> +
> +       kunit_stream_add(stream,
> +                        "Tried expectation: %s, but\n",
> +                        match->expectation_text);
> +       for (i =3D 0; i < match->matcher_list_len; i++) {
> +               result =3D &match->matcher_list[i];
> +               kunit_stream_add(stream, "\t");
> +               result->assert.format(&result->assert, stream);
> +               kunit_stream_add(stream, "\n");
> +       }

What's the calling context of the assertions and expectations? I still
don't like the fact that string stream needs to allocate buffers and
throw them into a list somewhere because the calling context matters
there. I'd prefer we just wrote directly to the console/log via printk
instead. That way things are simple because we use the existing
buffering path of printk, but maybe there's some benefit to the string
stream that I don't see? Right now it looks like it builds a string and
then dumps it to printk so I'm sort of lost what the benefit is over
just writing directly with printk.

Maybe it's this part that you wrote up above?

> > Nevertheless, I think the debate over the usefulness of the
> > string_stream and kunit_stream are separate topics. Even if we made
> > kunit_stream more structured, I am pretty sure I would want to use
> > string_stream or some variation for constructing the message.

Why do we need string_stream to construct the message? Can't we just
print it as we process it?

