Return-Path: <linux-fsdevel+bounces-7669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCF828F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53054B22375
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9963DBB1;
	Tue,  9 Jan 2024 22:08:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0403DB98;
	Tue,  9 Jan 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d54b763d15so14407985ad.0;
        Tue, 09 Jan 2024 14:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838104; x=1705442904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li3Y7982rSqF0PYYpzguyahagJqPSE8wbuDH2ZsTdfg=;
        b=k5flbHsgRApJ3WP5dq5HhektLv4TtSmu0CU4+YM2UJHA2NBJzFFkmeVZZbT3MQe/H4
         Je234OGbZNxPyjXkrahVwAc0CZLik3D1FkljjoX/G7iDWBijUZEeEhph1gIaKcBvv1nq
         3zGwZFqnJrey1ZTg8v/EOTg8CtNG1S7oYYK5+KDUz+rb06ET2W6LEsJmNoLTPkFnTL0C
         v6Xy+3Ub5I/10Ve9caUl04OupEhGLizQCXbGZvyzThhPJ72tnukEHbwIg1eyb7swn1D3
         2ffWUlfPTReY0SjgI+SBbRaibBV0sLmUL/9/sriTgCofc8HA+s43cCB+BjDkSweB+R41
         x+mA==
X-Gm-Message-State: AOJu0YxrofsbeiygHqp9/d/8NrmOm1njQ5QI5yBZ0YKfy02ThkgSl5eX
	4qNcEm2nWfVCCrmdqdtYjqg=
X-Google-Smtp-Source: AGHT+IGcWxDZ2y2EsYJ8J084FeDEXeUlv8iQBOshvurkaqeU/GhU1KcrlCwGZBF1z9PZMM2dV7sWXw==
X-Received: by 2002:a17:902:fe18:b0:1d4:67f1:5daf with SMTP id g24-20020a170902fe1800b001d467f15dafmr33390plj.132.1704838104030;
        Tue, 09 Jan 2024 14:08:24 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001d45f92c436sm2286620pll.5.2024.01.09.14.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 14:08:23 -0800 (PST)
Message-ID: <ee9eb364-7aed-4a73-8e42-f66f084b0118@acm.org>
Date: Tue, 9 Jan 2024 14:08:20 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, "josef@toxicpanda.com"
 <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org >> linux-fsdevel"
 <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Daniel Wagner <dwagner@suse.de>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
 <0e33127d-6a43-46a1-9276-0c2f1965e345@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0e33127d-6a43-46a1-9276-0c2f1965e345@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 14:01, Chaitanya Kulkarni wrote:
> On 1/9/2024 1:31 PM, Bart Van Assche wrote:
>> On 1/8/24 22:30, Chaitanya Kulkarni wrote:
>>> 5. Potentially adding VM support in the blktests.
>>
>> What is "VM support"? I'm running blktests in a VM all the time since
>> this test suite was introduced.
>>
>> Bart.
> 
> An ability to start, stop, suspend, issue commands to vm, recent
> patchset async shutdown on linux-nvme list is one of the example why we
> may need this feature, see [1].
> 
> -ck
> 
> [1]
> 
> https://lists.infradead.org/pipermail/linux-nvme/2024-Januar/044135.html
If I try to open that link, the following appears: "Not Found - The requested
URL was not found on this server." Anyway, I think I know which patch series
you are referring to. There may be better ways to trigger shutdown calls than
by stopping a VM.

Thanks,

Bart.

