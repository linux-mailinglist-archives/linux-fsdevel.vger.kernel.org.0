Return-Path: <linux-fsdevel+bounces-11519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312928543BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350531C21390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3A1427F;
	Wed, 14 Feb 2024 08:03:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE213FED;
	Wed, 14 Feb 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897791; cv=none; b=NWhn9Ec5mEBOJ7TE0hIuaUL/gHt8gNruahDxpO/kQ2/5/w/GlmVIZeOhAoYGPRm1lY5Wc06WThEdU5TqudIpGdRdIWYPwd9QoG8eVuzaxxQg5yRrQ9YJLhWu6vopGVSM9Jd3VF2g09GVyXXTi835tUIyYCoc1k2bPQQAUJAJJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897791; c=relaxed/simple;
	bh=zy+VjKixEEKQMAzfjKLxgTAy/Adc7iuq5scyI1skU2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ALVCDgH66qJ3NHENNI4ypaqMO3ErfRzWC2AVlopuMo/uO91GolcTusEf7IMxytlKPkxHv7tYS1FkZgrNI+ct45zX9GASFZelexI66yrsW/ESJUTCbhz3uKljhrAPmEpFnlLvESnsJ7kP7PLnJN7vRLbXv+lyWHHZ4E4zKC9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 629E5227AAC; Wed, 14 Feb 2024 09:03:05 +0100 (CET)
Date: Wed, 14 Feb 2024 09:03:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: shmem patches headsup: Re: [ANNOUNCE] xfs-linux: for-next updated
 to 9ee85f235efe
Message-ID: <20240214080305.GA10568@lst.de>
References: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 12:18:41PM +0530, Chandan Babu R wrote:
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.

<snip>

> Christoph Hellwig (17):
>       [f23e079e024c] mm: move mapping_set_update out of <linux/swap.h>
>       [604ee858a8c8] shmem: move shmem_mapping out of line
>       [8481cd645af6] shmem: set a_ops earlier in shmem_symlink
>       [9b4ec2cf0154] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
>       [36e3263c623a] shmem: export shmem_get_folio
>       [74f6fd19195a] shmem: export shmem_kernel_file_setup
>       [eb84b86441e3] shmem: document how to "persist" data when using shmem_*file_setup

I would have prefer an ACK or even a shared branch in the MM tree
for these.  But as it's been impossible to get any feedback from
the shmem and mm maintainer maybe this is the right thing to do.

Andrew, Hugh: can you commet if this is ok?

