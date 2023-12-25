Return-Path: <linux-fsdevel+bounces-6906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E402D81E279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0225282072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B153E2D;
	Mon, 25 Dec 2023 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqqXi0IA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6E524C7;
	Mon, 25 Dec 2023 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbd87b706aso601249a34.0;
        Mon, 25 Dec 2023 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703540133; x=1704144933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk3BrCUhkF8HNi8hqkxjkr1dZsGMp84ddJ6VAzsBSHI=;
        b=lqqXi0IAgJ51KJw9d8Qsu7KCmXGSyP6cJ4y2ttk9IdKa97NR2pHY2CYdYoR7bWskFg
         MchvYxhCubWB3uTYJAyxw71QWzRQ108EDae/7Pve3DVY/3CorOJyWJWWNJD5j1NJL2ov
         GOtDMkj6LRw5wgIdQN/GqIi8Zxa8XbQCAAZk4LXhFhy7d9K+SkXuFZAgRo325v95B2y0
         VAzP81D85ttRdo7/EQWtp+6tbKUOseFYd/DG37mlanTAlzV35RBzHvqx5RKkvnYUnvB/
         b8P8CBcnWS+AvxGJ+fsfk5y5oibNGjMxJ8/LOOpgNGM77+C6tZHalcq1sczuVCsUO2JJ
         83fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703540133; x=1704144933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk3BrCUhkF8HNi8hqkxjkr1dZsGMp84ddJ6VAzsBSHI=;
        b=IBezbnbn1or/Ivft3+ebjtnEIsB0JqwoRXa07Pn9IY9LZAiiTR4LZSpEkqsmUQkydT
         udGbcc9mfiB0IfL6L19F9Hz92QRVGosdf+ddYHDQfa0LDdhguzokFb+yvR8hpDHi8Ka3
         Z8IJuFDZtACHxkjjNe4c6TuDP01xCoFkO4uaqrZhpAMCP1eg1WmoQA5ubOvM2oap78Ac
         7lmIyoJDQWZ8Rq6SSIkjRPrO82a9e8HyPpDc0BF3LN99o88uCy8icvmk3f0X2MaviLuZ
         bniR1bgr2cfvHEqKbOIWLzwkJHVPlDyywMuIc6L+hzc6J5tBUwGa+s37VuWmXob0uKU0
         44cw==
X-Gm-Message-State: AOJu0YyNkbAfbxRoDDiu7s11ThzUfH0fVEqneOlZMA130mVY4t1cyIDf
	TkIz/TMvlq8aeVLiTZxBQ+yMLk/X1dO0uiqtq6Y=
X-Google-Smtp-Source: AGHT+IF1ALMcZKnA4llsyBw7rVtGfnYUrZqqpeQaYHATEY6RAt9XEi5JjGL9mAun1x7rCUMA0cgxJM1hWmcGDvIbtRo=
X-Received: by 2002:a05:6359:c1c:b0:174:ed0f:672e with SMTP id
 gn28-20020a0563590c1c00b00174ed0f672emr2919571rwb.1.1703540132944; Mon, 25
 Dec 2023 13:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 26 Dec 2023 00:34:44 +0300
Message-ID: <CAPnZJGCdr7pw80Pq38UacmxsbQAowmasPtFxQVCP+tm6Cj9pUg@mail.gmail.com>
Subject: Re: Avoid unprivileged splice(file->)/(->socket) pipe exclusion
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man <linux-man@vger.kernel.org>, linux-s390@vger.kernel.org, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ahelenia Ziemia=C5=84ska! Thanks a lot for all this splice-related hard=
 work!

In https://lore.kernel.org/lkml/CAHk-=3DwgG_2cmHgZwKjydi7=3DiimyHyN8aessnbM=
9XQ9ufbaUz9g@mail.gmail.com/
Linus said:
> I have grown to pretty much hate
> splice() over the years, just because it's been a constant source of
> sorrow in so many ways.

> It's just that it was never as lovely and as useful as it promised to
> be. So I'd actually be more than happy to just say "let's decommission
> splice entirely, just keeping the interfaces alive for backwards
> compatibility"

So probably we should do this as Linus suggested? I. e. fully remove
splice by replacing it with trivial read-write?

--=20
Askar Safin

