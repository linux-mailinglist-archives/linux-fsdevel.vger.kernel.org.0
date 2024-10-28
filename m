Return-Path: <linux-fsdevel+bounces-33064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B39B3140
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19BDB22CF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FC1DA631;
	Mon, 28 Oct 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="P0tbyf8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E8155C97;
	Mon, 28 Oct 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120530; cv=none; b=h3biM3tJRs5Al2/+d6oImLaV9PQXI39PbAH1G8MbMUn+NWTnTs+I4UeQriT4CJYLmQaP9HNW5IzxkKnlR3C3sLLCLXSt0ftgz/Qlc5/u5AyDi/Hmyrs0K+dxbQuOjPHTL4NFRv5qFYfWQ07gFZKy0sZm+SRwB92pr7dw9t08SfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120530; c=relaxed/simple;
	bh=bSxXCiT5Nbu+HDBzPcXQrjwXQbggE+FVpyv9r6mUuLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUGbhM8UKoIpJ/tfMNaSyv08Tz/cXpkiDyu9zwaf+7BdbWDY8p+F5yFLR66g2Yx2BeV0yHwuLxHL0fVSXl6Nd99HYZ6dy3hkBF1VJZy4mKuNZgxVS6LBu20rDVvOxrQVms7OVY8w8rPgNgqQq+4UTchUV1/JqmY2W2NA8nxZ8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=P0tbyf8x; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730120511; x=1730725311; i=markus.elfring@web.de;
	bh=bSxXCiT5Nbu+HDBzPcXQrjwXQbggE+FVpyv9r6mUuLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P0tbyf8xodvYsLbGzpTebYojgnzJXafhlmYYAUda7FxxfmsK+U02ma5KLhuZn+y/
	 hMnVTQPs0y0WAgxiUqDKNFB5m3Ow9VXqTm59GrbJjUVvUfOh4GZa0tsCJEg1EQhQp
	 xV/12EyiuIiL2TvRTDwnVXe2pnRdjNuRdq4UgECtJI9DnRZs3XNY9D06QtoGlAD4k
	 e+DO2N3Udd2ckZln2RHhl9GI6tCLxcS2LhQBk/dVEeFkfMhC5s7f3uJxesKf3bCH9
	 5nc9Oe7dZa1A9bZhbadc1VornZMIncG1ZBSAe0rjLRTK89pG4yqwbhPGAexB9aOy0
	 GdCbVOQ1XRBev6V2vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1u4gwK0WYb-00yDfG; Mon, 28
 Oct 2024 13:56:09 +0100
Message-ID: <4e6a5dcd-7870-4d1d-a29a-a3749af588fa@web.de>
Date: Mon, 28 Oct 2024 13:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
To: Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Joel Granados <j.granados@samsung.com>
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
 <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
 <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>
 <t4phgjtexlsw3njituayfa6x5ahzhpvv6vc2m6xk6ffcbzizkl@ybhnpzkhih7z>
 <582379a6-dea3-482f-86e4-259d4b23204e@web.de>
 <fpyvxkkhyv7gqbwayxmcglf2jh6gs65brbtojxxtpief4nm35g@l2jq7oab7p3p>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fpyvxkkhyv7gqbwayxmcglf2jh6gs65brbtojxxtpief4nm35g@l2jq7oab7p3p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ynb6ZeYgEpyr6G4Rc6wqD8V2BB50wnywktqzztcW5fUD5iTYocF
 tNObWf11qY+SthiGdkRpRNtpiRtu1P6l9UQGTQkq//+wb/wHJ08GtHd0L+OCY5fxH0/QJ2i
 sujC6zwlsz2Zzt8mhgdM2s15qR/TzKhrUayh4JMwcnjQyUs+itMs94aePR3p++GavPsSUMs
 Gbleu8OAK9V0LM6y+djHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CZvqSNMXO84=;r2JJuCgxFNdCtZP0a8wvfp+l8oi
 HHXp+HxAQbDO87w9BboVYoHIFybkXq0aROJ8RluWcH0fkpSZb5M4AgcGWl3rkhcEgmmwVNFCG
 alsg7EFGKo8pxjvghlkkh4iyJB/XBnhSFNTpmx53t2xbEZBY6XH+EeGdVd7MJHzJ2nHCeNFo8
 XUOqIM6oIquo/4BcYEBIXCqS8vewUCZotsddph8flw2/ysVhHLWcoGBFMF/JKfCrCM41Kjfdq
 fe/1/TM78AiT6CKiLRcjvWUhYTCfln+bgDsbK820dPrnv2xqyQdqcJ1GL9SYLv7g9uwVs+8MJ
 e+MRAsqsIVZp10JS+5+cg9vZWZSkzeXqhYpzo1kTmHd3KVdRy0SepCHW0BT1dbrSQ1SYVK4aL
 LvppFuSi6lEq3Do6rzbGT8HJOMH3cORazMq0fpc6sGKpQr4+LjrIJK9F36ITwXG9D7mRD2kjv
 7/b6Wzoosja7HPm4fJVIO0kwB7iJpP6gfzMn1rwd/i/aM0DDACQmorVYVdCJjcXA67phDtZAH
 Q0rCxm7Og220JVQBebe5l0aToUwaxP0EfDOrA8KZ5LBtrOv8do4lFnLH09iTSt9HU34akZGE1
 MsLC8MRWndFUNjTlJ/c5y57k/8jRMKUQW4ERTRvIC5lcJ+JzU0ZcyBFrhR0+EMz07JSMkFvPp
 jc87m+X68Q2zNQBI2YOEDpCfFn1t53sobspU8Qvwus9F8IUPOVzdB+xBGadap98bFnBWReKPI
 +7v43mpW0N/FRXL0u29RXCjAvgXHS86Q7JULBs40eUYMvJZymBdq5kkk4Vtde8FlHjmX75h+F
 T2/5Bpt8irkTE+q7DRqoI1+Q==

=E2=80=A6
>> This issue was transformed by using a script for the
>> semantic patch language like the following.
>> <SmPL>
> Aren't you missing a "virtual patch" here?

Yes.

I presented an SmPL script example which would not be directly used
for the tool =E2=80=9Ccoccicheck=E2=80=9D.


> Is there another way to run it besides this command:

Another command example:
time spatch -timeout 23 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Proj=
ekte/Coccinelle/janitor/avoid_duplicate_function_call2.cocci > =E2=80=A6/P=
rojekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20240913/avoid_duplicate=
_function_call2-no_loops.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Cocc=
inelle/tuning1/next/20240913/avoid_duplicate_function_call2-no_loops-error=
s.txt


Regards,
Markus

