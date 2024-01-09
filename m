Return-Path: <linux-fsdevel+bounces-7635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F522828B54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3F1283B17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D03B782;
	Tue,  9 Jan 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OQZpe6Cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04B39AEA
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bee9f626caso6485339f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704821585; x=1705426385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gl0hz8eDpL8opmyW9F4Kd688dZLpv+GlT+GEV9WPEWE=;
        b=OQZpe6ClMOPW+0jpQk81HwSq3+imko2s6Mmra+FyBdKHYZ/lm2OHCX+Q0m4ki70gk2
         +zF39PygaxqafNR5iTLPC1uIYiN6n8At/gar1FOL3XhzWMu7PxvD5YVJ48EyMEcW65xq
         rIyjylNdR7c5hoqGZnnJ6JJg0wEnLdK0FBDfxnx3N+4p2LhWhTNWLNUoD9EKl4j7ATS+
         Wr1iIer220TsnUjU2fIkusSgKmezv3Yh7nhcA/W6VZyRUg/k48GVG1RLZeHVRjDKYtRe
         hiJvxTiA3Hul+QzNNgpoBM5rLa+BD4bQ65b2fB/DuSzbZ++GYIxDmJM36Skw/7vKhMz5
         t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821585; x=1705426385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl0hz8eDpL8opmyW9F4Kd688dZLpv+GlT+GEV9WPEWE=;
        b=m//+354gNsxtcVUWfUgL4VCK518bLQAI665c8vguctzlwfiX5ZEGLX/lOVU++FxRrb
         xhruy2nmM9/QnIAcyYWZx5+QS+Hb/KzQMf7Nhojnoc/toM1FCVvnxOERAFnwyA0myUCP
         7WBzTSD750ISLu1mXOggJ0G5/t7ym6KConEeo7NjM1k+rlvSLKkV2a3cNocc3shW6h24
         26W/U39zksP3Ro82JVDsP2SneZtWDSMFBwgkqtXnbksRPIgxTV8mcvwU4w/S9xivdnFq
         MSsbuMeyK/IzX6mNghP7KanhMKY3Bc0GMI+9GZIMN8q9+bEVFhLAsEnKz1cb7/UYtWKo
         FkEA==
X-Gm-Message-State: AOJu0Yxjc7+2lxfAi3l+SVb7FFp6/as/QNYbCCBvBjOmZEmQ4SyLit3/
	05efLD8gAhGYMDAYZqe6qC8VRt2Q1b9GPqwJ4iUOK0BbQun6ww==
X-Google-Smtp-Source: AGHT+IEuBTpThMPiYISQsgQuPrt5TH1yaBPjeVvtYu+QWPingc2/Go9aQrDXVQDobvlKGxusDcsVvA==
X-Received: by 2002:a6b:d317:0:b0:7bc:2603:575f with SMTP id s23-20020a6bd317000000b007bc2603575fmr10050727iob.0.1704821585465;
        Tue, 09 Jan 2024 09:33:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cp26-20020a056638481a00b0046df4943a5csm763777jab.148.2024.01.09.09.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:33:04 -0800 (PST)
Message-ID: <f8227e1b-7d70-4868-bd89-c6029325d2ee@kernel.dk>
Date: Tue, 9 Jan 2024 10:33:03 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "fsnotify: optionally pass access range in file
 permission hooks"
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk>
 <20240109-gitarre-zettel-5c9b772561cf@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240109-gitarre-zettel-5c9b772561cf@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 10:30 AM, Christian Brauner wrote:
> On Tue, Jan 09, 2024 at 09:08:40AM -0700, Jens Axboe wrote:
>> This reverts commit d9e5d31084b024734e64307521414ef0ae1d5333.
>>
>> This commit added an extra fsnotify call from rw_verify_area(), which
>> can be a very hot path. In my testing, this adds roughly 5-6% extra
>> overhead per IO, which is quite a lot. As a result, throughput of
>> said test also drops by 5-6%, as it is CPU bound. Looking at perf,
>> it's apparent why:
>>
>>      3.36%             [kernel.vmlinux]  [k] fsnotify
>>      2.32%             [kernel.vmlinux]  [k] __fsnotify_paren
>>
>> which directly correlates with performance lost.
>>
>> As the rationale for this patch isn't very strong, revert this commit
>> for now and reclaim the performance.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
> 
> Thanks for tracking this down! I think Amir, you, and I came to the
> conclusion that we can fix this in without having to revert. Amir is
> sending out a new patch later tonight. I'll get that fixed by the end of
> the week.

Yep, either revert or that patch fixes things for me.

-- 
Jens Axboe


