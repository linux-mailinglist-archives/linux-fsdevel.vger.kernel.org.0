Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C97376AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 21:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhEGTbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhEGTbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 15:31:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B434C061574
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 May 2021 12:30:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x2so14235385lff.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqZy1ieThk76BROimCSjnj5uRtrwUcwDo/dQoRLlE6w=;
        b=Ittasm4CSxNIShC0+m3SoY8O2RM3MH2Koapfd9IVvcrucECd3r5H54KY0Uw64XfVQX
         nqtNg8qBGKwkYKbhyUWnieWQy6/mRqN+SRP0cOjA/wTE3IS8nYNXtcKk7/ISHv2yQzry
         7jEn+Wn7KQ3gdg3jF0irgJ0xEyg6I1s54y5UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqZy1ieThk76BROimCSjnj5uRtrwUcwDo/dQoRLlE6w=;
        b=Hi3c7FSUnu+PaayaWUcrHZud0ublbb0aLBKs8Jf/Q/uuqiFp229+rBC+HSXkK1Ewqo
         usB12D1x8aDOIYKxKwc4iWez4p60oNN/nSJdeq75yLWMqUt+10hJ9d21yJTs1bAlcBG7
         fI4POcl01vZeL7Xwbg5C3u9d4M4mbxCkaFE/Cg7Q9nGskGbOYkU8xg/aTtGGkHycdqZO
         ozX5a5LTWC9SuRBg+e1yRdiaytDwinaP5YNp6pME9ZRmZ1SDR/wbDg8xbFrLaF0JZ7Cv
         ep0tub6I2qSmSWtvDZTfHIEyxtFhA3sGC3uEFGLClu1/pFsKZN/+ZnKi73DHvj7ogH3r
         5rXw==
X-Gm-Message-State: AOAM5336wNZitD22QxU2NmpxrHRmhnzWRJr7cq84ohYJKV1c4DIUrcqq
        iN8UtAjytI1jBEUb2WYMh4CJCMiAxRwxYem7yTY=
X-Google-Smtp-Source: ABdhPJz69ThW5xbX4U3Zc6PNa8HQFkbVVUsRGCBshTHOgYXpDazqlM7VWt7GdukQi/97LrhlxLPvkQ==
X-Received: by 2002:a05:6512:2312:: with SMTP id o18mr7326392lfu.159.1620415801831;
        Fri, 07 May 2021 12:30:01 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z23sm1428475lfq.241.2021.05.07.12.30.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 12:30:00 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v6so12959617ljj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 12:30:00 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr8836478ljp.251.1620415800148;
 Fri, 07 May 2021 12:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
 <202105071116.638258236E@keescook> <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
 <YJWSYDk4gAT1hkf6@zeniv-ca.linux.org.uk>
In-Reply-To: <YJWSYDk4gAT1hkf6@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 12:29:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhWKp=fQREgQy0uGjo-uvcTg-11gJLoDp4Af8WOKa8ig@mail.gmail.com>
Message-ID: <CAHk-=wjhWKp=fQREgQy0uGjo-uvcTg-11gJLoDp4Af8WOKa8ig@mail.gmail.com>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 7, 2021 at 12:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  That would do wonders to anything that used to do
> copy_to_user()/clear_user()/copy_to_user() and got converted
> to copy_to_iter()/iov_iter_zero()/copy_to_iter()...

I didn't mean for iov_iter_zero doing this - only splice_read_zero().

> Are you sure we can shove zero page into pipe, anyway?
> IIRC, get_page()/put_page() on that is not allowed,

That's what the

    buf->ops = &zero_pipe_buf_ops;

is for. The zero_pipe_buf_ops would have empty get and release
functions, and a 'steal' function that always returns false.

That's how the pipe pages are supposed to work: there are people who
put non-page data (ie things like skbuff allocations etc) into a
splice pipe buffer. It's why we have those "ops" pointers.

              Linus
