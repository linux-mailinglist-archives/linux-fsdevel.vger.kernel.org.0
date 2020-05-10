Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3A1CC5D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEJA6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 20:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgEJA6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 20:58:17 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB02C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 17:58:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b26so4459178lfa.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkZLcTT9RBY1m/QfLNMtrzusV0je4e07ARSIXoWJWAs=;
        b=d/2jdVrvgvUG1UThwodilkmvnh6my87EM5v+b/nlwmeKZnUZXYHkZAIUuMw3tlQv+1
         q/ha6tP9/sPPm8KxNNtA2UNJcsiCwaT0kATyI1wURIHH2V5stXNXYcwwkUyQkiH3EkZG
         c464fO9/sbq6hmzNqCDH3RO5ythUdJ6Kr0pe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkZLcTT9RBY1m/QfLNMtrzusV0je4e07ARSIXoWJWAs=;
        b=smdHZIMhzliQPrlYsRUdg3qumT9sNBzr4+zw3+6o1w9wyTjG4tojOucNaEnjhlVeWI
         na4mWcFti53ynjAMawbWISaE25iNhn0h0R+vBgSVETRbjMOb4O6uODksfbs3rVfEEcUS
         b4nPXncKtpHxC6jNI8aMIFBxogp6/ycbfW1/mVy/I3RQK4DwnxBniKCGyA/x+ruLqcMv
         xM6a6A6NuZhujHIxcmzPjZjjZ7gqywBPSvVPEUBh73cqOFddUtsxbdIz+us9tVcoqVME
         2vjJhjXkOhvtpP9qbFV+A/06JCDO8SONPc9N3WqEQfui4dKIqnH5ey2xTXlh7WuMJWvm
         vP5w==
X-Gm-Message-State: AOAM533qW8nTeA5y0G315jTekEsCUpOPe4ZgNkfFWFu+Nvez3wVn6ydu
        nn4SAeHh829diNrIuFwoezjBnnmfrcY=
X-Google-Smtp-Source: ABdhPJyE+deF5bm+lsVzuozhi3wYAhUyTBLUgOwm70/5JAQ+PBnumm2aiOH7Xj58jKQ+ioKWSeQLPg==
X-Received: by 2002:ac2:599b:: with SMTP id w27mr616112lfn.164.1589072293582;
        Sat, 09 May 2020 17:58:13 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t13sm5170619ljd.38.2020.05.09.17.58.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:58:12 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f18so5622201lja.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 17:58:12 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr5900390ljj.241.1589072292121;
 Sat, 09 May 2020 17:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200509234124.GM23230@ZenIV.linux.org.uk> <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk> <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
In-Reply-To: <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 17:57:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Message-ID: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless access_ok()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 9, 2020 at 5:51 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I think that this access_ok() check helps reducing partial writes (either
> "whole amount was processed" or "not processed at all" unless -ENOMEM).

No it doesn't.

"access_ok()" only checks the range being a valid user address range.

It doesn't actually help at all if the worry is "what if we take a
page fault in the middle".  Because it simply doesn't check those
kinds of things.

Now, if somebody passes actual invalid ranges (ie kernel addresses or
other crazy stuff), they only have themselves to blame. The invalid
range will be noticed when actually doing the user copy, and then
you'll get EFAULT there. But there's no point in trying to figure that
out early - it's only adding overhead, and it doesn't help any normal
case.

                  Linus
