Return-Path: <linux-fsdevel+bounces-47827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10556AA5F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88761B68410
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6B1D5CDE;
	Thu,  1 May 2025 13:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563643169;
	Thu,  1 May 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107056; cv=none; b=hrm/cHpp3X94/ILusWyTX4GBXspCF2MhpP2WOPaT70pHg/Ngpd9QrojuNSGxFm6CIPAyTdxe6Er+GV1McuMfYSopv5o0xkh9++EGupXxzJaQrcN6exlaOTvNV6r3/RHR6hxPdbdC89I4dPfkMZDtNJP/Isqq7rQIZuevYyB3qVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107056; c=relaxed/simple;
	bh=uYiz63L+VnDwNbZ16crXbGirkbwEswdlinEmUh3j+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDPu/LesFs6rIZGRj9dB7qLu5/PA+Hjo2DGzTZpEI4iotX7sufNBN+ZoXCZkrU4/Gt6Ksg+jll68xhEdd7Ez9ADzkwujWr2eWH3AnbqOUCRSZdzkhQym3OweaS0sN+QZLLqW9BAWKZEt441mv9J5SVOoDmxGf8/6JYSYmOeWSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFF7168CFE; Thu,  1 May 2025 15:44:02 +0200 (CEST)
Date: Thu, 1 May 2025 15:44:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	catherine.hoang@oracle.com, linux-api@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org
Subject: Re: [PATCH v9 00/15] large atomic writes for xfs
Message-ID: <20250501134402.GA11168@lst.de>
References: <20250425164504.3263637-1-john.g.garry@oracle.com> <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 30, 2025 at 03:14:04PM +0100, John Garry wrote:
> Hi Christoph,
>
> At this point, is your only issue now with
> 05/15 xfs: ignore HW which cannot atomic write a single block
> ?
>
> I am not sure on 15/15...

I don't like it, but it's a mount option and nothing persistent so
I should probably just shut up.


