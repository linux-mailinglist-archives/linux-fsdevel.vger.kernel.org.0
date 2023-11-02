Return-Path: <linux-fsdevel+bounces-1840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8137DF625
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4C9281B33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9421C29D;
	Thu,  2 Nov 2023 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qb9ZXZl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823719BDE
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:18:09 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845AF13D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:18:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a6190af24aso164634766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698938283; x=1699543083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi6BGbaajC0NEJYmO6rk7RlnqCChXrOH9lm+rlx8Qc8=;
        b=qb9ZXZl7lWJosECGESF0gUm23qyl5+K97Ir2SXQ4m0XrPEr9PdEM/s8RPIDPQWNJTo
         9QdKzlZka5Ey2hkCPIgnEhbi9xr6t+wIY3zPOhBUD9trTmSiQpOzm+b5pWngIkQ2+Mxk
         Pqr7kaAQvwM0Z4t1YTJJadHWJoyXbxcuIa4VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698938283; x=1699543083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi6BGbaajC0NEJYmO6rk7RlnqCChXrOH9lm+rlx8Qc8=;
        b=QzR8aBGz2w7tUALvbQI4oZ6+882NjdnF7LZjtImQdEsJjg8ylVZ7r2ISoplYY4spkP
         YLI0ikVWO2S3qVIgpa/9zG/sB9CMfLiJFW/5+EwKwhOoHN4CO2ULyoU+CkncpZOLqwuQ
         +qve2elzO/4F7aGl3GuhAZtvo2szzNBlTr+si5PTUNY8fJtnYXgY7etZfck39aPE+eus
         RJH6Jle+cJ5EldydOKLgYdAzjPjI61Koq8sykphEQGDvNyrBjXPLAmVUjvs8IoyJLeq4
         9s0aylxfuukmj7dkgbfBdXUDQ8UT9xyYMzgzvyGlTh1ur29gWveFOg/G4P5vs8/f0J7o
         c4VQ==
X-Gm-Message-State: AOJu0YxDIKsmNVO1gAIXPsbTRLy7UOoANIpYVkp1qNMDUfqvoPFA6rND
	ClZUfdTcfSOeiYKYpJ/EmxSwl1HLu+f3zFs3tNx2/g==
X-Google-Smtp-Source: AGHT+IFSz/TJ2waNg6ELwtl1jRTKf9TUnDv883tJKjv5rWxyrAJaMmUOyYZSvLJiqW+vLgnkKpulWFoYptGHPCkyqM4=
X-Received: by 2002:a17:907:7f06:b0:9be:6ff7:1287 with SMTP id
 qf6-20020a1709077f0600b009be6ff71287mr5143198ejc.57.1698938282819; Thu, 02
 Nov 2023 08:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031144043.68534-1-winters.zc@antgroup.com>
In-Reply-To: <20231031144043.68534-1-winters.zc@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Nov 2023 16:17:51 +0100
Message-ID: <CAJfpegtjNj+W1F4j_eBAij_yYLsC9A3=LgNvUymSykHR5EvvoA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: Introduce sysfs APIs to flush or resend
 pending requests
To: =?UTF-8?B?6LW15pmo?= <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Oct 2023 at 15:41, =E8=B5=B5=E6=99=A8 <winters.zc@antgroup.com> =
wrote:
>
> After the fuse daemon crashes, the fuse mount point becomes inaccessible.
> In some production environments, a watchdog daemon is used to preserve
> the FUSE connection's file descriptor (fd). When the FUSE daemon crashes,
> a new FUSE daemon is restarted and takes over the fd from the watchdog
> daemon, allowing it to continue providing services.
>
> However, if any inflight requests are lost during the crash, the user
> process becomes stuck as it does not receive any replies.
>
> To resolve this issue, this patchset introduces two sysfs APIs that enabl=
e
> flushing or resending these pending requests for recovery. The flush
> operation ends the pending request and returns an error to the
> application, allowing the stuck user process to recover. While returning
> an error may not be suitable for all scenarios, the resend API can be use=
d
> to resend the these pending requests.
>
> When using the resend API, FUSE daemon needs to ensure proper recording
> and avoidance of processing duplicate non-idempotent requests to prevent
> potential consistency issues.

Do we need both the resend and the flush APIs?  I think the flush
functionality can easily be implemented with the resend API, no?

Thanks,
Miklos

