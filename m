Return-Path: <linux-fsdevel+bounces-7001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9581F839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CAF28431A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3F7499;
	Thu, 28 Dec 2023 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muvb7i96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AC2748D
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7fdde8b26so265809439f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703767086; x=1704371886; darn=vger.kernel.org;
        h=mime-version:to:subject:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lxdWpiTQMypmLfIse7Av+VzLCeqyUaMayXpEzw/GSw=;
        b=Muvb7i96nq56FiMjt1061j+UkcrHbCwfzNq6Malr5VarQPhitLHfx5mE/Zc4p9L4vN
         RzgHvuMAkxuZWVabgLbyMCx1LvS2S2tLUf1iUWbHQjTvkPEgelp7hH7I9+JnnoZIkmFs
         nYXHHc0hq37P+ctw+llFMGmdzApCtfOAXJLw2C04ByK/8o1J1hKmeHlOD0wYSagwIkZF
         pM0iLhstzNVA4srKNdKM6bRnGEVrsiLtRsSh1yNugVIBxsXi1zv7gPC8CiaZRRoVentD
         iCJT3FaVt2oJzVsTlLY2oqkzM88fMmqkRZnC4akJxCRcJtloIpG8uyYgx4+VY/Jm715H
         Pc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703767086; x=1704371886;
        h=mime-version:to:subject:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lxdWpiTQMypmLfIse7Av+VzLCeqyUaMayXpEzw/GSw=;
        b=K+gNqTArdV8GJnvksFaFF29XU9LxeJlb2ADd4ERGiZXmeYVPJkrgFYYjNdWvGLPAkd
         q7zOocnpyOWU0lXiBU7pTwEu4VpIevaHxXjEk+yd6jXfcgs01q6hVNjpQIf+RK5EqQMF
         IJgTU+bC9Zg3eke4pAmco4bikC7clUTMJGhEIODdIuIwsyIrsGDboFIfrJCmdZtdpbIT
         wuXc6pcoZSoCrM8RfmJdDlWE69I/gCOHk0L0MCUuEYtEfExueZdo3rSKzWFUq0c8GSh0
         82e04gdrzaLAqkrbow57Cv8TWuacCGoaJXQU39oJEqlhuV6E/WYK1KUeUuWKUBEie21p
         Ollw==
X-Gm-Message-State: AOJu0YzbHJGU8PAEJkm2uAXN88qOcX2ikW7wNWiIUwRnqQx6QgLJU4Rl
	FMV9xYYobihoydRCMUsG8BuNbutCxooZoVR2bLk=
X-Google-Smtp-Source: AGHT+IHL/CtCduJZDKY19gL/lsT1cxA2bV1kHbaiTVB6FIlCXzrTJ6XtxaDXx4OXFvKNIk5x4BN2SQ==
X-Received: by 2002:a05:6602:2c4c:b0:7ba:b555:a91 with SMTP id x12-20020a0566022c4c00b007bab5550a91mr10698688iov.36.1703767085795;
        Thu, 28 Dec 2023 04:38:05 -0800 (PST)
Received: from instance-3.us-central1-a.c.hidden-server-403811.internal. (2.173.184.35.bc.googleusercontent.com. [35.184.173.2])
        by smtp.gmail.com with ESMTPSA id e6-20020a6b6906000000b007bb2e9e676asm481976ioc.43.2023.12.28.04.38.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:38:05 -0800 (PST)
Message-ID: <658d6c2d.6b0a0220.5d3b2.0b0c@mx.google.com>
Date: Thu, 28 Dec 2023 04:38:05 -0800 (PST)
From: gtegvevtbe9@gmail.com
Subject: Transaction completed Verified Parcel status Order completed Pleased
To: linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8983611217665744335=="

--===============8983611217665744335==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hope your doing well
linux-fsdevel
kindly refer to your purchase-receipt   #500697
Thanks a lots 

--===============8983611217665744335==
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Invoice500697.pdf"
MIME-Version: 1.0

