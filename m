Return-Path: <linux-fsdevel+bounces-31974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A196E99E9E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B4F1C22423
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF1227B81;
	Tue, 15 Oct 2024 12:33:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130171CEADB;
	Tue, 15 Oct 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995614; cv=none; b=LGFee/oBKR7l1/nl+UY/2b9X224xbXXf5kvzL2SvdEzfNJlLcEb37oSYgLhDMUCi1oVmrwCuegMQYdhs0tA4iy6xhfJtEEMQphQKUrXHPnI68yZF0WFRroRIUum0+WWwhNPfo1Dyzj6fGL5OOn7jlb/6jWdSn/XEPdCWPzSBd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995614; c=relaxed/simple;
	bh=r8NJhNW2NGHmD6eructmNftLrlxZrsEcUUeKsW1XvQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB93vSHPUGOzf8tUmzFYJH2B65Xp7N77m5/3JlUQnI02rsIbFq8jzI1+fZ/O3c+L9vY8oYJmaeQrSgXMUPayWP4JmO++hl6sQLfrZzR6tGehOnLcn+w+EqiZsNYR4i7WoY4E0JKr4fjB7HVYgTdlIBSNe+zdFfL/Fd1OYrVtPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 950FE227AAC; Tue, 15 Oct 2024 14:33:28 +0200 (CEST)
Date: Tue, 15 Oct 2024 14:33:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, brauner@kernel.org,
	djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dchinner@redhat.com, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v8 5/7] xfs: Support atomic write for statx
Message-ID: <20241015123328.GA687@lst.de>
References: <20241015090142.3189518-1-john.g.garry@oracle.com> <20241015090142.3189518-6-john.g.garry@oracle.com> <20241015121539.GB32583@lst.de> <9c05dfea-339e-44e7-9688-b5206726a1c5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c05dfea-339e-44e7-9688-b5206726a1c5@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 01:22:27PM +0100, John Garry wrote:
>> Nit: I'd do with the single use sbp local variable here.
>
> I think that you mean do without.

Yes, sorry.


