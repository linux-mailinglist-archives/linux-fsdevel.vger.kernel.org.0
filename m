Return-Path: <linux-fsdevel+bounces-13907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B4875558
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AEE1C22402
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E662130E53;
	Thu,  7 Mar 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIzF/9Wo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DB12E1CF
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833209; cv=none; b=MhEcD/bdBgqKEcplehPpxMeQjrAsVqTE5DrtD+mZ9Xx/iXnxLqNUXWVwK6Aq3SRKbgL5bovvxiHGihKzeQ9+Hl7o1+z4Pl8pD1r4FnXIxzJxNB2+4UNnp2Hgqhihs81blN3YgGXdjusk+shUazVjKbaS34ITqWVlc1oYm5Rn+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833209; c=relaxed/simple;
	bh=hRSl+XEmM4fPNM12v3nNoTx7PNw2TGseWo3VuRaIdko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMoYc8tp+8qIfmyo+KTsGtkkz57RLgpbZbFL3i55SQbL+2fqS7RfgUu069llOaIRiLIQmPN0NP9NAHVroK1fbtQHeJd7iFVhB8APmJ6Gzgt06O4l+xKB1k+QbEyi732t0q5+DiiXgf15M/SmF35qK1C9oNke+QCBJ/rvnt2g17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIzF/9Wo; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Mar 2024 12:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709833205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Saf0V459wjVI/LACMclGTIzYyUNjj1FKOP0tushsb8k=;
	b=fIzF/9WoqVVDQVfK5OIIQsnwrnp4nKQCLhLc6Ex7PZuRVHUpvG+MG7OAWnrNk/UQ226T2I
	zMuqiO3Nt8FDHMBvH/C/1QnWTAu1Xumqk4ZVMdbHnVPyQSXF73y+BeESa5PW552epgKYZ7
	RDsqlCmxXcJsO45vFsxhg3hJMgfZ7NI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <xqazmch5ybt7fatipwkuk7lnouwwdn55cirvaiuypjmy3y4fte@6vwyvv3uurl5>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
 <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 04, 2024 at 10:18:22AM +0100, Christian Brauner wrote:
> On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> > Add a new statx field for (sub)volume identifiers.
> > 
> > This includes bcachefs support; we'll definitely want btrfs support as
> > well.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > ---
> 
> As I've said many times before I'm supportive of this and would pick up
> a patch like this. There's definitely a lot of userspace that would make
> use of this that I'm aware of. If the btrfs people could provide an Ack
> on this to express their support here that would be great.
> 
> And it would be lovely if we could expand the commit message a bit and
> do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
> then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
> subvol_id for the field in struct kstat.

_id is too redundant for me, can we just do STATX_SUBVOL/statx.subvol?

