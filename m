Return-Path: <linux-fsdevel+bounces-52055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5CADF38B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C30189F9D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD892EE98C;
	Wed, 18 Jun 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="W04iXp0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E12FEE14
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266861; cv=none; b=bPXSFxHGUg3WfCj7KPbCWVU81OC/1U9IiQ2ds4qQKJijeZ3WcboJaLLXFbKhvLVrniaCuKRrbgQORE9RitxTdSsrFFJ0D4yobmuqetm4m2gxa9+zKwYnrI0JvTBjDBLNoL3T2U42ggjrCiZWI+8Pwg4oSy/IZiGERO9iE6FGvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266861; c=relaxed/simple;
	bh=F/nvd8bkomziVpdG5KtRpTWlRx2HiZ4Bxg/35F0+VdM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=mj/3bk3FOi0skZY6RwephrKU4TLuplbeIdThdaUJPiJ66qa+0J7mYMsbr2rdcqzhJbnD3ESjpxepFhTnt4+uF+Nej4k7MklLIWTgHa1UipZ/d3AzCGfLJicLKsFn58MDVS8avnZNONe5xulzEqEBhBRuLHqR9cVKOtRN7Ip3K1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=W04iXp0d; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:fa8:0:640:af01:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id DE54461AAB;
	Wed, 18 Jun 2025 20:08:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M8RiUj0LmmI0-B7EkpBWX;
	Wed, 18 Jun 2025 20:08:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750266503; bh=yBJmq/zHs9vKdBwOTlKJdQTKoNBNJiBszdmWDMJmDxY=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=W04iXp0doeBZjLnt6JARttllWSPfIwL7ct0kM0zyCK0AlWk9tlgMVOafh+OcV6gka
	 CW5ivhY++1NrZiGlWL6wgDHqNpniPnaAV9VJ7gziXz8hqqvp9/63CcHA1zxZCFkEXT
	 I1DR3KJ0GP84iYSk319QmHPKgDf82GOJWZ52HG54=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d2bd4e09-40d8-4b53-abf7-c20b4f81e095@yandex.ru>
Date: Wed, 18 Jun 2025 20:08:22 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: Jan Kara <jack@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
 <bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: On possible data race in pollwake() / poll_schedule_timeout()
In-Reply-To: <bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/25 6:20 PM, Jan Kara wrote:

> So KCSAN is really trigger-happy about issues like this. There's no
> practical issue here because it is hard to imagine how the compiler could
> compile the above code using some intermediate values stored into
> 'triggered' or multiple fetches from 'triggered'. But for the cleanliness
> of code and silencing of KCSAN your changes make sense.

Thanks. Surely I've read Documentation/memory-barriers.txt more than
once, but, just for this particual case: is _ONCE() pair from the above
expected to work in the same way as:

diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..1a4096fd3a95 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -191,8 +191,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
          * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
          * and is paired with smp_store_mb() in poll_schedule_timeout.
          */
-       smp_wmb();
-       pwq->triggered = 1;
+       smp_store_release(&pwq->triggered, 1);

         /*
          * Perform the default wake up operation using a dummy
@@ -237,7 +236,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
         int rc = -EINTR;

         set_current_state(state);
-       if (!pwq->triggered)
+       if (!smp_load_acquire(&pwq->triggered))
                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
         __set_current_state(TASK_RUNNING);

@@ -252,7 +251,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
          * this problem doesn't exist for the first iteration as
          * add_wait_queue() has full barrier semantics.
          */
-       smp_store_mb(pwq->triggered, 0);
+       smp_store_release(&pwq->triggered, 0);

         return rc;
  }

Dmitry


