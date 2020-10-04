Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9276F282D7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgJDUFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgJDUFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 16:05:34 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DBC0613CE;
        Sun,  4 Oct 2020 13:05:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPAGB-00BwHH-Bg; Sun, 04 Oct 2020 20:05:31 +0000
Date:   Sun, 4 Oct 2020 21:05:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC][PATCHSET] epoll cleanups
Message-ID: <20201004200531.GR3421308@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 04, 2020 at 11:08:11AM -0700, Linus Torvalds wrote:
> On Sat, Oct 3, 2020 at 7:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Locking and especially control flow in fs/eventpoll.c is
> > overcomplicated.  As the result, the code has been hard to follow
> > and easy to fuck up while modifying.
> 
> Scanning through the patches they all look superficially ok to me, but
> I'm wondering how much test coverage you have (because I'm wondering
> how much test coverage we have in general for epoll).

Besides the in-tree one (tools/testing/selftests/filesystems/epoll)
and LTP stuff (testcases/kernel/syscalls/epoll) - only davidel's
epoll_test.c.  Plus slapped together "let's try to make it go through
that codepath" stuff (combined with printks in fs/eventpoll.c)...
