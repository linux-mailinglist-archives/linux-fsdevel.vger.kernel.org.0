Return-Path: <linux-fsdevel+bounces-275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11767C895D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CE7282ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FD1C293;
	Fri, 13 Oct 2023 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AyAedIIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD1BDFF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:00:15 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926BCE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:00:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748ca56133so26594739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697212813; x=1697817613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAM2fFfPiP1Mnp6RwSY6WoqTNoSbS2pT2DLPBUGrp7w=;
        b=AyAedIIa75/1Yx0pnZ1uK/RCo2F2gDMAXUi5QLhZsJteEjUwCmmcd5sCX4mbmR7W0s
         xvRS72PglKm9idiNQ4reedAH5gV9GBD/JI4u36RJX33hy0ApqbG+J4HbhGnJTBEWTr46
         TvPShnd4QQydvNtBox6epeHKqaq40YMTlHp4RXE50dOQEcCUHFPEgaPf0+1xpsoV6der
         2NllcCKruBW2YIGMFsEfB4xILTCtd5pG5dnDcdpIO9Tt/jkxD0NRrKL2dqyW5FxGk8LW
         yR8WE5zXS4CbdfOiAYXC5w2lGx0xjnLaTCVBiSouiGf+ZErY1nibshnYJAOAgVNBW0oo
         IkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212813; x=1697817613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAM2fFfPiP1Mnp6RwSY6WoqTNoSbS2pT2DLPBUGrp7w=;
        b=i1ekdk4pZ0iiQwPDItSB9idt01KwfuHkP+rDmXnoLsw7LUbRvR0OPw2mwX4ApqEVmi
         BpgQpkmKaudVvwgHU0OxWSEUP/h+SnlNWkAApEYsVjKH87FdttCn0K3fv4Ie52IXqScZ
         Wc8xdf8c65XuvhZL7lLlmmwFvECEzf3W3Lc/Vy5RAyJHfrtEvkML95IxVMvMoR9lBsAs
         uEucYtUYv7hwrCOUpbGpm5jFzpXH8+0U8fpAWyeoJJB7bzsrISgSYZxxmqWeLzGyXGkS
         1lH+Gx5WRYIM+mdCtentu/lpsKxPJqKh4KoGK1pq0WiXIIzhjEwsG6cKLui6ty52iqg/
         kb/A==
X-Gm-Message-State: AOJu0YyijxP4V5BMTMlzpjqHTEgqJOQ63svwIUCzesKjzDRTXup2lnnX
	tR8KwCE1y3tSI1+HtcaYBK7sgA==
X-Google-Smtp-Source: AGHT+IFzjem69ePBCBqDP5L3fTUJ3gv63iLK3duQ9K4PYEd++2EOb3gD3dGfha97sNftPIO0xQJWSQ==
X-Received: by 2002:a05:6602:2a44:b0:792:9b50:3c3d with SMTP id k4-20020a0566022a4400b007929b503c3dmr33400985iov.1.1697212812650;
        Fri, 13 Oct 2023 09:00:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h15-20020a0566380f0f00b0042b5423f021sm4605218jas.54.2023.10.13.09.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:00:12 -0700 (PDT)
Message-ID: <55620008-1d90-4312-921e-cef348bc7b85@kernel.dk>
Date: Fri, 13 Oct 2023 10:00:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Dan Clash <daclash@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
 audit@vger.kernel.org, io-uring@vger.kernel.org
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
 <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 9:56 AM, Paul Moore wrote:
> * You didn't mention if you've marked this for stable or if you're
> going to send this up to Linus now or wait for the merge window.  At a
> minimum this should be marked for stable, and I believe it should also
> be sent up to Linus prior to the v6.6 release; I'm guessing that is
> what you're planning to do, but you didn't mention it here.

The patch already has a stable tag and the commit it fixes, can't
imagine anyone would strip those... But yes, as per my email, just
wanting to make sure this is going to 6.6 and not queued for 6.7.

-- 
Jens Axboe


