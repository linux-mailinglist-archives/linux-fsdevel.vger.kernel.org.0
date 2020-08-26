Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963862535D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHZRPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZRPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:15:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A4C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so1404436lfi.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP9JT9RZ6cg16XibPhu1WP9qLmnAItWF0Fa2z1UMDZI=;
        b=gnE/PuzwUiR5nbYEU0P+4LWH2qyES1j1Z881X6oEA+lavFprJsQaKzOFd9+1tsnfM+
         e9OfyrazJJTWB/GksaUDWytv75fKgS0GnX+tCaBCitTlh8Ksllt4L6s2t89+ILGxAL4S
         TMmZy2nzqRMYH+qmpOU92kllkom8B8DMMf7fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP9JT9RZ6cg16XibPhu1WP9qLmnAItWF0Fa2z1UMDZI=;
        b=cCxLZHgDRf4L+6McXZSTtXXSNtYWV3vIylKyn2G08fmCS4RyIE8j5jT9lYVj+qZksq
         VUhNbtW4YMuzE5USBbSdIQaNlDqEfH90abS/Oza0wr3tF5Mfq797acRF/CZIwMxbsG1F
         /Oo6F7IW8tUKlRHLsjCQkFVK6PmaXcVTceaABpyph86LrO7CodRVmLvR+b+0dLzQUzM6
         5EE/NL1ni1nYrfIZxfxVfU6l9ahZAxqFttgx0S868lQXzGdjHXeTxOAn66ZrklagQLqD
         uYItj1QDqWjkaUdk8KkTiwU60pdGHB5PuurxTD+TJi3kTXGWA/jyPesa3MAEp8dU2lNY
         B6QA==
X-Gm-Message-State: AOAM531rdglts/av19k9AH6r2OhfiNpJ0DBrLrNE+5WTG/R+iMgXGlT0
        M1KOR6MsvbrIhwNfNnW5vBC/MWjSmGJoTw==
X-Google-Smtp-Source: ABdhPJy4/cckOCCsaqJr3fPGahB4q2s5W+jaawlVe1/VkfgU2hG+s5AxoiTykMlKWFWzSnheBFks+Q==
X-Received: by 2002:a19:8856:: with SMTP id k83mr7826470lfd.131.1598462108973;
        Wed, 26 Aug 2020 10:15:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g1sm625009ljj.56.2020.08.26.10.15.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m22so3243517ljj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr7171003ljh.70.1598462107068;
 Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com> <20200826151448.3404695-5-jannh@google.com>
In-Reply-To: <20200826151448.3404695-5-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 10:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYkiyOKvBG96EaP5BgXeppXVC2rPv56bhBR27C9sbDLA@mail.gmail.com>
Message-ID: <CAHk-=whYkiyOKvBG96EaP5BgXeppXVC2rPv56bhBR27C9sbDLA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:15 AM Jann Horn <jannh@google.com> wrote:
>
> A downside of this approach is that we now need a bigger amount of kernel
> memory per userspace VMA in the normal ELF case, and that we need O(n)
> kernel memory in the FDPIC ELF case at all; but 40 bytes per VMA shouldn't
> be terribly bad.

So this looks much simpler now.

But it also makes it more obvious how that dump-size callback is kind
of pointless. Why does elf_fdpic have different heuristics than
regular elf? And not in meaningful ways - the heuristics look
basically identical, just with different logging and probably random
other differences that  have mostly just grown over time.

So rather than the callback function pointer, I think you should just
copy the ELF version of the dump_size() logic, and get rid of a very
odd and strange callback.

But even in this form, at least this patch doesn't make the code look
_worse_ than it used to, so while I would like to see a further
cleanup I no longer dislike it.

              Linus
