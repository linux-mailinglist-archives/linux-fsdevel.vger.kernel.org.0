Return-Path: <linux-fsdevel+bounces-77001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNcAEqWgjWky5gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:43:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA7012BFA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86235301C517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5A2DFA2D;
	Thu, 12 Feb 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="A6MU7Hsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i677.smtp2go.com (e3i677.smtp2go.com [158.120.86.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CA2DF6F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889378; cv=none; b=Gf42x0vE2ivxRxpdrZwusenSeE5YRlhh5IlJBuFUaIqwz3pydTs8ma51Yu5mKH9VB+bvRFjSxuVXCPzFMLu3q8n1Ifj3z44O6e+VcoRlh7h9dKIQwX5ROs2fjv5QaaH3ek98V/9fT3xFwSlB/0dw4y2Na0nrDYKBVweXB4OjsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889378; c=relaxed/simple;
	bh=HNEpAuZGU8T/U+euPf7PsgW+b7BopHEn/wG+L+SBZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE1Eeu+WqnVMQ6Rg0HZfPSJtjHwtAC7uLbCKmaDKoAdPjuqwtdsnPwF5o3he9r+2l1fImCiNs4RBH58TYaPPV1Tzn8IVDpF/eg+gFtWJ3qRSOl85V4FJRAK16JzC6nJCQYpg6Q1lhjFWvUgtdxhF6gXw6l+uU78Vrnrq6DDkFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=A6MU7Hsz; arc=none smtp.client-ip=158.120.86.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1770889375; h=from : subject
 : to : message-id : date;
 bh=cSz0rTGp9/+1Z7AIaEcK3nmcIXZNhHRnmZh2Iy17Igg=;
 b=A6MU7Hsz1gfV2vpiIKywOoCg3gXpTbA0MdefEjemhmSsQCZh1k45fdo7l3tEpYGR7Eer/
 xnQ6F0NyQXtuq1aQU8YHH/faYskU15JOj75P6+VolvLo9fpQuIa+ZekRBDvogStO0SaF7qE
 4IBU7c8foO/ZbFJOCjvA/kovmLJTCrH86WhEsQ/gUTpfzcODduG6Z/weUNUwrzJwclCAVVZ
 DFL2vRDmtJZUKFaIDic1d91TMlVsOx7p1A0L6sVntrQWBg924o4EpdnGOq1M2qZ4w96srg+
 MD3X50uaYbBaRigbMsasRZLCb9wAvIczbZq1sjIqQ304FZwVKeFq9BQ+pAFQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vqTDk-FnQW0hPtR4n-nC1s;
	Thu, 12 Feb 2026 09:42:48 +0000
Date: Thu, 12 Feb 2026 10:24:27 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache
 retention time
Message-ID: <aY2cS77rIL-h-8il@pilgrim>
References: <cover.1769013622.git.repk@triplefau.lt>
 <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
 <3929797.kQq0lBPeGt@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3929797.kQq0lBPeGt@weasel>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sCOEI9QSwV
X-smtpcorp-track: XzfTOVUPtxH2.wS3H-P5CRXeD.__2_6wPZ-t6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[triplefau.lt:email,triplefau.lt:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77001-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	R_DKIM_ALLOW(0.00)[triplefau.lt:s=s510616];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,triplefau.lt:email,triplefau.lt:dkim]
X-Rspamd-Queue-Id: DDA7012BFA1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 04:58:02PM +0100, Christian Schoenebeck wrote:
> On Wednesday, 21 January 2026 20:56:09 CET Remi Pommarel wrote:
> > Add support for a new mount option in v9fs that allows users to specify
> > the duration for which negative dentries are retained in the cache. The
> > retention time can be set in milliseconds using the ndentrytmo option.
> > 
> > For the same consistency reasons, this option should only be used in
> > exclusive or read-only mount scenarios, aligning with the cache=loose
> > usage.
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  fs/9p/v9fs.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> > index 1da7ab186478..f58a2718e412 100644
> > --- a/fs/9p/v9fs.c
> > +++ b/fs/9p/v9fs.c
> > @@ -39,7 +39,7 @@ enum {
> >  	 * source if we rejected it as EINVAL */
> >  	Opt_source,
> >  	/* Options that take integer arguments */
> > -	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
> > +	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
> >  	/* String options */
> >  	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
> >  	/* Options that take no arguments */
> > @@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
> >  	fsparam_string	("access",	Opt_access),
> >  	fsparam_flag	("posixacl",	Opt_posixacl),
> >  	fsparam_u32	("locktimeout",	Opt_locktimeout),
> > +	fsparam_s32	("ndentrytmo",	Opt_ndentrytmo),
> 
> Not better "ndentrytimeout" ?

I just wanted to avoid to re-align all the above, but lazyness should
not prevail over readability :). I will change that thanks.

> 
> My first thought was whether it was really worth introducing a dedicated
> timeout option exactly for negative dentries (instead of a general cache
> timeout option). But on a 2nd thought it actually needs separate handling, as
> negative dentries have the potential to pollute with a ridiculous amount of
> bogus entries.

Agreed.

> 
> Wouldn't it make sense to enable this option with some meaningful value for
> say cache=loose by default? 24 hours maybe?

That is an interesting question, I have seen pretty satisfying (at least
for me) perf results on the different builds I ran, even with a 1 to 2
seconds cache timeout, maybe this would be a good tradeoff for
cache=loose being almost transparent in the eye of the user ? But maybe
this is too specific to the build workflow (that hit the same negative
dentries fast enough) ?

> 
> > 
> >  	/* client options */
> >  	fsparam_u32	("msize",	Opt_msize),
> > @@ -159,6 +160,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry
> > *root) from_kgid_munged(&init_user_ns, v9ses->dfltgid));
> >  	if (v9ses->afid != ~0)
> >  		seq_printf(m, ",afid=%u", v9ses->afid);
> > +	if (v9ses->ndentry_timeout != 0)
> > +		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
> >  	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
> >  		seq_printf(m, ",uname=%s", v9ses->uname);
> >  	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
> > @@ -337,6 +340,10 @@ int v9fs_parse_param(struct fs_context *fc, struct
> > fs_parameter *param) session_opts->session_lock_timeout =
> > (long)result.uint_32 * HZ; break;
> > 
> > +	case Opt_ndentrytmo:
> > +		session_opts->ndentry_timeout = result.int_32;
> > +		break;
> > +
> >  	/* Options for client */
> >  	case Opt_msize:
> >  		if (result.uint_32 < 4096) {
> 

Thanks,

-- 
Remi

