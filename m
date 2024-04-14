Return-Path: <linux-fsdevel+bounces-16884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9208A4134
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6391F21E81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5BB225D6;
	Sun, 14 Apr 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dh7qHjMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0C1AACB;
	Sun, 14 Apr 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083212; cv=none; b=KqaGNp5HKV3AulXeabgEoJ+Hs40RI5HFjPhAhRunRGiuUIHTPd2WCyQAU9IME+3+U/5gmxhYHYm2KuuX4rtli+rXJcvmB0vUCxodcZQ30T0vaVU6ELb2szrY6vRrQbjEXcVozzX9gS/Njx5+I4bFqL0rP7G+JPwWrb7p6NCxyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083212; c=relaxed/simple;
	bh=seA5IFTTKtz3rxkW9bt3e5Nr/g+T2Bqjd+8wwfAZNV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8pFPrqU+1IAljepeeftlRltg4Mqg6H7aC3evujLPYfLKqVDbVl39C2+cwT0IOoSlIHkvMZkRlXNTJmiJYes2JVAQcQxGZOqAhP+b9JGdleQmdMGKHxmRcSSOIoe+sNd8eppLlnnlOM8twU14ctVlAi8dwJfPmLXiNU4HAjmS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dh7qHjMc; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vvBCrccEPJxt9vvBCrmDNu; Sun, 14 Apr 2024 10:25:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713083141;
	bh=dGoX59thRuXUYmBYOFd2avcmGJHn+u6ShTmIj0ogTUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dh7qHjMcMRQY/vho5dmpjWqCOu7MKWkzFnLGM/Yw0wE6cOYU+XcciVWr5h7axCkEu
	 +Tx7wXhvSotjyIH9q49Sx0otuHQx4ybW/A1SWR7hfqtH2mOpf1xIxlra9P9uEv4Sb8
	 wG2Iuzbdmex6dgeQK281Qdu5OtLD1+heHvc0JMec3+jb4CzmRSB44mc/trXL5A/AeM
	 Im2UzziPpnYyi+FhHq0fAobFqGAQZATqG6Zx2n6GKeEWaGj+Qo03Goll89mZq8AQsX
	 Zre6iQJrLbUqufN1ptPIBAYl7TdDnC+9S943g7nbn3YwXzMQLMnRuKVBOslnYOX/7L
	 z7KKSPfHOPHqQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:25:41 +0200
X-ME-IP: 86.243.17.157
Message-ID: <24c05525-05f7-48bb-bf74-945cf55d3477@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: Remove usage of the deprecated ida_simple_xx() API
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <f235bd25763bd530ff5508084989f63e020c3606.1705341186.git.christophe.jaillet@wanadoo.fr>
 <ZaVy9r0wX8pUE10n@casper.infradead.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZaVy9r0wX8pUE10n@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/01/2024 à 19:01, Matthew Wilcox a écrit :
> On Mon, Jan 15, 2024 at 06:53:37PM +0100, Christophe JAILLET wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> Note that the upper limit of ida_simple_get() is exclusive, but the one of
>> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> 

Hi,

polite minder ;-)

CJ

