Return-Path: <linux-fsdevel+bounces-79342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAYdCH0OqGk8ngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:50:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E4D1FE8CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B453037152
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676C3A0B3D;
	Wed,  4 Mar 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI+s4Kx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6634D4FE
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621420; cv=none; b=N/zFm8U74sdw8CfXw/Il7SwDCPtE5V1Eq87LjJ6KJwyD89KyAaczC0UvVJx0QozdZE9MmGawqpJ8PasJ2/bhSpunwUdiEosHk669s4M5rGz/QUsawHAN2e109+Yg2IGdKVokpi9w6hkLD705SqPKL5aXC9+y065zNUpsnam6vlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621420; c=relaxed/simple;
	bh=5daFPy402h8ECba3AHJJY+pyR4PgUs7bwOQDKQJvEB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD53ltSuzBR5ikc8s57d4PCd1rgKnqn5NblxHHdON1ArFpYvAMNh4/hM4GT9FdemODpH7vdf1h6uMBibakzDmcLqoQQcJKBAuVAwcpTJkSvapeDRpyiNuaCBnwz1FGfgKLFjSZwM5C3BnpqBajY2jPwOaRe0ZQwA/2dpkwKV26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI+s4Kx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6E4C2BC87
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772621420;
	bh=5daFPy402h8ECba3AHJJY+pyR4PgUs7bwOQDKQJvEB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VI+s4Kx/g8w8hTc/TMWyP2jBXRGcg5oUXTTDPLxdh629nUrMjJk+XtRW+pUQlqfGs
	 Z8bhwb/ZSnR7rnOIkLe+RqgXUHaZPRd8QD/e5tFYqlc/RbE9yqM+w2wSvaY04YuUVe
	 IoMLtjXOi213saY1yvcJ7fdXcu1ZkBGv9RllpLv9muLL9EwBJghqKAE8rjJJorELgo
	 odB4yXgsb9Zc985g4kUCwsGDvmXyNA4zlXzIt3IgcxHr+lzeiXr69kJkdQCMQNdYvR
	 KVDRYA3P59y15mZJDx8GJZk9+hlwuNDFafDBlHcVB4mldaYidHL5tH3iC5qThFyg8s
	 DoVZZFhEOh0kg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6611e4aefdcso94940a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 02:50:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoGJCblKqPLADc/PBG4ulvT2PIRJyXw4UM3faYQ2nSVl7Aa5tX8PohinG1pIfWGhNRDlsxzYq8A6/QUYhw@vger.kernel.org
X-Gm-Message-State: AOJu0YznG1tv06/tFVVUFr1WyLFWJjuwi6yR3vQozOgKYVDcAQ4pIO/6
	JxnP1sQuMPSVlCuT/SqWwNJT4ph6+ZkNf687y7blPsqQznlwqaSDNrkW4Tyu9Nx+q4GWqieJxvD
	XADQ31s2nGUiI0Evu0IynS0z+vlKHNCo=
X-Received: by 2002:a17:907:2d27:b0:b8e:a179:3331 with SMTP id
 a640c23a62f3a-b93f11e4011mr105671166b.5.1772621418838; Wed, 04 Mar 2026
 02:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304083839.725633-1-arnd@kernel.org>
In-Reply-To: <20260304083839.725633-1-arnd@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Mar 2026 19:50:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8=wyLPswVYaq_BBQYGy3CvehZL67NZfSev0_zQAy5ExQ@mail.gmail.com>
X-Gm-Features: AaiRm51iW68badzuAALgpMqz9CM2l5DTbohr7ydeMdezgGawMl6E4Tn19XsJ70E
Message-ID: <CAKYAXd8=wyLPswVYaq_BBQYGy3CvehZL67NZfSev0_zQAy5ExQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: reduce stack usage in ntfs_write_mft_block()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Colin Ian King <colin.i.king@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74E4D1FE8CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79342-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,arndb.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 5:38=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The use of two large arrays in this function makes the stack frame exceed=
 the
> warning limit in some configurations, especially with KASAN enabled. When
> CONFIG_PAGE_SIZE is set to 65536, each of the arrays contains 128 pointer=
s,
> so the combined size is 2KB:
>
> fs/ntfs/mft.c: In function 'ntfs_write_mft_block.isra':
> fs/ntfs/mft.c:2891:1: error: the frame size of 2640 bytes is larger than =
1536 bytes [-Werror=3Dframe-larger-than=3D]
>
> Use dynamic allocation of these arrays to avoid getting into dangerously
> high stack usage.
>
> Unfortunately, allocating memory in the writepages() code path can be
> problematic in case of low memory situations, so it would be better to
> rework the code more widely to avoid the allocation entirely.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied it #ntfs-next.
Thanks!

