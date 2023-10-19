Return-Path: <linux-fsdevel+bounces-772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49257CFE7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A71C20E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7982315B3;
	Thu, 19 Oct 2023 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSjlhChO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96230FB0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:43:38 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5217CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:43:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9cb74cf53fso753759276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697730201; x=1698335001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DPDsfu8aU8LPZp5ceCevOLz2QIEW4bMfW3ekc28nuA=;
        b=MSjlhChOw4FdF/DM8FPldM0IDkJxUbF7VdpGVfrvKcwpzMtKbk1qXfgsT34zMEIG0p
         aaBKrfX0VVJxLHEBtTauHPJzcWeQUGQjnblyuwfMSUiwWGKS6OhJ5iI9Vqe+u98aKzuM
         ktVCsooA8pPo8j2+gTNPjF1LjalT/yrpKiG0Jss3/5wU5MreBHpwoAYw9oaERtTkX3ce
         eIzWDeislL9Yqb67L3t3Mo3WdhYcbNIze0IgS8OiUyBKZ9TIXKFqODt3vaac5vdl9a+O
         k+XHmiIuCW3JZXlzWi+GNtuUimq5cxjZjmciUKWlWEbBpvXjUjr/SOzBIPtg+IvrkA8l
         XQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730201; x=1698335001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DPDsfu8aU8LPZp5ceCevOLz2QIEW4bMfW3ekc28nuA=;
        b=PrEnHSTcJeailRCms2B5oyRd7ZaMOKzZBp7d1kcKfk7O+Ss6Os4COy0YGX4F0W2QrV
         Z05kNzB5XmCCliwL4Ss5tOh7AzdgQ57mPqz+5aGNE+UQmL0hml4zPm1AKD3q7RI7n5EB
         4+tsCUCjOfrBAeqVrki9FV+wu0NQp2SFIIyokzq82w9dIeQdK9i4AuVT1LG8WHEHAmbd
         g63C8c5w1BLRdn2VyNUMfKNdnYoLv76IdyjgAoYi8lfnM84GnXuUMD1oGxmXoo/P2oR9
         yWdiJTxDLbl3zvGosdngGGlSOKAtqha4MWbJ60LebUHCGumXzVDRgf6AAOUBsyxtCa/i
         /8lw==
X-Gm-Message-State: AOJu0Yy6c0XKykDYBF+66GNjF4c/qf/oz5F8u2S+jUHMbQohaEzrRPLv
	9BGibBPgGjz2bM918Y3PmQqrFTx9WNCnFjnlUjdbaw==
X-Google-Smtp-Source: AGHT+IHe28QnWKSdMzGbZBpSd2uD/FXtVN47Cyko18LnBywC9KLnDTZu5KY3QtF/uku8HpgQF5dunHQMdDre0XAaHhs=
X-Received: by 2002:a05:6902:302:b0:d9b:6c9d:e6a with SMTP id
 b2-20020a056902030200b00d9b6c9d0e6amr2644471ybs.0.1697730200564; Thu, 19 Oct
 2023 08:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-4-surenb@google.com>
 <ZShzSvrN7FgdXi71@x1n>
In-Reply-To: <ZShzSvrN7FgdXi71@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Oct 2023 08:43:07 -0700
Message-ID: <CAJuCfpE2SmiF6C6xh93ruCxQd_rBK5Vb8jCpKT=y2LSdgHpjgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/mm: add UFFDIO_MOVE ioctl test
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 3:29=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Sun, Oct 08, 2023 at 11:42:28PM -0700, Suren Baghdasaryan wrote:
> > Add a test for new UFFDIO_MOVE ioctl which uses uffd to move source
> > into destination buffer while checking the contents of both after
> > remapping. After the operation the content of the destination buffer
> > should match the original source buffer's content while the source
> > buffer should be zeroed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     | 41 ++++++++++++-
> >  tools/testing/selftests/mm/uffd-common.h     |  1 +
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++++
> >  3 files changed, 102 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index 02b89860e193..ecc1244f1c2b 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -52,6 +52,13 @@ static int anon_allocate_area(void **alloc_area, boo=
l is_src)
> >               *alloc_area =3D NULL;
> >               return -errno;
> >       }
> > +
> > +     /* Prevent source pages from collapsing into THPs */
> > +     if (madvise(*alloc_area, nr_pages * page_size, MADV_NOHUGEPAGE)) =
{
> > +             *alloc_area =3D NULL;
> > +             return -errno;
> > +     }
>
> Can we move this to test specific code?

