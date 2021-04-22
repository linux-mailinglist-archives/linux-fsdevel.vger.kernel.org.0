Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD636802C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhDVMVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhDVMVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:21:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526CC06138B
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 05:21:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o5so46020512qkb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qVWrfQzUOT2W5T6LzCbeZXCDM93ivBP3SLZzFzlfi4E=;
        b=Ua3mkPD/Xz9lzWvgIzVY3P//fV1gr9BbsHlBhhjqwmXmajXfImTOzvXIzBwM8Z1Lu9
         X+tqw5PKqwgg/STXozh3785Y7GuSKT8xJP3YqLUlEz1MS7Ig5ksTLOYIjKuabNevAxrP
         o9YJDw+2dvkU8YWpD5M0duw9U/2YEQ94ZrFuNq/AljCHbyJuG2J6gBcCPRuODL5PNPcS
         WlQKaPfhGLu9jysxZOGvwpU/5giO0guXha2TJWgVPDRIc7V9di2fSayGB6T7rAga8ZRM
         +Mpw7dBzGk2fjMJugMz/RHOSZ5yIjO4nUTChSqGe6RLQPhX8x6zvV+Fx9GhuUS6ogY3y
         nwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qVWrfQzUOT2W5T6LzCbeZXCDM93ivBP3SLZzFzlfi4E=;
        b=thHDDKtkigNFrlKbKifFjH7slqF8LpAoN0bqrU3jI/Hwr7SP71f+D8nhm5MwbyU5KZ
         yfTpVuoIlpgin+aIiYlvqda54Z+3NA0sHcYHqvFNRdneaYyyHAuJk2qu8FtA3cmugxK0
         Tbi+7felqjkPRZmm+/BAwa5XfyUWkChKnDkdsgCBLI/mIULT+U2H1L3BBRPkr20kzerY
         tWhQCRD3QOFLJgYxuEc9ys7MrnKtyZ7CSblArKDICoTgVQh4qv+oxMSjRy7/XxEkZA0c
         l/Q9jzKDc1WUfkz+9e1PW5NfrFjK1H4Vv9WGWxFJq/moWzvrZjespyqIeSyqDcFN6+3z
         5fMA==
X-Gm-Message-State: AOAM5332ixWLRtohi7gZya6AWU/84Mymb6ZE8dKBgrUa6xXDiJX/57xO
        STKejA+9SFt6LT9tfZWWn/fGRo2xaXitgA==
X-Google-Smtp-Source: ABdhPJzwE+9aeUZVBpFovriagH/KNZxNHbpOUz5vHV6OomQkhIlD0Qo0haX5OGY5XKqAyn+WCHqMgA==
X-Received: by 2002:a37:c57:: with SMTP id 84mr3406814qkm.340.1619094078598;
        Thu, 22 Apr 2021 05:21:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id w67sm2044765qkc.79.2021.04.22.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 05:21:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lZYKb-009xA0-8R; Thu, 22 Apr 2021 09:21:17 -0300
Date:   Thu, 22 Apr 2021 09:21:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: (in)consistency of page/folio function naming
Message-ID: <20210422122117.GE2047089@ziepe.ca>
References: <20210422032051.GM3596236@casper.infradead.org>
 <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:09:45AM +0200, David Hildenbrand wrote:
> On 22.04.21 05:20, Matthew Wilcox wrote:
> > 
> > I'm going through my patch queue implementing peterz's request to rename
> > FolioUptodate() as folio_uptodate().  It's going pretty well, but it
> > throws into relief all the places where we're not consistent naming
> > existing functions which operate on pages as page_foo().  The folio
> > conversion is a great opportunity to sort that out.  Mostly so far, I've
> > just done s/page/folio/ on function names, but there's the opportunity to
> > regularise a lot of them, eg:
> > 
> > 	put_page		folio_put
> > 	lock_page		folio_lock
> > 	lock_page_or_retry	folio_lock_or_retry
> > 	rotate_reclaimable_page	folio_rotate_reclaimable
> > 	end_page_writeback	folio_end_writeback
> > 	clear_page_dirty_for_io	folio_clear_dirty_for_io
> > 
> > Some of these make a lot of sense -- eg when ClearPageDirty has turned
> > into folio_clear_dirty(), having folio_clear_dirty_for_io() looks regular.
> > I'm not entirely convinced about folio_lock(), but folio_lock_or_retry()
> > makes more sense than lock_page_or_retry().  Ditto _killable() or
> > _async().
> > 
> > Thoughts?
> 
> I tend to like prefixes: they directly set the topic.
> 
> The only thing I'm concerned is that we end up with
> 
> put_page vs. folio_put
> 
> which is suboptimal.

We have this issue across the kernel already, eg kref_put() vs its
wrapper put_device()

Personally I tend to think the regularity of 'thing'_'action' is
easier to remember than to try to guess/remember that someone judged
'action'_'thing' to be more englishy.

Jason
