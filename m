Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8936932
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFFBaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:30:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46975 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFFBaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:30:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so577420wrw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 18:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpGCO041Tg4SdQTzukwjDvK5uvTmFYR2PFl3r1dL9b8=;
        b=ejvHIsk4euV0ppc0epTzvVzKP6ja3YamlfuEnsYOlwGiRDpcKsu5blj9KswKc1lmHk
         FlHNai9oKCPDuqXa7TJVSlPeiKK3R0r+zHaoc0/vO+KgoYHspMWlx28mglyIxvgpaPHe
         hzizJY3TdPzpNMvRO3GLuNa2Z3bBIyLELT3tU3Ha3njuSlNB+l7YFoEZJGWDICks22rP
         Qed1+wFLqO11s+sVV1ovH/1qQeWozeg+0PR8715Yw5GgkDw0trU7l6zXsnXOhVJDNEMj
         aMz3quLWYhYCfEO9JKtWdOPTQc+vfT1SWWx3gQh089h7Li6omjAeHLZGPGCeWfbJrYgP
         eqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpGCO041Tg4SdQTzukwjDvK5uvTmFYR2PFl3r1dL9b8=;
        b=h5vd/nJZ5UPjwP7BnoVDSTVGAw2ij1jekEz5xnrjQERoavO+BlSBzkJsSP1SPld1J1
         TzR6d8/ywi7N1HGre8MCKPgPYrosC/zMBqo2z7idIAaZEhu/2QyP0WChIWsJr1ZKckY+
         T0KsdpnU033RI1dJfpd8HAsl9SUAKImFAGIsd33v3uzFPwA5VhcT7KXHMAtG0aSbuF0g
         wauPKgvUnOTNMYYGH3OkycwX9p43TgfhQxgq5JIO656QypOUwc8Gw7khZKpix/PfYycR
         rlZTVuFGQMyQBa1/uQSOnnAH2R4DW8M1D88z/2i3kqQdHL0wr8zL3RNwhW5J4EIhB5jk
         Mqhw==
X-Gm-Message-State: APjAAAXyrwoG31SZoI7RUXc/0FbzcamFXeDx+LYjAcqarQUJL7/Q4Zh9
        SwW/VOBZziDvHteF4nwwpnWX8dlIso78rF00eerj
X-Google-Smtp-Source: APXvYqwxpKa2J21eVqy9vuAUqWSndFyq+8Hj5f1fxZf/oyQGr75L3YoqW8zROuipuK2Zrr7VCYmxZRrq/mq2BI+GwQw=
X-Received: by 2002:adf:e352:: with SMTP id n18mr4855529wrj.82.1559784619871;
 Wed, 05 Jun 2019 18:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com> <20190517182254.548EA20815@mail.kernel.org>
In-Reply-To: <20190517182254.548EA20815@mail.kernel.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 5 Jun 2019 18:29:42 -0700
Message-ID: <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:17:10)
> > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > new file mode 100644
> > index 0000000000000..fe0f2bae66085
> > --- /dev/null
> > +++ b/kernel/sysctl-test.c
> > @@ -0,0 +1,293 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test of proc sysctl.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/printk.h>
>
> Is this include used?
  Deleted.
>
> > +#include <linux/sysctl.h>
> > +#include <linux/uaccess.h>
>
> Is this include used?
Deleted.
>
> > +
> > +
> > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[] = "-9";
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
>
> Is the casting necessary? Or can the macro do a type coercion of the
> second parameter based on the first type?
 Data field is defined as void* so I believe casting is necessary to
dereference it as a pointer to an array of ints. I don't think the
macro should do any type coercion that == operator wouldn't do.
 I did change the cast to make it more clear that it's a pointer to an
array of ints being dereferenced.
>
> > +}
> > +
> > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[32];
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +       unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > +                                            - (INT_MAX + INT_MIN) + 1;
> > +
> > +       KUNIT_EXPECT_LT(test,
> > +                       snprintf(input, sizeof(input), "-%lu",
> > +                                abs_of_less_than_min),
> > +                       sizeof(input));
> > +
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                       proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> > +}
> > +
> > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[32];
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +       unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > +
> > +       KUNIT_EXPECT_GT(test, greater_than_max, INT_MAX);
> > +       KUNIT_EXPECT_LT(test, snprintf(input, sizeof(input), "%lu",
> > +                                      greater_than_max),
> > +                       sizeof(input));
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                       proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> > +}
> > +
> > +static int sysctl_test_init(struct kunit *test)
> > +{
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This is run once after each test case, see the comment on example_test_module
> > + * for more information.
> > + */
> > +static void sysctl_test_exit(struct kunit *test)
> > +{
> > +}
> Can the above two be omitted? If they can be empty sometimes it would be
> nice to avoid the extra symbols and code by letting them be assigned to
> NULL in the kunit_module.
 Deleted.
>
> > +
> > +/*
> > + * Here we make a list of all the test cases we want to add to the test module
> > + * below.
> > + */
> > +static struct kunit_case sysctl_test_cases[] = {
> > +       /*
> > +        * This is a helper to create a test case object from a test case
> > +        * function; its exact function is not important to understand how to
> > +        * use KUnit, just know that this is how you associate test cases with a
> > +        * test module.
> > +        */
> > +       KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > +       KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > +       KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > +       KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > +       KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > +       {},
> > +};
> > +
> > +/*
> > + * This defines a suite or grouping of tests.
> > + *
> > + * Test cases are defined as belonging to the suite by adding them to
> > + * `test_cases`.
> > + *
> > + * Often it is desirable to run some function which will set up things which
> > + * will be used by every test; this is accomplished with an `init` function
> > + * which runs before each test case is invoked. Similarly, an `exit` function
> > + * may be specified which runs after every test case and can be used to for
> > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > + *
> > + * module.init(test);
> > + * module.test_case[0](test);
> > + * module.exit(test);
> > + * module.init(test);
> > + * module.test_case[1](test);
> > + * module.exit(test);
> > + * ...;
>
> This comment (and the one above for "this is a helper") looks generic
> and should probably only be in some documentation somewhere and not for
> a sysctl test?
>
Deleted.
> > + */
> > +static struct kunit_module sysctl_test_module = {
> > +       .name = "sysctl_test",
> > +       .init = sysctl_test_init,
> > +       .exit = sysctl_test_exit,
> > +       .test_cases = sysctl_test_cases,
> > +};
> > +
> > +/*
> > + * This registers the above test module telling KUnit that this is a suite of
> > + * tests that need to be run.
> > + */
>
> Same comment about generic comment.
>
Deleted.
> > +module_test(sysctl_test_module);
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d5a4a4036d2f8..772af4ec70111 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1908,6 +1908,12 @@ config TEST_SYSCTL
> >
> >           If unsure, say N.
> >
> > +config SYSCTL_KUNIT_TEST
> > +       bool "KUnit test for sysctl"
>
> Why not tristate?
>
I don't believe KUnit as a module is currently supported.
> > +       depends on KUNIT
> > +       help
> > +         Enables KUnit sysctl test.
> > +
