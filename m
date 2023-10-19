Return-Path: <linux-fsdevel+bounces-788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B601D7D0294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D681C20E97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCE39868;
	Thu, 19 Oct 2023 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSN0j0a9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB336AE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 19:33:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC340FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697744008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjYAtvDvXRjIix5kXoA10+zXT6ErSvL+h1IeZEyCdg=;
	b=KSN0j0a9weD3yvrwLIbZwPAPeYKTPIg7VxAXc/CvdI4wh+0bpMCkj9MM+Nmr+8MXq5xbdc
	wRLj1YunktAgxMnsE74RcGSzg1Ps3BZXwPVPLOy43oC9g7iAeaVeUNgJ6DReURG0jspfDw
	J1GlX59rNcemUzGkcNfTUUETuVLWzH0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-GRHWHeYgPSCO5C1zFnS_Sg-1; Thu, 19 Oct 2023 15:33:25 -0400
X-MC-Unique: GRHWHeYgPSCO5C1zFnS_Sg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65623d0075aso212476d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744004; x=1698348804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FjYAtvDvXRjIix5kXoA10+zXT6ErSvL+h1IeZEyCdg=;
        b=fjmbioC4o/jKvvwnEsuMI7JQxMeqYvQinS/QgwhqgrA6MGZlf0DTiaHn/g1OQAWVoI
         kswV50EAQ1L6OOH3lMIMHQCjo2+20q7w/QnmnoGadLZiFKr7nhUQmTEFe9JbDtvbbxvW
         cVUzXsuWQRBB7dbORE+nNI06c0XGSyQCcl0g7PofFY4zWyCwXHIDbl9OvESnoFAZAbN0
         Rm2bdTbIzRCNYr+WayCV3x8y/Rkt9GKv4pb9wtdoyk4qc4BWY4h655KF6I4X7FJ52kfT
         bsaLRlACvumjl+3gbj4rQFqeAF8xGKalYciEflMzz0aAVVQsTMPNXQ2HhbsihLKTU2ym
         04fA==
X-Gm-Message-State: AOJu0YzxVPRnUsA1M0lUIu+588Nz/nyo5RziG02Z4MEzC3unbDurKLa6
	yE2kOD0XbSPUlVUhaaZ2Ir2nmw/vQ5IsQGu4zseD1qfPq1uAfDZVuSxt10594bM5AFD3A1KTE/a
	I2+wx0Ha5SRibU+KL8J95h9Om6Q==
X-Received: by 2002:a0c:c3c4:0:b0:66d:264c:450f with SMTP id p4-20020a0cc3c4000000b0066d264c450fmr3372673qvi.0.1697744004336;
        Thu, 19 Oct 2023 12:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEySUVGYdiNI41djpnNt8DvZOKaaR+Ss0NZxR6LoARW1JHB7/096+uVjxmgd3k7TNVmtlmjLw==
X-Received: by 2002:a0c:c3c4:0:b0:66d:264c:450f with SMTP id p4-20020a0cc3c4000000b0066d264c450fmr3372648qvi.0.1697744003979;
        Thu, 19 Oct 2023 12:33:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id y3-20020ad457c3000000b0066d1e71e515sm86901qvx.113.2023.10.19.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:33:23 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:33:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, david@redhat.com,
	hughd@google.com, mhocko@suse.com, rppt@kernel.org,
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 3/3] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZTGEgR/L8ZmNvmkm@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-4-surenb@google.com>
 <ZShzSvrN7FgdXi71@x1n>
 <CAJuCfpE2SmiF6C6xh93ruCxQd_rBK5Vb8jCpKT=y2LSdgHpjgQ@mail.gmail.com>
 <CAJHvVchpKHBBNYGYCiGmpHbax2_oKkmEoqE0NnY9ChowC+tPEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVchpKHBBNYGYCiGmpHbax2_oKkmEoqE0NnY9ChowC+tPEA@mail.gmail.com>

