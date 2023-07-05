Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC806748AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjGERvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjGERvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:51:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC271E57
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 10:51:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992ace062f3so836913866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688579470; x=1691171470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEI4v+2KKn+EkDZzdrBmikEj6qMvmv1XLjDpHecmTZc=;
        b=f5HN0rW/zmfb6pFzjhlVkLATVIc8CO9MM9qNTqXTMEchOXn4fIxtcz3Bx9eyCqCr2Z
         M5Z0iUelv4vCsc15ld58d/0zM9UUJWAwN+XIleuO4uVXGFuUytLSMFn2mcLd7qm+OYZ1
         txF0HDVGO4e0+Hr8h5AqLUey2XXij6T+Mts2sUaS2d97sVSzm9XURFST97gRUCjUd6ZN
         +Knu2ZIlBqLLoX3vOXvgJPO7sE0U6CsNwW92Su3zO87HD6GAacOyAX02RaADnRwZ3+j2
         m4p1oaf9lM/wlHWC1mrl0h9YdVrFcv8uLiTLvIrPNPSZf2hUt7l/wo4cEKxx+wobVv0G
         MoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688579470; x=1691171470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEI4v+2KKn+EkDZzdrBmikEj6qMvmv1XLjDpHecmTZc=;
        b=ltBtaciA8iNr4WSFnzEFxCo058mQiAFXIj1cg6DhdrylucTUUFYAIqbHhFWTYs5MsX
         pLmiIFuP9FuOhRESjuqFdDc9Hj5IlRWG+PEeZQ1KtbbivH6p5k7UtM8dvKfWZwUgxNAg
         mweST8mMboDQEedkrNOTJPgjuYq6TsFSLyhWH5SP2mvhz9F6fQIT2m/EE0oIImA9WtDz
         I14Zluwo8Lzx5dYF0vaNys2DeQrJIcOh5G7wFg/1n70zM7UrF2tIid1ny45r1VMGf+P/
         bzIO/oZbC0+ftTZdsEnxOjkmbW5dpchtmres4O3BMMRPyb/XdUMCCYn7fx3/s9yQ8mU2
         yDwQ==
X-Gm-Message-State: AC+VfDzRaVdVWFd4TiMQ8ce5HkCMkviljLPca5SN1L2eQUYdf1uGKP9q
        mfrGfbvrE07lTdewkZx0IWseTkUDuM0YFJSPX31PhA==
X-Google-Smtp-Source: APBJJlFTojzQ/aPODd2ghbLHceO/hDIk0cF+cNlCPev56yuRvsdr91pXNO6nCvO7/y6BChiKczWX+RHhutgcASJd0c4=
X-Received: by 2002:a17:906:f1d3:b0:978:6a95:512d with SMTP id
 gx19-20020a170906f1d300b009786a95512dmr11603991ejb.11.1688579470177; Wed, 05
 Jul 2023 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-4-axelrasmussen@google.com> <ZKSJNB3BbCiPxcdD@x1n>
In-Reply-To: <ZKSJNB3BbCiPxcdD@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 5 Jul 2023 10:50:34 -0700
Message-ID: <CAJHvVcjfrOU5PoSoh4n1O0tmr-2bsPzinHDW5OwhCh=egk=-uQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 4, 2023 at 2:03=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jun 29, 2023 at 01:50:38PM -0700, Axel Rasmussen wrote:
> > Previously, we had "one fault handler to rule them all", which used
> > several branches to deal with all of the scenarios required by all of
> > the various tests.
> >
> > In upcoming patches, I plan to add a new test, which has its own
> > slightly different fault handling logic. Instead of continuing to add
> > cruft to the existing fault handler, let's allow tests to define custom
> > ones, separate from other tests.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c |  5 ++++-
> >  tools/testing/selftests/mm/uffd-common.h |  3 +++
> >  tools/testing/selftests/mm/uffd-stress.c | 12 +++++++-----
> >  3 files changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index ba20d7504022..02b89860e193 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -499,6 +499,9 @@ void *uffd_poll_thread(void *arg)
> >       int ret;
> >       char tmp_chr;
> >
> > +     if (!args->handle_fault)
> > +             args->handle_fault =3D uffd_handle_page_fault;
> > +
> >       pollfd[0].fd =3D uffd;
> >       pollfd[0].events =3D POLLIN;
> >       pollfd[1].fd =3D pipefd[cpu*2];
> > @@ -527,7 +530,7 @@ void *uffd_poll_thread(void *arg)
> >                       err("unexpected msg event %u\n", msg.event);
> >                       break;
> >               case UFFD_EVENT_PAGEFAULT:
> > -                     uffd_handle_page_fault(&msg, args);
> > +                     args->handle_fault(&msg, args);
> >                       break;
> >               case UFFD_EVENT_FORK:
> >                       close(uffd);
> > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/s=
elftests/mm/uffd-common.h
> > index 197f5262fe0d..7c4fa964c3b0 100644
> > --- a/tools/testing/selftests/mm/uffd-common.h
> > +++ b/tools/testing/selftests/mm/uffd-common.h
> > @@ -77,6 +77,9 @@ struct uffd_args {
> >       unsigned long missing_faults;
> >       unsigned long wp_faults;
> >       unsigned long minor_faults;
> > +
> > +     /* A custom fault handler; defaults to uffd_handle_page_fault. */
> > +     void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args=
);
> >  };
> >
> >  struct uffd_test_ops {
> > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/s=
elftests/mm/uffd-stress.c
> > index 995ff13e74c7..50b1224d72c7 100644
> > --- a/tools/testing/selftests/mm/uffd-stress.c
> > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > @@ -189,10 +189,8 @@ static int stress(struct uffd_args *args)
> >                                  locking_thread, (void *)cpu))
> >                       return 1;
> >               if (bounces & BOUNCE_POLL) {
> > -                     if (pthread_create(&uffd_threads[cpu], &attr,
> > -                                        uffd_poll_thread,
> > -                                        (void *)&args[cpu]))
> > -                             return 1;
> > +                     if (pthread_create(&uffd_threads[cpu], &attr, uff=
d_poll_thread, &args[cpu]))
> > +                             err("uffd_poll_thread create");
>
> irrelevant change?

Right, I'll revert this. In an earlier version I had a more
substantial change here, and just didn't fully revert it.

>
> >               } else {
> >                       if (pthread_create(&uffd_threads[cpu], &attr,
> >                                          uffd_read_thread,
> > @@ -247,9 +245,13 @@ static int userfaultfd_stress(void)
> >  {
> >       void *area;
> >       unsigned long nr;
> > -     struct uffd_args args[nr_cpus];
> > +     struct uffd_args *args;
> >       uint64_t mem_size =3D nr_pages * page_size;
> >
> > +     args =3D calloc(nr_cpus, sizeof(struct uffd_args));
> > +     if (!args)
> > +             err("allocating args array failed");
> > +
>
> It's leaked?
>
> Isn't "args[] =3D { 0 }" already working?

That works, but GCC can warn in this case (-Wmissing-braces) depending
on the definition of struct uffd_args. I liked switching to calloc
because it avoids any possibility of that even as we add/remove things
to struct uffd_args in the future.

Since it's a selftest and this function is only called exactly once,
it didn't seem worth the code making certain we free it, instead just
leaving it to be cleaned up when the process exits.

>
> Thanks,
>
> >       if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
> >               err("context init failed");
> >
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
> --
> Peter Xu
>
