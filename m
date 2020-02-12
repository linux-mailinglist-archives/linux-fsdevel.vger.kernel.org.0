Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF315B27E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 22:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgBLVIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 16:08:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36444 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgBLVIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so4025768ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=Q58W0NiVVgTX+oNnbx2yak8H3LqZJhOMXKR6Ng/loJu7bqEx0qJqJdUgYoD/Insl5V
         0bdfWlwpi7ZWdHerxvV1fP32PeO3Q+Sr+beCxumaLAw59xU5UE6TavPtsaLJeIdwxKCP
         /m8KW47+oG3MYjz8Wo+heg9mc0RztoSq3bL84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=MrcqrOfiL2TTECuCTlH/RDoklYuR2Md+yuQYxD+auZkimku/6eAlrEiXqm2kzMYFA/
         lXGAJjl8hm/yHMjE4akoktRImUC6GvJ4CNKGqRpU/hLTCdDGM1OQssTy/7EP3bOLbAU3
         1k17Zx6CHPC5E8thqDo5QsYTCHm6w0Qf0UfdsYspGUkfVXcLMs5ncl+sYqhFhZReZdWr
         9Thu/lYYWk3IktSIsTtg5NfZ1on5i6lB+d0QLfxCbYzMiVxOirkiWNFvjFYuOTZHuURN
         6vjVZXJF1R1cJCL0HoxHfrBaqb4KZZphxuCNsOhPJbN+SmAmzJNVFpes1cCcjs9Dx2Zu
         2cDQ==
X-Gm-Message-State: APjAAAVGKj8T1yrW5mmx1LAjBTSa8P53ShREhI06L5zME4kNT5tZ0/Am
        q0Xpb5FZRBKbwOoYzuMUZ52RMlfG7tY=
X-Google-Smtp-Source: APXvYqxXfPev5kbYIJJPw+te3wVjpqsgS491rMHNSKPoeaAW6sRbOwLbRFe4WGPZOiyciA5TXrDurg==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr9013710ljl.83.1581541723807;
        Wed, 12 Feb 2020 13:08:43 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id y2sm164338ljm.28.2020.02.12.13.08.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 13:08:43 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f24so2639060lfh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 13:08:43 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8729073ljj.241.1581541376733;
 Wed, 12 Feb 2020 13:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212204124.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 13:02:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 12, 2020 at 08:38:33PM +0000, Al Viro wrote:
> >
> > Wait, I thought the whole point of that had been to allow multiple
> > procfs instances for the same userns?  Confused...
>
> s/userns/pidns/, sorry

Right, but we still hold the ref to it here...

[ Looks more ]

Oooh. No we don't. Exactly because we don't hold the lock, only the
rcu lifetime, the ref can go away from under us. I see what your
concern is.

Ouch, this is more painful than I expected - the code flow looked so
simple. I really wanted to avoid a new lock during process shutdown,
because that has always been somewhat painful.

            Linus
