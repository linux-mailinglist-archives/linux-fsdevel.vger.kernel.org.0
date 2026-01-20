Return-Path: <linux-fsdevel+bounces-74610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLvpBQ8bcGkEVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:17:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E24E6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851F670B8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF43DA7E0;
	Tue, 20 Jan 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHG5977V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EC3D3333
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906034; cv=pass; b=dktLelyg+gC2raGZbvw7IXOvLYOmItLxoCaWz2rSv6fZioPdn8iJCoLh3P1aAZkiJUjFU7vNLhtMvBuyrY8m7lF5KB84zq7bjkxDa8Z46W+DOE5pnmgk+K0AI3Cvm7x+zNw3ZneYWtsG6FL4ltIrAcjdQLaEAuIaN6SpFbsC3h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906034; c=relaxed/simple;
	bh=TKz7zq7ZWVu1sfAEneijOvheA4TyUtTF3E4BMeyVDVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWEie/zJ6K838BC8RDZliFq0E2IoBCsf3sLsk5W1l4pEEpUF+ZNZCACpCsIsaNiGmBCcj/82WLQoAYtq2wE7zd1+S1NUSdopopaGr4ni7/CL7g5qBPkyHXwXUSX3efCATGgnFYAlHiiG9BhaF8UH0dluCsRVzEQz4L2yoAbcewI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHG5977V; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so8200181a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 02:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768906031; cv=none;
        d=google.com; s=arc-20240605;
        b=aVR+/+R6cKaRVNM9OoEyef+BHlkaW7+rzBmAfupzBFdH9Rqb1atORgZWpM8kSxZzU2
         wOFJcDAYD54/7OvUU+Y03UK2XaLsw6bsu71tAT4maOPHqbuiWWEqGv44PSzBU7uJ4728
         yGGq4VgsOSThDk3MpdKAoW29MgCWU5mXL43GTbChxAVWtFiRjqNK6nx2E/Cxhr5+EHzF
         1A3HZgdzLpi0YvyVnKJyc/z/8gYfg0QjWcr51LLPWBEK8KQbbcJkt+ZNXTZQn5Mmqv8/
         oiqdOEpeVr3LiW/9qUOZnqQkDF1dp5doTU4A14Dz8klHA7hJp4zjq1UnK0eebdlYH5ux
         LHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=09MK/V/MGe7qGKeDNemiMyqY8nfP9GpjZdKWjlvooyg=;
        fh=qgQCfZv4e+sHzgRSWNk3ftvt2G8A7svtQgDQfcDkXQg=;
        b=WTpuJqzY9jigKMMI60uc1EKBcCJ9URlj559C+YO3rm9Bgb11Sh0JqQ2/Pp1blhTJQd
         xTFHZ36pNS5hNFqramU8yEBC3iPpJEAuawssTAlxOi9gcXiOnMH8B9wVpluNb9J8oRt2
         3B45Ukr6NXM+C7FcWdFdEsHiJPe72pjTe8vRWLGEuUSpE0BUDrM2CnYO3ek/ntoyRcLQ
         T4Ca1vme1gxpKLDPv/GM/J7uIvik+tr8DdEu75hqSTNL7bY07nRD3kYmeQYkFGYmd5Jv
         dz4FXGEedYjlFHdLbajiyZ5RxZT7Kyjym2RiwWD6uCOjtcbugToUfutYwlDuWjxTCahS
         8eBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768906031; x=1769510831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09MK/V/MGe7qGKeDNemiMyqY8nfP9GpjZdKWjlvooyg=;
        b=VHG5977VPthDQn1tio2pdJroGVPWhO9so9o3zjtUvg3IVUroin1n+zet97jbkyyfkV
         4ehjUHNHhxiyvDZ5/ceIW5hp+u0/q0o6GIHsBoauVsJjlYwY9L2mHft9nOh9B8liZ33R
         cs7HVC1SJHDT9nTTm2em+XcFplQaZ/YpZif1/XIy0oaCnyUxyftM50P8AK3led6N+4E1
         XQAgMgM8OF+EmOwHlDX0hCNFQM4mCRqxqvu1T/0KrM7eNV+nq+rSK0Jk2ooAGoYvEH0x
         dfvjAxEuRfc+6Cyku/r9h7Mep5ER986EZEtSh3I+6UOKyK2ouhWf18N9LoGFiJoLvmDw
         w8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906031; x=1769510831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09MK/V/MGe7qGKeDNemiMyqY8nfP9GpjZdKWjlvooyg=;
        b=KdVXZerjb7+89bdLsZp5RPoG0Si6U0xyfropm9hRrHDID9h8tyvuJH2DeZicSk511m
         4Pk9KVahyLNIrcAst7z9xxN+9JKkEq0SXZ/XO3uSQxCB7KnQmQ42rGpnsGMY5dhGi0rB
         HjFhN65QFsV55znSflUVw0t4WvDYntXebFM/39NAkfyUdoQDWRke1ZWlPEAMwfKJtfF9
         LLbcaOtlbziHDKqAct2dhsKmOgebetnH9FsMh5Ku42A1R3X+jreItilKNPBzipALtgyZ
         PW0YhuzS9dF4DxDCGdf1rS40cQkhaEONAjt7gRAn5pmLxLY40ZoWxN7tacuv6FgzwH4T
         qLbA==
