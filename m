Return-Path: <linux-fsdevel+bounces-76115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCfBNYVIgWnNFQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 01:59:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E83D3309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 01:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EA2D30078A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10012165EA;
	Tue,  3 Feb 2026 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oymjkyAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6321B9C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080383; cv=none; b=HPtJYaW/sVBG2gUEiDk2X060lxLC5N9RcPzlJjjIXFaa2JwPTQgqkmRjq5ZgqtDaCFKOlSmj14xZgYoSNXVI+fbCv4B5QSHeQRYkcdv8cr+Fk6b4B7dqVl9u2E4q9bKImIjuUGU32VuSzxRejO2kbf2iGYdYQVkMgbl4dlgxmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080383; c=relaxed/simple;
	bh=8248i/kYArgyaQTa2HABl7HpWtk+x6i4SNBHC7ecfvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+As1W0b0lK0ljb/TvRI2vYm9kTEAc47WJeMyD4yv/aNkYzJSlKHw/v/z3XH52VU8Mcfl5vwmA5clDrzoJq8MgEPeGbBITUmhqO60H1JrmjelUsX/FDvXB+lposqJaCn7j8wDgTB74GpB+zkCgxH1IwTFaoofcgwDYxDVihvKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oymjkyAL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6130wZeK027056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Feb 2026 19:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770080319; bh=aUyJiVznOTfQ6pPxpOeT0GU34DTIGGka4AHQzI4bQCY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=oymjkyALcY2L6SOAuZbHGBaaZnFauHrclv6xQuVdOYpduatevDy6DEZzen76pSw5N
	 XSQfkThuW5BRzrU06IYhabSdIPWNjwnQq3+jhdRbr25SpUVdQmkk5lNGOzd/uO747K
	 5wJy84oHudJlo887rgejCF0q1QH5M51Hm5HrX5Qs3lHCepH4V3tn4Q2Mbopst+Bthx
	 0C+l4IQPlMxaV2LUrSt8VQhwr0E8xmYuMjg6fdD9CnZNtwd7fmd+npl3qZ/la1AxRO
	 KtkMvAXtqMqtkMjomn3aBlwVAqM9ZppQSr3aAmTcLg/UvUvgBZF6yKRoZrRsiGt2QT
	 gDbA0NuZCVYXw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id F2B815704A33; Mon,  2 Feb 2026 19:57:34 -0500 (EST)
Date: Mon, 2 Feb 2026 19:57:34 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/11] ext4: move ->read_folio and ->readahead to
 readahead.c
Message-ID: <20260203005734.GB31420@macsyma.lan>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76115-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsyma.lan:mid,lst.de:email]
X-Rspamd-Queue-Id: 73E83D3309
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:06:32AM +0100, Christoph Hellwig wrote:
> Keep all the read into pagecache code in a single file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense to me.  Thanks,

Acked-by: Theodore Ts'o <tytso@mit.edu>


