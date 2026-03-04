Return-Path: <linux-fsdevel+bounces-79350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLO/Ft4rqGkgpQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:55:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A81FFE6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79EC53024A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924E20E6E2;
	Wed,  4 Mar 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GD7rN9I/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80E18D658;
	Wed,  4 Mar 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628900; cv=none; b=HdwiX7MbO9+p52TJO7BoiqIMJ/XpkWk/TM3AeQVbXzTbscjAXiX9j14Z0A7YTYzv543e3msXpiJg98qWNpWcYAG1VGhnvL7qUnKZuGNSBk00oO4wHqylxfep9ONA8aZAEWlqcAyxX4/81Z5DjRVEA5dceYj26e21rn9GzPXCT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628900; c=relaxed/simple;
	bh=f4Rjaivtmb3+wzO9vUxbHKyV0yJ5P/xpKMxO+oCU/ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TslDB78V5c5rhot3GbvpAFUvy6pAo37yBI4CihcNryveq4CxPJwAwrqofdJEQ7yHi03iKjZ7dEmGerP0nEj40kva4Q0HpfmaiWVek93PfbJJs8XET2yj5bk2QShw6PG92azMgNXjZlcVKQNPYyWVpYs5/j70D+Wa7XxE/dqmdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=GD7rN9I/; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=n0FpsErEZt+zXR22oyxotDzQ8v/fhvPRZ3CgAovnctg=; b=GD7rN9I/H6kztAQ3+r29OLdzlB
	2wp5jpgSAboJgom75taGQMek16gUDvz3xI7vdGjdkpNUllrDTHF98AWiP+OCnH+rOZ1fmy5VcaJFU
	VKsQ6X0/ZlhIxWns+OUOSrPYZumUmEIpIrX7CdBPYoYV4I28H3Mc09hzxyuMYS02nf08z/62Z/xbi
	o1m/AHciADED1VNUeJY8ncGAEmsjfmoxoNY5go/O2j5G08nElYTASCIXdLrkXyY4YDPEYHEBmARgM
	e/aWLxbdPItZilethgeTdmimnnNzkNy7FU0wpgJatFK9xS3e1c+1ib2jXv+kI3wFni1B8xrQxUwur
	lGAuab0dWMoGjmeHvd/MBN6yLukf+/HH1qFtTyg8lltEfcG3lFZv1rYSN1P8QJaq/8h7GyKjo+sds
	9CFRMrYpSXsWvfhbsbfaBU9DGH7EEzwD7KLJjh3SGl3RXf9rTHBfyBltzYNJVT4bF75KE8tF91O8n
	b0v+WABLv71eHCuGNmp8y5vbDohoaKzkO6L/MjGGTa2Ulku/7V+j3+KjGuosg2U/NbESz7ogmGBeF
	eboARZxObG5i3ci4voEH4Lq7Xy/IUxhPjQpEa2MT9K8iFNIdR0b9Vsy0ALCB/E8/jIOeQYMPJGked
	2nW3iFKQUtNa6G8IDGdoEUGmfK35WtwFAc5Kgsmbc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject:
 Re: [PATCH v3 3/4] 9p: Set default negative dentry retention time for
 cache=loose
Date: Wed, 04 Mar 2026 13:54:55 +0100
Message-ID: <13960849.dW097sEU6C@weasel>
In-Reply-To:
 <59d4509e1015eb664bc2b5e59e1d5cf11ab95656.1772178819.git.repk@triplefau.lt>
References:
 <cover.1772178819.git.repk@triplefau.lt>
 <59d4509e1015eb664bc2b5e59e1d5cf11ab95656.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: C52A81FFE6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79350-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:email,crudebyte.com:dkim,crudebyte.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Friday, 27 February 2026 08:56:54 CET Remi Pommarel wrote:
> For cache=loose mounts, set the default negative dentry cache retention
> time to 24 hours.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  fs/9p/v9fs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index a26bd9070786..d14f6eda94d6 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -24,6 +24,9 @@
>  #include "v9fs_vfs.h"
>  #include "cache.h"
> 
> +/* cache=loose default negative dentry retention time is 24hours */
> +#define CACHE_LOOSE_NDENTRY_TMOUT_DEFAULT (24 * 60 * 60 * 1000)
> +

Come on, really worth to save 4 characters here as well? :)

Whatever:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  static DEFINE_SPINLOCK(v9fs_sessionlist_lock);
>  static LIST_HEAD(v9fs_sessionlist);
>  struct kmem_cache *v9fs_inode_cache;
> @@ -440,6 +443,13 @@ static void v9fs_apply_options(struct v9fs_session_info
> *v9ses, v9ses->uid = ctx->session_opts.uid;
>  	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
>  	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
> +
> +	/* If negative dentry timeout has not been overriden set default for
> +	 * cache=loose
> +	 */
> +	if (!(v9ses->flags & V9FS_NDENTRY_TMOUT_SET) &&
> +	    (v9ses->cache & CACHE_LOOSE))
> +		v9ses->ndentry_timeout_ms = CACHE_LOOSE_NDENTRY_TMOUT_DEFAULT;
>  }
> 
>  /**





