Return-Path: <linux-fsdevel+bounces-6877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584681DC48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC081F21842
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DEE554;
	Sun, 24 Dec 2023 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WxbE8QYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A715DDC1
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78102c516a7so306550585a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703448058; x=1704052858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRhZWIGZneY7CCk3NyYKzqQhTCRd0INElGt/+FX8Ozs=;
        b=WxbE8QYwMhotoSjgzbrHUz11XXIpJvliUzjUMcnsEGkvVEkHH56HzkAG7NtlHmJZFU
         axclxQqDLY8ltd/9D5HVw6EHJLKnmPt8nosT/fvxkqqiNeyLIrS5606iwxB48GfqButo
         9rOz8ADlf+0ehUsWKQltu9IEXzNSaCEDrDh9+p+1pwSHbR4GjPoVJMC6+BR1wLTJ6SU7
         TA+upgE11si9E1gLSAM4sHsrZi1usl/3hUgIkgZVK8I4D3cWfjnbO1HaPw+mcIfTJHeV
         CL6lmeD5cq+mjEVriLXzMqkHgoompO9xpdEB3iB9qOdlXxoANi9tCNhxmBxwuqWhGm+o
         9ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703448058; x=1704052858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRhZWIGZneY7CCk3NyYKzqQhTCRd0INElGt/+FX8Ozs=;
        b=qvEED+5VNp10L2guxQIo3wpkst1MWq75Fq8WEyQPryTeSYhbjwxem7L8KjOGzLqUys
         mDQnA/X6YsYj7tIzgXuB5DDZm0ZbsPdAjclZeWCCD3Hf7iKTkX7LzqJ3oRBPqOfMUamI
         gJOPSrPh92GzlOn+t+sf8KYWXRNB2JhF8EKo/ifDTJO7lildA1rbiRi0rXEV64kn0tDJ
         ihCKTMxGg93IVD4l55XzQ12YcbBEmqbTDsL+as4hfzCxFrL6lzBada4LDm13iyPe+w7q
         6Gl5PhVEO/NRVGHIiVMjd+BEq3BTLWUwf+v23GAhGH9CByRoWJzlbMsJjCGiJLqZdqJw
         u7CA==
X-Gm-Message-State: AOJu0YzDzH0kSzv9H+OrSJkuXjt0s0RiOqODrsa05v3DCJH7pWUGP//R
	ow5mWi2VEIS7uY6wYKYJONJlYTLHpkyol6I4jZ8gOyY7EbsO
X-Google-Smtp-Source: AGHT+IGGEVFeFhkTB7jVchuDtKXOnHqNKcGmknAIqqagn0+tlp3+In1BgHtNLZSu5UGOR93R9NGNy8KuFxDKeYwgPB0=
X-Received: by 2002:a05:620a:5311:b0:77d:cd41:1254 with SMTP id
 oo17-20020a05620a531100b0077dcd411254mr5910352qkn.12.1703448058542; Sun, 24
 Dec 2023 12:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com> <20231223153411.GB901@quark.localdomain>
In-Reply-To: <20231223153411.GB901@quark.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:00:46 -0500
Message-ID: <CAHC9VhRV9WN_pQgQUvkz7wb_oHO86JRV5r7twG6ropoJaR3Ujw@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alfred Piccioni <alpic@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 10:34=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> On Fri, Dec 22, 2023 at 08:23:26PM -0500, Paul Moore wrote:
> > Is it considered valid for a native 64-bit task to use 32-bit
> > FS_IO32_XXX flags?
>
> No, that's not valid.

Excellent, thank you.

> > If not, do we want to remove the FS_IO32_XXX flag
> > checks in selinux_file_ioctl()?
>
> I don't see any such flag checks in selinux_file_ioctl().

Neither do I ... I'm not sure what I was looking at when I made that
comment, I'm going to chalk that up to a bit of holiday fog.  Sorry
for the noise.

> Is there something else you have in mind?

Nope.

--=20
paul-moore.com

