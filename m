Return-Path: <linux-fsdevel+bounces-38396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51AA016E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D76F3A12F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3E1D5CFA;
	Sat,  4 Jan 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="nN2czW4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BA148314
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024276; cv=none; b=le1eFTiXfFkiAsmdIYqgo9jdedJwEk4rRqLcPpuIuGSynagA1LtTAN8FTkK7wxes4Gy4NshR0twFnRkOO63jR1gbocv4G0suJRIAVDhx5uFmLl4fQNtOe/sNRZV4Gnh7wZbr1bWeFJFoL+GYaw6FJF1qoYVJl1LONdnN11ap8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024276; c=relaxed/simple;
	bh=8+2MOObpnyhskJLTLzSmy1tnyb8a+DUQmsvoGvW5pCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReTlbvYKuFmORBxcmVk+2UqoG+KdMhotsRh9RlVeV+9tEfnlZppgx4iymidlZkKPze/9kNLUALxeuMEwesCow9rFjTb2bgdPRQyNVHzJ2vU9aLW+LJsK7VML08PKxGKTCuIHwSo4XU4ttlZ8w/att2ywqP8fZmv5Ju/InpoOQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=nN2czW4V; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436202dd730so94726175e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jan 2025 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1736024271; x=1736629071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMFnLOGj0Yy/n0rpIiYliyI3Qfa537Ey1LG6cUw1oGA=;
        b=nN2czW4VgWvHnyKzFrfzJTwCYY2sh5jOhgim3zFIkWFX+89lHPRUHJCdDyXzfH6teZ
         RXwwwdwK26qj/bsvcQrkRhQxNHW+KAuyEfHmjOiCKHefKE4rpa+zSQ08cxf50b6DPLHM
         /8Uc/5RkNjHVjM6zXF+CnD3/czE/kRsfaVBGhAn86JuwM2GHoS5tXnS8RR9qQqIJPfJN
         iiDMIGgFXvfoYRSIVrOcfj7VG6k7eQ9Wdkckzd2jzLPmwWT1TTE0AVX8tcWgYgY0AqpM
         iCAjYK7U4TPxn+1Gn+JHvIkDnhBxyoTdvYg++MnPx62f+Ijbi0PJGeLze/boLpMC5Jxb
         QAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024271; x=1736629071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMFnLOGj0Yy/n0rpIiYliyI3Qfa537Ey1LG6cUw1oGA=;
        b=w/pLd8BBiOdpipgz1wrQGcFnb/bezK2Rin/SogwSY+jbeT8EJtStQBsrtU/ofaFIWo
         1/ximLeUWVZRMrCK7b6IrHB5MBx145KEyfx0zt0kJa8MIWy+YvcFYIfjGkTl4lOOrW36
         axONYyO8rBxEMLL3Xj1cTkFHrixBLM0ogLMqdCJklV5gT7UXZKc7D45XvTQCcqGk9Pg+
         eWCI9uoX35HCKGhWcXBJY4lyXXrAhkGIwmQGdGrbksJXDTDDgocNpKCKFgem90kHFPmE
         zLV3mbQV3ujRbkS6uZSB0fVF9qGHpg6hYPk4JBaqPp3o89F8QHUfuSVSy3ekcrh6bRrj
         fl+w==
X-Forwarded-Encrypted: i=1; AJvYcCWycnmF2m6O9CNmkviROTm1sijU0/b0Tic4KnT3G8ZQpC42e7FXuPQdM5t4xcWEG3R+bzT/c5g5wDh/Exje@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1Ghc24pdsvVBGdAp1KbAb212o51hm/8f2PiArYyRJGcdoAGI
	7gPaPVhJhUNln0e+GUd2kBMd8MDmg68avFqg/edrwQCphM4w+7UOFPvCdJE/Zg==
