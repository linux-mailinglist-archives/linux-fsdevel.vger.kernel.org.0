Return-Path: <linux-fsdevel+bounces-77538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCEVGLtllWmOQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:09:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E5D15390A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89875301DAF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAA30C373;
	Wed, 18 Feb 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDHuZRUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E938194C95;
	Wed, 18 Feb 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398574; cv=none; b=Ti7kcvHvgNg4hcpCLaVV1n8H6IWkcJe2brpyBQwu5v0YV+XaTazCij03SZ6MCsKxdbf/iZJRN3zXxSdzV/OrqoxXFzVBtprJV6JY99qtRMfbMnLof/YevobVNr8bz+VnJAtEOdN9Lc9A8zL971ub56bEfTyN9NJF8Qatk80sUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398574; c=relaxed/simple;
	bh=E+JXX/D7nVzCbXMojQr2+ZsL9vr1MB+pmBhAmWQe0k8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=o99xO4lLDVQItMCN403VnqBEFAbH/0VwFEmPbe9Ey8jfEeK7mQLXGte+tmUbnNTsSD108GmQOS8zozwpjZUMe40ISR4vPdr7dXYaCoHZC87I18iKT79qRivEUrTH8hTapLnNeRTmhgNDIQf/EgRLng9CGdos9FsU1eHSCNbcJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDHuZRUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BAAC19421;
	Wed, 18 Feb 2026 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771398574;
	bh=E+JXX/D7nVzCbXMojQr2+ZsL9vr1MB+pmBhAmWQe0k8=;
	h=Date:To:From:Subject:From;
	b=LDHuZRUu6OngjnaydxbpkZ65GQxnOAfkhQO6/chsr3A1tIPlWufr0b1+Y7Ho47hp0
	 CU84Xv58/u9Dz8KmeN3Es/448wrPKHHoODhG4UPNWfCpN0R1O5kdwP/nTSbydocZyx
	 W64Zm3P4v/79C02NVpxZLHnbBh5jLc40so9xaLbJ3YGRYI4RlHMzhz6U33KDg8hofT
	 +nnCDnYd5CuN6ZjVS//p+IFJXqdAVOmmHJObxpIw7o5Q14hLvOwnJaQDVJccjfBSeg
	 aVhJxskiaXZ1QcFtIFoML2Bcu8DjMTFwmwx9n/YUWowbKgHswjmMyFdnpo2Gcw2V4F
	 BRk+idOUs470A==
Message-ID: <924998a5-9786-4868-ba9f-726c4437cd7d@kernel.org>
Date: Wed, 18 Feb 2026 16:09:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Zonar v1.0.0 released
Organization: Western Digital Research
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77538-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 27E5D15390A
X-Rspamd-Action: no action

This is to announce the release of zonar, a graphical tool for monitoring and
inspecting the usage of a file system on a zoned block device. Zonar source code
is hosted on github here:

https://github.com/westerndigitalcorporation/zonar

Zonar currently only supports XFS but we are working toward adding BTRFS support
as well.

Command-line tools like xfs_bmap already allow getting the disk location of file
data extents. Zonar allows the same, but graphically, and for many number of
files and zones at a time, which can greatly facilitate understanding and
visualization of a file system data placement decisions.

-- 
Damien Le Moal
Western Digital Research


