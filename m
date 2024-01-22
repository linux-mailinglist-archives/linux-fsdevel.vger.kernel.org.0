Return-Path: <linux-fsdevel+bounces-8449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09109836BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9721C2567D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274F40BF7;
	Mon, 22 Jan 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exia.io header.i=@exia.io header.b="5IkZ9qyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com [198.54.127.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A63D964;
	Mon, 22 Jan 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937033; cv=none; b=Fp3FFxWVlvoGYbpuEqbawMLEaAeQ96+iYVnewQoi9ij6sx+RlvvH6eqf+UDW/tgmiuCk0axntpZwGyVd8rHpb9z92IiJaLAr3U6Nd3CH2Pn25bGvTovEGHro9vf7695QFCxTqbCoVgoxfivD3qJSLhW9nSSDlrEYk59W7sEA4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937033; c=relaxed/simple;
	bh=08AzbJBDTNvT7ROIQXDEvrMtJP9y4Vc1P/92plU2FMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsWUWVCT5pXfBtw1Ad1wqejyR5yLfXBeiGDfFOUExpgGmnDjWM8aVQny2MGYHJo/UEJU6F6YAGUcZO7PYiKKnDWONQKXaxV5MS49UCsalMgXk1WEoCi0WATiZwlLdOwVao4gvfWGDz+0xSMVacg6AwovZZIxP7AgznNXMQXJa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exia.io; spf=pass smtp.mailfrom=exia.io; dkim=pass (2048-bit key) header.d=exia.io header.i=@exia.io header.b=5IkZ9qyF; arc=none smtp.client-ip=198.54.127.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exia.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exia.io
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id A90DB18000AE;
	Mon, 22 Jan 2024 10:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=exia.io; s=default;
	t=1705937024; bh=08AzbJBDTNvT7ROIQXDEvrMtJP9y4Vc1P/92plU2FMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5IkZ9qyFHIk7pp99vhyLQ06zBRPufV1N+24fe8ZVDChfrZOR2vD14mdBd1TXW43m4
	 0/BBsYPE9UBOfEudTdy29kv54FCCVzL7Me2hNJS/vTO+iQR0SF4zo921wKRcWDZccH
	 +ZRzgssiVAw/nOU3vUlrGWf4xCaUiAHtPzyTSFHRxHvW/LpeDqhrnvU/lLjDPQaetE
	 38EDGCdcutwWJiJwl8Gyob8M5PaAuMwu3X4946LgOyurhEt5tqLvKWRr6iah1Q48Nh
	 6sWkWAe3ygvj13OTmVyeEsakWedyQoLMpulO8dQt+oWYh98+EkoISa1BdcAaLauO9C
	 ULJbm+XegtNpw==
Received: from [192.168.1.17] (M106073142161.v4.enabler.ne.jp [106.73.142.161])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Mon, 22 Jan 2024 10:23:35 -0500 (EST)
Message-ID: <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
Date: Tue, 23 Jan 2024 00:23:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Content-Language: en-US
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: ebiederm@xmission.com, keescook@chromium.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
From: Jan Bujak <j@exia.io>
In-Reply-To: <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

On 1/22/24 23:54, Pedro Falcato wrote:
> Hi!
>
> Where did you get that linker script?
>
> FWIW, I catched this possible issue in review, and this was already
> discussed (see my email and Eric's reply):
> https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com/
>
> This was my original testcase
> (https://github.com/heatd/elf-bug-questionmark), which convinced the
> loader to map .data over a cleared .bss. Your bug seems similar, but
> does the inverse: maps .bss over .data.
>

I wrote the linker script myself from scratch.

Thank you for the link to the previous discussion. So assuming this
breakage was intended my question here is - doesn't this run afoul
of the "we do not break userspace" rule?

