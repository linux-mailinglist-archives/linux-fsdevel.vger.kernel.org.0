Return-Path: <linux-fsdevel+bounces-77248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEiTMcl/kWl9jQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 09:11:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE66C13E468
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 09:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 575F63003BCF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B62BDC2F;
	Sun, 15 Feb 2026 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt2M0ZoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC195231A41
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771143105; cv=pass; b=eRcend4fI90VKJ1gMtaOud6yEReRmequ3OnRk5DNfjABUeCRP6sYRvG6UjyhmB9I3sGYq4xe654xW4lh2OkTE8n3FISrjkx/rD9Z1jU7ZFYvtrKJ+SgOqcVKHbPbvcvCdN9gNm5dJLBcnT9sYN/FQXAkSJRQX2Yy/U2PQlqZ9Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771143105; c=relaxed/simple;
	bh=DTDk7K5Zkqtnt5fprRdhYF0zEccC1vT/ncnySQAaQkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKa2CwXdGJJug/SvJBYuUhpviiUSPMuotIqymvXOHieTElPzVteRhncz4NnsDgxyxdzALMmIb9IYa2XdrQUfS+SeahSAX4BvK0kWgbh0XRniVfr5pvnW3Y2XiPGZlqIt88GntJi0eW40zWxkOSgQ0AL2oo5s3nwqFzkPVrm2ekQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt2M0ZoW; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8845cb580bso367100766b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 00:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771143102; cv=none;
        d=google.com; s=arc-20240605;
        b=cK6XHoLQ1lEwjPLdnp/bqciArmXCSZA4+AxPTUF6k+1ocIzMg7H8RukfpX7NveUWMc
         v4nQ5/GKNJ6uTPMzRlfyiUZ3cfDfu6AX+TXU37O2FC+rT7OQZlZiW2EJYBOPDCNZCz3J
         /bFpLgMVZ7/edN8iT+vR+UhVTKgn2JjtG/UDd6iH2/4GB/MHupRgRMBkGIncqgffl3tg
         cpQC47ZLQG05AR22+Ago7g7Gke8H/lB1+UE/3RaVNDaMgnF6cs2YBMe8dnWGnmYAhHjZ
         EHfOtJswFutRiQDhEQ11kEO1zCDsPe6AuVhLj+eXJf2CP0Rlo8GdGej8pXprQQ6ecg3L
         FuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        fh=ZZ3fqYqEur8MK8+oEh8/4mL1MF5dEsKDsp3EdJ+LxGc=;
        b=I5KOhXuMhrQB/tCgEMYtXic2h1OssGFATv1HapZI++Q+kS1TJ2j+Ot5px/2ehHS5gM
         cPBWXE/pB1Ui3ekABqj8K8BqhAiCexZr/JdM4LoF6VBK68GUumQA/xfLhDsI7jFvQepC
         VZ6JKexMOeER4i/qvoWRawljhNSBOUx+EkUR1ZgPWluj2aSO9hJO1Na8SqEsf+Tyb06B
         uGFcitN3rFz5NLOpD6MZf9b9NvNcbKTyziIoIudaG8dKjtjIKN74v4Fk5BCqX6UIBE1w
         QMT4uewq04mCpxDmhxrj4VNijFKUFOiphph/uwj8Vlm6IPUDe+LOaEUv1G28LCktCDkI
         7wYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771143102; x=1771747902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        b=Xt2M0ZoWWQIkYKU675MIq2NiyvF5zm3oAhVTSRcJjVJI9xJAQmwinHKYmDEutmJ80l
         oLiEw6Fggx4auTa2P6eKfL+noaG9VlJXveG+s+OPeqDBjrOeBLxUSqme8VqG5+kct522
         Fw96lz2KMVs5zTtOazVyqZ+natmsNtlRHBJba2t8Ok5MugBik+VWwSKlp5EN+VDZri73
         77lSqXGpq6KUR/0ptO84KHwMvYhl7K8fnFdiTSz8G/nrYfUMhjJZoWr/hJJbS40YP1l/
         sV18Ua556gCbQ1NagFWAa1JVHivl/7Z9ZpvTZFoAhS3wncX0ZnykqQrkBixiMrDoO9ty
         YznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771143102; x=1771747902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        b=BqzhALWfIWW3qZZcKPnuZazd7bfFiQzrpZV8JiNBEF9XfVsM/zYPv+YUpEL9Q79GUk
         a39uJmcwp1ZUEZnR6a7rUQHYrpGcGdvoDHHLXzBHyHg1J7Pdz/09ewYVRTleuw3MKKrw
         0LONmI5xAYQdrS+D3vMYunkimjIYrhQWixaLGlJD9sDfXltRfBzr8K0npNyfp6uQlo2X
         EUf6mpMEEjm1OUDNu25BvciYdwZBhkRnV/g9fJ4crGNI9eOOK/baZ1HILB2Om1WO9e8l
         2+efe8MTAB71BqtVXXORootqoPGz61TiO+9R7L56xF149T3XjmRq66jVRrk6gJ6fCR/c
         CpMw==
X-Forwarded-Encrypted: i=1; AJvYcCXSiZFvTf8WdIbd8Fvb5sRdHMgEIskRdnCpn+Lm0d+jWeSg/j4lGNRzHtsuDHO25Y1qNGtMyiAp27k7+RWF@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwDdfptnhUjM6rbyN2dLwL5uHj0IMhyu8d8HPBPYJ6EnJIzci
	Yqag1XfPjNjX3HUHFTw26bmIlX2iFhzPsyjZNnbO6l4UsjyH0muG7/mt91AfscF/GHAS3/lsrx4
	6KlyYeZIKZdPOcsybIe7BMIznxUed6DY9+Q14n2g=
