Return-Path: <linux-fsdevel+bounces-24443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53AA93F502
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561191F22307
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D21474D0;
	Mon, 29 Jul 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXCKb3WQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2391465A1;
	Mon, 29 Jul 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255486; cv=none; b=G0vTNUXKyW8DmlMVhi2rlVxvEH4W33kNPtNGTupvUsj4KPqtHuzb8d//o2xqRa/kTI10dDzIibSbetQ4gkePVn19z78Z6Oerm1xXcYHhh5RgBiiT3MAR3IfqbPEGs1WHH44p2oHN1GNTEs/xD0dqJXkb+BXQ6HadVdzqEfVyut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255486; c=relaxed/simple;
	bh=M7Hnrz26bsy5Tr1t7esb5UBzrw3GNQZ5FccICOao0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE3IQqLLuNs015zl75vROj72fxZFQwyBbbdSTagK5+NcI9avyI+lkLjbaxKyh+9PCZN97aSTf5R8vJKUInysRLmhMXXXAionGdoNte+H9hdStu5UphL6FCA9UNO+xXBLm/9Tr72sWO27TA71u9Y2lO2M8bK1THxGRRXbdpgZQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXCKb3WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FF9C32786;
	Mon, 29 Jul 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722255486;
	bh=M7Hnrz26bsy5Tr1t7esb5UBzrw3GNQZ5FccICOao0lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXCKb3WQhuIC+038/AFjxfT9z18DzXyWDnJ39Ewv/7ctmv6NSe8hbr2msZz8QFTzu
	 EkxJhbPQeOoQ/SA4bl0rT74xYGzm0M1Fb2NJSQ3x69WYDfB6+jnPg4+SAHe/c2d+i+
	 OqkEmOYORwzDcHxeLJr2IdgcENbANatRqNAv7ZfBmt1uLYf8anSp/s+LblpSyMEeBn
	 1sToUt97mbQdDCoSZ0bJNcWdy6BH/5FiSMn0ktk+1KH9Mirx1gr/9V4sRmCoTcpLfQ
	 KqdyYrR9GDWJRFhFcoC8EXI6nc8L6kTIvjxigBv4MQjn/v9U64+Gsm57ilZyFhsxaw
	 uzXxkMSb/VlsA==
Date: Mon, 29 Jul 2024 14:18:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: mohitpawar@mitaoe.ac.in, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed: fs: file_table_c: Missing blank line warnings and
 struct declaration improved
Message-ID: <20240729-abgeordnete-attest-d20071dfb242@brauner>
References: <linux-fsdevel@vger.kernel.org>
 <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
 <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
 <20240729114959.lxhpjhve7lhpf2jm@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729114959.lxhpjhve7lhpf2jm@quack3>

On Mon, Jul 29, 2024 at 01:49:59PM GMT, Jan Kara wrote:
> On Sat 27-07-24 12:51:34, mohitpawar@mitaoe.ac.in wrote:
> > From: Mohit0404 <mohitpawar@mitaoe.ac.in>
> > 
> > Fixed-
> > 	WARNING: Missing a blank line after declarations
> > 	WARNING: Missing a blank line after declarations
> > 	Declaration format: improved struct file declaration format
> > 
> > Signed-off-by: Mohit0404 <mohitpawar@mitaoe.ac.in>
> > ---
> >  fs/file_table.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index ca7843dde56d..306d57623447 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
> >  	register_sysctl_init("fs", fs_stat_sysctls);
> >  	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
> >  		struct ctl_table_header *hdr;
> > +
> >  		hdr = register_sysctl_mount_point("fs/binfmt_misc");
> >  		kmemleak_not_leak(hdr);
> >  	}
> > @@ -383,7 +384,10 @@ EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
> >  struct file *alloc_file_clone(struct file *base, int flags,
> >  				const struct file_operations *fops)
> >  {
> > -	struct file *f = alloc_file(&base->f_path, flags, fops);
> > +	struct file *f;
> > +
> > +	f = alloc_file(&base->f_path, flags, fops);
> > +
> 
> When you separated the function call from the declaration of 'f' this empty
> line is superfluous. Maybe Christian can fix it up in his tree (or maybe he
> already did). Otherwise the patch looks good. Feel free to add:

I already did. :)

