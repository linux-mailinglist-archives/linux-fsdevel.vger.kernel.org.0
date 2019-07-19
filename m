Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450916D7A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfGSAIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 20:08:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36996 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfGSAIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:08:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so13342420pfa.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRmMofzH8EHSj6E3cUHEuNcWCBCVICedNp+mVFhoif4=;
        b=ZuZqh7QuADeUza5BhAWEENNvaV0g0jd5nez4wU52/esfttZou3UuBOkS+0P5EYezOv
         mBCDIlx+aW0PO4LCr2vlr9Sq9eotO27QuwkPBoAs0D3UXufcpx8jCTXwdk+t5yDCyZ2o
         hBXAk3CnxyOvhHixlw611iwjS4vRpGSce5cdO8ltQEZhsFcllcdMKbwnDalmjBPDrr0F
         nncif+MnpHeS51AwyDcrldJhfUOIvLXnBYiBsqEbpqbnyVoreSCq8I3EkWt2w752mtOS
         lWuyh+9ifRutogenkD7RgfEviU0zYPe7i2PZsebsm0o8GwEQeuKjYmDDxpExuTOiM9DB
         XXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRmMofzH8EHSj6E3cUHEuNcWCBCVICedNp+mVFhoif4=;
        b=bg1BlZL+8TO7P5ZCG0PS1MtJ/5QiCmOV+FAFOSWF+cCuBWK/zwo4sfqwd6kRJqv0jG
         5UiCrEf4kNoe5e3ycmluZFYBt1jt/apaClPU6s3wqJkSPvr3Y+uMktEXjOsLlUDqHmcq
         DRZibTWUFZRxEyWvZZ36xktuXdKhuFh9R4YWqXL4Pm0o3GQ2OMXTV4n/do4qXzFsTz/5
         u85pMXOdV3uqaSueXIo+3Nm5Oe8VytDLUc2FloTgLnKS2lmcfU88Laf/YnFTt45khWiD
         QGUriDwjIB73yxtmh7ZpD0enRP3AJ3TNjQjaMzUbQMgW9lc4gB47K/HCzYwdu7CdDilE
         oKiA==
X-Gm-Message-State: APjAAAUAEnTUPIbsDvngtbAMhOzTZGOH2rMLsOr8RCHOLxEXk4K+e1EA
        CO7v+0OM0MgrgFRnnQP+RCznFw==
X-Google-Smtp-Source: APXvYqxAOFjf5oA9A+1bpCmZie3RNqaNqRQFLwviDg050dKmmK4tJI6r2jwnchjqAYjGJmpWO7h6KQ==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr53924589pjo.94.1563494920174;
        Thu, 18 Jul 2019 17:08:40 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id m4sm38563517pgs.71.2019.07.18.17.08.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:08:39 -0700 (PDT)
Date:   Thu, 18 Jul 2019 17:08:34 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Stephen Boyd <sboyd@kernel.org>
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
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream
 like logger
Message-ID: <20190719000834.GA3228@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com>
 <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
 <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:22:33PM -0700, Brendan Higgins wrote:
