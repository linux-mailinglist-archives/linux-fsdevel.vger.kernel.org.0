Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D02D34A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 22:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgLHUyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHUyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:20 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D3C0613D6;
        Tue,  8 Dec 2020 12:53:39 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmjz7-00HUxg-Md; Tue, 08 Dec 2020 20:53:21 +0000
Date:   Tue, 8 Dec 2020 20:53:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201208205321.GI3579531@ZenIV.linux.org.uk>
References: <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk>
 <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk>
 <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de>
 <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk>
 <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 12:25:55PM -0800, Linus Torvalds wrote:
> On Tue, Dec 8, 2020 at 11:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Said that, it does appear to survive all beating, and it does fix
> > a regression introduced in this cycle, so, provided that amount of
> > comments in there is OK with you...
> 
> Ok, considering Greg's note, I've pulled it. It's early in the last
> week, if something comes up we can still fix it.
> 
> That said, considering that I think the only use-case was that odd
> /proc splice use, and the really special WSL2 thing, and both of those
> are verified, it does sound safe to pull.
> 
> Famous last words...
> 
> Al, since you're around, would you mind looking at the two
> DCACHE_DONTCACHE patches too? Honestly, since they seem to be an issue
> only for DAX, and only for DAX policy changes, I don't consider them
> critical for 5.10, but they've been around for a while now.

Umm...  I've got
fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
and
fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
in "to apply" pile; if that's what you are talking about, I don't
think they are anywhere critical enough for 5.10-final, but I might
be missing something...

Al, still buried under piles of email ;-/
