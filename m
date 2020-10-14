Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1A28E492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgJNQes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgJNQes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:34:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E431C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 09:34:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so169980lfj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0AU+sz3hX9IdLoDFFqg1uYSLIaKHJ9Dh+Kq+wNQplZA=;
        b=siUGYTrxpOgMgKoVv34+z5bf04IUehAgVcT+zPDqZqkF3Lpkm5cAiZarWBneO8YrFt
         UnDq9nOSZf4KZeeGHW0tjarRjkN+HDZD3f8ylOd2Hb2jK4Y2qwCp472ZXXQeIUVuwoKW
         ixX79nywpZBWgsoBlGbbxkMA/1pYXhzMGJQkryaRfVV9G0ky8YzdK+I+PJNY/qo/SUgt
         gynWTuHtbEQnUQ028fKr31sqKp9ViDSjPKg/Mu+upQYhOiucOhOQA4NeOArlrymQyKw6
         um14hJ3k4L2hIZFmjscyIelPJjGZgV3eFxFCMdY9TLhmVAI4iz58VP1KWS0vhQRKtVhG
         mHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0AU+sz3hX9IdLoDFFqg1uYSLIaKHJ9Dh+Kq+wNQplZA=;
        b=LwZfFaE1Z6/k4+ee4GHictVUBzG31gvihaoGAm3fXw8OLVJcDYbUdBufcYWGM6dPJp
         G/QjMY4XJBm8GkBV1ZestPZTHteyuJV6pDdNfyjJLU8NpcJj/BoF/hCnxktAGFg60eL+
         8WdJzunJt0xSfqxCSZpefhKr57jdLOnI00EF4JEjdbTIoFm4Qb9LJGoKIpZkywyZ3RJp
         JiTaRjouFoWZ4swSWzq+6PWAHjJBO2zM/LH+kscht3rumR9LEO58Lz+9cZ6tJ8Ylw1yk
         9QOnsYwd3pGg/OqdATKOMCjVY2WzhrSL9n5ynW81/gNwSadxL7MPTxA3c+geU5PmieE6
         DExA==
X-Gm-Message-State: AOAM532q8REEy9dmg9/i4+OWUfq8qbIGllKinDOTw7WNX8tHODTj6G+Q
        N5PlJ7Mh40uIN/rDpM2WrwfRQVu2Iy08X21CNb8=
X-Google-Smtp-Source: ABdhPJw0Onl2frKyZjaB7M0lphZPB2AguRFc+OmfN6L7SMEQ23j7zUp7+m6ANqhYtIB5WIEko+iQ7YOv9xHd+MpmtJU=
X-Received: by 2002:a05:6512:41e:: with SMTP id u30mr69486lfk.204.1602693286653;
 Wed, 14 Oct 2020 09:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201014134909.GL20115@casper.infradead.org> <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
 <20201014153836.GM20115@casper.infradead.org>
In-Reply-To: <20201014153836.GM20115@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 14 Oct 2020 09:34:34 -0700
Message-ID: <CAHbLzkqw+retBoiJRgLbSKD2QW1HMnG_q3Tca4gg_eRccbBxqA@mail.gmail.com>
Subject: Re: PagePrivate handling
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 8:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 14, 2020 at 10:50:51AM -0400, Chris Mason wrote:
> > On 14 Oct 2020, at 9:49, Matthew Wilcox wrote:
> > > Our handling of PagePrivate, page->private and PagePrivate2 is a gian=
t
> > > mess.  Let's recap.
> > >
> > > Filesystems which use bufferheads (ie most of them) set page->private
> > > to point to a buffer_head, set the PagePrivate bit and increment the
> > > refcount on the page.
> > >
> > > The vmscan pageout code (*) needs to know whether a page is freeable:
> > >         if (!is_page_cache_freeable(page))
> > >                 return PAGE_KEEP;
> > > ... where is_page_cache_freeable() contains ...
> > >         return page_count(page) - page_has_private(page) =3D=3D 1 +
> > > page_cache_pins;
> > >
> > > That's a little inscrutable, but the important thing is that if
> > > page_has_private() is true, then the page's reference count is suppos=
ed
> > > to be one higher than it would be otherwise.  And that makes sense gi=
ven
> > > how "having bufferheads" means "page refcount ges incremented".
> > >
> > > But page_has_private() doesn't actually mean "PagePrivate is set".
> > > It means "PagePrivate or PagePrivate2 is set".  And I don't understan=
d
> > > how filesystems are supposed to keep that straight -- if we're settin=
g
> > > PagePrivate2, and PagePrivate is clear, increment the refcount?
> > > If we're clearing PagePrivate, decrement the refcount if PagePrivate2
> > > is also clear?
> >
> > At least for btrfs, only PagePrivate elevates the refcount on the page.
> > PagePrivate2 means:
> >
> > This page has been properly setup for COW=E2=80=99d IO, and it went thr=
ough the
> > normal path of page_mkwrite() or file_write() instead of being silently
> > dirtied by a deep corner of the MM.
>
> What's not clear to me is whether btrfs can be in the situation where
> PagePrivate2 is set and PagePrivate is clear.  If so, then we have a bug
> to fix.
>
> > > We introduced attach_page_private() and detach_page_private() earlier
> > > this year to help filesystems get the refcount right.  But we still
> > > have a few filesystems using PagePrivate themselves (afs, btrfs, ceph=
,
> > > crypto, erofs, f2fs, jfs, nfs, orangefs & ubifs) and I'm not convince=
d
> > > they're all getting it right.
> > >
> > > Here's a bug I happened on while looking into this:
> > >
> > >         if (page_has_private(page))
> > >                 attach_page_private(newpage, detach_page_private(page=
));
> > >
> > >         if (PagePrivate2(page)) {
> > >                 ClearPagePrivate2(page);
> > >                 SetPagePrivate2(newpage);
> > >         }
> > >
> > > The aggravating thing is that this doesn't even look like a bug.
> > > You have to be in the kind of mood where you're thinking "What if pag=
e
> > > has Private2 set and Private clear?" and the answer is that newpage
> > > ends up with PagePrivate set, but page->private set to NULL.
> >
> > Do you mean PagePrivate2 set but page->private NULL?
>
> Sorry, I skipped a step of the explanation.
>
> page_has_private returns true if Private or Private2 is set.  So if
> page has PagePrivate clear and PagePrivate2 set, newpage will end up
> with both PagePrivate and PagePrivate2 set -- attach_page_private()
> doesn't check whether the pointer is NULL (and IMO, it shouldn't).
>
> Given our current macros, what was _meant_ here was:
>
>          if (PagePrivate(page))
>                  attach_page_private(newpage, detach_page_private(page));
>
> but that's not obviously right.
>
> > Btrfs should only hage
> > PagePrivate2 set on pages that are formally in our writeback state mach=
ine,
> > so it=E2=80=99ll get cleared as we unwind through normal IO or truncate=
 etc.  For