X-Gm-Gg: AZuq6aK7qsHkWkGcwfIfY5pdR8RJxSZC4kfnVyBCVLDx9jKu7Tv5p1aQwGK04Y/mMlA
	eAjdJfzIKRwLXaFKMQNQrICbQWJwD8qaRFddyXlhdiSP5FnVc21SHpjHaov4UbH0a6KMeqwL0RV
	m9M9jYfCKQzNN+fwx2xSY9dhv7bAkyF4CdZd/Zr3FL+eImdCqWdZaZyfq3UAmFOsfYVsQmuuZRU
	wClrwF4N+yntbZmYXwYz61gSREpXZ1Zmok75G9G7W1Dp0Bq48TYv0ADerek54naJnrKCY6B8ZHJ
	H6U6hzCA83qHGyKW5xd9/1MdkHNQMChmK1wE0eU+zg==
X-Received: by 2002:a17:907:3d9e:b0:b8f:a724:8704 with SMTP id
 a640c23a62f3a-b8fc3c7d456mr241918966b.42.1771143101677; Sun, 15 Feb 2026
 00:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214212452.782265-1-sashal@kernel.org> <20260214212452.782265-85-sashal@kernel.org>
In-Reply-To: <20260214212452.782265-85-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Feb 2026 09:11:30 +0100
X-Gm-Features: AaiRm50iIi5RwEAw9dxYIy_zWbg5mNMrBSmlP3CQ0mExJK-TzLN3fgMTeFhoPa4
Message-ID: <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-5.15] fsnotify: Shutdown fsnotify before
 destroying sb's dcache
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jakub Acs <acsjakub@amazon.de>, Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77248-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazon.de:email,suse.cz:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EE66C13E468
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 11:27=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> From: Jan Kara <jack@suse.cz>
>
> [ Upstream commit 74bd284537b3447c651588101c32a203e4fe1a32 ]
>
> Currently fsnotify_sb_delete() was called after we have evicted
> superblock's dcache and inode cache. This was done mainly so that we
> iterate as few inodes as possible when removing inode marks. However, as
> Jakub reported, this is problematic because for some filesystems
> encoding of file handles uses sb->s_root which gets cleared as part of
> dcache eviction. And either delayed fsnotify events or reading fdinfo
> for fsnotify group with marks on fs being unmounted may trigger encoding
> of file handles during unmount.

In retrospect, the text "Now that we iterate inode connectors..."
would have helped LLM (as well as human) patch backports understand
that this is NOT a standalone patch.

Sasha,

I am very for backporting this fix, but need to backport the series
https://lore.kernel.org/linux-fsdevel/20260121135513.12008-1-jack@suse.cz/

I don't expect major backport issues to kernel >=3D 6.10 with commit
07a3b8d0bf726 ("fsnotify: lazy attach fsnotify_sb_info state to sb")

Backporting below 6.10 will require more dependencies.

Thanks,
Amir.

> So move shutdown of fsnotify subsystem
> before shrinking of dcache.
>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgXvwumYvJm3cLDFfx-TsU3=
g5-yVsTiG=3D6i8KS48dn0mQ@mail.gmail.com/
> Reported-by: Jakub Acs <acsjakub@amazon.de>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> The function is present and the code structure in the current tree
> matches what we see in the diff. This function has been in
> `generic_shutdown_super()` for a long time and would exist in all active
> stable trees.
>
> ### 8. SUMMARY
>
> | Criteria | Assessment |
> |----------|-----------|
> | Fixes real bug | YES =E2=80=94 NULL deref / crash during unmount |
> | Obviously correct | YES =E2=80=94 simple reorder, reviewed by 2 top
> maintainers |
> | Small and contained | YES =E2=80=94 1 file, ~6 lines, moving 1 function=
 call |
> | No new features | Correct =E2=80=94 pure bug fix |
> | Risk of regression | Very low =E2=80=94 only slight performance impact =
|
> | User impact | HIGH =E2=80=94 affects any system with fsnotify watches d=
uring
> unmount |
> | Reported by real user | YES (Jakub Acs) |
>
> This is an excellent stable candidate: a small, well-reviewed fix for a
> real crash that affects common operations (filesystem unmount with
> inotify/fanotify watches). The fix is trivial to understand (reorder one
> function call), reviewed by the subsystem and VFS maintainers, and
> carries essentially no risk of regression.
>
> **YES**
>
>  fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d14001..9c13e68277dd6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -618,6 +618,7 @@ void generic_shutdown_super(struct super_block *sb)
>         const struct super_operations *sop =3D sb->s_op;
>
>         if (sb->s_root) {
> +               fsnotify_sb_delete(sb);
>                 shrink_dcache_for_umount(sb);
>                 sync_filesystem(sb);
>                 sb->s_flags &=3D ~SB_ACTIVE;
> @@ -629,9 +630,8 @@ void generic_shutdown_super(struct super_block *sb)
>
>                 /*
>                  * Clean up and evict any inodes that still have referenc=
es due
> -                * to fsnotify or the security policy.
> +                * to the security policy.
>                  */
> -               fsnotify_sb_delete(sb);
>                 security_sb_delete(sb);
>
>                 if (sb->s_dio_done_wq) {
> --
> 2.51.0
>

