Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52877BF07D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 03:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379388AbjJJBtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379375AbjJJBtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:49:51 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A869F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 18:49:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a505762c9dso63483797b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696902587; x=1697507387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq3aYBssSknCkELoDWL5PONaJce6offpoVO2OC5YbY0=;
        b=bpSA1VLhlw5jjQub43JPpykYIBsjO9ylgy3lSoIATzwr148A1ze5tzehAYKJRBb5Eu
         EJCXBbGRoiqqWvKeIFmrdaDKnfnl8iAaG69NQIlIeVcMffY18UbSdQ0iAp/SHMVp4jPH
         XXPpT8oGSIF9mvhaph4kPQUOvuS7yyf6Gx3V7eSwISxGt67UNmeAt4xPJ2EbFasytu6J
         d0UY6Xpx1urkjc+6KnOYHhJfvo6OE0thX9OapWxZAQmW8KiDoDLp7YACFERsYkFyNTyy
         ajh8DZ0mWi8DbYZ4uPhBrGGXyMG1I21WOlasY8FgxMDIdrYMCi/M02dxPZ+9EJvnhUOD
         k4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696902587; x=1697507387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq3aYBssSknCkELoDWL5PONaJce6offpoVO2OC5YbY0=;
        b=mbi7UjWh7rrSRareL6Omtlf16aIswywTjhZU24rRJkFlV4eOFkCZTbMtMGJDm0Xizo
         dcN0/Iz7pPi3U28SmTcJHL6pqhUZpdG7W4Rt9gjZ3bdoZw+BH2r3voMsbu9+xxgcpNx3
         bxt3bNdFHtrUPJljJgTw1cUy9+PNNXpTGNI2sd0kIC5m2VOv/kUr82RprKRFkpPOzNwW
         +HF/1bupNJ82RrkfKiCjyqlHMxkOD/REXie78xv3FRD/XBxI9dLZIU7UV3iWXX9R5jO+
         2iF2518wT3HavbXSSs6RZBPZ06VV57OjDpBvaGrh2EtYNbRiVDyjygRjZm8z5QUs4Btz
         vElA==
X-Gm-Message-State: AOJu0Yw/zicTaEheFlnE80W08Tyj94BW9d8mvK6UbIVziBF7HZZDg/1e
        9pL59S3BzHlqvZOq1tXncSFy2wK8kezpfo6h0NG8YQ==
X-Google-Smtp-Source: AGHT+IF1wzf0z81f9XNeq7rMtn3vscHxfdIyiAWjbj9uunHLA7KUVtOoWE/ISwjSWxumTn33b/64kTrbRsvxcQHvgQw=
X-Received: by 2002:a81:9182:0:b0:59c:6ef:cd55 with SMTP id
 i124-20020a819182000000b0059c06efcd55mr18343288ywg.8.1696902587307; Mon, 09
 Oct 2023 18:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com> <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com> <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <CA+EESO47LqwMwGgkHQdx1cBdcn_+FWqda8OPcBU-skk9yML_qA@mail.gmail.com>
In-Reply-To: <CA+EESO47LqwMwGgkHQdx1cBdcn_+FWqda8OPcBU-skk9yML_qA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 Oct 2023 01:49:36 +0000
Message-ID: <CAJuCfpH9hBRnUM1S8NL=QDwfn227uyz4ZYPxRYngG=WNKkCk2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 9, 2023 at 5:57=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Mon, Oct 9, 2023 at 9:29=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
> >
> > On Mon, Oct 9, 2023 at 5:24=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> > >
> > > On 09.10.23 18:21, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 9, 2023 at 7:38=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> > > >>
> > > >> On 09.10.23 08:42, Suren Baghdasaryan wrote:
> > > >>> From: Andrea Arcangeli <aarcange@redhat.com>
> > > >>>
> > > >>> Implement the uABI of UFFDIO_MOVE ioctl.
> > > >>> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the applic=
ation
> > > >>> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pa=
ges are
> > > >>> available (in userspace) for recycling, as is usually the case in=
 heap
