Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C891E8C64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgE2X6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgE2X6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:58:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC24C08C5C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:58:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so702427lfc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9oRh5gR3+qwNsKnzAdgLcqnQbIduR2IcrLYYdPrX+E=;
        b=Bc015UgtNqPTOb/2Z/1EwgCOiwCzM8LFM0oFPwrImmq9COeq6AaRHeFZ7XNbaJXOzR
         yuIX57HkJ+DvmHyIfYOst/p93Hvbf30yU/xsV+mGG5dsjrRw23QEIGIaKVJCRrgX6t9E
         eiIgE0RztbY+cy0h1XhuzL+q9dBTwYq5UHUrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9oRh5gR3+qwNsKnzAdgLcqnQbIduR2IcrLYYdPrX+E=;
        b=r+m5bypZrVPd59EakCKau3cpB4s+dqpGh4hshS/8lvAUoXCzi7QNKweMmI0T+G1vA0
         yO+XLNwsrIzYUXdoRguzgM2g4e9rs8Q/tT+jf8kWOEeZyNcO1FXAuYenNb0Lu6/zahII
         1vW4GgZo/HpQ8QEGkPeMGsmJvn9f3qAMKVs+lRtdoQBqsBlLoNjSMD2IrS893aP7iVVe
         dP3Jk7CLR8s1TEmv1Ts60T0ncjAbmM38tvvQnW4+Z5sWDdQjYGzfzrmF2wyyMUyvR7Gl
         56Et3JVuSER/r9p4bTlarynFI/Sx9C7tp7oM4ZUejiPkdwddgUDaMug8UECRxJGYs+0v
         Opgw==
X-Gm-Message-State: AOAM5338ztTa1xJTMkkFmwqkhT3CdqQnsqioa2ONbt0Hd8f/Ics1zCyP
        ozx2vydDKgg4tMc/5w0dyrohScNCCME=
X-Google-Smtp-Source: ABdhPJxdJRvN/o6BcIHqAw12VXKJzqTYa/7WHLpohFb74Wnc1JCedXdExfG3BLULFy/b/8eqqIkAnQ==
X-Received: by 2002:a19:6105:: with SMTP id v5mr3327429lfb.202.1590796689872;
        Fri, 29 May 2020 16:58:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q8sm2390903lfo.13.2020.05.29.16.58.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 16:58:09 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a25so1352815ljp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:58:08 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr5117882ljd.102.1590796688558;
 Fri, 29 May 2020 16:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232615.GK23230@ZenIV.linux.org.uk>
 <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 16:57:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwsgYPUfzRNd3Lm08=+HvfoQ4TjS6UCwZUZ_pFEPey6w@mail.gmail.com>
Message-ID: <CAHk-=wjwsgYPUfzRNd3Lm08=+HvfoQ4TjS6UCwZUZ_pFEPey6w@mail.gmail.com>
Subject: Re: [PATCHES] uaccess misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 4:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My only complaint was that kvm thing that I think should have gone even further.

Oh... And the cc list looks a bit odd.

You cc'd fsdevel, but none of the patches were really to any
filesystem code (ok, the pselect and binfmt thing is in fs/, but
that's kind of incidental and more of a "we split core system calls up
by area too" than any "it's filesystem code").

The kvm patch didn't have anybody from kvm-land cc'd, for example. I
added some to my "this shouldn't use double underscores" reply, but..

                  Linus
