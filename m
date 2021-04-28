Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B0036DE9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbhD1Rrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbhD1Rrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:47:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE220C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 10:46:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 4so40676096lfp.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSp3pG8dXFozEXy+cySWLM8gnFTjSS+49BzY5lWcsD4=;
        b=SoQdTmzP6hzb9+P80G8+F5jiqD/LVHkhkbM5bIUW+QtlVU7Out24D0T1rY5WGKhZAJ
         9b5DVoXPEPnR/6JOe05sMyEYilISH6KZEqtWuzYqcwwP+vFIgD1AONe0sTGQ6Q8rA8zn
         piqb8rGU3Lkrf4gu1ZTe/T9NI4xgzS3hRJU/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSp3pG8dXFozEXy+cySWLM8gnFTjSS+49BzY5lWcsD4=;
        b=ZuHJaBpA2DGIWON71x+4wFQvkr2P+VGDHAPMt0a2AlqrO1VLf89vaWG38cK29LRTpU
         pp83Dm2HQS1j1Vgdxh/PVH+Z5d5kYcK/1dZCPdOq7RtpewBBYzuf+cmd0+TOxCkRC/cK
         wmtiM9e2HyA8DDFaHZngGTGxlIHPHKDRIj7z0gZsLORMjSRVpH01YsdRq0mp3yIQ1aJc
         E6tleqgJqk6STZtgQL0zfBJ/sZlI0N7f+0WCyI/pGQxKdVKbFHhE77BGKIBQQZFlnE3t
         k0SS6fpRdsdr809L4ofXFTm5X1C7hb/4iis0UCA2VLkHQHRnbAuBs0lBDqwGdaIaah7K
         9fXw==
X-Gm-Message-State: AOAM532IrVt76gHQOlfQQAiZkEdpUqlDwqhjM9SSdzqgydvoM3wuWixH
        cXO8z31ABirukyT15D5pzKINjrdfUP8Nkmj/
X-Google-Smtp-Source: ABdhPJxX9LsRsPzpzzYEF1BRHo2E5CPkSskWmitgXA+bXNFa0Jfoo8tV/qECjAW94Eq+M9027TZM6Q==
X-Received: by 2002:a05:6512:ba7:: with SMTP id b39mr14174156lfv.365.1619632012284;
        Wed, 28 Apr 2021 10:46:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k16sm119127lfu.214.2021.04.28.10.46.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 10:46:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 4so40675968lfp.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 10:46:51 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr3081254lfg.40.1619632010958;
 Wed, 28 Apr 2021 10:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210427183414.12499-1-arek_koz@o2.pl> <20210428061259.GA5084@lst.de>
 <9905352.nUPlyArG6x@swift.dev.arusekk.pl> <20210428130339.GA30329@lst.de>
In-Reply-To: <20210428130339.GA30329@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 10:46:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
Message-ID: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
Subject: Re: [PATCH] proc: Use seq_read_iter where possible
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arusekk <arek_koz@o2.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 6:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Unless Linus changed his mind just patching the file you care about for
> now seems like the best idea.

I'm ok with expanding splice() use, but I do want it to be on a
case-by-case basis and with comments about what actually used splice()
in the odd circumstances.

Our splice infrastructure is probably a lot safer than it used to be
now that set_fs() is gone, but splice() on odd files does remain
historically a source of not just bugs, but bugs that were security
issues.

So it's mainly a "once bitten, twice shy" thing for me, which is why
I'm more than happy to extend splice(), but want to do so in a very
careful and controlled - and documented - manner, rather than the old
situation where "pretty much everything can do splice, whether it
actually works or not".

                 Linus
