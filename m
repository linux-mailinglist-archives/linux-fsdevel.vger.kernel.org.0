Return-Path: <linux-fsdevel+bounces-72301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D422CECCBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7073C3009560
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 03:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7926A1AC;
	Thu,  1 Jan 2026 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ResmzQtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1052580DE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jan 2026 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767239869; cv=none; b=jvlp6XhnhdSXRpxaKW5kpYx/EKgXs4sqtLG241RK7hV63CX9nqlLUU++iqyC8FlTRU4xEohQwIqpd0FnfmTi6+DLcPuside7q6bXOyGgNQ5H84Mooqcki4YjzyuGED9Q71EqiB8rLfBMHfCIbo3yQMa3m+/z8Wo/UMnWktqsV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767239869; c=relaxed/simple;
	bh=/vyg0ynh5LAMEF2mj8X9Csbd5f/G8rOZ2939OPD08pY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i59eA3x1WFQYnJ67I+8TPwjFk00zjTCptZ4qLyIhMoBuoAs5z7XvRqTFV0b+paAi1pzr/oc5wDgvIDCTC37ljOmAAry3eajMbaWRMCyhNBsmhLne/qsNvUXbJLVlQiDEZVlkgHJjv+e6sogJJUsBTEzQTdDpSHPPVZ1TvgyU7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ResmzQtZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f8a6b37b2dso44080211cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 19:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767239867; x=1767844667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHJ9HSrCP71SSn2XcU2kZVrOG3UT/v21uGWNywYBtRo=;
        b=ResmzQtZqZmj7nJh6YPuumTuTL+8cDzHdZSHIKZHGrrhVnmXCgWz88PCJb2BAcoqrs
         KRIMnfOrwN49It406gO4C6StYMwlDzKEWmVVPKSbQ3EOl0qSvvone9p7Zh2/ISj94cgC
         b93BZjVIy51Ni7WRR9m5JECORQ/XfIQx8j4l3Fc4DF8KWPkVPiSNuACjZUMt7bPLbOW1
         ZT5JxkGGKQLJk0OxdYHnuRRbQxhxzzbpHRYvk7emS7UIFaHqJGiwkNO+tjuBvWVkZa6o
         vpHIZLhl0sOonCB8FCWCsGZ0P3SI8PY0Sz/EskfO98M+hZTbNJViyDdIbZCeniXIxvc+
         D8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767239867; x=1767844667;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHJ9HSrCP71SSn2XcU2kZVrOG3UT/v21uGWNywYBtRo=;
        b=NKCB3JOi9wDTg+PN34PjvzlFziC4WwSWY/aXRimRoqChGORpPOONDeM8AeKTmbwGTY
         /hYFjgaJuYTjj8KCNCKcTvpARPjE0RKeax9+H7g59zirBCDecm0CVyLMa7Ig5IaeCc0y
         O0a1IdlXhnr/CdZ/AS528lq4uKLDAhiQGgwcW8zfVO2NNmJpAqddUI4roaYxHKTadVeX
         n4N31FshVZJc15EyrEfk4B/MaoqrdYf8NWtS8mMdbVXJo9tMeXDbFIg/jniDmVWQL/4g
         d9y/KiB8IcN1Xj/Kd+chXJlDAMr2pszL3G/zsVtDLO8a6Wmjf8AG1WWnDy0SK0jkw+KW
         +C9A==
X-Forwarded-Encrypted: i=1; AJvYcCV2n7LbD4THWRxin0/gdHJKU6aQEQ6stEpgqXlKcxdPdpo+IL/j/ZN0wfaOO6m+PHb7tBQnngFkyerl9YUf@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSFP2dh27B0BaGYm/XVkrG4CQTEpBT63oFLERIpfzcjF6YB1t
	VjtkiLjv9AntTpKN6xEv1s37b1l7QdURr4m5zwKirgvaHVLJzZYEHWAq
