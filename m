Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913A87B2616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjI1Trj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Trh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:47:37 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801261A4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:47:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c268676a9so164648107b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695930454; x=1696535254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlqQYHcSZTQEN/TIyJgTq3z/gFgEQXlRPAw0wk0he68=;
        b=GWddrRrbnYUphjZdUbBst7J4k0tIbE91q6ZTHTt7wDfxvFZEoMblwQVourdFoZaXJZ
         XjSW8LR+YEiRq2NWST+DwWlC7jPDlL6X5UIvqWaXq0qWHwR/Kc0Ei2WChLxOgdqXw0Vt
         PGkZO6Qin3sFGK3ymXMGWvKhnUTxSYdJokhLEpR75ooakrLPr/5QDDiJwhjZoK0G9gCH
         PJc2bizWZtS873A3V2SDk4kxazsIpgu7kK69vu5Ze6FyKXHvdcng9DjJyYAO43fCwPHe
         7KfvPjGfa88GIVabBC81yHxL9XJpIs+9RGiiLyGWOSujF4QDvwrs/m8Ur3GfQnsdWwCl
         SvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695930454; x=1696535254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlqQYHcSZTQEN/TIyJgTq3z/gFgEQXlRPAw0wk0he68=;
        b=rqwtM5VSP8Vu+lvTy35UrGg6gaMYd6IIyQYwSB6yocN/ZvhyvAImJOux2ad/C8qudS
         CQfslsTgZ58hWCscuDKUfW+40n28+NC2DWKIeqbKN8fkRz51yVpFbBggQmY/BbeU/NLp
         j1doj/CcRv4BaHciwFZjNUrrhMyMPmDpdfTRvRIl1x0DjfvKrOssxEhm1H+TlXaWFyqm
         0hKRZWderDBArNXlacZVVy/acUVkbVZvj/mjz+VJqwfQbd+d2U72MOV2Ml6t635haEWl
         RTgVx66mY030yZLqDWcnhAetriPfEOcnJCdBC++rQu+WnapgLT5shWlK+iEoGKe+/mSX
         ZhSw==
X-Gm-Message-State: AOJu0Yyv3vwkvaZzDwU/iInfpLU20urgDi/1GHkbOIKgj4ad3E/lMhpz
        l3kdrpZlcNkjL42ny4WaD6jBzjOIROEh2lYExXR6hQ==
X-Google-Smtp-Source: AGHT+IHwCwf7G5lBhB8dV+VuDEF9GYBuzciJmXGyD46zbE5siwyxIqRSHjWzbZlsjSHQXB2P1bWaVvAT2t8QBdpOYn4=
X-Received: by 2002:a0d:df45:0:b0:59f:6175:bd72 with SMTP id
 i66-20020a0ddf45000000b0059f6175bd72mr2137442ywe.6.1695930454372; Thu, 28 Sep
 2023 12:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
In-Reply-To: <ZRXHK3hbdjfQvCCp@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 12:47:21 -0700
Message-ID: <CAJuCfpG5OArpzOBgsy7DvrL4m-Z97SgyrdbnAk8sYogqdwvWEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Sep 28, 2023 at 07:51:18PM +0200, David Hildenbrand wrote:
> > On 28.09.23 19:21, Peter Xu wrote:
> > > On Thu, Sep 28, 2023 at 07:05:40PM +0200, David Hildenbrand wrote:
> > > > As described as reply to v1, without fork() and KSM, the PAE bit sh=
ould
> > > > stick around. If that's not the case, we should investigate why.
> > > >
> > > > If we ever support the post-fork case (which the comment above rema=
p_pages()
> > > > excludes) we'll need good motivation why we'd want to make this
> > > > overly-complicated feature even more complicated.
> > >
> > > The problem is DONTFORK is only a suggestion, but not yet restricted.=
  If
> > > someone reaches on top of some !PAE page on src it'll never gonna pro=
ceed
> > > and keep failing, iiuc.
> >
> > Yes. It won't work if you fork() and not use DONTFORK on the src VMA. W=
e
> > should document that as a limitation.
> >
> > For example, you could return an error to the user that can just call
> > UFFDIO_COPY. (or to the UFFDIO_COPY from inside uffd code, but that's
> > probably ugly as well).
>
> We could indeed provide some special errno perhaps upon the PAE check, th=
en
> document it explicitly in the man page and suggest resolutions (like
> DONTFORK) when user hit it.
>
> >
> > >
> > > do_wp_page() doesn't have that issue of accuracy only because one rou=
nd of
> > > CoW will just allocate a new page with PAE set guaranteed, which is p=
retty
> > > much self-heal and unnoticed.
> >
> > Yes. But it might have to copy, at which point the whole optimization o=
f
> > remap is gone :)
>
> Right, but that's fine IMHO because it should still be very corner case,
> definitely not expected to be the majority to start impact the performanc=
e
> results.
>
> >
> > >
> > > So it'll be great if we can have similar self-heal way for PAE.  If n=
ot, I
> > > think it's still fine we just always fail on !PAE src pages, but then=
 maybe
> > > we should let the user know what's wrong, e.g., the user can just for=
got to
> > > apply DONTFORK then forked.  And then the user hits error and don't k=
now
> > > what happened.  Probably at least we should document it well in man p=
ages.
> > >
> > Yes, exactly.
> >
> > > Another option can be we keep using folio_mapcount() for pte, and ano=
ther
> > > helper (perhaps: _nr_pages_mapped=3D=3DCOMPOUND_MAPPED && _entire_map=
count=3D=3D1)
> > > for thp.  But I know that's not ideal either.
> >
> > As long as we only set the pte writable if PAE is set, we're good from =
a CVE
> > perspective. The other part is just simplicity of avoiding all these
> > mapcount+swapcount games where possible.
> >
> > (one day folio_mapcount() might be faster -- I'm still working on that =
patch
> > in the bigger picture of handling PTE-mapped THP better)
>
> Sure.
>
> For now as long as we're crystal clear on the possibility of inaccuracy o=
f
> PAE, it never hits besides fork() && !DONTFORK, and properly document it,
> then sounds good here.

Ok, sounds like we have a consensus. I'll prepare manpage changes to
document the DONTFORK requirement for uffd_remap.

>
> Thanks,
>
> --
> Peter Xu
>
