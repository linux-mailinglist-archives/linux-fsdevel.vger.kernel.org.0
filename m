Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935183BB46B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 01:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhGDXhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDXhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 19:37:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E54C061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 16:35:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k8so22106481lja.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 16:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwMcQsym/BEPzMP2lbVzmNvoE0udGzyI6q7NPfbPtIc=;
        b=WEsJAbGMCTNJpCXKUPPJBHuRCQPKS8NO5qmQnMl1WajTYa84eaq41xkNqXX3etfh/b
         Ad1SmEp+4xqdqX8kmTQkSQk3fy9ekNTShj/T+viMDjMcxoebUpSs4Kk8d4k3eROTOp6y
         TkDUqyCsRYFcQxf+vSZY2Xgwu0j/rhgh+GFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwMcQsym/BEPzMP2lbVzmNvoE0udGzyI6q7NPfbPtIc=;
        b=kYRfQxo/emKOH5wMPWzfOSR3YMqWdxHob1rABVSe+TZ8wsy7nc9L78cFrB35rEAC0H
         j1iXUCZn9huNwLBPPFFy5q05RfZ44CIdNGN5WRmyibVRXZl6g+RaYCMZQmP0zvSdHKvG
         rZPQ6e9DnBBLFNq3fUvz+IEf+wmxo5k9+6O9xj1pIJ3zmD3miCB3kCiMtrg34cpy3fmZ
         +wukGLoc6zZZNJTDYX0LTDKLl9moqq560TIjosCAmw2bXAgV5MuiOpKLW6rOEzKMw9KD
         TVPeQNyT1d8NDLlMRPmBMjXiiHsSWeA1r1mtwhD0+uGdZPTyiNFXw/69Jp0X8jvZ+AZD
         gPsw==
X-Gm-Message-State: AOAM530uucN4af3SzspNwj1OHDvKioOOi9scis1/XkyE9WwTsbb6hL7k
        WbNIU0M1SrAAbM7t520E/DRl8TA2Tr3QOoFr
X-Google-Smtp-Source: ABdhPJzFjXy/mKZsj1atrbjh/JxHbOWjEJvIvo/1GAFkBA4zaenQvWjXuLnyfHRPTqdsVL25XdE0Ng==
X-Received: by 2002:a2e:7002:: with SMTP id l2mr8623987ljc.374.1625441715054;
        Sun, 04 Jul 2021 16:35:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j5sm908387lfe.124.2021.07.04.16.35.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 16:35:14 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id e3so13681794ljo.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 16:35:14 -0700 (PDT)
X-Received: by 2002:a2e:50b:: with SMTP id 11mr9098341ljf.220.1625441714149;
 Sun, 04 Jul 2021 16:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net> <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
 <YOI6cES6C0vTS/DU@casper.infradead.org> <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
In-Reply-To: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 16:34:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_L071F_-jRBLs--_0_g5Hmnr+Gt36kYqDdP_5j_UxMg@mail.gmail.com>
Message-ID: <CAHk-=wh_L071F_-jRBLs--_0_g5Hmnr+Gt36kYqDdP_5j_UxMg@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 4, 2021 at 3:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it had been easy to fix I'd have kept it, but this amount of pain
> isn't worth it - I just don't want to add extra code for architectures
> that do things wrong and don't really matter any more.

Ok, removed:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a180bd1d7e16173d965b263c5a536aa40afa2a2a

where 99% of the work was writing that commit message ;)

              Linus
