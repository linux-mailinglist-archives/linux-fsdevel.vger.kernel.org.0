Return-Path: <linux-fsdevel+bounces-7667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E00828EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 22:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0219B1F25C33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8E3DB94;
	Tue,  9 Jan 2024 21:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5953DB81;
	Tue,  9 Jan 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d51ba18e1bso27622415ad.0;
        Tue, 09 Jan 2024 13:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704835913; x=1705440713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2HSg/AmhYZcGkcbY0eGgy1Bb+DyP7rKRWI4KTFYTp8=;
        b=KIlrb/gppm4WFt5sD8lJ6PMMS3GqYh4iFk3CU5hXXDypbIjtyA3r6bfbDTpf2jc/YU
         ihYOiV/QAbg6+5t64tAHsapBaTK2ORNq24Bpr8BQyuvKMDmBm7Y7U/KZenmoKBHKJ44r
         BeGLB+SZHdFGTG/LuwqX/2jgcI81WrhaXw9e21BtpeWKCREaKIRxFE7/X7FFfDiv4cZd
         C6/gQ6kFyI4jiV495euKgtQhNLAne+GWm6V4E/5IlZJKraJf9KGF84nexml7Poj5cutu
         rnoMei4h86waThOLsxfMW4sOhp7YQLXQst3f151h5+GHbpBiDt/A9itL9R1hc8XG5PB8
         0Jsg==
X-Gm-Message-State: AOJu0YxwxfPcIeT5m9JAd9J2FCQDdZLncbccBXzW7KcUPATiB0hfAZVJ
	O3LftVGWqOAdvsECGYzrGnM=
X-Google-Smtp-Source: AGHT+IGgEoQ64du2K0/Q9WBgQuZMDtB5igrtdQVepbGX4TmcvhjuKUR8/XlFeDlu1Dyk5zxvLefSFw==
X-Received: by 2002:a17:902:d50e:b0:1d3:ee1f:ce54 with SMTP id b14-20020a170902d50e00b001d3ee1fce54mr24664plg.89.1704835912946;
        Tue, 09 Jan 2024 13:31:52 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d491db286fsm2245078pls.282.2024.01.09.13.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 13:31:52 -0800 (PST)
Message-ID: <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
Date: Tue, 9 Jan 2024 13:31:48 -0800
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
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org >> linux-fsdevel"
 <linux-fsdevel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "josef@toxicpanda.com"
 <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Daniel Wagner <dwagner@suse.de>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 22:30, Chaitanya Kulkarni wrote:
> 5. Potentially adding VM support in the blktests.

What is "VM support"? I'm running blktests in a VM all the time since
this test suite was introduced.

Bart.

