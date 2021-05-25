Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF938FA7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 08:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEYGKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 02:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhEYGKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 02:10:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400FC061574;
        Mon, 24 May 2021 23:09:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so44170714lfc.9;
        Mon, 24 May 2021 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIjqP76bcokXstcVdhXWvCsy9Nq7fCd9xQ0EpMlYmg8=;
        b=sxteB4R20pB3LVf7bwC2WnMYCUmO1YAItFF8XNAJ39+8E9INk1Rsb7mLJW29Xfdt/L
         uJL/zcvuTo6GYP//mEWBiypsP4T/m1Ra3C9yFQWgrULXZ8jcplyqr6E8WieSRBIIgmm2
         A3FYN3CG0958F5VQoX9yorSMJRokNsjkEs/M8Plun44vR/OziaztEvd3GtaDkqN/jKWT
         zVJ1IvtOhKoFasQjTc73XZ99mRrxAzgznJAlbOZIFSXECx2xtZwYutDmFAvOyXI7sSom
         EbPAd5bgh74HCcpY9nEwmrGFGpC0qZbjRJI4lOn8US0MPXlViieWcX4GLJH0bNKIUFFX
         k0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIjqP76bcokXstcVdhXWvCsy9Nq7fCd9xQ0EpMlYmg8=;
        b=eKuXsAI+AKkGpouUQR3btyegWYeKNBPl1UN+asse6YH8rxlr04syZcXByfmsz5maN5
         FaTxFy7vUNW7bDMUOLErxoJ64go0kE/4NPNCnlJvNqXmT2vNasdzmS4hZC4LMvQ6r17M
         +NkruZ9U21T/xW7ON2h+PJuih+iahQodKPuxQqSeJUh4anV/JKC41L4xOHjC3WhP0DpE
         U7zsB6vr2gRyKTi82In9AS0PX9c+yVxdZ6U0LXG6LKDIUgRpHRv8bKjfh/Un0lULUW1H
         9L+nNfN65Fv3WO1duArgO89xnL2RLIkB9/jAk6xizpZh+KvX9LIepAjSpRrFmyuNKiPl
         jQXw==
X-Gm-Message-State: AOAM530oVAKoURD2ZU/DeJ0L3aBMDMsQWSKreiltIRJ1psu6ZK3qTHaG
        g+04HzCyaZk2GGZXU87dL8Dp7lsWDX+VpUVDYX8=
X-Google-Smtp-Source: ABdhPJzxZM44nrqFrvqyW48LlAXCTcWnKbNVFUjP1SuvvY7pcpn+XUmtsmuWhDsYaCVKuoeyp43EFA8q/rru8pe4QHE=
X-Received: by 2002:ac2:4944:: with SMTP id o4mr12741999lfi.568.1621922960403;
 Mon, 24 May 2021 23:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com> <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
 <20210521155020.GW4332@42.do-not-panic.com> <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
 <20210524225827.GA4332@42.do-not-panic.com> <CADxym3akKEurTTGiBxYZiXKVWUbOg=a8UeuRsJ07tT+DixA8mw@mail.gmail.com>
 <20210525014304.GH4332@42.do-not-panic.com>
In-Reply-To: <20210525014304.GH4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 25 May 2021 14:09:08 +0800
Message-ID: <CADxym3bbx7pXahoRb98ocQb1JYQMdagYDJ+XKe_RwD=7c6MCug@mail.gmail.com>
Subject: Re: [PATCH RESEND] init/initramfs.c: make initramfs support pivot_root
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, gregkh@linuxfoundation.org, tj@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, f.fainelli@gmail.com, arnd@arndb.de,
        Barret Rhoden <brho@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        Chris Down <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        palmerdabbelt@google.com, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 9:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> >
> > This change seems transparent to users, which don't change the behavior
> > of initramfs.
>
> Are we sure there nothing in the kernel that can regress with this
> change? Are you sure? How sure?
>
> > However, it seems more reasonable to make it a kconfig option.
> > I'll do it in the v2 of the three patches I sended.
>
> I'm actually quite convinced now this is a desirable default *other*
> than the concern if this could regress. I recently saw some piece of
> code fetching for the top most mount, I think it was on the
> copy_user_ns() path or something like that, which made me just
> consider possible regressions for heuristics we might have forgotten
> about.
>
> I however have't yet had time to review the path I was concerned for
> yet.

Yeah, I'm sure...probably. The way I create and mount 'user root' is
almost the same to block root device. When it comes to block
device, such as hda, what kernel do is:

/* This will mount block device on '/root' and chdir to '/root' */
prepare_namespace->mount_root->mount_block_root->do_mount_root;

/* This will move the block device mounted on '/root' to '/' */
init_mount(".", "/", NULL, MS_MOVE, NULL);

/* This will change the root to current dir, which is the root of block
 * device.
 */
init_chroot(".")

And these steps are exactly what I do with 'user root'. However, I'm
not totally sure. For safety, I'll make it into a kconfig option. Is
it acceptable to make it enabled by default?

Thanks!
Menglong Dong
