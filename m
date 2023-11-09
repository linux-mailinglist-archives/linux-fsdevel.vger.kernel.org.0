Return-Path: <linux-fsdevel+bounces-2467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6417E62FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 05:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F6B2810EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA56AA6;
	Thu,  9 Nov 2023 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4D63B2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 04:51:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DA170F;
	Wed,  8 Nov 2023 20:51:53 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42F3767373; Thu,  9 Nov 2023 05:51:50 +0100 (CET)
Date: Thu, 9 Nov 2023 05:51:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, catherine.hoang@oracle.com,
	cheng.lin130@zte.com.cn, dchinner@redhat.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	osandov@fb.com
Subject: Re: [GIT PULL] xfs: new code for 6.7
Message-ID: <20231109045150.GB28458@lst.de>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64> <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com> <20231108225200.GY1205143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108225200.GY1205143@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 08, 2023 at 02:52:00PM -0800, Darrick J. Wong wrote:
> > Also, xfs people may obviously have other preferences for how to deal
> > with the whole "now using tv_sec in the VFS inode as a 64-bit sequence
> > number" thing, and maybe you prefer to then update my fix to this all.
> > But that horrid casts certainly wasn't the right way to do it.
> 
> Yeah, I can work on that for the rt modernization patchset.

As someone who has just written some new code stealing this trick I
actually have a todo list item to make this less horrible as the cast
upset my stomache.  But shame on me for not actually noticing that it
is buggy as well (which honestly should be the standard assumption for
casts like this).