> On Thu, Jul 18, 2019 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-07-16 11:52:01)
> > > On Tue, Jul 16, 2019 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
[...]
> > Do you have a link to those earlier patches?
> 
> This is the first patchset:
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788057.html
> 
> In particular you can see the code for matching functions here:
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788073.html
> 
> And parameter matching code here:
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788072.html
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788086.html
> 
> My apologies in advance, but the code at this early stage had not
> adopted the kunit_* prefix and was still using the test_* and mock_*
> prefix. (Hence, struct kunit_stream was known as struct test_stream).
[...]
> > The crux of my complaint is that the string stream API is too loosely
> > defined to be usable. It allows tests to build up a string of
> > unstructured information, but with certain calling constraints so we
> > have to tread carefully. If there was more structure to the data that's
> > being recorded then the test case runner could operate on the data
> > without having to do string/stream operations, allocations, etc. This
> > would make the assertion logic much more concrete and specific to kunit,
> > instead of this small kunit wrapper that's been placed on top of string
> > stream.
> 
> Yeah, I can see the point of wanting something that provides more
> structure than the raw `struct kunit_stream` interface. In fact, it is
> something I had already started working on, when I had determined it
> would be a large effort to capture all the variations. I was further
> put off from the idea when I had been asked to convert the KUnit
> intermediate format from what I was using to TAP, because, as it is,
> the current data printed out by KUnit doesn't contain all the data I
> would like to put in it in a way that best takes advantage of the TAP
> specification. One problematic area in particular: TAP already
> provides a way to present a lot of the data I would like to export,
> but it involves JSON serialization which was an idea that some of the
> other reviewers understandably weren't too keen on. TAP also wants to
> report data some time after it is available, which is generally not a
> good idea for test debug information; you want to make it available as
> soon as you can or you risk crashing with the data still inside.
> 
> Hence, I decided we could probably spend a good long while debating
> how I present the information. So the idea of having a loose
> definition seemed attractive to me in its own right since it would
> likely conform to whatever we ended up deciding in the long run. Also,
> all the better that it was what I already had and no one seemed to
> mind too much.
> 
> The only constant I expect is that `struct kunit` will likely need to
> take an abstract object with a `commit` method, or a `format` method
> or whatever so it could control when data was going to be printed out
> to the user. We will probably also use a string builder in there
> somewhere.
> 
> > TL;DR: If we can get rid of the string stream API I'd view that as an
> > improvement because building arbitrary strings in the kernel is complex,
> > error prone and has calling context concerns.
> 
> True. No argument there.
> 
> > Is the intention that other code besides unit tests will use this string
> > stream API to build up strings? Any targets in mind? This would be a
> > good way to get the API merged upstream given that its 2019 and we
> > haven't had such an API in the kernel so far.
> 
> Someone, (was it you?) asked about code sharing with a string builder
> thingy that was used for creating structured human readable files, but
> that seemed like a pretty massive undertaking.
> 
> Aside from that, no. I would kind of prefered that nobody used it for
> anything else because I the issues you described.
> 
> Nevertheless, I think the debate over the usefulness of the
> string_stream and kunit_stream are separate topics. Even if we made
> kunit_stream more structured, I am pretty sure I would want to use
> string_stream or some variation for constructing the message.
> 
> > An "object oriented" (strong quotes!) approach where kunit_fail_msg is
> > the innermost struct in some assertion specific structure might work
> > nicely and allow the test runner to call a generic 'format' function to
> > print out the message based on the type of assertion/expectation it is.
> > It probably would mean less code size too because the strings that are
> > common will be in the common printing function instead of created twice,
> > in the macros/code and then copied to the heap for the string stream.
> >
> >         struct kunit_assert {
> >                 const char *line;
> >                 const char *file;
> >                 const char *func;
> >                 void (*format)(struct kunit_assert *assert);
> >         };
> >
> >         struct kunit_comparison_assert {
> >                 enum operator operator;
> >                 const char *left;
> >                 const char *right;
> >                 struct kunit_assert assert;
> >         };
> >
> >         struct kunit_bool_assert {
> >                 const char *truth;
> >                 const char *statement;
> >                 struct kunit_assert assert;
> >         };
> >
> >         void kunit_format_comparison(struct kunit_assert *assert)
> >         {
> >                 struct kunit_comparison_assert *comp = container_of(assert, ...)
> >
> >                 kunit_printk(...)
> >         }

I started poking around with your suggestion while we are waiting. A
couple early observations:

1) It is actually easier to do than I previously thought and will probably
   help with getting more of the planned TAP output stuff working.

   That being said, this is still a pretty substantial undertaking and
   will likely take *at least* a week to implement and properly review.
   Assuming everything goes extremely well (no unexpected issues on my
   end, very responsive reviewers, etc).

2) It *will* eliminate the need for kunit_stream.

3) ...but, it *will not* eliminate the need for string_stream.

Based on my early observations, I do think it is worth doing, but I
don't think it is worth trying to make it in this patchset (unless I
have already missed the window, or it is going to be open for a while):
I do think it will make things much cleaner, but I don't think it will
achieve your desired goal of getting rid of an unstructured
{kunit|string}_stream style interface; it just adds a layer on top of it
that makes it harder to misuse.

