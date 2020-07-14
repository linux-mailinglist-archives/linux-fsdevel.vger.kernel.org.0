Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2421FD72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGNTfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:35:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A1C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so24998469ljl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=KIYXfollvDwZIWSi8MBvzI16dhsw+y4zL9hnXlh1UD0SE8cjPtPzh3zCIWaf7usmKY
         sJIPvwRi57eB+/xJI+6JaFihnvlQfFnptYDDF1G9FGiSyn3r0SxvQFRYD3v6hzm4/QTE
         v64cADt8D/wtG1AQ2083itD+hTnNb9/mL5p7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=Ib2kMFWakSEKaGXMb8GV9YMiVSgS1tFlrar9UDWZ9DU7RGMmAcS02ekcA0pOLqdAzN
         j3plipgixYGijPTGFBayDb7y9bcJnmBjWeESZDj3aCucHAOFHbaWifVvd3ISEyu0MTBi
         G4flugpSZ/YdV4EDXBRC0t9Tcd58UF+PS09BTNqzEsPDdI3G6x5zJ68bYYBopF0vY7Hz
         jHndV17kDBQ1Rf+mtlAOuhXX9vqUeyJIVWenjvdaA19D1Q7A17gnjlTtyelWoWcVG2Nm
         9HrjDdUl6cXvv6dw4s9FTpOL403/JoQB5G/0WrUOytDD8SvoKOBk1awHGmEVCXVdmMvo
         k+wQ==
X-Gm-Message-State: AOAM531nKiRhfA4GvlqcNMgNAsE+QFb4iir+Es7/NPbbB8qJ0Z3iglXq
        xSGIBmgnTG5Oef2RH3y12ZjanNN4H+U=
X-Google-Smtp-Source: ABdhPJxwWNlj0ksdyScDUVZTel8koRjk4JTDhlxPCiDKFnHnrduNZFaAIC0HTSbzBYXTLtp+hGLB1Q==
X-Received: by 2002:a2e:b054:: with SMTP id d20mr2853501ljl.55.1594755303217;
        Tue, 14 Jul 2020 12:35:03 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x17sm5498456lfe.44.2020.07.14.12.35.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t9so13088330lfl.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr2908470lfd.31.1594755301618;
 Tue, 14 Jul 2020 12:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de>
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:34:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series starts to move the early init code away from requiring
> KERNEL_DS to be implicitly set during early startup.  It does so by
> first removing legacy unused cruft, and the switches away the code
> from struct file based APIs to our more usual in-kernel APIs.

Looks good to me, with the added note on the utimes cruft too as a
further cleanup (separate patch).

So you can add my acked-by.

I _would_ like the md parts to get a few more acks. I see the one from
Song Liu, anybody else in md land willing to go through those patches?
They were the bulk of it, and the least obvious to me because I don't
know that code at all?

              Linus
