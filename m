Return-Path: <linux-fsdevel+bounces-45199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25868A748A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34892189BEAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48299212B04;
	Fri, 28 Mar 2025 10:48:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C36FBF;
	Fri, 28 Mar 2025 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158884; cv=none; b=LsaC9H+JDdagIOvHHFLu0LVzTBpdlj/IMWIKj+OzfoU6kKjLKxIxd68Bt5gAxmms7AlCvx6eqOIU6pkJj46LqP9wfvZHlBReKlJc4wliimoZGNBEkoAIfs+ca+5QCL0pj5J9D3rYBkU0EYKQEBelcM7tyZXcTnVaOS7BpP+n6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158884; c=relaxed/simple;
	bh=624HXbVtaXf7OEa53mYPunxElgZh35bwXenaW8Dt5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU8dE4WWGFHmp7MPLPhoiVxPyCcaLQ37Hpi/PV3Q+KpRt87OUJvd6MCGPiAzYESlgpHTnalJyrCWqQCozlKhvKEuFwoqIcYPyWIHjmvTQFPx3ZoQdh3faW6gU7Sb0kozhtoJErtoivr3d/CTvNQdBpT1tSAidzA8Ts5E1BihqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4214968AA6; Fri, 28 Mar 2025 11:47:51 +0100 (CET)
Date: Fri, 28 Mar 2025 11:47:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	djwong@kernel.org, dchinner@redhat.com,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix conflicting values of iomap flags
Message-ID: <20250328104750.GA19460@lst.de>
References: <20250327170119.61045-1-ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327170119.61045-1-ritesh.list@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 28, 2025 at 01:01:19AM +0800, Ritesh Harjani (IBM) wrote:
> IOMAP_F_ATOMIC_BIO mistakenly took the same value as of IOMAP_F_SIZE_CHANGED
> in patch '370a6de7651b ("iomap: rework IOMAP atomic flags")'.
> Let's fix this and let's also create some more space for filesystem reported
> flags to avoid this in future. This patch makes the core iomap flags to start
> from bit 15, moving downwards. Note that "flags" member within struct iomap
> is of type u16.
> 
> Fixes: 370a6de7651b ("iomap: rework IOMAP atomic flags")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


