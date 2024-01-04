Return-Path: <linux-fsdevel+bounces-7345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D5823C10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 07:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E25A1F26267
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555031A594;
	Thu,  4 Jan 2024 06:08:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F718C31;
	Thu,  4 Jan 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5DCE68AFE; Thu,  4 Jan 2024 07:08:22 +0100 (CET)
Date: Thu, 4 Jan 2024 07:08:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Message-ID: <20240104060822.GA29011@lst.de>
References: <20231219000815.2739120-1-bvanassche@acm.org> <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de> <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org> <20240103090204.GA1851@lst.de> <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 03, 2024 at 03:09:00PM -0800, Bart Van Assche wrote:
> Since struct address_space does not have a member with the name "inode",
> I assume that you meant "host" instead of "inode"?

Yes, sorry.

> If so, how about
> modifying patch 06 of this series as shown below? With the patch below
> my tests still pass.

This looks good, thanks.

