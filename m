Return-Path: <linux-fsdevel+bounces-5380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2280AF06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5B81F21219
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208DD58ABD;
	Fri,  8 Dec 2023 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOtIDtz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87D10E0;
	Fri,  8 Dec 2023 13:55:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67abd020f40so28588336d6.0;
        Fri, 08 Dec 2023 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702072531; x=1702677331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V8vWGz5/dJUjY/urBndjDFSG8k8j3bSatsr73/t6EE=;
        b=hOtIDtz1ZUhqEfusq1DOleorOM58PdS/D8tWn0hRaIp+1Q7kQka7Bt3bcdQmRV+oVY
         rY23hTHghxKr1dCxnwCLznOv4QZjYfqgrsHPxRaoKFH05zpe7byB0+v/Q47Jsawqs8qv
         Ko6B73Bvn8QhjVqluvoZ4X/yuuUOFJNxidgiz2NTEavgeJMipoalcUijDUSgR6QG1u9o
         /atqaagM2uvzWw7zl9yghPxVE0kaqYTzlaREj6Bu24c7bcsr4ZdIGgJqxcG4K9qKN4Th
         5qk36ZoiRgtQpiNJb4YUSU70VLrcv9qqD/r71z95/H6qKhI2qzJeiIn52g1AwpgiR5mG
         T18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072531; x=1702677331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V8vWGz5/dJUjY/urBndjDFSG8k8j3bSatsr73/t6EE=;
        b=optTXUfRmmz/yUKRGxpE9oL8osHQ7V3vbfdnD7gSMeu2k6r91bR5+F2Z6IWIzVFNHV
         0AsmAy2ic8XcXL4sbERBMECJukNnkoeAPZply3dDYXogP6w/vjKAt8h5rVhIhm2tDMRJ
         IALoYFE6C4AK9nf7UucS0NljcXuiStT6ed0dTYx8U59tDFOg3kYmj+wGLWc2x/heGKm6
         4gC0+QEJ0wWOR57vyW4wxyrdXhDdIhwN38mKioV4dxPRdJgCntkRbX9aniBnEot6Rifm
         7vhWYp2n91GNyq2hQ/C9ID8Rf2y2SEG64QAc0CvRjwCG1fWummpCA+EtOfQ+6NJ8Obk0
         bPYQ==
X-Gm-Message-State: AOJu0YyXN31k1B6NkDQREwDRX7G5Zwrwu+v9lRDZ7ClWAgtpIlGSvIX3
	Pmm108MMVO7KIF+tPmQiBYTrb7FzQuqy5NMLprg=
X-Google-Smtp-Source: AGHT+IH2i1FNcnWTur5vxTyWRGGWBiAGh91/5FPA8f6UZMtZfRtTTezksmqSJymLBKckYKQovbca1VJLx2GohwvuPKA=
X-Received: by 2002:a0c:fc47:0:b0:67a:ceb0:6161 with SMTP id
 w7-20020a0cfc47000000b0067aceb06161mr1365436qvp.53.1702072530813; Fri, 08 Dec
 2023 13:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2023 23:55:19 +0200
Message-ID: <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, paul@paul-moore.com, 
	stefanb@linux.ibm.com, jlayton@kernel.org, brauner@kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 7:25=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> EVM updates the HMAC in security.evm whenever there is a setxattr or
> removexattr operation on one of its protected xattrs (e.g. security.ima).
>
> Unfortunately, since overlayfs redirects those xattrs operations on the
> lower filesystem, the EVM HMAC cannot be calculated reliably, since lower
> inode attributes on which the HMAC is calculated are different from upper
> inode attributes (for example i_generation and s_uuid).
>
> Although maybe it is possible to align such attributes between the lower
> and the upper inode, another idea is to map security.evm to another name
> (security.evm_overlayfs)

If we were to accept this solution, this will need to be trusted.overlay.ev=
m
to properly support private overlay xattr escaping.

> during an xattr operation, so that it does not
> collide with security.evm set by the lower filesystem.

You are using wrong terminology and it is very confusing to me.
see the overlay mount command has lowerdir=3D and upperdir=3D.
Seems that you are using lower filesystem to refer to the upper fs
and upper filesystem to refer to overlayfs.

>
> Whenever overlayfs wants to set security.evm, it is actually setting
> security.evm_overlayfs calculated with the upper inode attributes. The
> lower filesystem continues to update security.evm.
>

I understand why that works, but I am having a hard time swallowing
the solution, mainly because I feel that there are other issues on the
intersection of overlayfs and IMA and I don't feel confident that this
addresses them all.

If you want to try to convince me, please try to write a complete
model of how IMA/EVM works with overlayfs, using the section
"Permission model" in Documentation/filesystems/overlayfs.rst
as a reference.

Thanks,
Amir.

