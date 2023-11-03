Return-Path: <linux-fsdevel+bounces-1905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED937DFFA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 09:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809C81C20A61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991079F7;
	Fri,  3 Nov 2023 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732C79E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:11:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD8123;
	Fri,  3 Nov 2023 01:11:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DFE767373; Fri,  3 Nov 2023 09:11:47 +0100 (CET)
Date: Fri, 3 Nov 2023 09:11:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Li Dongyang <dongyangli@ddn.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	adilger.kernel@dilger.ca
Subject: Re: [PATCH] mm: folio_wait_stable() should check for bdev
Message-ID: <20231103081146.GA16854@lst.de>
References: <20231103050949.480892-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103050949.480892-1-dongyangli@ddn.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 03, 2023 at 04:09:49PM +1100, Li Dongyang wrote:
> folio_wait_stable() now checks SB_I_STABLE_WRITES
> flag on the superblock instead of backing_dev_info,
> this could trigger a false block integrity error when
> doing buffered write directly to the block device,
> as folio_wait_stable() is a noop for bdev and the
> content could be modified during writeback.
> 
> Check if the folio's superblock is bdev and wait for
> writeback if the backing device requires stables_writes.

https://lore.kernel.org/lkml/CAOi1vP9Zit-A9rRk9jy+d1itaBzUSBzFBuhXE+EDfBtF-Mf0og@mail.gmail.com/T/#t

https://lore.kernel.org/all/20231024064416.897956-1-hch@lst.de/


