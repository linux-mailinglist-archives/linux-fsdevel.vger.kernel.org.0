Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27D413C53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhIUVY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhIUVY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:24:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C506C061756;
        Tue, 21 Sep 2021 14:22:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 194so1890502qkj.11;
        Tue, 21 Sep 2021 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiQxvhVNzY5zCxIOTQQXBXxpp6b9FiVncQs/k+YKMCs=;
        b=KtfOAzczLf0S1BFbAIoiW4zxFBG8ZPjpN/NbomYKTWnPIVCMAtNq0RdMZhLGhVJ1hc
         CwrqXBaQaH56MD3t3h1VOqPW+ogAMHuAqPPWvb+fBNXuOlDTdbR+m1rUlANO1EZhkvf2
         07iS3r4Amc/Mnr/Wwjw3RxZe6B795nGAzvDPzrgnZBKOk2nzYPp2UY9xe0FvMMH7+Vob
         cUDi1oJ7RLPrmZo0TevQ004ZHmoqtOBapYMUG8IKhBbNjDOmV/uVC6MvoeDGvBVB4TKO
         HUOAIwVMxXsl4pwYmHbTSVMIn/v5AvXoESuoav2TpB5ax/kXTczEiIggj/LNWwNLjBqi
         xLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiQxvhVNzY5zCxIOTQQXBXxpp6b9FiVncQs/k+YKMCs=;
        b=TbIgFgHzGvAp6t9sdhCAUfoaetcxChaCMNcp1nNICpOXA/NsISiiYIZC880MCveavD
         FEGMUwD7sgpapm6OsAZYGAb9wb/lu2oiE+7Ne01DwjkwcwLhFLjERpigCDMJ7WiLmc+W
         EradcDav987Ta9QpDXUUmXtRL+mwr+rl6xE1vtGDbtNxgBBgmSU3O+Aqq98YO9tCum3n
         mGpCip+3NXKvAtfwRR8CWBn8AMc43b2sTnEaqn/1Mp9Ogm8BWoRS7r1Jr2gFSSWVBpPm
         guwoDYIMn0rS5bgGVMgRq+/y83Jlf/9MQBQlkSKY81wX0LMEwfs/PDcidje76E5BkxlS
         gbDw==
X-Gm-Message-State: AOAM5303jB85OBqFxpIyjM1d0rcwgcXU/zRua4QaPasW9p87A1gmvurJ
        xaL9LyEZnYvT49neUgVczg==
X-Google-Smtp-Source: ABdhPJyR+J7ZxD+Yy8ZlAnHeR4i6ruyawKY00Pkt0u4O/+6eDD8fVbKUv0H3b5itd6blx8R5CktZSg==
X-Received: by 2002:a37:9c46:: with SMTP id f67mr4558769qke.98.1632259376788;
        Tue, 21 Sep 2021 14:22:56 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s18sm127606qtn.46.2021.09.21.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:22:56 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:22:54 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUpNLtlbNwdjTko0@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpKbWDYqRB6eBV+@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:11:09PM -0400, Kent Overstreet wrote:
> On Tue, Sep 21, 2021 at 09:38:54PM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 21, 2021 at 03:47:29PM -0400, Johannes Weiner wrote:
> > > and so the justification for replacing page with folio *below* those
> > > entry points to address tailpage confusion becomes nil: there is no
> > > confusion. Move the anon bits to anon_page and leave the shared bits
> > > in page. That's 912 lines of swap_state.c we could mostly leave alone.
> > 
> > Your argument seems to be based on "minimising churn".  Which is certainly
> > a goal that one could have, but I think in this case is actually harmful.
> > There are hundreds, maybe thousands, of functions throughout the kernel
> > (certainly throughout filesystems) which assume that a struct page is
> > PAGE_SIZE bytes.  Yes, every single one of them is buggy to assume that,
> > but tracking them all down is a never-ending task as new ones will be
> > added as fast as they can be removed.
> 
> Yet it's only file backed pages that are actually changing in behaviour right
> now - folios don't _have_ to be the tool to fix that elsewhere, for anon, for
> network pools, for slab.
> 
> > > The anon_page->page relationship may look familiar too. It's a natural
> > > type hierarchy between superclass and subclasses that is common in
> > > object oriented languages: page has attributes and methods that are
> > > generic and shared; anon_page and file_page encode where their
> > > implementation differs.
> > > 
> > > A type system like that would set us up for a lot of clarification and
> > > generalization of the MM code. For example it would immediately
> > > highlight when "generic" code is trying to access type-specific stuff
> > > that maybe it shouldn't, and thus help/force us refactor - something
> > > that a shared, flat folio type would not.
> > 
> > If you want to try your hand at splitting out anon_folio from folio
> > later, be my guest.  I've just finished splitting out 'slab' from page,
> > and I'll post it later.  I don't think that splitting anon_folio from
> > folio is worth doing, but will not stand in your way.  I do think that
> > splitting tail pages from non-tail pages is worthwhile, and that's what
> > this patchset does.
> 
> Eesh, we can and should hold ourselves to a higher standard in our technical
> discussions.
> 
> Let's not let past misfourtune (and yes, folios missing 5.15 _was_ unfortunate
> and shouldn't have happened) colour our perceptions and keep us from having
> productive working relationships going forward. The points Johannes is bringing
> up are valid and pertinent and deserve to be discussed.
> 
> If you're still trying to sell folios as the be all, end all solution for
> anything using compound pages, I think you should be willing to make the
> argument that that really is the _right_ solution - not just that it was the one
> easiest for you to implement.
> 
> Actual code might make this discussion more concrete and clearer. Could you post
> your slab conversion?

Linus, I'd also like to humbly and publicly request that, despite it being past
the merge window and a breach of our normal process, folios still be merged for
5.15. Or failing that, that they're the first thing in for 5.16.

The reason for my request is that:

 - folios, at least in filesystem land, solve pressing problems and much work
   has been done on top of them assuming they go in, and the filesystem people
   seem to be pretty unanimous that we both want and need this

 - the public process and discussion has been a trainwreck. We're effectively
   arguing about the future of struct page, which is a "boiling the oceans" type
   issue, and the amount of mess that needs to be cleaned up makes it hard for
   parties working in different areas of the code with different interests and
   concerns to see the areas where we really do have common interests and goals

 - it's become apparent that there haven't been any real objections to the code
   that was queued up for 5.15. There _are_ very real discussions and points of
   contention still to be decided and resolved for the work beyond file backed
   pages, but those discussions were what derailed the more modest, and more
   badly needed, work that affects everyone in filesystem land

 - And, last but not least: it would really help with the frustration levels
   that have been making these discussions extroardinarily difficult. I think
   this whole thing has been showing that our process has some weak points where
   hopefully we'll do better in the future, but in the meantime - Matthew has
   been doing good and badly needed work, and he has my vote of confidence. I
   don't necessarily fully agree with _everything_ he wants to do with folios -
   I'm not writing a blank check here - but he's someone I can work with and
   want to continue to work with.

   Johannes too, for that matter.

Thanks and regards,
Kent
