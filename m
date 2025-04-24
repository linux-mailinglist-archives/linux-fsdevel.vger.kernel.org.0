Return-Path: <linux-fsdevel+bounces-47216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE7A9A79A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B83BCCCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89421FF3A;
	Thu, 24 Apr 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh07Matf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092941E7C12
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486564; cv=none; b=YIU7cBvqWr5UtHHaimnQvvOJ71Sp2mbkOfVQGLsgudfi1vTkSVGeivraSe9s1mj9V5rDQKIv3c7WlJqobfKwOJZQMojXcXiMOiJHVAUIvko1Jiac12WXBGlbADse9WKSzf91k2arSEt6DInwGwuRGSJSetj2B9XxgtTxtq3AWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486564; c=relaxed/simple;
	bh=rRfT3KkaK7lPudDrJg4iPSOijskuE157fIEcYxnRdeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+W6Le7vj4+HcSDaTg5+51rGX5jH5F11ys07mLNcg318PYGWjqQ3pvKOZAmKC9cUxUb/PvWHpZ9h/4FWBwz/Gp9rR0ucBtKfg+W559QVHSFxApfV74FQWu5BY0WUITQmJ5wt2Pwr8ftOF3hkJA2KLa+g94wdzALYw7mhzyk/Cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh07Matf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97371C4CEEB;
	Thu, 24 Apr 2025 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745486563;
	bh=rRfT3KkaK7lPudDrJg4iPSOijskuE157fIEcYxnRdeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xh07MatfjhRJFfZSUxWbzkHHn7vG8Sg3QWP/4nwuePvuKCKSzdV8YausVL8fP5PaA
	 RF/qhkp7j0pTVwoZ/iXnKfqy/Ar7oNTgsJYrICKUY3eLSeQg3rVyoBudfHYOf2smeb
	 qD6CI0/8aNreil/0PyM2utMoHNQjQW2nkm7J6Xqw1IxrSmzjOw1lbrfBhoneKl8g0D
	 FZUzT4XqRorgUfINXe/5fgTdB0eT+0G8l1kfeC0VGiHy6Nwy5sJp+jE3lUAAg2a37Y
	 fOeouihAAb8J5PD9ZNeLskFAmUv4iaMQbWX+iDo9X9UQCDBlOkSnDBS81tbNqLiZ7v
	 JJZa/VzHtfhmg==
Date: Thu, 24 Apr 2025 11:22:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "fs: move the bdex_statx call to
 vfs_getattr_nosec"
Message-ID: <20250424-liefen-abprallen-c698e7d7eb26@brauner>
References: <20250424-patient-abgeebbt-a0a7001f040b@brauner>
 <20250424090444.GA27439@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424090444.GA27439@lst.de>

On Thu, Apr 24, 2025 at 11:04:44AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 10:59:44AM +0200, Christian Brauner wrote:
> > This reverts commit 777d0961ff95b26d5887fdae69900374364976f3.
> > 
> > Now that we have fixed the original issue in devtmpfs we can revert this
> > commit because the bdev_statx() call in vfs_getattr_nosec() causes
> > issues with the lifetime logic of dm devices.
> 
> Umm, no.  We need this patch.  And the devtmpfs fixes the issue that
> it caused for devtmpfs.

For loop devices only afaict. The bdev_statx() implementation is
absolutely terrifying because it triggers all that block module
autoloading stuff and quite a few kernels still have that turned on. By
adding that to vfs_getattr_nosec() suddenly all kernel consumers are
able to do the same thing by accident. This already crapped devtmpfs. We
have no idea what else it will start breaking unless you audit every
single caller.

If this stays in then please figure out how to skip a call into
blkdev_get_no_open() unless it's explicitly requested. I don't care if
we have to add an in-kernel only request flag. We have one already
anyway.

