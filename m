Return-Path: <linux-fsdevel+bounces-73231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87335D12B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8345930086E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EF3587DE;
	Mon, 12 Jan 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="QfwzMLa0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dmi/qDsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C532572F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223613; cv=none; b=roDYx08qojmeaw3IAV5qTnCzJVMHzriVkVd/Gw5huQAYN3Y4Nu9bzVMHQNTFePYsDftKlgk+T2zg+Y36TWfrOFSuxcdgryBVQkzt/3KLzI//0yegV3pgL3vqPuUQTCN/qqx5LxZwVEbR0qEC8Gea/ICNQtlgHvyb3QKLIOgelkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223613; c=relaxed/simple;
	bh=nXyfN0YJsWf17PHE167+q67+AjS0ueOPu4+Hw9nPIl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe2keC+iEB6UYrv6mIiw5h1rXjCnn2sBG5ucIreSrthEC7wSAfMXGA9ERTXzh3r7WNOhbPcqSFc94siv1iz+k9gDp1116+E60bc6YdZv0VC6qFrYn2TwJI/DVZ+spwd15WBUA9rwuK8hGp4bOxF/ARwSPXCwTy4vUG84VyPkPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=QfwzMLa0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dmi/qDsN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 64A8D1D000AF;
	Mon, 12 Jan 2026 08:13:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 08:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768223610;
	 x=1768310010; bh=4rwvIQQ5/xTfEFg3HKGNsbOT2MXXlVC1j87J//yyLgo=; b=
	QfwzMLa06tg9W+DzNE0TXe7cWh5ulGvcDOuaxJFHWklCgr+AJ69kfNbniHlOh0Pe
	eQCXxY29tw7JU0o5s0isofTQkDoEkEUVy1UlzuSs98dNAlHlDVOblbH9cL3rkHHb
	v7Np3roIoHQ5dbbcbW/Bh+hwHIhzQcnKRJznSHO+EKtZiXf03rbhM9paCgexqXUb
	pZQqwb8DxLL99AtwBnWgcbIgczz3J15ICCrWnybE7xqOeyQB4MPNDBO+NKRkhmTO
	oQbIIyZo7D05znuRvJRaRlEIRcvEuKNAZ6xHp1Q0FSIgod37Vdq/7HOA40QZxJrP
	JrAkLJdWQbInigd+EEd1pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768223610; x=
	1768310010; bh=4rwvIQQ5/xTfEFg3HKGNsbOT2MXXlVC1j87J//yyLgo=; b=D
	mi/qDsNx5EKCb3rArqTLnIF0jTwBi908rkoOwcpVxeErKqH4eQJstFXXvoKehTOA
	F77A85KrPrj+iUx5CvptiziTbbOiU02TvhVTm4OKYSyC8GOB/6h1Aj/8SFietaqQ
	BpPywAs9Zr5XLYJCpbgx9HcINUW+b4gE2C0FZFM6pXgdR6mcvADFIZUhOZU9pqTZ
	azbhfKSlwx/ixyZRMkaVA3NPBd0crbcH/qYjYmaLFl8Oy/E+n+jmTyNS9nfj24v/
	1DODNfGiUhByhaF//Y0afcqupv0g7wkQwQnzgL0yA2BUvOpI5GKwM+f77cRdMe5J
	r6/jQVt/8JUFn9V1Upmrw==
X-ME-Sender: <xms:efNkaUGP5TPYnFPL5uF10PWo7PMe8TZ8NHdaeckXt8-udujTAkv67w>
    <xme:efNkaf5EEvgg6gOZJB7GDt30oDLfVatZLrw_rTKbrTnVd1xTLQ3NrrslZzLGMka3Q
    llQR4R5irODhj7P_IjZV8lLkQv71bUHgZio9V4GcN11QzJS23k>
