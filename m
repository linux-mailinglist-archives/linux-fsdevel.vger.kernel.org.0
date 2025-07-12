Return-Path: <linux-fsdevel+bounces-54738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B730B028D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 03:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C6AA65F24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 01:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93178F26;
	Sat, 12 Jul 2025 01:17:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A645009
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283056; cv=none; b=KxQpPXxDotMrvJ7fXfy7iqPMnXTpwWR/MmQtNNA63hot1tyCJwsS8gJeN8N7/lOMgzPejLpeD/DI4ongXfXK/DvRSjzIbBJw9pBawjqB920MtyJmmDQKUCUjTl7831FoY11KFn/ZzwAYNM9g82grCd106A07ctmbN/faa4Pv4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283056; c=relaxed/simple;
	bh=fn2grJQ47mBUqXR3ubf/h9gkktj0zblLol3sri10GG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SggwBVbavz8OokndG+LzEfbw50/EN4GBz3syl8DicE7aq1qeDbbNtLmQe+hFOTxogZnrjem92satvBdAjkQvng9VtjH1Doi7bPANeoc+osMLQyfhBr0VOpX/P7RhYSA24f2mNO84WyeF6zRSabvIpq/OY56fv7zArZNdEF+HLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bf9cg4ylZz2TSwQ;
	Sat, 12 Jul 2025 09:15:31 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B521140276;
	Sat, 12 Jul 2025 09:17:30 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Jul 2025 09:17:30 +0800
Received: from localhost (10.175.112.188) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Jul
 2025 09:17:29 +0800
Date: Sat, 12 Jul 2025 09:02:42 +0800
From: Long Li <leo.lilong@huawei.com>
To: Bernd Schubert <bernd@bsbernd.com>, <leo.lilong@huaweicloud.com>,
	<miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: Re: [PATCH] fuse: show io_uring mount option in /proc/mounts
Message-ID: <aHG0MhIc_UE6xGE2@localhost.localdomain>
References: <20250709020229.1425257-1-leo.lilong@huaweicloud.com>
 <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100013.china.huawei.com (7.202.194.116)

On Wed, Jul 09, 2025 at 01:00:05PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/9/25 04:02, leo.lilong@huaweicloud.com wrote:
> > From: Long Li <leo.lilong@huawei.com>
> > 
> > When mounting a FUSE filesystem with io_uring option and using io_uring
> > for communication, this option was not shown in /proc/mounts or mount
> > command output. This made it difficult for users to verify whether
> > io_uring was being used for communication in their FUSE mounts.
> > 
> > Add io_uring to the list of mount options displayed in fuse_show_options()
> > when the fuse-over-io_uring feature is enabled and being used.
> > 
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> >  fs/fuse/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index ecb869e895ab..a6a8cd84fdde 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -913,6 +913,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
> >  			seq_puts(m, ",default_permissions");
> >  		if (fc->allow_other)
> >  			seq_puts(m, ",allow_other");
> > +		if (fc->io_uring)
> > +			seq_puts(m, ",io_uring");
> >  		if (fc->max_read != ~0)
> >  			seq_printf(m, ",max_read=%u", fc->max_read);
> >  		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
> 
> I agree with you that is impossible to see, but issue is that io_uring
> is not a mount option. Maybe we should add a sysfs file?
> 

Yes, this is not a mount option. Thank you for your suggestion.

Thanks,
Long Li

