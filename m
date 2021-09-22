Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091C741514E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhIVUXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhIVUXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:23:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA8BC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t10so16885970lfd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+xhlLd4huTRJupVTgnduPJLYoAg28pRoAPZdUIDHYE=;
        b=KB4oJUW1zrMvaDw9J/F7wkiDHhTBjRs3+VPOv8q74he+/KK7vTzgQp9ym5f7epRhXJ
         e7fCj6TrmlzX40U5DT3gk4252HT9vjMH/PiV6TwTsi3sbJJ+mC5g1IxME1+AVhlAwyPO
         rDEF0KjrxrDuYv++ZlVCIwd6iolgz093Tk1vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+xhlLd4huTRJupVTgnduPJLYoAg28pRoAPZdUIDHYE=;
        b=SxBd4GMK6ZFV2Oj6dJYdIlgl+1a/u2j899b5ZURAJSG1JkoeVm0oDUpRgbcIFBeOAK
         vQVG8Je5Q2VlS0vTu0CDXySsMAhBGVUYiGl+RgedcS+Ft6h+msXRhLj8qvyA6uUVF/2B
         zmG7RLGBiodaC7dx/zf6CnbK3jzOeXy859YC5hoBCWtJxgz0B92lLvECQwdf9lZJ9jDf
         sj/lUgSkdh7TxrwE+6K4XhKyv35D5m1OjRm92RKFtXx3iOO1ra/NoosMOUAOZpffx7oS
         PQozSc4KRcpj8UIybpM+D/wrygjQI/vMxQbI8B7/1kihahq4/+DUSUvrWRSyxcxUkQZH
         uEMw==
X-Gm-Message-State: AOAM532Lq6MEgnMfKmUBe6s8UvfcnlxD/y7iK8jNaxmlg4h7Bbj+VNRm
        ayr7x8KezC2GNwPEJMD+VgsIWTXcPpkMDcU86tA=
X-Google-Smtp-Source: ABdhPJyrT8ReRRqBsoqGwOrDWvOpoVzoxj8wzrUmTCi6347ZM/Nf6TgwjZe6Kn3hsuxPcZ/zuDQsQg==
X-Received: by 2002:a2e:a7cf:: with SMTP id x15mr1266052ljp.100.1632342099313;
        Wed, 22 Sep 2021 13:21:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i15sm255842lfg.118.2021.09.22.13.21.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 13:21:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u8so16266490lff.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:37 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr1340109ljh.68.1632342097278;
 Wed, 22 Sep 2021 13:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <YTu9HIu+wWWvZLxp@moria.home.lan> <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org> <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan> <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org> <YUtPvGm2RztJdSf1@moria.home.lan>
 <YUtZL0e2eBIQpLPE@casper.infradead.org> <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
 <YUuJ4xHxG9dQadda@casper.infradead.org>
In-Reply-To: <YUuJ4xHxG9dQadda@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 13:21:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vOmaE-BTHNjTTkw+vjx=P3Pa-TFPZngEOR-39fZhPg@mail.gmail.com>
Message-ID: <CAHk-=wh=vOmaE-BTHNjTTkw+vjx=P3Pa-TFPZngEOR-39fZhPg@mail.gmail.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:56 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The continued silence from Linus is really driving me to despair.

No need to despair. The silence isn't some "deep" thing.

What  happened is literally that I wasn't 100% happy with the naming,
but didn't hate the patches, and still don't.

But when there is still active discussion about them during the merge
window, I'm just not going to merge them.

The silence literally is just due to that - not participating in the
discussion for the simple reason that I had no hugely strong opinions
on my side - but also simply because there is no way I'd merge this
for 5.15 simply exactly _because_ of this discussion.

Normally I get to clean up my inbox the week after the merge window,
but the -Werror things kept my attention for one extra week, and so my
mailbox has been a disaster area as a result. So only today does my
inbox start to look reasonable again after the merge window (not
because of the extra email during the merge window, but simply because
the merge window causes me to ignore non-pull emails, and then I need
to go back and check the other stuff afterwards).

So I'm not particularly unhappy with the patchset. I understand where
it is coming from, I have no huge technical disagreement with it
personally.

That said, I'm not hugely _enthused_ about the mm side of it either,
which is why I also wouldn't just override the discussion and say
"that's it, I'm merging it". I basically wanted to see if it led
somewhere.

I'm not convinced it led anywhere, but that didn't really change
things for me, except for the "yeah, I'm not merging something core
like this while it's under active discussion" part.

           Linus
