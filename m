Return-Path: <linux-fsdevel+bounces-78943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PqsIy3GpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:17:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08C1DDAD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8238301673B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177C423A76;
	Mon,  2 Mar 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1yKnxo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0442F1FED
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471829; cv=pass; b=DmTVYrywHaFkRSbE1Cz2/VWcvPlTswwcEljBfXF0ej3mtGBBgDRtfR6Dd3dI4Ead+w5tZJSwVl5QbVOODzha632GWbn2h6lOutPPkN1ga2xM8Qgy6KM+EbnUT3pCT0estqoDEKHOHaC0wkDs6uBDiENZE8+QjCIZtS9UP8j4lQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471829; c=relaxed/simple;
	bh=fpreoqoSF5RnkM8XCro3dE3W+VJBsxFCvrsLQiFfavs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma4hSBWM7OuExs81VbzyAfx4qAN8S0YnlJs5ElqtxaNvCx12DtiRCL1ye2W0uIJLIcI3jFn3TDL2cfCevfebNZi6PuuK3lxmpPsl76SGxUQu3P6eMNBENWCzVtRd1yJO7wB74RmkPoafwaOo71q5RStipcnhiFNYz1wMI05zi+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1yKnxo9; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65fe2d2b744so28754a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 09:17:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772471826; cv=none;
        d=google.com; s=arc-20240605;
        b=GS96Z5hdBo8YloswbjiuvMzgAjtLYWWHX7YQWCKRjSXdqeZjTmXBX8qeOIOa137yWu
         8qg2P9qygUjJ9x1fwKd1ETAynTDLEXNRsGlz3pihwkDrgECihHV5JgSpTjCJppEEa05F
         oJvgUCSfZtvhjW2UaNfBjwvlr11Ano1dcLQmPaQriJsuElEKfaRugX6Z7QYAOSC9z4Pn
         hviQ6WpmUTh9VA+GNHbcIvkMvErLJWHpmrGHAID+80cCA/l9we79FBocmBVH6z5But/0
         2Kk7jVdtQnsmbACvQVKCM5Co2mei9ccgQhCPQfR+9yTnhzYZ6VhsyVijLoJ5N7MbvB0N
         BVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHxBEn3H7cXkCpIXtAJ4369GNhZ1kHUTDApVz9lbi6M=;
        fh=x+5qG3jOh5wye8t2SSi0DzyMETlGG0M6m3Mi42IgMMQ=;
        b=UOdMYVjWy0yJM8oXFG1heNfZux5aOdcPwCHLhPHGJczXcdk6AI/H5HMSZrfwxY0X9i
         luVqAT2pZvYrSjCpQJPwFVvxpYloxhvIGj4oR3WO3kk5HmRvIt9Kt9D5xD5CYDRYo8Rc
         nQmBBnXbcZnFbliDiTMzm8n6noqoDBDBgvKfHK5QN1YS8crIOcsgLmPIMoD++COirCGN
         aYvg1HxBA7/+Zhxp1gTxodIRLord3cDSYkvxJHnau0GbyFEW/lucHLQB0vUBOgyoTJao
         kCLNlE09brqaZmU0Nem0XTaj4hjNf6G2heOnA2bcKWlnlDgEntuTOJmv5ea6OpHXAfun
         JsuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772471826; x=1773076626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHxBEn3H7cXkCpIXtAJ4369GNhZ1kHUTDApVz9lbi6M=;
        b=H1yKnxo93KAdvxxHV9ZojuIigzBKsmooCMqEnFhICDg6wQIuPcT0tzm0VCfOu/mGhB
         6siPI1il+HW+YWheMjf03jqQYMZa5Eyo8NP64/tCnxzME8dBlaRmIBXM8Vm1EzBbgerw
         1bDRld+M2yANacM2SGwSG221PAiinbrucHhlwjZD92az0sjpDWqdqJynyNwRMlgH6/d/
         X0P79uW6qqOodnPO/gW7Lf9eS3VIvskvgqhuu3CoSwAJazBfeQRi1DX98jUvIONBHUIk
         bv/BG0BT99f+4aAQLvn9DJ1BaoUXD2dLxSDXfsdgRy8QRe2kquUYD/66pBYPmTDr0r8W
         gScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471826; x=1773076626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHxBEn3H7cXkCpIXtAJ4369GNhZ1kHUTDApVz9lbi6M=;
        b=ctvyvNnZ14ImIevlTFgFthGk69kSXg+tyhPrWZeAEP1QcQr/t32sJn3gCC7YbF9qBs
         GZwBEaSgvW0EzgSXZGCn0+GSN8vzPGze/Ik9lQOuAo8//q4duwWdcaor0JhHvj3axtxM
         Br+VcNISdW/zFiQtKYBMtYTccRjZFPKa4OOYBIhvsejvNuuvB8ueB4pi6hv9koz4G1bZ
         qiwiMa+MduogI2kCnioPR5MNGEIJ889jPsFcoqyaYG0YlDYJtmZDApmrhvdVj+0LR7dU
         VgjqaeuPo7wu/Cz4U/JOUXPfAkEEt07M/19rRH6eJoLtM1AA3oZivbEDPtTlP3xvD9Wx
         fMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDP1P11E51DsQzbjr5pRangGD0M9dY1UojsIX9fOxTolwMKQgMl0xVZEIuJi1ZeWpZhGgkC4IPSOgdI+OC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lcL3D+8xLVX6pERcsjrHZwmetzlZ7gLfluzcW0/q7ZU/k2+l
	Lb4r4D68yhZ2UVTi1YkROKJnqa/W+K8FjAVmvc0X8vxp2/qqsP/bhm7Yb61z5mB1pPTItgEPiom
	TUeNwVWds6bq9mjvcrMCGMGkTkMsZ2eI1AO5lKeW0
