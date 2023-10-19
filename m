Return-Path: <linux-fsdevel+bounces-721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA027CF123
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 09:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3781B210AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE4D299;
	Thu, 19 Oct 2023 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOqfiKqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178DD26A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 07:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B777DC433C7;
	Thu, 19 Oct 2023 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697700271;
	bh=Y7/RgxS6eDdTnl62hNbYaqOLvqoDI7GSPffvTf1rHUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOqfiKqRDXLKsMwN91ow53EQAdi3d7B53CV2s6fTSdn+3Xm4TJvE/x0gZQgPZ40+E
	 fY1lqszBxhJb6d7So8EMrJAhO83fa3mAcpM+zZiiN4fmxmeRdIpFkim/GOqMhiaWyN
	 Vnv6yNK9tsBioVdw1qI/Kbc+dwIiXVsdtxDUAXdaZaHsW1NdcRZN/E2c5mrthJ0Uaj
	 Cu1Gm+bKEkdD1wsrEmRvBGeVN571Rqvjcjlhg4YnrIVREgxKdAtU/uaPTSxKhMIGvQ
	 sdzsat6VMLB+tm+DN1SAa5daRGTrd3iCU/HVM5q1PUg4asueizxXP3zHxCS/9VmQgC
	 SLoDs3hBdQo0Q==
Date: Thu, 19 Oct 2023 09:24:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231019-albern-vormerken-6a1c3548a02a@brauner>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
 <20231018-retten-luftkammer-2bae34ff707f@brauner>
 <20231019055740.GA14794@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019055740.GA14794@lst.de>

On Thu, Oct 19, 2023 at 07:57:40AM +0200, Christoph Hellwig wrote:
> I turns out that we'd need bdev_mark_dead generally exported for this.
> I don't quite like that, but I don't really see a way around it.
> Maybe fix that up in your tree?

Done.

