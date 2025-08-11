Return-Path: <linux-fsdevel+bounces-57292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA5B2048A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C0A3B1EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26B1A0BF3;
	Mon, 11 Aug 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ftml.net header.i=@ftml.net header.b="Ed2cyNfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ts0Y+f4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B024A047;
	Mon, 11 Aug 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905883; cv=none; b=lvdAEt6lO+Jo2baaKDuJxp+31mN1Q+Lgh/SEF3OgNhgMTS9atmxajZjnxitjAV4G+t/K/VN/QnFT4b789N8qVj24XOSzMJtrx965qUd+qzyfiyGhNzwG7BUcXzabJQPI4qQaPFe42tDwRUcZar+hBTOBpOD7nS0P+iEDgsHFVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905883; c=relaxed/simple;
	bh=mzqAvYNXZUjuM9nPAtcLwwMPV5K6jGc+GukSM2P58io=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KtdQ6rqiZIBNJHi517nXWooTHPCFTf9ka5d0FrLzSxw9XHnBSZbrzUSqDWgv6i8j0h9U2HhmvkQaTNtxx1jW+B3tv2lWfaT+SBaA8v7uhRmfZncKprfR5LmZ1mopV7yux8JiwwSturqmNm2u9ku9iMnewMNcCMVblsKD1cqtog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ftml.net; spf=pass smtp.mailfrom=ftml.net; dkim=pass (2048-bit key) header.d=ftml.net header.i=@ftml.net header.b=Ed2cyNfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ts0Y+f4c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ftml.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ftml.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C199EC0079;
	Mon, 11 Aug 2025 05:51:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 05:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754905878;
	 x=1754992278; bh=mzqAvYNXZUjuM9nPAtcLwwMPV5K6jGc+GukSM2P58io=; b=
	Ed2cyNfVOqHw77GPhbjFPFhFv0AoaMQuGWvfdCku1xw5Hqamx53wLiLX100Nlbuk
	TPFTBDzkmnG4o+ziIfyiTKTlsLL5OqhyylQVQOhzZ2oozysOMosEYvRbsVrmACdv
	Rpz4ftS9c7AUoWw54+nd/bxVWjWzEhdf6D8KxxihQF1TcEXtximLj0R7SeARS3eW
	cOv0y7C+WZWCHNI8XajPGPNcM4gouEJg99UiLpLf3VOW7qlyjn7oSsJj4yPJ5o0T
	OvWX20CczdtfjdbeOW/df7lyOYzT5MDZmxU85C7b3/JPqhT28Sk+tTD23Jqo03kX
	B0xVBHqdU39t7YND7ZkQwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754905878; x=
	1754992278; bh=mzqAvYNXZUjuM9nPAtcLwwMPV5K6jGc+GukSM2P58io=; b=T
	s0Y+f4cko7ggUUkenJrpJMyj2msIC+6av/D+rF58MQr3FFJhm6/5onq/6kCirjQo
	YH6JwVevRtEr0yGot8KhflDZuNNLF03vCI7Q/c6Ui1BzUVPR3MkwvAcAIQTFRaZI
	gFx1nrl58qjflVJsLH0NQ3KM05XaI9wlizcz0hXMQzMifXx8vwYYX1A4t7HsLK2b
	DC0cwAHlLT0w43+l0ve28tXmWuyJhRlxhHBaxVBrbka635WZ69uc0cmW7oAERv2S
	VBq1YDfe0rmohg7jBlCJyQHcyMuHeZeE+/nfFyvc+8ve2EIoaA74k0VxzF9vrbLT
	cAprS43vpFbkz3LGWgv0g==
X-ME-Sender: <xms:Fb2ZaPzdIi2S7Fub2RA-iyHTQLixy1cD4vaLNpP6m--gqeunuFgP_A>
    <xme:Fb2ZaOA8XDrbv_boH0Py_WT3ZLBxAWNi_pnjHUm713o4kd40Jp5I7nayu77C7yoYC
    htoKGpw1cvvl68HCf4>
X-ME-Received: <xmr:Fb2ZaLELK0n8aGeASbfj9NfhH5Jwy39w5nV9_NwnlLII0yi3zJC5Mk10IAk7jNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvvehfuffhjggtgfesthekre
    dttddvjeenucfhrhhomhepmfhonhhsthgrnhhtihhnucfuhhgvlhgvkhhhihhnuceokhdr
    shhhvghlvghkhhhinhesfhhtmhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeduhfefvd
    ffkefgvedvffffffekjeegfefhleffgfehieelieeiieeiveeftdfghfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgvkhhhih
    hnsehfthhmlhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprh
    gtphhtthhopegrughmihhnsegrqhhuihhnrghsrdhsuhdprhgtphhtthhopehlihhnuhig
    qdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhishhtqdgstggrtghhvghfshestggrrhhlthhhohhmphhsohhnrdhnvghtpdhrtghp
    thhtohepmhgrlhhtvgdrshgthhhrohgvuggvrhesthhngihiphdruggvpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:Fb2ZaFPVHqDeHF1DLctsIDknNMHsBG947bzHvBjXjBKJhe4jFqcL6g>
    <xmx:Fb2ZaM4b2pCE7l-dgX7LZu5Mt7-LP-B2kkk2cUa9FcOXxtk5h2wZXQ>
    <xmx:Fb2ZaIgaQWkMHtiI5FK8emmJLgnz9JFYvKj2cGqtkK8lJLTI7mcWHA>
    <xmx:Fb2ZaBcykMXsdSyUiLo7IGOtA1ER53Ubfg9rzBYDjCQ6l_hZ30BvbQ>
    <xmx:Fr2ZaLj9tb_7xrm-9y4KlnRodvRWVIfw2I_xE6poXgy5fCTN-I7WGzf1>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 05:51:15 -0400 (EDT)
Message-ID: <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
Date: Mon, 11 Aug 2025 12:51:11 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kent.overstreet@linux.dev
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de,
 torvalds@linux-foundation.org
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Content-Language: en-US
From: Konstantin Shelekhin <k.shelekhin@ftml.net>
In-Reply-To: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Yes, this is accurate. I've been getting entirely too many emails from Linus about
> how pissed off everyone is, completely absent of details - or anything engineering
> related, for that matter.

That's because this is not an engineering problem, it's a communication problem. You just piss
people off for no good reason. Then people get tired of dealing with you and now we're here,
with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
Will your sponsors be happy? Probably not either. Then why are you keep doing this?

If you really want to change the way things work go see a therapist. A competent enough doctor
probably can fix all that in a couple of months.