> > > >>> compaction algorithms, then we can avoid the page allocation and =
memcpy
> > > >>> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> > > >>> userspace, we avoid the need to release (via madvise) the pages b=
ack to
> > > >>> the kernel [2].
> > > >>> We see over 40% reduction (on a Google pixel 6 device) in the com=
pacting
> > > >>> thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_=
COPY. This was
> > > >>> measured using a benchmark that emulates a heap compaction implem=
entation
> > > >>> using userfaultfd (to allow concurrent accesses by application th=
reads).
> > > >>> More details of the usecase are explained in [2].
> > > >>> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> > > >>> touching them within the same vma. Today, it can only be done by =
mremap,
> > > >>> however it forces splitting the vma.
> > > >>>
> > > >>> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-=
aarcange@redhat.com/
> > > >>> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaU=
Q5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > > >>>
> > > >>> Update for the ioctl_userfaultfd(2)  manpage:
> > > >>>
> > > >>>      UFFDIO_MOVE
> > > >>>          (Since Linux xxx)  Move a continuous memory chunk into t=
he
> > > >>>          userfault registered range and optionally wake up the bl=
ocked
> > > >>>          thread. The source and destination addresses and the num=
ber of
> > > >>>          bytes to move are specified by the src, dst, and len fie=
lds of
> > > >>>          the uffdio_move structure pointed to by argp:
> > > >>>
> > > >>>              struct uffdio_move {
> > > >>>                  __u64 dst;    /* Destination of move */
> > > >>>                  __u64 src;    /* Source of move */
> > > >>>                  __u64 len;    /* Number of bytes to move */
> > > >>>                  __u64 mode;   /* Flags controlling behavior of m=
ove */
> > > >>>                  __s64 move;   /* Number of bytes moved, or negat=
ed error */
> > > >>>              };
> > > >>>
> > > >>>          The following value may be bitwise ORed in mode to chang=
e the
> > > >>>          behavior of the UFFDIO_MOVE operation:
> > > >>>
> > > >>>          UFFDIO_MOVE_MODE_DONTWAKE
> > > >>>                 Do not wake up the thread that waits for page-fau=
lt
> > > >>>                 resolution
> > > >>>
> > > >>>          UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> > > >>>                 Allow holes in the source virtual range that is b=
eing moved.
> > > >>>                 When not specified, the holes will result in ENOE=
NT error.
> > > >>>                 When specified, the holes will be accounted as su=
ccessfully
> > > >>>                 moved memory. This is mostly useful to move hugep=
age aligned
> > > >>>                 virtual regions without knowing if there are tran=
sparent
> > > >>>                 hugepages in the regions or not, but preventing t=
he risk of
> > > >>>                 having to split the hugepage during the operation=
.
> > > >>>
> > > >>>          The move field is used by the kernel to return the numbe=
r of
> > > >>>          bytes that was actually moved, or an error (a negated er=
rno-
> > > >>>          style value).  If the value returned in move doesn't mat=
ch the
> > > >>>          value that was specified in len, the operation fails wit=
h the
> > > >>>          error EAGAIN.  The move field is output-only; it is not =
read by
> > > >>>          the UFFDIO_MOVE operation.
> > > >>>
> > > >>>          The operation may fail for various reasons. Usually, rem=
apping of
> > > >>>          pages that are not exclusive to the given process fail; =
once KSM
> > > >>>          might deduplicate pages or fork() COW-shares pages durin=
g fork()
> > > >>>          with child processes, they are no longer exclusive. Furt=
her, the
> > > >>>          kernel might only perform lightweight checks for detecti=
ng whether
> > > >>>          the pages are exclusive, and return -EBUSY in case that =
check fails.
> > > >>>          To make the operation more likely to succeed, KSM should=
 be
> > > >>>          disabled, fork() should be avoided or MADV_DONTFORK shou=
ld be
> > > >>>          configured for the source VMA before fork().
> > > >>>
> > > >>>          This ioctl(2) operation returns 0 on success.  In this c=
ase, the
> > > >>>          entire area was moved.  On error, -1 is returned and err=
no is
> > > >>>          set to indicate the error.  Possible errors include:
> > > >>>
> > > >>>          EAGAIN The number of bytes moved (i.e., the value return=
ed in
> > > >>>                 the move field) does not equal the value that was
> > > >>>                 specified in the len field.
> > > >>>
> > > >>>          EINVAL Either dst or len was not a multiple of the syste=
m page
> > > >>>                 size, or the range specified by src and len or ds=
t and len
> > > >>>                 was invalid.
> > > >>>
> > > >>>          EINVAL An invalid bit was specified in the mode field.
> > > >>>
> > > >>>          ENOENT
> > > >>>                 The source virtual memory range has unmapped hole=
s and
> > > >>>                 UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> > > >>>
> > > >>>          EEXIST
> > > >>>                 The destination virtual memory range is fully or =
partially
> > > >>>                 mapped.
> > > >>>
> > > >>>          EBUSY
> > > >>>                 The pages in the source virtual memory range are =
not
> > > >>>                 exclusive to the process. The kernel might only p=
erform
> > > >>>                 lightweight checks for detecting whether the page=
s are
> > > >>>                 exclusive. To make the operation more likely to s=
ucceed,
> > > >>>                 KSM should be disabled, fork() should be avoided =
or
> > > >>>                 MADV_DONTFORK should be configured for the source=
 virtual
> > > >>>                 memory area before fork().
> > > >>>
> > > >>>          ENOMEM Allocating memory needed for the operation failed=
.
> > > >>>
> > > >>>          ESRCH
> > > >>>                 The faulting process has exited at the time of a
> > > >>>                 UFFDIO_MOVE operation.
> > > >>>
> > > >>
> > > >> A general comment simply because I realized that just now: does an=
ything
> > > >> speak against limiting the operations now to a single MM?
> > > >>
> > > >> The use cases I heard so far don't need it. If ever required, we c=
ould
> > > >> consider extending it.
> > > >>
> > > >> Let's reduce complexity and KIS unless really required.
> > > >
> > > > Let me check if there are use cases that require moves between MMs.
> > > > Andrea seems to have put considerable effort to make it work betwee=
n
> > > > MMs and it would be a pity to lose that. I can send a follow-up pat=
ch
> > > > to recover that functionality and even if it does not get merged, i=
t
> > > > can be used in the future as a reference. But first let me check if=
 we
> > > > can drop it.
> >
> > For the compaction use case that we have it's fine to limit it to
> > single MM. However, for general use I think Peter will have a better
> > idea.
> > >
> > > Yes, that sounds reasonable. Unless the big important use cases requi=
res
> > > moving pages between processes, let's leave that as future work for n=
ow.
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
>
> While going through mremap's move_page_tables code, which is pretty
> similar to what we do here, I noticed that cache is flushed as well,
> whereas we are not doing that here. Is that OK? I'm not a MM expert by
> any means, so it's a question rather than a comment :)

Good question. I'll have to look closer into it. Unfortunately I'll be
travelling starting tomorrow and be back next week. Will try my best
to answer questions in a timely manner but depends on my connection
and availability.
Thanks!