I attached a patch of what I have so far at the end of this email so you
can see what I am talking about. And of course, if you agree with my
assessment, so we can start working on it as a future patch.

A couple things in regard to the patch I attached:

1) I wrote it pretty quickly so there are almost definitely mistakes.
   You should consider it RFC. I did verify it compiles though.

2) Also, I did use kunit_stream in writing it: all occurences should be
   pretty easy to replace with string_stream; nevertheless, the reason
   for this is just to make it easier to play with the current APIs. I
   wanted to have something working before I went through a big tedious
   refactoring. So sorry if it causes any confusion.

3) I also based the patch on all the KUnit patches I have queued up
   (includes things like mocking and such) since I want to see how this
   serialization thing will work with mocks and matchers and things like
   that.

> I started working on something similarish, but by the time I ended up
> coming up with a parent object whose definition was loose enough to
> satisfy all the properties required by the child classes it ended up
> basically being the same as what I have now just with a more complex
> hierarchy of message manipulation logic.
> 
> On the other hand, I didn't have the idea of doing the parent object
> quite the way you did and that would clean up a lot of the duplicated
> first line logic.
> 
> I would like to give it a try, but I am afraid I am going to get
> sucked down a really deep rabbit hole.
> 
> > Maybe other people have opinions here on if you should do it now or
> > later. Future coding is not a great argument because it's hard to
> > predict the future. On the other hand, this patchset is in good shape to
> 
> Yeah, that's kind of why I am afraid to go down this road when I have
> something that works now and I know works with the mocking stuff I
> want to do.
> 
> I would like to try your suggestion, but I want to try to make it work
> with my mocking patches before I commit to it because otherwise I am
> just going to have to back it out in a follow up patchset.
> 
> > merge and I'd like to use it to write unit tests for code I maintain so
> > I don't want to see this stall out. Sorry if I'm opening the can of
> > worms you're talking about.
> 
> Don't be sorry. I agree with you that the kunit_stream stuff is not very pretty.
> 
> Shuah, have we missed the merge window for 5.3?
> 
> I saw you only sent one PR out so far for this release, and there
> wasn't much in it; I imagine you are going to send at least one more?
> 
> I figure, if we still got time to try out your suggestion, Stephen, no
> harm in trying.
> 
> Also if we missed it, then I have another couple months to play around with it.
> 
> What do you think?

I attached the patch mentioned above below. Let me know what you think!

Cheers!

From 53d475d3d56afcf92b452c6d347dbedfa1a17d34 Mon Sep 17 00:00:00 2001
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 18 Jul 2019 16:08:52 -0700
Subject: [PATCH v1] DO NOT MERGE: started playing around with the
 serialization api

