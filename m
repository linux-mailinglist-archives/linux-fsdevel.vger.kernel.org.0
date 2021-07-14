Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5F3C91DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhGNULk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244371AbhGNULK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:11:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD9C0251B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y42so5709872lfa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjVQmrIVGwltwK1r5dkwsbhATiXC528RkYBjqLevFP0=;
        b=Ox4QzPp+RQGEZBJFDxx5UYrPFN4p4RoiXXBT+FyFJWV6ZUXeoxj+gDImRM83J1ujqR
         ei6/kbKym7FZaiPdTn+r7szeDcTdbY6Zm6YmOauIZ3I7GkaFkjgekcuAsVzTmnnWq7SJ
         SFvm/+rZ1ixzb9T0YIytnbpcK0kdy+Pmpgir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjVQmrIVGwltwK1r5dkwsbhATiXC528RkYBjqLevFP0=;
        b=ohGwvAOghiKue574yEcObydkkWfVi70i/5sTN2daUJuCItxHZByo0Ge+JhuXgoJdlw
         fHr8VgoTk1soaCeCdUepMByVjH8azYixapIPtz2isWTnoWj5hNht7RBgFYXpblApkNYP
         HVbdoaQKrLW8rt0PiI0xXazJv3QXyAtIcIL/NmXvVFvo11XaM+xnTwUW31I4z5Q39rFj
         FxHVni8R2ocm8grxD2k/PF+IJ072Ji/dxvqW3IyEiMXJ5ALFirQqzkAko/13ADFZiOXb
         7SqOQi/PvSRt9PMGJ7bnGQcqiVmm39hxM7GPHv6iGDqu4ssZZMljnyBB4O/ZgLoAAqBT
         Itig==
X-Gm-Message-State: AOAM531dTUsk6C6VEVwVpBvDbdm4MmMl2fBk1kSSKSik0e3kWTfI9xMb
        0zSk3ueKr8mmqSNQ9pyjlwwKeksaczqimo6g
X-Google-Smtp-Source: ABdhPJzKKXD5e3k7zaq8g+6waXmgGPr4y4sLCbmVtr324f9EioSMFnfoTdyqjL6/qTh8vS+DzqKwrg==
X-Received: by 2002:a05:6512:3745:: with SMTP id a5mr23245lfs.478.1626293125600;
        Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d7sm148544ljq.112.2021.07.14.13.05.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 22so5634005lfy.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr32339lfk.40.1626293124769;
 Wed, 14 Jul 2021 13:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <YO8Rw23KxCDjzKeA@infradead.org>
In-Reply-To: <YO8Rw23KxCDjzKeA@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 13:05:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
Message-ID: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 9:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> configfs fix for Linux 5.14
>
>  - fix the read and write iterators (Bart Van Assche)

I've pulled this, but I'm somewhat disgusted by it.

The overflow "protection" is just wrong:

+       to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
+       if (to_copy <= 0)
+               return 0;

because if users control "pos", then that "to_copy" could be a huge
positive value even after overflow protection.

I hope/think that we always end up checking 'pos' in the VFS layer so
that this isn't a bug in practice, but people - the above is just
fundamentally bad code.

It's simply not the correct way to check limits. It does it badly, and
it's hard to read (*).

If you want to check limits, then do it (a) the obvious way and (b) right.

Something like

        if (pos < 0 || pos >= SIMPLE_ATTR_SIZE - 1)
                return 0;
        to_copy = SIMPLE_ATTR_SIZE - 1 - pos;

would have been a hell of a lot more obvious, would have been CORRECT,
and a compiler would likely be able to equally good code for it.

Doing a "x <0 || x > C" test is actually nice and cheap, and compilers
should all be smart enough to turn it into a single (unsigned)
comparison.

Possibly it even generates better code, since "to_copy" could then -
and should - no longer be a 64-bit loff_t, since it's pointless. We've
just checked the range of the values, so it can be the natural size
for the machine.

Although from a small test, gcc does seem to be too simple to take
advantage of that, and on 32-bit x86 it does the range check using
64-bit arithmetic even when unnecessary (it should just check "are the
upper 32 bits zero" rather than play around with doing a 64-bit
sub/sbb - I'm surprised, because I thought gcc already knew about
this, but maybe compiler people are starting to forget about 32-bit
stuff too).

But even if the compiler doesn't figure it out, the simple "just check
the limits" is a lot more readable for humans, and avoids the whole
overflow issue. And maybe some compilers will do better at it.

            Linus

(*) Ok, it's easy to read if you ignore the overflow possibility. IOW,
it's easy to read WRONG.
