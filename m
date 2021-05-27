Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4325239288D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhE0Hb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbhE0HbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 03:31:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7179C061574;
        Thu, 27 May 2021 00:29:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q7so6540928lfr.6;
        Thu, 27 May 2021 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1c4xwHXGGH1sejR0TUAI0AnMRSAgsr2C+wu36PqGz4g=;
        b=H8zeQu+eGMTrFrWohbctnGNggExgciyKjSFweAeZ5yi75WASzHLuC2DRrHzjv+lDFM
         QcxNPlyHvJON1F9oHy9YJWtyTn+zbxk31SfN/oucRoiK/ng69AkASErakarkA9UmgW9X
         Vudo4TkSk9kb1j1DKCjPA7K/ZAetPGEQH1f+VmXfdv/bY901w9PdbSN/fK++G0+cAB0+
         W8x5OzsrdM5wcAwfPDmUt1N3w4HEgGMe3m+n2jm4ftQK/B4VNsoHw3jaOynaSq1UZFun
         2fOSyDzDDuWHMynrg18PT+60oXzMw3JQi4o7ofYSCPKPmkjqNYBua8Fn7DaMa+gFzVYU
         r09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1c4xwHXGGH1sejR0TUAI0AnMRSAgsr2C+wu36PqGz4g=;
        b=n+4NUyQyth17QCs0S8U6ML7IYzP9crs4GHgId38ZnkIdxD/O7lKVIcNju+ZtgUWWD3
         h+Xwayl16ekyP4WgxLQdM43859sNZXsFVBjN3Wk001G35T//4vYKAetD1mHjSeCwTEe6
         hhI7aaedvu66nRJvmH0o4vlo+NCWUtOIGkXDb5SjxtWQ5U64oZQhuqGofJoLj6RfHjXW
         smCN3SLnlY157N3Xa+HSCzPS0UM4cwtpmQB5EArRwBsX5/26nBy/Qx+CiRTjQNGLR+1t
         bNL8PjltqHAM3C1PCYuzbdBHJDy4S+tTLU6+DjyejO8li5X4CBREjLVLLWM8XzU9NAIf
         Kbyg==
X-Gm-Message-State: AOAM532cs/XDueQyXRKE9+4BMVmMBnMgQRNZo88bkFury9fiBwlxq4G5
        KjkFtm0xrcE3TMGGTpgiPkqtHpOmstxQpVKRx9Q=
X-Google-Smtp-Source: ABdhPJxPj0Ski8hZJ2fdA/b4uoV3r7vKalt/kVCf/x6dYXgUUtfdc8u0vpPBo4B0dYwMUv+rCujEF0oNzz56WHCJA4I=
X-Received: by 2002:a19:3f0a:: with SMTP id m10mr1585850lfa.477.1622100573127;
 Thu, 27 May 2021 00:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn> <m18s42odgz.fsf@fess.ebiederm.org>
 <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
 <m11r9umb4y.fsf@fess.ebiederm.org> <YK3Pb/OGwWVzvDZM@localhost>
 <CADxym3bznknEWLaa-SgYZAsTGucP_9m+9=JW7oc6=ggrUaBk7A@mail.gmail.com> <20210526090310.GI4332@42.do-not-panic.com>
In-Reply-To: <20210526090310.GI4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 27 May 2021 15:29:20 +0800
Message-ID: <CADxym3YD6QakhB4mw6reN1EH_4hrmHNHOYyeh4pM2WjyWiag9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, Chris Down <chris@chrisdown.name>,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        mingo@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 5:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
[...]
>
> I asked for the kconfig entry. And it would be good to document then

Wow, I didn't recognize it's you, haha~

> also the worst case expected on boot for what this could do to you. I
> mean, we are opening a different evil universe. So that's why the
> kconfig exists.  How bad and evil can this be?

I just dig into it a little deeper today. Except the boot time you
mentioned, I haven't dig out other bad case yet.

I don't think this will affect the path lookup you mentioned before.
As I know, all threads in kernel are using the same root, and after
change root to 'user root', path lookup will be inside this root.

One thing, the name of the root mount will change from 'rootfs' to 'tmpfs'
or 'ramfs'. Before this change, what you can see with 'mount' is:

$ mount
rootfs on / type rootfs (rw,size=903476k,nr_inodes=225869)

After this patch, it will become:

$ mount
tmpfs on / type tmpfs (rw,size=903476k,nr_inodes=225869)

I'm not sure if this is a risk. And I tried to change pivot_root to make
it support the root that have not a parent mount, but not success yet.
That seems much more complex.

Thanks!
Menglong Dong
