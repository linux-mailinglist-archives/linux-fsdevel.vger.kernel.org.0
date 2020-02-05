Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40BE15352E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBEQZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 11:25:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42556 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:25:12 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izNUE-007rET-L5; Wed, 05 Feb 2020 16:25:10 +0000
Date:   Wed, 5 Feb 2020 16:25:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [put pull] timestamp stuff
Message-ID: <20200205162510.GW23230@ZenIV.linux.org.uk>
References: <20200204150015.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
 <20200205160801.x3hr3ziwz2ffxltt@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205160801.x3hr3ziwz2ffxltt@chatter.i7.local>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:08:01AM -0500, Konstantin Ryabitsev wrote:

> >   To: Linus Torvalds <torvalds@linux-foundation.org>
> >   Cc: fsdevel.@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
> >   Subject: [git pull] kernel-initiated rm -rf on ramfs-style filesystems
> >   Message-ID: <20200204150912.GS23230@ZenIV.linux.org.uk>
> > 
> > on that other message in my mailbox, but I don't see it on lore. Odd.
> > Is it because the "fsdevel" address is mis-spelled on the Cc line?
> > Strange.
> 
> That message-id doesn't appear to have traversed the mail system, so my 
> guess would be that it didn't make it past some upstream MTA -- either 
> vger or the one before it. The fact that this messages is not on 
> lkml.org either seems to confirm that theory.

At a guess, bogus address in Cc (mistyped mutt alias - "fsdevel" would've
become "linux-fsdevel@vger.kernel.org", "fsdevel." got interpreted as
local address) got something spooked enough to filter it out...
