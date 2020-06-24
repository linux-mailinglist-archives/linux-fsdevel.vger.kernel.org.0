Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E03207581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbgFXOTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbgFXOTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:19:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8355C061573;
        Wed, 24 Jun 2020 07:19:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so2724504ljm.9;
        Wed, 24 Jun 2020 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NSyax6ev10CoFfCbF9gPBTmrfEb93mBKae91IjP71c=;
        b=h9Sl+3qOPt4dUxLpC4KU9frwWZ0+27WfmlnLf86KiNau1lsYTFGhA/u3Vxvz8Z0ac+
         1340GmKMELSOTqtNuG3lqr7KiQ7cvy5czX0vqyzuNku6A0nBDLIvXqHFdpHm6fnciU1M
         WvItGUrC1Zmq0TlgQAINxdc/YqBlRJbbvOSirry99iefHM6AYnb1cnP+L3E0UP7plkgg
         y6aA2AitaJL8bJbq7T/6Sdp1HYIGANQL1ynJbgmVGszscUFrjMZAQlWTKb9CsDPcd0f8
         e6pwSzfW4Jn3MnOozo/BfJvb0DQ3cZ1gBOQdERFIcKUv2cPUIHpTiUpZgqv85YfYHBX5
         AChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NSyax6ev10CoFfCbF9gPBTmrfEb93mBKae91IjP71c=;
        b=Ew9TeF5H8lO9WTtsnzt5kL2SRX/zxjUjPDZuxArDGmYmMxXLGARzIZFj5zDBs5WVYm
         3En2EsCc047cKGkrqQIWKoAad0NUU0eC9QAPLQo4a1FJeY+wR1I33gWw9O4FoZqeynki
         crEQXyxqGzZN9HRZdlHxqj5rypruzNaSqhokmnRcz12yL/5FqyEwGN3gamLF8F8JMerx
         hf36qDTv8irC21BswiOc3LgwHFhufAH9cRemV+KYYpLAru3C5ObfiEDfPgygV329QFtJ
         R3rl4cLo24+7HMJO7wu8BU0xp86Po2HHkVNUP/q1eVsOs3e418I2w+q4aSJlfZ22cPVn
         lMVg==
X-Gm-Message-State: AOAM533nqqJEt/butWJxUmsnf3pcK7FJDVk2ksEkUXHU7DlLInlYtQ7y
        k8Y/nCobSrcC5ZzSJxmoPwbzV01LgXzQqG0gAeg=
X-Google-Smtp-Source: ABdhPJyn5q25dxEZhQFCUztSUeKc4/1tA5EznQ1APlzzBb5GfOOKUweKQSJ7YGwQRpZ0As6LZhxmFFZ+tzEdt9LYwYk=
X-Received: by 2002:a2e:9187:: with SMTP id f7mr14418157ljg.450.1593008341012;
 Wed, 24 Jun 2020 07:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com> <CAADnVQKrow=jGGPnn=u2896XRzaavs9b686u_Pe4aicN34ESjQ@mail.gmail.com>
In-Reply-To: <CAADnVQKrow=jGGPnn=u2896XRzaavs9b686u_Pe4aicN34ESjQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Jun 2020 07:18:49 -0700
Message-ID: <CAADnVQJXcRfiPFg4u2h+aCnxyEnWcwBKoE0koQR+fvVvpBaE7w@mail.gmail.com>
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

On Tue, Jun 23, 2020 at 11:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 23, 2020 at 9:00 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 10:51:15AM +0900, Tetsuo Handa wrote:
> > > On 2020/06/24 4:40, Alexei Starovoitov wrote:
> > > > There is no refcnt bug. It was a user error on tomoyo side.
> > > > fork_blob() works as expected.
> > >
> > > Absolutely wrong! Any check which returns an error during current->in_execve == 1
> > > will cause this refcnt bug. You are simply ignoring that there is possibility
> > > that execve() fails.
> >
> > you mean security_bprm_creds_for_exec() denying exec?
> > hmm. got it. refcnt model needs to change then.
>
> I think the following trivial change should do it:
>
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 79f139a7ca03..f80dd2a93ca4 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -512,7 +512,9 @@ int fork_usermode_blob(void *data, size_t len,
> struct umh_info *info)
>         file = shmem_kernel_file_setup("", len, 0);
>         if (IS_ERR(file))
>                 return PTR_ERR(file);
> -
> +       err = deny_write_access(file);
> +       if (err)
> +               goto out_fput;
>         written = kernel_write(file, data, len, &pos);
>         if (written != len) {
>                 err = written;
> @@ -532,8 +534,11 @@ int fork_usermode_blob(void *data, size_t len,
> struct umh_info *info)
>                 mutex_lock(&umh_list_lock);
>                 list_add(&info->list, &umh_list);
>                 mutex_unlock(&umh_list_lock);
> +               return 0;
>         }
>  out:
> +       allow_write_access(file);
> +out_fput:
>         fput(file);
>         return err;
>  }
>
> I'll do more tests tomorrow...

yeah. sorry. -enocoffee. It needs more work.
