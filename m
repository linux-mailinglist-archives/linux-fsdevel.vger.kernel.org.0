Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4EECB1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfKAWMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 18:12:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36975 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfKAWMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id b20so8256790lfp.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=O3mYYvlU9vmiWCuVM7D5zeynWjET9sBTNe2UP3ZA3GeXbBriHFMqoPk2kJgyTgcAeI
         BstBtBLU16kkJaWSMcP9+57VaYHHgUIqojJCqULremk/l27m2Dlyko2Sd9hhC3Y74UKd
         ZPG4og+yRVtEHOd/O+5D/qMCxYtxUKUSxHi24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=txC0ffyZ43/pRXbeHE0gXjdGIjD2LycBidPicLXPvZar/vZHYE0z4HnC54lE+lCIO8
         JKE7AFmcfPyLVYXOoD7KJYA8SrS6y6czBGZ6+wyrjTAutmBfsfPhYsNAJv2nBkAfyIm5
         kUqN0+rR+Jv708jZ91N5aRNEF+1UR0GlX9ajG8ESlTP+OShucF21s8dVZIQl/H0raeTE
         uQNxbJn2cor/Y9OZY1LkgHUdWBND7juiyIbiFC2zQJsS3Lo3DkUNJb2Qg5ZDSZRWxdPP
         XFAORlUmeGzQ24d71/D5isLvqjFpBA+dr3u7pDoizXfYmInCROZd8U4oL+E9370Ybnfb
         KYTA==
X-Gm-Message-State: APjAAAV9Lmxky2S9+D6UiVNKyQfWLHLxq/Xq3Bp+tEOX/yDkFDsr8wlm
        E5JvlcISFT4LyjTUSOIv7RqN0bLF7lo=
X-Google-Smtp-Source: APXvYqzXjg3KcStV4INMFTr23eKS3WmA0Z9HwUx+1snMRwBGgyKX6A7D8s2MxeuDnnMlvmDJkgA14w==
X-Received: by 2002:ac2:4651:: with SMTP id s17mr605871lfo.46.1572646360518;
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t135sm3285632lff.70.2019.11.01.15.12.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f5so8263525lfp.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr8678681lfc.79.1572646359613;
 Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
 <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <13964.1572645926@warthog.procyon.org.uk>
In-Reply-To: <13964.1572645926@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 1, 2019 at 3:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Changing those to non-sync:

Your benchmark seems very insensitive to just about any changes.

I suspect it is because you only test throughput. Latency is what the
pipe wakeup has been optimized for, and which tends to be much more
sensitive to other changes too (eg locking).

That said, I'm not convinced a latency test would show much either.

               Linus
