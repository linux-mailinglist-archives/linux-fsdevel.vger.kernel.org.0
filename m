Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225853D8B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhG1JrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhG1JrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:47:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8385C061757;
        Wed, 28 Jul 2021 02:47:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so2001288plf.4;
        Wed, 28 Jul 2021 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iPJfT32PGYt4NJ5C+bncE2oPEQUqDqGzmN3ZvuFQkGI=;
        b=SV1ILPTpHhcPVfAExOd1xUWdXjac03q3/bUhkyQX0fBdxe9DOlGsmMoBR41c+6BGS1
         Y0sIHvQZNNT2c8Zp/bCNbM/cakRjXXnx1hlcCRQ0sgtG60ew5BVyr0t+HdLCOg5F0q0u
         0BdYBhUh5aZ8EC8VgZv9MHym0Qr3Xuw3B6L/77nDLHMm4E0g09Lmvp60n6z+Xk2WXYd+
         PN+Ba6UTM+l6IIjaRK23rgFWjpBGZNDAThaEjTU0ZUhjESHHWrgL0h8QL/SBrvkHRac8
         k56RLfEk5+7t0OBQpM9yDL86L4/+8Cxt8jgkfTPPakD9A31e/UrdMnwMEOBz+csXj9HI
         5d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPJfT32PGYt4NJ5C+bncE2oPEQUqDqGzmN3ZvuFQkGI=;
        b=TGZZEpG3GqxjtjoyX7Q9HYVwz43KkHFRDunAY+9C+ND58OoVkekEmvZ10CVR6tCMcY
         POFEFK00STNQGNsf621VaktkSqToLhKx5TSZNyZ1IG79wZeSC+2P15Oj1riZ83hHtsmC
         spyVFDyzVhblwVaAmyxig+DNtlzOjI8i+GwFYvYyZib51/2jgFUhE1cBDFyMvf+crOAu
         9v6Sc0ZWIs+nNqiIOR47QorIAG6fC0g75O54oQUkOxXGm6MqK7E3ei9TWfZKE9jTmT1i
         eDyQocM5mvQBbDzFvzNKCv3/V3JZn8rHHbN+Tz8olJNdxsZL8qc0CI3Py+9ApnPuqELJ
         qUpQ==
X-Gm-Message-State: AOAM532VnWvrSmzYqhrg3a9hJcupGsT72gqJbtqmqoiDqGohiCgm2/V6
        yZOo+Ax9ij9eN19hHznQ8YEeCy0RA9n5jJRs
X-Google-Smtp-Source: ABdhPJx7eeQZY6RmA2SeF+LALVSppSIzUZOiaiW2Y6eoqtb6ufWzam9z2zRewtEHioSmFhdoQzmi8g==
X-Received: by 2002:aa7:9e1b:0:b029:384:1d00:738 with SMTP id y27-20020aa79e1b0000b02903841d000738mr23528820pfq.71.1627465633057;
        Wed, 28 Jul 2021 02:47:13 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.110])
        by smtp.gmail.com with ESMTPSA id r18sm7495964pgk.54.2021.07.28.02.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:47:12 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
 <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
 <YQA1D1GRiF9+px/s@mtj.duckdns.org>
 <ca2bdc60-f117-e917-85b1-8c9ec0c6942f@gmail.com>
 <YQEKNPrrOuyxTarN@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <ed8824d5-0557-7d38-97bd-18d6795faa55@gmail.com>
Date:   Wed, 28 Jul 2021 17:47:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQEKNPrrOuyxTarN@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Tejun Heo wrote on 2021/7/28 3:41 下午:
> On Wed, Jul 28, 2021 at 11:17:08AM +0800, brookxu wrote:
>> Yeah we can adjust file-max through sysctl, but in many cases we adjust it according
>> to the actual load of the machine, not for abnormal tasks. Another problem is that in
>> practical applications, kmem_limit will cause some minor problems. In many cases,
>> kmem_limit is disabled. Limit_in_bytes mainly counts user pages and pagecache, which
>> may cause files_cache to be out of control. In this case, if file-max is set to MAX,
>> we may have a risk in the abnormal scene, which prevents us from recovering from the
>> abnormal scene. Maybe I missed something.
> 
> Kmem control is always on in cgroup2 and has been in wide production use for
> years now. If there are problems with it, we need to fix them. That really
> doesn't justify adding another feature.

But considering stability issues(k8s), There are still many production environments use
cgroup v1 without kmem. If kmem is enabled, due to the relatively large granularity
of kmem, this feature can also prevent the abnormal open behavior from making the entire
container unavailable? but I currently do not have this scenario.

Thanks for your time.

> Thanks.
> 