---
 include/kunit/assert.h | 130 ++++++++++++++++++++++++++++++
 include/kunit/mock.h   |   4 +
 kunit/Makefile         |   3 +-
 kunit/assert.c         | 179 +++++++++++++++++++++++++++++++++++++++++
 kunit/mock.c           |   6 +-
 5 files changed, 318 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/assert.h
 create mode 100644 kunit/assert.c

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
new file mode 100644
index 0000000000000..e054fdff4642f
--- /dev/null
+++ b/include/kunit/assert.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_ASSERT_H
+#define _KUNIT_ASSERT_H
+
+#include <kunit/test.h>
+#include <kunit/mock.h>
+
+enum kunit_assert_type {
+	KUNIT_ASSERTION,
+	KUNIT_EXPECTATION,
+};
+
+struct kunit_assert {
+	enum kunit_assert_type type;
+	const char *line;
+	const char *file;
+	struct va_format message;
+	void (*format)(struct kunit_assert *assert,
+		       struct kunit_stream *stream);
+};
+
+void kunit_base_assert_format(struct kunit_assert *assert,
+			      struct kunit_stream *stream);
+
+void kunit_assert_print_msg(struct kunit_assert *assert,
+			    struct kunit_stream *stream);
+
+struct kunit_unary_assert {
+	struct kunit_assert assert;
+	const char *condition;
+	bool expected_true;
+};
+
+void kunit_unary_assert_format(struct kunit_assert *assert,
+			       struct kunit_stream *stream);
+
+struct kunit_ptr_not_err_assert {
+	struct kunit_assert assert;
+	const char *text;
+	void *value;
+};
+
+void kunit_ptr_not_err_assert_format(struct kunit_assert *assert,
+				     struct kunit_stream *stream);
+
+struct kunit_binary_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	long long left_value;
+	const char *right_text;
+	long long right_value;
+};
+
+void kunit_binary_assert_format(struct kunit_assert *assert,
+				struct kunit_stream *stream);
+
+struct kunit_binary_ptr_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	void *left_value;
+	const char *right_text;
+	void *right_value;
+};
+
+void kunit_binary_ptr_assert_format(struct kunit_assert *assert,
+				    struct kunit_stream *stream);
+
+struct kunit_binary_str_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const char *left_value;
+	const char *right_text;
+	const char *right_value;
+};
+
+void kunit_binary_str_assert_format(struct kunit_assert *assert,
+				    struct kunit_stream *stream);
+
+struct kunit_mock_assert {
+	struct kunit_assert assert;
+};
+
+struct kunit_mock_no_expectations {
+	struct kunit_mock_assert assert;
+};
+
+struct kunit_mock_declaration {
+	const char *function_name;
+	const char **type_names;
+	const void **params;
+	int len;
+};
+
+void kunit_mock_declaration_format(struct kunit_mock_declaration *declaration,
+				   struct kunit_stream *stream);
+
+struct kunit_matcher_result {
+	struct kunit_assert assert;
+};
+
+struct kunit_mock_failed_match {
+	struct list_head node;
+	const char *expectation_text;
+	struct kunit_matcher_result *matcher_list;
+	size_t matcher_list_len;
+};
+
+void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
+				    struct kunit_stream *stream);
+
+struct kunit_mock_no_match {
+	struct kunit_mock_assert assert;
+	struct kunit_mock_declaration declaration;
+	struct list_head failed_match_list;
+};
+
+void kunit_mock_no_match_format(struct kunit_assert *assert,
+				struct kunit_stream *stream);
+
+#endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 001b96af62f1e..52c9e427c831b 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -144,6 +144,10 @@ void mock_register_formatter(struct mock_param_formatter *formatter);
 
 void mock_unregister_formatter(struct mock_param_formatter *formatter);
 
+void mock_format_param(struct kunit_stream *stream,
+		       const char *type_name,
+		       const void *param);
+
 struct mock *mock_get_global_mock(void);
 
 #define MOCK(name) name##_mock
diff --git a/kunit/Makefile b/kunit/Makefile
index bbf43fcfb93a9..149d856a30f04 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					common-mocks.o \
 					string-stream.o \
 					kunit-stream.o \
-					try-catch.o
+					try-catch.o \
+					assert.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
 					test-mock.o \
