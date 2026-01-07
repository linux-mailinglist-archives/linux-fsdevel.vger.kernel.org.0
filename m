Return-Path: <linux-fsdevel+bounces-72607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF4CFD2E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D9E8306595E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85322327BE4;
	Wed,  7 Jan 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="GapqslJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A1326933;
	Wed,  7 Jan 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781819; cv=none; b=tSFmpAhYG6Jnwt1p5O0feAcRYa+Fd9jrA72fSYvQFXmN9m5KR+N0tCEXAtgWnct0thsVOBafW1mnSk8IlgYxMzPz5IMiE+nGYzW45DVey+t65iLxuN6iUjSKIWWDJZbuB8lE99MhDCySGdoatb4zbnxBlzLS0IvuId40J4hI7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781819; c=relaxed/simple;
	bh=QDNik1P9OvsgAtFchTw4BckF/mSE1cSKBVO0iEJIHME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzm63Kc2/EyFtIP7D43GS3+oqppwzBuC1PWMzdpv+tsy2xMirsMcmABJ8FWinKmSYxaRllfxQclfe/O0adFOnVHEQvua182APa5IxC79EMy/ISgKuUVHuLCYjJWkgckfKT9MGi1+ETAsy74wHmaxv56diRDhDOVV8eN9SzzWzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=GapqslJR reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dmPHX1tZwz1DDr1;
	Wed,  7 Jan 2026 11:22:48 +0100 (CET)
Received: from [10.10.15.21] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dmPHS5YrMz1DDdR;
	Wed,  7 Jan 2026 11:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1767781367;
	bh=5sCdqnj/RCGcOZ4N1FNFLLmFTy7auxTIhL2QEEcNqFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GapqslJRt7PAo/OPdy40/uiS8yl/fdKamd8Ti7v8KhTSWM+dyJpM0kA09WqDkvmTF
	 JDac2AP0hk4IXLuaOc19G85CIClqVXmQFScccHC7rgNcYdl16DovAFndj0u/scyZuZ
	 rFnlzmQeoXkgQ81qRhHQTXrNih6T2iluIH43PJMds/ZZIo6rm/VM9YDeYihibbVdmg
	 uDvdrF41naRrcWhAD/3/BJoa7qr9vCUPqLxuLP48CDDioxfF0rw5/F8n0Js/OfpQsy
	 f1VR1SCUMB9l0JY24lstr5qvSKP50VGC6KkhF0cw5Ng7hX+p9V4PT5L0p7hEJpFlek
	 UmVwAHzAgacCA==
Message-ID: <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
Date: Wed, 7 Jan 2026 11:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] printk cleanup - part 3
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-12-27 13:16, Marcos Paulo de Souza wrote:
> The parts 1 and 2 can be found here [1] and here[2].
> 
> The changes proposed in this part 3 are mostly to clarify the usage of
> the interfaces for NBCON, and use the printk helpers more broadly.
> Besides it, it also introduces a new way to register consoles
> and drop thes the CON_ENABLED flag. It seems too much, but in reality
> the changes are not complex, and as the title says, it's basically a
> cleanup without changing the functional changes.

Hi,

Patches 7-17 all say "replacing the CON_ENABLE flag" in their
descriptions, which should rather be "replacing the CON_ENABLED flag".

Cheers,
Andreas


