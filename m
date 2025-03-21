Return-Path: <linux-fsdevel+bounces-44670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C158A6B3E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9AB3AA24B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA61E51FF;
	Fri, 21 Mar 2025 05:01:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401F184F;
	Fri, 21 Mar 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533280; cv=none; b=MFMNXsDU05pYrF1CXs8lpOe5BdJrSgZJR6ZJZF91jZIRPxp/VZJZGZe8uniGl/BVYM7hIeM5s8TbMGiG96LDgUrcylFrADX2wxDtpFtxt2L+JWmy/aavmCIQBJL39MYlFZc7kCKI6zo7FtVejcYr+tsuw0QaD+V1wzA3hamROxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533280; c=relaxed/simple;
	bh=3QD724I6a0I1C2bbSHIvWSRTUdaPvAxnzKDiRc8qpUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnekX7eZKn6jjKayRa+9LnyFnDfAj2XxGf3HhBftPa0PlDwQptQK0DNyfHP8l0buGlog4U/cE7Nrqkk8Kn/r5ko+ze7DbZJcaw91L7qzPhWi0V8dEVYn2yT2GQXAwivw1m1DeogsZWgZe0c8X/5+rPit+bs8BSRK8KfNmLypRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9124568AA6; Fri, 21 Mar 2025 06:01:14 +0100 (CET)
Date: Fri, 21 Mar 2025 06:01:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250321050114.GC1831@lst.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

We've been trying to kill off initrd in favor of initramfs for about
two decades.  I don't think adding new file system support to it is
helpful.


