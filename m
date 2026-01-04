Return-Path: <linux-fsdevel+bounces-72364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D38CF0F4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A724B301C96F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3A2FABE7;
	Sun,  4 Jan 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iYLShZNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14321CC44;
	Sun,  4 Jan 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767531632; cv=none; b=VP3cSvs2YiNjhfxAcEWZbAyviWWlIi1LXx7a7tDASWu1XJgzfF9Q2LQBrfkuDisK6NxzONbPLrBxtKorZVQJHZ+qheZbS07G8aqJLdJFobRWc9T2/hSmBe1VhExmSlRPabohgktKiFr+rEz3WxTnQouu2wjRbMkzipRDOId6/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767531632; c=relaxed/simple;
	bh=w+Za7i0qZ9e6Cwm8z4YFFZyXszscJxU6c5gG0Iqi41s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LLt08yx0tjXEU2/WEzZxDnN8vZiVu1nU4n4JIEQZBdwNX+c/EOOSkebBYi1ivqFcugeNu78JMLW2KzVcUvjgaFrSI10LpH/6xELvSpy8iSzGRk8AsM9ZOGpl6yhr1i8qMfyyVcHEg/pYB1Uv44oHHB4a1NIte25hin+KYu9ELA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iYLShZNy; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767531628; x=1768136428; i=markus.elfring@web.de;
	bh=w+Za7i0qZ9e6Cwm8z4YFFZyXszscJxU6c5gG0Iqi41s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iYLShZNyxML7AIIUrQoK7lhKBEcUlDiBRkklW0XqGuL70QLSrQnF1OVub1eF1dDQ
	 t9WR9OSNnt6AND5DIsu197g7GA4WrZDxeIk+kx0l/YL/wOdAjzbVR27J/ZRwJoMi/
	 wfz7GsWeqXIfYES+HMQ9ST3bZO6BDrjyp+1q6/eaFEN1umKWCeYMAzefauqijES2d
	 NG27uSUgnP9S2Tfb4UmFVJMi3V+H96mVrMuiQJF1zrzB10TU00WoRLcpsBzRvio0k
	 bPomP+Fz+Y9ixPWSDulFbgjj4Ap7LjKftw0GRBXJKCeLCgDN/GDMWb//22OD7DsYl
	 vQ13HgO02JE6veBnrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.182]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1vVXIO3RNr-00GWfH; Sun, 04
 Jan 2026 14:00:27 +0100
Message-ID: <f81c3747-ef35-4726-a7b9-f69b99ed1d97@web.de>
Date: Sun, 4 Jan 2026 14:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ritesh Harjani <ritesh.list@gmail.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai@fnnas.com>, zhangyi <yizhang089@gmail.com>
References: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
Subject: Re: [PATCH -next v2 6/7] ext4: simply the mapping query logic in
 ext4_iomap_begin()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTkzsWA1lD6klQv053OAO2VjxhVYPiYSgMVwyUCszRCpFaAYN/l
 FD/jccq8mKC1XL37JjbdHVJUawhjigLERr8fooiIQgMd75+sDCgzi71gHKT4Uhmn50sKpVz
 HozNz3aLi8UWHmMBUzru7s67RD1ae0rbaj2Y8CR5v7aw0aitSFd5SD8KO7KKwflL05pZlKj
 KExOlO3TXtIA2KaPwpAWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hvsP5aVmQy0=;BKsjqClKkkOFLjzzwbhTEyaQIxi
 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

> In the write path mapping check of ext4_iomap_begin(), the return value
> 'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
> it can be returned directly without checking IOMAP_ATOMIC.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc3#n94


How do you think about to use the word =E2=80=9Csimplify=E2=80=9D in the s=
ummary phrase?

Regards,
Markus

