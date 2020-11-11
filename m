Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63372AF79C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKKRyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKRyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:54:32 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80261C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:32 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so4357901lfj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5z5ZWxKl1XdvN7r77o5/F7KFBS3l/2PI63c9zLP4QU=;
        b=IJDhODGPEFIKEwMbT+gjJFRHugQW5o0Hlvzl8+o+nf98y8sQ3VdTfAfYeL/5ndK9KW
         aG8LwYMlatfX1lNMM9AQFeL9Wf4skmcYCGuv7sBm2S/ZhFPbKHTg5BbMp32OoiPTuRIr
         opV9yB8PTauJ3VpOi/LI/4Fcpb1qDDS0tA4Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5z5ZWxKl1XdvN7r77o5/F7KFBS3l/2PI63c9zLP4QU=;
        b=sLhu/jHBiW6fv74cRqV1MOGWuZE5qBObIm33wL9u3Lnt4uyf1ag+AQfgk2JAoJ2w2s
         xUh1SsHyi+VJXmaw/CAGDZ5MOsZ1k7Of708lG+DL1J8IHbOzwil/Ipj++2YPz9OAVOFa
         nJ5wuz3GJwt8yek4kIH8IUOuRT08HyrhuCJfmy8d+7c4nqALfGWCEaS4lmyxMLm1VFPa
         9PxbDZ9y/X9+wn8YUy4jztfZ4cTMEoo88fFhdsKV+LcxdOE37YonX5ONygr+O6DzS+Lr
         WooxCHFlW4SdBUANOBCTjoUkx8unWlGzoK4+pMoFAJEl+G6iVRI1MdQWqY2se2J8/8/0
         xUMw==
X-Gm-Message-State: AOAM530my2xtS4UKtYYmZjitdt9tCGiMn4WU7O/PsnPZeQPYkKPMrb9K
        o58UzajX+3VdJ7gBVZZRl6rblcgmPb5fog==
X-Google-Smtp-Source: ABdhPJy3YUMsAQld9lUl3FNwKnbY2MkKCft5I31sTy5lmyDrh1aOCtdU8hS7EaYS5SolQwnNpuE5Rw==
X-Received: by 2002:a19:2d5:: with SMTP id 204mr9529284lfc.117.1605117270551;
        Wed, 11 Nov 2020 09:54:30 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t22sm296913ljh.89.2020.11.11.09.54.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:54:29 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id i17so1974843ljd.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 09:54:28 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr8669216ljn.421.1605117268642;
 Wed, 11 Nov 2020 09:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de> <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk> <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201110232028.GX3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Nov 2020 09:54:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
Message-ID: <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Any objections to the following?

Well, I don't _object_, but I find it ugly.

And I think both the old and the "fixed" code is wrong when an EFAULT
happens in the middle.

Yes, we can just return EFAULT. But for read() and write() we really
try to do the proper partial returns in other places, why not here?

IOW, why isn't the proper fix just something like this:

    diff --git a/fs/seq_file.c b/fs/seq_file.c
    index 3b20e21604e7..ecc6909b71f5 100644
    --- a/fs/seq_file.c
    +++ b/fs/seq_file.c
    @@ -209,7 +209,8 @@ ssize_t seq_read_iter(struct kiocb *iocb,
struct iov_iter *iter)
        /* if not empty - flush it first */
        if (m->count) {
                n = min(m->count, size);
    -           if (copy_to_iter(m->buf + m->from, n, iter) != n)
    +           n = copy_to_iter(m->buf + m->from, n, iter);
    +           if (!n)
                        goto Efault;
                m->count -= n;
                m->from += n;

which should get the "efault in the middle" case roughly right (ie the
usual "exact byte alignment and page crosser" caveats apply).

               Linus
