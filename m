Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319EF7BE660
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377185AbjJIQ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:29:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080529E
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 09:29:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313e742a787so2816335f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696868961; x=1697473761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9uxnDjj5RsOcAN+RF0ynO6xdWSr/KBmzmP+ARysPwQ=;
        b=bzknRyENyCX43KOi5mzPbUiU3uf2+7Ruiku1yomFUMIf8Pj1+NQk6nQ40aJi6/djLl
         COd/P9S3AabzMxTQQQexSgQ+PqzU4Xajk75Fe6OW4EVQWhVaBHf7onlEw7rm9MzwZY15
         ZlhP3AnlljENRL3p/Uqfz0Z1yyIHlcscCHuaUB69h7F4mpZBLqW6XRUs45M0Twihf7Zf
         86lYSXibmt9ixAT5fZCzgqgRltLgPcg7zpjVKGCTOlen4PuQVpb6Ui3M/qJCJFfkWBSl
         RpLiTRgiUdL5D7tSiIj4wDhMsRug935ToshteoMxm7VoqMbYNdI/HW968qTvMSRxS3Tm
         jZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868961; x=1697473761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9uxnDjj5RsOcAN+RF0ynO6xdWSr/KBmzmP+ARysPwQ=;
        b=YNcyr7m92Nt3iwHW6ZVedaTf4bFDSkQ9khDoF/h0viyE3tvNLIdr/2UKbjDTaUrEY/
         3nlA9A64tD8y4QGdgO/QvoHUf5ULNLoheTEXQW4VybT/ptjOgR7BSBj/z7v67XcYQMwV
         nYuo7igCzM1XtvaE3cQ5rTRT1haNg9Jo5OYlyfsnKxm1cx/ebuQGEKW6HwdVO1WmMno3
         ojp48uUpWEqOYGDW3xa/xX9IqT1+msh325ovVJ9zTpX3qisN8fY2G0D/kdjnTHgihZpi
         VJeJ8t/mkfPRoFAVfN/HuWG/J+5c5Uqbbx+TKLjjYeJ2EfCN/lxNeurtqBYLvQFrF/mH
         yc2w==
X-Gm-Message-State: AOJu0Yw+t4EjYl4n22BlcmB0Li4IZkTBmteMuDYwXJOvKHOdKIhfgCck
        Shw5XWI4eK66hOxvTgtm9B3H4voCFmqxMnyOM+vjRQ==
X-Google-Smtp-Source: AGHT+IH6PLI2drC54PV9B3H88bFGBQmIanwb3EneliHOPBj95HFQUfNM0nOikUEz5pJHMri6gAV4G1Mzu6DEnQh8dhI=
X-Received: by 2002:adf:ff88:0:b0:319:5234:5c92 with SMTP id
 j8-20020adfff88000000b0031952345c92mr9481043wrr.35.1696868961196; Mon, 09 Oct
 2023 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com> <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
In-Reply-To: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 9 Oct 2023 17:29:08 +0100
Message-ID: <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 9, 2023 at 5:24=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.10.23 18:21, Suren Baghdasaryan wrote:
> > On Mon, Oct 9, 2023 at 7:38=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 09.10.23 08:42, Suren Baghdasaryan wrote:
> >>> From: Andrea Arcangeli <aarcange@redhat.com>
> >>>
> >>> Implement the uABI of UFFDIO_MOVE ioctl.
> >>> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the applicatio=
n
> >>> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages =
are
> >>> available (in userspace) for recycling, as is usually the case in hea=
p
> >>> compaction algorithms, then we can avoid the page allocation and memc=
py
> >>> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> >>> userspace, we avoid the need to release (via madvise) the pages back =
to
> >>> the kernel [2].
> >>> We see over 40% reduction (on a Google pixel 6 device) in the compact=
ing
> >>> thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY=
. This was
> >>> measured using a benchmark that emulates a heap compaction implementa=
tion
> >>> using userfaultfd (to allow concurrent accesses by application thread=
s).
> >>> More details of the usecase are explained in [2].
> >>> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> >>> touching them within the same vma. Today, it can only be done by mrem=
ap,
> >>> however it forces splitting the vma.
> >>>
> >>> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarc=
ange@redhat.com/
> >>> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZ=
KNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> >>>
> >>> Update for the ioctl_userfaultfd(2)  manpage:
> >>>
> >>>      UFFDIO_MOVE
> >>>          (Since Linux xxx)  Move a continuous memory chunk into the
> >>>          userfault registered range and optionally wake up the blocke=
d
> >>>          thread. The source and destination addresses and the number =
of
> >>>          bytes to move are specified by the src, dst, and len fields =
of
> >>>          the uffdio_move structure pointed to by argp:
> >>>
> >>>              struct uffdio_move {
> >>>                  __u64 dst;    /* Destination of move */
> >>>                  __u64 src;    /* Source of move */
> >>>                  __u64 len;    /* Number of bytes to move */
> >>>                  __u64 mode;   /* Flags controlling behavior of move =
*/
> >>>                  __s64 move;   /* Number of bytes moved, or negated e=
rror */
> >>>              };
> >>>
> >>>          The following value may be bitwise ORed in mode to change th=
e
> >>>          behavior of the UFFDIO_MOVE operation:
> >>>
> >>>          UFFDIO_MOVE_MODE_DONTWAKE
> >>>                 Do not wake up the thread that waits for page-fault
> >>>                 resolution
> >>>
> >>>          UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> >>>                 Allow holes in the source virtual range that is being=
 moved.
> >>>                 When not specified, the holes will result in ENOENT e=
rror.
> >>>                 When specified, the holes will be accounted as succes=
sfully
> >>>                 moved memory. This is mostly useful to move hugepage =
aligned
> >>>                 virtual regions without knowing if there are transpar=
ent
> >>>                 hugepages in the regions or not, but preventing the r=
isk of
> >>>                 having to split the hugepage during the operation.
> >>>
> >>>          The move field is used by the kernel to return the number of
> >>>          bytes that was actually moved, or an error (a negated errno-
> >>>          style value).  If the value returned in move doesn't match t=
he
> >>>          value that was specified in len, the operation fails with th=
e
> >>>          error EAGAIN.  The move field is output-only; it is not read=
 by
> >>>          the UFFDIO_MOVE operation.
> >>>
> >>>          The operation may fail for various reasons. Usually, remappi=
ng of
> >>>          pages that are not exclusive to the given process fail; once=
 KSM
> >>>          might deduplicate pages or fork() COW-shares pages during fo=
rk()
> >>>          with child processes, they are no longer exclusive. Further,=
 the
> >>>          kernel might only perform lightweight checks for detecting w=
hether
> >>>          the pages are exclusive, and return -EBUSY in case that chec=
k fails.
> >>>          To make the operation more likely to succeed, KSM should be
> >>>          disabled, fork() should be avoided or MADV_DONTFORK should b=
e
> >>>          configured for the source VMA before fork().
> >>>
> >>>          This ioctl(2) operation returns 0 on success.  In this case,=
 the
> >>>          entire area was moved.  On error, -1 is returned and errno i=
s
> >>>          set to indicate the error.  Possible errors include:
> >>>
> >>>          EAGAIN The number of bytes moved (i.e., the value returned i=
n
> >>>                 the move field) does not equal the value that was
> >>>                 specified in the len field.
> >>>
> >>>          EINVAL Either dst or len was not a multiple of the system pa=
ge
> >>>                 size, or the range specified by src and len or dst an=
d len
> >>>                 was invalid.
> >>>
> >>>          EINVAL An invalid bit was specified in the mode field.
> >>>
> >>>          ENOENT
> >>>                 The source virtual memory range has unmapped holes an=
d
> >>>                 UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> >>>
> >>>          EEXIST
> >>>                 The destination virtual memory range is fully or part=
ially
> >>>                 mapped.
> >>>
> >>>          EBUSY
> >>>                 The pages in the source virtual memory range are not
> >>>                 exclusive to the process. The kernel might only perfo=
rm
> >>>                 lightweight checks for detecting whether the pages ar=
e
> >>>                 exclusive. To make the operation more likely to succe=
ed,
> >>>                 KSM should be disabled, fork() should be avoided or
> >>>                 MADV_DONTFORK should be configured for the source vir=
tual
> >>>                 memory area before fork().
> >>>
> >>>          ENOMEM Allocating memory needed for the operation failed.
> >>>
> >>>          ESRCH
> >>>                 The faulting process has exited at the time of a
> >>>                 UFFDIO_MOVE operation.
> >>>
> >>
> >> A general comment simply because I realized that just now: does anythi=
ng
> >> speak against limiting the operations now to a single MM?
> >>
> >> The use cases I heard so far don't need it. If ever required, we could
> >> consider extending it.
> >>
> >> Let's reduce complexity and KIS unless really required.
> >
> > Let me check if there are use cases that require moves between MMs.
> > Andrea seems to have put considerable effort to make it work between
> > MMs and it would be a pity to lose that. I can send a follow-up patch
> > to recover that functionality and even if it does not get merged, it
> > can be used in the future as a reference. But first let me check if we
> > can drop it.

For the compaction use case that we have it's fine to limit it to
single MM. However, for general use I think Peter will have a better
idea.
>
> Yes, that sounds reasonable. Unless the big important use cases requires
> moving pages between processes, let's leave that as future work for now.
>
> --
> Cheers,
>
> David / dhildenb
>
