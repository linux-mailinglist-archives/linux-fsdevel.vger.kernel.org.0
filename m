Return-Path: <linux-fsdevel+bounces-75889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKB7DsKxe2mSHwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:15:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCEEB3D97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1688C3017275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8665313267;
	Thu, 29 Jan 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="BhzqHV/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96C264602
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714109; cv=pass; b=abRBQcaVGR/5lpGxisof7DNizoziOgEfXZaKJg/Sost5wzwx1FsUe1GVimdHWhIiNDSsJsn8vX3JNl4DQnH8AEQNMsx7188HDPQHyyg0QRI80NbzJDDIeVpaq5UJ4qkATxClSselqRHcnYX8F6O62vqJ53oNC0jgv9w61F3bVFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714109; c=relaxed/simple;
	bh=pJaRvOJgMYmEatmgqO0Noh1C5/LrR0kKBSSEGupr8ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyVSXnmuLURZbL/d9YYg41sxLzXkVnTZfwAW+23F+NPikO9m8JsrlFvme6fLZHgsg4p2RvHWRs37KnhzX01Qwa8zNjtKzGnoNsJnPDsOxLbOyWiAJ5gCsXKCqbfkVmB/1+gu6/iYahVRCwqnJglSo3MhxZ+Ya/K0NCSp8DFz+n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=BhzqHV/U; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7947be0850cso14028487b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769714106; cv=none;
        d=google.com; s=arc-20240605;
        b=frgv+jH9YWypIXWde1BWhqcuucUeRRUlU8pmwRPbAaItxl6PRIzyDRaT72icJkSRZZ
         +vbeD96V/yvVqgeBQeyO9tGVkl8HSGUaPsbW9JPjpTduKa4VWUei1hvxQGH9aodjL/v7
         TnapWZhOZ7JFC7dlt5ueqXm86zCeMhvKRBbJCkgdTtCPwKnFu7eCjglD2g6C7rXVcNKa
         yRrn3J73znLlMg39C57sRwSuWtR9LF5TVzs6K/uSnoPoiNM5Mm7y/Zk64a7+8qnWz4BN
         5uKdVGy9XY/Qj5dEIbUsRz66o/xG/8fYZ6Lg7Dytp+hC7kNOVgSZr6iuXi8fNjhzj0Ek
         migQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5N6G03pV1aQUjOR6HAuoVJqJhcVYIGKXUjXXorv7DA=;
        fh=cBSH6hVRk2RC5HpQ7SCqwglbL+Lu8PEdeJw63bwOcuw=;
        b=DQz7HUFgMuQfV28ApwOqXPd/gbUCBirFDti34+/vfGwS+d+3FAXGayumMmu8GP2oLP
         Z8NXKGMSt1bFz616HAsfw3L1BDwrkmZooSLYQmtC/dHLP21Gn99wnnfPUXu2dqBdyZoZ
         dX9uCPqKDRVfRPSQQ29qs2DNcICZ3nBcdlAspEbPYw72ZdMTJt+mJyIc8rMGTl068Vlu
         RaETFPZDY0dyCirST5vnKPKgoTAryRe/+gtslg7K5SCmfXWZSmiQbMXXeAxx0OpzSX1U
         FKhXigAFPgFS3/t578E7xT3S8+gXjm6KmA3u143DYhI9hAET/R+wt7fOUuUBaGvulDcx
         UUPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769714106; x=1770318906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5N6G03pV1aQUjOR6HAuoVJqJhcVYIGKXUjXXorv7DA=;
        b=BhzqHV/U9ewE8NJ1d3D8vEElVQPGp0UbX928OBjCCNMFp5h/fLqnsngGHg7E4GFxiB
         yBqxqrgCHNLtn672IxEu3BU58EeqHQ3O/5jH8UWTo2wPuESQT9klFJeD2jBqip6zaeab
         Od4IzPZm1hfgbtrv/sTIEn7+iVlXeA8gEylV84jbZEhsvPsScU8iH5OSY/Gr6rd3kyWs
         FnfGGKd4J9YtMp5jjMEYKrlW4QwdJ3ORUKRJtE0fNfJZ6siIw9maHlmoEgiR9KdHxcm2
         Fvql5hiuDdxC8agqNb8nFPbBf+KC+vU5ZQMX8uaP4w0bJG81kClCmfD5n48sPhtQr6Ld
         fU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769714106; x=1770318906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5N6G03pV1aQUjOR6HAuoVJqJhcVYIGKXUjXXorv7DA=;
        b=N1X815F+0kNRlJcnofv9TcDUAD1J3mNkw47jM5xLRK3VfaxcKCiqiZOx0cJzEUouB4
         lVFkKnMNfhP1sNnTooUG4VwlQGVE8OVJtL+2NyFaDSI+p3uXruUEJ6DP31lWZrlEq/mW
         3MX01U0EO7RnGS3ZIsPbIffjlcBCY9uk6deUn0maCiY5UVGmCjn6cMx0RM0a7r9eAfPD
         rYKmpeVyOI4o/suBWk1HomE3ctvu1sSYfzXsRleEXQT3JBrRwEyWq5fw2hZisbae5ybu
         LUE/oGBhoRVlx5gKpk3KLtZPU8m1tP0CDoMBZs1hKnq4ia9QMM9Vu0N2MAhqPWvZ5kbd
         iNVQ==
