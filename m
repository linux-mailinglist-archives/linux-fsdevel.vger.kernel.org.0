Return-Path: <linux-fsdevel+bounces-77689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH9KEf/DlmnjmAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:04:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D177415CE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A470C301FC8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5033345A;
	Thu, 19 Feb 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2sPzez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509D1C84A0;
	Thu, 19 Feb 2026 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488252; cv=none; b=rIF55jSgW7Sy04ggixUdF5KP6quI+5txn3dPm6MyjJds4b8K4+nTrSsR6R1asfoFfYr6AdZJZr7jDQt0yPuIHFNj5TWvS9XjP78IRVV0HTdIxQDUyeRTvSK78BOX57tdP+oNyj2IzSio+RRuhbeK1EPR/pa7JI7rxCOBnmrb5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488252; c=relaxed/simple;
	bh=NVUYtecCF9wa3MX9UqJyTg7zs3yFZ9hMZXbz8g0TbvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU1JU7NJaU7rwSS7JV15GVC0KV0gztwM28bk5shRDUWdiYTzfRDY9iBzjoV7ptuNcaSkovNuwojXnDOgnMmeI1vWtipVmHA3ZgkPgwguXYi3hVIZTZpYn9jWM/ZTSpYwyigO9zfijtCrQYGqkPZsvH7CZ4ec/JaXzCylhQniuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2sPzez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B7FC4CEF7;
	Thu, 19 Feb 2026 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771488251;
	bh=NVUYtecCF9wa3MX9UqJyTg7zs3yFZ9hMZXbz8g0TbvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL2sPzezBV9TvE+WeD1Va1G8PzSLyf3eJTEDj2N2K8xN9h7P6vp6hswsXedNo/Uht
	 RpjhNrbEiwCK+Eq3886Qt8onTZAJcEK/TGnFLTsV92v9417/RQjW8Js8fIjOKVr7t6
	 CARAFG24Fr3rKJimUmK4JlXZFBAqjrV6VLAD0a5GZbEvhsjOT4WzXRqGMr1fL1RW1A
	 1gQoXUsoXWii1TgQFqp1JhjzHYLpa+H4jaed/8jKm327O49E3uSpcAj3/XsvT0I7z/
	 zHkKYgbMgfp8LCjvvOGjQmZeTFpJ9v8aNB/gTwEU/zLFNN1kAIeK7YNI2bg2zM83Mt
	 8Fm0PMHuKpyiQ==
Date: Thu, 19 Feb 2026 09:04:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Tom Spink <tspink@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
Message-ID: <20260219-galaxie-sensibel-b6d27e60d524@brauner>
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
 <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
 <aZakzr_QAY6a-dlB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZakzr_QAY6a-dlB@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77689-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,gmail.com,vger.kernel.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D177415CE85
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:51:10PM -0800, Christoph Hellwig wrote:
> I'm not sure what replying to an 18 year old thread that's been paged
> out of everyones memory is supposed to intend?

I'm so confused. This showed up top of the batch of mails from the
mailing list for me locally yesterday.

