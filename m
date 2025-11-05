Return-Path: <linux-fsdevel+bounces-67135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E3C35F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF97B4E2F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B50329368;
	Wed,  5 Nov 2025 14:04:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9A31283B;
	Wed,  5 Nov 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351458; cv=none; b=LUV8GGtUsMktH0mxox+nBZChj3TU8eeLFE8ZHGGHtEaKF8VNFIvR2EvS1Xyq/9CBxhlIEwCD44/Yprpq830ukFVYeGmqEaF/6G0yEH0W/9pv7MyeQQSsirI8aIVI0XMQvKMnpXckBnYie1j5dnRTP101o5Aq3Dd+8qyLly4XvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351458; c=relaxed/simple;
	bh=rqBqhzsknaVp7SyFenW+eX1qJl3YHhuaVStSL9Knyow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbqsPzyLfCFG+qlmbH/kI3PbGI0CdnZ4ECYdYoXkYSKsXdESsO360xfHvT+OnLrwAaCNthIvWVr6GGgT1IXEUDiqATHQJBVrM14Q1TClzQnYetEVGdWJPMoDu1Eb+MQnPCCCKLJySTOZ5aDIkM+4evR2e+jIj5MeaqK6/icVrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6495227AAA; Wed,  5 Nov 2025 15:04:10 +0100 (CET)
Date: Wed, 5 Nov 2025 15:04:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: replace FOP_DIO_PARALLEL_WRITE with a fmode
 bits
Message-ID: <20251105140410.GA22325@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-2-hch@lst.de> <f79ef55f5ec05400582dea69e7bc3f14f5a5d1f0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79ef55f5ec05400582dea69e7bc3f14f5a5d1f0.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 12:30:06PM +0530, Nirjhar Roy (IBM) wrote:
> On Wed, 2025-10-29 at 08:15 +0100, Christoph Hellwig wrote:
> > To properly handle the direct to buffered I/O fallback for devices that
> > require stable writes, we need to be able to set the DIO_PARALLEL_WRITE
> > on a per-file basis and no statically for a given file_operations
> > instance.
> So, is the fallback configurable(like we can turn it on/off)? Looking at
> the code it seems like it is not. Any reason for not making it
> configurable?

Please read the cover letter.


