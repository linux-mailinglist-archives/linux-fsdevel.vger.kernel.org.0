Return-Path: <linux-fsdevel+bounces-78380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMNeDJgTn2nWYwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:22:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E30199823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E839E30764A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D23D525B;
	Wed, 25 Feb 2026 15:15:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E33D3D1D;
	Wed, 25 Feb 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032507; cv=none; b=qZLxK9cKnSAxJRHv/znLmmDU2CeL7S/VrC6z3e9v+qgyIikBIDf03KL91HR53fsxvxsxg5QzaAXHHly2DqJVqo7jc34iP4j8XVaAjhTZWt3n2lfw+xzO/injpVdUWozphd/iISr6QMCqxpdB/1X3LtJ4egF+wJHUQRPP5+7FHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032507; c=relaxed/simple;
	bh=0b1TmiH9mAvRdRD6zdxNAVUGwraBR8r0oVfV8c2n774=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cleLXBybFlBAyqJyCbmYa3T8RYg5bWR2AB3RkTxPtYVQ981gyuI6Vez7yn7dLK4B/ZdHQAa4rdWW/T4zlVvK9b76w4Kx14WZg7ALluGubnE3uDm1jko2pFg/oqeS25By5Ae24+uXKjV4KOdYsX02RlZc6odNae/D9sNVjNu4WQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id A23BCE03DF;
	Wed, 25 Feb 2026 16:14:56 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 25 Feb 2026 16:14:56 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kevin Chen <kchen@ddn.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 0/8] fuse: LOOKUP_HANDLE operation
Message-ID: <aZ8RJFhnYA0519sv@fedora.fritz.box>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78380-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: B3E30199823
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:24:31AM +0000, Luis Henriques wrote:
> Hi,
> 
> I'm sending a new version of my work on lookup_handle, even though it's
> still incomplete.  As suggested elsewhere, it is now based on compound
> commands and thus it sits on top of Horst's patchset [0].  Also, because
> this version is a complete re-write of the approach presented in my previous
> RFC [1] I'm not going to detail what changed.
> 
> Here's a few notes:
> 
> - The code isn't yet fully testable as there are several pieces missing.
>   For example, the FUSE_TMPFILE and FUSE_READDIRPLUS operations are not yet
>   implemented.  The NFS-related changes have also been dropped in this
>   revision.
> 
> - There are several details still to be sorted out in the compound
>   operations.  For example, the nodeid for the statx operation in the
>   lookup+statx is set to FUSE_ROOT_ID.
> 
> - The second operation (mkobj_handle+statx+open) is still draft (or maybe
>   just wrong!).  It's not handling flags correctly, and the error handling
>   has to be better thought out.
> 
> - Some of the patches in this set could probably be picked independently
>   (e.g. patch 4 or even patch 1)
> 
> So, why am I sending this broken and incomplete patchset?  Well, simply
> because I'd feel more confidence getting this approach validated.  I don't
> expect any through review, but I would appreciate feedback on anything that
> would help me correct major flaws.

I, personally, appreciate the fact that you sent this out, so I can understand how
you are using the compounds for this real world problem, and it gives me confidence
that I'm not completely off with the compounds. 

Do you by any chance have implemented the fuse server part, too, or looked at it?
I'm just curious.

> 
> [0] https://lore.kernel.org/all/20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com
> [1] https://lore.kernel.org/all/20251212181254.59365-1-luis@igalia.com
> 
> Cheers,
> -- 
> Luis

Thanks,
Horst

