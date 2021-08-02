Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF24F3DE259
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHBWQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231987AbhHBWQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627942588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bREK9zy4MDrqGtjS0pSsWU8oAG+CWsA5oDR3x7mbPSI=;
        b=QB/bDxDlvPg82l9xKBMWv2y22OoPWiNxXqvSEZCrFkFLrBT01Dq3ajsP8vcL6lEXo8mT0+
        aN+0Qr6IGVcyKts+rrSKq+7iBfhRlZwJHoksTyBG41pMSj6cra4rQrD9AgI8CjAD4Bsjgv
        NozMghUXzzxk5XqA8ibkrNYWq1QQws4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-tjT2SYOPOaWvGmTIJekI2Q-1; Mon, 02 Aug 2021 18:16:27 -0400
X-MC-Unique: tjT2SYOPOaWvGmTIJekI2Q-1
Received: by mail-wm1-f69.google.com with SMTP id f10-20020a7bcc0a0000b0290229a389ceb2so205971wmh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Aug 2021 15:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bREK9zy4MDrqGtjS0pSsWU8oAG+CWsA5oDR3x7mbPSI=;
        b=PL6QX1Vhy43MuprrmNSl4Kh9YyA4ExAnBFdETr0JJRrVCV5/jZDBnvD0KPzU7D3iik
         iAo6P2uzskcmKloEXHjLtWfFhe+7c7b9u5rFd/4GKwwJSQo6r7WmNti7PE5A8PJ/7ZRa
         9mMP0zQAWBUV9rIPDB723vKGhETPXqOMSQpzmR+b+OJv57Jf/bf8d1XGLNVKwE2FUpP2
         ZIrQlcvppT58R+EVKKBjQbBS8qs4NzJQLhvFeVgjkMzPJTXKAEmgehn8HnRpXiAEzgfJ
         Eg1JHajRLWUZ91lbQ+n3GcXc+ltRjPGaTSQjOsLFxggZYQhDTDOQslKAKG+8AHKBxVkb
         WDAA==
X-Gm-Message-State: AOAM5339XcoA/boizY6ap1NpzN1tf21CTW/FSa12m9YLArMxs2tskMHt
        uc9POABk9sHiHd5Mx+0KnKoQXu7pvwxplLkB3AKApJZYPyusjogjmUiuuXjGUU+CH+feTbki/vQ
        J08OJJnYlBhjCsBQsgrHYfrTzaMP9oOLODCsQQmzZzQ==
X-Received: by 2002:adf:f584:: with SMTP id f4mr19665665wro.211.1627942586403;
        Mon, 02 Aug 2021 15:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0I9UcTRdpE8V808zLwZ0ppUehGsLFatZfcJjH0DRbpsdYTHYnfj1IfGIBU85XZ6MC679Jrj8bqU6dL6tCw10=
X-Received: by 2002:adf:f584:: with SMTP id f4mr19665658wro.211.1627942586272;
 Mon, 02 Aug 2021 15:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210801120058.839839-1-agruenba@redhat.com> <20210802221339.GH3601466@magnolia>
In-Reply-To: <20210802221339.GH3601466@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Aug 2021 00:16:15 +0200
Message-ID: <CAHc6FU66B9VJFu6tPvDMJZYPbgGoytf3zR1yxRfg92Zw1=vaCQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Fix some typos and bad grammar
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 12:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
> On Sun, Aug 01, 2021 at 02:00:58PM +0200, Andreas Gruenbacher wrote:
> > Fix some typos and bad grammar in buffered-io.c to make the comments
> > easier to read.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Looks good to me, though I'm less enthused about the parts of the diff
> that combine words into contractions.

Feel free to adjust as you see fit.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks,
Andreas

