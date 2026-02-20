Return-Path: <linux-fsdevel+bounces-77821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCMgHyXAmGnuLgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:12:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E116A93C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4DC303DD50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B134E770;
	Fri, 20 Feb 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8mkqqus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760F357711
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618289; cv=pass; b=shmQ/4kGMVKPkC5uU6UxWQWWIM9C68HZO6R/AV5fujktwcC+WKtn430jblOejC/5mDZDP7XFTkfn5HIqz0GZ/HLOgLFOfKqV+y6SsfLU3+163GXD7kd1QrDzh+SzByn3/uw0bMxSDJXFesp084WT8QkBx6LmwUQqeuI6O8fnI80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618289; c=relaxed/simple;
	bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrt6vh+MWzb3D77a7HjsLksotU/1cTQu/UCvIAgfGCaCo1UrlpLpnhOxayECFkDJe30358iiN/Jf1b/BFxpyYADYzN2iZ3tbzXt3Yy8p5aQ5x6FJwdwXCdxxT0Na+M/Pej0HpoO40zVNHwo3Cjag4jzhrkwNLgsqOt5JxzicU+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8mkqqus; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso5632533a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 12:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771618287; cv=none;
        d=google.com; s=arc-20240605;
        b=OSbe6R/Bd5sYGFw5ohIAwxSksb8eLMYlWx/B0hndYMmE6mraw/Wd4ArihDM+u4HHAw
         CtY6r0YNzRK6z4OHsQXFcwqFra7x+zdMvpJnhY7aUIyTXSE7/M1ax7DAfSHPu2BKM5fr
         AQ2GIBA3WlIwSrpn731Q3kuW1v1Z0gz6hgq/uqfid0jNeOiGJupOiH775jyvkrYqlRBz
         mxWptSkvqZ8uQ514q/VNZ87qlaE4bcRw4CeirnSVwaNdvfHhW0sJkshVo0MZQzhM1FUi
         5VRVm00Pr6oooW51d3PCm0NOxJEnqoVNeYOiZClrwi+OuKWqtyVMYLrCt9fENl7nUKqv
         Ch2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        fh=gZyfKVKtT3EMV5Huqokn0s6Je5MkKkSu25EIQtCQ7v4=;
        b=gxJHlflf6LdSbsHnW8M7u2TNcRj2NSPZhxIy14OX3r8OJhJ5MJmANVvzga2X9Zrjyn
         F1Niloj+Pl3vCjT6v4QRQZ1LkXcSqXs80iN5VCG7pHisIS62kPYxrh/8A2mz/Qbg5zIr
         CeQsmXKpAS+A7jItzq7kv60VXP01ojcWAyvh1mS3SIGbGePESMk46rGqhw77Bf4QMia7
         1RBTzn9VmhFofyrYv7Xp77PsL7J3heierWYp27Y7JAUxZXdShv5L8sL56XKDohyXOhAX
         XLRc87A/9D049axbP6jPzOx+HicdCAKu+iAbefeyfYwUvyqeGUuA8GuPJQzcoUQ00WuL
         SyMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771618287; x=1772223087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        b=f8mkqqusXyvhQHYJaW28XHtVosjcC4aCNi5gxBqXFpMFduCOtx9B4ESK58h4qjyURX
         qbdSwrNMJo1V38YR0AweM7yRTBdzEmfCrRbB6+uJNSAOAYLWRVr0QPhSIfPCYZMZGJD2
         HXOQ47u/T3UIOdn1rCIQ7gP0+OSV/ZwCtJqC0oUxradIsOcPcqFsQZRATEPAbyLstIaf
         0UVCLltkLCpFNLjhei+C/BzUpWD2X9/A0yVzKWHIFS6RPERFDv/ZC7h6+OrSsf006ydK
         Y9liG18m7K0QpNMGP3FJ3+3h+2cSaIToBz78h3p4z6Hp6bqTxisdE1uSEXqS+/TddAEp
         ymyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771618287; x=1772223087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        b=vhT+rzVMnPVRgHpi4ygFQBHHZpLTd8r0LnDuPJIgxXOyVYRzYpndrbtbUCnewf/bJu
         kAcHD9WcSxpuhpT7jKLaxb5FC0g2TUzJFu3R3qQfeUhHoYsETV4k9Bu1w5P6lN49tl6C
         qZ8aiSVCKwvWvHGYTa0SeHqDbiawiE5VyawmEcTuSRs5z0Sjo0aVrrv5PNJP1Gtk/PeD
         EcrvaYvmnp3U3Ls8UJm+dO8Q1Qd1b0jlYSp6ELLiozbG/IEo1rtKcwktkBgte5WDWoyf
         /nGAJxFsN7wWraGNaD2JGnt/uMwRfr4Ms5wbPw5yJjKHZVPO8BnIcyX/0msUE1Pp/kl2
         lCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTkXgxM/q2MiDj8knQZB4ZOtF65UitU6A6bZpTk9NWhVxz8yuK9R9Cw4Z/Z+kOeblg8Iqg9fkhhczATRHI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywin2UGX0JecLeM+M+tSGwk6sCqP2UqXj1TZuktn1s+3xZb2IhT
	bduF1N574KYJXZNONEOOh4Fu7eZtt691G71qkpfIPG9HarnJatwohV4qJWo/w3e5ZDo8LpuOiRO
	kPwMWlAG+iFWjLIRDg42zavMca6PM4mw=
