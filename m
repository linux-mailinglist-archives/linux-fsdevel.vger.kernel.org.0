Return-Path: <linux-fsdevel+bounces-17318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C418AB624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F35F2830E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64202BAF5;
	Fri, 19 Apr 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sq8kL1Q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB801BF3D;
	Fri, 19 Apr 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559650; cv=none; b=nDYoTmJCEpr2ISye69KgV2/UUB2N3QVi+Gx2Vyk6KDuTTvvpjHXxL1IflYFsd3IhVwaQK7SGPkCgcmq35H989eojSlvpVMo9tr8KATJfOLCBOOaRw5/4gjlvxHHK88VcSt8SBSYSBIRFOYXsJtL+rFN/Wo73dB5wb8RWotMtL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559650; c=relaxed/simple;
	bh=RGWo5cAReV5vNXbHaLvoR0Q1CkQ78gT22HxOCR6MmFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0en4P3f1FfOC2ojFHKCQPFV5N1QjjeXweiTqrqhm2cWo3+uDpNs6+CUGYSeGmPpLe6tgJ7XDXM8x2s4/noz+/8lUZfSFa5EJRih4C3anrt8kGI1AwivU34hjnQqFkOYyoDaptc5itO15KXNi1k8YsEuUPRlYzlCOdWFNwOJeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sq8kL1Q0; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id xuzvrCCwxiGtUxuzvrtdg8; Fri, 19 Apr 2024 22:38:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713559096;
	bh=nME8lOdkd1+x8VPwStcPPr6o4g/uIgFzm/OQJZC+ERg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sq8kL1Q0xocF2YLzi8UH02TAqQB1HqTWQd7uRKq5s81YWxIEO4iUSP/QP3s0dlthk
	 +2mzFZT4IBrhTBuW51X/VMW6qTZzo9oCFSOwYZ6ye8QjI8VNFihtslpZNaZFxuRmX/
	 Jyxf+gzIrZ5bg+Lj/04ROJiJyWoBkqUp/0h5jBtl6ndVBgM7c2D6QTR05il9vskrJf
	 wYeaT7vKj+OqqDINkDhhQQrlMDJs3PcqEidCVwvuPFvWXqiVaVsW53ZenkVpEpDIiu
	 aBn+kMEzDf9bu0D+9cBzEiDkBL71YSURoGHUXZCzbrn2gGIgJ/6ld6mEYs+Hlmcrfz
	 4OuooDveRulAA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 19 Apr 2024 22:38:16 +0200
X-ME-IP: 86.243.17.157
Message-ID: <5e5cde3e-f3ad-4a9b-bc02-1c473affdcb1@wanadoo.fr>
Date: Fri, 19 Apr 2024 22:38:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
To: David Laight <David.Laight@ACULAB.COM>,
 'Al Viro' <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
 <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/04/2024 à 22:56, David Laight a écrit :
> From: Al Viro
>> Sent: 15 April 2024 22:01
> ...
>> No need to make it a macro, actually.  And I would suggest going
>> a bit further:
>>
>> static inline void seq_puts(struct seq_file *m, const char *s)
> 
> That probably needs to be 'always_inline'.
> 
>> {
>> 	if (!__builtin_constant_p(*s))
>> 		__seq_puts(m, s);
>> 	else if (s[0] && !s[1])
>> 		seq_putc(m, s[0]);
>> 	else
>> 		seq_write(m, s, __builtin_strlen(s));
>> }
> 
> You missed seq_puts(m, "");
> 
> I did wonder about checking sizeof(s) <= 2 in the #define version.

git grep seq_puts.*\"[^\\].\" | wc -l
77

What would you do in this case?
2 seq_putc() in order to save a memcpy(..., 2), that's it?

It would also slightly change the behaviour, as only the 1st char could 
be added. Actually, it is all or nothing.

Don't know what is the best.

Any thought?

CJ


> That would pick up the cases where a separator is changed/added
> in a loop.
> 
> Could you do:
> 	size_t len = __builtin_strlen(s);
> 	if (!__builtin_constant_p(len))
> 		__seq_puts(m, s);
> 	else switch (len){
> 	case 0: break;
> 	case 1: seq_putc(m, s[0]);
> 	default: seq_write(m, s, len);
> 	}
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 
> 


