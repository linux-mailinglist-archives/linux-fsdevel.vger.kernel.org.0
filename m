Return-Path: <linux-fsdevel+bounces-75945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMFcHQnEfGmgOgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:45:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D35BBB48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 773793012E90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24964311971;
	Fri, 30 Jan 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+PUyfqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FC324700;
	Fri, 30 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784308; cv=none; b=tRkCsKC7kd7erlsSOjylFwEwODur16YW5hSGlJdDPZb2LQcm0IqPAJJhJf+ZsfVo043Ry/uBmgz7qwCtp3k6l3QtbCT2G4ei1gXeLo4lHjBkPB5dempVZ1IoOjEA1SjuQlNQjEO2/SUYkDLXetTbE02mJYDi+pCocji/A5BHgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784308; c=relaxed/simple;
	bh=SbeIFy3aGm/yv9ATqXhsMJS7c0Yz2TFMRQZhyVjzOXw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HBAjGEXdo5psqv6DkI2d+iUfODXEBBMANjNW4SKPRSkxBy8/i/82ZvvHR+zEru1mro6eKtRkGFW67NrBo2KcCLpGL2oa+Q2v0B+BON3YtVHIjUXcNm3dIK9FVdnMgsVvd5ZKYW6ipfgyxRXc/AXjcHh5AkrLgLECq+duwJ/uQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+PUyfqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243FAC4CEF7;
	Fri, 30 Jan 2026 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769784308;
	bh=SbeIFy3aGm/yv9ATqXhsMJS7c0Yz2TFMRQZhyVjzOXw=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=K+PUyfqCWQTfvYXg2orBLGkVYmLXGYZfxNd2cRsb4Ss14EUNhiYDYAuobAa8EfCs4
	 9jlc5boYoegQ5BqrdTwm2HQvR4CSTx85u66izsLzs3V0LfAM2aUMIWfI59gxS2STlh
	 A56Ndh48SBSxjeKdbvdqEI612rUV/nTFAHlIy8vNp4iNpW/N2WomC5ZrYcjwRsJIPU
	 qL3xchvlLh5EqJmpCJA0K1Z9m9Kbj3KyqMDrP925cQHcP6V5p0D03UBk77qygJXkIf
	 MwSyl9f7hwsOOpqqcFmqj4gbh2i0eXW5atBxqZ0fwKQX5Kp+MRjrhlKQD5P1ArWR/5
	 93QlG/CO426vw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25051F4007C;
	Fri, 30 Jan 2026 09:45:07 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 30 Jan 2026 09:45:07 -0500
X-ME-Sender: <xms:88N8ab6YVW1u_rS0LO5rEgPieAct4SnQB9vAvDncjYwrW5TjTfkykQ>
    <xme:88N8abuQY-PtZzBFehdSgbaTH6njvkG1wt12LY7SB_olPmBSg_75dRHPN7SAKNlqg
    Lb9pmvrMs0ydeaMK8h1eYcrpSa055esJ1WCsrXw8hreiQ9EYrAXXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhonhgvlhgtohhnshduleejvdesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:88N8aVnqPhtUyuDj55XfgOw1HsPcug0GnG-FyNvvdFsQBUh1FEqaqQ>
    <xmx:88N8aXukjnN7w33KFH2m1xCWjLq3eD4SpIwzA4YfLeHdKzRV0L7_KA>
    <xmx:88N8aT8d-UkQNntusCuR7AVHRKybbLSZTB51n_aHpIyanAT1kGbtUQ>
    <xmx:88N8aRM4DW1Vi8ZmUJiVYZynB58nBgRoAvgphL4Ncw0Ke9cHQT3ORQ>
    <xmx:88N8aRGvm691w9Wxqa8_obbDiS-4hb7zOIMx21KA46elaBFqgoM0JG9O>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F30DB780077; Fri, 30 Jan 2026 09:45:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBI4pOdhfek
Date: Fri, 30 Jan 2026 09:43:42 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Lionel Cons" <lionelcons1972@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <263079d7-bed3-4417-8b7d-cb534da90a2c@app.fastmail.com>
In-Reply-To: 
 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75945-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C3D35BBB48
X-Rspamd-Action: no action


On Fri, Jan 30, 2026, at 7:58 AM, Lionel Cons wrote:
> 1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which has
> become a HUGE problem for hosting them on embedded hardware (so no
> realistic NFSv4 server performance on an i.mx6 or RISC/V machine). And
> this has become much worse in the last two years.

If this is a general concern, please take the time to collect some data
and file a full regression report.

Also note that signed file handles are enabled by administrative settings
that default "off". There will be little to no additional CPU load if you
choose not to use them.

-- 
Chuck Lever

