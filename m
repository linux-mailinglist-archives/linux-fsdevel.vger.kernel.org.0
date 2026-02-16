Return-Path: <linux-fsdevel+bounces-77303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHYtGko3k2mV2gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:27:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4171458B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B41302B23F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBAA329387;
	Mon, 16 Feb 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsNuEOh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B032721D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255545; cv=pass; b=bNjl0iRYC6+j04vVZfLoHJ7uRcT40dESkTP9gw2O5X1f6a1VKYa2deeNrWkSdAE6Ksu06A/JPfhpH96M5tyY6KuN6zjHpmnTi6lOYIrmED+cNykegGwfgNAMgx3Zon16z7d+91PM6/qw+xXsXByyyKgKqduOkSixHwaW0jirsls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255545; c=relaxed/simple;
	bh=0WdtWYEHI09V+05DDbCwX5t6QJHUAd3cuf9OggMni3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q665FbFc/U7RJD2Hgp1LlMYAVsQQoPtCnUQk49NKBL8Cia+OnxQdtf2cTINw7RpJ3txr/amrXXBDn/AQ6QXemcJPK5UEwmBrz0OdZ4+l+NTUVHq6RxFB4Q5ViJBlkHrzpM9+KP0XNfrXjv1nuxPPQuXPj9U4jSuWcdy7zvzt+vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsNuEOh5; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b885e8c6727so509375066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255543; cv=none;
        d=google.com; s=arc-20240605;
        b=Ws1Q9jLt/5EXqpjyFDtyds+N5AO5uu8hdjfavG7b6hLEuIVFTNVVMvX+Vd6ZGj+Z9N
         uDLgALdkElc36PVhqyNQM32bvhkHKIQYjE4WAFSa6YtYtP/FQtjl17xPZ1Ft/hikA0sE
         zrG9US8fw2nFvp62DgD1SPIe4BoHea0mj3G7aMLEGN5S4dy1GaMNNdZu0NIwn4gC3s92
         6NVdJOyUqkEXc/UQ2+OBIcXqpkFoDdjZv+Ux+r1AOa2VPitt3it+VjV/MNFqk0mrfqqP
         XUcPYnDtXbf9KletF/t1pJuJWGTda8obZHTiV3AJx9G0q9GVfWas31xPsfF1aAr+ESld
         DeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        fh=0TxX0fcRkgx5IB8wUNk7gaDXOyBlUkQ9NK7kS8AMZTs=;
        b=SII7GGt/7DK2KZBCOAhRBxbgSitCQMFhHMuoydo2XscKDgUBUjJCitAbymxQEyJM7K
         bFMY37MFW1Oh/NlWmSb2+aq/aeePIxiSbIYHQgvwsrcWXiuJwZbebnudE4rwcGpO86xt
         G3x40FBoYJcINpbGIKYR0xmFtUy0UQUZOvuPq4R6tkTrhugWUHVcshDeLtFfy42RYFXD
         4jUy7NZKPkjvEWtSwk5YkjaM6T4HfU8BPge4Y9zhxDsK9WPj5DkXPTWdEaogirURRq8l
         Q9oQFpownVwquomK5ZBc/v76iO8EShTYhs7CQyfO5kEgxQKtgWauDTYkQbIdg/Zhl94+
         5ofQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771255543; x=1771860343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=CsNuEOh52WRAGxSHidc+/x9Gnktz/c9FVE5FB1EcKq1X9mrZrVMnqgwwh21NcidTTu
         lMVJvD7djqUYMQcasW0KFtKnh3U152DI28pgBxdTM3ooGNF0khPKIzo0XUutevw6XX+J
         5EBgE0bASqwwrydhQcfX8kR9hcRhqXZIAIzz3OfDcSuV1ElT2PMuIOohhVP+h8QKzz6b
         HmZ3n4Rk941Y9SSVKdnENzPcwkqYa/g64gU35Kz4JAOJlzDIIu/HtDyyUTFHGzICPd8u
         cjwt/VbtSgStIRPj0BC7+/bJlAk/tuijL3J8AOH5jeNug1XPnxkQJSs1hRYea9EL38Xn
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255543; x=1771860343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=hAZCtscXDo5xQyYrf2306dVc2afhChvrY8tG/ix4rGGXjFNISwm+64ApsqZjdYPtS2
         zzp2XXxfnmD/ud9DJ5CQ1zzNHVclZqpwJnV/5BmlVyjtvqvd2mM6zNAc0/1h3ECBjTqu
         /IA3zOSGnMYly1bh4Y+279NcB4gIKeNvgE0/rh3nPORXfGQOo06pFINhzfpqUyOZ8E8W
         1ZrtpbOjcPGRtyodakvil4MJB1OQc+6ALQUZUkgPHWeMh/j556GtgeaAn6pXEN95npmP
         UO1zB7vSJDzHEVW7Tv5Z3pnElZ5KVJCzYHH8pL9+SYoUu1J3Zs0cYwhY2OKlRuStoUBR
         V48g==
