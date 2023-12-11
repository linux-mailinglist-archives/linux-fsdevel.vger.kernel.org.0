Return-Path: <linux-fsdevel+bounces-5530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE280D2A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF95B1F21890
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2234CDEE;
	Mon, 11 Dec 2023 16:46:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC36E8E;
	Mon, 11 Dec 2023 08:45:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AD7968BFE; Mon, 11 Dec 2023 17:45:56 +0100 (CET)
Date: Mon, 11 Dec 2023 17:45:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 04/17] fs: Restore F_[GS]ET_FILE_RW_HINT support
Message-ID: <20231211164555.GB25306@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-5-bvanassche@acm.org> <20231207174617.GD31184@lst.de> <3c08f127-45ff-458c-9ae7-75a1870781d8@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c08f127-45ff-458c-9ae7-75a1870781d8@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 09:37:44AM -1000, Bart Van Assche wrote:
> I have submitted a pull request for fio such that my tests can be run
> even if F_SET_FILE_RW_HINT is not supported (see also
> https://github.com/axboe/fio/pull/1682).
>
> The only other application that I found that uses F_SET_FILE_RW_HINT is
> Ceph. Do we want to make the Ceph code work again that uses
> F_SET_FILE_RW_HINT? I think this code cannot be converted to
> F_SET_RW_HINT.

Well, let's pull a few folks in.  I'd personally prefer not carrying
this around in the file and supporting different write hints in the
same inode, which also makes things a mess for file systems.


