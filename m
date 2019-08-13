Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77D8ABFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 02:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHMAd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 20:33:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42423 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHMAd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:33:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so12012pgb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zq6yHL2C60RwcDmlpshxa1wOQkUxi3yYyWuvX6Jr4HM=;
        b=namSPmDWPujc9+lfquW9m9ZpboLlU1GpXC90hrm7My2wALTeQGovCGeuZeoLPKDSjJ
         DPnzh7Y+F6ZapREAMTLVxQZrviv1eRlvHMlffAnktNPvtsaYfgv/HuEgBsY2QrOo0MZs
         nE5JrVUKP9CgWZePaSr61slKkLrb+gpW5RLUbSyHEZcmQpKomsq1IAcpf8aQcFR1ZzcC
         pbhJzddvNnULPjOfPycV2nj/vsXw3HM0ePAOrnoYPxMcKCNqqjXJyNERbNaXrHH4I6Qe
         8XEuxJNNe0v8zBXjNRU7Pd1TCUbPC3LGaWGg1bvuBHstTQGPVL0WQxCYeaoFZfNh0X+l
         HFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zq6yHL2C60RwcDmlpshxa1wOQkUxi3yYyWuvX6Jr4HM=;
        b=TN52UczjW7DWtn5tzhj6zxIuPGgP8lPDWPyxiGi+UPi833RNDh0DdOAjAJgrPP7/OR
         6WFElu8q1VVCtgVoynaVsbpIqsJof8fZ0LiFr0KfYAivvdiPvlx393tpP6oetErMUsBH
         czR6d2V+iFPqmNcL1ztTZgB3RD9yWXRgi5F5fEIbbHUDllt8gKtfZvK+u9YBl5Y8Qxca
         xXcwv9V3jvuRQOQf9JHImGnWhDaAHHcxa0J333b8UFSvOP/llZiRJR2lJWX4dfntqs8C
         US2JBBiS76pG0oGTnzbYRJhjS3IsXmQtBYlPYOS57TMeFyrIkZS8lSfVM0sRu3IZawh8
         i8oA==
X-Gm-Message-State: APjAAAXaBCb6oI8EnFNiCsRXDMqyT/XRXi8zzSrQVtSzaYKO3X/D+bOp
        Y41OAIbYQuhaajraJM3oz14eZQ==
X-Google-Smtp-Source: APXvYqzfHrFqfVRu0MgZ/V5gvwVgMJn7qSDV7sNF8V3DEvMYQp7KqAKffNLgf1l1YpJPVE1awdWI2Q==
X-Received: by 2002:a63:5402:: with SMTP id i2mr32378986pgb.414.1565656437536;
        Mon, 12 Aug 2019 17:33:57 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id 97sm661739pjz.12.2019.08.12.17.33.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 17:33:56 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:33:52 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
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
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
Message-ID: <20190813003352.GA235915@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
 <20190812235701.533E82063F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812235701.533E82063F@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:08)
> > Add support for expectations, which allow properties to be specified and
> > then verified in tests.
> > 
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> Just some minor nits again.
> 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index d0bf112910caf..2625bcfeb19ac 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -9,8 +9,10 @@
> >  #ifndef _KUNIT_TEST_H
> >  #define _KUNIT_TEST_H
> >  
> > +#include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/slab.h>
> > +#include <kunit/assert.h>
> 
> Can you alphabet sort these?

Sure. Will fix.

> >  
> >  struct kunit_resource;
> >  
> > @@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
> >  #define kunit_err(test, fmt, ...) \
> >                 kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> >  
> > +/*
> > + * Generates a compile-time warning in case of comparing incompatible types.
> > + */
> > +#define __kunit_typecheck(lhs, rhs) \
> > +       ((void) __typecheck(lhs, rhs))
> 
> Is there a reason why this can't be inlined and the __kunit_typecheck()
> macro can't be removed?

No real reason anymore. I used it in multiple places before and we
weren't sure if we wanted to stick with the warnings that __typecheck
produces long term, but now that it is only used in one place, I guess
that doesn't make sense anymore. Will fix.

> > +
> > +/**
> > + * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> > + * @test: The test context object.
> [...]
> > + * @condition: an arbitrary boolean expression. The test fails when this does
> > + * not evaluate to true.
> > + *
> > + * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
> > + * to fail when the specified condition is not met; however, it will not prevent
> > + * the test case from continuing to run; this is otherwise known as an
> > + * *expectation failure*.
> > + */
> > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> 
> A lot of these macros seem double indented.

In a case you pointed out in the preceding patch, I was just keeping the
arguments column aligned.

In this case I am just indenting two tabs for a line continuation. I
thought I found other instances in the kernel that did this early on
(and that's also what the Linux kernel vim plugin wanted me to do).
After a couple of spot checks, it seems like one tab for this kind of
line continuation seems more common. I personally don't feel strongly
about any particular version. I just want to know now what the correct
indentation is for macros before I go through and change them all.

I think there are three cases:

#define macro0(param0, param1) \
		a_really_long_macro(...)

In this first case, I use two tabs for the first indent, I think you are
telling me this should be one tab.

#define macro1(param0, param1) {					       \
	statement_in_a_block0;						       \
	statement_in_a_block1;						       \
	...								       \
}

In this case, every line is in a block and is indented as it would be in
a function body. I think you are okay with this, and now that I am
thinking about it, what I think you are proposing for macro0 will make
these two cases more consistent.

#define macro2(param0,							       \
	       param1,							       \
	       param2,							       \
	       param3,							       \
	       ...,							       \
	       paramn) ...						       \

In this last case, the body would be indented as in macro0, or macro1,
but the parameters passed into the macro are column aligned, consistent
with one of the acceptable ways of formatting function parameters that
don't fit on a single line.

In all cases, I put 1 space in between the closing parameter paren and
the line continuation `\`, if only one `\` is needed. Otherwise, I align
all the `\s` to the 80th column. Is this okay, or would you prefer that
I align them all to the 80th column, or something else?

> > +
> > +#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                      \
> > +               KUNIT_TRUE_MSG_ASSERTION(test,                                 \
> > +                                        KUNIT_EXPECTATION,                    \
> > +                                        condition,                            \
> > +                                        fmt,                                  \
> > +                                        ##__VA_ARGS__)
> > +
