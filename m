Return-Path: <linux-fsdevel+bounces-37935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64979F9476
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425537A3FDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7621638D;
	Fri, 20 Dec 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EzQvoGT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920EA215F66;
	Fri, 20 Dec 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705266; cv=none; b=ISkPl/DB4BLx7hVgS02dP8uGo/6gl5YzxMa4iA/B/j3o9ZwCzfDxGVTwXYEF06ZwOW4kotVu3TfA5qNjPPs59KpQ4PVQydKhjf34FlumCOTWTugRFteWOG8QHbOe4fC/F6y0DNEvVaSbyuCM4o8cXi6BDr51uryb9rNB7YLIVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705266; c=relaxed/simple;
	bh=/QgsaZGxWOTIhdITtBIUUC+iS6luLG8QYQ3+p+/HCOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSK2AvXfca74jCAexdDc9VgEqQOumZ6ABWNSgUbZzuilzJlVz6b9CMYPKgNtKRcgycsB0Sh7NeDCKET1z+7ZoErE6mdGppIhKTMLkthKcRdzgTbU50k7xtMDAqUYvF8Oe32SEdvl3FEDuurzSMHT/Dlv2N5pykSiVpj/DRKwcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EzQvoGT8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734705253; x=1735310053; i=markus.elfring@web.de;
	bh=5T0917byC1huSWtpTb769iZOPl3HsxjQatmAkTeKph4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EzQvoGT8akVJeYFTWcfJZrNtoWcJ5r4AgdAOQPyfhyce8xIkmzXZmxXrXLxC9llX
	 F9btkmShB/vu0yd0Fmv6eGxNMmpYZtOQlVU8gW5ZBLFFhqgN2NAn6+38nY9Ng6Rg0
	 qmXtZ7QxK/F/i1ZAwwDCVSo8zuG35VxHKH3hu2DCDQZ4oHhRB9ovH2HSdiidDmnFf
	 Ls9mudI8WzsznU/qmxtrOLiq8V03Pkul9T0Bm0PBGT33l0b+10zOLrn+rT47UwrgH
	 SksanIFDAyC8201GufYdscJdL9L/GEO0sNrYh4LWhRv0U3KavbVwW0rGRSOCISym4
	 f/wAffnkrU2JsZ/7DQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtsj-1tHoa40Mqv-00EzVJ; Fri, 20
 Dec 2024 15:34:13 +0100
Message-ID: <4256c3d6-5769-444a-84d5-3b416015bc34@web.de>
Date: Fri, 20 Dec 2024 15:34:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] seq_file: copy as much as possible to user buffer in
 seq_read()
To: David Wang <00107082@163.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20241220041605.6050-1-00107082@163.com>
 <20241220140819.9887-1-00107082@163.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220140819.9887-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VVfMjF3HkBj7R3rGza+9QgxWM4UrbeSIDlOwVMNBNVo0WUeQaJS
 TSBNXzGNLNzNkUIqc3IzznbZa2hCXWCCF5Rvu4prTlKl+HOvo4+p+ixxBynoQJdEoWD2xIv
 XMeoHGZjjbPPrvIqTp1iaXGf57zM9zo4BIgNEbiuAgH++FnOw21VLexjQCkI60VGfI3RXap
 UlGAuQ/f+FJ4Y77CedE4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iq4p8VkIdXA=;sbVzcdWdWDCqPdVmhW2l6r2vULG
 1qn6II3NNoyiNSjMeMdRgPNt06xfLbmnT9TsQtH7mzySre5uPTxuyOKN7dzddFuA2ganbp27v
 yvvH2aB2T8z8Jx3YEg+Yz06j5rrKfwUgatLfp2kmzkZFS2X2EBZ19Bz/EJaXdKGKwy+tHlbIs
 /qTDz3t1A5+bwu6lt6Id2yHTs9evW6Ns+9aZgIRHI1SdgT2hSIsAssuiyTxP6vNUseUjtfziB
 epLJ/GfLVIUkiFeIhBt+KFcjUYLj9v3qOiBIfcxpDK6Xf7KMAtVu/lJ1YHhJQVoWsJjF6ol9L
 WYjpnAZKzkdtnmK0RwSnjxV47fgZwv8dQTKlFaEHu+DUUsaeMX0YwVVNgzg6yJBmYtvemSojD
 YOiiEeTXp0WARQLmXYPj4C7mwqp8VyZdCswlNJtacD2QSSenvjfRd51l3FLkRTrMNuuYhrQoQ
 2ah9rCN53rbjBwOb5oNYK+JnIgBqJRS90FOudfFAJWW4Dp/aiLEJqwpGXkfhRqztJpY6RGnCm
 03cH92KcEF5jKg4fI1pKFCIIIDX2WH+1lW0sKetyFIa/Fhvy5Q2OVmiYbR+pX3Y5R/g1fcn2l
 wrAELch3DK8znJmcm8wNNpHScVQOXgL5pIlZcox5hqRE+ZTm9tokRa94Ba0Gl/tMEk5ajIJ+2
 fqjHbSnbBUUA0+7pEA+wGnGnqeuZU9l7qN5jxJTZH+mnfRvsA5zjLSdFAqyFlrKd218XbaIx6
 /CYHAFpwQ9NCVFKvZdLgYsogtsZkCfA/CJnud7eArPFFn0JAUj+AFRTi3ulFQR4bWjZcFSV9S
 BgsS9e1WW7/54yUmUaHdZpFkglrchHUZ+j1K6/USrk7uQQsAlNIED6Gbm9iCYe0g6Id/vh8bZ
 z9C8LYUYkTdCLFt2xzCR+GBkDIc/bL6XUWwMx3Zy6y4F8HEI9ORxcWZRm4Gw9ImRHs+qv3MoA
 P+jcSjOh/eXcAjRCO472y2Ghd38eOFEktyrnSMQFcbtwKK1NSn2qb7VS9VIlQju95XETFptOm
 Rag+671URusynVjjCp6tI27iKPjiI1T2HXk5GiIYrRQ6uslDsCccN+Bd8rdxTF74MLdUALlYW
 8QV6IL9+o=

> seq_read() yields at most seq_file->size bytes to userspace, =E2=80=A6

                                                    user space?


=E2=80=A6
> 	$ strace -T -e read cat /proc/interrupts  > /dev/null
=E2=80=A6
> 	 45 read(3, "", 131072)                     =3D 0 <0.000010>
> On a system with hundreds of cpus, it would need =E2=80=A6

                               CPUs?


Is it a bit nicer to separate test output and subsequent comments by blank=
 lines?


=E2=80=A6
> Fill up user buffer as much as possible in seq_read(), extra read
> calls can be avoided with a larger user buffer, and 2%~10% performance
> improvement would be observed:
Will it help to split such a paragraph into three sentences
(on separate lines)?

Regards,
Markus

