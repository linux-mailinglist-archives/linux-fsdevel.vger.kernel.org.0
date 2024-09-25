Return-Path: <linux-fsdevel+bounces-30068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D034B985A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938F52826D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AFB1B3740;
	Wed, 25 Sep 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMqSyEKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152718C336;
	Wed, 25 Sep 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264506; cv=none; b=EfoMEXynAvXKNlc6XDpKb9PXrH3lI10Nx+cgWF3lcO3Ch3UjEfwl3YRT8Y1tX/gH7IRjUUY3SRlUrxDxggujWUsYxqiXuQP+rO5qOWsieeIFvi9huDWOxyCVOgz3/Rh5vUVy2w79h9Cia0Irjc942Lc+Newdx8SuFV0ikiAv6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264506; c=relaxed/simple;
	bh=AWU8ag6TsRORY9WiQaZ4/YUhKGR80CvIOUpQt2DeNjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+htitufC4vCSmtaW33W/BBg7Bqc1aclnyRsWwq6SnfDBuB/8pY0miJdI9k5V5PxlaCIH9mpNRHjmxkV5uLGMLC43uvhveVGHEppDuotRlBA+IjPRGO/FqNCvNqaMA2vMAIpEs19THlMlSQCVcoHvjD4ZRz9d3ibvQhY2YoOHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMqSyEKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991EAC4CEC3;
	Wed, 25 Sep 2024 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264506;
	bh=AWU8ag6TsRORY9WiQaZ4/YUhKGR80CvIOUpQt2DeNjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMqSyEKQdTHXTpv62L73HXYSvQNqQCCC6WXcWoiFvSvBOcWofXPkE9mTyNkwsAJ5G
	 Fn37LYLx4ZI4BMShvsoHvKhcs6Ax4UC+lgnx8mkmswE5Z5sshjh/p2mg3e5gnOe//C
	 s2ku5F3EY/t4X+ulBkBMZrum31RizsxHElTTDZYG/H2Rr3lFvdO4Snr5dDhduUOvex
	 xAYkBNveXeBhHlQSwfqm538TkkFlnBnCbh+tTICpcr4Un0ut0S0Ym9FFTAA1G6+lbL
	 L5rr0LUAGRIKL1o/yE7Jwg8+bipIuVHfVuVXI+WNAYmg30OHTMU7uv3lWAESkKLfmT
	 Dba3TmvQzXN/A==
Date: Wed, 25 Sep 2024 13:41:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <20240925-aufdrehen-zuzug-43c74793e4bf@brauner>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
 <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>

On Tue, Sep 24, 2024 at 06:45:55PM GMT, Linus Torvalds wrote:
> On Tue, 24 Sept 2024 at 17:17, Dave Chinner <david@fromorbit.com> wrote:
> >
> > FWIW, I think all this "how do we cache inodes better" discussion is
> > somehwat glossing over a more important question we need to think
> > about first: do we even need a fully fledged inode cache anymore?
> 
> I'd be more than happy to try. I have to admit that it's largely my
> mental picture (ie "inode caches don't really matter"), and why I was
> surprised that the inode locks even show up on benchmarks.
> 
> If we just always drop inodes when the refcount goes to zero and never
> have any cached inodes outside of other references, I think most of
> the reasons for the superblock inode list just disappear. Most of the
> heavy lifting has long since been moved to the dentry shrinking.
> 
> I'd worry that we have a lot of tuning that depends on the whole inode
> LRU thing (that iirc takes the mapping size etc into account).
> 
> But maybe it would be worth trying to make I_DONTCACHE the default,
> with the aim of removing the independent inode lifetimes entirely...

I would be rather surprised if we didn't see regressions for some
workloads but who knows. If we wanted to test this then one easy way
would be to add a FS_INODE_NOCACHE fs_flag and have inode_init_always()
raise I_DONTCACHE based on that. That way we can experiment with this on
a per-fs basis.

