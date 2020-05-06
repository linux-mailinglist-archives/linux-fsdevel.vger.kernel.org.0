Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E71C7972
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgEFScg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgEFScf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 14:32:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2EDC061A0F;
        Wed,  6 May 2020 11:32:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so2896540edv.2;
        Wed, 06 May 2020 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fq3C3PbiEHBNQ27byMZOeuqdKYIZw/ni/msqiBB7jyw=;
        b=rJLEiPN7+PxVlf0QK9PQNUT6kdIjMim7/Ob4MOBhcoNSlOu2jcUZTT6HZnRkZBplSw
         gZ7/yA0PANlt5Anpszzp4vP722DW0sXC9Gm78C9nyFl2PR2ny6S4LFG+8XYxupDtF+M7
         svQk0iI11QWz45fTvs5s2+YBLElpfugmc/46+FDIU5YtMEcbsh0Er/PXglJhernwl7Sq
         5JiIoVLofL284wjgrRU7sH68j4j+ZtIrlo8hPqZf3iQPaACAasJnBrboSvJDeNuQoWKi
         LrRNEPC/B9g1dqRX1W/SNp+CcAAboD7hzPJ08Ioz+pqzHU0laa/KsjTEOXl5mNNPghME
         G5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq3C3PbiEHBNQ27byMZOeuqdKYIZw/ni/msqiBB7jyw=;
        b=MJp/1VGoeM9AvUAaERCqjkAVxT/bD0ml9HP+stHiyK7jRRp1LLIsO6yVlarKpSmvV0
         /PAPYgWSnH5sB1WCzDTGIGKSALbMtWbUMlGtl/w2gukNV9csfC1uMCKZI6iWxGen9SaU
         j23uryfIQ8gaDcle+dFBc+ipnXR3TMCClcFrz8BZHhMx8ySnOfjh3iqZiyit1w/cBUGR
         GKkyB5+I2PiInn0JidfuLtIXaVBceyJ/ZbnFYh7efPlgcbUOrg+Hyn13eZaj73qQPkiY
         qLoWHyvBN9M6B/2Lo1lew0lFo26IlpY0rRt7EuuIbSWmsbtuvB2dm/QavxYGwF5oWvaW
         8jxQ==
X-Gm-Message-State: AGi0PuYUrABMq86MUjFXcVe4SSUryFYDk4hKo/P+K41PwOeEEEXt0CDf
        fcSWzz1OetKSAw8BJH4Cyk6uM/7DTSRY+rCvi74=
X-Google-Smtp-Source: APiQypIqKVPkPU9lpEJGXc3tDKlNRebjzrlGVMGBlrUrwK8oBbdsyu+LRyPffWUSAmpIOciZmJuZppyjOo2b3eZ4pfE=
X-Received: by 2002:a05:6402:558:: with SMTP id i24mr7963797edx.347.1588789953782;
 Wed, 06 May 2020 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200429133657.22632-1-willy@infradead.org> <20200429133657.22632-19-willy@infradead.org>
 <20200504031036.GB16070@bombadil.infradead.org>
In-Reply-To: <20200504031036.GB16070@bombadil.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 May 2020 11:32:10 -0700
Message-ID: <CAHbLzkq14tV3o_Oh82FhgyDZ4=8mRf8udfhEGHyTVCPQceq=1A@mail.gmail.com>
Subject: Re: [PATCH v3 18/25] mm: Allow large pages to be added to the page cache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 3, 2020 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 29, 2020 at 06:36:50AM -0700, Matthew Wilcox wrote:
> > @@ -886,7 +906,7 @@ static int __add_to_page_cache_locked(struct page *page,
> >       /* Leave page->index set: truncation relies upon it */
> >       if (!huge)
> >               mem_cgroup_cancel_charge(page, memcg, false);
> > -     put_page(page);
> > +     page_ref_sub(page, nr);
> >       return xas_error(&xas);
> >  }
> >  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
>
> This is wrong.  page_ref_sub() will not call __put_page() if the refcount
> gets to zero.  What do people prefer?
>
> -       put_page(page);
>
> (a)
> +       put_thp(page);
>
> (b)
> +       put_page_nr(page, nr);
>
> (c)
> +       if (page_ref_sub_return(page, nr) == 0)
> +               __put_page(page);

b or c IMHO. The shmem uses page_ref_add/page_ref_sub so we'd better
follow it. If go with b, it sounds better to add get_page_nr() as
well.

>
