Return-Path: <linux-fsdevel+bounces-16117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D4898987
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9061F28322
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0D128833;
	Thu,  4 Apr 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="fG5DuGnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB677129E88
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239635; cv=none; b=hEyK2lcaLLDi7R6O+c9qRp7GaWm4iENpEnu8dTRdGO6xrP7E8ngYqCfQDTIg3TzaIMDOIBhCkSAvILmlXGfHVLBseytesffdxWG317A3HnGx5Y1qZTYqD4O/h1t4b2YzA2KgseJDLGPqlZA0Tr/LKIvz2rBGuyg+kactkp49n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239635; c=relaxed/simple;
	bh=E+j9cz4kxBl1NQUZzQyZHjbBiKZgtg0pRVyiZQ0eJZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWqJXh5JTll4ia6v0YC2168KKj8a9OireJ3gODViaE/jJEA+4xuhtgIGG31DKnDKGxIBlWAsCKFMUEHxOyUZjNlQEx+4xc8kMpJzPs++weood6d4L+zET3Ya333cmvT9gHAfXU+/QrxrrLX7FMyJFShZHK2EeN1QZhPaAsoQuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=fG5DuGnx; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 669BB82A0E;
	Thu,  4 Apr 2024 10:07:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712239627; bh=E+j9cz4kxBl1NQUZzQyZHjbBiKZgtg0pRVyiZQ0eJZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fG5DuGnxr+zxlJSErXfcbJKh2MCqvy9o/QGFKS+VMkX/FxhnfjIw3d6ibbMNv5dzx
	 uf12s/92do9DhzoLCMPIho0aNSTTWYobCUpWQn3Pj+nNALdr3QG6xtcVRYTDavKKea
	 A4q/oqBtDhWSsC3zW29qGmdiemy1yH04mYoqktsDa+Trir8x8U03a+AOOkEU2i6FsQ
	 7PaNyIpEq9taovfxMmJ7QAlaSI0106t5lKR3wBRhDSKQB6Qw3RyAuQeXzK5J8JuUf+
	 YW4UbFezh2wDNFnDtMxplUcz2HPn0kPCTYEMCBcPwhW3kQ4YzblO728eE2VFW9f3do
	 vtHKxeKebZVeg==
Message-ID: <e9aac186-7935-485e-b067-e80ff19743dc@dorminy.me>
Date: Thu, 4 Apr 2024 10:07:05 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in
 passthrough mode
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-10-amir73il@gmail.com>
 <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me>
 <a939b9b5-fb66-42ea-9855-6c7275f17452@fastmail.fm>
 <CAOQ4uxgVmG6QGVHEO1u-F3XC_1_sCkP=ekfEZtgeSpsrTkX21w@mail.gmail.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <CAOQ4uxgVmG6QGVHEO1u-F3XC_1_sCkP=ekfEZtgeSpsrTkX21w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Sweet Tea,
> 
> Can you please explain the workload where you find that this patch is needed?

I was researching before sending out my own version of attr passthrough 
- it seemed like a step in the direction, but then the code in-tree 
wasn't the same.

> Is your workload using mmap writes? requires a long attribute cache timeout?
> Does your workload involve mixing passthrough IO and direct/cached IO
> on the same inode at different times or by different open fd's?
> 
> I would like to know, so I can tell you if getattr() passthrough design is
> going to help your use case.
> 
> For example, my current getattr() passthrough design (in my head)
> will not allow opening the inode in cached IO mode from lookup time
> until evict/forget, unlike the current read/write passthrough, which is
> from first open to last close.

I think the things I'd been working on is very similar.

Two possible HSM variants, both focused on doing passthrough IO with 
minimal involvement from the fuse server in at least some cases.

One would be using passthrough for temporary ingestion of some memory 
state for a workload, user writes files and the FUSE server can choose 
to passthrough them to local storage temporarily or to send them to 
remote storage -- as ingestion requires pausing the workload and is 
therefore very expensive, I'd like to pass through attr updates to the 
backing file so that there are minimal roundtrips to the fuse server 
during write. Later the HSM would move the files to remote storage, or 
delete them.

One would be using passthrough for binaries -- providing specific sets 
of mostly binaries with some tracking on open/close, so the HSM can 
delete unused sets. Again the goal is to avoid metadata query roundtrips 
to userspace for speed; we don't expect a file open in passthrough mode 
to be opened again for FUSE-server-mediated IO until the passthrough 
version is closed.

Thanks!

Sweet Tea

