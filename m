Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF3416690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbhIWUWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbhIWUWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:22:15 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E92C061574;
        Thu, 23 Sep 2021 13:20:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z12so4964399qvx.5;
        Thu, 23 Sep 2021 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=askzCAM6l+1NBUX7qVCLMpd/n/UPTDcVezPFkcxeG10=;
        b=eLsPCDr7NBTobzPXdG0PmPN/PLb9kFyXb+wQpPc8z+UkQMR6EBIk0bXw/EzKtkuG1h
         C1G+XwwU7AdWSSux9n6xNLKUORS9Vxec1r+5KRkAJM38uMEFM9PCFpLYOtlldixcOE+l
         CKO7Wsa5hB6nGAloEHUM7YJsDB57o12vTAX1hiNp2uDXTyNmLWaBUdAPQZztbfIYfcZb
         JoLvZkn7wxS/958q/ULTPcZ5QMjnxgie037ZqFAb+yipJ9DULYrDz301A6DhOZ16r0an
         Zt8L7LRTVUBBO44rwVTiOYvmy70rO2JEN/0Nkq0Azt/inAZhZyFkE51u1paKCq+6lkaY
         nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=askzCAM6l+1NBUX7qVCLMpd/n/UPTDcVezPFkcxeG10=;
        b=t7fmR7JOFz1ncUVHFsL5sw6A7P53ad7OVgX7H97B6//VgAb8DLwBKusjyD/GwsGMz9
         1GTgG1UGjKKKethecKhXjBaKte4Nl41EetWemnyOnZEZCvJG2+/KgWjIJFo3mcVcCMqn
         E3Q5onoVTVJiB9n9eY6Ptq+5Qthq7qy0JkR3pcPmqlY4m2pIGm+mPoUHmNuFGJkuQMhH
         Nh88GEcaAMYYF5xIk3A+giVXRmgxtV+TxeO8kEjLqrDzR8tJ1saVrvz1zA8dxH68mjJp
         3knJT5o/Bf7pdQv5xPl/clraBiCFtEY3OJtXDmGUWYiVYA9lLN/NOEoIUTnHVvsArYuw
         by2A==
X-Gm-Message-State: AOAM530pS/FZeXh+fgfdb4rENKXYmTcyh7m/OzWMagdx/HNW0U/Pu6W/
        obaMnQsrS1zllcDCIKHOovOwjai2SC+K
X-Google-Smtp-Source: ABdhPJxw26ptNjjfnYiS442+734imrvDyEStZq7vZE7zC3t9JAkTgbYwcpxpuDjIbEVTAOpWieERjQ==
X-Received: by 2002:ad4:496d:: with SMTP id p13mr6210710qvy.52.1632428442306;
        Thu, 23 Sep 2021 13:20:42 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w11sm4937213qkp.49.2021.09.23.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:20:41 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:20:39 -0400
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
Message-ID: <YUzhlwqdCXP6+w4s@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUwTuaZlzx2WLXcG@moria.home.lan>
 <YUzAzl5iCdfUBJqe@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzAzl5iCdfUBJqe@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 02:00:46PM -0400, Johannes Weiner wrote:
> Yeah, with subclassing and a generic type for shared code. I outlined
> that earlier in the thread:
> 
> https://lore.kernel.org/all/YUo20TzAlqz8Tceg@cmpxchg.org/
> 
> So you have anon_page and file_page being subclasses of page - similar
> to how filesystems have subclasses that inherit from struct inode - to
> help refactor what is generic, what isn't, and highlight what should be.
> 
> Whether we do anon_page and file_page inheriting from struct page, or
> anon_folio and file_folio inheriting from struct folio - either would
> work of course.

If we go that route, my preference would be for completely separate anon_folio
and file_folio types - separately allocated when we get their, both their
completely own thing. I think even in languages that have it data inheritence is
kind of evil and I prefer to avoid it - even if that means having code that does
if (anon_folio) else if (file_folio) where both branches do the exact same
thing.

For the LRU lists we might be able to create a new type wrapping a list head,
and embed that in both file_folio and anon_folio, and pass that type to the LRU
code. I'm just spitballing ideas though, you know that code better than I do.

