Return-Path: <linux-fsdevel+bounces-74158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9338D3317A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 665BE3029F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BE339B39;
	Fri, 16 Jan 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwjBbbAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3FB339870
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576206; cv=none; b=hYZyGBVlr3XNfSX6AjbQ7mzpx8gWApmsinqdJ5BaNHccxE5K/olOUtHixuqHb/bkiW6RxlUXTELA/jD8AWqLW8XZS7Fj9YXItC99WesYhpKHOkvIL5iTAKKrRvM3CNzMOKJ7QZcsaXM51UXojDvHom+muY7Iv6LZUiZ+2wJwPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576206; c=relaxed/simple;
	bh=SefBEYYPE1CC9h9G+k4CAtgolZihts5t+4TEsUNX76I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FidJbuqDK4fJXXtjTyDgnhvvd967f9aFI3ImbseVgauZ6UHvX//GD8J+w0S7as3tWX0nS0it4IccmEoz79LBKmaU0qfrq1dNDnMk7Zl2PKM+PtPj+iT3Jnz4QYteLraF2WErjBslU7elFsStOqjvKiTxSGeaRM/A/FZLJTR7Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwjBbbAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B2C4AF09;
	Fri, 16 Jan 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768576205;
	bh=SefBEYYPE1CC9h9G+k4CAtgolZihts5t+4TEsUNX76I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jwjBbbAx27YfQxuCe7wPmDSb77ZC/T9IigcaxAZ7bWJtJTr3zb6cMh6EsFMZWW5EJ
	 074QEXFZ7jg/SArRvIt8OBMFvOJa4keWfnXmuWR7FNValZmXbJyt+qdP8KQRE02xLz
	 +zY5TiCe2FEPR6vi+YZMYb45gNTmmnSBaT2P8Ruq6WVEjrvxBtxuCj2NRCRBG1IAIu
	 z2TiO4r/0otgGyoIbv7gGsB0HcUD1dR/Oa97spZRJnbwPSxbSBRMZU5zFa3DlKED7f
	 eYkrpV088bOoZRd6nuM59sfN4X6UMcOV5+vigop04MKAwsiceAUAD9pMKqJF9bmT+Z
	 kQ0nqI+RDXJ+g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6E752F4006C;
	Fri, 16 Jan 2026 10:10:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 10:10:04 -0500
X-ME-Sender: <xms:y1RqaeaOF3vOxHQe_T2F9R-7KMYmP62umrgttbsdSy3Q2UKW9KVxIw>
    <xme:y1RqacNPAZ9ZTHIuyJ9c5Ubfu9hRdaqFSizyiWUr6Lv0Cp3N0TTcbXdmXp_1OygbY
    rMfGjLH2jd5gA_BR-_kz3-S1Yn7V3ApX3e7yXFOwyDnTD2kj26EVgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:y1RqaSCN9elmT8ib5nsW7DW8Zd1ausi7uodhbCuaBt_vYIA_HC5Uhw>
    <xmx:y1RqaYVBCdFC-4maS_j0vA2JEDVpt2qQLPJYF0N6Py2rQU8d-MzeVg>
    <xmx:y1RqaQ-du9Z52wYeUbLyZd3B6EPbySSkCYwweCU1c8GfeQv_d4kO_Q>
    <xmx:y1RqaaSWf_trPqiu1iYR5VXye7q8Rw0XoFKfBAB7VIgUlM5JOXCnPg>
    <xmx:zFRqaVQSZRQWoyx7tWIc3R_KZ-b6-aMUmYrHcH2POi1jqhJsxaMjkw56>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 255E4780070; Fri, 16 Jan 2026 10:10:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO3h44zqd9zZ
Date: Fri, 16 Jan 2026 10:09:32 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <3fc1c84e-3f0b-4342-9034-93e7fb441756@app.fastmail.com>
In-Reply-To: <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:59 AM, Jeff Layton wrote:
> On Fri, 2026-01-16 at 09:32 -0500, Benjamin Coddington wrote:
>> Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>> 
>> Expand the netlink server interface to allow the setting of the 128-bit
>> fh_key value to be used as a signing key for filehandles.
>> 
>> Add a file to the nfsd filesystem to set and read the 128-bit key,
>> formatted as a uuid.
>> 
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>>  fs/nfsd/netlink.c                     | 15 +++++
>>  fs/nfsd/netlink.h                     |  1 +
>>  fs/nfsd/netns.h                       |  2 +
>>  fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++++
>>  fs/nfsd/trace.h                       | 19 ++++++
>>  include/uapi/linux/nfsd_netlink.h     |  2 +
>>  7 files changed, 136 insertions(+)
>> 
>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
>> index badb2fe57c98..a467888cfa62 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -81,6 +81,9 @@ attribute-sets:
>>        -
>>          name: min-threads
>>          type: u32
>> +      -
>> +        name: fh-key
>> +        type: binary
>>    -
>>      name: version
>>      attributes:
>> @@ -227,3 +230,12 @@ operations:
>>            attributes:
>>              - mode
>>              - npools
>> +    -
>> +      name: fh-key-set
>> +      doc: set encryption key for filehandles
>> +      attribute-set: server
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - fh-key
>
> Rather than a new netlink operation, I think we might be better served
> with just sending the fh-key down as an optional attribute in the
> "threads" op. It's a per-netns attribute anyway, and the threads
> setting is handled similarly.

Setting the FH key in the threads op seems awkward to me.
Setting a key is optional, but you always set the thread
count to start the server.

Key setting is done once; whereas setting the thread count
can be done many times during operation. It seems like it
would be easy to mistakenly change the key when setting the
thread count.

From a "UI safety" perspective, a separate op makes sense
to me.

What feels a little strange though is where to store the
key? I was thinking in /etc/exports, but that would make
the FH key per-export rather than per-server instance.

That gives a cryptographic benefit, as there would be
more keying material. But maybe it doesn't make a lot of
sense from a UX perspective.

On the other hand, some might like to manage the key by
storing it in a trusted compute module -- systemd has
a facility to extract keys from a TCM.


-- 
Chuck Lever

