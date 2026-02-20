Return-Path: <linux-fsdevel+bounces-77831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBJSHUDdmGnYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:16:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B416B24C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31B263003BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29030FC10;
	Fri, 20 Feb 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bme1k1jC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDD15687D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625787; cv=pass; b=qWoqcN/NIcUNkbbyj2AwL12/zVVKE3JlB9CP3u0EL3CQTnVCkraT6j2dwOFnlLNVaKWWsK9oJRJE/Jngskjc60FpU5Z1iuXg6TL3KN78KU5fnXqznDyD+kdqFkujNOMJ32NyET8yIqVTKSnZOUgwIuhzdeaXfCR1wY900HKj8H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625787; c=relaxed/simple;
	bh=I2pkF5QAewPTXXJtz0yw3qpr9uypN+JI71t0BKuPbOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYYFpOGOFtkPUDbIT784oXAV2Q8ZCl5HqHFAIyQldS4/YbiPji9DhFiBQ3IwHNAwN0LiHUGI7nI0wBWfx0S3azL/Qwr+BmWHamZZLfkrIYvDVQqPRExZUvCWSPD8A1de+g7gODD0iBMGHwBYoRGK2gMlvXELca+0m24xdnW0hNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bme1k1jC; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1697396a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 14:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625786; cv=none;
        d=google.com; s=arc-20240605;
        b=fg7ZYrMzkeohUp+I/jEUEXi7d3sVsvBQkDVe7aviJxZmUEH6dkkEq5kI5JVB/O3dvc
         M1j1kIU0qpRqMSyMfVInG6RDisMOlVeI5W+lpMGetAn0Cuaat4ztufuWGIZRoklmUvuM
         UQgFieBnyU9WPWv+Q5SLIaJS/y8Iu5yZEqnajcY++4kZMJwm8JRFyBYVd5eiPJPef4S6
         Ak7P1ba4/dF2A6wdDzb6gzb6/ah1KMl2jqmyExu1GpUvBv0Q+/6+2ywH2snns5YSJo0W
         +1RZn5MJPMqnd3srKb5DCrYTKgARY0TWO8ulFawHhK7ctu38hoTXjZ3PO/b59l5RVl6W
         6y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        fh=pqvGy4k/7bVSceUoYxgQ5QcaeX7enGRCGXZ2FVd7TLs=;
        b=BGzUnUj4Eu7Stl4oHqJhVdrc/0H/l9QzGFV3EoLJs9PqEnB8+XHev89znf/tI6L6jG
         xmSQxNqzJOyUBuRFzqUPmfkZDmtRDvybQvjWS3Mq4rA+KVEwzJpFML3OmU1fyO9aVtV6
         u4sO+lfT9q+CakyTJHV8jQIGyl3+o4yHU65YQ8t+GNsr1BptWl8FXLwHSTx1zG8SIZxk
         Xp/JFNhHckZvMQptrAWyMY+TR8cnoffxfDk3qy+LbX1dnJ654xYaLUTSXNOmd9mOf7Cp
         Y0c2ULvkh4UC1gXW3ejnXfOfuTM8i7MfP7Y0yey5UdJ4p7ugZsEpcfYjL94jACRpepXu
         mEcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625786; x=1772230586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=Bme1k1jC2cFEcSNQxgaL9wQHB7SvEZ/gabSWPoX6xzBCzNnNAoDHxMFzNkqxoGd5xg
         IC7cXkvJYE5GUrxifnj712uMQk7EhVg+Gvc+dEDpdX1i2+c4ZSvCzN8yD+CyU/qY5kKG
         XuCGmKshY1ecwBV+TSr97U/Y93qorzP5MXpN0dlePVzLcwx1Wi+4biRnnnhg4r9rKAV5
         5MEMf+bHYwZbltfFcC+HL4u2JjoeVGTv1TYuUBN5TsXjxy/VkSQ/tDKWE4E826dtMeaI
         vUINoNH5r0MoTSDxJOinvodgbGlyehDpU4q/1S5wfwlC7m4m5jnOrGhycBNTXFyQGB52
         XeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625786; x=1772230586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=VzNLCnjFyqKFxvxBrDaBou5mAD/IRi1wRsWAnuo0owKS8zH2b1ZOFtsRyvadxi9GAK
         bsfK+5Y+dVwsqduaX4zIXUBQMkp6hpH8WY3jUFnht35MffLrfYgtqEEwBszev24ODaUr
         GwUXVzJ2DCLUN+I8NgKqd1QZgxlAWWUUFMcWf7I9CDzpl/J7H1j+/vsUGTw8xnOqoYJ7
         oG+Z5SwrAur+g3C0JDCS/dGXJOf+LWWQv0g2feuOSK9Lr5iEG5OURqDqEM5233zSI5YM
         G8LGsQ5BGfdX6xCeCJlkpcmyLBOj1Fm3wcqKWbjs7P+vHQmn7llMc9l1kXKIfIRXpJiH
         SY9A==
X-Forwarded-Encrypted: i=1; AJvYcCUT4z7I6/LdXWnAHcWczWKB9x5nm30dLEamkkgBvrabApQOlno8IfD2c+POCgQLUTjsgCElwSWfQaezBjXd@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSqaC0AdjIDJAhvlJECvSDblVHf/1nmXTAm8ilYp4V3TMpT6J
	YcQhwnDTertvCWWi+di7LpfhYFQcGOxO3Wq79WrSVrRMSRHJ5y6Zdpcb+oMlH3XCSMCwYoe/bXw
	un0fJZ5Zm0GRbmrkFnaLLxi9+iEbw9hC44wnQK7Ce
X-Gm-Gg: AZuq6aLD0Jw7PtOcDa8eQyzZbMqfo7H2zVwDK+fDosE2xeOJUW/JKbrqAggJhkZAlFP
	gpHwdC5IiwCocuJXknF7i17+TLwKECMDvGD/vdXBe/CU5zax8p8M8DyCw0DkwUrvo1KjEPuZ555
	8ErwWpsY2qIGyR9ram67pumMiHeGCIhqZpuaw3R6+UDEQYhDM0ws2gmMH3erh1dTGTUwz/F6RUZ
	V7WbHEQNSt/ESDrjzE6QuTSaqfVU32t8oRz/ZGi5iAkUJvdtX6u4fIu1uqzUqDnBtxdqeq25PLF
	gFunSrY=
X-Received: by 2002:a17:90b:3809:b0:356:1edc:b38 with SMTP id
 98e67ed59e1d1-358ae8c0f04mr1044426a91.24.1771625785809; Fri, 20 Feb 2026
 14:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:16:14 -0500
X-Gm-Features: AaiRm50rzPOdaKhOCRDQhwiojB-mAL3ILUNVZIdIhAPsr9Z69VQz2AhP1HaIvAk
Message-ID: <CAHC9VhQU3aMHYdvp_Af88iBVdiOzZv2gWjFABUpvCxF37YJBPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77831-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email]
X-Rspamd-Queue-Id: 922B416B24C
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

