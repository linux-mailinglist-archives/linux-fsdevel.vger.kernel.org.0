Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155F4207B42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405942AbgFXSMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405761AbgFXSML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:12:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E0C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so3411ljp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5O34Bhu+mXlljW4o1n6jAUtWoAilwwsuuBTtWM5EkM=;
        b=X5q/JuuAXzg5cLEyj9l4hKnog2zLaFr6cPK5cIKZiYO1/ckVvp/JHr+ds9iPiDjB+2
         hcA8637lcsrPk11j//mj62+mDzxeVnrD1z58Kyi/e3QQBd8UhOM4HlUaGtI/ZNsmRYg6
         dF2K+SB970XHvOOxNG1Iyqt+exYASwGWsUUTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5O34Bhu+mXlljW4o1n6jAUtWoAilwwsuuBTtWM5EkM=;
        b=GeELHsMo7IoF2i7/S84OrmeiMVQTeA5IMnsuO1SReAlaEJiAcQbUCUrhAu2//rnW4y
         Z4NxQ0SYdK6fL60zevTl/wEggQgf6637pnYQzh4vK4zsKSO2fK1ZQwitEGw7x+WkhfEL
         Iqoj5j/nffaLO1kl+g/imp5epLssKrtOGyQseiKI4WIsLCWUeDfS5ckSbzZ614B9Zdrq
         S4eskkIhir9+hXsr7b7703ojoJwrEszfbANCwQcTMaS6oYFcj48mpJHyTYom6rxrw+BA
         oKETspEG9gvHMkOMTaogm35Q1vNEKAscfLGV62TQuIS24rttzfzJyWuz+f3TKSzHuvfA
         UmAg==
X-Gm-Message-State: AOAM533wxMzdEdqrx0sc/hfKGoG1OnojOR60mcKjMQt+JQHsjKRdnbuP
        +5wpw7FXChGsVV3MxwIKNVAqJwuHmyo=
X-Google-Smtp-Source: ABdhPJx08qFopM6lJU11zWV25hfvV97x6Qi6MFgrW6vQeIZFI5Qr8fKjmbBFcnBW5sX75gLzeBoAbA==
X-Received: by 2002:a05:651c:2050:: with SMTP id t16mr13253880ljo.178.1593022327911;
        Wed, 24 Jun 2020 11:12:07 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d8sm5395060lfa.16.2020.06.24.11.12.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:12:07 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s9so3582952ljm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:06 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr14351650ljk.314.1593022326362;
 Wed, 24 Jun 2020 11:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de>
In-Reply-To: <20200624175548.GA25939@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:11:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
Message-ID: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I don't care at all.  Based on our previous chat I assumed you
> wanted something like this.  We might still need the uptr_t for
> setsockopt, though.

No.

What I mean was *not* something like uptr_t.

Just keep the existing "set_fs()". It's not harmful if it's only used
occasionally. We should rename it once it's rare enough, though.

Then, make the following changes:

 - all the normal user access functions stop caring. They use
TASK_SIZE_MAX and are done with it. They basically stop reacting to
set_fs().

 - then, we can have a few *very* specific cases (like setsockopt,
maybe some random read/write) that we teach to use the new set_fs()
thing.

So in *those* cases, we'd basically just do "oh, ok, we are supposed
to use a kernel pointer" based on the setfs value.

IOW, I mean tto do something much more gradual. No new interfaces, no
new types, just a couple of (very clearly marked!) cases of the legacy
set_fs() behavior.

                Linus
