Return-Path: <linux-fsdevel+bounces-78663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKroALbnoGnVnwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 01:39:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ADE1B1432
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 01:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E520301150E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB025FA05;
	Fri, 27 Feb 2026 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="MhNykkj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928342049
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152752; cv=none; b=McZXekZDdd13RIfqedFoIDQHc2Ts8d/QZqIgKNlJV/b9hLC4Gua1cSRkHwlp6x3OQeRX+MWJfaK/rnBBTQyo/zXYGyHkF3EskSjzPtQqdHwD3I8IrUF3VRsr2xAOq5Tmdmcs077Ct301bJQS5V68KRnW0Sh7ccRavNCQIuQNVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152752; c=relaxed/simple;
	bh=PK3FAzZvqaEyJs8Sx40VKRYx8aTTcB7w5hjWEECIoFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od4cmsM9QVEDdWvqvdbR4qkugLmMkvtXTnSk6rkcB8ROhkbOQ083Ce8Vq3HZ+8p8m0yEk2kqIhhwCi2jBJWUTeAAlrECvl/OjHY97vj9bSCd6uDOAVtcX83FEAKz16NM9+YyqHLowf05Y1bxhSb+tfh1+UYHPBR7yTeuLyrvhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=MhNykkj4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Fri, 27 Feb 2026 00:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1772152747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKI+vi4yaHxTjG6pvYfewwBW9KEqFz+EHZ7SlPGvs84=;
	b=MhNykkj4rsjPKxlpMtH80UpDx50qkzYNi16KHRhIUOJHyiY+X61tlWxokDmFd4uB1Oy7rj
	zmJ+cXin6+Ga0aNMbw2tdLR5k76cupgq4Td0JkXhEK1p/97rNyD+pIYM55T6ag222JBkNz
	fMRDT4XFh4SOd2goB1te6WjMMt/5Jbc60jXJNcv3HSzxVrkjyJ+1o3F9K+m50MRNjK4NRs
	/sw1ivvwgPnmPP7VNEnq9JCd35IOn9gMHH0G7PSQ7XkF1ATbZeszsOABPF7l95k2/MSidv
	2/OBOEqQhUeopWPSyLctnDe+8/kkTX0/7Q7p2RfuqNqaJofRgsoSluWRgC1gIA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <aaDnuqeArrGyAty-@Bertha>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-3-contact@gvernon.com>
 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
 <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
 <aSTuaUFnXzoQeIpv@Bertha>
 <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
 <75fd5e4a-65af-48b1-a739-c9eb04bc72c5@I-love.SAKURA.ne.jp>
 <d1e3e3f6-e0c4-4e70-8759-c8aa273cbe37@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e3e3f6-e0c4-4e70-8759-c8aa273cbe37@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gvernon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gvernon.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78663-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@gvernon.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gvernon.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gvernon.com:dkim]
X-Rspamd-Queue-Id: 01ADE1B1432
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:54:54PM +0900, Tetsuo Handa wrote:
> On 2026/01/06 19:21, Tetsuo Handa wrote:
> > When can we expect next version of this patch?
> 
> I'm testing https://lkml.kernel.org/r/427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp
> in linux-next.git tree since next-20260202, and syzbot did not find problems; ready to send to
> linux.git tree if we need more time before getting next version of your patch.
> 
Thanks for your patience Tetsuo, I've been focussed on work for the past
few months following a change of employer. I will review the most recent
feedback this weekend and respin the patch.

I appreciate your feedback on previous versions of the patch. It will be
good to get this bug finally closed.

Many thanks,

George

