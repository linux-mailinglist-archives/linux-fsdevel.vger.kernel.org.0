Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961233D4B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406718AbfFKR6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 13:58:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34621 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405972AbfFKR6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:58:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so5441644plt.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezWWyHmFr3D52R1hMjM3lFqjTF5qDUt/Gz8+w6Ybeeg=;
        b=NXabX8VKhqlLINuoMQHbinmJIUbVH0BN+gV3EBZfeU2WCiSZGaL5z1BBk/58lNpSLk
         6OZS/QBr9Xcqp8FLP0aoFzarQalnNz5o/W4LmU3plkkiz8px1w/b14QGZtx/LpELMViT
         Cq0zGOdkG0bUXDxO/omwJpd2ykSJkUq6SnLNsOdyke4UAJxvvy6sJ2KCrvAjbWxYUAfv
         mNi2NE/pq7hdDfUErhLVHQrN935jeqQID0v5d+Q6AZHeXiOFfmRa4pwDvFIRPShgom9k
         +iiaBa56wRxxqOBXtYUg69RYV0vztcjvfpfAUcRMjGUqaocx9uX+ixG798K/4fglHZBe
         neug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezWWyHmFr3D52R1hMjM3lFqjTF5qDUt/Gz8+w6Ybeeg=;
        b=ZeR1tK34eMgVHHhY0F1ctAqrrJ5oaNC+Vog6ehWiSL9G48rO8K8W3O3wz1hE/dCNbi
         tYk11AWncfrxwWd6qSRuKW5Mq2UYxpy/FFke4ybSsBeBcW1bLiOpWV2uOUvDVYZ3+1m1
         toa1A66+q7TKJFDtFpQExjc3GYZ5k9zArXM30ebBVCW2Bk2b8S30tZpOp6xxDw3yNYSz
         SLD9aZxJbhrotYtABC8l/P2aDg0sJTOrLEfWd4HfPwkTbJLGofoG0LZWrSuDbUrDEhyp
         N1D0nfpWoZ8xRHKL4zQOGpu+DhDCOvmbLhIE5o6KtaQox7ePjK+Qgo6O0n951YwqVElb
         qigg==
X-Gm-Message-State: APjAAAUQACLoZtu/5Xwpv9Jl9TbccE8XhgR+TWugWe18KR5c8HJXKqtc
        gMfeLuzBwBTy0NY2M6Dbl038CA==
X-Google-Smtp-Source: APXvYqxLhXRMoy3niXLUf+3yjcR+oYOqDZdO4IrAaXbVjtaTgohrWX6P7B3Tnf00xa75XTTIUTknBA==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr47725400plc.186.1560275916197;
        Tue, 11 Jun 2019 10:58:36 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id s64sm13222982pfb.160.2019.06.11.10.58.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 10:58:35 -0700 (PDT)
Date:   Tue, 11 Jun 2019 10:58:30 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190611175830.GA236872@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
 <20190607190047.C3E7A20868@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607190047.C3E7A20868@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 12:00:47PM -0700, Stephen Boyd wrote:
> Quoting Iurii Zaikin (2019-06-05 18:29:42)
> > On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > > new file mode 100644
> > > > index 0000000000000..fe0f2bae66085
> > > > --- /dev/null
> > > > +++ b/kernel/sysctl-test.c
> > > > +
> > > > +
> > > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > > +{
> > > > +       struct ctl_table table = {
> > > > +               .procname = "foo",
> > > > +               .data           = &test_data.int_0001,
> > > > +               .maxlen         = sizeof(int),
> > > > +               .mode           = 0644,
> > > > +               .proc_handler   = proc_dointvec,
> > > > +               .extra1         = &i_zero,
> > > > +               .extra2         = &i_one_hundred,
> > > > +       };
> > > > +       char input[] = "-9";
> > > > +       size_t len = sizeof(input) - 1;
> > > > +       loff_t pos = 0;
> > > > +
> > > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> > >
> > > Is the casting necessary? Or can the macro do a type coercion of the
> > > second parameter based on the first type?
> >  Data field is defined as void* so I believe casting is necessary to
> > dereference it as a pointer to an array of ints. I don't think the
> > macro should do any type coercion that == operator wouldn't do.
> >  I did change the cast to make it more clear that it's a pointer to an
> > array of ints being dereferenced.
> 
> Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
> both sides and cause a build warning/error if the types aren't the same.
> This would be similar to our min/max macros that complain about
> mismatched types in the comparisons. Then if a test developer needs to
> convert one type or the other they could do so with a
> KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
> explicitly.

Do you think it would be better to do a phony compare similar to how
min/max used to work prior to 4.17, or to use the new __typecheck(...)
macro? This might seem like a dumb question (and maybe it is), but Iurii
and I thought the former created an error message that was a bit easier
to understand, whereas __typecheck is obviously superior in terms of
code reuse.

This is what we are thinking right now; if you don't have any complaints
I will squash it into the relevant commits on the next revision:
---
From: Iurii Zaikin <yzaikin@google.com>

Adds a warning message when comparing values of different types similar
to what min() / max() macros do.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 include/kunit/test.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 511c9e85401a6..791e22fba5620 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -335,6 +335,13 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * 'Unnecessary' cast serves to generate a compile-time warning in case
+ * of comparing incompatible types. Inspired by include/linux/kernel.h
+ */
+#define __kunit_typecheck(lhs, rhs) \
+	((void) (&(lhs) == &(rhs)))
+
 static inline struct kunit_stream *kunit_expect_start(struct kunit *test,
 						      const char *file,
 						      const char *line)
@@ -514,6 +521,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_BINARY(test, left, condition, right) do {		       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_binary(test,					       \
 			    (long long) __left, #left,			       \
 			    (long long) __right, #right,		       \
@@ -524,6 +532,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_binary_msg(test,					       \
 				(long long) __left, #left,		       \
 				(long long) __right, #right,		       \
@@ -538,6 +547,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_PTR_BINARY(test, left, condition, right) do {	       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_ptr_binary(test,					       \
 			    (void *) __left, #left,			       \
 			    (void *) __right, #right,			       \
@@ -553,6 +563,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 				    ...) do {				       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_ptr_binary_msg(test,				       \
 				    (void *) __left, #left,		       \
 				    (void *) __right, #right,		       \
@@ -1013,6 +1024,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_BINARY(test, left, condition, right) do {		       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_binary(test,					       \
 			    (long long) __left, #left,			       \
 			    (long long) __right, #right,		       \
@@ -1023,6 +1035,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_binary_msg(test,					       \
 				(long long) __left, #left,		       \
 				(long long) __right, #right,		       \
@@ -1037,6 +1050,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_PTR_BINARY(test, left, condition, right) do {	       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_ptr_binary(test,					       \
 				(void *) __left, #left,			       \
 				(void *) __right, #right,		       \
@@ -1051,6 +1065,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 				    fmt, ...) do {			       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_ptr_binary_msg(test,				       \
 				    (void *) __left, #left,		       \
 				    (void *) __right, #right,		       \
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

