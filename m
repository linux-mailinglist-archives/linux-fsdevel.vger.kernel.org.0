Return-Path: <linux-fsdevel+bounces-26875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868395C57A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FFFB2205C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2089281205;
	Fri, 23 Aug 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="scAYF6wc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6F12D20D;
	Fri, 23 Aug 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394606; cv=none; b=qQZyjTYBZPmpKoD00VUjJNPTGU2mxjzv8sspbwxxsvz1v1b31COlks3nAoUfvRXGvPo+EX8m7C8f27gBU2LcDZaeRFZdUHgivkjCrzUoa/+JPb2IHCk4HYYGfutGRkeue3DDpkvip9A7tLhvRQ9IzFVgDngWhhA+ECw9v4siffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394606; c=relaxed/simple;
	bh=xyGfCPbineUy+UuU7cIwJ4fjQy+W9cArrH0n3Zackko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaBJDH7IWZdoB6r2Ka0lQXKSMGOwMdswH8FBjBnUf9hvU/dJls39/WybKqTAvM0Sl83Xuy+CcDZXs/eATZDxQESWUP6xJDTDtVkrsL0VytLcYeXNx4Inh5Xu0bUD6a0hLbW66NgtNMKZkHkgUd0vUeJlel8+YTATABHrfaiRg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=scAYF6wc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dDRJTumGqGgK5uukfw51tG1Riug8zodCJhx3CwG4cTA=; b=scAYF6wcHCuMN0eK66OrKdQGc+
	ax6zVSAjzesBlcYVcPQPrUyw6A3v0g33MYGA5idrhoAhGd3lUaI80loeVBUPe13dDehNEanPzsfiK
	ShQhtC3fQ1mZUZqecrWaX+BXfMmPFSUe6VC9O4trkSej/sO5ELZ8cpC1WtyfY5jpWhuOI88Sx6jVq
	Vcx/qvIzWUBIboJi0+NY3bZp+6mheDsy75rJM2Oiaypau1z7JqwSwXaoF3rhb4fWOqblEBoGrnH/i
	8wEONSMgxsAuelJZc1DZucbziJd4B6IVqmLGy4+eze0fdXzrDj69r6NJsV3YAPds67SncHJ7Fk3yx
	CpkQzP5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shNo9-00000004QgH-2D0U;
	Fri, 23 Aug 2024 06:30:01 +0000
Date: Fri, 23 Aug 2024 07:30:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.headers.unaligned 2/2]
 util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:10: fatal error:
 'linux/unaligned.h' file not found
Message-ID: <20240823063001.GA1049718@ZenIV>
References: <ZsgKudBxLxfMvlCU@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsgKudBxLxfMvlCU@rli9-mobl>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 23, 2024 at 12:06:17PM +0800, kernel test robot wrote:
> Hi Al,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.headers.unaligned
> head:   5adcdf60b29da8386cab7bb157927fec96a46c42
> commit: 5adcdf60b29da8386cab7bb157927fec96a46c42 [2/2] move asm/unaligned.h to linux/unaligned.h

Try 6f0416d97dba.

