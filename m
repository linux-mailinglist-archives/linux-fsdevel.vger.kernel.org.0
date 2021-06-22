Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C93B0D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFVS7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhFVS7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:59:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89DC061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:57:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d25so3511245lji.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPk7T/ftbiBmPf+o6AYQ5V0HnU5NGPQBeJe2s6miHI8=;
        b=VhTAedbTxJDC60DaO13KHKxcUeyU8ENl3RSl3vIntzzeRYtWM0BVNQZJ7sDNpmRFQO
         Ucorn0ijH5dvTGTuXlecFzoOE2aDg/bX3NnRpMk0K++RjVnfO6xG9mcKG8RMdHCWoqbH
         9yUMAp0MAks+wmHiCn2j+g4RTxHlsJd0MRqpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPk7T/ftbiBmPf+o6AYQ5V0HnU5NGPQBeJe2s6miHI8=;
        b=sslq2Az9fk7TYLbS7Py35tA0+UV3iuGqO5gdXEUkNPNBDF4ZJ7pm7pQylPJmW0GN0o
         v8T7S1r1lL4vDCtBtN7J15bFmcWNqFlGGGAVMhYlMn5lq8SvamY7LTgB+H4gpC83eyhg
         h64MCZvzsS+KGVxc5ymw0SnlpfLehVah3X4+U70KikfPjELbl2FGg2vXBBu1OLEDxWz8
         SU4b28jaUb+HKR3K/LpPiELPF3NQcL6FTmZjVAr7NciBU/qGs5BTwrqqz74WJHm1MJVx
         ygBVjK5VmUm/mHP/RhOqPR8XOze63pGt8oJgSZtWq7o3cp3sO1by70O0dv/6cVdx71cB
         9qiA==
X-Gm-Message-State: AOAM532TQAaRs4xXX2WwwbgtHU8EHOgUFx7jjGrV9E9mriSlON6KcaUL
        XVTGT2BgkYK1JHdQTrNeAL7S9QiWIDxNh0mm91Y=
X-Google-Smtp-Source: ABdhPJz2iwNayVbl24YVZyGYukKQ4oETTLf/BEeCywsOyVBXO6gsaBEMB/ZmS7qwKRlEOKkvWhxgLA==
X-Received: by 2002:a2e:8684:: with SMTP id l4mr3150431lji.175.1624388248344;
        Tue, 22 Jun 2021 11:57:28 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m16sm2465981lfl.300.2021.06.22.11.57.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:57:27 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a16so10063624ljq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:57:26 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr4487018lji.251.1624388246482;
 Tue, 22 Jun 2021 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
 <YNIqjhsvEms6+vk9@casper.infradead.org> <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
 <YNItqqZA9Y1wOnZY@casper.infradead.org> <F78E1A78-DB7E-4F3A-8C7C-842AA757E4FE@gmail.com>
In-Reply-To: <F78E1A78-DB7E-4F3A-8C7C-842AA757E4FE@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:57:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDyrOMJMZBxtTUaMeuSd_dafiR_DFCwsLSbJuLwEuYsw@mail.gmail.com>
Message-ID: <CAHk-=whDyrOMJMZBxtTUaMeuSd_dafiR_DFCwsLSbJuLwEuYsw@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Jun 22, 2021 at 11:51 AM Nadav Amit <nadav.amit@gmail.com> wrote:
> Just reminding the alternative (in the RFC that I mentioned before):
> a vDSO exception table entry for a memory accessing function in the
> vDSO. It then behaves as a sort of MADV_WILLNEED for the faulting
> page if an exception is triggered. Unlike MADV_WILLNEED it maps the
> page if no IO is needed. It can return through a register whether
> the page was present or not.

Yeah, that looks like a user-space equivalent.

And thanks to the vdso, it doesn't need to support all architectures.
Unlike a kernel model would (but yes, a kernel model could then have a
fallback for the non-prefetching synchronous case instead, so I guess
we could just do one architecture at a time).

               Linus
