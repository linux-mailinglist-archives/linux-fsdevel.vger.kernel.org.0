Return-Path: <linux-fsdevel+bounces-13495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5773870827
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B83B294E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61A60266;
	Mon,  4 Mar 2024 17:15:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBC5F578;
	Mon,  4 Mar 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572551; cv=none; b=bKWBzp+kWEIzsOCM5yerSH6WPk+KesNZEhUVIwBHjI7OnHEQzQH5Cd3VJlfEuQWhf9NTPqe1GVvbWCfoM0xv8fwWZjqu9EK74tqj0VQxhVWmrf2OAMJyhFgRQxhZFXdVusKT/spN63DpFjyLSoE9bRm0Ux0Qz+DXta1fT0Wl9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572551; c=relaxed/simple;
	bh=aaeQmI5Mk+0ZmGmeBSGFa1SC7WxNexA6264mgTD3F3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncjUeLaG4iLsKOzSEoAS7TAbUlIO/AwK9NzNnBo+Whnfh+10T+5NiXV7fFSemxQqV4A82zuzNBObbMNqueZlfZzuzMiaO9nCouCiWYS9eA66LhGvMV2IOZgoNR51BPVBGJyb8iZUZQC2vH6ApIiHNZUM+TX8CEg6T480c+hDYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so4094741a12.1;
        Mon, 04 Mar 2024 09:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572550; x=1710177350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ehg7NkMQ4Vbl6iQ1xzEEvZzo8U7HNP2WGNugPbEFZ0=;
        b=EWUw9MCkX8dtqtRulVvG4uJKDeQriGy1AmK5p12hAD7CCrzw31fxPmR/0x8QKz6ygm
         vh6PbeQkf8MaxsrhbNabw6FSR34NWYF0krChzoMlCQ6mQIIH8pj0EMcUXGO3eSIXeOju
         J31ACY8/YW8u+eF1dG0uJiXffhc0ya4VjQJU3z9ii91L6sBDtkhd4ZVVJVyf0ddrSADV
         d81BqBKZX2jSS14sxHSFVons9OMNI8Xq55tGp6UwfCrTiNcyM0X2v4ShlKzVlZa75cAH
         5G5853Pk6FKYBuIs3fi5AjWJnUcPzaUfSttXGxyMOWulWX+Bc2nXNDuyLEBRP2SxyJA+
         bMZA==
X-Forwarded-Encrypted: i=1; AJvYcCW3uDdbvd4HY7EnffeHFBt4MHLCWCPAG43XLa1FzvoEi5jtrR5YXGxCJwWPTNnyb7fWyzUBYuVPbFwe7QN1DHhraKWYncBgQ7+U9uLlZhQvibLpar4mbH+sefNrhAe+mtPjrRwHdtSOAlrJvw==
X-Gm-Message-State: AOJu0YwpVlL77764izUf8lnthfmVcIaxCqn8Gz1w5wLAKoN3KZ+4nkcs
	bA3q4e98/YiGVm1I81fOvz9av06TlN7Zu5wy2hrP0lXx6oR6qod8
X-Google-Smtp-Source: AGHT+IEBQkEzy9z9g5TaBJMKd7F8WgCrN4ydJgAvTFHCWQpxQIx8AlKs4FHtvlHZYvpLFOYLn8/j+Q==
X-Received: by 2002:a17:902:be13:b0:1dc:b306:20f1 with SMTP id r19-20020a170902be1300b001dcb30620f1mr8139857pls.64.1709572549925;
        Mon, 04 Mar 2024 09:15:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1e3f:accb:b518:9d5d? ([2620:0:1000:8411:1e3f:accb:b518:9d5d])
        by smtp.gmail.com with ESMTPSA id ba12-20020a170902720c00b001d9c1d8a401sm8733612plb.191.2024.03.04.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:15:49 -0800 (PST)
Message-ID: <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org>
Date: Mon, 4 Mar 2024 09:15:47 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Content-Language: en-US
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com, brauner@kernel.org,
 jack@suse.cz, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
References: <0000000000006945730612bc9173@google.com>
 <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com>
 <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org>
 <20240304170343.GO20455@kvack.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304170343.GO20455@kvack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 09:03, Benjamin LaHaise wrote:
> This is just so wrong there aren't even words to describe it.  I
> recommending reverting all of Bart's patches since they were not reviewed
> by anyone with a sufficient level of familiarity with fs/aio.c to get it
> right.

Where were you while my patches were posted for review on the fsdevel
mailing list and before these were sent to Linus?

A revert request should include a detailed explanation of why the revert
should happen. Just claiming that something is wrong is not sufficient
to motivate a revert.

Bart.

