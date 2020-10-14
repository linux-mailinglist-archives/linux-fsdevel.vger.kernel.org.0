Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB828E4E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgJNQx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJNQx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:53:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E563C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 09:53:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so158598ljj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUWxdkdjg3lFrQZhFI9PuRj+O488sFbEr8pq3LquhNM=;
        b=Dt066gP1+r7WsWUip/hPQkGd3om2xvR/D+iICX0sXkTFFYEBD2RqEDZQy8tSaGaMUR
         H5wB5kzJTkCT8oQU72tNDP92wSRVr2NCIZjn7r0Dv76pfk4Ja635M0iatP/0mGcrd5ff
         ONoPiJsCy5e36akQzfPFFU9VTMraqg5N1opLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUWxdkdjg3lFrQZhFI9PuRj+O488sFbEr8pq3LquhNM=;
        b=bSp3A3w/E12h5oTTvdQFpjdii1/ptqwAX/r4SuDlN2BcmvzYxwd9eksy080jGdKuM8
         GvjYh59NMMEPveCqqE7mcLss07KwA9ZefXuYyowkSm3Z2pHDE+kz45xWJbUlIj1HVzlm
         iPjqN9S2XPgNiwPbJAEvVW7cxLcGBY33UD6kdXmL6REIOCOaGmMr0CvKhRSzORVTvvVm
         8Aw/4YXaAdEQx65o3ByiHujLZb1uu2ixbFUtZRo+LxpW3aUJWF26SYw3/0AYiCYnwo10
         3YkT6KZVlke/XTsXHoT6Qc4gcdxuZOC98KFbeNqhxqwWDE0Z/6zuptcq3hr08vO0o6yX
         to2g==
X-Gm-Message-State: AOAM533YKzNBxsStoUdWEcQu0Pbvc2sKDv7ADecjhCxj9n+ME9NlWTPT
        Ys5s2QHicLi4tDlyyWxfYe7mYBJ6cIYuVQ==
X-Google-Smtp-Source: ABdhPJzTa0u/FFjWcHykLgWj5Dd91qKAy4Yf6gWjs3+PraocwCY+gA9Zvp8YWz59aWEmAN/N8Ld/cQ==
X-Received: by 2002:a2e:9bcf:: with SMTP id w15mr57781ljj.14.1602694433138;
        Wed, 14 Oct 2020 09:53:53 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u15sm1341794lfl.140.2020.10.14.09.53.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 09:53:51 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c21so122674ljn.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 09:53:51 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr55751lji.102.1602694431261;
 Wed, 14 Oct 2020 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com> <20201014130555.kdbxyavqoyfnpos3@box>
In-Reply-To: <20201014130555.kdbxyavqoyfnpos3@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 09:53:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
Message-ID: <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 6:05 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> So we remove strict serialization against truncation in
> filemap_map_pages() if the mapping is private.

Well, that particular patch does.

But as mentioned, that's the wrong way of doing it. It's just that the
right way - which keeps the serialization - requires some changes to
how we actually install the pte.

Right now that goes through alloc_set_pte(), and that one is basically
written with the page lock in mind. So the current logic is

 - lock page

 - check page->mapping etc that is now stable

 - lock page tables if required (alloc_set_pte -> pte_alloc_one_map ->
pte_offset_map_lock)

 - insert pte

but that whole alloc_set_pte() thing is actually much too generic for
what "map_pages()" really wants, and I think we could re-organize it.

In particular, what I _think_ we could do is:

 - lock the page tables

 - check that the page isn't locked

 - increment the page mapcount (atomic and ordered)

 - check that the page still isn't locked

 - insert pte

without taking the page lock. And the reason that's safe is that *if*
we're racing with something that is about the remove the page mapping,
then *that* code will

 (a) hold the page lock

 (b) before it removes the mapping, it has to remove it from any
existing mappings, which involves checking the mapcount and going off
and getting the page table locks to remove any ptes.

but my patch did *not* do that, because you have to re-organize things a bit.

Note that the above still keeps the "optimistic" model - if the page
is locked, we'll skip that pte, and we'll end up doing the heavy thing
(which will then take the pte lock if required). Which is why we
basically get away with that "only test page lock, don't take it"
approach with some ordering.

But my theory is that the actual truncate case is *so* rare that we
basically don't need to even worry about it, and that once the
(common) page fault case doesn't need the page lock, then that whole
"fall back to slow case" simply doesn't happen in practice.

> IIUC, we can end up with a page with ->mapping == NULL set up in a PTE for
> such mappings. The "page->mapping != mapping" check makes the race window
> smaller, but doesn't remove it.

Yes, that patch I posted as an RFC does exactly that. But I think we
can keep the serialization if we just make slightly more involved
changes.

And they aren't necessarily a _lot_ more involved. In fact, I think we
may already hold the page table lock due to doing that
"pte_alloc_one_map()" thing over all of filemap_map_pages(). So I
think the only _real_ problem is that I think we increment the
page_mapcount() too late in alloc_set_pte().

And yeah, I realize this is a bit handwavy. But that's why I sent
these things out as an RFC. To see if people can shoot holes in this,
and maybe do that proper patch instead of my "let's get discussion
going" one.

Also, I really do think that our current "private mappings are
coherent with fiel changes" is a big QoI issue: it's the right thing
to do. So I wouldn't actually really want to take advantage of
"private mappings don't really _have_ to be coherent according to
POSIX". That's a lazy cop-out.

So I dislike my patch, and don't think it's really acceptable, but as
a "let's try this" I think it's a good first step.

> I'm not sure all codepaths are fine with this. For instance, looks like
> migration will back off such pages: __unmap_and_move() doesn't know how to
> deal with mapped pages with ->mapping == NULL.

So as outlined above, I think we can avoid the ->mapping == NULL case,
and we can remove all the races.

But it would still do new things, like incremnt the page mapcount
without holding the page lock. I think that's ok - we already
_decrement_ it without holding the lock, so it's not that the count is
stable without locking - but at a minimum we'd have that "need to make
sure the memory ordering between testing the page lock initially,
incrementing the count, and re-testing is ok". And maybe some code
that expects things to be stable.

So I'm not at all claiming that things are obviously fine. I'm happy
to see that Hugh started some practical stress-tests on that RFC
patch, and I think we can improve on the situation.

               Linus
