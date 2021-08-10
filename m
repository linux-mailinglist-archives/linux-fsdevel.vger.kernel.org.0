Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45263E5291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHJFOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhHJFOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 01:14:24 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60BC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 22:14:03 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q3so4512642vkd.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 22:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbj2YIoq+E9w00zYigZfnEN2+DZS/6bH7EkHmJaJ7+4=;
        b=W2e6d7tANNuZvnWrmp6EN6PiiHeqThHUisatkH1a/4EL21ldzCzpHeXzGPY/9224BN
         Z/CiGZ7mZ32SpUG876YtQApfpUprIqF/xqEBvS7noMQ2n7FVPdaNK2oJscvnwdfI8Rui
         EDb1N2EJDvgQD5KJqrgWTMAVPLLaVNvPnUQHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbj2YIoq+E9w00zYigZfnEN2+DZS/6bH7EkHmJaJ7+4=;
        b=I4abQlJUN71df4KeQWC9DGlQq4fcTpuSDm2tLI+utAETf3ihDB3sfSN+VrIzzWJ0mj
         jXWcnCo9k8bmy2zKOORm8w5++MjlXvpc1QmBQbgOcSgdFFPX0CSaaUFQV03PziMpge5y
         lsCebFbbsAOrcUnKC+hPIqH5vrCsg96A7AlPCdGaoej3dFF5718UL66o0uRYNFWqY66o
         N568FS+1qFP8sNnRkwsmuet+eR7LdlkDWb8gryFlV26Bdp+1aim4aqGJG++l5/DhSuYu
         TYBsJoGJ+aB83i/goEvY7uwygrzUSTtQZxJMDRZA/utlMQXGoobW0/YmML83F5vbshvB
         2E3Q==
X-Gm-Message-State: AOAM533cp3T44y1QtTnEwulEC2lALfyNiH2lleuNbdytcJbZSZfwPJaF
        CDQqtEC+xkDkXxX5gi9PlQBp+M0S0Ed8qgudzrf3Uw==
X-Google-Smtp-Source: ABdhPJyK6yckKurEBP3/dfOsOeLJXctvCuX/cIs5kTcfm8Je/8pZ6c+cyun3iM9fbLfjpMMG2FXHjhz8Ez7yxBUxsWo=
X-Received: by 2002:a05:6122:696:: with SMTP id n22mr15132849vkq.19.1628572442200;
 Mon, 09 Aug 2021 22:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com> <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
 <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com> <YRGtF69Z8kjsaSkb@casper.infradead.org>
In-Reply-To: <YRGtF69Z8kjsaSkb@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Aug 2021 07:13:51 +0200
Message-ID: <CAJfpegvD-n-Gb850wiB6J62CqGOtvV9LVWGfkXqqcB_UpJnBeA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Aug 2021 at 00:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 09, 2021 at 02:26:55PM -0700, Linus Torvalds wrote:
> > On Mon, Aug 9, 2021 at 2:25 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I've pulled this,
> >
> > Actually, I take that back.
> >
> > None of those things have been in linux-next either, and considering
> > my worries about it, I want to see more actual testing of this.

The denywrite patch has been in -next for three weeks, the others
less, but also spent some time in there.  The reason the commit
timestamp is so recent is that the fixes have been pulled to the front
of the queue.

But okay, I can drop that patch from this pull request.

> Not only that, the changes to fs/namespace.c and mm/util.c haven't been
> posted to linux-mm or linux-fsdevel, as far as I can tell.

It has been posted to both and got an ACK from an MM person:

 https://lore.kernel.org/linux-mm/YOhTrVWYi1aFY3o0@miu.piliscsaba.redhat.com/

Thanks,
Miklos
