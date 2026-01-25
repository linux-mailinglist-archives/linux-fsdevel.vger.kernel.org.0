Return-Path: <linux-fsdevel+bounces-75373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LXzJtVedWnFEgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 01:07:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F397F503
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 01:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D464F30107C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207CA937;
	Sun, 25 Jan 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zD8l8cdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79710800;
	Sun, 25 Jan 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769299656; cv=none; b=I8C1B4cx9nlVQPlYVNVtVw2XNxg3XgSD68bvvU4jEQxf7ZSbKJ4ahHHEjhGeWIuL9kKlA2Pt1S9EI3wNzd2DcaL9enXfEWFxoOdtQJINOMcAKKQCwdK1sAXDWgXdf0qNJC5U4D2EJEZHGWL5Q1DbWpJxe5g9UuPrXn65o8hTbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769299656; c=relaxed/simple;
	bh=+tOkZl+hajFy2IyHZVk/tQjQOqPGD5xu064kuzDG1fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1lJ4Nmzq2wnsXUbPa8mPKblAxj26R7rV31xfpMTN23pQU4I7Ci0wDKeoIupacDpRIX+2Qsdx2W3PtSd09I+rkDwAlMZh6V1WqQAgL51ydjhp165D0qwdtVOia/gToFeJSDFVO8rGxCnbj+pSiTgzy9AGT+NahNySez+BS+hLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=zD8l8cdF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60P07AD22255121
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 24 Jan 2026 16:07:19 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60P07AD22255121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1769299641;
	bh=G94dzgEw769bp3wZyzddFA+BeL3JlACtdz53VsC6rWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zD8l8cdFdLCx6hk63kn9HwKfv4z0HXRimDqkRQGfuUfpucZnR+idj4WW5eTuz/kTZ
	 HgDcMdxrgRP1iFc59RBNyXbQ+40PFWK1Gtx6RLnvXGArZqKSUFQ2iDX6rXPB7tvYZi
	 M/lsf/3qQiB7pxWvRPZYvgt7fzE1Q33rX8sAVnjkEBSfqefFwaemjnDP9hCjOm0aZp
	 87FVEQwqSiiX9hU7bIGLK+eWgBOD1IM++FIkI+W44ztSQwAf0tKPISnIAN4Y7ovwn8
	 wgUT0ktcmNcar9tDA2ygzUZFLfghZzIvMdK8OFtSt9gTrTJtF6EIvKpdEdsVMhRS8u
	 Bk5+gcdGp83Ug==
Message-ID: <5d8f1f63-879d-483a-b8be-2512794e655d@zytor.com>
Date: Sat, 24 Jan 2026 16:07:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add the ability to mount filesystems during initramfs
 expansion
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, corbet@lwn.net, jack@suse.cz, lennart@poettering.net,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org,
        viro@zeniv.linux.org.uk
References: <20260124003939.426931-1-hpa@zytor.com>
 <20260124174150.974899-1-safinaskar@gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260124174150.974899-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75373-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[zytor.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:email,zytor.com:dkim,zytor.com:mid]
X-Rspamd-Queue-Id: 36F397F503
X-Rspamd-Action: no action

On 2026-01-24 09:41, Askar Safin wrote:
> "H. Peter Anvin" <hpa@zytor.com>:
>> At Plumber's 2024, Lennart Poettering of the systemd project requested
>> the ability to overmount the rootfs with a separate tmpfs before
>> initramfs expansion, so the populated tmpfs can be unmounted.
> 
> This is already solved by [1] and [2]. They are in next.
> 
> [1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
> [2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/
> 

Just to make it clear: unless someone feels there is value in this feature
regardless of the above, there is no need for this patchset.

	-hpa


