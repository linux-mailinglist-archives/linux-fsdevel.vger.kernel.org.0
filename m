Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1F26AD7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgIOTZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgIOTZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:25:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F1C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:25:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m5so4329457lfp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJ76vB6+4ycMBkD931QgS5Ukqdx5kxOnbEsbkPVkIJY=;
        b=K/ky+PYuwHYePx6OEBKns0EDkIr8nowBSRrpiET1hezMsa2hv3rsR9+InJ1nA1DgeP
         0a4AvpQh70LEMzRyqpbSEEzCp2BJhZFW9DEXqX3K41QwfFVydy5j7YOeYzsT7qixL2wL
         JXBW8/jfZbyeO9l02MHA96BInuP3nsCSINfDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJ76vB6+4ycMBkD931QgS5Ukqdx5kxOnbEsbkPVkIJY=;
        b=fdsjjn2XJ7x4Lto7DWUT3YcPxxHRcCM35BpAJC7EwMcdVcBm9xK/ZcNDnQ9k4xkQA8
         28O50EkwcKCMcpET+EQNI13iMnGj2j/Sa+0+u18iPyLJ7nOEZpY29dFrwvQvfXb54s6E
         1NZ0W0IoTc8OfmkVRtXOYQV71MZN93Qmw8bdqGyU5VGuv+f1s9pXgWwdcNZNPiEtJeJ6
         0ztrziqVSAa4/oS2WV9IjP6/wYuPT3BOEFNZhDHCB2SR2npQBBnhJ7T84XFdmRqZyexl
         zwnxB8my87i08BN50GSBIA7zoe+PZ602xQ4+BCvaikkqHC5bmbhRCdpahQUvQQ08f4bH
         ygjg==
X-Gm-Message-State: AOAM5336g3Or5RN731QATtpWYhRmju8HupqGYh0Yr2UqsI0+cXCb7yke
        8bSJq4MVjmQ6ZEV+EggVDP8jq1VY/naZpQ==
X-Google-Smtp-Source: ABdhPJyfDkSY9UePacCiGGmDKvO55eHEks9NrCJ5QhUoeLADJ14zqogJFLpc9myeeTPzsQz5IlyAMQ==
X-Received: by 2002:a05:6512:534:: with SMTP id o20mr5899442lfc.397.1600197911166;
        Tue, 15 Sep 2020 12:25:11 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s127sm4861638lja.119.2020.09.15.12.25.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:25:10 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a22so3800056ljp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:25:09 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr5176148ljj.102.1600197909019;
 Tue, 15 Sep 2020 12:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <9a92bf16-02c5-ba38-33c7-f350588ac874@tessares.net>
In-Reply-To: <9a92bf16-02c5-ba38-33c7-f350588ac874@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 12:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihcYiKwZQjwGd8eHLqMm=sL23a=fyzJ_u1YiFNsKN2AQ@mail.gmail.com>
Message-ID: <CAHk-=wihcYiKwZQjwGd8eHLqMm=sL23a=fyzJ_u1YiFNsKN2AQ@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 12:01 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Earlier today, I got one trace with 'sysrq-T' but it is more than 1100
> lines. It is attached to this email also with a version from
> "decode_stacktrace.sh", I hope that's alright.

Yeah, there's nothing interesting there.

The only relevant tasks seem to be the packetdrill ones that are
blocked on the page lock. I don't see anything that looks even
*remotely* like it could be holding a page lock and be waiting for
anything else.

A couple of pipe readers, a number of parents waiting on their
children, one futex waiter, one select loop.. Nothing at all
unexpected or remotely suspicious.

The packetdrill ones look very similar.

> I forgot one important thing, I was on top of David Miller's net-next
> branch by reflex. I can redo the traces on top of linux-next if needed.

Not likely an issue.

I'll go stare at the page lock code again to see if I've missed
anything. I still suspect it's a latent ABBA deadlock that is just
much *much* easier to trigger with the synchronous lock handoff, but I
don't see where it is.

I guess this is all fairly theoretical since we apparently need to do
that hybrid "limited fairness" patch anyway, and it fixes your issue,
but I hate not understanding the problem.

              Linus
