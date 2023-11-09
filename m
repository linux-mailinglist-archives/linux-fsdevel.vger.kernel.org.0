Return-Path: <linux-fsdevel+bounces-2597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3257E6FB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42962811CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48121D525;
	Thu,  9 Nov 2023 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1B10790
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 16:51:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF3210E;
	Thu,  9 Nov 2023 08:51:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 566CF68AA6; Thu,  9 Nov 2023 17:50:58 +0100 (CET)
Date: Thu, 9 Nov 2023 17:50:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, catherine.hoang@oracle.com,
	cheng.lin130@zte.com.cn, dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	osandov@fb.com
Subject: Re: [GIT PULL] xfs: new code for 6.7
Message-ID: <20231109165057.GA8083@lst.de>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64> <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com> <20231108225200.GY1205143@frogsfrogsfrogs> <20231109045150.GB28458@lst.de> <20231109073945.GE1205143@frogsfrogsfrogs> <20231109144614.GA31340@lst.de> <20231109163856.GG1205143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109163856.GG1205143@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 09, 2023 at 08:38:56AM -0800, Darrick J. Wong wrote:
> Dave suggested that we might restore the pre-4.6 behavior by explicitly
> encoding what we used to do:
> 
> 	inode->i_atime.tv_sec = seq & 0xFFFFFFFF;
> 	inode->i_atime.tv_nsec = seq >> 32;
> 
> (There's a helper in 6.7 for this, apparently.)
> 
> But then I pointed out that the entire rtpick sequence counter thing
> merely provides a *starting point* for rtbitmap searches.  So it's not
> like garbled values result in metadata inconsistency.  IOWs, it's
> apparently benign.
> 
> IOWs, how much does anyone care about improving on Linus' fixup?

I'd really like to see the cast of a pointer to a struct type to a
scalar gone, because those tend to hide bugs.

I'm not going to bother you too much with it, promised.

