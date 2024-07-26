Return-Path: <linux-fsdevel+bounces-24351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D093DB2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 01:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AEB1F243DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093214EC62;
	Fri, 26 Jul 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Ih0Abz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397317BDC;
	Fri, 26 Jul 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037456; cv=none; b=DB8XeqqfsgLCUyUIkdM5UowO1Q9WdZdIQewC41Esxx/friPAJFIXGd8aneLO8enlordvpF8dR7a0YOfgRf7m1VaPC+cp/0NdAZHXvvIWkO6K6xu6cVSvDItSfUUnGAfarZcVh7tobyzY2XGFraeLe9NlIfpfQqvwjHiuQoKQS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037456; c=relaxed/simple;
	bh=2KNns/7ZahY9tw7x29VXVKG43LGYdEIM+ViJ7hYyhXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG3Gj/w9inEVTLx0cm7vs8xlsXqd0wpEnyzWtVRpgRGrcIgp9/+B/Ik9+w/qTovvyFQSUcN5HWKZPMOINOwN9vAKKmYmEWdhlW3ei7NytipXDn+PWUsKA162lYMiaqIYNNOTQechMS7zbQSJm/bb9OiXG32bbXz2pwTZozPIxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Ih0Abz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4ECC32786;
	Fri, 26 Jul 2024 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722037455;
	bh=2KNns/7ZahY9tw7x29VXVKG43LGYdEIM+ViJ7hYyhXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q2Ih0AbzP1JQVKriveLDIqHmPh834iATSjbI13Yvhl8jgstl2zm3DKUck2lZyHyCW
	 zbsw5R+EdnJRLbJElgxi0Rq52UIygmqiyzJSKKEjATdJ7Sv7upHiSq12nm8dKnokja
	 bIJB0ni9s8Y+heFjLYCHzCatHFhi1mSyneGM5w07cEj9dnmt68zRc7n5SgU9Dg3fP+
	 6AyTVf8RuuZ0+6ZOgCBLvL6i4rwA7jKB5OkJw/e8PPu6KsWpTzZWMhlxdhKx1Yh9rS
	 4SEmTS4wVYtZIhW8GWTT8NVJ2HLn2eRdBdmmSRNqSBfeGLoiMWkqmWvNpAgm33rA8R
	 /WgBsK94CVedA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efa16aad9so2414420e87.0;
        Fri, 26 Jul 2024 16:44:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpU9TrNVelTjtCtgolqBFxH4OMF65jne7NnXglnW1hvL3cxXl8MvC3MdhpXpQDzyMroaFx6/ak+QrD8P8JbSDRmuBYMl0SdKo532bulw==
X-Gm-Message-State: AOJu0Yw6H+hjmhZ+A5PFeNHEbVgfDbFRD5tXJ25wChCha0Ctme6SpAwL
	lig+W3FOQdppkJbYOt9NH7x4si8CczsALFRY9wpqtcY93WMVtOQyg8h/4zuZb4gZmQpT6OSaZoB
	1bxLDegD4rtKMt5zeeC/a7h64BiI=
X-Google-Smtp-Source: AGHT+IEPhZrA0YUHOcOpH8qPvEzi/d9jBKKQIsS9UHU4lsCBhcnoLu4kGwS6nCDAZ9VIjekttmZuKgjfGAmdyIcahI4=
X-Received: by 2002:a19:8c58:0:b0:52c:f12a:d0e0 with SMTP id
 2adb3069b0e04-5309b27a656mr655906e87.28.1722037453998; Fri, 26 Jul 2024
 16:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726085604.2369469-4-mattbobrowski@google.com>
In-Reply-To: <20240726085604.2369469-4-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Jul 2024 16:44:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4QvpRdeqGOMQ11soArcpYa+mnK0pM+Q_nJmbY5+V+VyQ@mail.gmail.com>
Message-ID: <CAPhsuW4QvpRdeqGOMQ11soArcpYa+mnK0pM+Q_nJmbY5+V+VyQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add positive tests for new
 VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, 
	jannh@google.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:56=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Add a bunch of positive selftests which extensively cover the various
> contexts and parameters in which the new VFS based BPF kfuncs may be
> used from.
>
> Again, the following VFS based BPF kfuncs are thoroughly tested within
> this new selftest:
> * struct file *bpf_get_task_exe_file(struct task_struct *);
> * void bpf_put_file(struct file *);
> * int bpf_path_d_path(struct path *, char *, size_t);
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Song Liu <song@kernel.org>

