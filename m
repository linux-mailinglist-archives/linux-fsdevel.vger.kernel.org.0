Return-Path: <linux-fsdevel+bounces-74173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68ED334D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 322AB302053D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31233BBA2;
	Fri, 16 Jan 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSSgOQ3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6E171CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578344; cv=none; b=gs4sYbBFL/sQPCxGyFD2kEBB+h3lY6Z6Fc3D56NM+rk9zE5D9eUmLwUf0ntM/yjtkASiZbvsxSLqNzx2ER0GwyWv1SarcA6arhCrXZismEAbkqp/5UL7FxpscaK95/MKoJw+skatM04AcjpfjE+OyrO9EHV5AGiSXxa6VIQEExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578344; c=relaxed/simple;
	bh=7WSELKFHp6tnLIgrq6oiFw1FV3UnkL+8iTtluDZR7sc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y6ERGWImFU8xFr5XQJQGM8j1hf2VGL1lCk41HiSd1gyaWltG/gG06cVJRe8U3QN9YCkH9J6mGMGhX81qOvuS9MHyy7QGWrZIY1Z+MRM1CWX2wRA1DQK5wCFk7UM2O8DlpIn7jwL65oy90sPVBdkg+zV+GURO6AjsVLNbBPJuy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSSgOQ3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B733C116C6;
	Fri, 16 Jan 2026 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768578343;
	bh=7WSELKFHp6tnLIgrq6oiFw1FV3UnkL+8iTtluDZR7sc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QSSgOQ3JeC2v7IosnKQ/Yb2tAgxB3y9ACUd1P9FBTOMUeKRcCFkX7M51zJ6e337ZD
	 T52ljzh6OTSGlTthQGpffKs6lrix+MFRyz0T9UTiXneNEOM0mhQXREIq5WzYufgLIE
	 EvXYTjLLXn1sqvlbXenE1L5a2GilW/HgQ2luuaNKZaUt0LrqmTOO2HTZja7Hi2XWnJ
	 aLcr2a2vUEhwvN4I7YqOTiZM0ffawBFpOOgZJlPCllh0fXK9yRO49jlfl3uCVlwLBU
	 jMcibqujO4xwNV/JaECQPnJ/CpYpyQv5iMQh81PM59kd/6cDQddCV4oi4ZJ/fTzpuq
	 9Q5Fl1wYGTYWw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 99274F4006A;
	Fri, 16 Jan 2026 10:45:42 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 10:45:42 -0500
X-ME-Sender: <xms:Jl1qaWlQsV4qT_6BeccNOMPmFTfEcTuv2r3ABSKgznaTTn0TDNchZA>
    <xme:Jl1qaYpmGKprwrgNCgZ2ZBjAkKdnbB8OX-bNfFGuUNTxDYnOscOXhpY1-sS0kJmpG
    jIzf_GK06Au3x97MRhvs4kLFayjmSmh974dRxgOZn2wPgHnuhbp_5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelfeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Jl1qaTvZ2fkMQR-EctfScCxUpZOlxzAFZ1BBrW7TBhBQhD1lf0hz-Q>
    <xmx:Jl1qaQTrgUT5AGU3JahY2fApn2bKeArQgX-SlFCQazROCh8wZPrHPQ>
    <xmx:Jl1qaSLid8wakogek2cXLkN1scoQ53ZK3_GIcvFKbU4BDigWXnnr_w>
    <xmx:Jl1qabsRPOoU3yF-4XpHxHreG1mX5TJLd2dXP-2h2Jx5NSIOPU9Zkg>
    <xmx:Jl1qaR8lcHz4-COH-XVFSj_f3CW8GRCtOkQGWDkZPiyLM2axDLa5aEzf>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7850E780070; Fri, 16 Jan 2026 10:45:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO3h44zqd9zZ
