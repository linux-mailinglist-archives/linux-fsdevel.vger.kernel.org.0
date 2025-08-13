Return-Path: <linux-fsdevel+bounces-57796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B36B2563D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EA656385E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85B2F0691;
	Wed, 13 Aug 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="I5fyLp/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btJDb8Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAD3009DE;
	Wed, 13 Aug 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122555; cv=none; b=mRhY/Y/dMAz127GvP5bd+inOn0WrVNcc19UgtzQJvrpjOgOTU1UtYVQSY54C+IyOZYGq9xmx4vLilR4wPJliQ2tyjJIfDRm0XF900d/pqv6wXTUvhDW3hGnftO3JWhDfQhMtjYCzKtDh8uFkjfcdV/L41mLvtbG0teT0lTLrF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122555; c=relaxed/simple;
	bh=HnSo7rJ+M2lPlnPcnC6jBvnC68nli4MfGrp7f5zzI+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMESFlIlyjs6c8ZS5zI853GIe55/cTxLI5ysFgv4nbIAyoC1TaMPd27/3jvhmDkDI+5xnuzsXnHzvKpDquSK5+3DTL6JKxA750hiNjTBuNu2dRl7QGimRyX3LkQjB0VYuwicSta8JcHsF2pV8szYuhj+060VJ9kwEe1I6HNUBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=I5fyLp/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btJDb8Ek; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA385EC01D0;
	Wed, 13 Aug 2025 18:02:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 18:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755122552;
	 x=1755208952; bh=82WxlZH9PCpxJARhloF58qJKf0NjK4Eh99jmnqfOLbk=; b=
	I5fyLp/NHlKracOArJL9CyanPF6Pt1pPVWR4wp8pvZIDZWATGCBUaEvCyjPhs6A5
	HbzkZ68PktCLU2gZyegd4cY0K1IJFttBWSTQha6L7FJSwlWCVPwJ7EM5MA4o2gJE
	JRjUdGJ67ANUfVrc1y3uRtXGbx1Gh6gG5KlWFDeN87mLXc4fcvYEGmqRi8m81H/o
	UVmSI6OuisYlBh1PSUKwOItm2q7k3dj1BP+FwNs0mL2V0Du0TDpF2CiAFcsFy4MH
	ur6OxrxLTxDda2k8dcCLAxrbUik4dOuwTwZa9kYRxH9SYFJLPeUQ+OXUW2hfc2An
	ahCPyBj/wCz9xjjEIiO5yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755122552; x=
	1755208952; bh=82WxlZH9PCpxJARhloF58qJKf0NjK4Eh99jmnqfOLbk=; b=b
	tJDb8Ek9UvH2Ppq7z6ubcRkdg6S54Jy7McBPUlfeBpRy3hZeJz/6AOrZtJwZTehm
	syxT2PKw8B6IBw1gi+excJordw5HmR+Zfxib0tafJRDU7Yf9ng4pm+XkA7oTBLO5
	fQ/FoMAC3T3J2UxhAJ6J4ub/6mTZP3BZQRd3Q8fwVi/5CTRmEmKXnhTxKsE33JCD
	cAUaZTuEN+4RZtw+j5KO0uCgrAhW49PHe1s+B53RoCLr1/53lKoFNUV36upL2dfw
	swXM7hnjJ4/IUjFGhJYuW1fpxZxmagxg6IsP6/1/yzVc7jDxQK5E4YuoPR/2v6WX
	MkHLHSoLSoJGzJr1Bb6IA==
X-ME-Sender: <xms:eAudaCaJuyCgUy6OnoDXsA738lkfH0bJ3O5f0e8BNQc9KwwWtZ8u4g>
    <xme:eAudaF0_u-FYSTLAXqAfaFH0eConqp192ubCqu95VAAs38b7kNbDcAkpiM4voOgwt
    2BiURsJTOQlwhfCAXs>
X-ME-Received: <xmr:eAudaNqEajDwX35z2jOJsuLy3SplmvIXQEkO1Bp65fXTncBZw41T7LgtCmRCOZTKLgUgg-8ILmHZYK3sZ0UvqodyUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcu
    ufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeu
    lefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhgrrhhmihhtrhhosehpohhsthgvohdrnhgvthdprhgtphhtthho
    pehsrghnuggvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eAudaMNTek3itWkzRuAl42gni0i0Kw0rz46VEshZQDRP9049cP2FZA>
    <xmx:eAudaOoUwanhde6fq01EN2cv_scoA0TDnfZxI9Mg28J7fn7YzFkIzw>
    <xmx:eAudaPskLSS3-GVd-Ys4a3I3M3ci-l7kYm_uDHda4G1EAG6ijSos5g>
    <xmx:eAudaN0Y9BOfF6820JVAP7bzR40wzhrRAn48S3Y4iat17koOkUG0OA>
    <xmx:eAudaF7uNhoJ2ZyW8hrKIraq-uEUGyQuxYjVJd0eBIh0-smQa58P4NUH>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 18:02:31 -0400 (EDT)
Message-ID: <495848ab-2493-4701-b514-415377fe877b@sandeen.net>
Date: Wed, 13 Aug 2025 17:02:31 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
To: Christian Brauner <brauner@kernel.org>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>,
 Eric Sandeen <sandeen@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com> <8734a53cpx.fsf@posteo.net>
 <cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>
 <20250808-aufrechnung-geizig-a99993c8e8f4@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250808-aufrechnung-geizig-a99993c8e8f4@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 9:13 AM, Christian Brauner wrote:
> On Wed, Aug 06, 2025 at 11:33:11AM -0500, Eric Sandeen wrote:
>> On 8/5/25 12:22 PM, Charalampos Mitrodimas wrote:

...

>>> Hi, thanks for the review, and yes you're right.
>>>
>>> Maybe a potential systemic fix would be to make get_tree_single() always
>>> call fc->ops->reconfigure() after vfs_get_super() when reusing an
>>> existing superblock, fixing all affected filesystems at once.
>>
>> Yep, I'm looking into that. mount_single used to do this, and IIRC we discussed
>> it before but for some reason opted not to. It seems a bit trickier than I first
>> expected, but I might just be dense. ;)
> 
> If we can make it work generically, we should. I too don't remember what
> the reasons were for not doing it that way.

Sorry for the long delay here. Talked to dhowells about this and his
POV (which is convincing, I think) is that even though mount_single used to
call do_remount_sb for an extant single sb, this was probably Bad(tm).
Bad, IIUC, because it's not a given that options are safe to be changed
in this way, and that policy really should be up to each individual
filesystem.

So while we still need to audit and fix any get_tree_single()
filesystems that changed behavior with the new mount api, may as well
fix up debugfs for now since the bug was reported.

Charalampos - 

Your patch oopses on boot for me - I think that when you added

	sb->s_fs_info = fc->s_fs_info;

in debugfs_fill_super, you're actually NULLing out the one in the sb,
because sget_fc has already transferred fc->s_fs_info to sb->s_fs_info,
and NULLed fc->s_fs_info prior to this. Then when we get to
_debugfs_apply_options, *fsi = sb->s_fs_info; is also NULL so using it
there oopses.

If you want to send a V2 with fixed up stable cc: I'd suggest following the
pattern of what was done for tracefs in e4d32142d1de, which I think works
OK and would at least lend some consistency, as the code is similar.

If not, let me know and I'll work on an update.

Thanks,
-Eric 




