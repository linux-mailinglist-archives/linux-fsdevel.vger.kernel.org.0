Return-Path: <linux-fsdevel+bounces-20933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D288FAEE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B67287D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA12143C5C;
	Tue,  4 Jun 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="SOeEetZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bths4Dil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE713B29F;
	Tue,  4 Jun 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493559; cv=none; b=Xxnhh1UM2tHbHgQNs3MWJjIhkxBKJ9HKCbmlEgA4S4vr5YAxbzlGdarcHhFsNyfGQCmP1XijedzBocmAYuPVdU92y75NWGGZFQcvSYRJcojgcCzx/weKOn8p3J7cnJEoSSkJkitoQPWUALfV467V6EToTKYpuzxr5i5+eyOUndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493559; c=relaxed/simple;
	bh=jHGksYsJhYFfvI7ABd+r/8I0l8LU2B9ZPQDS7hvB+d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtq/g0nEakT8OXSluCuJfO0mrOoirQVzvzLYQ6rp8JCrjkoLrrQg81NSAK9s/u0nEx4M/R3wOYywzVfdY61tmb77xskSeqZMemw2gMCnbuP5RzgY+uJxvU7QPjgVqvPOhq36+ubJ0qJRL8584BPsv+V1ORqsqex73Z5/nch1e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=SOeEetZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bths4Dil; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A00D11380118;
	Tue,  4 Jun 2024 05:32:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 05:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717493556;
	 x=1717579956; bh=Z/p/FhNJ0mP2yG98DTjrbvV/ibnqnwF1h5OakqDfidw=; b=
	SOeEetZh0Ow/keZ1Ik1aO0oSKhs+/s4Kw/VEx4YcD/SmVXSWLDOY76xpjfP9WJlI
	RQDosdFOlCnE6boiapTohMGYH+X6vwr3CGDMraPUZlmuBw7NHwK1MvtxilAk4/ia
	OzggNKn46Ah+LsOQjzMdKxuEm4VuMsYkxjodEAtEp7J4BYSG+uAWT8CAdn0ysnCZ
	Ic8yXAthhRuOu7y+c99QUiBvQ5pbl7rkZSKprDmW9mgqx9MkLzt+4KCjV0f0HJJi
	pypGuHNJ+Aapql6o6sfrax0/UhrvywLdRI3VM1LaVhHxFIBqSjlU6smyWAxt+rZB
	1NfPVftFM5lz0nvOGfStww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717493556; x=
	1717579956; bh=Z/p/FhNJ0mP2yG98DTjrbvV/ibnqnwF1h5OakqDfidw=; b=b
	ths4DilJb7/VHsQJgh3N5g0pO5MmvqdZ4Y+PbEWZf7Lg7H2stEYHv8NAjztb5PIS
	nAwfw6HvDoxFQ21bkzqSntl+Z7RyhW+J8k70zgsUpRa3NNm/gncZhzL13N+czJID
	Jf2pba+9AkXuCUZzfAm7nvMbyEdWAJ9PwkoCw/oFxkomH0tdwajfNl7GvfXa4Zfs
	vMzIGDIqWHPY1islMfyBzKuc7mlLIyjNLWdsCzfCEkPzEXHIi2FYnIchPEu3D14f
	Jw/0hYACvkWjC0Ep/STKlnpsn/b8XMPDZoYzNPaV+Ecig2sWisrP8ZKTts1vC/zQ
	65FVrkeapHJFswq6Wi36Q==
X-ME-Sender: <xms:M99eZvDrd6sSVAux9LM1F5XTfi-EPTSOMLEoFnCQqAb3RvThr0U-uA>
    <xme:M99eZlgxP6nJufSxJmBj0YYdoLWIp0o5ef8B41iSwYxpjNQ45XKi5TY4DmZTx6_SR
    P5cmeXibx95O4cr>
X-ME-Received: <xmr:M99eZqlqvZpiLSyBLj9xoudHIFF_bdAzuPM2xpfZiFCgsNTq-TVVH73kGjnFo-7MtlfmFhzi1kTpEgq6wUOMZKvBDYKuhEFGLL1wCVlgpjUPttclhFBN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:M99eZhysKTeafxadrlqV5SZUXbRB9rdvk33BMpKc13xJtebLcRhPSQ>
    <xmx:M99eZkQ0cxv3w7adHqAj1c9iK0k1Ns8aojG3SLh5fB26X4PCY5TQrg>
    <xmx:M99eZkb1mNgg-oZB0ak_ycqWsHKxMpGZJoy5IxgU0aR2raxeUIDKhw>
    <xmx:M99eZlTkoujd1Ou56DwzOhnyo91-sJzcEKMK4nN080OLBpTF-19xnQ>
    <xmx:NN9eZpTBt8XWajG0wq8ADdLj-h7rOt9S2cWY-Oqdjio75KrAAcdhZyHt>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 05:32:34 -0400 (EDT)
Message-ID: <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
Date: Tue, 4 Jun 2024 11:32:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 09:36, Jingbo Xu wrote:
> 
> 
> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>> IIUC, there are two sources that may cause deadlock:
>>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>>> requests, which in turn triggers direct memory reclaim, and FUSE
>>> writeback then - deadlock here
>>
>> Yep, see the folio_wait_writeback() call deep in the guts of direct
>> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
>> happens to be triggered by the writeback in question, then that's a
>> deadlock.
>>
>>> 2) a process that trigfgers direct memory reclaim or calls sync(2) may
>>> hang there forever, if the fuse server is buggyly or malicious and thus
>>> hang there when processing FUSE_WRITE requests
>>
>> Ah, yes, sync(2) is also an interesting case.   We don't want unpriv
>> fuse servers to be able to block sync(2), which means that sync(2)
>> won't actually guarantee a synchronization of fuse's dirty pages.  I
>> don't think there's even a theoretical solution to that, but
>> apparently nobody cares...
> 
> Okay if the temp page design is unavoidable, then I don't know if there
> is any approach (in FUSE or VFS layer) helps page copy offloading.  At
> least we don't want the writeback performance to be limited by the
> single writeback kworker.  This is also the initial attempt of this thread.
> 

Offloading it to another thread is just a workaround, though maybe a
temporary solution.

Back to the background for the copy, so it copies pages to avoid
blocking on memory reclaim. With that allocation it in fact increases
memory pressure even more. Isn't the right solution to mark those pages
as not reclaimable and to avoid blocking on it? Which is what the tmp
pages do, just not in beautiful way.


Thanks,
Bernd

