Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BF2075A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391181AbgFXO0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbgFXO0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:26:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F63CC061573;
        Wed, 24 Jun 2020 07:26:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so1369048lfh.11;
        Wed, 24 Jun 2020 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTlPjaEuLkT0QgL+A/2JglgCcsMWqPH0L44CLFBV1SM=;
        b=tO/FnTvdHdzIpuxUQy1wwQ4DPmYI/tYau+9ST2jDm79OeDkzFAv21GhxjwSiJ3BsMe
         1gwLct9itLtyJSf3KikjKqRabrCOODPviltcfBo+tNJTB8tUt3mJZW2cYZFQJB5v5maw
         3AkplUYwWkA8zsqgU3vWkT6R3CBL5W3anLvPzNLOcGP9Wc6BaObNgtAkVLyK4QlwxrSg
         TjyLcxgrnwybuIMlPld1RU54zhZK1vdZXEz1rbu4UG7mJkOYf6gWzApecFZvKWZAiQLc
         KGA5zKFLlC0BdnO+j6aWo7qALB0QiN7G+5DrbGrp90Jxs4ihu0ery1fYAsKYcl1dYCpO
         DHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTlPjaEuLkT0QgL+A/2JglgCcsMWqPH0L44CLFBV1SM=;
        b=MrT9gq813bD+IqTIXZQlTs36SsZzmiHOoYSxvU9De1fywcjfbqRArmsbpSk5KlK30x
         H2OTKouyrdkDitlYetzNtxWnq66ssL2bWTIzsru06/cwx7ILJpC//YtnerOAYjaISrb8
         gXvMuJFEuY7q0/eetbx2m3Na2oaYVgCGMYCKyeAEpJ9lY1Ut6GUp2i4KBV6jw5WAxS1d
         ehqx/VDPd01DG2gJI1eOd1jCuMJSl7MOLYOhx7kVYEQMGiFfEsv17awwovCdpzEkUFIT
         9o4KlP0hxOF60b8icooBpBVjmJVmxr9AvocTz9nnUoLM5WbvopAPAfieuIyJro75PEs2
         NW1g==
X-Gm-Message-State: AOAM533JvVTQkqE0JbjZHUiMm5kWCUbfJj7w7gRQj1f9FTAmNzs34W+x
        6z5GIWVa/gv+BVrAc5k3E1KXKxZ4CPReNs/947o=
X-Google-Smtp-Source: ABdhPJxPlMeCRcoPqRVNHRUdpNTM1nFWSo4hDNGsx3i5ljQAoeJbJZoqS04grNYvQms3RKSALvSkfyRBIjLsyfYQLds=
X-Received: by 2002:a05:6512:54d:: with SMTP id h13mr15774112lfl.8.1593008793808;
 Wed, 24 Jun 2020 07:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <87d066vd4y.fsf@x220.int.ebiederm.org> <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sgck6g0.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Jun 2020 07:26:22 -0700
Message-ID: <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 5:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:
>
> > There is no refcnt bug. It was a user error on tomoyo side.
> > fork_blob() works as expected.
>
> Nope.  I have independently confirmed it myself.

I guess you've tried Tetsuo's fork_blob("#!/bin/true") kernel module ?
yes. that fails. It never meant to be used for this.
With elf blob it works, but breaks if there are rejections
in things like security_bprm_creds_for_exec().
In my mind that path was 'must succeed or kernel module is toast'.
Like passing NULL into a function that doesn't check for it.
Working on a fix for that since Tetsuo cares.
