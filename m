Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4067BE63E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377046AbjJIQVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377047AbjJIQVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:21:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFBE9C
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 09:21:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7ad24b3aaso4869157b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696868496; x=1697473296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWEDMabBDXVAf1Pbn/AZJ5/IlrMxaWW3Jbubn56F5tM=;
        b=N53IZmLIDcm0yOwa2+sSztIosQJUc+byeCa1cygVedgzTwWE5s04TQEDrnZh3iARrN
         rb6OJgnmYFSZ7e6+9dsC0PwhSj3ksmh3hoFKVo9sQu4elvSv7LpsY14eV71OLM0/co9c
         zKoz65IO3hB4l4Ty/5keQBM9LstZkZCNL+KQgWIGIgWy01L4Em6y09DmzogxpV+aofdN
         gYd9s5d6+AQGCRiXDDcNqSSmtcbv47tVBZ6kxpPRQdogPOF8sIcsHOpJ8QSnhLP25MZn
         CSpoOjPMpu7pDR53RQP+NVRw4+yyKvT8KiQfuCzzd9dmvGK/HakWS24tNN6zX3FnkSdi
         Z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868496; x=1697473296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWEDMabBDXVAf1Pbn/AZJ5/IlrMxaWW3Jbubn56F5tM=;
        b=e76rQo+B0cQtJLynZHsMERmEQHQI8fiIttn7x4rcbyD84rYJZe5ahVkBZYwh9Szmpo
         z/22/2tCwa4KwE4XEAJgDPWlGwzcH8P1ZZnWXBwRLMwpN666xXAbWFatUxHJwu1Ag6w1
         qpcenljR+MSX0FED4QtDk0jf8Sfall/xh6Qu64mDAsDLgXZY9+VzOHNFZVwpd3AEoKzs
         RuZaluHoDSx9B1zvej9KN3lsmImnaSyzJpeHXW5cYQOydEqWU1/tAgrcrizcUwV2DVg2
         axnAsfDdD5ZZjAnTBdd5akDwyt54nGXaIFk99AI6xnCTl3A+50IoV7fQsEPSxu+d7DSX
         Vzbw==
X-Gm-Message-State: AOJu0Yw1iVJGud/L6MMie2iVdkny3pONN7TXbObi095OWOAuxbs1qFlQ
        sc51krtd9o15pd+rKlGtFMe1zX7J+iS8E2p8tdeyzA==
X-Google-Smtp-Source: AGHT+IF2OmOB0yghUAKz3DlOALSAWglmgSJNOvrM1rf3LA5p2DLe0WzUxprQASiV/coW0oDcUEKKvfaqc6HIZ2m8nlU=
X-Received: by 2002:a0d:c546:0:b0:595:80e4:907d with SMTP id
 h67-20020a0dc546000000b0059580e4907dmr16646576ywd.32.1696868495792; Mon, 09
 Oct 2023 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
In-Reply-To: <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Oct 2023 09:21:22 -0700
Message-ID: <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
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

