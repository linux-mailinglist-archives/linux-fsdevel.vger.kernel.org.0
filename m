Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873DD1CC646
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgEJD1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 23:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgEJD1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 23:27:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13659C061A0C;
        Sat,  9 May 2020 20:27:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXccO-004oCo-4n; Sun, 10 May 2020 03:27:08 +0000
Date:   Sun, 10 May 2020 04:27:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCHES] uaccess simple access_ok() removals
Message-ID: <20200510032708.GO23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 05:34:58PM -0700, Linus Torvalds wrote:
> On Sat, May 9, 2020 at 4:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Individual patches in followups; if nobody screams - into #for-next
> > it goes...
> 
> Looks fine to me, although I only read your commit logs, I didn't
> verify that what you stated was actually true (ie the whole "only used
> for xyz" parts).
> 
> But I'll take your word for it. Particularly the double-underscore
> versions are getting rare (and presumably some of the other branches
> you have make it rarer still).

I have - FWIW, right now I'm going through the patch series for netdev;
once I'm done with turning commit messages into something printable
(and finish rereading the patches themselves), there it goes, hopefully
tonight.  Then a bunch of small branches + repost of csum one + some
of the weird shit (comedi compat ioctls - the largest pile of
__get_user() and __put_user() outside of arch/* is festering there).
Then regset stuff + (probably) resurrection of i915 stuff.

I've got a bunch of stuff around execve(), but that'll have to wait
until I get through the recently posted execve-related patchsets...

Then there's e.g. mempolicy compat stuff, etc., but I'd rather wait
for several days before posting that, reviewers' bandwidth being
finite...
