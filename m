Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD91206C24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbgFXGFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgFXGFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:05:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9964C061573;
        Tue, 23 Jun 2020 23:05:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so1203500ljm.11;
        Tue, 23 Jun 2020 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Z9fHqLXgOm0n7UmLwNeJuv67f0+a+SBVV6ekUy68zA=;
        b=qJ6Eku5d6gECfuQ94hQXns5OO86tzVV2pqEvzmKJ0KomNU5LsF4ahTasNh64btfXKz
         3EwVn7gvhX2LLmC8v25xUrpfjtOIyKvLSlNIu4BwHc3bBkjZefe8+15Bb3+iK9N/vybH
         Ghz7A+r8pLCwYx5cPY5wP3W4jdNyeFXje1ZgmAeIcJy4KwjjL5waK0Rmh4zORDuNbWNP
         b5DU9aXAAUYbzmOTMCpUbsEj2rlZI/u8vuQtP5dU8HPFxcfniVMaWPqwo9UIHDhGKrkJ
         eWsyCpj1JqPI1rpibwbHOep40NeVor/D5oAONUc4tr2qNHFLlLq4izCtIQKQiJJ491nL
         xbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Z9fHqLXgOm0n7UmLwNeJuv67f0+a+SBVV6ekUy68zA=;
        b=QWmwPsZ5kuTOTSlW8K7RWjkwsy1g2QxE+KAUgnU0nGwjs1vLgrfJiJDLZ86n/mSNoo
         3xcw8kAJAcfhIWantvZ55w9ztfC6G19Ay4W6XwL/ejhmJ/ICJM+ZEI+qgcWROtIuFCNn
         Gcg4j0NDftS5IZzBEblzCwr4GWZ2L/by1IXrbC0bXGh29mdHvhpkSa99eU4QqsAVLni9
         iqo1G0ePv5z9F1EEAeEe7Tz5E/2KJl+Az0XBZLo/vLerSaulrObSkro81T3e8+NFqA3c
         iEGxIUvGGV44S0tt7iiZeVO+Hgekmcqk2uaIZzyuTLJBc5g3T7uiyokMNfI6bzPUajA1
         gpQw==
X-Gm-Message-State: AOAM533lN0L5OqNRbMRqQTXTBlEaeW3fVclkro2mDXi/Y8+8UAc/lwws
        mPPIxXLtkLUVY3k6oiobkerIRoUTjaKpS0TeqpE=
X-Google-Smtp-Source: ABdhPJxqPlf/lTh0R1Ca3j88H5bteQmLx3S3FiVVu9nOE9VS2aFOA7ixS8lo0Afl9WruUIvclfNhiLECmXQ9MJ0thzE=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr13420938ljo.121.1592978713104;
 Tue, 23 Jun 2020 23:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp> <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 23 Jun 2020 23:05:00 -0700
Message-ID: <CAADnVQKrow=jGGPnn=u2896XRzaavs9b686u_Pe4aicN34ESjQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Tue, Jun 23, 2020 at 9:00 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 24, 2020 at 10:51:15AM +0900, Tetsuo Handa wrote:
> > On 2020/06/24 4:40, Alexei Starovoitov wrote:
> > > There is no refcnt bug. It was a user error on tomoyo side.
> > > fork_blob() works as expected.
> >
> > Absolutely wrong! Any check which returns an error during current->in_execve == 1
> > will cause this refcnt bug. You are simply ignoring that there is possibility
> > that execve() fails.
>
> you mean security_bprm_creds_for_exec() denying exec?
> hmm. got it. refcnt model needs to change then.

I think the following trivial change should do it:

diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03..f80dd2a93ca4 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -512,7 +512,9 @@ int fork_usermode_blob(void *data, size_t len,
struct umh_info *info)
        file = shmem_kernel_file_setup("", len, 0);
        if (IS_ERR(file))
                return PTR_ERR(file);
-
+       err = deny_write_access(file);
+       if (err)
+               goto out_fput;
        written = kernel_write(file, data, len, &pos);
        if (written != len) {
                err = written;
@@ -532,8 +534,11 @@ int fork_usermode_blob(void *data, size_t len,
struct umh_info *info)
                mutex_lock(&umh_list_lock);
                list_add(&info->list, &umh_list);
                mutex_unlock(&umh_list_lock);
+               return 0;
        }
 out:
+       allow_write_access(file);
+out_fput:
        fput(file);
        return err;
 }

I'll do more tests tomorrow and send it with SOB.
