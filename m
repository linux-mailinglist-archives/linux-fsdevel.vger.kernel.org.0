Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A60415143
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhIVURF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhIVURE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:17:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C849C061574;
        Wed, 22 Sep 2021 13:15:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 138so13781638qko.10;
        Wed, 22 Sep 2021 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vZeUWnpc+YxmSN19tmVWnrlRKoVK8UiPdHoDGapAoiY=;
        b=TtkjId9bTJ9XX2hqkS8nkulFkBBTW3xYnl0xwKu377KBgf7bWaNckoCGRf0h7IVqXL
         97xCGmdR/chwTLca1AWCW05W8ovwDlbl3sKq7AQflpziPjCxMS6oICYHjHfWLGt/q/wy
         v8gONvVFg8HoOLw7ttP3w8PtwU8wb0i1AMouJk6epoF3eqZAxxi4b62UqL5DjO9wrDro
         pqT7uTYviI+2I0pcxudrxGCvMwZd0vHmee4dnKSeQcVhm97sDufbYarEhzyKW+XpUsMP
         Y9JM88iv6DPbqfr/a0AbTfi5OsfN/XLmQaaUPS4LXDVFKEF6ml1T8uVzRhzqSjJ+275y
         ytlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZeUWnpc+YxmSN19tmVWnrlRKoVK8UiPdHoDGapAoiY=;
        b=poBWH7SmtcR8HggMw4hsrLNBwZ8MPtgHG7K0WDl754cUY7mRolB+gtdrL3MC7IsXtz
         sAB8TQB7kfcplrHigT1atLMUzHvPo0gc2OkNUhhB0wceyTw5e8aB6qD+k1+dYv5UCY0s
         AAq2GEU/yBQbwoFqCQugOpyvAaDHchtUp0EIBBZ2fRdKKRlaoo4pgK+C1QX8D56mTAzU
         ZIcz21DPJflNVfFJby6PtRyAJh7DixvI02b3/WcAVxGKnT5DO9qAyxXqmY7GDJV5rWKP
         on3dQ0G+lLwLU63x62KsV3m957HbJDoTWAZuqhgSTOtEPsUqRKBZKKLDPfb+fqVEa09h
         qbUQ==
X-Gm-Message-State: AOAM530vOFQaGfF8l24UDb+VIfXlkQND4vDHE3xG5YTgzkOFa9X8hyKq
        F2fyd6rIdA0RZPD0ZWgkSQ==
X-Google-Smtp-Source: ABdhPJw7Y2MQUvRUjamAp187vgwZkraxlv2ZILXdG0AMyKft43uAxxEFW0hrTZXVlxCEQAoZouWUrA==
X-Received: by 2002:a37:f616:: with SMTP id y22mr1233777qkj.520.1632341733694;
        Wed, 22 Sep 2021 13:15:33 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t8sm2528013qkt.117.2021.09.22.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:15:32 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:15:28 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Mason <clm@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUuO4D8nzEDJa6uH@moria.home.lan>
References: <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUtPvGm2RztJdSf1@moria.home.lan>
 <YUtZL0e2eBIQpLPE@casper.infradead.org>
 <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
 <YUuJ4xHxG9dQadda@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUuJ4xHxG9dQadda@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:54:11PM +0100, Matthew Wilcox wrote:
> That's the nature of a pull request.  It's binary -- either it's pulled or
> it's rejected.  Well, except that Linus has opted for silence, leaving
> me in limbo.  I have no idea what he's thinking.  I don't know if he
> agrees with Johannes.  I don't know what needs to change for Linus to
> like this series enough to pull it (either now or in the 5.16 merge
> window).  And that makes me frustrated.  This is over a year of work
> from me and others, and it's being held up over concerns which seem to
> me to be entirely insubstantial (the name "folio"?  really?  and even
> my change to use "pageset" was met with silence from Linus.)

People bikeshed the naming when they're uncomfortable with what's being proposed
and have nothing substantive to say, and people are uncomfortable with what's
being proposed when there's clear disagreement between major stakeholders who
aren't working with each other.

And the utterly ridiculous part of this whole fiasco is that you and Johannes
have a LOT of common ground regarding the larger picture of what we do with the
struct page mess, but you two keep digging in your heels purely because you're
convinced that you can't work with each other so you need to either route around
each other or be as forceful as possible to get what you want. You're convinced
you're not listenig to each other, but even that isn't true because when I pass
ideas back and forth between you and they come from "not Matthew" or "not
Johannes" you both listen and incorporate them just fine.

We can't have a process where major stakeholders are trying to actively sabotage
each other's efforts, which is pretty close to where we're at now. You two just
need to learn to work with each other.
