Return-Path: <linux-fsdevel+bounces-12297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9CB85E4BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF02E286306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26483CD0;
	Wed, 21 Feb 2024 17:39:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68683CC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537171; cv=none; b=Sw6foD+l6P0NHUgogwu5htGQNYkTmT9HhOcAIvXyo4+t+bgkXVoQOZOVkXZ6TMMoS/tqctNNVxKRmsSxe/TTiIt/JUpZXdiSkKnvy442r2gm89pqHQyQypaz1+uKjpyfL0d3piQ2JIQaaaACaGVDDdniAYX37mhKvhBhv0UMMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537171; c=relaxed/simple;
	bh=4+eqHRFC3ShkFh+TAUR9dcpf3nwV+K8bUeFgtw/9hLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBAD1a5nS58roARCQMUlU/cerW037nwYIuNthdTczdu2hh26PuMUnRkdcwT+TaTNYaDCx0rBDsQPLD4Qm6XsKrVLg8V7gFfBFho6KXFPi3m5d/RzoUfuKVZTLA+kGVRFpqvafpejaQ1lEWgdVKLXJdzB+E3NbIrCMMqEJPdbNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7881b1843so7033675ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 09:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537170; x=1709141970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzmxX7lsOU1upU/cnNF4xH7Am7ystT+ZLu0KeQfmgXo=;
        b=m/a81kc9mg4a5sEKuhdrGhK6pRLoqrMz0kHpS9O9zcFYYnkxhjWvBW8pCjAN6TbQCU
         cIWStKsrT6qz/mYehDbwGfPL0NoZ/KT1pVgrGaB7SkteKYS+0d1rxdjcxEUVnfqTxPUB
         lpWqy2sq66khSnwvWjnqtVdcXeXup8VsCxIPWZ5sYDRItx+ShD7WajSB1Wrildy4RkXx
         IYWmFGNLSHG1JAg0wqF4BVAZx5mZ4Y7vfDnESAw4zURHCQsr6mMO1wCbw5mBO++lZn+H
         hXGJ8LXVrJuMRUTEaaiAbSQ6qz37IXIZI5c5vt3MPnoL0DmjgTrmFvoitp7uQznqQ25V
         V5+A==
X-Gm-Message-State: AOJu0Yw/mhojCLgZ4q4vVouSGFWeL0co1USFdczqbdKG0bt8I26fXqKX
	0M0aHNvNbz7/CRdCdaQkVCfbRGyCOxg27e1jf7FSthAPTb/RDLeWs3lZT9sM
X-Google-Smtp-Source: AGHT+IG0vmba0wCPMjNPdleTYmeEHCWCHWajT8immqHD5ChFB3IqIprRfxjQzggtC2wZIrIuBqTNNg==
X-Received: by 2002:a17:902:d34b:b0:1db:ceb0:2022 with SMTP id l11-20020a170902d34b00b001dbceb02022mr11446148plk.27.1708537169455;
        Wed, 21 Feb 2024 09:39:29 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:d74f:a168:a26a:d7fe? ([2620:0:1000:8411:d74f:a168:a26a:d7fe])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001db28ae5d81sm8304575plh.159.2024.02.21.09.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:39:29 -0800 (PST)
Message-ID: <c1856035-6696-45dc-a0a9-dc0bb6955280@acm.org>
Date: Wed, 21 Feb 2024 09:39:27 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix libaio cancellation support
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 01:26, Christian Brauner wrote:
> On Thu, 15 Feb 2024 12:47:37 -0800, Bart Van Assche wrote:
>> This patch series fixes cancellation support in libaio as follows:
>>   - Restore the code for completing cancelled I/O.
>>   - Ignore requests to support cancellation for I/O not submitted by libaio.
> 
> And the libaio cancellation code itself is safe?

As far as I can see the libaio cancellation code is safe.

Thanks,

Bart.

