Return-Path: <linux-fsdevel+bounces-782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CA7D008A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050371C208E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABF335CC;
	Thu, 19 Oct 2023 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3MxB/Rc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2632C9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 17:30:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58233138
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:30:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8a822508so1347521566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697736605; x=1698341405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAurVaDY4Y7iKpcdCWtd8DcvDhclHUigROPGt0DwP4I=;
        b=W3MxB/RcgWqrP0X6LIzTAA609jUI0QOm/pyOz3XJw3ND9NrTrVVlGGvQ0v00eOGfuR
         K71Quu7r/tZxj1OFYUFRkEdg56F2laXYmIWn37pWNmWDdMK+m+MpSbhUvv+Fdr8+NNtO
         ZYnYs8XVTrpQLhTX6c6J+o3Gz245BQfE2eOdUb4dV4xL+gIJE34VkZJ+iAGYai4cio+N
         LVaMlg6m9Fwomn9vb1f0T2qkCWJ6G9vsIhvnCf9AUJvaORVlp/++NVbQjv6pnHABUC4v
         rFKv4tjdf2Vnw/Tnudqk84I6VKZDg50bQoCb+vGeL5zrXB6W9l0WOqvwjxh0ZiNJiEXi
         QIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736605; x=1698341405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAurVaDY4Y7iKpcdCWtd8DcvDhclHUigROPGt0DwP4I=;
        b=cBdxIGXlLZ7cpmWzJYC1VbqZMUDhwakclYR6MlysSWJuqwahSCb63DlGnj2aq6WFIo
         fO4wwFRhYtSIXXIDg+faLHSmKgiicIWW0WF8OByw8rX3DvYEMCatRwNd/bgvPVNSLqSF
         5MwQYVYlf5vvPMaXv83VkfYt6nBfcsB8k0LqOPnjwyrj1P6sPIJb3e1wZlQsyDfL7k0J
         pK1keljmTglRMmJ0cQB4y4dv/CJN5gCotmC21fDhtOpt1WGyRZpmfnnxaa1w+FKIw9RR
         hZa7HTFcXdbhADsjAD7feqoz7f9ok/B34LPQRipZ3645wiVuopvEraH/H5Lc57VXMU4R
         tlaw==
X-Gm-Message-State: AOJu0Yw3SH4azOwIXnEI39loMLbrFDaVEzMOuJH0wGWmXbPldfXeJBtZ
	9+VKRMXeZ0nUkDFxzRNvdqQhmZfWFJMxnC/IUT+HwQ==
X-Google-Smtp-Source: AGHT+IHSZri8nXlKAjUkj+Rn1zxVvwP9rVjfWLt21urXdgubxJwwllu1ZEhXZeg6mDIzbPAa3WiOaM+FoK+uOXkcy60=
X-Received: by 2002:a17:907:3687:b0:9ae:57b8:ad1b with SMTP id
 bi7-20020a170907368700b009ae57b8ad1bmr2090783ejc.21.1697736605364; Thu, 19
 Oct 2023 10:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-4-surenb@google.com>
 <ZShzSvrN7FgdXi71@x1n> <CAJuCfpE2SmiF6C6xh93ruCxQd_rBK5Vb8jCpKT=y2LSdgHpjgQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE2SmiF6C6xh93ruCxQd_rBK5Vb8jCpKT=y2LSdgHpjgQ@mail.gmail.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 19 Oct 2023 10:29:27 -0700
