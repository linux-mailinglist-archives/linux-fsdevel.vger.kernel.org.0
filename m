Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242AE3B0CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFVSeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhFVSef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:34:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C93DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a16so9966942ljq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=NP4S1TsIF9h2rPtpSgvjlnlXPEzV1Eg6DWYa5iK2q6AtxYQkNIkoYmNrE9B5XO/S4e
         HF1VEmrSrJFoleJ4FjX+FsvMVqxeW7ygtwWfM8q4P8/YZWbLfBROiuS/kumnsSNRhqqv
         IWq+2Kwg/HRFdIwqvLmKhyArAFRW+GJQTx+1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=qQzAU66YIhMaLnRtWuN0jV9ji0oFDuDPrSQZouRKs6AZ2OKMeSooM7uJIzfJyquT7J
         I4t8vEq5mVpYBj4I6K/rLcROG+JNpnZy7B3hmvgkWdTAQsh4WN2BlAnje8DeuwzGsiv/
         Q3OHhRvB4PUe+PpKXcfbFuOSh/K4+vLN53Bu4oWlBZQ0Urcq1rqlGJ1mqSq3WK/BN6Cb
         +i1xscLAO7U5aJ8u5D0B4d5HDqqoYRpVY4+Ec7rnUcyYho9nX9Jxm6OfsIivcmzxN0Hw
         bfBPgUfyTycfJMVretPAAc61rQhoBtit74i064zhiXqcdPm0P3eDJzooyUz5xHuZZgrz
         OaiA==
X-Gm-Message-State: AOAM530YqogRbuVqrIIU9l+IMpefw9yBH2qKjRjDKVEvdnOfpLm2r4sJ
        Ghu2HzvenYhyFWEJ7wloMI74fmI0XzNK9dDEb3E=
X-Google-Smtp-Source: ABdhPJxP84Hmo00dVhFms0W2w025A+uqyo/X6XSvErZ6U01caJZgz72grBpgJDtM/P5hsj4vwzDogg==
X-Received: by 2002:a2e:90c8:: with SMTP id o8mr4487686ljg.127.1624386737344;
        Tue, 22 Jun 2021 11:32:17 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n2sm1193278lfq.43.2021.06.22.11.32.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x24so37490540lfr.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3809268lfc.201.1624386736181;
 Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <3233312.1624386204@warthog.procyon.org.uk>
In-Reply-To: <3233312.1624386204@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:23 AM David Howells <dhowells@redhat.com> wrote:
>
> Probably the most obvious way would be to set a flag in task_struct saying
> what you're doing and have the point that would otherwise wait for the page to
> become unlocked skip to the fault fixup code if the page is locked after
> ->readahead() has been invoked and the flag is set, then use get_user() in
> iov_iter_fault_in_readable().

Yeah, the existing user access exception handling code _almost_
handles it, except for one thing: you'd need to have some way to
distinguish between "prefetch successful" and "fault failed".

And yeah, I guess it could be a flag in task_struct, but at that point
my gag reflex starts acting up.

               Linus
