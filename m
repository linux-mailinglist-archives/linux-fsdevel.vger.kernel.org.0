Return-Path: <linux-fsdevel+bounces-76746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJp+Lv01imm0IQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:31:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A371141D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 393DC3026C02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EE423A6A;
	Mon,  9 Feb 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe/57tgw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115938759B;
	Mon,  9 Feb 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665449; cv=none; b=gAhk6w5l2vUfHNSBEGIffAcMkRI7r5qseKLdWqsLNK5V473/cGcSLGs43yeIz9gKm1Juzg/vy2hhPzjwkBWZzsImOZcBODJUFIaMTEVIX24SV+igAmDIe+ie6N5NknA7aNabj6AG9JAFzMif7hblQ5sGW2xf9KiYpOrdArQC0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665449; c=relaxed/simple;
	bh=zrJUCHukbfzP557UANU8l3FaP7bX7yDd2ON1I8n/hmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKrX8P7YF+CgoQYOYH50RAP1z+XR+8f5TWEOeQ/9aNojBNwoncDsL4KyBUxecOwMwSCY+foyUFQwccxB/6Zjx3OSAhxH2FRt5HHdXJ5NdbPXq8lR9d7frS1c9lQyfeXV9oIFtzLUMM/g5QoawZsSuWlESDY3NrgmbL7cU7Pl+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe/57tgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB629C116C6;
	Mon,  9 Feb 2026 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770665448;
	bh=zrJUCHukbfzP557UANU8l3FaP7bX7yDd2ON1I8n/hmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qe/57tgwfFP66I8oSPSWM+4H+o7kzbimhIlnmPROULjzNkOGjGRNaueaWJZ3vdpbp
	 wJgtw+ECH1g48fEJUkfA5QVNYEQwYg1NRK+OzyYkmYFkyWBWwaOgJENDubeW5Ms5Ah
	 OL8UlpY3OXvX7O71wQbcPB543ybz0wNQSNVJfrXHvgsrR/DKOPrpamD6vr2D+i5dsI
	 jmFQNM2M6mnrr+4dCMnsQRAxauJaeaySISx3BrqNWq5rHiWffT47ftdBOzdAf250iE
	 NLZSyexIQtzO8CKVyPtcca/spPVn3/qlmf9p+uVbHe5uiQ5oUa60kDvrQRu62IAz7W
	 i58VmSprDDcKQ==
Message-ID: <e2a7dd77-246d-4af5-a30b-ba726951ff84@kernel.org>
Date: Mon, 9 Feb 2026 14:30:46 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
 Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260207060940.2234728-1-dai.ngo@oracle.com>
 <ebcb1893-bf03-4637-bf0c-918eb42705bd@app.fastmail.com>
 <e66142e7-ae6e-4d4a-b2fd-2507d2948f77@oracle.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <e66142e7-ae6e-4d4a-b2fd-2507d2948f77@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76746-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24A371141D8
X-Rspamd-Action: no action

On 2/9/26 2:24 PM, Dai Ngo wrote:
>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>> index ad7af8cfcf1f..c02b3219ebeb 100644
>>> --- a/fs/nfsd/nfs4layouts.c
>>> +++ b/fs/nfsd/nfs4layouts.c
>>> @@ -27,6 +27,25 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>>>   static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops;
>>>
>>> +/*
>>> + * By default, if the server fails to fence a client, it retries the
>>> fencing
>>> + * operation indefinitely to prevent data corruption. The admin
>>> needs to take
>>> + * the following actions to restore access to the file for other
>>> clients:
>>> + *
>>> + *    . shutdown or power off the client being fenced.
>>> + *    . manually expire the client to release all its state on the
>>> server;
>>> + *      echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
>> Has there been any testing that shows expiring that client actually
>> breaks the fence retry loop below?
> 
> nfsd4_revoke_states calls nfsd4_close_layout to remove all file leases.
> I manually tested it.

Excellent!

-- 
Chuck Lever

