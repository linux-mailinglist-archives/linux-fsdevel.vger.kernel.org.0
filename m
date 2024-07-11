Return-Path: <linux-fsdevel+bounces-23546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F278592E127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92201B221D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3014AD3A;
	Thu, 11 Jul 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="n/6oZnRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC917BDA;
	Thu, 11 Jul 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684034; cv=none; b=a22BbKL27VqqjGN4XoHWA5E3c2HZkw3F5jZwEpC8hJKuKj3tiS+IXHg+uK9f/ZWDpCAUVYHJekCf7ailHVH38MJ46KBCW3UXBtPt0HU/ge4SpJlsp/UlETLuH2FU3KtQykOw0X1yzinG46F7J9aLGjlzMna7XOp9cjNnQuoP0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684034; c=relaxed/simple;
	bh=XnzfW3DG9X0+QdL29CqM/11d0IXE6lzFBGaQGdpUkds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qxp+ZgQplVaMD3jw6HjeZRApLnPYj0+RdFjT3pUL4+viqqzQZQamSKShvQPelSCj1fP1Gzj7vyF4Bu9U/mhhXLN6HOb+8ne/PosXSCaHC0UbPsNGi/OGOtRUvCRo7arC8EyHNtwR2AySvQCQjjG3/lU2o6+NuyNQjwt1JBXvKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=n/6oZnRx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720684022; x=1721288822; i=markus.elfring@web.de;
	bh=XnzfW3DG9X0+QdL29CqM/11d0IXE6lzFBGaQGdpUkds=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n/6oZnRxuJpdMunuLCl5bxESJ6u1QLCAadI/dvmrZ9wKCx8tMNFyBYFOyIgCX6up
	 13u/mZg/xCAYrXWIMHhTMc/v0nYcCe+qbcYz7r7+wsZjWXcTENgFqJxmjKFoQsls5
	 RUvK5zcPgfXKpCCUxLmPr1EujJRdKf0aJPBRS/JGcy0y5HK9wZqYsU69g4oTPR51T
	 Vlg4OV1EPxXF2KWjIhUx98H/vMa/117LIFij6UsGuJcqeW6zFkiWoykFIUsuGJSN9
	 ZN82847CUsVHCr5CUWqoodzoJKz4iapvZCpOgxwbLdNOg+mNIN74VGeYvgl3ckBo9
	 0FDj6a8dwhvLUaqNrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1sv4zo2Qfm-00X1Pz; Thu, 11
 Jul 2024 09:47:02 +0200
Message-ID: <5c191e5d-b64c-4e3c-9f70-9cd3371a3142@web.de>
Date: Thu, 11 Jul 2024 09:47:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 fs/bfs 0/2] bfs: fix null-ptr-deref and possible
 warning in bfs_move_block() func
To: Vasiliy Kovalev <kovalev@altlinux.org>, linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 lvc-patches@linuxtesting.org, "Tigran A. Aivazian"
 <aivazian.tigran@gmail.com>, dutyrok@altlinux.org
References: <20240711073238.44399-1-kovalev@altlinux.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240711073238.44399-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1JiinJ3+yc+LmeMIId0sYC4JYeGKm2xPQk5bWf/CF+whoVJXXD
 t9votmnCuvSxqD83n7ztYsfHSgZN43AbGeJ/M4k8lVuDJHWiUGenqsRCwkJPGRBu6mk2SeX
 D+jAatzFsKW+hV4BhYqX2oRfToRZJau5kp7V3f7ePt47TURtFI1+jyNT06LCkiu/+2olj4q
 b4UiFnprEj55xqJNSrlBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CTO1ztm/gPg=;gGeVZZwNzH4SOqdjktemmEnHUXE
 BHaEhVS1plRVFHcHV/ud0lBUaWeTmZKjihuEPpd1ZAQdMyllIX2Q42RwlmwSUqvwKceLQ6a5D
 JM+ZavHWVvQN6z4f36DBHkfXzarBkFPAoPc0ObfiI9CqzZZ2TbC2kro6AYuWTZe/T0gQwited
 mvLUy8Rb0SFfogP3BikpEI8DpPw5aoPwjT7ciipAtMbf1TyZNmp9grzjM2UinL0jjIz80iBBF
 Tz+qm8f/L0X3xf+jXyLqguaGuHi4LH+AUEsGux/sqPdeAHIOFjx3f8rTrPr46fqTaqY8bW561
 ddvNVezX6JKzA5rUSj0O0haTV5L9kdrnm9Q8t3RJNHqV+CcQZ+7QRtg7u7qqcSzsNTwliVqJp
 rB707EkyGbBTSBqBw0iT8LiivuRUCE+eYugTiI4KJD1XiZoempPyR7bUmfOA177rBABF/9O4d
 KkuuJR0KB0CDbqcoUtD3hlH0Nuf9nUFr6vAiZLCTm41PNqFzlSM1zsxktV0ZdkFhXhvn1Kkry
 cmeShP5Cz5AQQ3xqMxPLtxp8VGSqMHtBM4KSEx+iQbNKr+VUxwAYnyoeoz8yzTkT67I+VxMmI
 Hz38nd9iCo29zAZEePb7hptl3njYjlxdE4u3zDPaaZ72lMSRZYl1JDocl9Iz9LzlAZ2SwHNFK
 PkJUI1hhGyT4PSLjmDjOmHca/Z3Mmj3NKpdDX13dYPgQN3VzzEmo/rWyyfFOrQunXZpiSnZTN
 16G9pYOq8fmzmlfmDOAhp4stk8wFg0dwD8eRagRYQipBbcy+rupViMdB9J9VEp+kPbegXfPer
 1rKKDFYzbBtCi+ZmmfKeUeeQ==

=E2=80=A6
> [PATCHv2 fs/bfs 1/2] bfs: prevent null pointer dereference in bfs_move_b=
lock()
=E2=80=A6

I find it usually helpful to separate the version identifier from the prev=
ious key word.

How do you think about to improve the outline another bit (also for the co=
ver letter)?

Regards,
Markus

