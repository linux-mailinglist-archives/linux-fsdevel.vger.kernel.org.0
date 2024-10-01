Return-Path: <linux-fsdevel+bounces-30505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C098BDF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401451C21500
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0721C3F34;
	Tue,  1 Oct 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qSqm3bad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463C3D7A;
	Tue,  1 Oct 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789817; cv=none; b=praywevr9bL2WX4EvdLbBfEjXaMDQvreW2L9QKTEFY68Yv30XjclUFKgKe9BU0g2tIv/M7T4G0ElX9TGk+M8jFBwT5tkXBzGj7+/PwM06iBkqn8sI9aj9UtyYSKl+4pWDWp+LHk3hTs05jNGglsi4f5ZDNnzYhEhXrxjgbru2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789817; c=relaxed/simple;
	bh=c/Rk6PjmJ6GfC6NURLP1vSsA9XLmz1niuHd9MU2R9eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtitGfi+C2CFot78m1fRU/NIgW7ByQjr+fM+A9Zyq3zCPJF02WWkLcocNi5pF16fuzJT4tV6vdzHFDQVi1KgEX3oppKa/TxNa4C011AiESn4aE11a22k37UZvXeyeSc4y68A08Zn0JLP5OsPJaNNU2dd3O5dfbPn4E3mnsJ6a0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qSqm3bad; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3143:0:640:c03:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id CD1DF60F6D;
	Tue,  1 Oct 2024 16:29:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bTapn58i2iE0-2EyJBfL4;
	Tue, 01 Oct 2024 16:29:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727789381; bh=KubsaPbyWvwFEquzJqrt0T5NjPeudcABlCQsvgPu6Wc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=qSqm3badk6i9jZ40aZgck5nFcpbu+vw+uwNo3AjkrMl5iLfgL5Q6WdHLI2WjUGfjO
	 lKex9w1nOijQDDZqK6kgZ8xgmZ0tKIHCfBBhKAGWOq4SYeVjhm8XFiZ5NLISJqxnfI
	 Gk9teRAEVjzf/nk/S+lZhIwMGQ8URuyjKJxt/9/U=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <62362149-c550-490f-bd7a-0fd7a5cd22bc@yandex.ru>
Date: Tue, 1 Oct 2024 16:29:37 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add group restriction bitmap
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Florent Revest <revest@chromium.org>, Kees Cook <kees@kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins
 <charlie@rivosinc.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Samuel Holland <samuel.holland@sifive.com>, linux-fsdevel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>
References: <20240930195958.389922-1-stsp2@yandex.ru>
 <20241001111516.GA23907@redhat.com>
 <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
 <20241001130236.GB23907@redhat.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241001130236.GB23907@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

01.10.2024 16:02, Oleg Nesterov пишет:
> On 10/01, stsp wrote:
>> 01.10.2024 14:15, Oleg Nesterov пишет:
>>> Suppose we change groups_search()
>>>
>>> 	--- a/kernel/groups.c
>>> 	+++ b/kernel/groups.c
>>> 	@@ -104,8 +104,11 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
>>> 				left = mid + 1;
>>> 			else if (gid_lt(grp, group_info->gid[mid]))
>>> 				right = mid;
>>> 	-		else
>>> 	-			return 1;
>>> 	+		else {
>>> 	+			bool r = mid < BITS_PER_LONG &&
>>> 	+				 test_bit(mid, &group_info->restrict_bitmap);
>>> 	+			return r ? -1 : 1;
>>> 	+		}
>>> 		}
>>> 		return 0;
>>> 	 }
>>>
>>> so that it returns, say, -1 if the found grp is restricted.
>>>
>>> Then everything else can be greatly simplified, afaics...
>> This will mean updating all callers
>> of groups_search(), in_group_p(),
>> in_egroup_p(), vfsxx_in_group_p()
> Why? I think with this change you do not need to touch in_group_p/etc at all.
>
>> if in_group_p() returns -1 for not found
>> and 0 for gid,
> With the the change above in_group_p() returns 0 if not found, !0 otherwise.
> It returns -1 if grp != cred->fsgid and the found grp is restricted.

in_group_p() doesn't check if the
group is restricted or not.
acl_permission_check() does, but
in your example it doesn't as well.
I think you mean to move the
restrict_bitmap check upwards to
in_group_p()?
Anyway, suppose you don't mean that.
In this case:
1. in_group_p() and in_egroup_p()
   should be changed:
-  int retval = 1;
+ int retval = -1;

But their callers should not.
There are also the callers of groups_search()
in kernel/auditsc.c and they should
be updated. But they are few.
Just to be clear, is this what you suggest?

> So acl_permission_check() can simply do
>
> 	if (mask & (mode ^ (mode >> 3))) {
> 		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> 		int xxx = vfsgid_in_group_p(vfsgid);
>
> 		if (xxx) {
> 			if (mask & ~(mode >> 3))
> 				return -EACCES;
> 			if (xxx > 0)
> 				return 0;
> 			/* If we hit restrict_bitmap, then check Others. */
> 		}
> 	}

Well, in my impl it should check
the bitmap right here, but you removed
that. Maybe you want the check elsewhere?


