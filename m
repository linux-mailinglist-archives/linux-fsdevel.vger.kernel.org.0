Return-Path: <linux-fsdevel+bounces-74813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPSLFz17cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:07:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8145297C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B0514FCFCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339938B9B3;
	Wed, 21 Jan 2026 07:06:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8536D4FF;
	Wed, 21 Jan 2026 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979163; cv=none; b=T9kOcN+oWGCNHgUvQSQc7UIbIj0EaRx1OKNg4vL1K/MZTLrC5Vxvrq+qNd5I3Rk0oPCblJWVct94khxe+J+iXasSWuaFGb+YsBZ8G0zrMoywbjtnFg8+EZEx1hB/BmGbHvY+hXidpyN/ljnboEnESBiwQAtN/efF+Imuw2Mulyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979163; c=relaxed/simple;
	bh=A2KfSkJuhESCLyE4jZ0Ge4N1CSVaBszfju+1MHdCnvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTLSvE2q8yq8H8KP5q68HjVW4oetEI2COlYjv2ntPMesujtgqeqj8gMHYVKIuKN9D6tuiTTUuTGHMmMRlfIhGZ93l96tNmp31ycBENDmvxbfhtpaPDcC1sJOO/3KNIw9gJY1OMSOz4eb23DW7F0Q0OZQ1XBzqfk4NYjW/Fyw/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A902227AAC; Wed, 21 Jan 2026 08:05:57 +0100 (CET)
Date: Wed, 21 Jan 2026 08:05:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Message-ID: <20260121070556.GA11882@lst.de>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs> <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs> <20260120041226.GJ15551@frogsfrogsfrogs> <20260120071830.GA5686@lst.de> <20260120180040.GU15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120180040.GU15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74813-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: EF8145297C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:00:40AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 20, 2026 at 08:18:30AM +0100, Christoph Hellwig wrote:
> > 
> > > +		unsigned int	bio_bbcount;
> > > +		blk_status_t	bio_status;
> > > +
> > > +		bio_reset(bio, btp->bt_bdev, REQ_OP_READ);
> > > +		bio->bi_iter.bi_sector = daddr;
> > > +		bio_add_folio_nofail(bio, folio,
> > > +				min(bbcount << SECTOR_SHIFT, folio_size(folio)),
> > > +				0);
> > 
> > You could actually use bio_reuse as you implied in the previous mail here
> > and save the bio_add_folio_nofail call.  Not really going to make much
> > of a difference, so:
> 
> Hrm.  Is that bio_reuse patch queued for upstream?  Though maybe it'd be
> easier to make a mental note (ha!) to clean this up once both appear
> upstream.

It is queued up in the xfs for-next tree.


