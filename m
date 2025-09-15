Return-Path: <linux-fsdevel+bounces-61296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23533B57573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7783B1AA0049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD372FA0D3;
	Mon, 15 Sep 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U2d3rnO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457932777F2;
	Mon, 15 Sep 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930581; cv=none; b=CxUvA7JOBniMzZ3RCiX7J4v1/Wd5PJFlUHcsjsXpKOWIJqtMhq3jA534eCeUwWwNAwGcoTjDOmyk0oWiVAa7ccYHN3L44sOoum6bSWhDls44RNiIEpnoJ/QdGpbYtk/hnGRe10qM90r9XPLamDN55NmwImSaO1Z+kCTWlPu1UnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930581; c=relaxed/simple;
	bh=tEuo7dUHSUktp9AudaN5WSBqtp1xBhez4IXo/pFJGdI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OTPVrbYPjEFtiaEFTbaCDKPvxzCVzZsuQDltVF3Z5Kd4kuKfVsmfyb/zwE5OJclaaU5VIF4KvMp1R6yRpEXuYC3RjCv+od3aGT19FTtEz+UkxtOQFmrA41ZF0Bt/yLZX8eITsvz9nd0xXRfuv/K3b3aWjj06Ycgmp/kNmbtUoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U2d3rnO3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757930577; x=1758535377; i=quwenruo.btrfs@gmx.com;
	bh=NlzUiQkOWaiQRdovh/MbbQk0N2o4ddT6HvP/SBnpXhQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U2d3rnO3R5btDPjlQrn+lajJ0LSg/ubkTQvIePy464/1J8GPpTxSnhuZ+beKpBth
	 3nvKc0bJ+2GsBg5Ul1VcGyCxpdwzgj/iEcmJtYPDhQI1SbzxZfo0c1HtHls5eD8JH
	 LFOt/gdgj8U4guINUJLKkJ+iFKTyPdpXO87kMW9lfmXrGeWL3dfE5Wi+De1SqlPWD
	 xJdULmPwQHmu0JfI69uSFpXrNUmqMjdEvDK3qoQkVk/4gVCfLK2H0mZtaaCv+od4z
	 fkW9RBw5MWdnwtV9T+mLAjWHRgY5v2yBWkhGJox3GaZYr9kye7HYlYUED5RzUelPp
	 b8xTCGvyIDvG5on8pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1uECu61HNO-015Aol; Mon, 15
 Sep 2025 12:02:56 +0200
Message-ID: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>
Date: Mon, 15 Sep 2025 19:32:53 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Any way to ensure minimal folio size and alignment for iomap based
 direct IO?
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TL9DUZXO/CJ/ReamPYWSTjn4vDmGH2+nvRLX5hwNcwQBzBYW06H
 QhhBk6ifzQ4y2zwuPDIsK30sOa7xoFrPlHpNo8Q8pq9ceNp8WMTw/P2dhcvGqs621WtTPdE
 CstR11qrCwNlgrWXkJuElstz9824LvbDwLwdcHuRnEnZ+6kUI5MMiK+pIfnP/0csn2Nli5m
 0GEFpypCWeIjTpLj2iiiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4ar8ZKJ054g=;rgA1x3a70IxJVVeg0kdFZLLqDv0
 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
 QFqP3unnw4gHbBu5cADEqUQGGBc2

Hi,

Recently I'm implementing block size > page size support for btrfs.

One core point of the bs > ps support is:

- No fs block is allowed to cross (large) folio boundaries
   This ensure that the btrfs checksum routine needs no multi-shot calls
   for a single data block, and ensures we can use a lot of
   bio_advance_iter_single() calls to move to the next block.

This is pretty easy since filemap is already supporting a minimal folio=20
order, thus most part it's a very smooth sail for buffered IOs.


But things are going crazy for iomap based direct IOs.

I'm getting the following bio during my local tests, which is using 8K=20
fs block size with 4K page size:

[  130.957366] root=3D5 inode=3D2464 logical=3D15974400 length=3D8192 inde=
x=3D0=20
bv_offset=3D0 bv_len=3D4096 is not aligned to 8192
[  130.957376] i=3D0 page=3D0xffff8cc616e96000 offset=3D0 size=3D4096
[  130.961977] i=3D1 page=3D0xffff8cc61730e000 offset=3D0 size=3D4096

The bio initially looks fine, the length is 8K, properly aligned.

But the dump of the bio shows it's not the case, instead of a large=20
folio, it's two page sized folios.

This will not pass the btrfs requirement, but weirdly the alignment=20
check for the iov_iter at check_direct_IO() shows no problem.

But unfortunately I can not find any folio allocation for the direct IO=20
routine except the zero_page...

Any clue on the iomap part, or is the btrfs requirement incompatible=20
with iomap in the first place?

Thanks,
Qu

