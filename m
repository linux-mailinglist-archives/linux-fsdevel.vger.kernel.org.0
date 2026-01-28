Return-Path: <linux-fsdevel+bounces-75726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uApoB3kgemmv2wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:43:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA9BA302D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F54A301584B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C33612FC;
	Wed, 28 Jan 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XArbwGGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32F274670;
	Wed, 28 Jan 2026 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611310; cv=none; b=NT5inurKiKdWEg29TCAaWlTc1h2fzVCETsd1AfGfMozR0fRRL6k+0Ncq2eibwqjeWA8z00Co/clLYiWq/XF955sra+keE8Fr6BSVkZPobIv0huV+76C1LsMAZoCfDjQioTccq+CCLEXRcwqOsrpzQ8JViEjtg4lyEZ5BIh1VV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611310; c=relaxed/simple;
	bh=eaglsE8/gh41Pv/4uZDqiEy1NKc+8kx3Y5GXq4lMU/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJQSXA/TgiWDtNtQO4Op2UGMOIg3+IpLusZFD+UUbBhUlcTnWoAyJ20PoYeJjDYjyaCA96uJCCbTTzM9CvBeGMhQK/3jhTdQHwvvz2kI1kE3zV60YdvbCSv3YucXteFWNF/s4G3nKHc3MhxtOV7Ci4S/s/pONGamIe2KBb+a110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XArbwGGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC324C4CEF1;
	Wed, 28 Jan 2026 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769611309;
	bh=eaglsE8/gh41Pv/4uZDqiEy1NKc+8kx3Y5GXq4lMU/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XArbwGGsJ6ShSlGxbPiN1HzTvjw9CLByogKuzIH0DDgj2SltlXZEnbNeCcZ6fsDSU
	 aGlYNj9zDLfec/bHwHEm2/yWrg0c5oaTMVuLiEEfzQYMy/qSuiTZP+Z0QZsBhdGJq8
	 hgcbjqGdD2+5pvd8JGTVW63ud582Lar0oP1kI2BbXxgYbIXE+p9sG87IKmIsa736rx
	 cQpcTd7e9XMFJKpP8wfQ/zNfLkCXM8rtr1X3bqiH82xVCss5vN95E27LtGzIgBhulB
	 rYWBSu4/gqRzTRSp85N29q/u6kYkG6oeFfiQAfmXnbpEZ0Ry53GtDumzHAf3gadvQC
	 jxIbk8OXPtBQQ==
Message-ID: <041a37d8-c114-4ac0-875d-022e9d07aac8@kernel.org>
Date: Wed, 28 Jan 2026 09:41:37 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Trond Myklebust <trondmy@kernel.org>, NeilBrown <neil@brown.name>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
 <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
 <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
 <33c02e5a-03e7-42ef-8ccd-790a9b29a763@kernel.org>
 <D3263C1D-A15E-48EC-B05A-8DC6A0C2B37A@hammerspace.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <D3263C1D-A15E-48EC-B05A-8DC6A0C2B37A@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75726-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAA9BA302D
X-Rspamd-Action: no action

On 1/26/26 1:22 PM, Benjamin Coddington wrote:
> On 24 Jan 2026, at 14:48, Chuck Lever wrote:
> 
>> I can't recall if Wireshark is smart enough to introspect Linux NFSD
>> file handles (I thought it could). It would be sensible to have some
>> Wireshark update code in hand before making the final decision about
>> keeping the new auth_type.
> 
> I've gone digging and wireshark has a surprising amount of filehandle
> dissection code - it currently can "Decode As:"
> 
> dissect_fhandle_data_SVR4
> dissect_fhandle_data_LINUX_KNFSD_LE
> dissect_fhandle_data_LINUX_NFSD_LE
> dissect_fhandle_data_NETAPP
> dissect_fhandle_data_NETAPP_V4
> dissect_fhandle_data_NETAPP_GX_v3
> dissect_fhandle_data_LINUX_KNFSD_NEW
> dissect_fhandle_data_GLUSTER
> dissect_fhandle_data_DCACHE
> dissect_fhandle_data_PRIMARY_DATA
> dissect_fhandle_data_CELERRA_VNX
> dissect_fhandle_data_unknown
> 
> .. almost all with finer grained filehandle components.  I certainly can add
> patches to parse FH_AT_MAC for the linux(s) decoders, but I admit I don't
> have any use case.
> 
> I'm completely neutral on keeping FH_AT_MAC at this point.

If we can't find a use case or need for something, the usual practice is
to remove it from your patches until we have one.

Is anyone working on Wireshark patches to handle signed Linux file
handles in some kind of sensible way?


-- 
Chuck Lever

