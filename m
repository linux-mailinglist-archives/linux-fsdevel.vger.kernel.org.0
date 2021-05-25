Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0638F8F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 05:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEYDpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 23:45:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BAC061574;
        Mon, 24 May 2021 20:43:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p20so36315346ljj.8;
        Mon, 24 May 2021 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDF6mBMgNJLUIrRtn1QdpOxFrtc+wC5o+OnjVFJaNNk=;
        b=Bgyg3SufXoRKshaUkZgPFsX+GP+0f8Lok/5IYi98BOdCvCIIu1A3RR1yWrGeBHsEdu
         MXxxFSsQ42UWUUsKEVd2JehHqdkHJIG1FT5hbQdF/ZzoVLz1JQPPo/3VE0qaCd7/VKrj
         6Y4UGGJ+pRDPORu1qATrXn6+T+kYbzeoJi05R6mxV+lq2kF2SHEpqDWvA7YmLDSOqsNu
         SpwCvzVLjo8o0i0aGi2v1d4j245DX7aRevsWcvLkXBfaIfPskTnw4O7060TnLGm8HPar
         kLwjZ0h2+Mc0bXiYhSWn4DmyIFGF0mmAlNF6znSDqSJkA/7waZGmr6AcqavdYwIRtSM4
         2f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDF6mBMgNJLUIrRtn1QdpOxFrtc+wC5o+OnjVFJaNNk=;
        b=IUBH+IdzM/7f0gX7K/NWAS1pxfgcvrxSBJtavten04o/BXOEB8Mb5PY+d5KCeG8Z1M
         7tekd+wxN/vpJeajBcZjJdLoonxN5mMiyHaa0ceI6KD6Uts4cbOmBblErcJVzeYDyKtH
         vU80fQoR73JKF+iFL9LJ1rvshiXI+CpXzNEOjTfUNDlPKLNXbpp2y03zPTwDvYaspJbV
         8YE7VbCYenZ3mVyKF/9B+uSt/qVawlLKUvSSr6MXaA4OU9d03tQZU0ijZOGjZ5sb8qaZ
         arcF8krQjyVrHacpcZG9uuh35/uHFw6uFXaIONFLBRIP1krXdJGc2ODBoIN2CpzmwL5r
         NscA==
X-Gm-Message-State: AOAM533ZBE0QEndmpLiwkMG1c18K+X3PnKi6Ni9twFt29mTKhn8ZDZA1
        eyqdfVvha5rLPMeFQtjW6ziv/wUac3ydSSPOjiQ=
X-Google-Smtp-Source: ABdhPJx73FLXjgNeG1gmGuwVqMUcPxH61t13GnpkEha9rszuiJdELc042dY1kjnaPHP0FYjl6KLgs/8Ogq4Zm8kd1Kc=
X-Received: by 2002:a2e:240e:: with SMTP id k14mr19355228ljk.423.1621914223981;
 Mon, 24 May 2021 20:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-2-dong.menglong@zte.com.cn> <YKxMjPOrHfb1uaA+@localhost>
In-Reply-To: <YKxMjPOrHfb1uaA+@localhost>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 25 May 2021 11:43:31 +0800
Message-ID: <CADxym3asj97wATjGthOyMzosg=dHY-bfk5pqLPYLSCa2Sub73Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] init/main.c: introduce function ramdisk_exec_exist()
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, joe@perches.com,
        Menglong Dong <dong.menglong@zte.com.cn>, masahiroy@kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, gregkh@linuxfoundation.org, tj@kernel.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 9:02 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
......
>
> As far as I can tell, this will break if the user wants to use
> ".mybinary" or ".mydir/mybinary" as the name of their init program.
>
> For that matter, it would break "...prog" or "...somedir/prog", which
> would be strange but not something the kernel should prevent.
>

Wow, seems I didn't give enough thought to it.

> I don't think this code should be attempting to recreate
> relative-to-absolute filename resolution.

Trust me, I don't want to do it either. However, I need to check if
ramdisk_execute_command exist before chroot while the cpio is unpacked
to '/root'.

Maybe I can check it after chroot, but I need to chroot back if it not
exist. Can I chroot back in a nice way?

I tried to move the mount on '/root' to '/' before I do this check in
absolute path, but seems '/' is special, the lookup of '/init' never
follow the mount on '/' and it can't be found. However, if I lookup
'/../init', it can be found!

Is there any one have a good idea? Or I have to dig into the code
of 'kern_path()' and figure out the reason.

Thanks!
Menglong Dong
