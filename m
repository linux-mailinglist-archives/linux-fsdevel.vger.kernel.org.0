Return-Path: <linux-fsdevel+bounces-76884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAjfOWOOi2mhWAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:00:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EFA11ED67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB952307C54C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6532D0D0;
	Tue, 10 Feb 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="NPuaWvWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A53314A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753564; cv=pass; b=e8hccmQ60Boxa2/DJFSfb4ChF4HpqFweRBYJ2uVgOdw1tCx8LDnLRGtxFEp+9RekS2eun9Kj0TvtX9Npz7pMQU0iIGbe3e9j+LuHo0z0X6BuQQEnDpvthlWM/yHvHD8vksmRYDOrqujQ1J4HWi0wHcOxANVEPTm/W1m6Ln1ua6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753564; c=relaxed/simple;
	bh=GAcYHDM05raVVWAMUANcGMvUzKJFe7KRctF2QqxGS1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diDaNGGJnG9lfVElwv6ymu5KElGKcKcBntX6TyJxcXrpbRD6evHbd2HhuyyyA+H8IMda8OXDaimE13xpsR7MKwNXvRSK7f9pl64sJr0QvpFOKd7VkHXQyOfs+6FwaX35bVVIlrIxGXNt9H1N0gKX9wceDa21K+QF3M85KlR3c3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=NPuaWvWc; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59de66fdb53so4194599e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770753560; cv=none;
        d=google.com; s=arc-20240605;
        b=ik+rD9aJ4c8OxDD+3mmPOke6gBGM1TIEnEULlfhHy8VtMLTHJfSRqcJbJkmSJXxkdr
         HWohn6dIFosvhWEXrKgbJ4w2KoMcNVTffhRg/jfhszqv/Z8EiW6D2pXu5QgWDr2k761I
         tDVdUdah65c/OZgvx1JZFsuX6p/UWRX3aaMP/ZjLKfdkPeITA/bVBuSASUVjPsX/PB4S
         D9nCuF0r6M7SUXzABPazFu1jzJpLSF1gnjJ4DEak1+1jAdDpBN57S+sQIsm98s0u4I/T
         hmN7gbaFS4WMuCGuBGcTTJTcW2paXMpFR/HabjgeZysOy5N1DMFdPPEcAV3fBvnD9/wU
         ULrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nzw5m+4TgH1BqV3b1iIXSxKPoOg4yWtxz+G3n6SK2Gc=;
        fh=OuZnncv8xFOu4CDtgR8Du2z78Uw+GcAhcL82qcKCVEE=;
        b=O5oEtwROcLmCk0n9wQU//NDkA9/gqIwxxYGIZMsIyiZuKy6cIGLtFOmOnjHsdU+Muo
         r5w1ufoX3/dgfcrSdJds0XCyvv3tFFMbwLGzDMQn27Zw/doatTmxrxetyGnIhPjSE/pC
         uGJ4DzeTr4zpul+UFuNpYcXhwJ3xfSY6iO/uCbq18hTBEhHSYGGVOhJFNVqzcC4zV5Dx
         MF05WI/Xp55nRqf9wCvvoW5TDTh5OJkdAJL9IA0yp0Eq/U+JYhqG8qvKbHvmf8oeSRYr
         DFPk/qh68YY8KzkhG23JrJZA1ZbFaAGM6nTN/Uev0tfXd7sisbrmaeHNePY89sEtM3j6
         mNCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770753560; x=1771358360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzw5m+4TgH1BqV3b1iIXSxKPoOg4yWtxz+G3n6SK2Gc=;
        b=NPuaWvWcq4Wwii0YBnRKE4DAslOE6yedaYNWvPaTfcbuesHgQye2AsIXSv3Gir2ULy
         fiT2gxb5ucrYrVjiRz1TtCPAJ80Yw/b67JEOJFPveRkJxxxXnb6V6nfEGnGuvQqtFCW4
         wEmu2EcpYIFDPUbDISDbFDEPRhhuKYF/XovJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753560; x=1771358360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nzw5m+4TgH1BqV3b1iIXSxKPoOg4yWtxz+G3n6SK2Gc=;
        b=IvrvEMRAnpyjhWAp4favFqJLSI32D+/DRi0Cmfb4jKN17NeDX2Fcd7HsyasODwwQ7X
         wpRxI8vbDjEWDSEDJULzRMW0JyS+V9eiGpGm/oCkkthkjw4eP/DuPkJweyAxuXynd9vG
         M6Qpuj+lCqzu0mAYqKlZxvi0g4z4dEtnLvmldZifhILKtYrFwFgd8bbd2gkHtYRJsAz8
         AVErhN7WKdePh0MT+PCX8zBgC6dCfx2YBUvkw4Chdn3FeFBZzByyFx7DUIx0gEM9v20I
         CIOGzaBJO/GFcwp+Op3v1uPmSa0FbD3CDMeW4vHakzuWwSkJwqmlj0OwZaAKya5d85e0
         Jt8A==
