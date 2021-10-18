Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B21432620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhJRSOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRSOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:14:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924AC06161C;
        Mon, 18 Oct 2021 11:12:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g17so7820486qtk.8;
        Mon, 18 Oct 2021 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1Y3hHjwpzUobNasEmJ1LbasYmT06ZrBoRVnLfQhAR0=;
        b=M+cYLFsQXMKBe086tLn8JKibWU7uGMqGxweAf+1IjkR7vkaR7gUvY8j8IcMMkrhAHU
         DXGYfSNzfByM+RS26Y3tpMBsO1dLWZKcJi+4lxVein2GeoZ8xpWClxKvBeuNsxCtSox3
         gFj4XIxPkiu2GqEF3jLjlY154pNJzItqCqSdqnnTQVGLQ08IiCzc5gpvU2qxdcnBkHXu
         GJUpy6jvXE8s9cj/ufGQ3Pe2q1zsOZByYnuG9t7Uyl+wfHNg+IC9qYL2w1+oY+OImXfC
         mv9ScOKfUtyhQAVb9T/pZhIhQNL4d9Q/+juXhmAPUY6y/G5NN1XZ3sddCbVoeXWRv0m5
         3MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1Y3hHjwpzUobNasEmJ1LbasYmT06ZrBoRVnLfQhAR0=;
        b=evCDs2T7ATG9hg9CY40ZhCUiN5VNjO3MoyFmUTlVJCL63UeFI5lU26TllABWSegaqE
         QILmDqVBs3/X5jW06bBg8zr3bBYrTsiFYS8LxIS0mlRdr9fVNzyQDWWzQkt+u7TEgtAf
         cJb6jtdhvX+7apZWJQ7ZSg5Qj9RfAEno3FrSkkyFWYhnUrs1P4u7Zw3NTV6gHL1sxyTn
         5Z7KOUxpKjqh36lZ4hTUlJQDnETUZD00eJWxQeJCDMQh2+pjlLqFE6HrgBrv03DkeuF2
         oBucgosFWoGfr/89dAYIIY6+7ST0r6RU8PlC2hivetAYXBhw/4B94XP4Qd7TWY+Ggr9C
         A65g==
X-Gm-Message-State: AOAM530c2GK5lskFZGp0q7ptMS0Mwb3rsLIJpuvT1TfYaFnu7yfnBkg5
        GabH+6+OfsG/f8ZJvXpwoQ==
X-Google-Smtp-Source: ABdhPJzUSAstoRyubIgeefnb4femxE5bBe7p0XNGuQ2TVeRfMhaLCl1FD1hyifZJ8eapRdC/tlf1Gw==
X-Received: by 2002:a05:622a:252:: with SMTP id c18mr31616513qtx.96.1634580757766;
        Mon, 18 Oct 2021 11:12:37 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c5sm6704063qkm.10.2021.10.18.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:12:36 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:12:32 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW25EDqynlKU14hx@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2lKcqwBZGDCz6T@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> I find this line of argument highly disingenuous.
> 
> No new type is necessary to remove these calls inside MM code. Migrate
> them into the callsites and remove the 99.9% very obviously bogus
> ones. The process is the same whether you switch to a new type or not.

Conversely, I don't see "leave all LRU code as struct page, and ignore anonymous
pages" to be a serious counterargument. I got that you really don't want
anonymous pages to be folios from the call Friday, but I haven't been getting
anything that looks like a serious counterproposal from you.

Think about what our goal is: we want to get to a world where our types describe
unambigiuously how our data is used. That means working towards
 - getting rid of type punning
 - struct fields that are only used for a single purpose

Leaving all the LRU code as struct page means leaving a shit ton of type punning
in place, and you aren't outlining any alternate ways of dealing with that. As
long as all the LRU code is using struct page, that halts efforts towards
separately allocating these types and making struct page smaller (which was one
of your stated goals as well!), and it would leave a big mess in place for god
knows how long. It's been a massive effort for Willy to get this far, who knows
when someone else with the requisite skillset would be summoning up the energy
to deal with that - I don't see you or I doing it.

Meanwhile: we've got people working on using folios for anonymous pages to solve
some major problems

 - it cleans up all of the if (normalpage) else if (hugepage) mess

 - it'll _majorly_ help with our memory fragmentation problems, as I recently
   outlined. As long as we've got a very bimodal distribution in our allocation
   sizes where the peaks are at order 0 and HUGEPAGE_ORDER, we're going to have
   problems allocating hugepages. If anonymous + file memory can be arbitrary
   sized compound pages, we'll end up with more of a poisson distribution in our
   allocation sizes, and a _great deal_ of our difficulties with memory
   fragmentation are going to be alleviated.

 - and on architectures that support merging of TLB entries, folios for
   anonymous memory are going to get us some major performance improvements due
   to reduced TLB pressure, same as hugepages but without nearly as much memory
   fragmetation pain

And on top of all that, file and anonymous pages are just more alike than they
are different. As I keep saying, the sane incremental approach to splitting up
struct page into different dedicated types is to follow the union of structs. I
get that you REALLY REALLY don't want file and anonymous pages to be the same
type, but what you're asking just isn't incremental, it's asking for one big
refactoring to be done at the same time as another.

> (I'll send more patches like the PageSlab() ones to that effect. It's
> easy. The only reason nobody has bothered removing those until now is
> that nobody reported regressions when they were added.)

I was also pretty frustrated by your response to Willy's struct slab patches.

You claim to be all in favour of introducing more type safety and splitting
struct page up into multiple types, but on the basis of one objection - that his
patches start marking tail slab pages as PageSlab (and I agree with your
objection, FWIW) - instead of just asking for that to be changed, or posting a
patch that made that change to his series, you said in effect that we shouldn't
be doing any of the struct slab stuff by posting your own much more limited
refactoring, that was only targeted at the compound_head() issue, which we all
agree is a distraction and not the real issue. Why are you letting yourself get
distracted by that?

I'm not really sure what you want Johannes, besides the fact that you really
don't want file and anon pages to be the same type - but I don't see how that
gives us a route forwards on the fronts I just outlined.
