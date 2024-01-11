Return-Path: <linux-fsdevel+bounces-7810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CA82B4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29E51F25351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5842068;
	Thu, 11 Jan 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh3fcnUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189C26AC7;
	Thu, 11 Jan 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5efb0e180f0so58777927b3.1;
        Thu, 11 Jan 2024 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704999441; x=1705604241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tFh3qsYh0T8RX+oziEs6jEklh5e0dLow8jErOyNNUZU=;
        b=mh3fcnUisgeVNc1NyJrc+BjKORZflHhLaU8/uARxVkd2AA22vMJiJWF/8sx1hwg1HI
         AIvEK1QoY+xaOXJUa/xaLPgYiHEVicyqaSWwRRfkJenwxNehW5XQbLBPJfXjmNh3dXGC
         VwOvrhDNszz5r5kVR34NUJm1wkMDB4bpWewrIjDxiItccpmkoBV2s2zz2umoqFgTIxv1
         SGbOskZjmcNz1ObOwXLzOnXq0sWZxrxwwuWVU8q+AZoND6ZHQWrv1KgHcc4+RyWXksK+
         u7PR8LnxRrx61S579CIlqvznovSw51UXIGdj5dJRX27csGE6KNEM/INoaPaiJ/szuNRk
         q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704999441; x=1705604241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFh3qsYh0T8RX+oziEs6jEklh5e0dLow8jErOyNNUZU=;
        b=c+YJZlZR5bntAsMCS9RY0fo2a7a288zXJYprCwhkLFtqWj/AHaNKmE5kJGqEyN8/4+
         6+rsoWPppLLjefWD137aiNtLiYPvooLNZ6XCadDbGJlrvNISeHRDPFaKAYMl4p0B9wrR
         71v6L5yu0reXT0I0NXMVAsktY04wd+7G3YjOOPIZI5bEpedoSOc3BC+Wt8IHLZYu0rfi
         m2yOVbhZYui26e6a6hWNAA7rZE4R2aGU56N3tS/QRQHK2fWmhbKu/W6qUeOtguRi7YdG
         NwFb4bpgNZ+Eg4E8hete6i6xSYWXe9hRuGFmVcODXmrkMJZicujSyrjIyfOBPr1jXGP7
         +I+w==
X-Gm-Message-State: AOJu0Ywt4oBGrEotqyKTZmQn/OghIIdvX2mtWsyH10MMmIzs4AkWELVT
	R6IF2fdriU8D6TML6ZxFfGE=
X-Google-Smtp-Source: AGHT+IEjOVlqBPgWjm1I/LWUZ0pAOGk0PP7MBg5TBGrx2KB/NwqwHabBz3kBY8lmmtJ1qSDp62bfRQ==
X-Received: by 2002:a81:f005:0:b0:5fa:ea54:f413 with SMTP id p5-20020a81f005000000b005faea54f413mr247403ywm.1.1704999440683;
        Thu, 11 Jan 2024 10:57:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3-20020a819103000000b005e8da478ccasm630440ywg.97.2024.01.11.10.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 10:57:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
Date: Thu, 11 Jan 2024 10:57:17 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <christian@brauner.io>, Amir Goldstein
 <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
 <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 16:32, Linus Torvalds wrote:
> On Wed, 10 Jan 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> with this patch in the tree, all sh4 builds fail with ICE.
>>
>> during RTL pass: final
>> In file included from fs/namespace.c:11:
>> fs/namespace.c: In function '__se_sys_listmount':
>> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
> 
> We do have those very ugly SYSCALL_DEFINEx() macros, but I'm not
> seeing _anything_ that would be odd about the listmount case.
> 
> And the "__se_sys" thing in particular is just a fairly trivial wrapper.
> 
> It does use that asmlinkage_protect() thing, and it is unquestionably
> horrendously ugly (staring too long at <linux/syscalls.h> has been
> known to cause madness and despair), but we do that for *every* single
> system call and I don't see why the new listmount entry would be
> different.
> 

It isn't the syscall. The following hack avoids the problem.

diff --git a/fs/namespace.c b/fs/namespace.c
index ef1fd6829814..28fe2a55bd94 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5070,8 +5070,10 @@ static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
                 ctr = array_index_nospec(ctr, bufsize);
                 if (put_user(r->mnt_id_unique, buf + ctr))
                         return -EFAULT;
+#if 0
                 if (check_add_overflow(ctr, 1, &ctr))
                         return -ERANGE;
+#endif

But it isn't check_add_overflow() either. This "helps" as well.

diff --git a/fs/namespace.c b/fs/namespace.c
index ef1fd6829814..b53cb2f13530 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5068,8 +5068,10 @@ static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
                 if (!is_path_reachable(r, r->mnt.mnt_root, orig))
                         continue;
                 ctr = array_index_nospec(ctr, bufsize);
+#if 0
                 if (put_user(r->mnt_id_unique, buf + ctr))
                         return -EFAULT;
+#endif
                 if (check_add_overflow(ctr, 1, &ctr))
                         return -ERANGE;


Any variance of put_user() with &buf[ctr] or buf + ctr fails
if ctr is a variable and permitted to be != 0. For example,
commenting out the call to check_add_overflow() and starting
the loop with ctr = 1 also triggers the problem, as does replacing
the call to check_add_overflow() with ctr++;. Using a temporary
variable such as in
	u64 __user *pbuf;
	...
	pbuf = buf + ctr;
	if (put_user(r->mnt_id_unique, pbuf))
                         return -EFAULT;

doesn't help either. But this does:

-               if (put_user(r->mnt_id_unique, buf + ctr))
+               if (put_user(r->mnt_id_unique, (u32 *)(buf + ctr)))

and "buf + 17" as well as "&buf[17]" work as well. Essentially,
every combination of "buf + ctr" or "&buf[ctr]" fails if buf
is u64* and ctr is a variable.

The following works. Would this be acceptable ?

diff --git a/fs/namespace.c b/fs/namespace.c
index ef1fd6829814..dc0f844205d9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5068,10 +5068,11 @@ static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
                 if (!is_path_reachable(r, r->mnt.mnt_root, orig))
                         continue;
                 ctr = array_index_nospec(ctr, bufsize);
-               if (put_user(r->mnt_id_unique, buf + ctr))
+               if (put_user(r->mnt_id_unique, buf))
                         return -EFAULT;
                 if (check_add_overflow(ctr, 1, &ctr))
                         return -ERANGE;
+               buf++;
         }
         return ctr;
  }

Guenter


