Return-Path: <linux-fsdevel+bounces-3945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031927FA400
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88385B21212
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD531739;
	Mon, 27 Nov 2023 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT7E8HXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAC3064A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 15:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19197C433C7;
	Mon, 27 Nov 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701097440;
	bh=CmyN4POryy0GY6emqZ5AQMcKf9o559jkPTJdOQYWUnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aT7E8HXwTd2pt1F4QaoX2Nt+oAvmuMmBgbW51AqmaunsHt6sNujWCJNhafqjd+btW
	 BN3oNeRNazB64fbRDRHGAKZflrlx2lkU86opwjhzM6noizMEM2IDBT1dbq9JyVw/wt
	 ysP4lQN9rGMzO/c289QDjO1QB1CuP5XsYFidDmtBQJahewH8h5af5g44ivr9k4/GH+
	 A2JdvxCAObdUZejt2x4YtmvAHwfKXfgSjtkQQ+1eTvUxPfQb7VOHia1LkGm+vj+iov
	 dRz3510/It6f9XGYAH3G+kCLjQK+bSnJhB4s0FVAiXETJgKJf1fF0WbfArN8gzAWv5
	 pW42gq1nF2wGQ==
Date: Mon, 27 Nov 2023 16:03:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
Message-ID: <20231127-hantel-bausatz-5dc9403f203d@brauner>
References: <20231126020834.GC38156@ZenIV>
 <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
 <20231126050824.GE38156@ZenIV>
 <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>
 <20231126-luftkammer-sahen-f28150b1e783@brauner>
 <20231126105832.lqhuxmzdxey5ubvs@f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231126105832.lqhuxmzdxey5ubvs@f>

> to say if you insist on Al's variant then we are done here. :)

I think it's just simpler and having it in a central place is actually
nicer in this case.

I mostly try to avoid arguing about minutiae unless they do actually
have provable impact so if a patch comes that adheres to someones taste
more than my own then I'm not going to argue (quite often). All three
version are fine and functional.

