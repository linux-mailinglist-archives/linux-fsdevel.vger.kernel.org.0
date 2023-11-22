Return-Path: <linux-fsdevel+bounces-3402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B37F4393
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07154280600
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4551036;
	Wed, 22 Nov 2023 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjkFnijP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4051012
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 10:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20672C433C9;
	Wed, 22 Nov 2023 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700648412;
	bh=+rF9Vifsr7jAReYkrDoqYQD7qInzjq/w6Dm9ScKsxqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjkFnijPY4yuc3S89P65mtgC0aOodU1a0RWLuJgeQiVoz/dZbp63cwupd2Rks6g7Z
	 ipGGIz72tExgIm2jXjXldacXW4xdJ4yEBo/sMlECsst+5oywd2sfpZEyYkodq4Rek+
	 qevfKKZ9YZyNivp5cf24W4JgKqB3fYfAVh2d5yuAqOOKXy3HvsBb66n0tcNxgABQKG
	 Pyf+UgCr9LXxEEwqxGbkBPklocD8uU4dKpgLIb+xKlEGWodEcn8Hpge1rPbKHIOMx6
	 1gJ1nnBuWdNJSiBwmPUVOrjIpM4AFW9DA3YganrwYnY1wrXNMvtxQeNigVgBP/mCBb
	 fbMxdGfHl+thA==
Date: Wed, 22 Nov 2023 11:20:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow calling kiocb_end_write() unmatched with
 kiocb_start_write()
Message-ID: <20231122-planung-gerne-0f9a1e3d09be@brauner>
References: <20231121132551.2337431-1-amir73il@gmail.com>
 <20231121210032.GA1675377@perftesting>
 <ZV0hWVWeI6QOVfYM@dread.disaster.area>
 <ZV2kteeZ972k1p1W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV2kteeZ972k1p1W@infradead.org>

On Tue, Nov 21, 2023 at 10:50:29PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 08:30:01AM +1100, Dave Chinner wrote:
> > I like this a lot better than an internal flag that allows
> > unbalanced start/end calls to proliferate.  I find it much easier to
> > read the code, determine the correct cleanup is being done and
> > maintain the code in future when calls need to be properly
> > paired....
> 
> Agreed.

Agreed.