X-Gm-Gg: ATEYQzxIPUbZO2riaqEotECoa2Sp8mJQK4pFKgzTRj2LYt7N5cD0+k/ZIq0ToOvgiIm
	cjpigI6hnq04pt4VyavhL3yvklCrzsr9NknYigMnq5+XW+0F0TFTrtKw5ajITjvqWVXI480U0f0
	uQJ8hgMyXgropArsxXbtJhBFxdPryWINbnMqCwftNjPb9EsI880oMlw1y4uamtdm8Mkq3yOBi7Y
	J7J7zYhN3u6mWsWEDyiMQE+9oZ5qtMqBsdtE2Sgu0Zj/Oh/QT1Wu3I/HzqRT7R0vtqti2qFDzhJ
	fwISO2m8muCmZDf/yLulP4RF75Qia08DUDH5
X-Received: by 2002:a05:6402:60b:b0:65f:7f8e:e922 with SMTP id
 4fb4d7f45d1cf-66008e0e4d3mr154898a12.10.1772471825099; Mon, 02 Mar 2026
 09:17:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org> <20260226-work-pidfs-autoreap-v5-3-d148b984a989@kernel.org>
In-Reply-To: <20260226-work-pidfs-autoreap-v5-3-d148b984a989@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 2 Mar 2026 18:16:28 +0100
X-Gm-Features: AaiRm52ntXdZp4Y35THHhsXAFFqZypk_rC1Lrz_89PQZLL6-GWz0wg2JbBQ2u4k
Message-ID: <CAG48ez3+SRvgkacMWunOC6yurecxViOKWuV2A-wrBnSwZgc24A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pidfd: add CLONE_PIDFD_AUTOKILL
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1B08C1DDAD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78943-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 2:51=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> lifetime to the pidfd returned from clone3(). When the last reference to
> the struct file created by clone3() is closed the kernel sends SIGKILL
> to the child. A pidfd obtained via pidfd_open() for the same process
> does not keep the child alive and does not trigger autokill - only the
> specific struct file from clone3() has this property.
>
> This is useful for container runtimes, service managers, and sandboxed
> subprocess execution - any scenario where the child must die if the
> parent crashes or abandons the pidfd.
>
> CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD (the whole point is tying
> lifetime to the pidfd file) and CLONE_AUTOREAP (a killed child with no
> one to reap it would become a zombie). CLONE_THREAD is rejected because
> autokill targets a process not a thread.
>
> The clone3 pidfd is identified by the PIDFD_AUTOKILL file flag set on
> the struct file at clone3() time. The pidfs .release handler checks this
> flag and sends SIGKILL via do_send_sig_info(SIGKILL, SEND_SIG_PRIV, ...)
> only when it is set. Files from pidfd_open() or open_by_handle_at() are
> distinct struct files that do not carry this flag. dup()/fork() share the
> same struct file so they extend the child's lifetime until the last
> reference drops.
>
> CLONE_PIDFD_AUTOKILL uses a privilege model based on CLONE_NNP: without
> CLONE_NNP the child could escalate privileges via setuid/setgid exec
> after being spawned, so the caller must have CAP_SYS_ADMIN in its user
> namespace. With CLONE_NNP the child can never gain new privileges so
> unprivileged usage is allowed. This is a deliberate departure from the
> pdeath_signal model which is reset during secureexec and commit_creds()
> rendering it useless for container runtimes that need to deprivilege
> themselves.
[...]
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a3202ee278d8..0f4944ce378d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2042,6 +2042,24 @@ __latent_entropy struct task_struct *copy_process(
>                         return ERR_PTR(-EINVAL);
>         }
>
> +       if (clone_flags & CLONE_PIDFD_AUTOKILL) {
> +               if (!(clone_flags & CLONE_PIDFD))
> +                       return ERR_PTR(-EINVAL);
> +               if (!(clone_flags & CLONE_AUTOREAP))
> +                       return ERR_PTR(-EINVAL);
> +               if (clone_flags & CLONE_THREAD)
> +                       return ERR_PTR(-EINVAL);
> +               /*
> +                * Without CLONE_NNP the child could escalate privileges
> +                * after being spawned, so require CAP_SYS_ADMIN.
> +                * With CLONE_NNP the child can't gain new privileges,
> +                * so allow unprivileged usage.
> +                */
> +               if (!(clone_flags & CLONE_NNP) &&
> +                   !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +                       return ERR_PTR(-EPERM);
> +       }

That security model looks good to me.

