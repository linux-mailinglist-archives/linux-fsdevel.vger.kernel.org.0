Return-Path: <linux-fsdevel+bounces-76402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N8XMEqAhGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:34:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CFFF1EEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D45300E161
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1E3AE702;
	Thu,  5 Feb 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d12Np2dW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DB396B6D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291271; cv=pass; b=CRDEhPmjNbTIE6PE5hmhFMaUIkhHZvckDnHeonyixtV4g50VhAKTsFIqy+YdqyAHJm1cso7wRD544lS5UD3rJXNPeXr6LrmdM4IcJO8zkLsAfZF2nEJMvd7jCE0Vbs2e+1p5fFI6EIGS2jj2dBOK1NbOYUKFuu2uSRIikTHl+lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291271; c=relaxed/simple;
	bh=Wllrb4WsKy79JRK0IRKHL+OD/vSc5rdMQLpSobXKH9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqEGrcc5azmKCu0V+fyqw5GniK5LCXnPOEXbZprGpS9hZSdUv2SwriNJWgDjrcACK+8TwqTN//poze3zrWtOFbTE71na9bvVG0w9YR7MR5hdgIDuATXj0l6EnkA+hnbAJb1gld6u+fKLqcOOSr2wSzPtlJS6CX4LpatUEQ78/Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d12Np2dW; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so1188457a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770291270; cv=none;
        d=google.com; s=arc-20240605;
        b=K3GFG65wYtnsgQ2dwuDQg3YIuaFDlCFaxGdtqCcWcSzb+6TOpb7r/TQhW62h/Ij5Ym
         uQ60g8P6CiVFLcoenurcMlLbmrvv8AygBDXlgY2OSyCKQkzuNkj5VPeN/fFIfGtS9ikb
         bqWEhQrHK27cm/UWkPymTQQrPTm52xsW/KsifGTvHT/Fs7DqC34gTTa9ZI8haQsx8jpJ
         euWzVmpAGmJYvFi+e+vD5auM5usN6/G+tgYoUYcjdUTjFLAXZr8JEsFQB9YiEJDaFTlR
         C+BpEE/7/RmINl/AfhX7BlKQgTHg1dNhmYyrfHLawI+G5YJDUh7EJ0hiJG3roPgGC5//
         ipiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ny70VYSd1xmz+6UjM3gPopGsV2FlfYDUrotLR2sKK5A=;
        fh=YBY2INhhir4obLApLuBTRLZKSfWb9xzE/cfH/qh27BY=;
        b=fKKc322Zu9T7RXkE0ej6BwyHd3zpyUUJDURXlT/E+YB7T6C/q8KbomQ1jazycaW7cH
         QJLSc8FOeU32hIsiMy6pSUj8IECFUwjDfbVq9+PqFKodMuom2jm1OOs9kuJkBjlU6dCN
         9c+32K7stY0IqELqOkXK3SbWKwKyaKoBJli8SOJHDoaYy0Lu+lEKB+gfZh9d43d/QQ20
         GOQ2tCn6HfjuyJNbnVA546hrnerq6AOVM41WxS6gkm6sNF+ef0mU61C3EcapxQuug5fw
         HofBtcaOTkJga7DrSObJwOBAM3ryUX5z3Ua/c9hEYA/VPKD6ugA7RMhu7d+RK/MzX+1q
         Dc0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770291270; x=1770896070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny70VYSd1xmz+6UjM3gPopGsV2FlfYDUrotLR2sKK5A=;
        b=d12Np2dWrxrrPfVW7VTgOLLvCxeDrSPXqWGIRLB29Yf4PCyVmWUZfJ+hfQhge2XRcN
         pWNTqfvUuYukLwgK44tomY77lHZONJtsrfwuGqsGl7dKwftvOkS7KIQr8gnnyIsFRoIy
         e/BiWowsDK0FxN0BQzhuMJ1QYPgl6gdVhjK3Uzl6wLkKT6Iry+m9ggqbSFmpO9l9w0pV
         XraW7IyVCEn93qySmzrSv6KteVr/Iz4pK4i1rTqLeqzE/ooRwacbTQyACHJsJ8DxkZGD
         Wp/N2w7z3gKD8VAiph1Q2ugpyZIyKiWZNxl8nOP6GuG48+NNCZB1fGjsuD/3ddXkWSJY
         NTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291270; x=1770896070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ny70VYSd1xmz+6UjM3gPopGsV2FlfYDUrotLR2sKK5A=;
        b=lN+pUWfmrh9v65/WHH8nIyPbbmzixfbL916SQ1trYCn31IbZQQwRKgY3yr8OQ7DP+h
         3um1vkPR+7yk8pswUb5ylWB6c2s5i9h7+Z3Ph6RojG+sD8d2WIBw6KiqjvJ6dekC6Sid
         EjaPrcYBkJqZgUK6+pE++G0RvqT6sWF8cy5GABvmVP9njNckXo3z2TdKfgWpw/lgSWjO
         A/7PhwT+vvB5D+ZFp9/d6JygsOz2irG324i4Zab/rRapYjqye/tXHgVVpyrU7yEeSKrH
         q+ock6YqYRU93R21y0GqofEBC4FQV77zkP+HtvQRMXRElUmM9cxbQ/PsA3JNurKI8gzl
         6/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUCOq8urpVdVZ7iuzKm5MNBa/1CpCHtsDvCL8yAl3PH99KZCngQvySJwlyf+MYGky3lfA0sL1ikuGFwrcLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuyutKGqf3IfX1ZPdFZJ6yQwOFuv9qrv8xbT7qoLjA2zur+Cp
	1uU6DHMEKhTwCRHa2bxfIfjpmxxXdx9sV0jJPGsrLBmTZ60E3KAB2KXWn2oiT8d5QaMNShD8Xu1
	Gq/UXqZo/HWqVxNvMyQ8rx2myU6Njox8=