Ack. I think that's doable.

>
> > +
> >       return 0;
> >  }
> >
> > @@ -484,8 +491,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, =
struct uffd_args *args)
> >               offset =3D (char *)(unsigned long)msg->arg.pagefault.addr=
ess - area_dst;
> >               offset &=3D ~(page_size-1);
> >
> > -             if (copy_page(uffd, offset, args->apply_wp))
> > -                     args->missing_faults++;
> > +             /* UFFD_MOVE is supported for anon non-shared mappings. *=
/
> > +             if (uffd_test_ops =3D=3D &anon_uffd_test_ops && !map_shar=
ed) {
>
> IIUC this means move_page() will start to run on many other tests... as
> long as anonymous & private.  Probably not wanted, because not all tests
> may need this MOVE test, and it also means UFFDIO_COPY is never tested on
> anonymous..
>
> You can overwrite uffd_args.handle_fault().  Axel just added a hook which
> seems also usable here.  See 99aa77215ad02.

Yes, I was thinking about adding a completely new set of tests for
UFFDIO_MOVE but was not sure. With your confirmation I'll follow that
path so that UFFDIO_COPY tests stay the same.

>
> > +                     if (move_page(uffd, offset))
> > +                             args->missing_faults++;
> > +             } else {
> > +                     if (copy_page(uffd, offset, args->apply_wp))
> > +                             args->missing_faults++;
> > +             }
> >       }
> >  }
> >
> > @@ -620,6 +633,30 @@ int copy_page(int ufd, unsigned long offset, bool =
wp)
> >       return __copy_page(ufd, offset, false, wp);
> >  }
> >
> > +int move_page(int ufd, unsigned long offset)
> > +{
> > +     struct uffdio_move uffdio_move;
> > +
> > +     if (offset >=3D nr_pages * page_size)
> > +             err("unexpected offset %lu\n", offset);
> > +     uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > +     uffdio_move.src =3D (unsigned long) area_src + offset;
> > +     uffdio_move.len =3D page_size;
> > +     uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > +     uffdio_move.move =3D 0;
> > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > +             /* real retval in uffdio_move.move */
> > +             if (uffdio_move.move !=3D -EEXIST)
> > +                     err("UFFDIO_MOVE error: %"PRId64,
> > +                         (int64_t)uffdio_move.move);
> > +             wake_range(ufd, uffdio_move.dst, page_size);
> > +     } else if (uffdio_move.move !=3D page_size) {
> > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.mo=
ve);
> > +     } else
> > +             return 1;
> > +     return 0;
> > +}
> > +
> >  int uffd_open_dev(unsigned int flags)
> >  {
> >       int fd, uffd;
> > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/s=
elftests/mm/uffd-common.h
> > index 7c4fa964c3b0..f4d79e169a3d 100644
> > --- a/tools/testing/selftests/mm/uffd-common.h
> > +++ b/tools/testing/selftests/mm/uffd-common.h
> > @@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool=
 wp);
> >  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *ar=
gs);
> >  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
> >  int copy_page(int ufd, unsigned long offset, bool wp);
> > +int move_page(int ufd, unsigned long offset);
> >  void *uffd_poll_thread(void *arg);
> >
> >  int uffd_open_dev(unsigned int flags);
> > diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testi=
ng/selftests/mm/uffd-unit-tests.c
> > index 2709a34a39c5..f0ded3b34367 100644
> > --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> > +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> > @@ -824,6 +824,10 @@ static void uffd_events_test_common(bool wp)
> >       char c;
> >       struct uffd_args args =3D { 0 };
> >
> > +     /* Prevent source pages from being mapped more than once */
> > +     if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> > +             err("madvise(MADV_DONTFORK) failed");
>
> Modifying events test is weird.. I assume you don't need this anymore aft=
er
> you switch to the handle_fault() hook.

