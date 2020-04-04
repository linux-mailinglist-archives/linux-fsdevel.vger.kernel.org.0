Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1819E464
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgDDKGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 06:06:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40833 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgDDKGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 06:06:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so9485137ljj.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2020 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f5WeYVcExZ58viobGo5xENBYY/7iA5WtiHNaBP74Ohk=;
        b=aTi0ATN9MaY24407laRnBef6LfGPpOgdRBwSwCQz2c3RW4Gj/WkUSmsjFupt1+Si1I
         /jw0cOt3bzoZ1L8XI8Cd7xl4uND//yB9GJHWzUv8WZWdrs2vMEb5P/6AngfEuXPZiSGf
         XPfLEX+uHTRcYFmBj3aEbcKNRHtdDgUwBBnViuTIu3RWq8uVF0MXaSq7dRYUFOEfUxag
         Me75vpJfK3iUGksokG2xHslbFjKJVBBYOFEjoY7PYPAXlsjqaldQ3YKyfSNa7FMzpHkn
         t+K46duTvK6NW20LFcqGjElqmIe9KQb5vJm4zg6VH9x14j7uPUY0uawotq+psxvUvGUB
         UXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5WeYVcExZ58viobGo5xENBYY/7iA5WtiHNaBP74Ohk=;
        b=BYy4/JI/EQ35k2CAk/7ahY6voT4kfAQn/CoqYGpS/uYGc6O93aNzlLMBZmfAwsTw0a
         u25a9g68gbMNgML8BNuW78KrafTglZla+nP2OxQN0BOnu9kqfHNQw9LzcNT/kZ4jRXQz
         Mo/8SzHk0SaPaScKtldF2za1PqZPd+Ptby3qoCi52myVkpgQKdNEsZNst4TSX2eEw2qL
         xyQtHjwp0QingUFPR9VTpeSBOpNejSykQmWx9Mwy2bQaKI7eTzVHz4UQ47TYWBeump3k
         X2tI1zCZwMrItGMF5EJy62yONRZgTI3RBzK+YDLUEVO+o6qPy/UMrsZAoP2xq8itWKy+
         Iwrw==
X-Gm-Message-State: AGi0PuYd0DENjNL3A1ctJw+janPSRHE4YOM3KpqDq8hcOIxPZ/T6lfje
        Vxc6fRoT8SIT7kJsqs4Bh4DkIg==
X-Google-Smtp-Source: APiQypJgK3TXAPv85OfJ7vCTcz4u4tUzYYbvpr+INBxhiypWT+murLDDhRYYaeJT38bk35encw/Ldg==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr7232769ljg.225.1585994757852;
        Sat, 04 Apr 2020 03:05:57 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:6f0:5f98:6c2c:3527:3946:ae? ([2a00:1fa0:6f0:5f98:6c2c:3527:3946:ae])
        by smtp.gmail.com with ESMTPSA id p21sm6378055ljg.5.2020.04.04.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 03:05:57 -0700 (PDT)
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread is a
 kthread
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0fb3cce8-fa3d-5c97-1eba-0f359797eea2@cogentembedded.com>
Date:   Sat, 4 Apr 2020 13:05:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404094101.672954-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 04.04.2020 12:40, Christoph Hellwig wrote:

> Use the proper API instead.
> 
> Fixes: f440c8a572d7 ("drm/i915/gvt/kvmgt: read/write GPA via KVM API")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index 074c4efb58eb..5848400620b4 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -2037,7 +2037,7 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
>   	struct kvmgt_guest_info *info;
>   	struct kvm *kvm;
>   	int idx, ret;
> -	bool kthread = current->mm == NULL;
> +	bool kthread = (current->flags & PF_KTHREAD);

    Don't need the parens.

[...]

MBR, Sergei
