Return-Path: <linux-fsdevel+bounces-831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ADB7D1060
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38A6282412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B21A73B;
	Fri, 20 Oct 2023 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KUOW6tHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFB1A70E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:18:45 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119919E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 06:18:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so180519166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697807922; x=1698412722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=KUOW6tHoH0YoRWmfTiYARPJh3y1s6CDX5alQWBN3z01Pox70KX1YmMeO4X8gmj80tz
         K4RAjFE7F6eu6sKWA8DNl5+VOzXiOhmW2Purw1TYWmojIpSfMpme5ITPOvFlXJW6gkOs
         RUxubMSHkKeGzfJUt/vfeX5Uvqu3tle5S0pJ1kJxeDkH9ty7a5MtTh6X0UWOjNkr/NSy
         GR2ERAP5mG5IONJh4g0dqFblVKeR620s2ZyBbRuOvXXt+WPG/xWFf1UHvocjUakUUMWV
         Sy7YWU6fCNmb4JC58tx/qKchZHrcWyHiJcH9jxYAOKOnVZzjUG9M47GXWwKI/rtndEKX
         BwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807922; x=1698412722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=uO23yS6uzpOvbWPntuVJvt2FeY5er9zQcg4bAQc9k90QtTsBTVlrrtexcsVzYK5FLJ
         hho9ozKLKQu8jiiauh69MYJpAHYxJbHvUk2fU5PWjFafmYosVCTIHKCNXkuR4B0MkHFE
         vzZp2kAYlcaJhv7gx4Kefc5/nNAK37cJGV4nZ7lGG21gdHYp9H9W73NVq5VplQIX6qjV
         eqQe+jyAaYgs1JVKQD94yaGOb+8flEA9xqZVqdczG/TC+vhiRMCsbwY1sRncvzmoZTKr
         qm23Wqt+mfKPGXfJ1sTUdUGu+iYfkRU6B6OhBlcSmSo5DyJq2pAv/9K7We6DALXdSTC3
         P0PA==
X-Gm-Message-State: AOJu0Yzj9mIC+UqJ5szqvVtrnaq5GzwPv+Kq/w1k5oHKRffpfItZvY8m
	tg6y5cHmP0x5oCK+YkIQSUr0KMTRihpQ/i/wq9y6QD2zLRBggNWECbQ=
X-Google-Smtp-Source: AGHT+IHJ0YVjts5wXBN5Jqp31pQ7zOyCplhCxmKRWiIG/OBUb9hPTVLkywcsxvesYEBUsruBmhSCSDcUubMxrq+Mqbc=
X-Received: by 2002:a17:907:7f2a:b0:9ae:659f:4d2f with SMTP id
 qf42-20020a1709077f2a00b009ae659f4d2fmr1364024ejc.26.1697807922329; Fri, 20
 Oct 2023 06:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org>
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Fri, 20 Oct 2023 14:18:31 +0100
Message-ID: <CAN+4W8hu+zWiWejWtc72WwQb6ydL3U3LXvaFBdc0o826JKzoAQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com, 
	sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
...
> This patch set adds a basic minimum of functionality to make BPF token id=
ea
> useful and to discuss API and functionality. Currently only low-level lib=
bpf
> APIs support creating and passing BPF token around, allowing to test kern=
el
> functionality, but for the most part is not sufficient for real-world
> applications, which typically use high-level libbpf APIs based on `struct
> bpf_object` type. This was done with the intent to limit the size of patc=
h set
> and concentrate on mostly kernel-side changes. All the necessary plumbing=
 for
> libbpf will be sent as a separate follow up patch set kernel support make=
s it
> upstream.
>
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
> instance(s) at well-defined locations to allow applications take advantag=
e of
> this in automatic fashion without explicit code changes on BPF applicatio=
n's
> side. But I'd like to postpone this discussion to after BPF token concept
> lands.

In the patch set you've extended MAP_CREATE, PROG_LOAD and BTF_LOAD to
accept an additional token_fd. How many more commands will need a
token as a context like this? It would cause a lot of churn to support
many BPF commands like this, since every command will have token_fd at
a different offset in bpf_attr. This means we need to write extra code
for each new command, both in kernel as well as user space.

Could we pass the token in a way that is uniform across commands?
Something like additional arg to the syscall or similar.

Lorenz

