Return-Path: <linux-fsdevel+bounces-20218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912748CFE03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305AEB21C91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8013AD3D;
	Mon, 27 May 2024 10:23:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EB1327E5;
	Mon, 27 May 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805411; cv=none; b=BtnC8otiZANOyz3zBq0h3QcNMSfKdWNeq6yG1xrmX+qfTYTzEIx1BgtXyeNwgbm6v4v6+buby0AMgWLoCnn8EhGzNSb+vKuagmbu+me11v5RzyeHOqH8amYj5v8wJabiQH/yyynH69s0Im5EIaWbdy8+lJ57JirWQpdTgXcrLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805411; c=relaxed/simple;
	bh=HT+8XGk7gp+WO4jR2xVV72O1raU8oPSotBFeVbxt5wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sPGPMRozVWVGA3F3FZb+p6gDnRL4/Jat9DLWgfazsDTe7mndBKQc7OWqt5N2xJQfx77lEjE+Swg2On0z8OgqdOmATSwE+7XB4UMbegP8YrxcKiN902woLk1p2YOSNdxyEJlcdUX4skwTvxDSj8l3/mMXR2/rjvjNf2vrZAN7MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a0c011d53so28692547b3.0;
        Mon, 27 May 2024 03:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716805409; x=1717410209;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofcOTpIvyE0qoQ1kR9BZTZeMOiB3j2MO3T05Qzwj5eU=;
        b=T5a8cRaA5OsWbzAAS87BqlBBXNhbpWN+XLvwvyaeANBBU571PKDP1PdrZGYn6G120r
         GH+xCe4WwiUR4MYi/XT+5n5StfqGZ21uy0EsiZrwo7SrvPJtA/xBcDcKx6xc91NVocDk
         bkO5sqsfBg1T6PQI7yiXcW9ndu6oCHqYkY6vJY2fWPMqbfHvkYa9y5rQI32KQl2Jgdcq
         GPIly46IV+eUxFcWXjja/QIercH1MSPAlOSjA8PQf7N1giBlCy5cazWeiNwKveawhTCh
         eSq7ehc0+22kNsdx5vLIopLJkUyCYBJnmkGohEuccnoTtoXz+m3SbrSxT2CZnHiHxpx1
         vJKg==
X-Forwarded-Encrypted: i=1; AJvYcCUGGt6Ha64oyf0pGle7McBnOUomsqEWug2FZ3tZfvI72zzZnizOqYe6F2BrG7XJIHVHJfXb7aRf1CiAjZsx3EaukYTwW5NtWE9dK1DULJSHee0Ks4WGqDr4K2gA81XhqpUvuP+HMr0/UWdWExYVmH9BYADqtBArlVY0o8mewXo78wFOY1s7XVgJ/3hooCv3
X-Gm-Message-State: AOJu0YywabICD99ifOQqt9zODAXyK8Sy8ekIdVR+fUaI/JxNODuSzO5/
	hYNS/v8XLhoq8BuhrdGELj8d+xmMMXynpcFPCsU1dABoEn6qM4iC1ulGkMpb
X-Google-Smtp-Source: AGHT+IH22e+WKp/1lpX9zbwb280IILBJAZPsxuHZDQjEUG6Sh9gZDfnJftXOweyxD2l9zgU5vmLAog==
X-Received: by 2002:a25:aa71:0:b0:df1:ce97:159b with SMTP id 3f1490d57ef6-df77218dfd2mr11642763276.14.1716805408587;
        Mon, 27 May 2024 03:23:28 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-df77474363fsm571270276.59.2024.05.27.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 03:23:28 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df771b6cc9cso3380439276.3;
        Mon, 27 May 2024 03:23:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBnEKd99Cb5+l7mqUV62YZqS2R0znN0IhQUdTjk9TDuI5RF+LUpDx8fL1xOJJ/2eH95XZuLhoPOyiH7buQ4JqCpEDMSeNlXGauzYL+BlcAZLHIJtGKxt1RKgmSGP3L+Bp8/XWl0PkAkcEb5jzEmGSP3eF5aM+MmJJRUR/mCLzzsLCBI7quD2gxwGD3E36S
X-Received: by 2002:a25:d393:0:b0:df4:dcb6:75bd with SMTP id
 3f1490d57ef6-df772160dd4mr10206351276.9.1716805407062; Mon, 27 May 2024
 03:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner> <20240527100618.np2wqiw5mz7as3vk@ninjato>
In-Reply-To: <20240527100618.np2wqiw5mz7as3vk@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 May 2024 12:23:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1kmLfT9NcQo3xhG0CzyNepmS39avw=SuyERHXc57xhw@mail.gmail.com>
Message-ID: <CAMuHMdW1kmLfT9NcQo3xhG0CzyNepmS39avw=SuyERHXc57xhw@mail.gmail.com>
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Mon, May 27, 2024 at 12:08=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Afaict, the "auto" option has either never existent or it was removed b=
efore
> > the new mount api conversion time ago for debugfs.
>
> Frankly, I have no idea why I put this 'auto' in my fstab ages ago. But
> it seems, I am not the only one[1].

fstab(5):

       defaults
           use default options: rw, suid, dev, exec, auto, nouser, and asyn=
c.

       noauto
           do not mount when mount -a is given (e.g., at boot time)

So I assume "auto" is still passed when using "defaults"?

However, nowadays (since +10y?), debugfs etc. tend to no longer be
put in /etc/fstab, but be mounted automatically by some initscript.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