X-Gm-Message-State: AOJu0YzMG1QNU7u4hKneYXjgBKhNkmdmpxHfc71XUsNH/1+IjUlJJO6h
	GFlV4ISG6oUZaASulbfW2KJzwxophiVEVbhUDPaQKAVpS3uxugpPdYQQIr/GPiijvu423AfC1et
	O9r22rDYl8s/SfWhdypfD3XCbcXJ8Y/8MEg/UDDuFTw==
X-Gm-Gg: AZuq6aKax++qOnoMIcsGSe1w3cfs0iRBp9C14l3a6Lr8RVoJs5JUibkXJsRfgVNtWIL
	RMROM7IaR5yz7gg3giNRU1J/RxZbFczvkZCErMSMkawmnR/fXgF0WZF8MGidzaCyUaRBV+h/0cy
	08XC0Y0U0xBYAmuRWFDWCfppbtU1Cj81J0sbsoPtPUd8oTDriweZTOdfG8PBIbAIaSkwzMJwfZn
	Yv/XnuJCe+yM55ZXo/HJgMspflSDdLtpZZu3oFL3D5Nh9z/ZeHE7UlQApoaenZMHduhvqjZYgIC
	iy74YiKyJxNexm2JfFO4FK08XTAtqFzJhZoHK+80dlx3NnlrIS5oFDAO
X-Received: by 2002:a05:690c:311:b0:794:73f7:ff7f with SMTP id
 00721157ae682-7949ded8fd8mr7203297b3.20.1769714106308; Thu, 29 Jan 2026
 11:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
 <20251105-rotwild-wartung-e0c391fe559a@brauner> <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
 <CACyTCKifDxhGBY0S9AYZBCw6S7-mf+0WYv=0VjBq_a+S0sWuiA@mail.gmail.com> <20260129-hummel-teilweise-43b0ba55723c@brauner>
In-Reply-To: <20260129-hummel-teilweise-43b0ba55723c@brauner>
From: Snaipe <me@snai.pe>
Date: Thu, 29 Jan 2026 20:14:29 +0100
X-Gm-Features: AZwV_Qjzm-cfhVSxwYOSKjDletHZc-y7ZSCY5ZiqZiyTVVZZ3o7_ZZzkjmyjqvI
Message-ID: <CACyTCKiijH+HXiEksuq6RFQnMfJ2tP5pWc5fPv6hn8rRDoRHBA@mail.gmail.com>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	TAGGED_FROM(0.00)[bounces-75889-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snai.pe:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@snai.pe,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snai.pe:url,snai.pe:dkim]
X-Rspamd-Queue-Id: 8DCEEB3D97
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 3:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> I think I might have even left a comment somewhere in the code...
> The gist is something like:
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ad35f8c961ef..e78aff6b3bf7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -961,8 +961,7 @@ static inline bool check_anonymous_mnt(struct mount *=
mnt)
>         if (!is_anon_ns(mnt->mnt_ns))
>                 return false;
>
> -       seq =3D mnt->mnt_ns->seq_origin;
> -       return !seq || (seq =3D=3D current->nsproxy->mnt_ns->ns.ns_id);
> +       return ns_capable_noaudit(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN);
>  }
>
> where we allow creating detached mounts or mounting on top of a detached
> mount provided the caller is privileged over the owning userns of the
> mount namespace.
>
> But then the may_mount() check would also have to be changed so that a
> caller unprivileged in their current mount namespace can still
> created/attach detached mounts in anonymous mount namespaces they are
> privileged over.
>
> Even the check_mnt() checks should be relaxed for move_mount() so that
> you can attach a detached mount in a mount namespace that you have
> privilege over. I'd need to see it in patch form though.

I was a bit confused initially but I think I'm starting to see the picture.

In my original attempt, process A (privileged in user ns A and mount
ns A) would open a file descriptor, send it to process B (privileged
in user ns B and mount ns B, but not A), which would then call
open_tree followed by move_mount. The issue with this approach is that
the file descriptor's path from which we get the detached copy is
still in mount ns A, over which process B is not privileged over.

If I understand you correctly, you're saying instead that process A
should be the one doing open_tree to get a detached tree (which it can
since it is privileged over user ns A), send it to process B, which
then calls move_mount. Today, this operation fails with EINVAL, but
the point would be to relax the checks in move_mount so that processes
can mount any detached trees in mount namespaces they are privileged
on, even if said detached tree originated from a mount namespace they
are not privileged on.

Am I interpreting your point correctly?



--
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://snai.pe

