Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B12175167
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 01:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCBAj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 19:39:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43460 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgCBAj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:39:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8Z7G-003jUU-Ag; Mon, 02 Mar 2020 00:39:26 +0000
Date:   Mon, 2 Mar 2020 00:39:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200302003926.GM23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:34:06PM -0600, Linus Torvalds wrote:
> On Sun, Mar 1, 2020 at 3:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Extended since the last repost.  The branch is in #work.dotdot;
> > #work.do_last is its beginning (about 2/3 of the total), slightly
> > reworked since the last time.
> 
> I'm traveling, so only a quick read-through.
> 
> One request: can you add the total diffstat to the cover letter (along
> with what you used as a base)?

Sure, no problem (and the base is still -rc1)

> I did apply it to a branch just to look
> at it more closely, so I can see the final diffstat that way:
> 
>  Documentation/filesystems/path-lookup.rst |    7 +-
>  fs/autofs/dev-ioctl.c                     |    6 +-
>  fs/internal.h                             |    1 -
>  fs/namei.c                                | 1333 +++++++++------------
>  fs/namespace.c                            |   96 +-
>  fs/open.c                                 |    4 +-
>  include/linux/namei.h                     |    4 +-
>  7 files changed, 642 insertions(+), 809 deletions(-)
> 
> but it would have been nice to see in your explanation too.
> 
> Anyway, from a quick read-through, I don't see anything that raises my
> hackles - you've fixed the goto label naming, and I didn't notice
> anything else odd.
> 
> Maybe that was because I wasn't careful enough. But the final line
> count certainly speaks for the series..

Heh...  Part of my metrics is actually "how large a sheet of paper does
one need to fit the call graph on" ;-)

I hope it gets serious beating, though - it touches pretty much every
codepath in pathname resolution.  Is there any way to sic the bots on
a branch, short of "push it into -next and wait for screams"?