Message-ID: <CAJHvVchpKHBBNYGYCiGmpHbax2_oKkmEoqE0NnY9ChowC+tPEA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/mm: add UFFDIO_MOVE ioctl test
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, david@redhat.com, hughd@google.com, mhocko@suse.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 8:43=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Oct 12, 2023 at 3:29=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Sun, Oct 08, 2023 at 11:42:28PM -0700, Suren Baghdasaryan wrote:
> > > Add a test for new UFFDIO_MOVE ioctl which uses uffd to move source
> > > into destination buffer while checking the contents of both after
> > > remapping. After the operation the content of the destination buffer
> > > should match the original source buffer's content while the source
> > > buffer should be zeroed.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-common.c     | 41 ++++++++++++-
> > >  tools/testing/selftests/mm/uffd-common.h     |  1 +
> > >  tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++=
++
> > >  3 files changed, 102 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing=
/selftests/mm/uffd-common.c
> > > index 02b89860e193..ecc1244f1c2b 100644
> > > --- a/tools/testing/selftests/mm/uffd-common.c
> > > +++ b/tools/testing/selftests/mm/uffd-common.c
> > > @@ -52,6 +52,13 @@ static int anon_allocate_area(void **alloc_area, b=
ool is_src)
> > >               *alloc_area =3D NULL;
> > >               return -errno;
> > >       }
> > > +
> > > +     /* Prevent source pages from collapsing into THPs */
> > > +     if (madvise(*alloc_area, nr_pages * page_size, MADV_NOHUGEPAGE)=
) {
> > > +             *alloc_area =3D NULL;
> > > +             return -errno;
> > > +     }
> >
> > Can we move this to test specific code?
>
> Ack. I think that's doable.
>
> >
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -484,8 +491,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg=
, struct uffd_args *args)
> > >               offset =3D (char *)(unsigned long)msg->arg.pagefault.ad=
dress - area_dst;
> > >               offset &=3D ~(page_size-1);
> > >
> > > -             if (copy_page(uffd, offset, args->apply_wp))
> > > -                     args->missing_faults++;
> > > +             /* UFFD_MOVE is supported for anon non-shared mappings.=
 */
