Return-Path: <linux-fsdevel+bounces-17732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299328B1EE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B06CB2937A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC786ADE;
	Thu, 25 Apr 2024 10:13:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4B8624E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040035; cv=none; b=isOZg8F+3AlAEcs/mKkSRHs1wvecLHlI+NN/UQaAjyLdbBUBdk9aaJ+sCFQBFkvfMUNe93cEYQ9Mi9nWViRz285RdxAEzcASCRnGEUK5Kn8mr11caLGBgquisKRqh9jtld5Ejs2uZFKrXFLz2S96HTOvltdyyx6qn5+0wBuUZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040035; c=relaxed/simple;
	bh=3E0SGUBEhtbR62VVY5qZfpwVUGi2m9FxGCTS5DtHoxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xdq0+fvPpDPeRLPcCI+o49G9h4vbBMlwMd8NhxDYVp5ZGX1A18UiJow2p8/cZUdHig1Tau2UCmXhmuR3/6Yhkwr9S4UdetEe8v25GJXybgdE5MaQlWcJi4WTUbgo5UOCfRlpmf2np1owyBMktMpi3958SrnPyHTWefbKu0HWw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4VQBXF0Whmz9v6Z;
	Thu, 25 Apr 2024 12:13:49 +0200 (CEST)
Message-ID: <97a3a5ea-62c3-4770-a40a-5ebb1d4e86aa@osuchow.ski>
Date: Thu, 25 Apr 2024 12:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs: Create anon_inode_getfile_fmode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <20240424233859.7640-1-linux@osuchow.ski>
 <20240425-wohltat-galant-16b3360118d0@brauner>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20240425-wohltat-galant-16b3360118d0@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 11:57, Christian Brauner wrote:
> On Thu, Apr 25, 2024 at 01:38:59AM +0200, Dawid Osuchowski wrote:
>> Creates an anon_inode_getfile_fmode() function that works similarly to
>> anon_inode_getfile() with the addition of being able to set the fmode
>> member.
> 
> And for what use-case exactly?

There was a TODO in the vfio driver [1] to create an interface here that 
would also allow to set fmode, hence this change.

-- Dawid

[1] https://lore.kernel.org/kvm/20240424234147.7840-1-linux@osuchow.ski/T/#u


