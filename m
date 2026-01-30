Return-Path: <linux-fsdevel+bounces-75946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DEmKd7EfGm+OgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:49:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D16BBBA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F445300F16E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021532938D;
	Fri, 30 Jan 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGpQ2YCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1025303C9F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784532; cv=none; b=tkNPrnvGI0uMxHSnJZovcnJ+fiFTH36b1wx+zdRyvh1NEUiDe7HV04JX6lI1FHcr+7GL4fOEAVqcUxbjX+NSdcnFoEN9m/eug0HbUYJ9K/V2BOXuHWNdExUxZj4xttIpLO5VshYdQtNYol1uao7x3pfJbJlWYv4Aj2J1FszXLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784532; c=relaxed/simple;
	bh=vPZvD5vu/bUixwHxgE82lw5IrKyUAf/x7/2ziu0XbYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PikL7xJ/m8oQiDDJGSlkbBV6LEXzDhSGGkJu6/ppnApglRODsL32d0w44IxOokBywuV0+zcGR+5HONecH4YaiyV285vFZtfzJY/yJhm80Wm3DMwxpvTrkmZNONqnLp8ZkHGQ1FJL5/4veibPevZynXZrAV4Y0dDOhcasdtn4PeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGpQ2YCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81045C4AF09
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769784531;
	bh=vPZvD5vu/bUixwHxgE82lw5IrKyUAf/x7/2ziu0XbYM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OGpQ2YCcWE1CwVl7UdBOgAqaOJah/4u+aCFwj4u0JN4f78cx0tK4xCACHvGP+6faW
	 TvQzhwglms+BfzX5y+XixveAaHamF6ZcZe544v4iD9T3Gx45rCjJ0J2dRcLOeCBPMq
	 ov9OcoZsjuixpQEpAUswjVDsyXD6p82xKuUb5Klm5qjgfVLZ/4G5E49psH7f0CW3jD
	 o5FfdL5rp/MCpz5Oo472VrOEmeVkmWiLttBJNtQceBqbJJom9yqO+RRTJMN5cwt19Y
	 nyc6HafGERL4doeR91T+f5K8mYm+kmFf46GtMThDjiB8kG5S+Wjz6UL5xr6bLc0XKD
	 ci5tGiCW2vIPQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D58DF4007C;
	Fri, 30 Jan 2026 09:48:50 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 30 Jan 2026 09:48:50 -0500
X-ME-Sender: <xms:0sR8afH9v6PnESB6t5CBCufydrZlEqJ5TF43iFz00g9y9U7-Gg-Amw>
    <xme:0sR8aXJ5oCrPRAEvzihTYYPK8eJirBPzL5XsbkOZZED5eTxoyUHe0H2NlBfK8qtx0
    6AO1GUWJJh9jBCklvl7IdwryYN-cP7ReQODQPUcY2IFTflmfuSwPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhiohhnvghltghonhhsudeljedvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggtohguughinhhgsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0sR8aQb6d4iOMNdHsOWYf99fsF19xeWoQ_psz3jqLvArRI0-hbk0aQ>
    <xmx:0sR8afEZsI5zEyXF-2P4s86HhjMDupDwx07Cyk9M_befj_fVJSqnzQ>
    <xmx:0sR8aUzsOCm2hriJQs_hrif4qL9deP0Wxy71YaxUI3A3WENpVNw1OQ>
    <xmx:0sR8aRlUhlPqKu5dgty5vznsdVADTkiCR3f91LggtEXIBn-Ynq0Ktw>
    <xmx:0sR8adkTQtvmDI-u60REkEGoj19e58S6E0pOaRU25pEbwOi_fEQQmpdd>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F343780076; Fri, 30 Jan 2026 09:48:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBI4pOdhfek
Date: Fri, 30 Jan 2026 09:47:50 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Lionel Cons" <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <556aa156-7453-4567-8e36-0edef995dcc6@app.fastmail.com>
In-Reply-To: <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
 <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75946-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 67D16BBBA5
X-Rspamd-Action: no action


On Fri, Jan 30, 2026, at 8:25 AM, Benjamin Coddington wrote:
> I could, if it pleases everyone, do a function profile for fh_append_mac and
> fh_verify_mac

Trond or Mike can demonstrate for you how to capture flame graphs
to very graphically illustrate how much CPU utilization is introduced
when using this feature. It would be valuable to confirm our expectation
that the additional CPU consumption will essentially be in the noise.


-- 
Chuck Lever

