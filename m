Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE210F355
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLBXWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:22:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44767 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfLBXWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:22:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so1455922lji.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zivbud+uo79674awuuW6IgbOjr9ZgzEppMzA23/d+3w=;
        b=UclclWVwgV4xGQBOpFikWRYV32woYv2h8DydWQGIKKlJaO6sY8EY4nxJo08fcognZc
         deheC2mhwyio+gu1GBFlvBcudM9owVwCIU2NYoX1t4/V4gtGiLscKYRmKWNT/nimRqlH
         YMCHJCulS4nnZJ4g1AhbL0Pc9o2mOYf7lgYmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zivbud+uo79674awuuW6IgbOjr9ZgzEppMzA23/d+3w=;
        b=oejUeDSRKsn0DqS5M/Kvw/POUGDhboL6TlDGTZcq1j00K8qdek0Dn4HHIL311JWOvV
         wdXBzexH+U/L5AbU/jjDJMVKmvId8ltdPSOzfNaEf+yrEeCYmol2LF9wcj+S3YXS7+UD
         ZV6v7KaC636bzCev2vUzfiXKjH7tyO+Hyr1FWTVowWJWrbbLiLYGRAozsECvvULXW8Qp
         thGvTcOLqWvXjTQe2UGHd7Sz84fzi5Zh8N7gkSQmrny7AUmWZI5W/6NZPdMxRX9oz3j8
         KbsYAQoOHRCBEr5iM64BN2M2aH4x4GUZOCftqv1pGQG2aDjEDm6A9COGfp61K4SIvb3F
         h0/g==
X-Gm-Message-State: APjAAAXe7mV8U78ZnpACzXRfjbtkon1cBLQtM98WOG8UqFYW6WfJlPUG
        ium62NH+Px5My7OuZ+dz2FXddZMTiHw=
X-Google-Smtp-Source: APXvYqzpWKZLTlHhv6imFVsWaTERXcOOK+FTKL1ucabp6WQ14KhzdOKWyAQZuKBM7JNVPOOcAE8Z3g==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr735051ljm.168.1575328969002;
        Mon, 02 Dec 2019 15:22:49 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c27sm277857lfh.62.2019.12.02.15.22.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:22:48 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y19so1252083lfl.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 15:22:47 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr894542lfi.170.1575328967630;
 Mon, 02 Dec 2019 15:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20191201184814.GA7335@magnolia>
In-Reply-To: <20191201184814.GA7335@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Dec 2019 15:22:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
Message-ID: <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.5
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 1, 2019 at 10:48 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> FYI, Stephen Rothwell reported a merge conflict with the y2038 tree at
> the end of October[1].  His resolution looked pretty straightforward,
> though the current y2038 for-next branch no longer changes fs/ioctl.c
> (and the changes that were in it are not in upstream master), so that
> may not be necessary.

The changes and conflicts are definitely still there (now upstream),
I'm not sure what made you not see them.  But thanks for the note, I
compared my end result with linux-next to verify.

My resolution is different from Stephen's. All my non-x86-64 FS_IOC_*
cases just do "goto found_handler", because the compat case is
identical for the native case outside of the special x86-64 alignment
behavior, and I think that's what Arnd meant to happen.

There was some other minor difference too, but it's also possible I
could have messed up, so cc'ing Stephen and Arnd on this just in case
they have comments.


               Linus
