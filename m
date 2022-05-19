Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1752DD8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 21:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiESTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbiESTOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 15:14:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DD111BAA
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 12:13:55 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e3so6746746ios.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/y06+DLzN/eyg4fXfBHtcLRTnFYxYLYCPqBTJsbH6s=;
        b=Hr7YTVx/XDlLAKxrqvGt3HM8lkbQ7yU2d3o62RUBreCJgrHoA8OSdL53fbQ3KLFiO2
         /1vHpfewwHUWgXcLIj3wMgTZ5sGELoRatnJpC5h8N64AtjuyzTrKNDDMAgk+T9w7cCeF
         Wg4EpROQ9lznY84WpbrXLJWghT/JB4bwz2w3PVWYuRB3zMZAcBIpkH5LdEYGfnVJpdOt
         BfSvIidMaMzxVrCEapVPuz5jtfaWcxAdLMsxpucS1Nk1ppff19DluwXMBAn4FJlGa24U
         mln4eXx0GXrxxAde1IcxQBsW5gzB/5zTgmkb5K81Vk8Gua1sTGxvoARNWc84yLIwalG9
         /3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/y06+DLzN/eyg4fXfBHtcLRTnFYxYLYCPqBTJsbH6s=;
        b=DrAP0/x7Fhptjymu0QqtM5zb9EvpO6rKSiBJngEQDhQxZioCt/FMhgtW+b0J9S1HBR
         tW9rsrE/Fcs0CevzPbWLMqK3NizAyqKAwo9Ei1AhZZ5eGP7obw9zC/LUqMIVKfdT+Cj4
         qcMAuiKe0281dKn4TTlw3u/8dWmXw7qQEbG1wqAIpptnopkYn4g9CtS/4AqI6bSF8UNY
         TMIQAmlywxigA6mqmiNPrjh/QwdeG56HMWsSAKnIgBdcgm3qRU5/k0ebYbrK5pwrY+Q+
         1gqEFa7w74mR4PprClzJNMMkVEtWk/xoBIyAU3+g5BlSN7GBAyJBzjBs4hsHjWj5Zw85
         2Yzg==
X-Gm-Message-State: AOAM530lCNNmbnm0mOeQU/rMZdFX09fWP1eekFvBPngxgzGVH2pqe16Z
        dJpllH/Wfy9IaTHmzbAtCx4utj9brISIfQenzq+pcg==
X-Google-Smtp-Source: ABdhPJy0GdftMdljZ/DggUvp858hbLHvZ0ZTwbMCuqHX0TPJ3QqmV+8xMprTqaPj1WirWbD9+n0Ce98OwaQRgHhTvhY=
X-Received: by 2002:a05:6638:1693:b0:32b:96d6:5fc0 with SMTP id
 f19-20020a056638169300b0032b96d65fc0mr3499533jat.167.1652987633996; Thu, 19
 May 2022 12:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-6-axelrasmussen@google.com> <bceb4b77-24fa-7654-0c59-fc858bea096a@linuxfoundation.org>
In-Reply-To: <bceb4b77-24fa-7654-0c59-fc858bea096a@linuxfoundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 19 May 2022 12:13:18 -0700
Message-ID: <CAJHvVcj8FnOAQ7HqrgiXiN+k2=XbXPerLZy6QBG1mDMW3=7ewA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] userfaultfd: selftests: make /dev/userfaultfd
 testing configurable
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:56 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> > Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> > let the user choose which to test.
> >
> > As with other test features, change the behavior based on a new
> > command line flag. Introduce the idea of "test mods", which are
> > generic (not specific to a test type) modifications to the behavior of
> > the test. This is sort of borrowed from this RFC patch series [1], but
> > simplified a bit.
> >
> > The benefit is, in "typical" configurations this test is somewhat slow
> > (say, 30sec or something). Testing both clearly doubles it, so it may
> > not always be desirable, as users are likely to use one or the other,
> > but never both, in the "real world".
> >
> > [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >   tools/testing/selftests/vm/userfaultfd.c | 41 +++++++++++++++++-------
> >   1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 12ae742a9981..274522704e40 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -142,8 +142,17 @@ static void usage(void)
> >   {
> >       fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
> >               "[hugetlbfs_file]\n\n");
> > +
>
> Remove the extra blank line here.
>
> >       fprintf(stderr, "Supported <test type>: anon, hugetlb, "
> >               "hugetlb_shared, shmem\n\n");
> > +
>
> Remove the extra blank line here.
>
> > +     fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
> > +             "Supported mods:\n");
> > +     fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
> > +     fprintf(stderr, "\nExample test mod usage:\n");
> > +     fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
> > +     fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
> > +
> >       fprintf(stderr, "Examples:\n\n");
> >       fprintf(stderr, "%s", examples);
>
> Update examples above with new test cases if any.

Will fix the above comments in v3.

>
> >       exit(1);
> > @@ -1610,8 +1619,6 @@ unsigned long default_huge_page_size(void)
> >
> >   static void set_test_type(const char *type)
> >   {
> > -     uint64_t features = UFFD_API_FEATURES;
> > -
> >       if (!strcmp(type, "anon")) {
> >               test_type = TEST_ANON;
> >               uffd_test_ops = &anon_uffd_test_ops;
> > @@ -1631,10 +1638,28 @@ static void set_test_type(const char *type)
> >               test_type = TEST_SHMEM;
> >               uffd_test_ops = &shmem_uffd_test_ops;
> >               test_uffdio_minor = true;
> > -     } else {
> > -             err("Unknown test type: %s", type);
> > +     }
>
> At this point, it might make it so much easier and maintainable if
> we were to use getopt instead of parsing options.

Agreed, I'd like that as well. But, since it's a bigger refactor that
affects all test types, I think it may be cleaner to leave it for a
follow-up series.

>
> > +}
> > +
> > +static void parse_test_type_arg(const char *raw_type)
> > +{
> > +     char *buf = strdup(raw_type);
> > +     uint64_t features = UFFD_API_FEATURES;
> > +
> > +     while (buf) {
> > +             const char *token = strsep(&buf, ":");
> > +
> > +             if (!test_type)
> > +                     set_test_type(token);
> > +             else if (!strcmp(token, "dev"))
> > +                     test_dev_userfaultfd = true;
> > +             else
> > +                     err("unrecognized test mod '%s'", token);
> >       }
> >
> > +     if (!test_type)
> > +             err("failed to parse test type argument: '%s'", raw_type);
> > +
> >       if (test_type == TEST_HUGETLB)
> >               page_size = default_huge_page_size();
> >       else
> > @@ -1681,7 +1706,7 @@ int main(int argc, char **argv)
> >               err("failed to arm SIGALRM");
> >       alarm(ALARM_INTERVAL_SECS);
> >
> > -     set_test_type(argv[1]);
> > +     parse_test_type_arg(argv[1]);
> >
> >       nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> >       nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
> > @@ -1719,12 +1744,6 @@ int main(int argc, char **argv)
> >       }
> >       printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
> >              nr_pages, nr_pages_per_cpu);
> > -
> > -     test_dev_userfaultfd = false;
> > -     if (userfaultfd_stress())
> > -             return 1;
> > -
> > -     test_dev_userfaultfd = true;
> >       return userfaultfd_stress();
> >   }
> >
> >
>
> Same comments as before on fail vs. skip conditions to watch out
> for and report them correctly.

I think in v3 things will be correct. Basically, in the skip cases we
just exit(KSFT_SKIP) directly, instead of relying on the return value
here. I'll take a pass and double check though before sending v3.

>
> thanks,
> -- Shuah
>
