Return-Path: <linux-fsdevel+bounces-3022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516C7EF596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E4728123D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA5374D3;
	Fri, 17 Nov 2023 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcab/2Zu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EBDF46
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D22C433C8;
	Fri, 17 Nov 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700236085;
	bh=iDn1ilq24Nw2UhEOzSj9ioh4lMDDBSXuQ5k5enzYlkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hcab/2ZunhI2WwBM2Zp2m/C9Y9W9EPWXnlBJkweDTV6uEjnq90odDd8crcUCoike7
	 epQzNqJTvHbRE52Gb4pZJd5nrv93QFkCA7eBWRb5ZWY56LNp8GKDFJHZkg+Hfp152E
	 DPV3F7/gEZ/DL4jqXJifiMb1OiPQ6aJ+J07881ZU=
Date: Fri, 17 Nov 2023 07:48:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Message-Id: <20231117074804.d475cadb2c5adbcbdb28f679@linux-foundation.org>
In-Reply-To: <b28b25ab-87eb-4905-855a-7809dda11f39@samsung.com>
References: <000000000000b1fda20609ede0d1@google.com>
	<tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
	<CGME20231117131718eucas1p13328b32942cce99a99197eb28e14a981@eucas1p1.samsung.com>
	<b28b25ab-87eb-4905-855a-7809dda11f39@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 14:17:17 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
> > Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> This patch, merged to linux-next as commit 1ff947abe24a ("squashfs: fix 
> oob in squashfs_readahead"), breaks mounting squashfs volumes on all my 
> test systems. Let me know if you need more information to debug this issue.

Thanks.  The patch has been dropped.

