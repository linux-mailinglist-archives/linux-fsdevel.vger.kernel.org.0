Return-Path: <linux-fsdevel+bounces-49314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA2ABA6C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331EB4A83AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CE281367;
	Fri, 16 May 2025 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tzVom2iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E423644F;
	Fri, 16 May 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439862; cv=none; b=twQbfrvakR2Kur8XpDDlJP68Ye8q2AUv7/OLuCagsSWnaD9Oa67TNuU89zPJ2oofks2+LHnlNP+VuevocP/bhNxQz1Hj1laJVEfqHmSil8plYfuC4AucIsPuH71n2ykYz6+tMWuloEjyFEorCW4ds84e2w7h0WpgmPjxA9aLpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439862; c=relaxed/simple;
	bh=aC4uD0ITTl/JDgfgCUKDW0jP6UX1KG9IQNgPkE3lK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/S25uOs9MAhauXEWDqIx+E5XBD9Ovw7IBt+/ccYEn9LKabXzhGpztHR93B84q+AtnvdQCvywxB6lP+we7qXjuaYh1N3ZSS4jbFLPgYs255rP5mENBdZQS3Dzm0SO9gGLFg8i6bo3i6B1zvsFOFdcSTr0k5D2XvmtHofABjL238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tzVom2iz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=CqWZwZQKIafLZoktjyxhluo+wFu9cppa1wUYPy14yRA=; b=tzVom2izoVb5qZSGJvmxeRe3oi
	L7H7X5HPVBTtWdjtxozkKjarX8sM9YBpDbyS+oPS5+8w+UCyezJBUi0yBBtMSatvP1RyeU1GYLhGS
	O9XG59+Y2bZsVUIxOlBJ7RxEi2Nisph3r+KTK7Y8hr2Lvtoz3mXCRNhcvbk4b+tJpHmDiZ7ldlQ0R
	dA36Ed9DwVtu0SN6IEUVK7TAYDHcaxd5+1lWSWx19fXcknnkATzRU2zhd9zbmbXB6MGX0gQbylPJU
	lUOih/c1ig8gzv2oOp/p+m9N+pBUWqNOZnKfQ1crJOcRR2Qob3JWbvUM7hOuxvZDEs2evfArwB2y/
	IOpGBRHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG4vr-00000003xBs-0UGa;
	Fri, 16 May 2025 23:57:39 +0000
Date: Sat, 17 May 2025 00:57:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
Message-ID: <20250516235739.GV2023217@ZenIV>
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
 <vtfnncganindq4q7t4icfaujkgejlbd7repvurpjx6nwf6i7zp@hr44m22ij4qf>
 <b3d6db6f-61d8-498a-b90c-0716a64f7528@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d6db6f-61d8-498a-b90c-0716a64f7528@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 17, 2025 at 07:54:55AM +0800, Zizhi Wo wrote:
> 
> 
> 在 2025/5/16 18:31, Jan Kara 写道:
> > On Fri 16-05-25 11:21:47, Zizhi Wo wrote:
> > > From: Zizhi Wo <wozizhi@huawei.com>
> > > 
> > > Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
> > > consistency between declaration and implementation.
> > > 
> > > Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> > 
> > I'm sorry but this is just a pointless churn. I agree the declaration and
> > implementation should better be consistent (although in this particular
> > case it isn't too worrying) but it's much easier (and with much lower
> > chance to cause conflicts) to just fixup the declaration.
> > 
> > 								Honza
> 
> Yes, I had considered simply fixing the declaration earlier. However, in
> the include/linux/mount.h file, similar functions like
> "mnt_put_write_access" use "mnt" as the parameter name rather than "m",
> just like "mnt_get_write_access". So I chose to modify the function
> implementation directly, although this resulted in a larger amount of
> changes. So as you can see, for simplicity, I will directly update the
> parameter name in the function declaration in the second version.

FWIW, "mnt for vfsmount, m for mount" is an informal convention in that
area, so I'd say go for it if there had been any change in the function
in question.  Same as with coding style, really...