> > data pages, btrfs page->private is simply set to 1 so the MM will kindl=
y
> > call releasepage for us.
>
> That's not what I'm seeing here:
>
> static void attach_extent_buffer_page(struct extent_buffer *eb,
>                                       struct page *page)
> {
>         if (!PagePrivate(page))
>                 attach_page_private(page, eb);
>         else
>                 WARN_ON(page->private !=3D (unsigned long)eb);
> }
>
> Or is that not a data page?
>
> > > So what shold we do about all this?  First, I want to make the code
> > > snippet above correct, because it looks right.  So page_has_private()
> > > needs to test just PagePrivate and not PagePrivate2.  Now we need a
> > > new function to call to determine whether the filesystem needs its
> > > invalidatepage callback invoked.  Not sure what that should be named.
> >
> > I haven=E2=80=99t checked all the page_has_private() callers, but maybe
> > page_has_private() should stay the same and add page_private_count() fo=
r
> > times where we need to get out our fingers and toes for the refcount ma=
th.
>
> I was thinking about page_expected_count() which returns the number of
> references from the page cache plus the number of references from
> the various page privates.  So is_page_cache_freeable() becomes:
>
>         return page_count(page) =3D=3D page_expected_count(page) + 1;
>
> can_split_huge_page() becomes:
>
>         if (page_has_private(page))
>                 return false;
>         return page_count(page) =3D=3D page_expected_count(page) +
>                         total_mapcount(page) + 1;
>
> > > I think I also want to rename PG_private_2 to PG_owner_priv_2.
> > > There's a clear relationship between PG_private and page->private.
> > > There is no relationship between PG_private_2 and page->private, so i=
t's
> > > a misleading name.  Or maybe it should just be PG_fscache and btrfs c=
an
> > > find some other way to mark the pages?
> >
> > Btrfs should be able to flip bits in page->private to cover our current
> > usage of PG_private_2.  If we ever attach something real to page->priva=
te,
> > we can flip bits in that instead.  It=E2=80=99s kinda messy though and =
we=E2=80=99d have to
> > change attach_page_private a little to reflect its new life as a bit se=
tting
> > machine.
>
> It's not great, but with David wanting to change how PageFsCache is used,
> it may be unavoidable (I'm not sure if he's discussed that with you yet)
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Dfscache-iter&id=3D6f10fd7766ed6d87c3f696bb7931281557b389f5 shows p=
art of it
> -- essentially he wants to make PagePrivate2 mean that I/O is currently
> ongoing to an fscache, and so truncate needs to wait on it being finished=
.
>
> > >
> > > Also ... do we really need to increment the page refcount if we have
> > > PagePrivate set?  I'm not awfully familiar with the buffercache -- is
> > > it possible we end up in a situation where a buffer, perhaps under I/=
O,
> > > has the last reference to a struct page?  It seems like that referenc=
e
> > > is
> > > always put from drop_buffers() which is called from
> > > try_to_free_buffers()
> > > which is always called by someone who has a reference to a struct pag=
e
> > > that they got from the pagecache.  So what is this reference count fo=
r?
> >
> > I=E2=80=99m not sure what we gain by avoiding the refcount bump?  Many =
filesystems
> > use the pattern of: =E2=80=9Cput something in page->private, free that =
thing in
> > releasepage.=E2=80=9D  Without the refcount bump it feels like we=E2=80=
=99d have more magic
> > to avoid freeing the page without leaking things in page->private.  I t=
hink
> > the extra ref lets the FS crowd keep our noses out of the MM more often=
, so
> > it seems like a net positive to me.
>
> The question is whether the "thing" in page->private can ever have the
> last reference on a struct page.  Gao says erofs can be in that situation=
,
> so never mind this change.

I recall when truncation is failed to remove private data, we may end
up having page->private as last reference. Anyway vmscan can handle
such case.

>
>