X-Gm-Gg: ASbGncsg+B9jxWQFqAxJxobhQKVNOWIbfLb0/TETJPanOXwzc+3iI/a+oDSwahveML5
	3Nt62jX1A0g+43J1i/QPS5wxaLUsEIfVuQWCHvWVCHlvogUWQIA5scdUvLYqFhl3+AWi8yaXDGv
	CpgBC+FyPdTUUna9qeKPSQR5QoajizqFR2WEqfz4W5TZO+RQ6qo/mPZeT+GDmfRq8Ob9g0g+AFr
	N4VNkkN4KvDIj0BwO1KdHvbw+oxmMZ0o/jcYUwmwvxt3jV93bWCWuZpGRWQTdjqsck3Bf06+YAB
	wQ5h90Wq5AhbWs6HdO/Qr5giFzQNY4idasUjTCcCeSKUBc47vjPtly6Lmae25bBMhPAyGO+aro6
	WFmpwYLIuR8AsGSCXMCY=
X-Google-Smtp-Source: AGHT+IHyQ0RNqwgXAMIn7XcyUmrF6oOmjTYvdVd99vYwfrrme9QxJmTgL2CxA0bJ8RyMSHrhe/qigw==
X-Received: by 2002:a05:600c:1c21:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-43668b5dfcbmr394305915e9.20.1736024271510;
        Sat, 04 Jan 2025 12:57:51 -0800 (PST)
Received: from ?IPV6:2003:d9:973d:8800:5833:f470:8c0f:e0a2? (p200300d9973d88005833f4708c0fe0a2.dip0.t-ipconnect.de. [2003:d9:973d:8800:5833:f470:8c0f:e0a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b417afsm561135255e9.36.2025.01.04.12.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 12:57:50 -0800 (PST)
Message-ID: <42f82db0-f252-4973-9f27-664286c84392@colorfullife.com>
Date: Sat, 4 Jan 2025 21:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
To: Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20250102163320.GA17691@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleg,

On 1/2/25 5:33 PM, Oleg Nesterov wrote:
> I was going to send a one-liner patch which adds mb() into pipe_poll()
> but then I decided to make even more spam and ask some questions first.
>
> 	static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
> 	{
> 		smp_mb();
> 		if (waitqueue_active(&pipe->rd_wait))
> 			wake_up_interruptible(&pipe->rd_wait);
> 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> 	}
>
> I think that wq_has_sleeper() + wake_up_interruptible_poll(POLLIN) make more
> sense but this is minor.
>
> Either way the waitqueue_active() check is only correct if the waiter has a
> barrier between __add_wait_queue() and "check the condition". wait_event()
> is fine, but pipe_poll() does:
>
> 	// poll_wait()
> 	__pollwait() -> add_wait_queue(pipe->rd_wait) -> list_add()
>
> 	READ_ONCE(pipe->head);
> 	READ_ONCE(pipe->tail);
>
> In theory these LOAD's can leak into the critical section in add_wait_queue()
> and they can happen before list_add(entry, rd_wait.head).
>
> So I think we need the trivial
>
> 	--- a/fs/pipe.c
> 	+++ b/fs/pipe.c
> 	@@ -680,6 +680,7 @@ pipe_poll(struct file *filp, poll_table *wait)
> 		 * if something changes and you got it wrong, the poll
> 		 * table entry will wake you up and fix it.
> 		 */
> 	+	smp_mb();
> 		head = READ_ONCE(pipe->head);
> 		tail = READ_ONCE(pipe->tail);
>
> and after that pipe_read/pipe_write can use the wq_has_sleeper() check too
> (this is what the patch from WangYuli did).

Would it be possible to create a perf probe to get some statistics?

I see at least 4 options:

- do nothing

- add the smp_mb() into pipe_poll, and convert pipe to wq_has_sleepers()

- add the smp_mb() into poll_wait(), convert pipe and potentially 
further poll users to wq_has_sleepers()

- add the smp_mb() into __add_wait_queue(), and merge wq_has_sleepers() 
into wake_up().

The tricky part is probably to differentiate wake_up on empty wait 
queues vs. wake_up on wait queues with entries.

--

     Manfred



