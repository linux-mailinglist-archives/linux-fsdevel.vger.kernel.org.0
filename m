Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81B37BC7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhELM1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhELM1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 08:27:35 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F62C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 05:26:25 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DF007C01C; Wed, 12 May 2021 14:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620822382; bh=qRiEqFkARgBkMB/Fjc0OdbBaBkXH4b8kFypa6t8BEow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scHnOKsdnhVcwu0hQnueE+cYG7l5yJnpN5A5ieyQH87/Gi68f4U9vULVkMMDMFkwj
         qOOPbzsjPFnIGL5BbnvEKfRQWnijcTjlKK/skd9MDxZFF2g4SkNgfZUdGYUYsZuiHX
         aVwm9cloG0RjCbV9mHePnt4x5qegFC9xoUfa7ckO0/mYyraiuJAe2rVEjxzGxVTWRS
         rkX8330C8hEDGgDNosuKUWi1KmsuO1yxwkzI+CTJlCUFQoJv8h8Z620KmMC2V55tfo
         624BMFW3R4PYwn+yjQvez1q5kTIpUulBaQoEIBZ+FOsIHM/GIeOQWL5GzjGOFgCAek
         o4O2flcoiPxmg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 84612C009;
        Wed, 12 May 2021 14:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620822382; bh=qRiEqFkARgBkMB/Fjc0OdbBaBkXH4b8kFypa6t8BEow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scHnOKsdnhVcwu0hQnueE+cYG7l5yJnpN5A5ieyQH87/Gi68f4U9vULVkMMDMFkwj
         qOOPbzsjPFnIGL5BbnvEKfRQWnijcTjlKK/skd9MDxZFF2g4SkNgfZUdGYUYsZuiHX
         aVwm9cloG0RjCbV9mHePnt4x5qegFC9xoUfa7ckO0/mYyraiuJAe2rVEjxzGxVTWRS
         rkX8330C8hEDGgDNosuKUWi1KmsuO1yxwkzI+CTJlCUFQoJv8h8Z620KmMC2V55tfo
         624BMFW3R4PYwn+yjQvez1q5kTIpUulBaQoEIBZ+FOsIHM/GIeOQWL5GzjGOFgCAek
         o4O2flcoiPxmg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f0ca766e;
        Wed, 12 May 2021 12:26:17 +0000 (UTC)
Date:   Wed, 12 May 2021 21:26:02 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
Message-ID: <YJvJWj/CEyEUWeIu@codewreck.org>
References: <87tun8z2nd.fsf@suse.de>
 <87czu45gcs.fsf@suse.de>
 <2507722.1620736734@warthog.procyon.org.uk>
 <2882181.1620817453@warthog.procyon.org.uk>
 <87fsysyxh9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsysyxh9.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques wrote on Wed, May 12, 2021 at 12:58:58PM +0100:
> <...>-20591   [000] ...2    67.538644: fscache_cookie: GET prn c=000000003080d900 u=50 p=0000000042542ee5 Nc=48 Na=1 f=22
> <...>-20591   [000] ...1    67.538645: fscache_acquire: c=0000000011fa06b1 p=000000003080d900 pu=50 pc=49 pf=22 n=9p.inod
> <...>-20599   [003] .N.2    67.542180: 9p_fscache_cookie: v9fs_drop_inode cookie: 0000000097476aaa
> [...]
>
> So, this is... annoying, I guess.

Oh, this actually looks different from what I had in mind.

So if I'm reading this right, the dup acquire happens before drop on
another thread, meaning iget5_locked somehow returned an inode with
I_NEW on same i_ino than that of the inode that is dropped later?...

How much trust can we actually put in trace ordering off different cpus?
My theory would really have wanted just that drop before the acquire :D



Anyway, I think there's no room for doubt that it's possible to get a
new inode for the same underlying file before the evict finished; which
leaves room for a few questions:
 - as David brought up on IRC (#linuxfs@OFTC), what about the flushing
of dirty data that happens in evict()? wouldn't it be possible for
operations on the new inode to read stale data while the old inode is
being flushed? I think that warrants asking someone who understands this
better than me as it's probably not 9p specific even if 9p makes it
easier to get a new inode in such a racy way...

 - for 9p in particular, Christian Schoenebeck (helping with 9p in qemu)
brought up that we evict inodes too fast too often, so I think it'd help
to have some sort of inode lifetime management and keep inodes alive for
a bit.
As a network filesystem with no coherency built in the protocol I don't
think we can afford to keep inodes cached too long, and I know some
servers have troubles if we keep too many fids open, but it would be
nice to have a few knobs to just keep inodes around a bit longer... This
won't solve the fundamental problem but if the inode isn't evicted at a
point where it's likely to be used again then this particular problem
should be much harder to hit (like other filesystems, actually :P)

I'm not sure how that works though, and won't have much time to work on
it short term anyway, but it's an idea :/

-- 
Dominique
