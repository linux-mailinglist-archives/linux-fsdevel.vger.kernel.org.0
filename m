Return-Path: <linux-fsdevel+bounces-76721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBdjKa0UimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:09:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E49112DEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F0C43047E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2B3859D6;
	Mon,  9 Feb 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l9GzceMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE613239E75
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656633; cv=none; b=NFIcd279NQmkZkBRx+9c+P6MT7ljf1nki8zb0BCAqm5F5IVwdXQCxBEmWjZMAMpYJIt7CRew2PdduGLGA/6bPlLsr1pZeFlEjJEUxqeC198Z1eyxkMSuAAeU2LZ5jM1F0ex5aKalGkr4uWw+BHnA6RHCM0cUerW1k4wlZXJCKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656633; c=relaxed/simple;
	bh=mQU+PSy3DUt4Ba5QB/r/C8tjmtjEIXHVIDDiAfHtCV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXufao9JyI3r/3nx1NJJmp2G7ch2ZfRuEQ8TF808O9sw4e3hjJSs7foELiyCERoo/1ku6Snymqd4t2CZqH/AMxmxQqYz0hODP9lDwKtAVb3mE5se5HyuzomDioVMmAKet4RvzXLIYPTwiPHpFf0F1a3fw2D9w0ORkzEDO/mutDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l9GzceMS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yFYT5KAsSK/+i8yjAkGONo4LAjzIcnt+WlVcpAm32c4=; b=l9GzceMScI+HVZEVOYYinRjvh+
	Z5tpUEfnVA+FQUVvP/nxBpkm6gALeEgR33ZW54EhOnp5SOSN4KgEh5xtYjfr+PDrlMH8V83FUNGb/
	43gMVg0iTodJXp8h3MO7BZSDKDf58lJ/5qLrreXmMNBSRzcrBOf21LH+4SFdPlvDxO7sDJFJilX37
	I8Hx+zaIQgEU5UhLKEY+EaIcHrEBNz6rByGaAMg4Xdplv2LQqgZepkHHz7p4O3ZYzIunCEUwQHBXF
	t4UXFd5SRnluUg6jNJ/nC2e/lH3D+GMT01y8z6gW8Z1/UZt7irqK+O7hJTpI/MiePKwMdBwdsiGUa
	pZMLdIhA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpUfs-00000009nTP-2BNW;
	Mon, 09 Feb 2026 17:03:48 +0000
Date: Mon, 9 Feb 2026 17:03:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: oaygnahzz <oaygnahzz@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] [QUESTION] ext4: Why does fsconfig allow repeated
 mounting?
Message-ID: <aYoTdL_6hvjrwJ3W@casper.infradead.org>
References: <20260209165944.12649-1-oaygnahzz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209165944.12649-1-oaygnahzz@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76721-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 89E49112DEF
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:59:44AM +0800, oaygnahzz wrote:
> Hi all,
> The mount interface will report an error for repeated mounting,
> but fsconfig seems to allow this. Why is that?

The patch is incorrect and unrelated to the question

> Thanks.
> ---
>  fs/fsopen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 1aaf4cb2afb2..06a8711dd627 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -300,6 +300,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  
>  /**
>   * sys_fsconfig - Set parameters and trigger actions on a context
> + *
>   * @fd: The filesystem context to act upon
>   * @cmd: The action to take
>   * @_key: Where appropriate, the parameter key to set
> -- 
> 2.33.0
> 
> 