X-Gm-Gg: AY/fxX6zu9eE6Z5UDmYCWcY7TYUqBXrBodufopRdgO+PFiHSAVFtJw/TR/VZ/l3mCGz
	MWpStXuQEoBTWVVTbj+Z5OAFTLvq+u5aS5DXKzGXStqgdFWgBI9Wf2yQ4o0UDCBFGjzC1lxTV4O
	Hk0hcsm0jE0t22hkUr7wn7ozzksgzPS7S0BvsPR6kEzIq8jrGvDOGeN0GxVsXMU1UGOEbvQxMd3
	KFGCihPUVSfqfmzwoI7iJI0g1P8LT5ruK6ojCkPD5ObrluB17Qug0D7LkH5wbWnTGHogNHihAXb
	GuwpYXUXb4MLWNgHAI6UZxJBc9LGqU/pVQbv7eEfPP/N4wcB5/59zNUcK+5SsxP95zfn2/hNoOY
	w4CQg9RYxv37+TQOyjV8zK5G5xfsKTxYc6FlIbvRjhOlAcH8hclNRn8lsfvtUgnNgBkz8ZRyDFQ
	GayCn/KeRV7sieHe4vm+7JH9isuGxCqT/FDHtTHS4qT1zHZLb+LppJZT4KSj6/+jgpLsI=
X-Google-Smtp-Source: AGHT+IGM0rVADS2lnU5j12v/LNHM3kU8YwfTvvv4Iz7GzLiaw8hH+kvxJs1uiRf5TU0O+ftRhl7yow==
X-Received: by 2002:a17:903:b90:b0:29f:301a:f6da with SMTP id d9443c01a7336-2a2f2a34f54mr371027125ad.43.1767233502214;
        Wed, 31 Dec 2025 18:11:42 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776c1sm334899895ad.102.2025.12.31.18.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 18:11:41 -0800 (PST)
Date: Thu, 01 Jan 2026 11:11:23 +0900 (JST)
Message-Id: <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
To: aliceryhl@google.com, lyude@redhat.com, a.hindborg@kernel.org
Cc: boqun.feng@gmail.com, will@kernel.org, peterz@infradead.org,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 catalin.marinas@arm.com, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, mark.rutland@arm.com, fujita.tomonori@gmail.com,
 frederic@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of
 read_volatile
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251231-rwonce-v1-4-702a10b85278@google.com>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-4-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 12:22:28 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Using `READ_ONCE` is the correct way to read the `node.expires` field.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/time/hrtimer.rs | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>          // - Timers cannot have negative ktime_t values as their expiration time.
>          // - There's no actual locking here, a racy read is fine and expected
>          unsafe {
> -            Instant::from_ktime(
> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
> -            )
> +            Instant::from_ktime(kernel::sync::READ_ONCE(
> +                &raw const (*c_timer_ptr).node.expires,
> +            ))
>          }

Do we actually need READ_ONCE() here? I'm not sure but would it be
better to call the C-side API?

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index 67a36ccc3ec4..73162dea2a29 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -2,6 +2,7 @@
 
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/hrtimer.h>
 #include <linux/timekeeping.h>
 
 void rust_helper_fsleep(unsigned long usecs)
@@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
 {
 	udelay(usec);
 }
+
+__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
+{
+	return timer->node.expires;
+}
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 856d2d929a00..61e656a65216 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -237,14 +237,7 @@ pub fn expires(&self) -> HrTimerInstant<T>
 
         // SAFETY:
         // - Timers cannot have negative ktime_t values as their expiration time.
-        // - There's no actual locking here, a racy read is fine and expected
-        unsafe {
-            Instant::from_ktime(
-                // This `read_volatile` is intended to correspond to a READ_ONCE call.
-                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
-            )
-        }
+        unsafe { Instant::from_ktime(bindings::hrtimer_get_expires(c_timer_ptr)) }
     }
 }
 

