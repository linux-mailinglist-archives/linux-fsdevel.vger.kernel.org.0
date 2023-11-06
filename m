Return-Path: <linux-fsdevel+bounces-2107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA897E2931
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D0AB20EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A628E24;
	Mon,  6 Nov 2023 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVeB/a8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4A18644
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E95C433C7;
	Mon,  6 Nov 2023 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699286253;
	bh=XakOiVEMQ571wvcS5zGAhlpsZauOUa29Y5gHDvsw+qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVeB/a8uodkCX0j62lt47x2YG8Bv4xgWfFh3B93YWDE3uZR/1+H5DvLu8B36rQoqM
	 eNGiPC/TAgJ1tevx7Ou2o9LuR9c6uRcm6gByg+upuaeD3XOqHyUaXKpHrij/buYQ9G
	 sirzNOITl2dbJUuqg5dFqbSgPbRAKgQxRzXxcGkNpNFfPAuaSl8NXeVhkbuquyl/+i
	 Yk9Fuatfq1iHVqmf10evgxHZ0+Fnk6MKb437dy8PKln7pcoOH/jh+HLETNkJ3QE1OD
	 T673p/8RTDKUS3FGNkDPIoQY+rZzadZlSJF3kb+DbVBq1kOrv/xvnSjnYohAl5WCpm
	 N2YMd6Q7b12+Q==
Date: Mon, 6 Nov 2023 16:57:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 3/7] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231106-mieten-wildnis-6cb767d234eb@brauner>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-3-jack@suse.cz>
 <20231106-einladen-macht-30a9ad957294@brauner>
 <20231106151826.wxjw6ullsx6mhmov@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106151826.wxjw6ullsx6mhmov@quack3>

> > Let's hope that this can become the default one day.
> 
> Yes, I'd hope as well but we need some tooling work (util-linux, e2fsprogs)
> before that can happen.

Yeah, absolutely. I'm moderately confident we'll have fairly quick
adoption of this though.

