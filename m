Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06BA2DD792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgLQSKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgLQSKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:10:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B8C061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 10:09:52 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so34226287lfo.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyr2DNXyT/PI6oPddMFB+7JOcv51vfYZBM8msxQ4ehU=;
        b=WJgn22xJzVmIm0pYatrBZTaOiMZm85fxXeliU4gkbm3eatafgORKqZHih45oQ/brLn
         murnbhEU4wk1yt8bXEw//VoNyKo0pjyBMACeR9tOpbenPNRRq34neKQNZ5G7YenUdHJy
         STr/M6fQtfm61OWnCNrDAzWXZXMOAKNG/uahg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyr2DNXyT/PI6oPddMFB+7JOcv51vfYZBM8msxQ4ehU=;
        b=ErB/+ymTSdVnQhxh0Ko1DUzr29ui9Cg/v6dr0kcnDrDkvj/F72YgqP5IfZ02UuxrqF
         ys/IW94yNBxT1eJAIXZ3+KDto2xQc+oOM2y0eh+9VPw0NHMs6VrGXne0Me7YOZxvHWgU
         cRDGr7rFFfOZhBerhEtsgepMw2pCisdyhyZN7WuFiATe44txix8Yiq9jiEosC0zHnl0J
         gG7fXBi2zEHsM8TQTLXDe+OK4B0XYYVS5lckdS7tlBL8RfTwTmPETKrUmkSb+jRFKir0
         iaRx549YfO+pTbjCfz7Qx5mT0SfcKe36+OhZJXJ5h8QN25/lqDuVSRXCEd0jJedE6r5C
         O4Sw==
X-Gm-Message-State: AOAM533RANDYpBmPeJLA20JmWgVv07YUOCCwjQbg0ScbKQbNw/wcwiRe
        yyBYQzdEaCfrmbbJECl6FQjsWMYlXg8mEg==
X-Google-Smtp-Source: ABdhPJxO/mtTbgmy1nD8nMTFgLL6497vV2JnStFZs0QtM7JwsS/oprJChT4/VGMtEtxFRF8B88YqdQ==
X-Received: by 2002:a2e:874c:: with SMTP id q12mr211483ljj.424.1608228590312;
        Thu, 17 Dec 2020 10:09:50 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c198sm655639lfg.265.2020.12.17.10.09.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:09:49 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id h205so16319219lfd.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 10:09:49 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr226223lji.48.1608228588898;
 Thu, 17 Dec 2020 10:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20201217161911.743222-1-axboe@kernel.dk>
In-Reply-To: <20201217161911.743222-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 10:09:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxQOBVZiX-OD9YC1ZkA-N4tG7sjtkWApY8Rtz4gb_k6Q@mail.gmail.com>
Message-ID: <CAHk-=wjxQOBVZiX-OD9YC1ZkA-N4tG7sjtkWApY8Rtz4gb_k6Q@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] fs: Support for LOOKUP_CACHED / RESOLVE_CACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 8:19 AM Jens Axboe <axboe@kernel.dk> wrote:
> [..]
> which shows a failed nonblock lookup, then punt to worker, and then we
> complete with fd == 4. This takes 65 usec in total. Re-running the same
> test case again:
> [..]
> shows the same request completing inline, also returning fd == 4. This
> takes 6 usec.

I think this example needs to be part of the git history - either move
it into the individual commits, or we just need to make sure it
doesn't get lost as a cover letter and ends up part of the merge
message.

Despite having seen the patch series so many times now, I'm still just
really impressed by how small and neat it is, considering the above
numbers, and considering just how problematic this case was
historically (ie I remember all the discussions we had about
nonblocking opens back in the days).

So I continue to go "this is the RightWay(tm)" just from that.

              Linus
