Return-Path: <linux-fsdevel+bounces-75128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNB2FNtfcmnbjAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:35:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A86B6D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EE8830086EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0372F5A29;
	Thu, 22 Jan 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rrFHvxbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D851AE877;
	Thu, 22 Jan 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101961; cv=none; b=QmTKbA/0Y5NM79qtjjIh0nA8QpWdhF1LdJmqG7fFLhjXQ9tR8kqSxlBGOMjvI8b1NIBCmlt9XEhAmjhC5vxN7MF8KZZ+UCg3od2jAQuSCiuicTDmgSHdzqiEsVuZHsiQpnpmpIZTf3muhrHUu3dpfPoGLAS+mSkmC8if4T0Ggmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101961; c=relaxed/simple;
	bh=XXcNZspnoL4W/Wsbggllblj227uQM2K2Orf3kgz+3qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATODYze5aTXxEoso0+T4g3fPdTx9LfDB41QMz6M5jnkDxgnaoRrVTGOXVNbKb3MjkiF1mvu5Q2nHJs7uTbrNqzuCTKza4k8CprV8/u1KepZ08j9NR3+xIxk4vhaRfRacDelCY6HJYBvp2pUMvKD3cegRa5CFCUb/ztUIdt5NV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rrFHvxbP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jhcqp5p/UzonWc8IjBJaz4qAzIJwvcWefuHCxyQBqqY=; b=rrFHvxbPB8PigX7BMUdALYMxgI
	jNI+GK0KQFjJvQn8Ho4weVvcChZQcYzmdjJ2RQuztwhLEpnbzbTnJQ4TdO4mdx4ZqO8IhG8U9GVkt
	OAUfisQbrkSXz9bT+0Uz2BnQQu51lROo1X+7G4AO7239PlbIBBCi56467IRZPda/sM+wJX6MStOWQ
	TnYFf9ik08K0WhKczuNV7gEeSi0BqwhU8Bb1iSA7OEJOnxA/qANyUBNFxlDlOeuS6Z4D2ekla8om/
	0v29J1Lz8RBSxM8ruvDIRH9gOM7Nc5Bu6yaraAxwSBhfvaif1gL50ACj4pzsnZzJGzh6EH/Ig/nFJ
	uPAfe/XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1viyG0-0000000FDdO-3Yr6;
	Thu, 22 Jan 2026 17:14:08 +0000
Date: Thu, 22 Jan 2026 17:14:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: [PATCH] fs/file: optimize close_range() complexity from O(N) to
 O(Sparse)
Message-ID: <20260122171408.GF3183987@ZenIV>
References: <20260122163553.147673-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122163553.147673-1-realwujing@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75128-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E9A86B6D8
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:35:53AM -0500, Qiliang Yuan wrote:
> In close_range(), the kernel traditionally performs a linear scan over the
> [fd, max_fd] range, resulting in O(N) complexity where N is the range size.
> For processes with sparse FD tables, this is inefficient as it checks many
> unallocated slots.
> 
> This patch optimizes __range_close() by using find_next_bit() on the
> open_fds bitmap to skip holes. This shifts the algorithmic complexity from
> O(Range Size) to O(Active FDs), providing a significant performance boost
> for large-range close operations on sparse file descriptor tables.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>  fs/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 0a4f3bdb2dec..c7c3ee03f8df 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -777,13 +777,17 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
>  				 unsigned int max_fd)
>  {
>  	struct file *file;
> +	struct fdtable *fdt;
>  	unsigned n;
>  
>  	spin_lock(&files->file_lock);
> -	n = last_fd(files_fdtable(files));
> +	fdt = files_fdtable(files);

Careful - that thing might be expanded and reallocated once you drop
->file_lock (i.e. every time you close anything).  IOW, every time
you regain the lock, you need to recalculate fdt.

Other than that, looks sane.

