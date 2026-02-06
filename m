Return-Path: <linux-fsdevel+bounces-76628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKCOJGc5hmmcLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:56:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F310250F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A44C304970A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0B3B8BA5;
	Fri,  6 Feb 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Csw0BfHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78311426D22
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404099; cv=none; b=cLifn+HQK73RWxYznjH+Jl487+VdMefBJnaQdkCYO1fwv7T8X2bWjl4S5vao9fnB0hPlhiatPeiQliMWP0UBewDaBJ/WbUB/Q67wDdswzwxH41/4PGhFWXLsdHhnnGrZJD5GCjbkXZpm/kR37qjvAcDwopj07+Vf2shABbuPbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404099; c=relaxed/simple;
	bh=hKCxXArb5MmLDQXsH2llw87ui4iuwN50i4e3U/xLpO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOhAFxxP/MKb9STiaeLS1/OXO7UqwQVdr+EB3NN8AMOIsX5XYgFfr/8IXAjX/rUqYyG00M0inAcQNHsyx/0tF03cQjVhWpVfnyO8bLRe6CBMhJlVSDI+/RYZ+J3Hi6tnqqhb3ImQHwiPrOWyvARPcs9m4Ol6zPS3qRUSkVgbBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Csw0BfHw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37e584d1-1256-46ad-9ddf-0c4b8186db08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZnCvjkBOiI3vs/EIfb+uZh3BeeEsDL1JmDGkWIqg1o=;
	b=Csw0BfHwNtQYzpRzS2SLNyiBhnOcCmi+9MqjruxtOErCUmSpv+5nI8Wqvjfmxo0p73K8Th
	WlQb0hu7T8LQsUcEB6rqVlCBlu3DP+Ch9VYGx3iYsCgV8xbKVE5KufCLNOFGmnKz6Th8pn
	WchHdPO4aCKbv7JyMB1U5jG1ltqdVNA=
Date: Fri, 6 Feb 2026 19:54:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
 <tq3nyswm72gackesz6v476qqvin5eaa67f4hf6lg52exzv7k7p@tczjh5n777tc>
 <20260206174742.GI7693@frogsfrogsfrogs>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pankaj Raghav <pankaj.raghav@linux.dev>
In-Reply-To: <20260206174742.GI7693@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76628-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E1F310250F
X-Rspamd-Action: no action



On 2/6/26 18:47, Darrick J. Wong wrote:
> On Fri, Feb 06, 2026 at 02:07:56PM +0100, Pankaj Raghav (Samsung) wrote:
>>> +static DEFINE_SPINLOCK(xfs_healthmon_lock);
>>> +
>>> +/* Grab a reference to the healthmon object for a given mount, if any. */
>>> +static struct xfs_healthmon *
>>> +xfs_healthmon_get(
>>> +	struct xfs_mount		*mp)
>>> +{
>>> +	struct xfs_healthmon		*hm;
>>> +
>>> +	rcu_read_lock();
>>> +	hm = mp->m_healthmon;
>>
>> Nit: Should we do a READ_ONCE(mp->m_healthmon) here to avoid any
>> compiler tricks that can result in an undefined behaviour? I am not sure
>> if I am being paranoid here.
> 
> Compiler tricks?  We've taken the rcu read lock, which adds an
> optimization barrier so that the mp->m_healthmon access can't be
> reordered before the rcu_read_lock.  I'm not sure if that answers your
> question.
> 

This answers. So this is my understanding: RCU guarantees that we get a valid
object (actual data of m_healthmon) but does not guarantee the compiler will not reread
the pointer between checking if hm is !NULL and accessing the pointer as we are doing it
lockless.

So just a barrier() call in rcu_read_lock is enough to make sure this doesn't happen and probably
adding a READ_ONCE() is not needed?

--
Pankaj

