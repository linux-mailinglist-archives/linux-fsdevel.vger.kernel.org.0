Return-Path: <linux-fsdevel+bounces-1194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3AA7D70F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547AC1F22DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E42AB58;
	Wed, 25 Oct 2023 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1vvnudHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5D156E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01E184;
	Wed, 25 Oct 2023 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MksVKmxFF/LOSGBS+HFtPGWz3xXVQGzCyxDBQuuQye0=; b=1vvnudHqJnQC2ZRqLZXuUJQKXu
	MOM8Uvr1em0IyrUx+dBy1/lwTIa9MZGTdxRufefgB4E6yCGyW/HPHa+wchRz8+PxpFgQ4ZhZ4Bxkm
	sNxNMZV3GLC/UoVraFhcbpAfGALv92E6KKkLZzhR1njbh26PX8oPn9v2suBYfJCmy/ZmDK4m9j6j/
	WR4bpU3oa9Y5+g3ezoGqBA6VoLmzmuUKS7pybaevGfvuMOSrvPt2623BgDKuPaRnBnY9FjrXtFzc9
	S+stIgS0RMgRTh0JgIvthZypT0KUBtl91ibHKKRwDcony+uM48tXtHqN8w4l54We5+Wzf/SlKddKy
	NRsqpAtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvftl-00CdCL-1L;
	Wed, 25 Oct 2023 15:34:21 +0000
Date: Wed, 25 Oct 2023 08:34:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTk1ffCMDe9GrJjC@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135048.36153-1-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
> Jan,
> 
> This patch set implements your suggestion [1] for handling fanotify
> events for filesystems with non-uniform f_fsid.

File systems nust never report non-uniform fsids (or st_dev) for that
matter.  btrfs is simply broken here and needs to be fixed.

