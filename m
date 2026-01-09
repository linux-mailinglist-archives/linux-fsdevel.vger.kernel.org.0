Return-Path: <linux-fsdevel+bounces-73057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5ACD0AC25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34345301074B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11226311949;
	Fri,  9 Jan 2026 14:57:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B522BE655;
	Fri,  9 Jan 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970620; cv=none; b=bwQK9DGiONMy5LQa5dm/7S3pp63j7ZCCCrBy/QIwV87n0zrNb12gRnb//Tnf5LIhMQmPVjjebRbbM1HCqi9DCD9D0X7UdjFtBWtKvAvSSOuRfb0bLdSR2lfk+fGYRutN2mVVpF86rFGbsuHTjaUn+u61gmmmJx0l/XLLv4cdV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970620; c=relaxed/simple;
	bh=XlIWm5kEQieWEq0QiY6N4rFVzA8LSoajEA8E3wT7qQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh21Ro+py8dYlP9PFBcdmwepOScbIdiPYiaTctMtd+xvTjezIpWyaMKgoWqYohl9el2ZuASQBldVU93pFMzDsDjAP/6jBhN6VOJiO+EH8qHC0IgUrrhReObhFdmUzgRMyn3cSD01vL6diPLg/sOW8bYoGtejVDBbHsafXCyOC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 3F410E032E;
	Fri,  9 Jan 2026 15:56:49 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 9 Jan 2026 15:56:48 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aWEWVAqHlTpzsklJ@fedora>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <87tswuq1z2.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tswuq1z2.fsf@wotan.olymp>

On Fri, Jan 09, 2026 at 02:45:21PM +0000, Luis Henriques wrote:
> On Fri, Jan 09 2026, Miklos Szeredi wrote:
> 
> > On Fri, 9 Jan 2026 at 12:57, Luis Henriques <luis@igalia.com> wrote:
> >
> >> I've been trying to wrap my head around all the suggested changes, and
> >> experimenting with a few options.  Since there are some major things that
> >> need to be modified, I'd like to confirm that I got them right:
> >>
> >> 1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use the
> >>    struct fuse_entry_out, which won't be changed and will continue to have
> >>    a static size.
> >
> > Yes.
> >
> >> 2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamically
> >>    allocated (using your suggestion: 'args->out_var_alloc').  This will be
> >>    a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
> >>    replacing the struct fuse_attr by a struct fuse_statx, and adding the
> >>    file handle struct.
> >
> > Another idea: let's simplify the interface by removing the attributes
> > from the lookup reply entirely.  To get back the previous
> > functionality, compound requests can be used: LOOKUP_HANDLE + STATX.
> 
> OK, interesting idea.  So, in that case we would have:
> 
> struct fuse_entry_handle_out {
> 	uint64_t nodeid;
> 	uint64_t generation;
> 	uint64_t entry_valid;
> 	struct fuse_file_handle fh;
> }
> 
> I'll then need to have a look at the compound requests closely. (I had
> previously skimmed through the patches that add open+getattr but didn't
> gone too deep into it.)
> 

I am preparing the pull request for libfuse today, so you can have a look at how it will be handled on the libfuse
side. 
That contains a patch to passthrough_hp as well so it supports compounds and you will have something to test, if you want to go that way.

> 
> Cheer,
> -- 
> Luís
> 

