Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC5376DED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 02:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhEHAsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 20:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEHAsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 20:48:32 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CDC061761
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 May 2021 17:47:32 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6CE88C01E; Sat,  8 May 2021 02:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620434850; bh=HnjLIramDXgnK51KmV8EqpAtXbk8rOEM4anA/029GCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAQNurAW8d6cufW+qRdOf/5sdfWLDp16nV9y7s8gFesjuXlX5QnWkomLxpzhPyerJ
         v/AsgwryLp6gzjmt6axdTpTlEUdWpYEcllsjKrgw4Udtbk6isSFvsO+atdzMrjejmA
         8yzhrllDiIQwZ7DeutWudQJv9plzxVARiS96RaFu39Uf0Rucu0SL9thw8plZ2Rg3rP
         0+7K4uL4UehUHoOxymZix7V+wODMN5Pl3lktWUfGuBT5uR/KTFwOfHio+qd2yBzDOI
         h4ixC2togfdMyKv61C/E1nME2eQwiDT/XgtJvXfqh6Q9G4Sfkn+EA33EsJjDCWX2So
         YKjzG8aGN1chA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 82401C009;
        Sat,  8 May 2021 02:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620434849; bh=HnjLIramDXgnK51KmV8EqpAtXbk8rOEM4anA/029GCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAA8JFqCi17AXVbXoUjb09Kyi7dFEuVGzAVEszRubxIlye3va1y+25Pt6NQ7aQ8AV
         zt7txKZhCrlDBkpCd5tXnm8VMEKO/VlYw9zp52mWjICVuN9gra6hZ/DSXOwDn1X80k
         sgl4i99FPx0vCz54R41wF1AHCCkrNSGz4koPK0SsysLKqrZNmn2URgm7lhrE8HWNnI
         A26asYFH4K2jrHaZwA+vm9jFldF+72wwQNe7TRRsgBodPaEtb4vHCm5NMPI1dRdVMH
         z1n0nWIgWNDM8gJKpinBmGOnbClEkPI5cXljdyIcNGoaSe2//aO+piEK8MH2QHBlFe
         HB/NpegftW/RA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1e78d7ac;
        Sat, 8 May 2021 00:47:23 +0000 (UTC)
Date:   Sat, 8 May 2021 09:47:08 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
Message-ID: <YJXfjDfw9KM50f4y@codewreck.org>
References: <87czu45gcs.fsf@suse.de>
 <YJPIyLZ9ofnPy3F6@codewreck.org>
 <87zgx83vj9.fsf@suse.de>
 <87r1ii4i2a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1ii4i2a.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques wrote on Fri, May 07, 2021 at 05:36:29PM +0100:
> Ok, I spent some more time on this issue today.  I've hacked a bit of code
> to keep track of new inodes' qids and I'm convinced there are no
> duplicates when this issue happens.

Ok, that's good.
Just to make sure what did you look at aside of the qid to make sure
it's unique? i_ino comes straight from qid->path too so we don't have
any great key available which is why I hadn't suggesting building a
debug table.
(... well, actually that means we'll never try to allocate two inodes
with the same inode number because of how v9fs_qid_iget_dotl() works, so
if there is a collision in qid paths we wouldn't see it through cookies
collision in the first place. I'm not sure that's good? But at least
that clears up that theory, sorry for the bad suggestion)

> OTOH, I've done another quick test: in v9fs_cache_inode_get_cookie(), I do
> an fscache_acquire_cookie() retry when it fails (due to the dup error),
> and this retry *does* succeed.  Which means, I guess, there's a race going
> on.  I didn't managed to look too deep yet, but my current theory is that
> the inode is being evicted while an open is triggered.  A new inode is
> allocated but the old inode fscache cookie hasn't yet been relinquished.
> Does this make any sense?

hm, if the retry goes through I guess that'd make sense; if they both
were used in parallel the second call should fail all the same so that's
definitely a likely explanation.

It wouldn't hurt to check with v9fs_evict_inode if that's correct...
There definitely is a window where inode is no longer findable (thus
leading to allocation of a new one) and the call to the
fscache_relinquish_cookie() at eviction, but looking at e.g. afs they
are doing exactly the same as 9p here (iget5_locked, if that gets a new
inode then call fscache_acquire_cookie // fscache_relinquish_cookie in
evict op) so I'm not sure what we're missing.


David, do you have an idea?

> If this theory is correct, I'm not sure what's the best way to close this
> race because the v9inode->fscache_lock can't really be used.  But I still
> need to proof this is really what's happening.

Yes, I think we're going to need proof before thinking of a solution, I
can't think of anything simple either.


Thanks again for looking into it,
-- 
Dominique
