Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D934B808
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhC0PlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0PkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:40:24 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01017C0613B1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 08:40:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m13so8816155oiw.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZESuPwCSf7zAcR2cGKk/CHabW7fEs1cOcXhkm3anZY=;
        b=MelJv90w+gGIM1JMDol5BkL8OgZuTiTD3QpNv2M8BM7DlHqDpZRZCs7hlbi7GvU0Lq
         tBnS1J4of5jRPAiZUUcIqqQsGJfsMsem+6t5/egbmVkTI84kuLpiHUrIBBRWZW+eSc7y
         wKUgTO8RwsofUaNizadmBYZaUhUYuaeg/DCkvVL7Y/6AJkzl/iDq1AQdbehUVe9+gQyR
         UfA90Ssc0ukkOt7wdF0kyLsLLP/yaM2LW4OShSXciE/ucwFAd3/0N4i9L9QnI0DkXo7M
         GD1RfRm5wHXjOngpfH2SK0+zBKJNqZzgjV6LlljEcr/X1jkLPhgiT1rQc+QxNGW5VeWe
         mNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZESuPwCSf7zAcR2cGKk/CHabW7fEs1cOcXhkm3anZY=;
        b=hKTcmCbc/fS29RCg/tJES8qyc1CMyCpG4Ogs6RqqpJ/5ESHXt8VAl9h+LL7nxNBGHh
         l12gIpOdsfGrBZylqAj6KDp96nr/pfW4rJoc8MAdnS8pKmHTgUNdcJ/ksOQFz6VatlHo
         h54sk0SOu2f27Y6+dewBaGJmh6jdCBc0n7ryb1aETAPEZULrs+K2YKY57uzskwxkGJSn
         Z3swmWNPwZ4DQQ+L/5aV4UmdGOFIRlCRgs6UJc54DfBNL3hqXJVP11+aiKpWjBUqYwSj
         ctrnVWRoHhPTA8hKLKEQoqM4H92Vi1AyBt69IJsWa9kMcUKBaC0rxS0OKVsCP/E6RUkF
         YSJQ==
X-Gm-Message-State: AOAM530zjGmgwWYjE04JEcWC7xtaG1B0K1zAmfDXej3bPor3UICMwaBR
        kwv0sAFJUN2T+kz//2W64Ww8Qk9Zbn5TrtHJp+nSBDVmb7G+0fDg
X-Google-Smtp-Source: ABdhPJwumFTI4Iop6e1zVJ7CwQGRtT6TwuJsezPcFZ3DTSHU24Ut/yjwE6DIkcpvr5avD8vRFBTuH/LpA3QS7F3fboI=
X-Received: by 2002:aca:478d:: with SMTP id u135mr13412996oia.174.1616859619003;
 Sat, 27 Mar 2021 08:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
In-Reply-To: <20210327135659.GH1719932@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 27 Mar 2021 11:40:08 -0400
Message-ID: <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK... I used David's suggestion, and also put I it right in
orangefs_readahead, orangefs_readahead_cleanup is gone.

It seems to me to work great, I used it some with some printks
in it and watched it do like I think it ought to.

Here's an example of what's upstream in
5.11.8-200.fc33.x86_64:

# dd if=/pvfsmnt/z1 of=/dev/null bs=4194304 count=30
30+0 records in
30+0 records out
125829120 bytes (126 MB, 120 MiB) copied, 5.77943 s, 21.8 MB/s

And here's this version of orangefs_readahead on top of
5.12.0-rc4:

# dd if=/pvfsmnt/z1 of=/dev/null bs=4194304 count=30
30+0 records in
30+0 records out
125829120 bytes (126 MB, 120 MiB) copied, 0.325919 s, 386 MB/s

So now we're getting somewhere :-). I hope readahead_expand
will be upstream soon.

I plan to use inode->i_size and offset to decide how much
expansion is needed on each call to orangefs_readahead,
I hope looking at i_size isn't one of those race condition
things I'm always screwing up on.

If y'all think the orangefs_readahead below is an OK starting
point, I'll add in the i_size/offset logic so I can get
fullsized orangefs gulps of readahead all the way up to
the last whatever sized fragment of the file and run
xfstests on it to see if it still seems like it is doing right.

One day when it is possible I wish I could figure out how to use
huge pages or something, copying 1024 pages at a time out of the orangefs
internal buffer into the page cache is probably slower than if
I could figure out a way to copy 4194304 bytes out of our buffer
into the page cache at once...

Matthew>> but given that we're talking about doing I/O, probably
Matthew>> not enough to care about.

With orangefs that almost ALL we care about.

Thanks for your help!

-Mike

static void orangefs_readahead(struct readahead_control *rac)
{
unsigned int npages;
loff_t offset;
struct iov_iter iter;
struct file *file = rac->file;
struct inode *inode = file->f_mapping->host;

struct xarray *i_pages;
pgoff_t index;
struct page *page;

int ret;

loff_t new_start = readahead_index(rac) * PAGE_SIZE;
size_t new_len = 524288;
readahead_expand(rac, new_start, new_len);

npages = readahead_count(rac);
offset = readahead_pos(rac);
i_pages = &file->f_mapping->i_pages;

iov_iter_xarray(&iter, READ, i_pages, offset, npages * PAGE_SIZE);

/* read in the pages. */
ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);

/* clean up. */
while ((page = readahead_page(rac))) {
page_endio(page, false, 0);
put_page(page);
}
}

On Sat, Mar 27, 2021 at 9:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Mar 27, 2021 at 08:31:38AM +0000, David Howells wrote:
> > However, in Mike's orangefs_readahead_cleanup(), he could replace:
> >
> >       rcu_read_lock();
> >       xas_for_each(&xas, page, last) {
> >               page_endio(page, false, 0);
> >               put_page(page);
> >       }
> >       rcu_read_unlock();
> >
> > with:
> >
> >       while ((page = readahead_page(ractl))) {
> >               page_endio(page, false, 0);
> >               put_page(page);
> >       }
> >
> > maybe?
>
> I'd rather see that than open-coded use of the XArray.  It's mildly
> slower, but given that we're talking about doing I/O, probably not enough
> to care about.