Date: Fri, 16 Jan 2026 10:45:11 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <703f29f8-a9e5-4947-9d93-a3cbde5cbdcc@app.fastmail.com>
In-Reply-To: <3c5af19d8793c34022bde2cb7fcca1855d1ea080.camel@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
 <3fc1c84e-3f0b-4342-9034-93e7fb441756@app.fastmail.com>
 <3c5af19d8793c34022bde2cb7fcca1855d1ea080.camel@kernel.org>
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 10:25 AM, Jeff Layton wrote:
> On Fri, 2026-01-16 at 10:09 -0500, Chuck Lever wrote:
>> 
>> On Fri, Jan 16, 2026, at 9:59 AM, Jeff Layton wrote:
>> > On Fri, 2026-01-16 at 09:32 -0500, Benjamin Coddington wrote:
>> > > Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>> > > 
>> > > Expand the netlink server interface to allow the setting of the 128-bit
>> > > fh_key value to be used as a signing key for filehandles.
>> > > 
>> > > Add a file to the nfsd filesystem to set and read the 128-bit key,
>> > > formatted as a uuid.
>> > > 
>> > > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> > > ---
>> > >  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>> > >  fs/nfsd/netlink.c                     | 15 +++++
>> > >  fs/nfsd/netlink.h                     |  1 +
>> > >  fs/nfsd/netns.h                       |  2 +
>> > >  fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++++
>> > >  fs/nfsd/trace.h                       | 19 ++++++
>> > >  include/uapi/linux/nfsd_netlink.h     |  2 +
>> > >  7 files changed, 136 insertions(+)
>> > > 
>> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
>> > > index badb2fe57c98..a467888cfa62 100644
>> > > --- a/Documentation/netlink/specs/nfsd.yaml
>> > > +++ b/Documentation/netlink/specs/nfsd.yaml
>> > > @@ -81,6 +81,9 @@ attribute-sets:
>> > >        -
>> > >          name: min-threads
>> > >          type: u32
>> > > +      -
>> > > +        name: fh-key
>> > > +        type: binary
>> > >    -
>> > >      name: version
>> > >      attributes:
>> > > @@ -227,3 +230,12 @@ operations:
>> > >            attributes:
>> > >              - mode
>> > >              - npools
>> > > +    -
>> > > +      name: fh-key-set
>> > > +      doc: set encryption key for filehandles
>> > > +      attribute-set: server
>> > > +      flags: [admin-perm]
>> > > +      do:
>> > > +        request:
>> > > +          attributes:
>> > > +            - fh-key
>> > 
>> > Rather than a new netlink operation, I think we might be better served
>> > with just sending the fh-key down as an optional attribute in the
>> > "threads" op. It's a per-netns attribute anyway, and the threads
>> > setting is handled similarly.
>> 
>> Setting the FH key in the threads op seems awkward to me.
>> Setting a key is optional, but you always set the thread
>> count to start the server.
>> 
>> Key setting is done once; whereas setting the thread count
>> can be done many times during operation. It seems like it
>> would be easy to mistakenly change the key when setting the
>> thread count.
>> 
>> From a "UI safety" perspective, a separate op makes sense
>> to me.
>> 
>
> I'm not convinced. We could easily vet that the key doesn't change when
> changing the thread count, and either return an error or throw some
> sort of warning and ignore the change.
>
> My main thinking here is that you'd want to set up the key at startup
> time and never change it, so if the server is already running you
> probably want to reject key changes -- otherwise you may have already
> given out some unencrypted handles.
>
> If that's the case, then now you have to ensure you run the op to set
> the key before issuing "threads".
>
> Why deal with an ordering constraint like that? Optionally passing down
> the key with "threads" means we handle it all in one shot.

We already configure listeners and threads in separate operations.
The ordering is managed. It's reasonable for the kernel to block
fh_key changes while the NFS server is in operation.

I'd much rather set a precedent of several small ops rather than
one or two Swiss army knives.


>> What feels a little strange though is where to store the
>> key? I was thinking in /etc/exports, but that would make
>> the FH key per-export rather than per-server instance.
>> 
>> That gives a cryptographic benefit, as there would be
>> more keying material. But maybe it doesn't make a lot of
>> sense from a UX perspective.
>> 
>> On the other hand, some might like to manage the key by
>> storing it in a trusted compute module -- systemd has
>> a facility to extract keys from a TCM.
>> 
>
> Yeah, there are a lot of possibilities here. I like the idea of
> scraping this out of the TPM, but that's not going to be possible
> everywhere. We'll also need some alternate method of storing the key in
> a secure way on the fs so that nfsdctl can get to it for hosts that
> don't have a TPM.

My point is none of this has anything to do with thread count.
Setting the fh_key needs to be a distinct UI element.

-- 
Chuck Lever

