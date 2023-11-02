Return-Path: <linux-fsdevel+bounces-1782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437F7DEABE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 03:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8DB21193
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC96184F;
	Thu,  2 Nov 2023 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UtZGHQRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED787EBB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 02:36:28 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D82110
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 19:36:20 -0700 (PDT)
Date: Wed, 1 Nov 2023 22:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698892578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hk7EDHXwmKrezCFMkFGV4WjYpzJvbn/keLuYpStMdE=;
	b=UtZGHQRY+qB8l04fJ40M75jfaW8vulKmHtYnJCL8y6KLIcKQgYi/tw5KP07AXiy/xVbn+h
	KgdBhUBHkAhXeDB+opLuuCfnMO4bsEpMa+7Px7dhDJTOFwxPI3bDI513iTLsZsq5V7ORZ2
	af+5O2J9mxAF8ifmk4fLUWAQlQHN9Is=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Dave Chinner <david@fromorbit.com>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231102023615.jsv2ffe4rbivgsja@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
 <20231031-proviant-anrollen-d2245037ce97@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-proviant-anrollen-d2245037ce97@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 31, 2023 at 12:02:47PM +0100, Christian Brauner wrote:
> > The follow up including a statement about "being arsed" once more was
> > to Christian, not you and was rather "tongue in cheek".
> 
> Fyi, I can't be arsed to be talked to like that.
> 
> > Whether the patch is ready for reviews and whatnot is your call to
> > make as the author.
> 
> This is basically why that patch never staid in -next. Dave said this
> patch is meaningless without his other patchs and I had no reason to
> doubt that claim nor currently the cycles to benchmark and disprove it.

It was a big benefit to bcachefs performance, and I've had it in my tree
for quite some time. Was there any other holdup?

