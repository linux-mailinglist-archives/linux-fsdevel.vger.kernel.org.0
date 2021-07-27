Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCC3D6C71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 05:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhG0Chi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 22:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhG0Chh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:37:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C553C061760;
        Mon, 26 Jul 2021 20:18:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e21so9669193pla.5;
        Mon, 26 Jul 2021 20:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BkpKJMj8n2tdrlAotNsD2n9oh289k/hxpaSEx0/2fUg=;
        b=gClIL7RqcSfXHukQYD9GBLkJ5ekF74p/wtUCDp6gVra+KFApFR/73C09AhdgVrIwrT
         D0/JYWqPoCVnbHlIyWzWbCfUa130s1dDr1A7IfJEhCpoRRFhUhlE9v9z9HKXgcMlMOQX
         4kjHirEqaVL9lk+vlRNvQpF8q8RExMDX4aPwfy0Y/GyoX5CvFVffxMKq3OoFwk6ODcwm
         /T28KX7ISkGoqJ31UyWZXYmTOdUMTJVztqa2yLVlxI/JFI7kLejlrdRcMhgLi3cBK1gv
         0i08p53OxpYSC6uZt9ycuqOG1UrZEWsZYUcB1Saf5BOLGH9wOKawTK2tIkg64YCE28AD
         PlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BkpKJMj8n2tdrlAotNsD2n9oh289k/hxpaSEx0/2fUg=;
        b=BIOU1PKkOp+Ht+x65/4X+oZ8mnx5H9L5OWJNqecnfzJXtylRPom14VpIhEIUBVbGrW
         Hun+k9qboROS+x7xOqV1md3rkv2+C9+dcLfa/U+GA4H5iCm2oP/ziQPWe0vpNVgcCm6o
         nnqJ4uLGiUci6tm+SSSgBXgnIKrvNLCPFPH1CvPrrbr0zQHVwZ6ettf4mSPWdx+Eo1Fd
         DKlfDZQgeEBPYBjQTv6PflFyVJ60nKYSJZ+Jz0nd6hF8vRlcSHbjn8jFb/vK7CT4BJZJ
         0afYK0Vv3a31v6HDAUptgdnhQ2gvU4AQdUPcz/vCn6IULTrxOp1n4d9R+q8gaIznl/I0
         9tTA==
X-Gm-Message-State: AOAM531CUIIIfBYR7zzgo1to+T7SqjuLAKrpoX0vyX5O2Q2GwogForgX
        H5QixJSckZ7sE+sQbQT7ys8RctCiPDcXTQ==
X-Google-Smtp-Source: ABdhPJwgcfRPYWQ5eC571yMwDz5qMcUDpqXvinWK75aYuwcM2CJD+cj5lfaBXoKQy3Us8ccPeT2NZA==
X-Received: by 2002:a17:90a:3b82:: with SMTP id e2mr2151317pjc.49.1627355883763;
        Mon, 26 Jul 2021 20:18:03 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id j128sm1562725pfd.38.2021.07.26.20.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 20:18:03 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
Date:   Tue, 27 Jul 2021 11:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YP8ovYqISzKC43mt@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks for your time.

Tejun Heo wrote on 2021/7/27 5:27:
> On Thu, Jul 22, 2021 at 11:20:17PM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> Since the global open files are limited, in order to avoid the
>> abnormal behavior of some containers from generating too many
>> files, causing other containers to be unavailable, we need to
>> limit the open files of some containers.
>>
>> v2: fix compile error while CONFIG_CGROUP_MISC not set.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> This is different from pid in that there's no actual limit on how many open
> files there can be in the system other than the total amount of available
> memory. I don't see why this would need a separate limit outside of memory
> control. A couple machines I looked at all have file-max at LONG_MAX by
> default too.

According to files_maxfiles_init(), we only allow about 10% of free memory to
create filps, and each filp occupies about 1K of cache. In this way, on a 16G
memory machine, the maximum usable filp is about 1,604,644. In general
scenarios, this may not be a big problem, but if the task is abnormal, it will
very likely become a bottleneck and affect other modules. 

> Thanks.
> 
