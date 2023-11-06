Return-Path: <linux-fsdevel+bounces-2099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E957E26D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1B42814AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5028DA6;
	Mon,  6 Nov 2023 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byjhbkQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CD28DA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04BC433C7;
	Mon,  6 Nov 2023 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699281153;
	bh=lXClTxVR0gTtEQpR7wLQM5KHmuWQx4g7X7NcmIWBY/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byjhbkQu++jMpPLIxKaIzPNy8fjHoSObAkNkNopA9bNoxvUpsDy0VnjNtzrXVQq/2
	 sOXP+3zVCONsXGKOxhQDwv+fXmcxbGvTIwDdq9DEgfkOMs2FzAdgxbapQwEU2ZlOJB
	 wue8J0DtyXnGFZB7a71YyuSO5IDL7xq2zkdol1htwfFerAmeRNQqB8qrfvG7dnOEHI
	 3A7Ak12d/LvBYkCZ0i8i4tEoVnLBGshKvopppyIgEpT0TSCp0EUgJcyGvWkg98L8IQ
	 G2elcJ5XC5y1Sv5XghTNP5j018wGDJ/pcoLi2v9pRhVOAmCK7EJMyLBiNDW2t/d5sp
	 xHRMCfuCDOp9w==
Date: Mon, 6 Nov 2023 15:32:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 5/7] fs: Block writes to mounted block devices
Message-ID: <20231106-erleben-seeadler-bec35961548f@brauner>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-5-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101174325.10596-5-jack@suse.cz>

On Wed, Nov 01, 2023 at 06:43:10PM +0100, Jan Kara wrote:
> Ask block layer to block writes to block devices mounted by filesystems.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

