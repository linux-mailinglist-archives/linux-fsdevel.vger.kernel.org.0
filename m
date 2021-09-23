Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27FB4157E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 07:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhIWFn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIWFnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:43:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9C3C061574;
        Wed, 22 Sep 2021 22:42:22 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id jo30so3507566qvb.3;
        Wed, 22 Sep 2021 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEUOfhmP78FxEf3QB0fKvSBV6gdVWnze8dsxjHleBkA=;
        b=F5aqSnSqaP1WJKXUpsns0B0iUJxeyFokn3QoLPiGMN7QDqR0Cd/HD3141M/SFBej8k
         89P0smQ9LUYWd+XCl5pk9lDLFQwChFSK5JvgabIo3i+amA443hGFtTfuNVX9xApurM1z
         MbXOnmistIT46B9YB4ehvLe33JXPcMejYsHJyeU4h4/6sB5z0Y7JChzdvTAygzenYwci
         Vy+6kdJP/gRAn6vndL4rxNbl3YNL7ZRW1WGbF7ayrKREmByGFYsj5JMiC3okoxpGr5Cw
         lR3lvF3mpH+BlzdFflB+V+OSzsCCvWywEVTVeSgcmnihoIboqEyJvfJ7pWYjR0PXBua+
         j2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEUOfhmP78FxEf3QB0fKvSBV6gdVWnze8dsxjHleBkA=;
        b=U81BV5VmL7ZnYyNLmiI4vS99ZPHZwGTjLBgrldgoBMnvJsPLnyvE0vWnET8fnXgeK2
         nljzofKEJAtBR9nfmrnqo0pprR1386fomE+MWjT3yTpdugpKxFnwwHfIwdUtLzXrc0n5
         90404t4Xct0jmfnB/DqtTa929su4JfVO01AnSL5mZPmbvMRRFa/6uSKfSJTFUVwya0R+
         JhSuRj6AYeWkPFc+KF6mL+65x4fb2hN0BN3foqkEMeTrLExr0B/qHjx3jJyH+veB18SS
         dir24u8cPYKZ62UokWhcXyK+MzmM6hfFOoNWx+UlKfxkAnPJ0ENkAKXCL/wn2fom7OV/
         M82g==
X-Gm-Message-State: AOAM531jFSv0yDKCJx7zZSXgf69cu7YQlZggjE04TpyMucPduStp9QhH
        uyAg2i3MizUxAp2SlIy7BA==
X-Google-Smtp-Source: ABdhPJwplcKSjSAbLbFDmQyYDOWb+8zCtPwiNCj+u/3MsjUpJfoRG3EP+jk64bAELpXz5Q/Xpt89Ag==
X-Received: by 2002:ad4:4893:: with SMTP id bv19mr2886275qvb.6.1632375740233;
        Wed, 22 Sep 2021 22:42:20 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r17sm2870821qtx.17.2021.09.22.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 22:42:19 -0700 (PDT)
Date:   Thu, 23 Sep 2021 01:42:17 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUwTuaZlzx2WLXcG@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUtHCle/giwHvLN1@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
> >  - it's become apparent that there haven't been any real objections to the code
> >    that was queued up for 5.15. There _are_ very real discussions and points of
> >    contention still to be decided and resolved for the work beyond file backed
> >    pages, but those discussions were what derailed the more modest, and more
> >    badly needed, work that affects everyone in filesystem land
> 
> Unfortunately, I think this is a result of me wanting to discuss a way
> forward rather than a way back.
> 
> To clarify: I do very much object to the code as currently queued up,
> and not just to a vague future direction.
> 
> The patches add and convert a lot of complicated code to provision for
> a future we do not agree on. The indirections it adds, and the hybrid
> state it leaves the tree in, make it directly more difficult to work
> with and understand the MM code base. Stuff that isn't needed for
> exposing folios to the filesystems.

I think something we need is an alternate view - anon_folio, perhaps - and an
idea of what that would look like. Because you've been saying you don't think
file pages and anymous pages are similar enough to be the same time - so if
they're not, how's the code that works on both types of pages going to change to
accomadate that?

Do we have if (file_folio) else if (anon_folio) both doing the same thing, but
operating on different types? Some sort of subclassing going on?

I was agreeing with you that slab/network pools etc. shouldn't be folios - that
folios shouldn't be a replacement for compound pages. But I think we're going to
need a serious alternative proposal for anonymous pages if you're still against
them becoming folios, especially because according to Kirill they're already
working on that (and you have to admit transhuge pages did introduce a mess that
they will help with...)
