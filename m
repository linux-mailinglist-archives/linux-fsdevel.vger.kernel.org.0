Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7428284A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgJDCtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgJDCtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:49:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1678C0613D0;
        Sat,  3 Oct 2020 19:49:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOu58-00BVBU-1j; Sun, 04 Oct 2020 02:49:02 +0000
Date:   Sun, 4 Oct 2020 03:49:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC][PATCHSET] epoll cleanups
Message-ID: <20201004024902.GN3421308@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004023608.GM3421308@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:36:08AM +0100, Al Viro wrote:
> 	Locking and especilly control flow in fs/eventpoll.c is
> overcomplicated.  As the result, the code has been hard to follow
> and easy to fuck up while modifying.
> 
> 	The following series attempts to untangle it; there's more to be done
> there, but this should take care of some of the obfuscated bits.  It also
> reduces the memory footprint of that thing.
> 
> 	The series lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #experimental.epoll
> and it survives light local beating.  It really needs review and testing.
> I'll post the individual patches in followups (27 commits, trimming about 120
> lines out of fs/eventpoll.c).

PS: the posted series is on top of #work.epoll, which got merged into mainline
on Friday.  Forgot to mention that - my apologies.