X-Gm-Message-State: AOJu0Yx1ffG0UZ4Imdc3t8TSU1NkbmOfs6supx6UXWVe2fGP11jn9H77
	2czBZLCt+uAi8k+2mnYjO2uGLamkEBY+4xKnUCosG0JBEkVDOn84XmvZVvs2WlMLOnLaqX6ZWED
	LraVdW6Htm36GmHe7H+emFn5FInS9DMs=
X-Gm-Gg: AZuq6aLrNeGD8EX0I/rniRhJQn8eZt4Sdyx3Krf7Wqal+zer4Z1txVawwSpX20TwAQt
	sWK8C/1AnS5jbe/MaMpWjFk/fzjCwRcuJD64X2ymcvfKt9wSQOqQYmVrOY8SitI4zguN1q3Sok5
	PqudUl1WPIc915fPZg4riBDaNUneBlNMICl1Qypr06p8hYLLNH1ZzRb12JwR9Jjy8ThIQERjF8B
	pC2VDyotl2t2qAs0knAktlymVA0BqRSn/Jx80SBzzAtFO6eT0AMaXdX7QFfsLJa0oPMB+FlFaiz
	5TVNPHFEnyn1AHF1/dn1bksYhhoOBg==
X-Received: by 2002:a05:6402:40cb:b0:64b:ea6b:a884 with SMTP id
 4fb4d7f45d1cf-654bb32c2d0mr11960047a12.17.1768906030432; Tue, 20 Jan 2026
 02:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119161505.26187-1-jack@suse.cz> <20260119171400.12006-6-jack@suse.cz>
In-Reply-To: <20260119171400.12006-6-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 11:46:57 +0100
X-Gm-Features: AZwV_QgL7MJywyvBcsEQqjGMYrwJyPHnpHG4GxbHLFkT9DUwoh21Osg_l2LLoRA
Message-ID: <CAOQ4uxjR6EeGMmxPCLjpHcbHufJQ8uYgnhJ106Q8DZwNq59UuA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsnotify: Shutdown fsnotify before destroying sb's dcache
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jakub Acs <acsjakub@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74610-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amazon.de:email,suse.cz:email]
X-Rspamd-Queue-Id: 7C3E24E6A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 6:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Currently fsnotify_sb_delete() was called after we have evicted
> superblock's dcache and inode cache. This was done mainly so that we
> iterate as few inodes as possible when removing inode marks. However, as
> Jakub reported, this is problematic because for some filesystems
> encoding of file handles uses sb->s_root which gets cleared as part of
> dcache eviction. And either delayed fsnotify events or reading fdinfo
> for fsnotify group with marks on fs being unmounted may trigger encoding
> of file handles during unmount. So move shutdown of fsnotify subsystem
> before shrinking of dcache.
>
> Reported-by: Jakub Acs <acsjakub@amazon.de>
> Signed-off-by: Jan Kara <jack@suse.cz>

You may want to add:
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgXvwumYvJm3cLDFfx-TsU3=
g5-yVsTiG=3D6i8KS48dn0mQ@mail.gmail.com/

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d1400..9c13e68277dd 100644
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

