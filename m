Return-Path: <linux-fsdevel+bounces-2047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6A7E1BE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 910D8B20E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF911722;
	Mon,  6 Nov 2023 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiAlDF8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43737FBF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D43C433C7;
	Mon,  6 Nov 2023 08:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699259111;
	bh=FDzAyqDW72wEFOlOk7vZD0z4dGsgWkl1Zu44szuH7CE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=IiAlDF8GPZXng62FoqJgcZu0Pqims1Mkw7mYCSESylFznFwQ8VrOzyY2mu3qpwZ3i
	 jxTpsdcfVGPeRK29DIK7suHfmpMyeoYrXoCU/zAdpU/Q+BiO+LxGiGou/pmUqAfm4i
	 B40HX6fJLp0uOLmYJqSsORqzk8uPYqTVBAE8rDZfcd/763k9RBWLHGRKPMp80iaSmW
	 E++fGfF5DWz7swOpPiCGxoWWX4lLnQCwI2diicJ3Gz0Y1/1eDDlMpUiONvKKv7c0DV
	 uomBT7EzY4vowQJTDf3YJxAFsgkJd8d/YsOE693MUmiqYxCpAbHEbCSye9XmafS5Ry
	 AaBYOosFO/uKw==
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, Jan
 Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Handle multi device freezing
Date: Mon, 06 Nov 2023 13:51:52 +0530
In-reply-to: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
Message-ID: <87y1fb70gr.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 04, 2023 at 03:00:11 PM +0100, Christian Brauner wrote:
> Hey everyone,
>
> Now that we can find the owning filesystem of any device if the
> superblock and fs_holder_ops are used we need to handle multi-device
> filesystem freezes. This series does that. Details in the main commit.

generic/311, xfs/006 and xfs/264 pass when executed against a kernel which has
the patches applied. Hence,

Tested-by: Chandan Babu R <chandanbabu@kernel.org>

>
> Thanks!
> Christian
>
> ---
> Christian Brauner (2):
>       fs: remove dead check
>       fs: handle freezing from multiple devices
>
>  fs/super.c         | 140 +++++++++++++++++++++++++++++++++++++++++------------
>  include/linux/fs.h |  17 ++++++-
>  2 files changed, 124 insertions(+), 33 deletions(-)
> ---
> base-commit: c6a4738de282fc95752e1f1c5573ab7b4020b55e
> change-id: 20231103-vfs-multi-device-freeze-506e2c010473


-- 
Chandan