diff --git a/kunit/assert.c b/kunit/assert.c
new file mode 100644
index 0000000000000..75bb6922a994e
--- /dev/null
+++ b/kunit/assert.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/assert.h>
+
+void kunit_base_assert_format(struct kunit_assert *assert,
+			      struct kunit_stream *stream)
+{
+	const char *expect_or_assert;
+
+	if (assert->type == KUNIT_EXPECTATION)
+		expect_or_assert = "EXPECTATION";
+	else
+		expect_or_assert = "ASSERTION";
+
+	kunit_stream_add(stream, "%s FAILED at %s:%s\n",
+			 expect_or_assert, assert->file, assert->line);
+}
+
+void kunit_assert_print_msg(struct kunit_assert *assert,
+			    struct kunit_stream *stream)
+{
+	if (assert->message.fmt)
+		kunit_stream_add(stream, "\n%pV", &assert->message);
+}
+
+void kunit_unary_assert_format(struct kunit_assert *assert,
+			       struct kunit_stream *stream)
+{
+	struct kunit_unary_assert *unary_assert = container_of(
+			assert, struct kunit_unary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (unary_assert->expected_true)
+		kunit_stream_add(stream,
+				 "\tExpected %s to be true, but is false\n",
+				 unary_assert->condition);
+	else
+		kunit_stream_add(stream,
+				 "\tExpected %s to be false, but is true\n",
+				 unary_assert->condition);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_ptr_not_err_assert_format(struct kunit_assert *assert,
+				     struct kunit_stream *stream)
+{
+	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
+			assert, struct kunit_ptr_not_err_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (!ptr_assert->value) {
+		kunit_stream_add(stream,
+				 "\tExpected %s is not null, but is\n",
+				 ptr_assert->text);
+	} else if (IS_ERR(ptr_assert->value)) {
+		kunit_stream_add(stream,
+				 "\tExpected %s is not error, but is: %ld\n",
+				 ptr_assert->text,
+				 PTR_ERR(ptr_assert->value));
+	}
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_assert_format(struct kunit_assert *assert,
+				struct kunit_stream *stream)
+{
+	struct kunit_binary_assert *binary_assert = container_of(
+			assert, struct kunit_binary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	kunit_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	kunit_stream_add(stream, "\t\t%s == %lld\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	kunit_stream_add(stream, "\t\t%s == %lld",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_ptr_assert_format(struct kunit_assert *assert,
+				    struct kunit_stream *stream)
+{
+	struct kunit_binary_ptr_assert *binary_assert = container_of(
+			assert, struct kunit_binary_ptr_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	kunit_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	kunit_stream_add(stream, "\t\t%s == %pK\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	kunit_stream_add(stream, "\t\t%s == %pK",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_str_assert_format(struct kunit_assert *assert,
+				    struct kunit_stream *stream)
+{
+	struct kunit_binary_str_assert *binary_assert = container_of(
+			assert, struct kunit_binary_str_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	kunit_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	kunit_stream_add(stream, "\t\t%s == %s\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	kunit_stream_add(stream, "\t\t%s == %s",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_mock_declaration_format(struct kunit_mock_declaration *declaration,
+				   struct kunit_stream *stream)
+{
+	int i;
+
+	kunit_stream_add(stream, "%s(", declaration->function_name);
+	for (i = 0; i < declaration->len; i++) {
+		mock_format_param(stream,
+				  declaration->type_names[i],
+				  declaration->params[i]);
+		if (i < declaration->len - 1)
+			kunit_stream_add(stream, ", ");
+	}
+	kunit_stream_add(stream, ")\n");
+}
+
+void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
+				    struct kunit_stream *stream)
+{
+	struct kunit_matcher_result *result;
+	size_t i;
+
+	kunit_stream_add(stream,
+			 "Tried expectation: %s, but\n",
+			 match->expectation_text);
+	for (i = 0; i < match->matcher_list_len; i++) {
+		result = &match->matcher_list[i];
+		kunit_stream_add(stream, "\t");
+		result->assert.format(&result->assert, stream);
+		kunit_stream_add(stream, "\n");
+	}
+}
+
+void kunit_mock_no_match_format(struct kunit_assert *assert,
+				struct kunit_stream *stream)
+{
+	struct kunit_mock_assert *mock_assert = container_of(
+			assert, struct kunit_mock_assert, assert);
+	struct kunit_mock_no_match *no_match = container_of(
+			mock_assert, struct kunit_mock_no_match, assert);
+	struct kunit_mock_failed_match *expectation;
+
+	kunit_base_assert_format(assert, stream);
+	kunit_mock_declaration_format(&no_match->declaration, stream);
+
+	list_for_each_entry(expectation, &no_match->failed_match_list, node)
+		kunit_mock_failed_match_format(expectation, stream);
+}
diff --git a/kunit/mock.c b/kunit/mock.c
index ccb0abe111402..ab441a58a918c 100644
--- a/kunit/mock.c
+++ b/kunit/mock.c
@@ -269,9 +269,9 @@ struct mock_param_formatter *mock_find_formatter(const char *type_name)
 	return NULL;
 }
 
-static void mock_format_param(struct kunit_stream *stream,
-			      const char *type_name,
-			      const void *param)
+void mock_format_param(struct kunit_stream *stream,
+		       const char *type_name,
+		       const void *param)
 {
 	struct mock_param_formatter *formatter;
 
-- 
2.22.0.657.g960e92d24f-goog

