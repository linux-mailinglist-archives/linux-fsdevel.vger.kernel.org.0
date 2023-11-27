Return-Path: <linux-fsdevel+bounces-3905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4867F9A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE59F1C20506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF7FC0A;
	Mon, 27 Nov 2023 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB62270C;
	Sun, 26 Nov 2023 23:08:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BA01227A87; Mon, 27 Nov 2023 08:08:31 +0100 (CET)
Date: Mon, 27 Nov 2023 08:08:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 01/15] fs: Rename the kernel-internal data lifetime
 constants
Message-ID: <20231127070830.GA27870@lst.de>
References: <20231114214132.1486867-1-bvanassche@acm.org> <20231114214132.1486867-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114214132.1486867-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 14, 2023 at 01:40:56PM -0800, Bart Van Assche wrote:
> -	case WRITE_LIFE_SHORT:
> +	case WRITE_LIFE_2:
>  		return CURSEG_HOT_DATA;
> -	case WRITE_LIFE_EXTREME:
> +	case WRITE_LIFE_5:
>  		return CURSEG_COLD_DATA;
>  	default:
>  		return CURSEG_WARM_DATA;

A WRITE_LIFE_2 constant is strictly more confusing than just using 2,
so this patch makes no sense whatsoever.

More importantly these constant have been around forever, so we'd better
have a really good argument for changing them.