I think so but let me try first and I'll get back on that.

>
> > +
> >       fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> >       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> >                         true, wp, false))
> > @@ -1062,6 +1066,58 @@ static void uffd_poison_test(uffd_test_args_t *t=
args)
> >       uffd_test_pass();
> >  }
> >
> > +static void uffd_move_test(uffd_test_args_t *targs)
> > +{
> > +     unsigned long nr;
> > +     pthread_t uffd_mon;
> > +     char c;
> > +     unsigned long long count;
> > +     struct uffd_args args =3D { 0 };
> > +
> > +     if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > +                       true, false, false))
> > +             err("register failure");
> > +
> > +     if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> > +             err("uffd_poll_thread create");
> > +
> > +     /*
> > +      * Read each of the pages back using the UFFD-registered mapping.=
 We
> > +      * expect that the first time we touch a page, it will result in =
a missing
> > +      * fault. uffd_poll_thread will resolve the fault by remapping so=
urce
> > +      * page to destination.
> > +      */
> > +     for (nr =3D 0; nr < nr_pages; nr++) {
> > +             /* Check area_src content */
> > +             count =3D *area_count(area_src, nr);
> > +             if (count !=3D count_verify[nr])
> > +                     err("nr %lu source memory invalid %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
> > +
> > +             /* Faulting into area_dst should remap the page */
> > +             count =3D *area_count(area_dst, nr);
> > +             if (count !=3D count_verify[nr])
> > +                     err("nr %lu memory corruption %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
> > +
> > +             /* Re-check area_src content which should be empty */
> > +             count =3D *area_count(area_src, nr);
> > +             if (count !=3D 0)
> > +                     err("nr %lu move failed %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
>
> All of above should see zeros, right?  Because I don't think anyone boost=
ed
> the counter at all..
>
> Maybe set some non-zero values to it?  Then the re-check can make more
> sense.

I thought uffd_test_ctx_init() is initializing area_count(area_src,
nr), so the source pages should contain non-zero data before the move.
Am I missing something?

>
> If you want, I think we can also make uffd-stress.c test to cover MOVE to=
o,
> basically replacing all UFFDIO_COPY when e.g. user specified from cmdline=
.
> Optional, and may need some touch ups here and there, though.

That's a good idea. I'll add that in the next version.
Thanks,
Suren.

>
> Thanks,
>
> > +     }
> > +
> > +     if (write(pipefd[1], &c, sizeof(c)) !=3D sizeof(c))
> > +             err("pipe write");
> > +     if (pthread_join(uffd_mon, NULL))
> > +             err("join() failed");
> > +
> > +     if (args.missing_faults !=3D nr_pages || args.minor_faults !=3D 0=
)
> > +             uffd_test_fail("stats check error");
> > +     else
> > +             uffd_test_pass();
> > +}
> > +
> >  /*
> >   * Test the returned uffdio_register.ioctls with different register mo=
des.
> >   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage tes=
t.
> > @@ -1139,6 +1195,12 @@ uffd_test_case_t uffd_tests[] =3D {
> >               .mem_targets =3D MEM_ALL,
> >               .uffd_feature_required =3D 0,
> >       },
> > +     {
> > +             .name =3D "move",
> > +             .uffd_fn =3D uffd_move_test,
> > +             .mem_targets =3D MEM_ANON,
> > +             .uffd_feature_required =3D UFFD_FEATURE_MOVE,
> > +     },
> >       {
> >               .name =3D "wp-fork",
> >               .uffd_fn =3D uffd_wp_fork_test,
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