X-Forwarded-Encrypted: i=1; AJvYcCXFaahYWqGVteEimYSrSmTMqg8WFSsxlxi+iPSL24+M1nPv2yz3qfcJnnBU4a2rlf1k9MvMfJ04gxZwzm7q@vger.kernel.org
X-Gm-Message-State: AOJu0YxHL5Yw0Ni5JJx8bJqTamXRbtyQJzX/+gAXuHq2ylQ84lFJ/VpS
	/xUECLPxeQvR+wKo63emAHplryLqEfv3DdvrBYiwkvuW+A6mPEV0Ls7QIeo+RiT55+kEDXPscvm
	lYguo1BLggCCP2QqLanUMVmN3crlo/gG84Xga4vg42g==
X-Gm-Gg: AZuq6aL1/3Rhx8D1OKy1zTr1t3saiIOYUc+RSlkaAfNOI9rOiI+jDNNxdVpq1o4GLFu
	OoPtiu824yGyJdkDgGpYQGl/oIvcpZ891w3c3bTtDib61Qjaf7bYTC9kSIp3VGK6FgtAppgTsu1
	dGP1XB1036LbAz7SUnGfHp7bXkbpySwrcZnXZnv3IOsgTmPWzmG8RBsuokNAbiG75BK4xRgfBoR
	A94SdJq1ZBShJRe3Z1rNedMWNGZC4x+3wpZhvzMcRZM5VBkY/FNFxb1WdSU6QF1aCHiynS/a692
	X/4SAn3jIf5YNoG3ud3I72Q24cWb2/t9D3T4veY=
X-Received: by 2002:a05:6512:2c85:b0:59e:38cb:2e2d with SMTP id
 2adb3069b0e04-59e5c2db507mr140749e87.30.1770753559975; Tue, 10 Feb 2026
 11:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com> <20260209190605.1564597-2-avagin@google.com>
In-Reply-To: <20260209190605.1564597-2-avagin@google.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 10 Feb 2026 20:59:07 +0100
X-Gm-Features: AZwV_QiUHp5Yt5UEwEQebOt4h2-FRofwh-qxLXTSMIijW9tK4Y_5N6CUeGnnSQU
Message-ID: <CAJqdLrpjW2TLKkhbQ-pG4tP=TFiJDcLGtGDrBqcxJnD+e1dZ9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Mark Brown <broonie@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76884-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 62EFA11ED67
X-Rspamd-Action: no action

Am Mo., 9. Feb. 2026 um 20:06 Uhr schrieb Andrei Vagin <avagin@google.com>:
>
> Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
> support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
> vector size calculation in create_elf_fdpic_tables() and
> AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.
>
> Similar to the fix for AT_HWCAP2 in commit c6a09e342f8e ("binfmt_elf_fdpi=
c:
> fix AUXV size calculation when ELF_HWCAP2 is defined"), this omission
> leads to a mismatch between the reserved space and the actual number of
> AUX entries, eventually triggering a kernel BUG_ON(csp !=3D sp).
>
> Fix this by incrementing nitems when ELF_HWCAP3 or ELF_HWCAP4 are
> defined and updating AT_VECTOR_SIZE_BASE.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> Fixes: 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4")
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/binfmt_elf_fdpic.c  | 6 ++++++
>  include/linux/auxvec.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 48fd2de3bca0..a3d4e6973b29 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -595,6 +595,12 @@ static int create_elf_fdpic_tables(struct linux_binp=
rm *bprm,
>  #ifdef ELF_HWCAP2
>         nitems++;
>  #endif
> +#ifdef ELF_HWCAP3
> +       nitems++;
> +#endif
> +#ifdef ELF_HWCAP4
> +       nitems++;
> +#endif
>
>         csp =3D sp;
>         sp -=3D nitems * 2 * sizeof(unsigned long);
> diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
> index 407f7005e6d6..8bcb9b726262 100644
> --- a/include/linux/auxvec.h
> +++ b/include/linux/auxvec.h
> @@ -4,6 +4,6 @@
>
>  #include <uapi/linux/auxvec.h>
>
> -#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table=
 */
> +#define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table=
 */
>    /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTE=
LF} */
>  #endif /* _LINUX_AUXVEC_H */
> --
> 2.53.0.239.g8d8fc8a987-goog
>

