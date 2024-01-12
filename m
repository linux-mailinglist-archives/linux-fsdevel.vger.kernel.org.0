Return-Path: <linux-fsdevel+bounces-7854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDF82BAD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5FE1C24C57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FC5B5D2;
	Fri, 12 Jan 2024 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu648VVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B275C8E1;
	Fri, 12 Jan 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e7409797a1so59481087b3.0;
        Thu, 11 Jan 2024 21:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705037068; x=1705641868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heVTH2EP/JfOmY9Rzq8j0Q0ltkkFkZbT8oB6/EA/QjU=;
        b=hu648VVH2kYUu4lEodQaeYcP1B4Rsits3CLYbZp7NuycxoBngWpJ8Re4Oc75vs0nma
         jgOy5N9maMKa2LBoMdO5bxB9kNStDnlX56wXTIp8K/FMHSVT8b6zNGNKjRKByYTAvwv6
         JW7XmhZ6cJNfLHEudrfODQyJRqo8ScJjas4Qvv9OZWpSd71fK8Sp4Vjdrf16nCsN5JbC
         GpZDpNArbU3AtX6F7CmP/jIX7jmIl+M6Wa4NRxVS2l8ExHNuXbb5a41Zwk2R5UfICLLv
         iPnsvJtCZSAcYXphBYa6x9CRPZdyHLeQn+5mAma6VNT0JCyrm6c4r7iUiBbVnvvMYuPy
         1/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705037068; x=1705641868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heVTH2EP/JfOmY9Rzq8j0Q0ltkkFkZbT8oB6/EA/QjU=;
        b=NqvJrnNbt0dIEMJEUzzz3klgU4gidwkefnw6NWLLnsCHpOCRf8T7E1s8ma2LNTlLOv
         b6QJ97Jf4S/1uwb1/2wiKfIAIxAW3uydjfxzVs2o4Dy493kpcLaHO0scuPLxal+X0gde
         Bgdv1SHjP22Ue6g3dMAHQK0HgL2SSlG+Z9UgKOt3rWIl+tzHBxKAH7ZDQex6GYOGwltt
         P9Rfti9LOzl9TZrvo6uWcnNmK7MKnDjOC7TiaOL1aYRjlQgKaM7DLctdtzYDtNz2rW/X
         Jwee3xcV0reKhI5AkXfu80YVg6mtmAOrU+L8r3d56gQVbC0GCq4MCXVrsny6Kuq/oB8S
         3b4g==
X-Gm-Message-State: AOJu0Yx4UVNNjCed3PCZcfCFJaZ0Od3otqLhQY/SRfms9ZsEeBaucna6
	aGzVzyKXYm35hEQZWaP5aXA=
X-Google-Smtp-Source: AGHT+IHuOgViTEPqU3OZ6NudbUXy1IrnGt80tE6bb6BIEVIHp1ZRyR4nzDuuMpu800H7CQ3z0WgXaw==
X-Received: by 2002:a0d:cccf:0:b0:5cd:c7a3:6cb3 with SMTP id o198-20020a0dcccf000000b005cdc7a36cb3mr867678ywd.37.1705037067775;
        Thu, 11 Jan 2024 21:24:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s65-20020a819b44000000b005e7fb8e1fdasm1058473ywg.14.2024.01.11.21.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 21:24:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 11 Jan 2024 21:24:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Message-ID: <ab4e88fa-af6a-49e9-a8bc-3cdc3a531aaf@roeck-us.net>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
 <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
 <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
 <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
 <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>

On Thu, Jan 11, 2024 at 07:40:32PM -0800, Linus Torvalds wrote:
> On Thu, 11 Jan 2024 at 15:57, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > I wonder if something may be wrong with the definition and use of __m
> > for u64 accesses. The code below also fixes the build problem.
> 
> Ok, that looks like the right workaround.
> 

I think I'll go with the code below. It doesn't touch the MMU code
(which for some reason doesn't result in a build failure), and
it generates

! 5071 "fs/namespace.c" 1
        mov.l   r6,@r1
        mov.l   r7,@(4,r1)

which seems to be correct. It also matches the pattern used
for __put_user_asm(). Does that make sense ?

Thanks,
Guenter

---
diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..5ce46b2a95b6 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -176,6 +176,7 @@ do {							\
 } while (0)
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_MMU
 #if defined(CONFIG_CPU_LITTLE_ENDIAN)
 #define __put_user_u64(val,addr,retval) \
 ({ \
@@ -221,6 +222,26 @@ __asm__ __volatile__( \
 	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
         : "memory"); })
 #endif
+#else
+#if defined(CONFIG_CPU_LITTLE_ENDIAN)
+#define __put_user_u64(val,addr,retval) \
+({ \
+__asm__ __volatile__( \
+	"mov.l	%R0,%1\n\t" \
+	"mov.l	%S0,%T1\n\t" \
+	: /* no outputs */ \
+	: "r" (val), "m" (*(u64 *)(addr)) \
+	: "memory"); })
+#else
+({ \
+__asm__ __volatile__( \
+	"mov.l	%S0,%1\n\t" \
+	"mov.l	%R0,%T1\n\t" \
+	: /* no outputs */ \
+	: "r" (val), "m" (*(u64 *)(addr)) \
+	: "memory"); })
+#endif
+#endif /* CONFIG_MMU */
 
 extern void __put_user_unknown(void);
 