X-Gm-Gg: AZuq6aIdy9KIWUZQD+w53bNPzINP5Jee1IOVbXmhfumAmnBMblRrrg9ZSbj2taTiGZm
	Xb1MW9nguJqGBE9iIGn02Xlcl9ppALm8JyKx39lsaPypxMVR4g4t32PcrJng/nt13u14ZboRUUD
	N/zMBIjMTsEDXGBX5X2eNjE8dHCAVpmZd4BWUeJW8sOr4pDvn0Tv62R7qSm5JRsAZam3Cnz6su1
	XxIgbr8Avff7p+AGif+6F+65IWIfw96scgaZKtxylBrIFEvik/W09C27n69v6uEnOaiIZQVffDP
	vp8bKB7ROXgV0zcwdikCZBvTc6H7Blcly+QDBfUttA==
X-Received: by 2002:a17:907:1b25:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b9081089466mr60024866b.14.1771618286359; Fri, 20 Feb 2026
 12:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org> <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org>
In-Reply-To: <aZi6_K-pSRwAe7F5@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 22:11:15 +0200
X-Gm-Features: AaiRm51G-BEIzt0SxbA22TK8LiihbDavtfXN5tpD9EpODADyVmlHbWbL_HHf7gc
Message-ID: <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
To: Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77821-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE4E116A93C
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 8:50=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Feb 20, 2026 at 07:15:56PM +0200, Amir Goldstein wrote:
> ...
> > > Adding a comment with the above content would probably be useful. It =
also
> > > might be worthwhile to note that fanotify recursive monitoring wouldn=
't work
> > > reliably as cgroups can go away while inodes are not attached.
> >
> > Sigh.. it's a shame to grow more weird semantics.
>
> Yeah, I mean, kernfs *is* weird.
>
> > But I take this back to the POV of "remote" vs. "local" vfs notificatio=
ns.
> > the IN_DELETE_SELF events added by this change are actually
> > "local" vfs notifications.
> >
> > If we would want to support monitoring cgroups fs super block
> > for all added/removed cgroups with fanotify, we would be able
> > to implement this as "remote" notifications and in this case, adding
> > explicit fsnotify() calls could make sense.
>
> Yeah, that can be useful. For cgroupfs, there would probably need to be a
> way to scope it so that it can be used on delegation boundaries too (whic=
h
> we can require to coincide with cgroup NS boundaries).

I have no idea what the above means.
I could ask Gemini or you and I prefer the latter ;)
What are delegation boundaries and NFS boundaries in this context?

> Would it be possible to make FAN_MNT_ATTACH work for that?
>

FAN_MNT_ATTACH is an event generated on a mntns object.
If "cgroup NS boundaries" is referring to a mntns object and if
this object is available in the context of cgroup create/destroy
then it should be possible.

But FAN_MNT_ATTACH reports a mountid. Is there a mountid
to report on cgroup create? Probably not?

Thanks,
Amir.

