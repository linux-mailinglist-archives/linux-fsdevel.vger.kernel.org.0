Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2523429EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 03:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCTCJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCTCJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:09:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C009C061760;
        Fri, 19 Mar 2021 19:09:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso5692848pjb.4;
        Fri, 19 Mar 2021 19:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+Sd5TkDkbYjDcW9c09ppjohkzoeSBsR3J/XEf8zomc=;
        b=V3n6jkfcvEkoHpTVHHc2tsWXuinWGyHZTGyhBSxnADEwW7fdQ0GnRCSIzxDcrMUqE1
         MXBuRsJoNO9SIrYDBalKJpfL1w1cW7Lm23UPOWHdh/bYVgVJIqQdjmrygX1hbPZAdeOd
         k03u64ZAh8tJ10tFn1Oi24srF1M3jrBPtXDm7eN3l5n1eKtYR1awFWPnql15fwOwDK9H
         qQnqiqR0aLkoOyJW2xydHWpYHfmqIdPPq3ypQUPEd3PJlj+L3YoS9aeyDOVRXYYzPD+/
         NFIumgHxSHpa+vgRyvYqBx4DM0CNSdjKY/AQtmYIGdMhObqXDFVIfSYuPKzeh8aI02r6
         lv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+Sd5TkDkbYjDcW9c09ppjohkzoeSBsR3J/XEf8zomc=;
        b=nXy2XMmxH9wI22y8HUoSqOX8X1j3zcAezUWThGfFYzaZsM2/Mebs3zVX/XCpKJ8BIi
         rs2IaxJinwWBrytq8uGPDVPOafpv2vA7ClXzqy7GSFWk5yF25cGptAyCr6hRhnJPenU/
         iWdVvzodVaI462OQaidw5fm6NU+cwaEoVdf1f9ysAdSh4JF+YMSUQ8tmoZEHweZ+qzQM
         rIiZPOBWD+swaFBi+oKW/1aXAIPyYM1xtg+vj9qj4A5oV5u3AEMMIquN9cIuNdyaywIf
         qL7Bf9S/WkGsVgTkPKbbeG6IP6uxn7N7K/eS+O8NIDJAKhPKbEeKzr0nTylH3ZeQknt+
         eV2A==
X-Gm-Message-State: AOAM533wBVz/d/0q58vFpHhAwlQ4mtSEQlnH20uDKewgi/uwvkTqqIUG
        v3NW91gelOo5bG9KGdMLzIw=
X-Google-Smtp-Source: ABdhPJx5mqZ3b2Tdd/JDeRtXn/WwG7dih3Ww8eM9H065TK7jFCpTnOg+ljp0WgS1SfQ142iuVpX4ZA==
X-Received: by 2002:a17:90a:bf15:: with SMTP id c21mr1417714pjs.160.1616206165399;
        Fri, 19 Mar 2021 19:09:25 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id v13sm6018780pfu.54.2021.03.19.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 19:09:23 -0700 (PDT)
Date:   Sat, 20 Mar 2021 13:09:20 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210320020920.GD77072@balbir-desktop>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
 <20210318235645.GB3346@balbir-desktop>
 <20210319012527.GX3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319012527.GX3420@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 01:25:27AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 19, 2021 at 10:56:45AM +1100, Balbir Singh wrote:
> > On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
> > > A struct folio refers to an entire (possibly compound) page.  A function
> > > which takes a struct folio argument declares that it will operate on the
> > > entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> > > guarantees that the pointer it is passing does not point to a tail page.
> > >
> > 
> > Is this a part of a larger use case or general cleanup/refactor where
> > the split between page and folio simplify programming?
> 
> The goal here is to manage memory in larger chunks.  Pages are now too
> small for just about every workload.  Even compiling the kernel sees a 7%
> performance improvement just by doing readahead using relatively small
> THPs (16k-256k).  You can see that work here:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/master
> 
> I think Kirill, Hugh and others have done a fantastic job stretching
> the page struct to work in shmem, but we really need a different type
> to avoid people writing code that _looks_ right but is actually buggy.
> So I'm starting again, this time with the folio metaphor.

Thanks, makes sense, I'll take a look.

Balbir Singh.