> > > +             if (uffd_test_ops =3D=3D &anon_uffd_test_ops && !map_sh=
ared) {
> >
> > IIUC this means move_page() will start to run on many other tests... as
> > long as anonymous & private.  Probably not wanted, because not all test=
s
> > may need this MOVE test, and it also means UFFDIO_COPY is never tested =
on
> > anonymous..
> >
> > You can overwrite uffd_args.handle_fault().  Axel just added a hook whi=
ch
> > seems also usable here.  See 99aa77215ad02.
>
> Yes, I was thinking about adding a completely new set of tests for
> UFFDIO_MOVE but was not sure. With your confirmation I'll follow that
> path so that UFFDIO_COPY tests stay the same.
>
> >
> > > +                     if (move_page(uffd, offset))
> > > +                             args->missing_faults++;
> > > +             } else {
> > > +                     if (copy_page(uffd, offset, args->apply_wp))
> > > +                             args->missing_faults++;
> > > +             }
> > >       }
> > >  }
> > >
> > > @@ -620,6 +633,30 @@ int copy_page(int ufd, unsigned long offset, boo=
l wp)
> > >       return __copy_page(ufd, offset, false, wp);
> > >  }
> > >
> > > +int move_page(int ufd, unsigned long offset)
> > > +{
> > > +     struct uffdio_move uffdio_move;
> > > +
> > > +     if (offset >=3D nr_pages * page_size)
> > > +             err("unexpected offset %lu\n", offset);
> > > +     uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > > +     uffdio_move.src =3D (unsigned long) area_src + offset;
> > > +     uffdio_move.len =3D page_size;
> > > +     uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > > +     uffdio_move.move =3D 0;
> > > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > > +             /* real retval in uffdio_move.move */
> > > +             if (uffdio_move.move !=3D -EEXIST)
> > > +                     err("UFFDIO_MOVE error: %"PRId64,
> > > +                         (int64_t)uffdio_move.move);
> > > +             wake_range(ufd, uffdio_move.dst, page_size);
> > > +     } else if (uffdio_move.move !=3D page_size) {
> > > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.=
move);
> > > +     } else
> > > +             return 1;
> > > +     return 0;
> > > +}
> > > +
> > >  int uffd_open_dev(unsigned int flags)
> > >  {
> > >       int fd, uffd;
> > > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing=
/selftests/mm/uffd-common.h
> > > index 7c4fa964c3b0..f4d79e169a3d 100644
> > > --- a/tools/testing/selftests/mm/uffd-common.h
> > > +++ b/tools/testing/selftests/mm/uffd-common.h
> > > @@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bo=
ol wp);
> > >  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *=
args);
> > >  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
> > >  int copy_page(int ufd, unsigned long offset, bool wp);
> > > +int move_page(int ufd, unsigned long offset);
> > >  void *uffd_poll_thread(void *arg);
> > >
> > >  int uffd_open_dev(unsigned int flags);
> > > diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/tes=
ting/selftests/mm/uffd-unit-tests.c
> > > index 2709a34a39c5..f0ded3b34367 100644
> > > --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> > > +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> > > @@ -824,6 +824,10 @@ static void uffd_events_test_common(bool wp)
> > >       char c;
> > >       struct uffd_args args =3D { 0 };
> > >
> > > +     /* Prevent source pages from being mapped more than once */
> > > +     if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> > > +             err("madvise(MADV_DONTFORK) failed");
> >
> > Modifying events test is weird.. I assume you don't need this anymore a=
fter
> > you switch to the handle_fault() hook.
>
> I think so but let me try first and I'll get back on that.
>
> >
> > > +
> > >       fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> > >       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > >                         true, wp, false))
> > > @@ -1062,6 +1066,58 @@ static void uffd_poison_test(uffd_test_args_t =
*targs)
> > >       uffd_test_pass();
> > >  }
> > >
> > > +static void uffd_move_test(uffd_test_args_t *targs)
> > > +{
> > > +     unsigned long nr;
> > > +     pthread_t uffd_mon;
> > > +     char c;
> > > +     unsigned long long count;
> > > +     struct uffd_args args =3D { 0 };
> > > +
> > > +     if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > > +                       true, false, false))
> > > +             err("register failure");
> > > +
> > > +     if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> > > +             err("uffd_poll_thread create");
> > > +
> > > +     /*
> > > +      * Read each of the pages back using the UFFD-registered mappin=
g. We
> > > +      * expect that the first time we touch a page, it will result i=
n a missing
> > > +      * fault. uffd_poll_thread will resolve the fault by remapping =
source
> > > +      * page to destination.
> > > +      */
> > > +     for (nr =3D 0; nr < nr_pages; nr++) {
> > > +             /* Check area_src content */
> > > +             count =3D *area_count(area_src, nr);
> > > +             if (count !=3D count_verify[nr])
> > > +                     err("nr %lu source memory invalid %llu %llu\n",
> > > +                         nr, count, count_verify[nr]);
> > > +
> > > +             /* Faulting into area_dst should remap the page */
> > > +             count =3D *area_count(area_dst, nr);
> > > +             if (count !=3D count_verify[nr])
> > > +                     err("nr %lu memory corruption %llu %llu\n",
> > > +                         nr, count, count_verify[nr]);
> > > +
> > > +             /* Re-check area_src content which should be empty */
> > > +             count =3D *area_count(area_src, nr);
> > > +             if (count !=3D 0)
> > > +                     err("nr %lu move failed %llu %llu\n",
> > > +                         nr, count, count_verify[nr]);
> >
> > All of above should see zeros, right?  Because I don't think anyone boo=
sted
> > the counter at all..
> >
> > Maybe set some non-zero values to it?  Then the re-check can make more
> > sense.
>
> I thought uffd_test_ctx_init() is initializing area_count(area_src,
> nr), so the source pages should contain non-zero data before the move.
> Am I missing something?

You're correct, uffd_test_ctx_init() fills in some data in area_src.

>
> >
> > If you want, I think we can also make uffd-stress.c test to cover MOVE =
too,
> > basically replacing all UFFDIO_COPY when e.g. user specified from cmdli=
ne.
> > Optional, and may need some touch ups here and there, though.
>
> That's a good idea. I'll add that in the next version.
> Thanks,
> Suren.
>
> >
> > Thanks,
> >
> > > +     }
> > > +
> > > +     if (write(pipefd[1], &c, sizeof(c)) !=3D sizeof(c))
> > > +             err("pipe write");
> > > +     if (pthread_join(uffd_mon, NULL))
> > > +             err("join() failed");
> > > +
> > > +     if (args.missing_faults !=3D nr_pages || args.minor_faults !=3D=
 0)
> > > +             uffd_test_fail("stats check error");
> > > +     else
> > > +             uffd_test_pass();
> > > +}
> > > +
> > >  /*
> > >   * Test the returned uffdio_register.ioctls with different register =
modes.
> > >   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage t=
est.
> > > @@ -1139,6 +1195,12 @@ uffd_test_case_t uffd_tests[] =3D {
> > >               .mem_targets =3D MEM_ALL,
> > >               .uffd_feature_required =3D 0,
> > >       },
> > > +     {
> > > +             .name =3D "move",
> > > +             .uffd_fn =3D uffd_move_test,
> > > +             .mem_targets =3D MEM_ANON,
> > > +             .uffd_feature_required =3D UFFD_FEATURE_MOVE,
> > > +     },
> > >       {
> > >               .name =3D "wp-fork",
> > >               .uffd_fn =3D uffd_wp_fork_test,
> > > --
> > > 2.42.0.609.gbb76f46606-goog
> > >
> >
> > --
> > Peter Xu
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >

