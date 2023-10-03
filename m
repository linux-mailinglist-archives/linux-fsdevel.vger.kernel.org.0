Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1A7B722E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbjJCUFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjJCUFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:05:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFD9E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 13:04:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f6767a15dso1924167b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363496; x=1696968296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4HnvVJM5UhNryBKAzUQ7ExKjrQO05hotZm+y3hVwo0=;
        b=NURDhA3b7C4JeZZhTHBBu9sB7DaPaUKiEoXQNEOorcexI32NygTtUV5Xztcf5X5ll+
         s94JwDsShrDGr7PEN+MMB2xaYeaNdaNDwOchORERNgKAseI5q30K3nZXFiZQwPXvt2zT
         kIr35/bhqOjZ5FZISY7f8uIs08n/V7xpiALFiujGsLzfqrWFyy1mi8mWTtWGoKaSooVB
         U911aMxMlpLKelU5t+ICpYxwwo+7Qyzh38n8ma+6/N2CKWSddKw/Vrlwq+mNvphzzQGZ
         Iiz9QNtylKDw9YUmANWimXxoKMbpc6POCU5CwWYiRAvN7WIakCfw6HxOSwahGlA1Q2N2
         Epaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363496; x=1696968296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4HnvVJM5UhNryBKAzUQ7ExKjrQO05hotZm+y3hVwo0=;
        b=HWCFudfmUe/byRCfFEGjEY2xKUl9iOPpdBOMQO1xTXGDAM0UWP9m8q0gnbDzoG0+MI
         uSqK9g4HCrmhdyOTiiAQwrWjDM+TuG68VLz68fnhlEXk+mDcsPWBpdUBqveCaqU7pDVj
         iQLVtkx1jfA/f1WhAe86drfkU+DPztzULV8ZKc96NO9uuex9N5jdPFtShKyb0tsPyXQP
         Sglc1NjnyLOqaXBuNMpqg8C1S2zVmfJSghk2wm7grZnWOKKiDx5DiUcM3luavO2jXafQ
         MoLc8aEScJafmy+scNi1Cajy+noPbAgBWdT27Ir7OhX6c+PZXkKUlC1Wyf72t/wuolKN
         WYHw==
X-Gm-Message-State: AOJu0YzAD43YKTgh8JaBSo4pP/UmIjizj7+OJ43FdwlkZB0d6gVhr5Vu
        N+SIS0FthkspbKj6npW7/NqXuM+1TBeV7Ej2TTIzNw==
X-Google-Smtp-Source: AGHT+IH9yT6ckHnJBiB5Cfo13hxaaAKxy5AR7WcWqkiDMh30P5bHjEM+Bte/4PVXH+TW9h5J6PjpHuiA2d0kgiAUOWA=
X-Received: by 2002:a0d:d546:0:b0:583:9935:b8ba with SMTP id
 x67-20020a0dd546000000b005839935b8bamr2961777ywd.6.1696363495623; Tue, 03 Oct
 2023 13:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com> <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
In-Reply-To: <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 13:04:44 -0700
Message-ID: <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

On Mon, Oct 2, 2023 at 12:34=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Mon, Oct 2, 2023 at 6:43=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 02.10.23 17:55, Lokesh Gidra wrote:
> > > On Mon, Oct 2, 2023 at 4:46=E2=80=AFPM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> > >>
> > >> On Mon, Oct 2, 2023 at 4:21=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > >>>
> > >>> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> > >>>> In case we cannot simply remap the page, the fallback sequence (fr=
om the
> > >>>> cover letter) would be triggered.
> > >>>>
> > >>>> 1) UFFDIO_COPY
> > >>>> 2) MADV_DONTNEED
> > >>>>
> > >>>> So we would just handle the operation internally without a fallbac=
k.
> > >>>
> > >>> Note that I think there will be a slight difference on whole remap
> > >>> atomicity, on what happens if the page is modified after UFFDIO_COP=
Y but
> > >>> before DONTNEED.
> > >>>
> > >>> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, t=
hreads
> > >>> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get =
lost
> > >>> during movement, and it will generate a missing event after moved, =
with
> > >>> latest data showing up on dest.
> > >>>
> > >>> I'm not sure that means such a fallback is a problem, Suren may kno=
w
> > >>> better with the use case.
> > >>
> > >> Although there is no problem in using fallback with our use case but
> > >> as a user of userfaultfd, I'd suggest leaving it to the developer.
> > >> Failing with appropriate errno makes more sense. If handled in the
> > >> kernel, then the user may assume at the end of the operation that th=
e
> > >> src vma is completely unmapped. And if not correctness issues, it
> > >> could lead to memory leaks.
> > >
> > > I meant that in addition to the possibility of correctness issues due
> > > to lack of atomicity, it could also lead to memory leaks, as the user
> > > may assume that src vma is empty post-operation. IMHO, it's better to
> > > fail with errno so that the user would fix the code with necessary
> > > changes (like using DONTFORK, if forking).
> >
> > Leaving the atomicity discussion out because I think this can just be
> > handled (e.g., the src_vma would always be empty post-operation):
> >
> > It might not necessarily be a good idea to only expose micro-operations
> > to user space. If the user-space fallback will almost always be
> > "UFFDIO_COPY+MADV_DONTNEED", then clearly the logical operation
> > performed is moving data, ideally with zero-copy.
> >
> IMHO, such a fallback will be useful only if it's possible that only
> some pages in the src vma fail due to this. But even then it would be
> really useful to have a flag maybe like UFFDIO_REMAP_FALLBACK_COPY to
> control if the user wants the fallback or not. OTOH, if this is
> something that can be detected for the entire src vma, then failing
> with errno is more appropriate.
>
> Given that the patch is already quite complicated, I humbly suggest
> leaving the fallback for now as a TODO.

Ok, I think it makes sense to implement the strict remap logic but in
a way that we can easily add copy fallback if that's needed in the
future. So, I'll change UFFDIO_REMAP to UFFDIO_MOVE and will return
some unique error, like EBUSY when the page is not PAE. If we need to
add a copy fallback in the future, we will add a
UFFDIO_MOVE_MODE_ALLOW_COPY flag and will implement the copy
mechanism. Does that sound good?

>
> > [as said as reply to Peter, one could still have magic flags for users
> > that really want to detect when zero-copy is impossible]
> >
> > With a logical MOVE API users like compaction [as given in the cover
> > letter], not every such user has to eventually implement fallback paths=
.
> >
> > But just my 2 cents, the UFFDIO_REMAP users probably can share what the
> > exact use cases are and if fallbacks are required at all or if no-KSM +
> > DONTFORK just does the trick.
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
