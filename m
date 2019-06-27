Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6F57BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfF0GKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 02:10:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39235 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:10:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so679005pls.6;
        Wed, 26 Jun 2019 23:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZwcXPCGwZbn09o1uwc7hniPSeMrN6eJpmY4d6Wfxi5c=;
        b=nJUgXmKQ0n/tCSTXSwTOf323Ng7Vbr8non3mik66azIBefrY1hqPJ+fUw+0vF+W567
         Sbx3FqnthpQkLTYeqMaPlT9pcZgWb9K8gNefyjYZe6Q9YMfR/smySJvyY2XfXynGxBSD
         m/OBPEDLQg8o+rKByuBjvs8suB8HJ/ORwAbgHh771iUNV/GPQCTNNXYad005uKvyIQbJ
         R6rUs3GXBa/r38GotkXo3nqsP+CHlwZgejmhEO3yIN5wYmTe7woPDafzo9zB0Mh7zG2r
         2H2Kr4YxgQSD6CBZCarufQ3kWHT6gGp7aeF1nImzZ6BBjjH4FTQatMHOYXqctJwL67ky
         nYng==
X-Gm-Message-State: APjAAAV+kc7BHr4DW0XZTeWYCEBqZtl1G0r7lngNZt84ifZ2u/IdWc2I
        9lGAJRVThAFm5Tq17TA2bAw=
X-Google-Smtp-Source: APXvYqwfDFSlOkWhmFZzzgQYetrDxzZaKzvd9ZX5n/88iknHRTMqvTXQfyQDDioGRxixBQmy4Bo+mg==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr2593873plo.327.1561615831154;
        Wed, 26 Jun 2019 23:10:31 -0700 (PDT)
Received: from 42.do-not-panic.com ([157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u21sm1323644pfm.70.2019.06.26.23.10.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 23:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7944140256; Thu, 27 Jun 2019 06:10:21 +0000 (UTC)
Date:   Thu, 27 Jun 2019 06:10:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Iurii Zaikin <yzaikin@google.com>, linux-api@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, Stephen Boyd <sboyd@kernel.org>, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        David Rientjes <rientjes@google.com>, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190627061021.GE19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-18-brendanhiggins@google.com>
 <20190626021744.GU19023@42.do-not-panic.com>
 <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:07:43PM -0700, Iurii Zaikin wrote:
> On Tue, Jun 25, 2019 at 7:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > +static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = 0,
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     size_t len;
> > > +     loff_t pos;
> > > +
> > > +     len = 1234;
> > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > +     len = 1234;
> > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > +}
> >
> > In a way this is also testing for general kernel API changes. This is and the
> > last one were good examples. So this is not just testing functionality
> > here. There is no wrong or write answer if 0 or -EINVAL was returned
> > other than the fact that we have been doing this for years.
> >
> > Its a perhaps small but important difference for some of these tests.  I
> > *do* think its worth clarifying through documentation which ones are
> > testing for API consistency Vs proper correctness.
>
> You make a good point that the test codifies the existing behavior of
> the function in lieu of formal documentation.  However, the test cases
> were derived from examining the source code of the function under test
> and attempting to cover all branches. The assertions were added only
> for the values that appeared to be set deliberately in the
> implementation. And it makes sense to me to test that the code does
> exactly what the implementation author intended.

I'm not arguing against adding them. I'm suggesting that it is different
to test for API than for correctness of intended functionality, and
it would be wise to make it clear which test cases are for API and which
for correctness.

This will come up later for other kunit tests and it would be great
to set precendent so that other kunit tests can follow similar
practices to ensure its clear what is API realted Vs correctness of
intended functionality.

In fact, I'm not yet sure if its possible to test public kernel API to
userspace with kunit, but if it is possible... well, that could make
linux-api folks happy as they could enable us to codify interpreation of
what is expected into kunit test cases, and we'd ensure that the
codified interpretation is not only documented in man pages but also
through formal kunit test cases.

A regression in linux-api then could be formalized through a proper
kunit tests case. And if an API evolves, it would force developers to
update the respective kunit which codifies that contract.

> > > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = sizeof(int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     char input[32];
> > > +     size_t len = sizeof(input) - 1;
> > > +     loff_t pos = 0;
> > > +     unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > > +                                          - (INT_MAX + INT_MIN) + 1;
> > > +
> > > +     KUNIT_EXPECT_LT(test,
> > > +                     (size_t)snprintf(input, sizeof(input), "-%lu",
> > > +                                      abs_of_less_than_min),
> > > +                     sizeof(input));
> > > +
> > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > +}
> >
> > API test.
> >
> Not sure why.

Because you are codifying that we *definitely* return -EINVAL on
overlow. Some parts of the kernel return -ERANGE for overflows for
instance.

It would be a generic test for overflow if it would just test
for any error.

It is a fine and good test to keep. All these tests are good to keep.

> I believe there has been a real bug with int overflow in
> proc_dointvec.
> Covering it with test seems like a good idea.

Oh definitely.

> > > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = sizeof(int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     char input[32];
> > > +     size_t len = sizeof(input) - 1;
> > > +     loff_t pos = 0;
> > > +     unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > > +
> > > +     KUNIT_EXPECT_GT(test, greater_than_max, (unsigned long)INT_MAX);
> > > +     KUNIT_EXPECT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
> > > +                                            greater_than_max),
> > > +                     sizeof(input));
> > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > +}
> > > +
> >
> > API test.
> >
> > > +static struct kunit_case sysctl_test_cases[] = {
> > > +     KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > > +     KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > > +     KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > > +     {}
> > > +};
> >
> > Oh all are API tests.. perhaps then just rename then
> > sysctl_test_cases to sysctl_api_test_cases.
> >
> > Would be good to add at least *two* other tests cases for this
> > example, one which does a valid read and one which does a valid write.
> Added valid reads. There already are 2 valid writes.

Thanks.

> > If that is done either we add another kunit test module for correctness
> > or just extend the above and use prefix / postfixes on the functions
> > to distinguish between API / correctness somehow.
> >
> > > +
> > > +static struct kunit_module sysctl_test_module = {
> > > +     .name = "sysctl_test",
> > > +     .test_cases = sysctl_test_cases,
> > > +};
> > > +
> > > +module_test(sysctl_test_module);
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index cbdfae3798965..389b8986f5b77 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1939,6 +1939,16 @@ config TEST_SYSCTL
> > >
> > >         If unsure, say N.
> > >
> > > +config SYSCTL_KUNIT_TEST
> > > +     bool "KUnit test for sysctl"
> > > +     depends on KUNIT
> > > +     help
> > > +       This builds the proc sysctl unit test, which runs on boot. For more
> > > +       information on KUnit and unit tests in general please refer to the
> > > +       KUnit documentation in Documentation/dev-tools/kunit/.
> >
> > A little more description here would help. It is testing for API and
> > hopefully also correctness (if extended with those two examples I
> > mentioned).
> >
> Added "Tests the API contract and implementation correctness of sysctl."

Yes, much clearer, thanks!

  Luis

