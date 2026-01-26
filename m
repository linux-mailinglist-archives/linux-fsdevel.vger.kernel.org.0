Return-Path: <linux-fsdevel+bounces-75520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NxIN9zAd2nKkgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:30:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC78C90A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F34A30602C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE59284B3E;
	Mon, 26 Jan 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWOYuQ/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A02848BA;
	Mon, 26 Jan 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455724; cv=none; b=skRSR9rj3SInQPqspKVaFPqBFxinuCOTsd9km7H/P+cZz4eVTgf46MJx5LCAFdFnxQWhMmALOnrl4h/od2fvs/+LXdGrE27oCFyEA1mWPjYUqrNqypf8OkkkpIlVQxVe3pXbzybjlGH8iH6O8+ZY7CQRnIZ75c9r+sx5+UbV2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455724; c=relaxed/simple;
	bh=a5nlSLq5FjNV/oB/CZwQOu1pk5mO8lVzfz7DbA8JsHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQUD2guZDP1ZG8ACfZVDiWSYDFDeImJA3HIwQaHRRnecmHAQb9SVCe1w6liXj8rH8TfpfeEfji4vRWVFTltFZqVNbEeEzGuQM6l/wadvUby7z3Pnl3gM5lqt62vVWctcwlRwKFptTfmbTL0hSQivNwE7wjl5ZYYwfWk/WPIBWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWOYuQ/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15803C116C6;
	Mon, 26 Jan 2026 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455724;
	bh=a5nlSLq5FjNV/oB/CZwQOu1pk5mO8lVzfz7DbA8JsHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWOYuQ/Qe0VMqhP0nF0d6USsVsU9gy5OmbjkBpZllADhWnCK3rOvG4MElCAuSofee
	 gQXxp7xfw2R8Sc9HEV+VH2K/GzDl1jv8T/MJbkCNuCNf24244rHWvxa7EwATQDvf2y
	 osoaiZ1L/jPBKZw2z1JBn2+f3P0510k/DXHpLI+79AaEHo5awOHakI2kMHVBAgpBSU
	 Ul7ZSLwxSRzBp+92m8b/Xp8EUch9HuaW49hMVW5UK5ioikAo106+g319fKy3BSFUvw
	 zCZES0UA/LH9NuOck5bfov/wf7XmpruiE0beHvPiFd2IiUbWnPw91eNpwWU5FGeB9j
	 cN0+TOXVD0LOg==
Date: Mon, 26 Jan 2026 11:28:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 0/2] Add traces and file attributes for fs-verity
Message-ID: <20260126192842.GA2305@quark>
References: <20260126115658.27656-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126115658.27656-1-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75520-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44DC78C90A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:56:56PM +0100, Andrey Albershteyn wrote:
> Hi all,
> 
> This two small patches grew from fs-verity XFS patchset. I think they're
> self-contained improvements which could go without XFS implementation.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> 
> v3:
> - Make tracepoints arguments more consistent
> - Make tracepoint messages more consistent
> v2:
> - Update kernel version in the docs to v7.0
> - Move trace point before merkle tree block hash check
> - Update commit message in patch 2
> - Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
> - Fix block index argument in the tree block hash trace point
> 
> Andrey Albershteyn (2):
>   fs: add FS_XFLAG_VERITY for fs-verity files
>   fsverity: add tracepoints

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

Thanks!

- Eric

