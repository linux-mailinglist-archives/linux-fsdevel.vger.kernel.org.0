Return-Path: <linux-fsdevel+bounces-1627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE577DCB2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A89B20F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6280134BA;
	Tue, 31 Oct 2023 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuZzEIEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED32105
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 10:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12426C433C8;
	Tue, 31 Oct 2023 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698749611;
	bh=gxTIuIEVQCXZGKQMzAchM7xFhsen1RbIdvVz+ZT7aqE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=VuZzEIEhzzRIQELD9FQG9asmlBB3IDjFnbxcEdOt1il6gn/MqAVoYX9eg8VREj2BA
	 KmSeMiJI5yTRpBhlApBJjWgDUkwBOStolXhyV/WopXKJmLr7xF939ZkQpW9Mm1aFoh
	 FRsQWPbSVlONWs/DOtF3uKl2vW1IBvw3lnaRpYtivl4jA3+qJZnLPsVwVh1NtAH9iy
	 zv3sJRhcNQyORUur6PM3Vidiw/auZXxdRcQTEMnjtL3qcZoe+eh/NaMa2ZlsB6epVB
	 vVUDFdQaHfGuS8sh0KdOKbr5OCYcX2m53llfTgTxzyA9trxBecQ8fC5WeloB5miWMc
	 wyygOGDgOQ5IQ==
References: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231031090242.GA25889@lst.de>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: catherine.hoang@oracle.com, cheng.lin130@zte.com.cn,
 dan.j.williams@intel.com, dchinner@redhat.com, djwong@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, osandov@fb.com,
 ruansy.fnst@fujitsu.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Date: Tue, 31 Oct 2023 16:17:35 +0530
In-reply-to: <20231031090242.GA25889@lst.de>
Message-ID: <87a5rzjc5z.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 31, 2023 at 10:02:42 AM +0100, Christoph Hellwig wrote:
> Can you also pick up:
>
> "xfs: only remap the written blocks in xfs_reflink_end_cow_extent"
>
> ?

Sorry, I missed the above patch. I will add it as part of fixes for 6.7-rc1.

>
> Also this seems to a bit of a mix of fixes for 6.7 and big stuff that
> is too late for the merge window.

I ended up doing two rounds of testing since I had to execute the tests the
second time after dropping the "xfs: up(ic_sema) if flushing data device
fails" patch. I hope to send the pull request by end of Wednesday.

-- 
Chandan

