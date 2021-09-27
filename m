Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7535E419D97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhI0Rzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhI0Rzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:55:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690AEC061575;
        Mon, 27 Sep 2021 10:54:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 138so37385623qko.10;
        Mon, 27 Sep 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nqerXrbMIY7Fc4sCLQnr/8c/NFYmTrN8ExKx8Kwlvs8=;
        b=TE8FrUk5bml6qC0WPBvGqevs6HjtGjjFSibyoRLQoJhgGw4ygE4LKDcQ2ADs2EIe/i
         iERiMqB9ITpJP0Jh6I6jpLQhQ9eca1vWWpskeqAMjiHWOjuin3OGRMGK6vV9mEWLxsFI
         EVkgTV7aji0uSeyyqYguJ+NjNs52hbchpsx0ASu7w5mz/NrU/YKe+v2gx0j/io9ltame
         p0FJ9Sn+i7vZOowRdEB0lRDGxnZwvxGtrVpY3Mz0iPDcSuJKSzfqUYRhOwRlaR9Q/BdQ
         Ajki3L7JCzd2WmYpaOlM+YVBPNo4tkoUZkFsH9h6DBJyuZh39a53AOpVu38A+TA/eDQ1
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqerXrbMIY7Fc4sCLQnr/8c/NFYmTrN8ExKx8Kwlvs8=;
        b=wZTF1wjI+mHuAEASAbkzl5HUjhZbHU2d0V+QajLMpKs/YQn5S0HfI1+vo43Fq3GzzW
         v1aOa7hDBkszdAHvHO+aStXxaRtPSzao2Vaag84fA9zxJk2MPd8ea2Er5bE0bKGhL6e9
         H+OXRSf9b1dAoZiitpn404RjVXeqlQ9t+0/U5kps89a6yn1vjtF4euJLsV84aSRIu4Ru
         rCqBX4eO71jqfmKvgJ3gOVPy8QTFtUxMkEYngs3UhMz1J1AfX+wHW4gyNbEQ5CG8bNeP
         QjypCWBtKXH+SDU7FdWGVsGZiPt5C5+sUibhXl++PQRs4QswfPVNkpn4Ixm3mNRoiJIL
         jfHw==
X-Gm-Message-State: AOAM531wDfh0zAZem6biaTyJ5QRJ74yP8VwToHy2aQsQ7Qd/ixqBZAg3
        fjjWBhZXGzhQ5lXeqc8BdWjEdzs9L8VJ
X-Google-Smtp-Source: ABdhPJzZhyAO48ZaPX93fi6kWxPici07wMQhSc6zubPsWsqInS9hfyUbEyszSjTeFooceBJBxn+d7Q==
X-Received: by 2002:a37:44cc:: with SMTP id r195mr1257805qka.77.1632765240635;
        Mon, 27 Sep 2021 10:54:00 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f10sm13094136qkp.50.2021.09.27.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:53:59 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:53:57 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YVIFNf/xZwlrWstK@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> On 9/23/21 03:21, Kent Overstreet wrote:
> > So if we have this:
> > 
> > struct page {
> > 	unsigned long	allocator;
> > 	unsigned long	allocatee;
> > };
> > 
> > The allocator field would be used for either a pointer to slab/slub's state, if
> > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > allocation - like compound order today, and probably whether or not the
> > (compound group of) pages is free.
> 
> The "free page in buddy allocator" case will be interesting to implement.
> What the buddy allocator uses today is:
> 
> - PageBuddy - determine if page is free; a page_type (part of mapcount
> field) today, could be a bit in "allocator" field that would have to be 0 in
> all other "page is allocated" contexts.
> - nid/zid - to prevent merging accross node/zone boundaries, now part of
> page flags
> - buddy order
> - a list_head (reusing the "lru") to hold the struct page on the appropriate
> free list, which has to be double-linked so page can be taken from the
> middle of the list instantly

That list_head is the problematic one. Why do we need to be able to take a page
from the middle of a freelist?
