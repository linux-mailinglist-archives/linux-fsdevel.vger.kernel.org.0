Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81AA28C179
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391179AbgJLT3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgJLT3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:29:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25BFC0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f21so17987311ljh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=Sg/dv0+6q/T5D5BigWu87HiS3Oyz1Gx2mRS8WRM0qJR+ZvzBax9hT9Li7FBVJE0ydo
         qxNsvOzo9+2aL74hch0pe/IBE/A3RgBB2mlynpMG99k3j8N5fOXAJq6TsU1kqDdSiWNJ
         88IXcUyrzO2MAL00aCNG8np3MdgE/b4+Tqkog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=PHrxEszgqbtisaa+z5m9g+ctTUe3w+d6Vczj8wQdb5csJSTFYpOnomG18q3VBjYQFA
         jTSH/N3R44dDPGenTHgqPS1gwqXwNT6FWdjtAL1KMjEPaXXjuzp68bceNQh068dKbU7w
         Myd/pZ+ftuxbNtHJbB26UXOlU+LSC87PcdLyXif7fjMPuhleAznsNs+Sfd92qtlkKVvz
         k8jmBRoHiwI/F5X1fF1rUisIaBQK7/uLFapMxOHUDctlX4iTzH1QFHQP/fOEZAgNm5iv
         zfWWuwoRd4yfLK+COJ6HgKCTkD2VmSQSgQxqvAPhTo8KuLD8dzAisrP3+1q7NnHUYjru
         9KMg==
X-Gm-Message-State: AOAM533rsjnEQYfE9iXHWGcT9PK1X8cTeQLyp0kYQBbzlPs3MbJCkHSw
        m92ct/VUlVVrlSYJlzOgHZeyCuwYAU3Dww==
X-Google-Smtp-Source: ABdhPJwyQPBG/EcDr7xQTZjjD2rqcDduywoepeDaOV43JZWhZZJn78RLqgUTZHp8lSYBRw+GmTmU8A==
X-Received: by 2002:a2e:8986:: with SMTP id c6mr2465716lji.29.1602530935740;
        Mon, 12 Oct 2020 12:28:55 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e73sm3540092lfd.199.2020.10.12.12.28.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id c21so17955072ljn.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr10194176ljg.421.1602530934167;
 Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Alexander Viro <aviro@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not [..]

That "writers" should be "readers", of course.

Although yes, that commit changed it for both readers and writers: if
the pipe was readable from before, then a writer adding new data to it
doesn't make it "more readable". Similarly, if a pipe was writable
before, and a reader made even more room in it, the pipe didn't get
"more writable".

So that commit removes the pointless extra wakeup calls that don't
actually make any sense (and that gave incorrect edges to the some
EPOLL case that saw an edge that didn't actually exist).

              Linus
