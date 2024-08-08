Return-Path: <linux-fsdevel+bounces-25421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607694BF85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685001C24641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BD18E75A;
	Thu,  8 Aug 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b="Ko+NputL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Joz9183O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AF148316;
	Thu,  8 Aug 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126867; cv=none; b=i8Eqs2gqiLFGQYOZUx8fjH414CV4N28n+DAFLOnjoGYamWyLfOYN1pArgaZJwjQ1ZavrRz5vSZKSMOaa00mQ8I2YzWtROZbMO2Pq1s+YnjiKWJ09SQE/GrD3o+at7uj2u8yi6qk6saMsyxlbvHPuYoT6gER7NRWkW6bHnRUiO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126867; c=relaxed/simple;
	bh=LjjvsxwbQX5iOYSkl2oHHUIvKoA55ZfBqzcqBqBcrDg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X3hrM8eOxK76Ire0kIdqMnK6GYvvIGDXEPQbMIin/xpLSxHqDtfiEZqjVBWbKtaVEcRk5T6mbKnjFInz1kkkknkjSEOU77H5z6UzgiV5pa+0dgxQpBEdob0sA94rnZtlNi/7OFbnKsZtwsPPl0bBa2dkxosqDLEVfgHCYNIvA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com; spf=pass smtp.mailfrom=tiljeset.com; dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b=Ko+NputL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Joz9183O; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiljeset.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A98C1151ADF;
	Thu,  8 Aug 2024 10:21:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 08 Aug 2024 10:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiljeset.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723126864;
	 x=1723213264; bh=LjjvsxwbQX5iOYSkl2oHHUIvKoA55ZfBqzcqBqBcrDg=; b=
	Ko+NputLDGloI+FKutuwImwIhohyVfL3RoS19N0ZFEsG349+3XFcmxou+tR4vMke
	beNEWHn6BLNnyVvOZEYCECjA4fpbamX1ftiGkNKb6SajxTjEGGdSBAW4yCqPIthi
	623cDS7fQ6EHqCI8NYAK7PRCBENabJAI+sOR1YJjO68bcKgqWrhcxGvdLwB67ylC
	CJ7Am586RZtNs81K2B9Yzg6zL3nQ+gyd8XpYQX6CwSfL8mln0IW4Px1mLKEbHpg8
	yWX0m4uBhiebRs5OC0/9rjuelxhr8YGLOHJeG8qRAGqfA6lKxTChsNsK17K5uChX
	bGofQVuvdLgBx3COkMRkOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723126864; x=
	1723213264; bh=LjjvsxwbQX5iOYSkl2oHHUIvKoA55ZfBqzcqBqBcrDg=; b=J
	oz9183O8sHGn1S0bep1sxSnNVxjNUZsw8kemdlbooYAJSJG8/DC6PVITJaM1N7sR
	J5drWFsb/B/wHerbTFR3oi2fwEepgXJX/OQN6YXSneWqFKI10xU+WLJembiQpp0d
	Ulm/b8JT2sa3Lhj4fMbDr0XL4aOKEH0FaaOqBfTexPZOBITABHtJxBTS69yfBlqe
	Lck8A0D6ffSHiUYdjELhSY6Yz9WgsQ8QvVKE3v5saSD1mrGkrGUzbETPdyax1SfJ
	2RaD9T5y70U7czIBppidnOiV8K52UPiZKBHZvkrD6Pmdx5EBSENnJf3mBwoUQnuc
	6sqFhHZfTiPavCuQjKICA==
X-ME-Sender: <xms:UNS0Zsi8C6yTe_cNr9OQOIDnbD0B0l7GZ0kZ9o967ueORqErwa37Zg>
    <xme:UNS0ZlAt8YyjYsjyvAo7UBNNAJlUszsnpvEuaRFwWlhP_te9W6cer7Bs5N8ztXsCe
    MspyFSl5-WYGNJVjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfoohhrthgvnhcujfgvihhnucfvihhljhgvshgvthdfuceomhhorhhtvg
    hnsehtihhljhgvshgvthdrtghomheqnecuggftrfgrthhtvghrnhepfeffheegkeeifeej
    vdeijedtfeetlefhtdekudefgfeihfejueejtdegvddtieevnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhorhhtvghnsehtihhljhgvshgv
    thdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    fhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UNS0ZkGDhs67U3YlZnz6oz13417tj66z2Uoz34-x-tZZCGOnjUAheQ>
    <xmx:UNS0ZtS0AWyPf8p908NfzLSjwLLCkxcGbIkg8eEuur7G4G4KoFdVSg>
    <xmx:UNS0Zpw65EzW4b_xNC9Y1mprt5mRNrRiM8w1IjysSeelIbLoAH9R_g>
    <xmx:UNS0Zr64i5pfiGz7HXTKdmOnxTpBiw4zk5UASi8I0lnjj5tadk8g3w>
    <xmx:UNS0Zk9_KcOlYjcKfJMHkEActaOMjKrFu8PIttA05ykFO1BsfhiWrk94>
Feedback-ID: i7bd0432c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3F7C1B6008D; Thu,  8 Aug 2024 10:21:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 16:20:43 +0200
From: "Morten Hein Tiljeset" <morten@tiljeset.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e244e74d-9e26-4d4e-a575-ea4908a8a893@app.fastmail.com>
In-Reply-To: <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
References: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
 <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
Subject: Re: Debugging stuck mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> It's likely held alive by some random file descriptor someone has open.
> IOW, try and walk all /proc/<pid>/fd/<nr> in that case and see whether
> anything keeps it alive.

Thanks for the suggestion, but I've already tried the equivalent of that by
using a debugger to find the superblock in question and then walking all open
fds and comparing the superblock pointer. I've validated that this approach
works in a synthetic example where I create a new namespace, mount the
filesystem under /mnt, run a program to open /mnt/foo and lazy unmount /mnt.

Walking procfs seems less precise. I've tried iterating through /proc/*/fd/*
and comparing the Device entry of stat -L, also without luck.

