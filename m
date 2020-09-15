Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26126ABFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIOSco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgIOSbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:31:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5BC061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:31:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so3684276ljg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dfn+wAryn8C6DCMRnpMqu5m74tYawQDjyF9URZVbit4=;
        b=KytikPFX2ltfGBuVNpKqIMWZkBuq7chmhFwJK4wg3F9rWrqDBv7uB9WDavsBoHoyUE
         wj2KWBLT+0RefUd1HoTSg6Ue4AUM1cNQKEd6Nhs7R6AeUsgwnk/hSGaz84Tr764/Q66H
         b+egq4Eo3V9tr9aRJcHnwjPJozP0YCOTZxh3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dfn+wAryn8C6DCMRnpMqu5m74tYawQDjyF9URZVbit4=;
        b=Kq1HVpK9MLTJqLhMiUAnhTfAKL+6dE8i3mOEE0396nQ19/eGO3i97YxxbUnI0Y/C4a
         2UeqxTD2xDkRIvUeu0Q3F9jmVhNBg+3ugKstsvX0rVVsR6xwT+gIEVOswTDQx5sx5S2s
         kBaiwVb3ily/4NRxuxO+HDrwiksko9JSj3jWhTQnFO2a/xHmw+6CvFPMEiGK+OUdsOq1
         Mf/GlxZKFmlNQAInsALGS7bLtI6ZHwzDhNU59ye5ioKDL6zX2aC2qnN3pDseYA5zvtZ7
         2L/DlRz5a7x/MxmSaPWPKzPDZn9A2kbU7hVxZKSIxgJD43ho6I36jqWbQ5sPtJXvOmO/
         aFAg==
X-Gm-Message-State: AOAM531h5ZEiFkUiW6NjNF5Zs4j2vVGpr0zJanf8joaMOGQCxCK7uy53
        LbwcziUewTTWELSCz6LJA94b0sl5WucdOQ==
X-Google-Smtp-Source: ABdhPJzYLHs1AqJaJrg6jnorUo1yzm7ToGoHCxBwMIjwWHPEbsGXPPowLOE7PYulznj3P3uyMr4QAg==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr7710807ljj.50.1600194699651;
        Tue, 15 Sep 2020 11:31:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u17sm4478635lfi.2.2020.09.15.11.31.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k25so3749586ljk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr7823371ljm.285.1600194698099;
 Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
In-Reply-To: <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 11:31:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH37sXgMC+0UtLceOUJry2FBa_G3j726TP4n69jeB80w@mail.gmail.com>
Message-ID: <CAHk-=wiH37sXgMC+0UtLceOUJry2FBa_G3j726TP4n69jeB80w@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 8:34 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> One more thing, only when I have the issue, I can also see this kernel
> message that seems clearly linked:
>
>    [    7.198259] sched: RT throttling activated

Hmm. It does seem like this might be related and a clue, but you'd
have to ask the RT folks what the likely cause is and how to debug
things.. Not my area.

                 Linus
