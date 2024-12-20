Return-Path: <linux-fsdevel+bounces-37928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CC9F91F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7570B188C605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE61C5F10;
	Fri, 20 Dec 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eiBkUleH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28231C549D;
	Fri, 20 Dec 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696824; cv=none; b=ImZ0mF3saMkeuS/gDuJOpVkU9Fj3/XovMYId00GQMLw1+JeYMehfdQ1vcH8pkduoT4/rOSnx9Bpk5WewjRuwQnFuyJYQMslcsm5KrwP0qPdOe0dnVPgKRrq2xAFED8ivn9azd1+aDgBDqrELASASl0J1RgoHgLFKNudJrJuVPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696824; c=relaxed/simple;
	bh=l0QV3pCfNvTEaAr2tp5IR6Nyt9OZ/n9ia4nnm12cf0Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EImn8QSaTYx88SONIScOYilqi5JVR4DgAn892rFX+n4+aGXr0bH/JNUef+Px4l/vY7/bWI00gI5iuAIVm95P7aY4trXHBy3OdQLJ4K5cyEAhO6CWc6UwFngAKk7RqCgjDfN323clQOXuK7ykhWwOEXRiVw6ETSxGQoqVT+WL6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eiBkUleH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734696803; x=1735301603; i=markus.elfring@web.de;
	bh=l0QV3pCfNvTEaAr2tp5IR6Nyt9OZ/n9ia4nnm12cf0Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eiBkUleH7S96Qiv4WR7VxwUr19IBYVgVOFafXpuBMphrSVd8y85eYqeBuKeRgQmB
	 TaiEhAO+fc2DN92vSax7oe3HD+2aYjashIDVvwsLkOzd0sKfgdmmIMZR7ySOgskyY
	 x8HOHxoBkdzyprMo0MKIKaMGeRhY0EI/DaL6nFoltx4AUDnzW++jINYrzqlJhuTSv
	 9TEHX1qnqSrDI8MewypA80/muqCn2UDDLuoMOTNLxVcNKp16uqPMf+isE/jutPeAb
	 xqpNDFJmSNFX26/9rnVsUcxCvTgUND3skX/xZ56nDMSTXtQ1pmlLEOGfIoSweJIuc
	 tKaaarcu8pOtLPY5GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1tn7ii1d19-00vTyD; Fri, 20
 Dec 2024 13:13:23 +0100
Message-ID: <18a1ba96-86d5-4c89-85f5-d816808e7735@web.de>
Date: Fri, 20 Dec 2024 13:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Wang <00107082@163.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241220041605.6050-1-00107082@163.com>
Subject: Re: [PATCH] seq_file: copy as much as possible to user buffer in
 seq_read()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220041605.6050-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNHzAjhlC9pYUlTg22o33E46vj4ldFHQ1M9h+Ve/1S3tqH6DGBj
 Pxd5yniTW0RaGPNl6OBtcBaI3mhpo7ujVWgR1ZE2f9IirC1C/VO7vnVK2syW85rgpUdhYs+
 No6lKcjZpO8/rFzvAHEeTM42UEiq6DrZAwCT24D+3oMYyyROnNjBbyYp9jHeIOFIsUY/Up6
 NYrGcfFVd98hFvINh9hbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fqrwgblh1xM=;l+7bQwjTg0IDcWlzPjrDex5zUV6
 5B5vUwWLxi132UdfN+mG3+ODC+WotgBJ7tmFJOs1c14JdlXg73jcz+Lda9FfRBG8ctJinXrcD
 kTEOCISgX21NnR7+l+oHzgFyABtXPxmgeZgg0C71z4kYfD02unm6zap+cdQz1jgznelBZ7Zie
 jrkiMW+O+owVUUVWWerm/nNSln7byFn00fW/LxtieRaxt6Ia3dnyFjK0/Cp783IG+aJ2+7tz6
 gA2FDAQ3I7gjk8fci8KihkRsMVKj6FUEJgrY6lI5bwPn4uQ5LRD+0sc8TsOp4XogQBw6CzEO/
 P268oOD3hmmNuP34Kwl8R+vqWwuVD1Tf1VOqCrD+0NW8paSa3ZaUGNGHeAF2JVlYyLALNBK86
 AbQT/NqUfGmqep9WXSZOb2YiFlHOEMBR1nGXYhYilalKPq8yTlN3FFLpNPQtT5u3WE2pdGDLA
 jpjuJPJ8TfLS7Z+sOadTIMyQOuiUfZDKD42Ryc4DRpWbn0IqGh3AUGkv6d+cO0WYKc2eTVqRs
 4RujnWXf4uXxl3utiXayCn1ymd290Ld6fjflWMSzxospLKGGgUIN/ivbF5sa19YxPExyBxV2m
 huEyKRW3ZooPTPyJYyWHplWtAyvQdmnI15hpXxlZsRqA2UBjo1afRUMSEF8ol6ge4bjtBFEAR
 gRhcZFHDcRJ35B84fAuMm+jTaai4eZKwYA+yFKaC7Y74nKee1tUZItbsmkMHffBegKrwcnHBB
 Yg9QAm5LsnABiuT4i0lfwehMk9V8+BEEzXcVtJyabZA1YEuje+AXJ1QvMSDvjmtbDKPAzqQRG
 8FCdZJ2Q6OOtiFYG87nnPlsGZmA2OjMkTbfE8qCCtzE1hXQFCl6jNXh/93E4iAs+TOQNzD7Yo
 t2KVBZ/B3N2eOPRq7TvgKeBD9SMvrUhmlj1JaYdl8bQJcXCO9GGDFQ2N5UN+pDFBsqKcRBdqY
 D2QisGDwg5aOSgxbzi3dyGNm6D458W9xt8jKz1L5t5xAiQtOTIXP457Aff4oRoNkVqqQdEQSt
 ZX07vHUar8SeMh16crpvUDo9m+Tnn69YFMQd7gwVeufOZrRtkhfe7/FJs+KWPUKTTiOgeAYQv
 pn+gJDvFw=

=E2=80=A6
> This patch try to fill up user buffer as much as possible, =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n94

Regards,
Markus

