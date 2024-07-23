Return-Path: <linux-fsdevel+bounces-24113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98A939CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3FE1F22957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422D14D447;
	Tue, 23 Jul 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlpWyiuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6714D282;
	Tue, 23 Jul 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724270; cv=none; b=uUSn9Fm1s3DM1LkRI/JpzN70tcPZYyB4N2kYeSSIPpoX6et1gouPQ0utsNnnTZOiWNBr6pzCk6mHyN/3ypCQcOTZQfDdkwNIDQ+TO6gX63gJ44bRHKWnfOIRxguYAEjig0YzNXgD15YP2xbOPEfW4Ascm4mpAwIHJvZDsnykxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724270; c=relaxed/simple;
	bh=2ZjbRPeeXbrIm0xAnumdD1ly1zV8UN2KljaltnZiPCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTDVYC7fiSPSapltbQD51gDgkYYrGHTppG19JcddphdZd66fgOJdMfbtNnBgDD1bjIWwGYib9+GLhYgyYdcP8yfk37xfP9+wghQmeWdG8M7AOmBhwxmpvoH+4cLcnStiKIJ/iKsc0X4r0XkdEAoyrhcOYytqHjmc/zL+o8UERDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlpWyiuY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721724265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK2EcdiJh2UsKYq9ETH81uD0C/sipi+a4DjtdiFTXK4=;
	b=LlpWyiuY+PZBgxwLd/IpEVDwLE222BpKHgr1RpB7VbGs6XxatJY6uaj7S1+p1f3sA/rhGF
	LBIt7voECdMcUrmmkXTUog+VjPBiXMj9DKY1ALk9NO54Y7OmFs1PVT72nKDJToeJaRnU9n
	woVBW/ixI37h287XNnk+URuOhlDOLe8=
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
Message-ID: <b58e6f36-9a13-488a-85d2-913dd758f89b@linux.dev>
Date: Tue, 23 Jul 2024 16:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
References: <20240711074859.366088-1-youling.tang@linux.dev>
 <Zo-XMrK6luarjfqZ@infradead.org>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <Zo-XMrK6luarjfqZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Christoph

On 11/07/2024 16:26, Christoph Hellwig wrote:
> Can we please stop this boilerplate code an instead our __init/__exit
> sections to supper multiple entires per module.  This should be mostly
> trivial, except that we'd probably want a single macro that has the
> init and exit calls so that the order in the section is the same and
> the unroll on failure can walk back form the given offset. e.g.
> something like:
>
> module_subinit(foo_bar_init, foo_bar_exit);
> module_subinit(foo_bar2_init, foo_bar2_exit);
>
>
Thanks for your suggestion,  I re-implemented it using section mode,
and the new patch set [1] has been sent.

[1]: 
https://lore.kernel.org/all/20240723083239.41533-1-youling.tang@linux.dev/T/#md81aaefe0c1fef70a0592d1580cbbb10ec9989b0

Thanks,
Youling.

