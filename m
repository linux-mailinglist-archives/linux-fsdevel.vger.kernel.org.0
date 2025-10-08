Return-Path: <linux-fsdevel+bounces-63599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E10BC52DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 15:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBC74010AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E1284889;
	Wed,  8 Oct 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mUKXEgOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ea3gOZ88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D619277009;
	Wed,  8 Oct 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929832; cv=none; b=SA3k1aWKr0Xz+2d5L+9/ypksmkcuLp2MKd+/c8kxMsIfr7Zvhj+pkcL/cmQLl1H1FDY+mzeqnRNfLzpYyNwaQ7BwBUk3pMemgM0TFL8JAZ1pjlOOBVqQLcWt56r21XiLtYJ+1SDB3GR8bWqeFDjUeLyQwpHrpKWgN3CYLShO7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929832; c=relaxed/simple;
	bh=63LzR7X/Nh1WbOCrqzTruzI/5vXPhk1WxQz2hU/SmW0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lywZX8CFnEe9vmnQePTIkdVxxvdpnREh6xW/miqwGq90A/jhcQyhszeVm0laXKeMCknk1jQvuzCl0eVsMlrw97s4odEnmxEADe7JNr/ukkmJGNY348CyFvhl2qnTK3KmRgVmhwDlBmR6RjZ/tP/e4d9YKdppKWUkRH0GRiou2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mUKXEgOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ea3gOZ88; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ED32CEC0232;
	Wed,  8 Oct 2025 09:23:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 09:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759929828;
	 x=1760016228; bh=63LzR7X/Nh1WbOCrqzTruzI/5vXPhk1WxQz2hU/SmW0=; b=
	mUKXEgOGAxz9QPlqdp5yD+/sQHMAN7Wfbv+lATjU71v4KbYA5iTJCsUSexFdOf3M
	NjGRg5BykvMrD0NYR14VOxNXiODiWBlt0He2XGs2cBzeJ54iRFIWZ+y5M3Lau7w2
	k8Ne/InLXXJYseSBhyTll6rEwqWl6hC710Mm01JdPsRk4CzCcYpRhNyO2xzqbG7Y
	PXvu9OmJypvoCNJTiTatrC2OXLa14oxL9U0GHK8H3a8r6EMPRCTy4iXBKecDzzsT
	lIDyrVa9W7XUhfQNXAV57anDpYBFCFkaqF8Mk9WqC6jmdrmTFug+GYWMsyOONAeU
	44gL+MZN4bPhDMUcyJCAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759929828; x=
	1760016228; bh=63LzR7X/Nh1WbOCrqzTruzI/5vXPhk1WxQz2hU/SmW0=; b=E
	a3gOZ88lGK2PiVL6Ct1aqG0C6VQaWn+X5VBdeVMs2InsxFGuEvpXs+hG275nNfq7
	ok5RN2cNY/NfsTkgsE2N8ZY5fhBw1APxVqyX6bt+8SGnFr0wyvJrFCmh35nBYgJD
	evcAAvVdn6II+eBq6t7wA+dWhiXfNN750URb1DcQmj8BDagpWVe531mYw88vDVT+
	uoeopzqKsp5eJqZjM622GEth3ZNTt3zTInFM5qh+Si31fyGqykJ8cuSOyn3SimS9
	3QL6JLmwTbDA+HABjwazYoL1cfrM0i05hx63iqo13qT7qUu+nQkjz6TZjTCk+LB2
	A57sqNbuHD+Fg8d2TACAQ==
X-ME-Sender: <xms:5GXmaH4b9fW8g1pMA0aRWSSB398qWM_Hu30OLVoQL476ZjtjhsmsSQ>
    <xme:5GXmaHu8xmecwjnSNPlifG7xSyP2kdmZwb0GmL7vtl9CU_ClioXTGylHA_WljI9Cp
    kmSdCquptO6blSbHpRM_oCCJ5G6LWv-JHTvzlrRnDXmHQWYnwThKX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprggrlhgsvghrshhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgih
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrghlsggvrhhshhesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhu
    gidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5GXmaDbtpROmjgydqMuUKqrfyzlZa_5A7qO6XWF3j4lGnLVHlcD5EA>
    <xmx:5GXmaFeFASN-hNF3ArTS3he1WJHnM84Tr0f6tr4uSvr9aZe-j54-qw>
    <xmx:5GXmaAnIw_8J33KVl1LtQ5KCt1MsCgoNBvysttAtVQ9Dg1VrImYPcA>
    <xmx:5GXmaF25YtvRaMtZ7E8Njd66HWKAzvGdXnnRB634U-U4JnKLPCRLOQ>
    <xmx:5GXmaHeWXam590hkTXUYoSnzMVqh4In3wyi2alVIr1T5y29ecpYeRzIX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6685C700065; Wed,  8 Oct 2025 09:23:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXClXubP6rjF
Date: Wed, 08 Oct 2025 15:23:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrey Albershteyn" <aalbersh@redhat.com>, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Cc: "Jan Kara" <jack@suse.cz>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Andrey Albershteyn" <aalbersh@kernel.org>
Message-Id: <5702a4d0-37f9-4131-bb4b-4a192088ec28@app.fastmail.com>
In-Reply-To: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
 <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
Subject: Re: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 8, 2025, at 14:44, Andrey Albershteyn wrote:
> These syscalls call to vfs_fileattr_get/set functions which return
> ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
> inode. For syscalls EOPNOTSUPP would be more appropriate return error.
>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