On Thu, Oct 19, 2023 at 10:29:27AM -0700, Axel Rasmussen wrote:
> On Thu, Oct 19, 2023 at 8:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 3:29 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Sun, Oct 08, 2023 at 11:42:28PM -0700, Suren Baghdasaryan wrote:
> > > > Add a test for new UFFDIO_MOVE ioctl which uses uffd to move source
> > > > into destination buffer while checking the contents of both after
> > > > remapping. After the operation the content of the destination buffer
> > > > should match the original source buffer's content while the source
> > > > buffer should be zeroed.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  tools/testing/selftests/mm/uffd-common.c     | 41 ++++++++++++-
> > > >  tools/testing/selftests/mm/uffd-common.h     |  1 +
> > > >  tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++++
> > > >  3 files changed, 102 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> > > > index 02b89860e193..ecc1244f1c2b 100644
> > > > --- a/tools/testing/selftests/mm/uffd-common.c
> > > > +++ b/tools/testing/selftests/mm/uffd-common.c
> > > > @@ -52,6 +52,13 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
> > > >               *alloc_area = NULL;
> > > >               return -errno;
> > > >       }
> > > > +
> > > > +     /* Prevent source pages from collapsing into THPs */
> > > > +     if (madvise(*alloc_area, nr_pages * page_size, MADV_NOHUGEPAGE)) {
> > > > +             *alloc_area = NULL;
> > > > +             return -errno;
> > > > +     }
> > >
> > > Can we move this to test specific code?
> >
> > Ack. I think that's doable.
> >
> > >
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -484,8 +491,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
> > > >               offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
> > > >               offset &= ~(page_size-1);
> > > >
> > > > -             if (copy_page(uffd, offset, args->apply_wp))
> > > > -                     args->missing_faults++;
> > > > +             /* UFFD_MOVE is supported for anon non-shared mappings. */
> > > > +             if (uffd_test_ops == &anon_uffd_test_ops && !map_shared) {
> > >
> > > IIUC this means move_page() will start to run on many other tests... as
> > > long as anonymous & private.  Probably not wanted, because not all tests
> > > may need this MOVE test, and it also means UFFDIO_COPY is never tested on
> > > anonymous..
> > >
> > > You can overwrite uffd_args.handle_fault().  Axel just added a hook which
> > > seems also usable here.  See 99aa77215ad02.
> >
> > Yes, I was thinking about adding a completely new set of tests for
> > UFFDIO_MOVE but was not sure. With your confirmation I'll follow that
> > path so that UFFDIO_COPY tests stay the same.

Sounds good.

If you want you can also torture MOVE a bit with uffd-stress.c to do
bouncing test all with MOVE, may need a new option and some more code
changes, though.

> >
> > >
> > > > +                     if (move_page(uffd, offset))
> > > > +                             args->missing_faults++;
> > > > +             } else {
> > > > +                     if (copy_page(uffd, offset, args->apply_wp))
> > > > +                             args->missing_faults++;
> > > > +             }
> > > >       }
> > > >  }
> > > >
> > > > @@ -620,6 +633,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
> > > >       return __copy_page(ufd, offset, false, wp);
> > > >  }
> > > >
> > > > +int move_page(int ufd, unsigned long offset)
> > > > +{
> > > > +     struct uffdio_move uffdio_move;
> > > > +
> > > > +     if (offset >= nr_pages * page_size)
> > > > +             err("unexpected offset %lu\n", offset);
> > > > +     uffdio_move.dst = (unsigned long) area_dst + offset;
> > > > +     uffdio_move.src = (unsigned long) area_src + offset;
> > > > +     uffdio_move.len = page_size;
> > > > +     uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > > > +     uffdio_move.move = 0;
> > > > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > > > +             /* real retval in uffdio_move.move */
> > > > +             if (uffdio_move.move != -EEXIST)
> > > > +                     err("UFFDIO_MOVE error: %"PRId64,
> > > > +                         (int64_t)uffdio_move.move);
> > > > +             wake_range(ufd, uffdio_move.dst, page_size);
> > > > +     } else if (uffdio_move.move != page_size) {
> > > > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
> > > > +     } else
> > > > +             return 1;
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  int uffd_open_dev(unsigned int flags)
> > > >  {
> > > >       int fd, uffd;
> > > > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> > > > index 7c4fa964c3b0..f4d79e169a3d 100644
> > > > --- a/tools/testing/selftests/mm/uffd-common.h
> > > > +++ b/tools/testing/selftests/mm/uffd-common.h
> > > > @@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
> > > >  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
> > > >  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
> > > >  int copy_page(int ufd, unsigned long offset, bool wp);
> > > > +int move_page(int ufd, unsigned long offset);
> > > >  void *uffd_poll_thread(void *arg);
> > > >
> > > >  int uffd_open_dev(unsigned int flags);
> > > > diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> > > > index 2709a34a39c5..f0ded3b34367 100644
> > > > --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> > > > +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> > > > @@ -824,6 +824,10 @@ static void uffd_events_test_common(bool wp)
> > > >       char c;
> > > >       struct uffd_args args = { 0 };
> > > >
> > > > +     /* Prevent source pages from being mapped more than once */
> > > > +     if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> > > > +             err("madvise(MADV_DONTFORK) failed");
> > >
> > > Modifying events test is weird.. I assume you don't need this anymore after
> > > you switch to the handle_fault() hook.
> >
> > I think so but let me try first and I'll get back on that.
> >
> > >
> > > > +
> > > >       fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> > > >       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > > >                         true, wp, false))
> > > > @@ -1062,6 +1066,58 @@ static void uffd_poison_test(uffd_test_args_t *targs)
> > > >       uffd_test_pass();
> > > >  }
> > > >
> > > > +static void uffd_move_test(uffd_test_args_t *targs)
> > > > +{
> > > > +     unsigned long nr;
> > > > +     pthread_t uffd_mon;
> > > > +     char c;
> > > > +     unsigned long long count;
> > > > +     struct uffd_args args = { 0 };
> > > > +
> > > > +     if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > > > +                       true, false, false))
> > > > +             err("register failure");
> > > > +
> > > > +     if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> > > > +             err("uffd_poll_thread create");
> > > > +
> > > > +     /*
> > > > +      * Read each of the pages back using the UFFD-registered mapping. We
> > > > +      * expect that the first time we touch a page, it will result in a missing
> > > > +      * fault. uffd_poll_thread will resolve the fault by remapping source
> > > > +      * page to destination.
> > > > +      */
> > > > +     for (nr = 0; nr < nr_pages; nr++) {
> > > > +             /* Check area_src content */
> > > > +             count = *area_count(area_src, nr);
> > > > +             if (count != count_verify[nr])
> > > > +                     err("nr %lu source memory invalid %llu %llu\n",
> > > > +                         nr, count, count_verify[nr]);
> > > > +
> > > > +             /* Faulting into area_dst should remap the page */
> > > > +             count = *area_count(area_dst, nr);
> > > > +             if (count != count_verify[nr])
> > > > +                     err("nr %lu memory corruption %llu %llu\n",
> > > > +                         nr, count, count_verify[nr]);
> > > > +
> > > > +             /* Re-check area_src content which should be empty */
> > > > +             count = *area_count(area_src, nr);
> > > > +             if (count != 0)
> > > > +                     err("nr %lu move failed %llu %llu\n",
> > > > +                         nr, count, count_verify[nr]);
> > >
> > > All of above should see zeros, right?  Because I don't think anyone boosted
> > > the counter at all..
> > >
> > > Maybe set some non-zero values to it?  Then the re-check can make more
> > > sense.
> >
> > I thought uffd_test_ctx_init() is initializing area_count(area_src,
> > nr), so the source pages should contain non-zero data before the move.
> > Am I missing something?
> 
> You're correct, uffd_test_ctx_init() fills in some data in area_src.

Indeed.

> 
> >
> > >
> > > If you want, I think we can also make uffd-stress.c test to cover MOVE too,
> > > basically replacing all UFFDIO_COPY when e.g. user specified from cmdline.
> > > Optional, and may need some touch ups here and there, though.
> >
> > That's a good idea. I'll add that in the next version.
> > Thanks,
> > Suren.
> >
> > >
> > > Thanks,
> > >
> > > > +     }
> > > > +
> > > > +     if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> > > > +             err("pipe write");
> > > > +     if (pthread_join(uffd_mon, NULL))
> > > > +             err("join() failed");
> > > > +
> > > > +     if (args.missing_faults != nr_pages || args.minor_faults != 0)
> > > > +             uffd_test_fail("stats check error");
> > > > +     else
> > > > +             uffd_test_pass();
> > > > +}
> > > > +
> > > >  /*
> > > >   * Test the returned uffdio_register.ioctls with different register modes.
> > > >   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
> > > > @@ -1139,6 +1195,12 @@ uffd_test_case_t uffd_tests[] = {
> > > >               .mem_targets = MEM_ALL,
> > > >               .uffd_feature_required = 0,
> > > >       },
> > > > +     {
> > > > +             .name = "move",
> > > > +             .uffd_fn = uffd_move_test,
> > > > +             .mem_targets = MEM_ANON,
> > > > +             .uffd_feature_required = UFFD_FEATURE_MOVE,
> > > > +     },
> > > >       {
> > > >               .name = "wp-fork",
> > > >               .uffd_fn = uffd_wp_fork_test,
> > > > --
> > > > 2.42.0.609.gbb76f46606-goog
> > > >
> > >
> > > --
> > > Peter Xu
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
> 

-- 
Peter Xu


