Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120C019E7A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDDU5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 16:57:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42378 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDU5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 16:57:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id s10so7258497vsi.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2020 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2x0AYyTRYtjT/SYXHm491NxzEChiRCQRcx9Z4KQvNzM=;
        b=ej6WMCwTFQHydwUw6G9KDNeQDdC/rj6vgjWFms54iDg1013xe9eqy6DrcQP5pszcji
         GnVFhEip7i+yTACoFhEqXPLV0MH50kK2C5IW2L3ZlpwFJg8p9CPq9AYci1IlVpVQzxAJ
         LGcr/ujlyBVvNeV/37rxZGR15+y2WXfZIj5GcNARTZoNAskehPNFoW3nV7f0TJZ1FmSj
         V8BZ/NS/WTBKEkdj02J8wiT5m5g3h0gyX6vPc/BLhTJGMI7nGa0bbSTqEVymhLFET42p
         YYm4a4T8YLMQBsRMTKJ30beRQ2gxhQJCKVQZxM5xRuKBwKY01JgL1CotVW4uYo/869dJ
         8qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2x0AYyTRYtjT/SYXHm491NxzEChiRCQRcx9Z4KQvNzM=;
        b=O6Ss9rXySTt947DC1rf+X96pJc/6aFZluFXEfqUSq4KtRvOcQk/VZq7gmui+wuXOyn
         oTYh52kzI3OTtQKGsDt0WYya0R8n6oSeWgzcXQqqk4X16gjAbrzGIlm1sx5y0Bn8uyts
         RkYLGTvfB/0dOZkpXljKYHYLWnTZhqa7Uo9yzcvSYbX34DtTJsGpRsQ4fSFMi2ehBLnx
         zmYF36kikG0YmtM4+3QJF91wIEZPSv8d+G3fQFZi9tRfXQ6FgQw+YsYSyBlA5MR1oEAE
         IHyBNI5jDfIPt+9Oo1iaYS5WMLejZ7xDDC+KGxg9Kb2AbwBBHhX+Qb1YBNhgX3ImstbL
         F9PQ==
X-Gm-Message-State: AGi0PuaIUoNdrmeidTWYTXBElvbceWCuMHqEY8vVA/IPXTTSbUTT81pV
        SJqADiyGF1ouAgNaos1uAhi3qP/tBOg469j0ZyOw7sMq9Ls=
X-Google-Smtp-Source: APiQypKxSTctjde1rLaR9pQPNwTSYPcH+H8+UEHrzbwI5KHm9VdOy5JtmGnRHHKU00mqqR//qEfeFV/mIpHn6qqq14M=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr11260819vsz.155.1586033856230;
 Sat, 04 Apr 2020 13:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200326170705.1552562-2-hch@lst.de> <20200404162826.181808-1-hubcap@kernel.org>
 <20200404174346.GU21484@bombadil.infradead.org>
In-Reply-To: <20200404174346.GU21484@bombadil.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 4 Apr 2020 16:57:24 -0400
Message-ID: <CAOg9mSSrJp2dqQTNDgucLoeQcE_E_aYPxnRe5xphhdSPYw7QtQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: complete Christoph's "remember count" reversion.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hubcap@kernel.org, Christoph Hellwig <hch@lst.de>,
        devel@lists.orangefs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew>  So yes, I think within the next year, you should be
Matthew>  able to tell the page cache to allocate 4MB pages.

I can't find the ascii thumbs up emoji :-) ...

-Mike

On Sat, Apr 4, 2020 at 1:43 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Apr 04, 2020 at 12:28:26PM -0400, hubcap@kernel.org wrote:
> > As an aside, the page cache has been a blessing and a curse
> > for us. Since we started using it, small IO has improved
> > incredibly, but our max speed hits a plateau before it otherwise
> > would have. I think because of all the page size copies we have
> > to do to fill our 4 meg native buffers. I try to read about all
> > the new work going into the page cache in lwn, and make some
> > sense of the new code :-). One thing I remember is when
> > Christoph Lameter said "the page cache does not scale", but
> > I know the new work is focused on that. If anyone has any
> > thoughts about how we could make improvments on filling our
> > native buffers from the page cache (larger page sizes?),
> > feel free to offer any help...
>
> Umm, 4MB native buffers are ... really big ;-)  I wasn't planning on
> going past PMD_SIZE (ie 2MB on x86) for the readahead large pages,
> but if a filesystem wants that, then I should change that plan.
>
> What I was planning for, but don't quite have an implementation nailed
> down for yet, is allowing filesystems to grow the readahead beyond that
> wanted by the generic code.  Filesystems which implement compression
> frequently want blocks in the 256kB size range.  It seems like OrangeFS
> would fit with that scheme, as long as I don't put a limit on what the
> filesystem asks for.
>
> So yes, I think within the next year, you should be able to tell the
> page cache to allocate 4MB pages.  You will still need a fallback path
> for when memory is too fragmented to allocate new pages, but if you're
> using 4MB pages, then hopefully we'll be able to reclaim a clean 4MB
> pages from elsewhere in the page cache and supply you with a new one.
