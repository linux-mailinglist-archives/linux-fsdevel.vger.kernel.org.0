Return-Path: <linux-fsdevel+bounces-719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F817CEFBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45D81C20D8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82251FBA;
	Thu, 19 Oct 2023 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B846699
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 06:00:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F42129;
	Wed, 18 Oct 2023 22:57:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1ACB567373; Thu, 19 Oct 2023 07:57:41 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:57:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231019055740.GA14794@lst.de>
References: <20231017184823.1383356-1-hch@lst.de> <20231017184823.1383356-4-hch@lst.de> <20231018-retten-luftkammer-2bae34ff707f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-retten-luftkammer-2bae34ff707f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

I turns out that we'd need bdev_mark_dead generally exported for this.
I don't quite like that, but I don't really see a way around it.
Maybe fix that up in your tree?

