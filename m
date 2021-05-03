Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2B371837
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhECPoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhECPoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:44:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB32C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 08:43:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so1459235otp.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9qCPLrC2IGZ3Z9AKXqcGRoiM4dO77NNhYrC1rXeFqg=;
        b=UJiSCSZQXrsU5lQYMFEIrkDJ3t2KYDf9MJd2WNuWHuqmZXMs4Ubl0iTgbqaYmULcDf
         nEoWRjIILOsh53i+9guatuNHQl28xfeJCU47RX8g7hnxawqmuK5nEm90q4zcb638h9PR
         QGjkP2W4rinP7N6+Z08Ow2/WcZVDfSO9iWYn9JOepniccfnjzsereL3qrwWLy2aAlIaP
         dyQz4Wb12g4DOU/hf5zl6kVQ0ikS5q0kD0vr7ygvuNWpjaZQOpNRSwDjNKzmAs9EaRCC
         G404okxXzJsah7As41DzGV8nEFYvVlLFzE1xAdMgdX3Wkmn5/gmYRBc1eEXs7yEJzFEJ
         NCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9qCPLrC2IGZ3Z9AKXqcGRoiM4dO77NNhYrC1rXeFqg=;
        b=kJ1+wVrw/PLH48uKp0Cc0huX+K2S0W/jfGMRlPxFNLW680+BPtwhWbzuXrlNIWAktK
         jXHWESHCroWnLiqKcBOIdJTUoKsKOzO4avwatnFv/w2+nETM9jXxbIu/qVQX1lELuPMP
         zphvWwH/X+WPcxlmoHg8PrmiFVUw0fqwhU5pb2YB2/tPlLJRB8XPzQeYpEimXE8GrtD8
         6s7A50liymexpcJn11BtCEjtleJfUK96hUjqen9IoTZjcudI/6sI1dbRtbGqUeFbYRv2
         4DOqzAGCqElJaImLY7N5O2SubQAVY1uRDHAgYBnCg0K2UDz0gSaIIo5SrzIPyebvo6zX
         jYHA==
X-Gm-Message-State: AOAM532DEG47AUgy0Wrf72JVLWddueX+Zu/nrjBCj8OO0QZtLE0ELnOu
        PXjO/YNrn/HSCx8k/rduoT9I2kc0FM5Fog8C+Q0Z+g==
X-Google-Smtp-Source: ABdhPJyshgTgbksV/4UpQeaf9g3/hWrcLpswGjtQW1v2RBwB+bT29YdYqxv0ZUVRQ3ef9OqnthvCoXyOylPTnidVOzI=
X-Received: by 2002:a9d:204:: with SMTP id 4mr15882835otb.352.1620056609768;
 Mon, 03 May 2021 08:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
 <20210502225854.GA1847222@casper.infradead.org>
In-Reply-To: <20210502225854.GA1847222@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 3 May 2021 11:43:17 -0400
Message-ID: <CAOg9mSQKR_3yfz=-ikTQKKthJ=zBExZJsCo_QjzJzV4G-YZ8fw@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs pull request for 5.13
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Matthew...

I added in your changes to "the current linus tree" and ran
the whole thing through xfstests with my fingers crossed.
It didn't fix any regressions :-) but I'll send it in as a patch.

-Mike

On Sun, May 2, 2021 at 6:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, May 02, 2021 at 04:45:19PM -0400, Mike Marshall wrote:
> > orangefs: implement orangefs_readahead
> >
> > mm/readahead.c/read_pages was quite a bit different back
> > when I put my open-coded readahead logic into orangefs_readpage.
> > It seemed to work as designed then, it is a trainwreck now.
>
> Hey Mike,
>
> I happened to have a chance to look at orangefs_readahead today, and
> I'd like to suggest a minor improvement.
>
> It's possible for rac->file to be NULL if the caller doesn't have a
> struct file.  I think that only happens when filesystems call their own
> readahead routine internally, but in case it might happen from generic
> code in the future, I recommend you do something like ...
>
> -       struct file *file = rac->file;
> -       struct inode *inode = file->f_mapping->host;
> +       struct inode *inode = rac->mapping->host;
> ...
> -       i_pages = &file->f_mapping->i_pages;
> +       i_pages = &rac->mapping->i_pages;
> ...
> -                       inode->i_size, NULL, NULL, file)) < 0)
> +                       inode->i_size, NULL, NULL, rac->file)) < 0)
>
> (i have this change all tangled up with some other changes in my tree,
> so no easy patch to apply, sorry)
