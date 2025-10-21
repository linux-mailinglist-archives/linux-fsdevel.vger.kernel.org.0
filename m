Return-Path: <linux-fsdevel+bounces-64837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E0BF5788
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41FA234E8E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F2329C6A;
	Tue, 21 Oct 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cPSDq71Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489B328B69;
	Tue, 21 Oct 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038474; cv=none; b=Eyv4BflKEYzkQBUQHGizvtDEg0b7jpdITK/IZWvPbGeIJ8Dya95KiVUmN47e0PxwM6ujgFi5zfvSkdU55eBwLUvZZbRksPYwturSrtlxc5ZsMfzehz8G/gfhIYO1CB/hUSDAWdvbYSJatDx5Xi1+kKYLrc3gHqwlI9GuWbT+ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038474; c=relaxed/simple;
	bh=TBZnD1WQ6PJS+FVgTzOmxWZbuTrbnkqarwmJ+RVORYY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JhmH6CLGAQh44j7z7WvsIlWqMaeKNAeY68duMyCQ4tA7hhzogqEOY9TJWDVyIvoF+xAhcAvTD1RZCoI0YFQUbFZxSKle5Btw1eqf+cejaOqno4tR9ZAN0WjPLz8WoHqJcCj+8BvJY51jsygre0Ob6heflT+PbzygJzNAWgNiGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cPSDq71Y; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761038463; x=1761643263; i=markus.elfring@web.de;
	bh=gdT/BCdcd/mTiM1pGcyOCpP3L+W/oI0BI2+GhwVP6hs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cPSDq71YUdUjnTKrhD9T9UJBLL2g8/esAnjPdiI7Q5ymHG2AlUz+zKVwkylHRI8u
	 lwtwtHxV1l0Ucz9g9GOto49wIK3JPtRrXaVF8BdqzVPosquAPQmOPhp9HelkqOpaa
	 uhjvXP6eGnL8Uq7UcUH/MUHibc+P2eBPiPBFMa8Deaqt+d2L2teV6aqf6qeLhZObc
	 UH6fJnnhu/4uw6snDrGf74j2geV56T+hBiYwL0jb6a/smo4/8P9QqnVSxJ6ba+WWK
	 nVGPTESTb+lBLL8hpw1WtNZ7rzFvtCizEjJuTIXmITSRcZmkSeYu0ysF42pFcKTzQ
	 ehrvE8jOQsXH8jNMzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.255]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1udjnx02Z8-00ijfy; Tue, 21
 Oct 2025 11:21:03 +0200
Message-ID: <7d9a7fa8-4121-4239-8f5f-fb4268e148bd@web.de>
Date: Tue, 21 Oct 2025 11:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shuhao Fu <sfual@cse.ust.hk>, linux-fsdevel@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>
References: <aPdHWFiCupwDRiFM@osx.local>
Subject: Re: [PATCH v2] exfat: fix refcount leak in exfat_find
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aPdHWFiCupwDRiFM@osx.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aK2MNfAMOecS3nJjXFJr7ipwaW+KHxVNVCLrgU/YXK9qkBTCHFJ
 KtRc5LFjQnikqBsYzPSk+us4bMpafYiUg1EJegQmkKr062XeCZIaoyONhMgqa+g2J9Tr5q6
 SgLT4JAmuLMYRbI7pZKLUQEo/oMRl6ypl08ua/O4gSe8+n2tbs5n/Z9ytjGSnEAedzCRYrb
 53O4/vxkucqZKNYvThcGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CImlBrbDZ7o=;fS0w2a4PAhdh9q0VF9HUGsSwGB4
 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
 wZ5SQ==

=E2=80=A6
> Function `exfat_get_dentry_set` would increase the reference counter of=
=20
> `es->bh` on success. Therefore, `exfat_put_dentry_set` must be called
> after `exfat_get_dentry_set` to ensure refcount consistency. This patch
> relocate two checks to avoid possible leaks.
=E2=80=A6

* Would it be preferred to refer to the term =E2=80=9Creference count=E2=
=80=9D in consistent ways?

* I see possibilities to improve such a change description another bit.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc1#n94


Regards,
Markus

