Return-Path: <linux-fsdevel+bounces-58408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C54B2E722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5D674E4EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD822D8DCE;
	Wed, 20 Aug 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muvPG7aV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C1E7C05;
	Wed, 20 Aug 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723841; cv=none; b=nLKeD6jRqEQshjP3A5Pj/MZ7MOOQpAtOJORVCbDXl5bVYjz0TX67b2TQC8Zto+DspL5iLxfsU67OBFaNKdXjXDiRTALhvxxTf+SKb+YkGdBztg6SUjvfCDqY1vlrCsXeQm8pYojo8W2op8TzkiON69NhsyDTYEKb+8LLjSg/38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723841; c=relaxed/simple;
	bh=RPKPmzf+C+b50/0CKUd/keQZ/bZJA+dnbto9tcMq0NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGmqkUx+ntiApbXnHQTnTOxUplEt3sTYNRVkrnODns3xJUoeI/c1vNTXJDe9jRmkp4kvHcvjJKL+Vh5LQLQzQAtNchGQ0RJAznUKsDOAj4fq/J9rOl4nb6hB1em+wXogH3hBj0eIyxxZXfbL3kDAR5zP2T9hGppy95izjbq2WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muvPG7aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DAAC4CEE7;
	Wed, 20 Aug 2025 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723841;
	bh=RPKPmzf+C+b50/0CKUd/keQZ/bZJA+dnbto9tcMq0NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muvPG7aV4Fn8WnL362DUP1IHygT3kO0fwEJ/FP3sHKR1jEARFMAYxxY+yK9CNsRsJ
	 u8dTLY4Elf8R0pEbgXd5NbstaUwn+lMEiH//qqHFxDaTt9puz05XNCx7CNfkCPIjIj
	 T3inlJ5sGrMVvRL/6X+bBDQ2g8tGVQQhQiS/2k956v6BLi90Nv+iZhezHZW26j7u+8
	 NNg/yFPYGolkarrU/JetCoY2TRixw/6DZcwiKUcp836HAYLv3VCMY5WHheYKliLZd6
	 cvKGv5gXBsodFpZeY4cFA2UDBYM5GTlV3U2qyBsR2L3HP3vhUNZI92aemFCMfQNx3C
	 OmpOWDWnzZiog==
Date: Wed, 20 Aug 2025 23:02:33 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, David Disseldorp <ddiss@suse.de>
Cc: kernel test robot <lkp@intel.com>, linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v3 8/8] initramfs_test: add filename padding test case
Message-ID: <aKY36YpNQTnd1d7Y@levanger>
References: <20250819032607.28727-9-ddiss@suse.de>
 <202508200304.wF1u78il-lkp@intel.com>
 <20250820111334.51e91938.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820111334.51e91938.ddiss@suse.de>

On Wed, Aug 20, 2025 at 11:13:34AM +1000, David Disseldorp wrote:
> On Wed, 20 Aug 2025 04:16:48 +0800, kernel test robot wrote:
> 
> > sparse warnings: (new ones prefixed by >>)
> > >> init/initramfs_test.c:415:18: sparse: sparse: Initializer entry defined twice  
> >    init/initramfs_test.c:425:18: sparse:   also defined here
> ...
> >    407		struct initramfs_test_cpio c[] = { {
> >    408			.magic = "070701",
> >    409			.ino = 1,
> >    410			.mode = S_IFREG | 0777,
> >    411			.uid = 0,
> >    412			.gid = 0,
> >    413			.nlink = 1,
> >    414			.mtime = 1,
> >  > 415			.filesize = 0,  
> ...
> >    425			.filesize = sizeof(fdata),
> >    426		} };
> 
> Thanks. I can send a v4 patchset to address this, or otherwise happy to
> have line 415 removed by a maintainer when merged.

With that change:

Acked-by: Nicolas Schier <nsc@kernel.org>

Thanks and kind regards
Nicolas

