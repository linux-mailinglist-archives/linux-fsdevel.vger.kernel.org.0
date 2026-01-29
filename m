Return-Path: <linux-fsdevel+bounces-75823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHT7H+KmemnF8wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:16:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E753DAA2FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 934D43019477
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1551F63D9;
	Thu, 29 Jan 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjWn/THU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A92AD0C;
	Thu, 29 Jan 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645788; cv=none; b=S6Mlcc+ChRF99PFbbpctNzB7T9qdDTQjxNkPDdyprnvLDSqRIMeyIr7YaQK5TI3xgDksHhEBZ+UfQJZSFatFFHYCcD7bdhGJPma2SwPV3ou3JZ2ty8gbDRLBLIhDcCqNaHMFLut/BGUigiecf98nKZsUS+q7h1sq9ZCLtFzKehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645788; c=relaxed/simple;
	bh=A4L1PHJtn0Y9ICRSIBIwecIZ/C9ZFW+i+GcXeYj0CRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuC9NchhUr31ORqMxXbPd58W2JzysEBpg2qEWPKYwp9LCQTTuAetAWKnQGhj4BHsZw278pzGHdQ9UOgPx2D2q3EubNZAEweZPhEEUGNMk33mYOq6uHu5nBEZEh6c4ZJxflSkSbb7AS9O5hf9y+cQe77Ddc3CFSGRnwhpsZBKt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjWn/THU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5102C4CEF1;
	Thu, 29 Jan 2026 00:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769645787;
	bh=A4L1PHJtn0Y9ICRSIBIwecIZ/C9ZFW+i+GcXeYj0CRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjWn/THUIDki0UZ44ConeD/NGXMLMIiL7q0V8kSRXAWW6DyDV6MuXZ8Oje6egmslL
	 d30erkw6O5t0TP/JVMIN/9GKMNbB1A284FwxLNyJRqqeyxbDzLm14QAW04KCJJvZ1b
	 1VB7mFHZGW0XZhLUox5z8hPGGkFygxSeWsKVYE/tyPYmsDUlOMxhbze3uOqdYqW095
	 B4jIu6iqaxRbCLkWUl0a1bI9+jveb587ELfk1b9RYvWJrMbLYQYakSKdV6mUl2O3vl
	 qlML7BKs0h+ATm/1kmG7M/AbBbc18CA7jEDiab+7+4F8heZk/UrYJ08iXDIXbssfTR
	 hiRXd4BxHGTHA==
Date: Wed, 28 Jan 2026 16:16:26 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Qing Wang <wangqing7171@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 0/3] name_is_dot* cleanup
Message-ID: <20260129001626.GF2024@quark>
References: <20260128132406.23768-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128132406.23768-1-amir73il@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75823-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E753DAA2FC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:24:03PM +0100, Amir Goldstein wrote:
> Miklos,
> 
> Following the syzbot ovl bug report and a fix by Qing Wang,
> I decided to follow up with a small vfs cleanup of some
> open coded version of checking "." and ".." name in readdir.
> 
> The fix patch is applied at the start of this cleanup series to allow
> for easy backporting, but it is not an urgent fix so I don't think
> there is a need to fast track it.
> 
> Christian,
> 
> I am assuming that you would want to take the vfs cleanup
> via your tree, so might as well take the ovl adjacent patches
> with it.
> 
> If you want me to drive this entire series via ovl tree, please
> ack the vfs cleanup patch.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-unionfs/20260127105248.1485922-1-wangqing7171@gmail.com/
> 
> Amir Goldstein (2):
>   fs: add helpers name_is_dot{,dot,_dotdot}
>   ovl: use name_is_dot* helpers in readdir code
> 
> Qing Wang (1):
>   ovl: Fix uninit-value in ovl_fill_real

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

