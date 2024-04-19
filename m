Return-Path: <linux-fsdevel+bounces-17313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED18AB554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9276F281EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B619E13C3D4;
	Fri, 19 Apr 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Sd1KqtwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3ED268;
	Fri, 19 Apr 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553174; cv=none; b=FrpM4YgSASJ4+Iu1tgHQOykOjn2z4EEdF/vdKgUYF/utibCwWr20ncq+/tnn6bdzH691NuCnZtZA4IRLw/OUB+J9fJDBeGi7qsHqxeqEzdn4TbmPbzf0tzgmgUzm1KhOeNA7biuQ1hQkMnzglT7ucvQ8nIE8tdXZt0F8DhhmbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553174; c=relaxed/simple;
	bh=zc7hK6FmhDFh36aYZYPV5/Mr9PUKXJd7kPS4zb4mMvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejrSaHGlUKFsq4xjPw/yFbzHs27eFU2xryV9jgMqWnV8j8r9/xSHHdkT05xvjWbq3KchIUWn/++nYzwUOz7NBr0lwWMIGLWQCDfW7ZJKptZHmoQj9lxAz4MU6dEgLQqtNIEwn8BqaCR/iH5OkTWdEE/D7QZEttxsd/L1O5dX/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Sd1KqtwO; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id xtSDrOsn5GyaxxtSDrHjJe; Fri, 19 Apr 2024 20:59:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713553162;
	bh=2I3jLva1wdiI0o0x25jMo1zPcjOqTppfHxbSiAlKjg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Sd1KqtwO/Rb4T0qw82HGSZsYRymMWG/5jYRmGBZgv1LBFxlxicVu5Y/KiDq0UxPtA
	 FZ3zbI5ji/wXRqwW2faLWd4iU/gBxGWhx8othrjCdlWXsjgR01nM3vjgrdopg3y1J3
	 jVoyJTP5WyXwTxT0JmicNp80aUB2jTk4JQZOkWg4yRg+af9FnPeRKHWdyHuasH5vnt
	 L7/peiyJJzfDMIlDJpxmIB+sk4TOmyzRZoa6UZGTgo/h+pLM/anuGSJRmMXO3pMYT3
	 gK8ukZhFObXuVPfxBx25BWo3NjfSb3K9uUtcHGCkKaxhoBwjsHOSC9JADxF9gjS+Rj
	 /frL5tAsu9qAw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 19 Apr 2024 20:59:22 +0200
X-ME-IP: 86.243.17.157
Message-ID: <86920c17-13a7-4cc3-8603-ab6d757fef56@wanadoo.fr>
Date: Fri, 19 Apr 2024 20:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
To: Al Viro <viro@zeniv.linux.org.uk>, David Laight <David.Laight@aculab.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
 <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
 <20240417010430.GB2118490@ZenIV>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240417010430.GB2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 17/04/2024 à 03:04, Al Viro a écrit :
> On Tue, Apr 16, 2024 at 08:56:51PM +0000, David Laight wrote:
> 
>>> static inline void seq_puts(struct seq_file *m, const char *s)
>>
>> That probably needs to be 'always_inline'.
> 
> What for?  If compiler fails to inline it (and I'd be very surprised
> if that happened - if s is not a constant string, we get a straight call
> of __seq_puts() and for constant strings it boils down to call of
> seq_putc(m, constant) or seq_write(m, s, constant)), nothing bad
> would happen; we'd still get correct behaviour.
> 
>>> {
>>> 	if (!__builtin_constant_p(*s))
>>> 		__seq_puts(m, s);
>>> 	else if (s[0] && !s[1])
>>> 		seq_putc(m, s[0]);
>>> 	else
>>> 		seq_write(m, s, __builtin_strlen(s));
>>> }
>>
>> You missed seq_puts(m, "");
> 
> Where have you seen one?

Based on results from:
    git grep seq_puts.*\"\"

there is no such cases.


>  And if it gets less than optimal, who cares?
> 
>> Could you do:
>> 	size_t len = __builtin_strlen(s);
>> 	if (!__builtin_constant_p(len))
>> 		__seq_puts(m, s);
>> 	else switch (len){
>> 	case 0: break;
>> 	case 1: seq_putc(m, s[0]);

missing break;

>> 	default: seq_write(m, s, len);
>> 	}
> 
> Umm...  That's probably OK, but I wonder how useful would that
> be...
> 

Thanks all for your feedback.

I'll send a v2.

CJ

> 