X-ME-Received: <xmr:efNkaRxpCW-i6N1S1mPZhFSk6StE6OD6PArhxcovvvDI2g4EqxwyWASDFDVyiJMQuOZ_r7TR-Ymt7dDTedUx8xv_JMuRD7GO35mcGO46gAmZHTJcLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhorghnnhgvlhhk
    ohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepuggrvhhiug
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:efNkaWOezfbZ8dDQLwJEloiyZBxs_Fs2QG4POHgbmy-BGiN0aW_kAA>
    <xmx:efNkafmRnTA9AGwQuOzf8sIov9IO1tNZtH329-iwcR1-0dmD0VBdnw>
    <xmx:efNkaTSTatWm8vSigtFwQ_kkgs6jlgtJf_nAKvjuedW550Y_z1hYKw>
    <xmx:efNkaWVhmDPPxvOiGg7L7ijd4yoIbjrWmulHoSNG2AikfIXP-b2wSQ>
    <xmx:evNkae2SfykxKeGIRWfNYlICVLEweHw5TlawPZCD2VXfT2eMq9F_basG>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:13:28 -0500 (EST)
Message-ID: <fc67afac-2345-43bf-a67e-c36f2d9f04c3@bsbernd.com>
Date: Mon, 12 Jan 2026 14:13:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: __folio_end_writeback() lockdep issue
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
 <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
 <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 14:06, Jan Kara wrote:
> On Sat 10-01-26 16:30:28, Matthew Wilcox wrote:
>> On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
>>> [  872.499480]  Possible interrupt unsafe locking scenario:
>>> [  872.499480] 
>>> [  872.500326]        CPU0                    CPU1
>>> [  872.500906]        ----                    ----
>>> [  872.501464]   lock(&p->sequence);
>>> [  872.501923]                                local_irq_disable();
>>> [  872.502615]                                lock(&xa->xa_lock#4);
>>> [  872.503327]                                lock(&p->sequence);
>>> [  872.504116]   <Interrupt>
>>> [  872.504513]     lock(&xa->xa_lock#4);
>>>
>>>
>>> Which is introduced by commit 2841808f35ee for all file systems. 
>>> The should be rather generic - I shouldn't be the only one seeing
>>> it?
>>
>> Oh wow, 2841808f35ee has a very confusing commit message.  It implies
>> that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
>> means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
>> all filesystems do use this code path and therefore the flag can be
>> removed.  And that matches the code change.
>>
>> So you should be able to reproduce this problem with commit 494d2f508883
>> as well?
>>
>> That tells me that this is something fuse-specific.  Other filesystems
>> aren't seeing this.  Wonder why ...
>>
>> __wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
>> that spot since 2015 or earlier.  
>>
>> The sequence lock itself is taken inside fprop_new_period() called from
>> writeout_period() which has been there since 2012, so that's not it.
>>
>> Looking at fprop_new_period() is more interesting.  Commit a91befde3503
>> removed an earlier call to local_irq_save().  It was then replaced with
>> preempt_disable() in 9458e0a78c45 but maybe removing it was just
>> erroneous?
>>
>> Anyway, that was 2022, so it doesn't answer "why is this only showing up
>> now and only for fuse?"  But maybe replacing the preempt-disable with
>> irq-disable in fprop_new_period() is the right solution, regardless.
> 
> So I don't have a great explanation why it is showing up only now and only
> for FUSE. It seems the fprop code is unsafe wrt interrupts because
> fprop_new_period() grabs
> 
>         write_seqcount_begin(&p->sequence);
> 
> and if IO completion interrupt on this CPU comes while p->sequence is odd,
> the call to
> 
> 	read_seqcount_begin(&p->sequence);
> 
> in __folio_end_writeback() -> __wb_writeout_add() -> wb_domain_writeout_add()
> -> __fprop_add_percpu_max() -> fprop_fraction_percpu() will loop
> indefinitely. *However* this isn't in fact possible because
> fprop_new_period() is only called from a timer code and thus in softirq
> context and thus IO completion softirq cannot really preempt it.
> 
> But for the same reason I don't think what lockdep complains about is
> really possible because xa_lock gets only used from IO completion softirq as
> well. Or can we really acquire it from some hard irq context? Based on
> lockdep report at least lockdep things IO completion runs in hardirq
> context but then I don't see why we're not seeing complaints like this all
> the time and even deadlocks I've described above. I guess I'll have to do
> some experimentation to refresh how these things behave these days...
> 
> 								Honza

Is there anything that speaks about the patch I had posted?
__wb_writeout_add() doesn't need the xa lock?


Thanks,
Bernd