X-Forwarded-Encrypted: i=1; AJvYcCUm0cNcMQINr3SCjk18BjUIuJqoTFHzw7i9nmLm3VWleGDofgceexDFf/Fip3cC0dMM460MrEaHSjHbzPbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vlfzJ/Ruviu/x8AjyOCVQqejZZss6ATyKXXioBfrlcFb2tZ8
	c9GZXeAfVOXlOZpXOOseY85jW27XcU9NhD962cfdW2onlFJ7dM7kxOLvL1/N8rUv6192fDaP9H3
	cqc9G3itiXjs8ni4hfTMFD2px6HgdAWs=
X-Gm-Gg: AZuq6aIUlEY1JUuhKGTxH6SY+Q7Sq3g4hidoJPTp9l7y5jYY84aJUV1y4lxtXgbWFfC
	lGCOXA/Bhd/6HmON8GjzdkRRnKHHRrQ0cOQ9+z0u/tT+kFffT68pTujk2jrAqUXl4GptAKLEUAf
	NqP1pz906yCCmG7xIFnVw1yMztSyXD6Z5XgqM4o2wRnRvri0IGiTD9Q6SkG1SHSF134r6rYynqS
	D20YFl+aptworENFbujGUsuFIK234dXp7RIRpp0S/m53CKkM3qb88jHv5OHV2/qZ3s7Tog/sWN6
	q2b7jTi2
X-Received: by 2002:a17:907:2684:b0:b88:1e2:ed49 with SMTP id
 a640c23a62f3a-b8fc053d4a8mr461131666b.8.1771255542306; Mon, 16 Feb 2026
 07:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:25:31 +0100
X-Gm-Features: AaiRm509zvV_5nztV_clDc8zDOEZuzPTyg08_yWfQUzaOuSbDQzEo3YOHZWR_N4
Message-ID: <CAOQ4uxiggWbj6p4giuXgKkjdV1aOB5SO-4grEW_H7FCE6iw1=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77303-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A4171458B7
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d0b9b984002fe..9c9fca2976d2b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
>                  __func__, flags, event_f_flags);
>
> -       if (!capable(CAP_SYS_ADMIN)) {
> -               /*
> -                * An unprivileged user can setup an fanotify group with
> -                * limited functionality - an unprivileged group is limit=
ed to
> -                * notification events with file handles or mount ids and=
 it
> -                * cannot use unlimited queue/marks.
> -                */
> -               if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> -                   !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
> -                       return -EPERM;
> +       /*
> +        * An unprivileged user can setup an fanotify group with
> +        * limited functionality - an unprivileged group is limited to
> +        * notification events with file handles or mount ids and it
> +        * cannot use unlimited queue/marks.

Please extend line breaks to 80 chars

> +        */
> +       if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> +            !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
> +           !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
>
> +       if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {

Not super pretty, but I don't have a better idea, so with line breaks fix
feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>                 /*
>                  * Setting the internal flag FANOTIFY_UNPRIV on the group
>                  * prevents setting mount/filesystem marks on this group =
and
> @@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * A user is allowed to setup sb/mount/mntns marks only if it is
>          * capable in the user ns where the group was created.
>          */
> -       if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> -           mark_type !=3D FAN_MARK_INODE)
> +       if (mark_type !=3D FAN_MARK_INODE &&
> +           !ns_capable(group->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
>         /*
> --
> 2.53.0
>

