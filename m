Return-Path: <linux-fsdevel+bounces-79259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHQgFzAEp2k7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:54:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E021F3046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A465B3015B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31E492507;
	Tue,  3 Mar 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxqY85br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8089492520
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553260; cv=none; b=lm1GCsuOgPW3C9PJ81SzFkfgDZ5JxmfiiXJ+sQeQEsOUxUJk8e4iSxksIK5MYvg8Gv6SQnpSldG4cohpBm0WoklRjYBKg+Ey3n6RfN6D0XHK8dBeQ327/uur6nhzlLjpWseD3/uVvf6wp8/8mOKEqcpdlay/9PXyXJ7p+7sIchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553260; c=relaxed/simple;
	bh=7Csp+KecJs5xE7uneLNyrOL/WiLvB1IKlhAVaz2x72w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tsQt1DhzOC+L2b8AubIOE6aDM3DLIGhc0ZDL34ddghQCkxGI1ZBi4Cz6NxUtxhFON0SyqCOiNVXwiByDjfU0xqaIskxzc/hJ4rEqEacadENoDTsP34eRaSxkGGZm7UVLhfqG7fMA5xzBK0M+e1y+KyoroWbxvfi1ib+IyDQsPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxqY85br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40440C116C6;
	Tue,  3 Mar 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772553259;
	bh=7Csp+KecJs5xE7uneLNyrOL/WiLvB1IKlhAVaz2x72w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QxqY85brKDfk30GnV/hv71WZPAfsJ6D/Gn/IguRfS1UT3rYhOKoYSU5dPiKnKRBj1
	 KHKKBb1NnvtN2QBsvgHtdgicDE7WYHhERn3lwfC39IosuY5zBl+wFNaR6bdy2sHv0t
	 KjeXkAsbX/J5rO+m0U7LkWAskwrJFAc3QND6OvsZw/iwMwVGQ9txDRgMLGygDp2XcB
	 Ps+0lJaw7dxnz7TMt6n0sUOJIM5fioHx8bW3UB+33vE85xmAfDX3n/fPQzoO+BSESM
	 m/ZqXNlRM6Vpm9iCFFD0y6WuBjtkCohEtHxCTQ2UqobQu3iXnfPN6OBsq+dLKUR84D
	 yTfrBb0KJepWA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2780BF40068;
	Tue,  3 Mar 2026 10:54:18 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 03 Mar 2026 10:54:18 -0500
X-ME-Sender: <xms:KgSnaU8DvfFLFwOH8ah_7pRv5Ys73nzEdY5lKLlNjW_LAII6JrFaLQ>
    <xme:KgSnaXg21ijQV60t6RzN2u-XttkstvmLZIKpjAEszJVYGTENio2oxCTUa258DuwAI
    t1JGitiv-pWjZwTtQ4kVeADle7K9iwFNpv_X9m1lYmMFgDv0BmreQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprh
    gtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KgSnaedrdCcmhV1LUkkMx-4I3WAQvErU51UbD3yqlicA9rRXzgXn-Q>
    <xmx:KgSnaUN5LxGvb46M2urvAqkYVeIGZrDUo6rcZu5bhp8k1s6FPUIe-w>
    <xmx:KgSnaRsksF4awmcEZnpYv4ekiqfiUw9YaGyQqO7-3hkvrbuvtxdInA>
    <xmx:KgSnadCBB3dxZ75J9uK0yGdim0pc2Ipw1L-3LP1Rnjcxnrz15YcNhA>
    <xmx:KgSnaYb6sP_1r_-rG08njHjG8mFsjwtEeZ6ur7oiJ-DmkYF544ZBRl9c>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0063E780070; Tue,  3 Mar 2026 10:54:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aj7RBWB7jqYs
Date: Tue, 03 Mar 2026 10:53:57 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Paolo Abeni" <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>,
 "Network Development" <netdev@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <4e3afa53-8c24-46b8-8dc8-876784a3ef80@app.fastmail.com>
In-Reply-To: 
 <CAF6piCKbxHF7DASK47-q3DFdtKgvheAGdLUaTwYsfg3ikZAi-w@mail.gmail.com>
References: 
 <CAF6piCKbxHF7DASK47-q3DFdtKgvheAGdLUaTwYsfg3ikZAi-w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: datagram: Bypass usercopy checks for kernel
 iterators
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 01E021F3046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79259-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Tue, Mar 3, 2026, at 4:42 AM, Paolo Abeni wrote:
> On 2/25/26 5:25 PM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Profiling NFSD under an iozone workload showed that hardened
>> usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
>> These checks validate memory regions during copies, but provide no
>> security benefit when both source (skb data) and destination (kernel
>> pages in BVEC/KVEC iterators) reside in kernel address space.
>
> Are you sure? AFAICS:
>
> size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
> {
>         if (check_copy_size(addr, bytes, false))
>                 return _copy_from_iter(addr, bytes, i);
>
> calls check_copy_size() on the source address, and the latter:
>
> static __always_inline __must_check bool
> check_copy_size(const void *addr, size_t bytes, bool is_source)
> {
>         int sz = __builtin_object_size(addr, 0);
>         if (unlikely(sz >= 0 && sz < bytes)) {
>         if (!__builtin_constant_p(bytes))
>                         copy_overflow(sz, bytes);
>                 else if (is_source)$
>                         __bad_copy_from();
>                 else
>                         __bad_copy_to();
>                 return false;
>         }
>         if (WARN_ON_ONCE(bytes > INT_MAX))
>                 return false;
>
> Validates vs overflow regardless of the source address being in kernel
> space or user-space.
>
> FTR, I also observe a relevant overhead in check_copy_size(), especially
> for oldish CPUs.
>
> /P

Paolo, thanks for the review. I'll post a refreshed patch shortly that
attempts to address your comments, and that modifies the common helper,
as Jakub suggested earlier.


-- 
Chuck Lever