X-Gm-Gg: AZuq6aKA/uRCm+PDaoiGZ0zarAbw1Gdo+VEaQ+VEE/IJtCt1z2IyVAa4HTb5nepeD+P
	nt20Usm/0d95QW+EJXoIvc5GxPoqGR7AAk5gpv/18i614G9tSMY0A0vc98nNtqSPX6ISoyIr1fN
	yNEwoqFIoljUnzFWV9OXWV5QGzpf/y+k+zVtmpTH6+yZnKs1CUg6+7IU6T+c/Ccds+UvgtqykG7
	bPFPDex6p/7S3H9J7YymlKI0LaBbn8yCV0CpLbG6vrTYslROzY0ZQLNKReRRhCC1BcOJVezlt7N
	Sn8Rsp0cPUoDc1Gk29R9FDUOdHKsJw==
X-Received: by 2002:a05:6402:f29:b0:64b:5562:c8f4 with SMTP id
 4fb4d7f45d1cf-65949bb6cfcmr2908607a12.7.1770291269875; Thu, 05 Feb 2026
 03:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dnncglg3x26gdsshcniw5yb4l2zlxz6qcwjqyekkpngb6v26q4@ftqnoe5eeapy> <20260205100437.1834-1-always.starving0@gmail.com>
In-Reply-To: <20260205100437.1834-1-always.starving0@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 12:34:18 +0100
X-Gm-Features: AZwV_QgE8wjfM8FlpFwp8a5QJSoz0VKfXZCzKeg29kODXXrJs5HemCJ7Q7cL1Ok
Message-ID: <CAOQ4uxiax3v03XeSP-MRHUqx5WTa67qOjtusSw=M-Tk0zARv6w@mail.gmail.com>
Subject: Re: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete event
To: Jinseok Kim <always.starving0@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, repnop@google.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76402-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68CFFF1EEC
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:05=E2=80=AFAM Jinseok Kim <always.starving0@gmail=
.com> wrote:
>
> Thanks for the feedback!
>
> I agree LTP has very comprehensive fanotify/inotify tests.
>
> However, the motivation for adding basic tests to kernel selftests is:
>     - Quick and lightweight regression checking during kernel
>     development/boot (no external LTP install needed)
>     - Non-root basic cases (many LTP tests require root or complex setup)
>
> Similar to how selftests/mm or selftests/net have basic syscall wrappers
> even though LTP covers them deeply.
>

If you just want to add some basic sanity tests, maybe this is ok, but...

> Do you think a different approach (LTP improvement instead)
> would be better?
>

Using the word "improvement" here suggest that you want more than
basic sanity and if you want more than basic sanity then by all means,
we do not want to duplicate all of the test LTP test coverage here
so please invest your time in improving LTP tests coverage.

mount-notify was written as selftest because there was no good infrastructu=
re
to test user namespaces in LTP.

If anything, I would recommend trying to move those selftests to LTP.

Thanks,
Amir.

