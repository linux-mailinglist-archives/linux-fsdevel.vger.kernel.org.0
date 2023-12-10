Return-Path: <linux-fsdevel+bounces-5438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7680BC00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52551B209FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993317725;
	Sun, 10 Dec 2023 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNHNYhTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB7FA;
	Sun, 10 Dec 2023 07:30:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-336210c34ebso266795f8f.1;
        Sun, 10 Dec 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222225; x=1702827025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xaVMYhrpoa/YqfB7r9ICllcqtbstEQQi97r/qMUiRCw=;
        b=DNHNYhTpaCRmBRaCd6vk/OnJQBJeST3Iu8Le1Bkg3uhrVFowrB8YomqzLlKPfGfd7M
         03ss9rSj55OU/QuqozFFAd9D87yMpgBI9vQ6Keegp696u35pD8AmqZxDw5Fyz8oL5szm
         0m55UXOzHICxXzrqZ9lm8xfoUUKfpjzUhz9t/w93fH84vGK9PJ42OA4rTagnhaZTzbO7
         4mLoO7g0DL8HfGo8JEoctoGoBY55voKpOB3UJXbsrg60neOiP5B93InXa0h0JVYxNwG2
         77rYHVgB+eMhvgdmBewz7OCFfHd3mmg2mloP4r2Fd6NnSxDt3bwEwWA0StCEcR3FBDDR
         Divw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222225; x=1702827025;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaVMYhrpoa/YqfB7r9ICllcqtbstEQQi97r/qMUiRCw=;
        b=oQ1aZBHLp/8WEMxgiuH30+0pnurxnv88f9nuD4Czj+dQhy4GWGl3d9ckQ+Eq4mW3xd
         JNtwEtT99A7zk8OKjZyA5EJdz1D3ZwC4f/yZYMff+HwchOcUAZLCF24/J2VW6rfNQYtO
         h/ZwbVI8v3AiJXlitEUX1XreyGg00TbiAiqGM4Z7724di7xj+oz0QWkV8nmGw4Qg9J78
         HzOVZ40bGYP/+AEs0R8jLBjnJx1W0urF2xHi3JY4BpfaCsITc7Kkbd1JZew2r0Fn12u1
         czfSNyGkrNIya8F9fMxnPUiD7nVEnB2cuB9hP9PC02K+gWoxpG3GkegEk8yK7BdqRdXl
         /ang==
X-Gm-Message-State: AOJu0YygdEYuyu41Cn2YsjxQThV4BTMBNAdKPNdkWKowxe9FPAdFCpFS
	E6rIQFTbEVFI6nG3W9S4M3w=
X-Google-Smtp-Source: AGHT+IG2AG3IBlHUI7YtIdQyEH/qzPalkwYp9vjItbp41rRAxUIlbSJl40T+/hE6se6K2YudybHMrg==
X-Received: by 2002:a05:6000:111:b0:333:16:7a85 with SMTP id o17-20020a056000011100b0033300167a85mr1164456wrx.11.1702222224555;
        Sun, 10 Dec 2023 07:30:24 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d6392000000b003333a216682sm6508763wru.97.2023.12.10.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:30:23 -0800 (PST)
Message-ID: <ce4bd46009b9b0b8fb2dbec83eaa3e4c476bb050.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF token support in libbpf's BPF object
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, kernel-team@meta.com, sargun@sargun.me
Date: Sun, 10 Dec 2023 17:30:22 +0200
In-Reply-To: <20231207185443.2297160-1-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 10:54 -0800, Andrii Nakryiko wrote:
> Add fuller support for BPF token in high-level BPF object APIs. This is t=
he
> most frequently used way to work with BPF using libbpf, so supporting BPF
> token there is critical.
>=20
> Patch #1 is improving kernel-side BPF_TOKEN_CREATE behavior by rejecting =
to
> create "empty" BPF token with no delegation. This seems like saner behavi=
or
> which also makes libbpf's caching better overall. If we ever want to crea=
te
> BPF token with no delegate_xxx options set on BPF FS, we can use a new fl=
ag to
> enable that.
>=20
> Patches #2-#5 refactor libbpf internals, mostly feature detection code, t=
o
> prepare it from BPF token FD.
>=20
> Patch #6 adds options to pass BPF token into BPF object open options. It =
also
> adds implicit BPF token creation logic to BPF object load step, even with=
out
> any explicit involvement of the user. If the environment is setup properl=
y,
> BPF token will be created transparently and used implicitly. This allows =
for
> all existing application to gain BPF token support by just linking with
> latest version of libbpf library. No source code modifications are requir=
ed.
> All that under assumption that privileged container management agent prop=
erly
> set up default BPF FS instance at /sys/bpf/fs to allow BPF token creation=
.
>=20
> Patches #7-#8 adds more selftests, validating BPF object APIs work as exp=
ected
> under unprivileged user namespaced conditions in the presence of BPF toke=
n.

fwiw, I've read through this patch-set and have not noticed any issues,
all seems good to me. Not sure if that worth much as I'm not terribly
familiar with code base yet.

[...]