> Again I think it comes down to the value proposition
> of folio as a means to clean up compound pages inside the MM code.
> It's pretty uncontroversial that we want PAGE_SIZE assumptions gone
> from the filesystems, networking, drivers and other random code. The
> argument for MM code is a different one. We seem to be discussing the
> folio abstraction as a binary thing for the Linux kernel, rather than
> a selectively applied tool, and I think it prevents us from doing
> proper one-by-one cost/benefit analyses on the areas of application.
> 
> I suggested the anon/file split as an RFC to sidestep the cost/benefit
> question of doing the massive folio change in MM just to cleanup the
> compound pages; takeing the idea of redoing the page typing, just in a
> way that would maybe benefit MM code more broadly and obviously.

It's not just compound pages though - THPs introduced a lot of if (normal page)
else if (hugepage) stuff that needs to be cleaned up.

Also, by enabling arbitrary size compound pages for anonymous memory, this is
going to help with memory fragmentation - right now, the situation for anonymous
pages is all or nothing, normal page or hugepage, and since most of the time it
ends up being normal pages we end up fragmenting memory unnecessarily. I don't
think it'll have anywhere near the performance impact for anonymous pages as it
will for file pages, but we should still see some performance gains too.

That's all true though whether or not anonymous pages end up using the same type
as folios though, so it's not an argument either way.

> I think we need a better analysis of that mess and a concept where
> tailpages are and should be, if that is the justification for the MM
> conversion.
> 
> The motivation is that we have a ton of compound_head() calls in
> places we don't need them. No argument there, I think.

I don't think that's the main motivation at this point, though. See the struct
page proposal document I wrote last night - several of the ideas in there are
yours. The compound vs. tail page confusion is just one of many birds we can
kill with this stone. 

I'd really love to hear your thoughts on that document btw - I want to know if
we're on the same page and if I accurately captured your ideas and if you've got
more to add.

> But the explanation for going with whitelisting - the most invasive
> approach possible (and which leaves more than one person "unenthused"
> about that part of the patches) - is that it's difficult and error
> prone to identify which ones are necessary and which ones are not. And
> maybe that we'll continue to have a widespread hybrid existence of
> head and tail pages that will continue to require clarification.
> 
> But that seems to be an article of faith. It's implied by the
> approach, but this may or may not be the case.
> 
> I certainly think it used to be messier in the past. But strides have
> been made already to narrow the channels through which tail pages can
> actually enter the code. Certainly we can rule out entire MM
> subsystems and simply declare their compound_head() usage unnecessary
> with little risk or ambiguity.

This sounds like we're not using assertions nearly enough. The primary use of
assertions isn't to catch where we've fucked and don't have a way to recover -
the right way to think of assertions is that they're for documenting invariants
in a way that can't go out of date, like comments can. They're almost as good as
doing it with the type system.

> Then the question becomes which ones are legit. Whether anybody
> outside the page allocator ever needs to *see* a tailpage struct page
> to begin with. (Arguably that bit in __split_huge_page_tail() could be
> a page allocator function; the pte handling is pfn-based except for
> the mapcount management which could be encapsulated; the collapse code
> uses vm_normal_page() but follows it quickly by compound_head() - and
> arguably a tailpage generally isn't a "normal" vm page, so a new
> pfn_to_normal_page() could encapsulate the compound_head()). Because
> if not, seeing struct page in MM code isn't nearly as ambiguous as is
> being implied. You would never have to worry about it - unless you are
> in fact the page allocator.
> 
> So if this problem could be solved by making tail pages an
> encapsulated page_alloc thing, and chasing down the rest of
> find_subpage() callers (which needs to happen anyway), I don't think a
> wholesale folio conversion of this subsystem would be justified.
> 
> A more in-depth analyses of where and how we need to deal with
> tailpages - laying out the data structures that hold them and code
> entry points for them - would go a long way for making the case for
> folios. And might convince reluctant people to get behind the effort.

Alternately - imagine we get to the struct page proposal I laid out. What code
is still going to deal with struct page, and which code is going to change to
working with some subtype of page?
