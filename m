Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C21FBB8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgFPQVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgFPQVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:21:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B10C061573;
        Tue, 16 Jun 2020 09:21:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so24325736lji.2;
        Tue, 16 Jun 2020 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rutRXz0r4RPjoUq6p2P1cCdyOAHIgEUeGio/qCwppKI=;
        b=GKugQ2aUJSFuCPkHF4l8KI4OYDQ5aRxn2DpwgQ6bo7k47o4kF+CqPmbDEuVaKdOLka
         M4jNLgop5VfO+oM50KJOga+oX9wwCFAS5z5eAdmTp5KnYIt9vZRGOFbGhzNDpoMp669h
         FVsKkCaC1tiy3OKvSdM4e2zfh2wXjz1RiEnuVLwpCD2Q2y/H9w9VJ00Ok0bWOIVT81K9
         sNMqTZnUOHnjXEyB9N1KGMriItjjY0Rbi1FkPtVS7uzWYp3Y8ymoKxWyjsFwsoMoYePC
         vEII5p5vAWgqVGfeuOss214OTCgMNm9O3oRKtDM0pfXeJMnFJK+Fl6rvnQH3B2xDXZca
         23Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rutRXz0r4RPjoUq6p2P1cCdyOAHIgEUeGio/qCwppKI=;
        b=bcKAX8z1mWIziVzDk2pkb9pBCodo8F/u65/feQQSWUbvjGnuf0uF4zLf9y3tNY/ZX/
         8VnXkhKH1jKLf1SZrXj7uvUiAeXJSx9atrdQBro/4B+quZEwm5sdt8ifkXO/WfpsjKMi
         6B1MtaafV2qjZ8Ei+bbCxz6M3xj8I+cLYLuSvQZab5XDZ9MQPvrCfo/ltzqkM6353BeX
         KzSmr3ZwCP9R4kdXGYJ4nrTeRMXXuXieqA+iqmHg6Gk3qkiyoalN3nn5aDvrwxXxjUQp
         Hnmyc5dKMn4/LA/0gxJ2SG61B3pmfMSDugGUXMeDi9EQ3yDshnuqwOsjNIj7aMrvWqx7
         B8VQ==
X-Gm-Message-State: AOAM532ZEHGkVFrVBRm/7E21/unB1hZnOHyDP4oOWV0Y5PhsGU6cBpuc
        55e6FJXruSiVj/jVAgdEtdAfBIWNHrJjBbvknzo=
X-Google-Smtp-Source: ABdhPJyB27SulU6iO8WwU8QdJcISHXWJjy+R1tOYonQ3HVk1Vw7tsbXU2t+PVxAEV1ml6zPw+a4b/dCSijDYmxMoWoc=
X-Received: by 2002:a2e:b1d4:: with SMTP id e20mr1773300lja.290.1592324509058;
 Tue, 16 Jun 2020 09:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org> <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org> <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Jun 2020 09:21:36 -0700
Message-ID: <CAADnVQ+D5aozzWVKjZua61B9=Xt7Cj+95o2ZOPf22YsPgqfX6Q@mail.gmail.com>
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

On Mon, Jun 15, 2020 at 6:55 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >
> > int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> >
> >
> > The function fork_usermode_blob is passed an array and a length.  Today
> > that array is stored in .rodata.  Not in a init section where it could
> > be discared.
>
> It's a one line change in bpfilter_umh_blob.S to make it .init section,
> but for bpfilter init may not work.
> For some ko init is appropriate for some other it's not.

since I remember discussing the desire to have only one copy of the blob
with Andy back then I did a bit of git archeology.
Sure enough it was in .init.rodata when usermode_blob() landed.
But then commit 61fbf5933d42 ("net: bpfilter: restart bpfilter_umh
when error occurred")
added blob restart logic.
It's kinda questionable whether bpfilter needs restart or not.
But because the kernel module now starts the blob multiple times it had to move
them from .init.rodata to .rodata.
Regardless the point is that init or not-init is a decision of a
particular kernel module.
