Return-Path: <linux-fsdevel+bounces-5174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA43B809057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 19:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548911F2115E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C774EB56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C610FC;
	Thu,  7 Dec 2023 09:42:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DDE0227A87; Thu,  7 Dec 2023 18:42:42 +0100 (CET)
Date: Thu, 7 Dec 2023 18:42:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v5 01/17] fs: Fix rw_hint validation
Message-ID: <20231207174242.GA31184@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013322.175290-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 29, 2023 at 05:33:06PM -0800, Bart Van Assche wrote:
> Reject values that are valid rw_hints after truncation but not before
> truncation by passing an untruncated value to rw_hint_valid().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, having one helper for F_GET_RW_HINT and F_SET_RW_HINT looks
pretty odd to me, it seems like the code would be cleaner if that
was split into two helpers instead.