On Mon, Oct 9, 2023 at 7:38=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.10.23 08:42, Suren Baghdasaryan wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > Implement the uABI of UFFDIO_MOVE ioctl.
> > UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
> > needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages ar=
e
> > available (in userspace) for recycling, as is usually the case in heap
> > compaction algorithms, then we can avoid the page allocation and memcpy
> > (done by UFFDIO_COPY). Also, since the pages are recycled in the
> > userspace, we avoid the need to release (via madvise) the pages back to
> > the kernel [2].
> > We see over 40% reduction (on a Google pixel 6 device) in the compactin=
g
> > thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. =
This was
> > measured using a benchmark that emulates a heap compaction implementati=
on
> > using userfaultfd (to allow concurrent accesses by application threads)=
.
> > More details of the usecase are explained in [2].
> > Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> > touching them within the same vma. Today, it can only be done by mremap=
,
> > however it forces splitting the vma.
> >
> > [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcan=
ge@redhat.com/
> > [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKN=
KXqxRCyjniNVjp0Aw@mail.gmail.com/
> >
> > Update for the ioctl_userfaultfd(2)  manpage:
> >
> >     UFFDIO_MOVE
> >         (Since Linux xxx)  Move a continuous memory chunk into the
> >         userfault registered range and optionally wake up the blocked
> >         thread. The source and destination addresses and the number of
> >         bytes to move are specified by the src, dst, and len fields of
> >         the uffdio_move structure pointed to by argp:
> >
> >             struct uffdio_move {
> >                 __u64 dst;    /* Destination of move */
> >                 __u64 src;    /* Source of move */
> >                 __u64 len;    /* Number of bytes to move */
> >                 __u64 mode;   /* Flags controlling behavior of move */
> >                 __s64 move;   /* Number of bytes moved, or negated erro=
r */
> >             };
> >
> >         The following value may be bitwise ORed in mode to change the
> >         behavior of the UFFDIO_MOVE operation:
> >
> >         UFFDIO_MOVE_MODE_DONTWAKE
> >                Do not wake up the thread that waits for page-fault
> >                resolution
> >
> >         UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> >                Allow holes in the source virtual range that is being mo=
ved.
> >                When not specified, the holes will result in ENOENT erro=
r.
> >                When specified, the holes will be accounted as successfu=
lly
> >                moved memory. This is mostly useful to move hugepage ali=
gned
> >                virtual regions without knowing if there are transparent
> >                hugepages in the regions or not, but preventing the risk=
 of
> >                having to split the hugepage during the operation.
> >
> >         The move field is used by the kernel to return the number of
> >         bytes that was actually moved, or an error (a negated errno-
> >         style value).  If the value returned in move doesn't match the
> >         value that was specified in len, the operation fails with the
> >         error EAGAIN.  The move field is output-only; it is not read by
> >         the UFFDIO_MOVE operation.
> >
> >         The operation may fail for various reasons. Usually, remapping =
of
> >         pages that are not exclusive to the given process fail; once KS=
M
> >         might deduplicate pages or fork() COW-shares pages during fork(=
)
> >         with child processes, they are no longer exclusive. Further, th=
e
> >         kernel might only perform lightweight checks for detecting whet=
her
> >         the pages are exclusive, and return -EBUSY in case that check f=
ails.
> >         To make the operation more likely to succeed, KSM should be
> >         disabled, fork() should be avoided or MADV_DONTFORK should be
> >         configured for the source VMA before fork().
> >
> >         This ioctl(2) operation returns 0 on success.  In this case, th=
e
> >         entire area was moved.  On error, -1 is returned and errno is
> >         set to indicate the error.  Possible errors include:
> >
> >         EAGAIN The number of bytes moved (i.e., the value returned in
> >                the move field) does not equal the value that was
> >                specified in the len field.
> >
> >         EINVAL Either dst or len was not a multiple of the system page
> >                size, or the range specified by src and len or dst and l=
en
> >                was invalid.
> >
> >         EINVAL An invalid bit was specified in the mode field.
> >
> >         ENOENT
> >                The source virtual memory range has unmapped holes and
> >                UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> >
> >         EEXIST
> >                The destination virtual memory range is fully or partial=
ly
> >                mapped.
> >
> >         EBUSY
> >                The pages in the source virtual memory range are not
> >                exclusive to the process. The kernel might only perform
> >                lightweight checks for detecting whether the pages are
> >                exclusive. To make the operation more likely to succeed,
> >                KSM should be disabled, fork() should be avoided or
> >                MADV_DONTFORK should be configured for the source virtua=
l
> >                memory area before fork().
> >
> >         ENOMEM Allocating memory needed for the operation failed.
> >
> >         ESRCH
> >                The faulting process has exited at the time of a
> >                UFFDIO_MOVE operation.
> >
>
> A general comment simply because I realized that just now: does anything
> speak against limiting the operations now to a single MM?
>
> The use cases I heard so far don't need it. If ever required, we could
> consider extending it.
>
> Let's reduce complexity and KIS unless really required.

Let me check if there are use cases that require moves between MMs.
Andrea seems to have put considerable effort to make it work between
MMs and it would be a pity to lose that. I can send a follow-up patch
to recover that functionality and even if it does not get merged, it
can be used in the future as a reference. But first let me check if we
can drop it.

>
>
> Further: see "22) Do not crash the kernel" in coding-style.rst. All
> these BUG_ON need to go. Ideally, use WARN_ON_ONCE() or just VM_WARN_ON()=
.

Yeah, it might be the right time to clean that up. Will do.
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>
