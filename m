Return-Path: <linux-fsdevel+bounces-23644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A937930710
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12BAB2137D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E813CAB0;
	Sat, 13 Jul 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mVaYXeBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9913DDDD;
	Sat, 13 Jul 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720896305; cv=none; b=QG21428rmpj5aY5o+mgw2o7gICRHfZ3MWB1G6q7xsZfc4Tqp6BgMb6ohlfmWaUV6X4aO2CXwRTf+kMKJxuToArodobCge6dicVPFPgJjE/cmKMiBG9br/HVTG7SQeiI6CkUpFVAFMwHw4FY0EilPdSI1Whtajga0VqsttzdBfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720896305; c=relaxed/simple;
	bh=S4VHF1SncDJq0sGOKJ8UmXPy4Jk7J8435o2/pnX922k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IS7nP9VrJz+boHd6ubVW8d6PidPH+yWqvzqoy1Mlk/7YZcGXMsx6Zbu7u4OwyBDs8Od7vlfzTSdeUqqHzgEbdzQdnZ/ggrFZe0IftM01M0W3ubpF/OCTv0cIsSKO0mfIYTK0sbWFQ1bT0EV3Z4roYw9gruTOYNgm7QIyqjjddag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mVaYXeBU; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720896295; x=1721501095; i=markus.elfring@web.de;
	bh=Tl94jXHRVPHxXEsNK8QYCbwg6IcbsePXJwiPZ1IYb2s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mVaYXeBUhKnDonClssgvcoZRLq7wEZ4av2RDahQVJ8y428r7TOc2I7GtiA/zhIu1
	 Kjg5Pn8w3+M0LeFS3pEtBRm37Rg+98/hPJaoBG4eDu8FX099srvss2QyVDRAU+Mq3
	 OV1CoYIpdrsgjU2IoLwN94U0fDUodrxexRjlGPw8TcRVibtnUP/bZOEUlwpMVvo0K
	 pGYTysuvouY/TRs0YOZbY2QI13Xyxka0hJjxOxCakNY1Kr4uDET14c/I4zZOsYqmK
	 /rX5ZfqBhJCKSH5R9FEayfjH7BnXYASlD9cas0l1upH9bLxOB3K/XAescIv4lb0LN
	 pZS0FfEhxSF1Z5PRJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTGt-1rvppX3qO1-00bN57; Sat, 13
 Jul 2024 20:44:54 +0200
Message-ID: <aace3b69-d26d-4f4f-a584-97f1bcb59f29@web.de>
Date: Sat, 13 Jul 2024 20:44:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] netfs: Use seq_putc() in fscache_cookies_seq_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JmU/2zR/PKK4sSlgNuBI3f9yIhj/lxOWu4mkHIhjafPLe6M+1rt
 rl5qyE3nSYsi3evGHgxOrDpIeP6oEqGldhN8Ld4hS9+wBzEpU4Mqty6A5uhZGcYrq0Mot2b
 vRwe+d0Rgq374vNOCEkxuiTPPmyNXRYRIcRSHaHDCkrF5VbDThNWVLD8TXf1aN35d243Aj9
 tSbgi4jrNnLl9POykuEWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jKBRqTA+rHg=;iYl9a6wc/pomO0tBXDvrmEI0a4f
 cs3p7lv6SpK3XOrTTfTvJ3rL04LziIMKMrTjyOL0sNXi1FlYt00MJ0phhsClms0El9BrjULG4
 a9KTA98J6a3pqiyZXuHxmVrssvC7hZ4/FrQvSYdpDxmfnM+Uee7KoRzwL2iLqRBQRTpRG4hHX
 LT5kiyDhNmPQ5u0GM5LokfAFDOfmoUykJ9gVkT9wK1nwSNeyl74p9IKYRie+FzvgQCqur+qq/
 15NSnZ6vuzl7VlrSFbBZZwETDmh5NE5xk+vig6WB9qnHtecnn4bcs+zfUii/6XNwCwY3mAP/4
 mbIovkLekC5GOy5K+PbqELrxaoxAoVnv9jPnOx0oZu1psaiEoP4n+yV24FjuF4MKAKRbGcoQF
 2U5Dm21qfIgZsGNTdnWznBC7QTAsh34AooVel5Jmvms1VD2gMWFmEA7GJIIZl5bOjcsF3kG/B
 spY1Hw0B7OBjKodpv0ZphBC1hp4jCooRW/obXFS8SuYRv2M3UzYHci8GqA+edoGG43qRtl9FC
 horcYQv//MDKWU2nCuc17f2X3yvlOfPqDF6jyWwMnz+lRg0WPKQXYpdZeQQAC6hYPAzc1dZnh
 df6H7rwgH1SAiWyvqEMAGCe8Z5skeTyhc9Rhy15lmQC7Ue5GCBTAOWzuQHMtXUh/rwgpDHGJA
 WMyQ/pR+XpKcOFBTJNLI5olz1kWbq1oaabP0Mi3YbY//q2rTuRN/UjKbR7YBhZJ88fTrH5AuA
 s/1SMCZ4T2E3MXw/KUYIMAnrKdGnlivqiJlfMaho38Qqmb/XI4lFptF/lr+KeD7sWOHpl8/i5
 g2FNondHa2GcxnJk0kVzC/eg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 20:35:35 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/netfs/fscache_cookie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index 4d1e8bf4c615..5e490336b90f 100644
=2D-- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -1134,7 +1134,7 @@ static int fscache_cookies_seq_show(struct seq_file =
*m, void *v)
 	auxlen =3D cookie->aux_len;

 	if (keylen > 0 || auxlen > 0) {
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 		p =3D keylen <=3D sizeof(cookie->inline_key) ?
 			cookie->inline_key : cookie->key;
 		for (; keylen > 0; keylen--)
@@ -1148,7 +1148,7 @@ static int fscache_cookies_seq_show(struct seq_file =
*m, void *v)
 		}
 	}

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }

=2D-
2.45.2