JVBERi0xLjQKMSAwIG9iago8PAovVGl0bGUgKP7/KQovQ3JlYXRvciAo/v8AdwBrAGgAdABtAGwA
dABvAHAAZABmACAAMAAuADEAMgAuADYpCi9Qcm9kdWNlciAo/v8AUQB0ACAANAAuADgALgA3KQov
Q3JlYXRpb25EYXRlIChEOjIwMjMxMjI4MTIzODA1WikKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL1R5
cGUgL0V4dEdTdGF0ZQovU0EgdHJ1ZQovU00gMC4wMgovY2EgMS4wCi9DQSAxLjAKL0FJUyBmYWxz
ZQovU01hc2sgL05vbmU+PgplbmRvYmoKNCAwIG9iagpbL1BhdHRlcm4gL0RldmljZVJHQl0KZW5k
b2JqCjYgMCBvYmoKPDwKL1R5cGUgL0NhdGFsb2cKL1BhZ2VzIDIgMCBSCj4+CmVuZG9iago1IDAg
b2JqCjw8Ci9UeXBlIC9QYWdlCi9QYXJlbnQgMiAwIFIKL0NvbnRlbnRzIDcgMCBSCi9SZXNvdXJj
ZXMgOSAwIFIKL0Fubm90cyAxMCAwIFIKL01lZGlhQm94IFswIDAgNTk1IDg0Ml0KPj4KZW5kb2Jq
CjkgMCBvYmoKPDwKL0NvbG9yU3BhY2UgPDwKL1BDU3AgNCAwIFIKL0NTcCAvRGV2aWNlUkdCCi9D
U3BnIC9EZXZpY2VHcmF5Cj4+Ci9FeHRHU3RhdGUgPDwKL0dTYSAzIDAgUgo+PgovUGF0dGVybiA8
PAo+PgovRm9udCA8PAo+PgovWE9iamVjdCA8PAo+Pgo+PgplbmRvYmoKMTAgMCBvYmoKWyBdCmVu
ZG9iago3IDAgb2JqCjw8Ci9MZW5ndGggOCAwIFIKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3Ry
ZWFtCnicdVCxCsIwFNzfV9wsmOaladPMHQQHIWRwEAepoogVq4O/70tbpQhNSO7u8e5xSbaKB5xf
yOr4QDNiHUkrV+hhIe3ltGAqNXJUnI8cTUsdOgoU5P5i8rbk2KnUw4XI21SytqUqPftK6vpfpuYL
bRe49wNlnKq0NiY3Ofex/rVkSEGNt8yuxByP9Uamv2GwlnPFbi/eI1ljBa0DezxPFH9vGf5gxhUQ
6ANv80LfCmVuZHN0cmVhbQplbmRvYmoKOCAwIG9iagoxNzMKZW5kb2JqCjIgMCBvYmoKPDwKL1R5
cGUgL1BhZ2VzCi9LaWRzIApbCjUgMCBSCl0KL0NvdW50IDEKL1Byb2NTZXQgWy9QREYgL1RleHQg
L0ltYWdlQiAvSW1hZ2VDXQo+PgplbmRvYmoKeHJlZgowIDExCjAwMDAwMDAwMDAgNjU1MzUgZiAK
MDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwODk4IDAwMDAwIG4gCjAwMDAwMDAxNTcgMDAwMDAg
biAKMDAwMDAwMDI1MiAwMDAwMCBuIAowMDAwMDAwMzM4IDAwMDAwIG4gCjAwMDAwMDAyODkgMDAw
MDAgbiAKMDAwMDAwMDYzMiAwMDAwMCBuIAowMDAwMDAwODc5IDAwMDAwIG4gCjAwMDAwMDA0NTcg
MDAwMDAgbiAKMDAwMDAwMDYxMiAwMDAwMCBuIAp0cmFpbGVyCjw8Ci9TaXplIDExCi9JbmZvIDEg
MCBSCi9Sb290IDYgMCBSCj4+CnN0YXJ0eHJlZgo5OTYKJSVFT0YK

--===============8983611217665744335==--

