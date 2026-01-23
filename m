Return-Path: <linux-fsdevel+bounces-75243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEneGO00c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:44:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F5B72AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 138DA300EBD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C233A718;
	Fri, 23 Jan 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPArbCqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EC3314D9;
	Fri, 23 Jan 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157813; cv=none; b=in0iulEYtlD329HJseFb2g20+7TOohGikM7HjLfYUKvxPOJylGDI7eBX53225JbWzZ7ht07V/685vBzvJFIBRhLD12CH1xzLEvwH9OMD1iWBSwcmBSxnWpn+o8FZMUQ9yyh3bYdX+w/Cztqf9wH+K/PZUntuJ4qrHu+T1a26jOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157813; c=relaxed/simple;
	bh=IjBzeukcuum7qie/wGvJsDRzxzqGbiX2MwG4HT1vpOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL53nwIfWZVYgfL3FV6ZdK7eJPsRhcjLIbjHIM9HfC9L+raMz70UTyjtWoYbcVIG2vm7GtgkQlOsUvUD8DYbyPmvkXQJhI9Un6GKMw8KF9dh/fy5Oti+AD6WdG3Kr+Slm0jGpaBIcsr3bhyiR0yKXeXrA8e5wBY25SK8zmbxuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPArbCqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6337C116D0;
	Fri, 23 Jan 2026 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157812;
	bh=IjBzeukcuum7qie/wGvJsDRzxzqGbiX2MwG4HT1vpOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPArbCqFQV6S6jzffEe6x0Or3TFnRdn/3fz4YpibBhZDda9p91mptWfib3r/Y8qbH
	 OAXKo69MdcX5MZpjfNnS/ebLG5oWTzwZI7G5Uox15zaREF+WuqY9lQIdh0ykF016n8
	 CdzU2Beli1fOQz+KGaqlHonhep+HAXQaOMP2EwwkGoE0NVt1bHoIl5EgyIuO4Qv1tQ
	 lnoF4PjOiOv0vKiAtUj0tprRtsbnfcbO0pgMGlbqqpkuc6++fDU/cB4sm/leccyH5a
	 agm19Rj5oCAONxB9g4h9UAbJDY38NHYazFH2kDEMryrkupDIy6h3ybUxzPAFcd9enL
	 Xic3trAJivnWg==
Message-ID: <f556fdbc-604c-4c5d-b1f5-0f9ca9322e55@kernel.org>
Date: Fri, 23 Jan 2026 19:43:29 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] block: remove bio_release_page
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75243-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2F5B72AC9
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Merge bio_release_page into the only remaining caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

