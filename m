Return-Path: <linux-fsdevel+bounces-11308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDC8528F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EC9B22A52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B414A8F;
	Tue, 13 Feb 2024 06:31:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF81FB9;
	Tue, 13 Feb 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805906; cv=none; b=R4uw4cb5OlVEK4VajCzwJAVlWzYkFJMBb9V/ZHAMyncxF42Oo17U0JcQX7ltHyyWQqrMp28Zbnnl4A23u1SqVriyQuNefcLzsO0RCyzlR/2KHAziiXEJHAvQmBZhGVXSstop4lXBKELj0qH3ljGC9SFiVelwicXcUPZsmX20UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805906; c=relaxed/simple;
	bh=YZKwkglXRpeP7mo8EyPF1blbKHA/vAS4XZVjSnfHwSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QymeUNuSYu01Y+ABXkwZ/G3BV8F+ZEgrMvS13uR4CKOLODmZfiaKPeYrCMP3XyRbqOubCvhlckJJrHpIhauYKp4X430Yjp7ly2of/90j3vOOFiyQZAa7Uc7CGWR749JRY5WVrErQmfGLtANTWny1nOHkKTzwkMPkJPVOqNsg4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBC45227A87; Tue, 13 Feb 2024 07:31:39 +0100 (CET)
Date: Tue, 13 Feb 2024 07:31:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 11/15] scsi: sd: Support reading atomic write
 properties from block limits VPD
Message-ID: <20240213063139.GA23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-12-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 11:38:37AM +0000, John Garry wrote:
> Also update block layer request queue sysfs properties.
> 
> See sbc4r22 section 6.6.4 - Block limits VPD page.

Not the most useful commit log..

Can you merge this with the next patch and write a detailed commit
log how atomic writes map to SBC features and what limitations
Linux atomic writes on Linux have?


