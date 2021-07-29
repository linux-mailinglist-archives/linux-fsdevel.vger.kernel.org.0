Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D783D9DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhG2Ghp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2Ghp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:37:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974CC061757;
        Wed, 28 Jul 2021 23:37:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so5761064plh.10;
        Wed, 28 Jul 2021 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mn2QXsC9iXN6n0TPueHgxmDAwTtq1MsZU9RTs4Fr/hY=;
        b=fULRnTdszNXc8PP2zScOdaash0b/Ue5x/8SbvvdEgbnSZ9++AHkKX1BMIbqqAWS543
         T5qpIoeSR5Xfhr2XKcxJjw5LMQzQ1fJGHO5R4iJDoT+cVvAHaLN3ET04tmF9tPqzL82a
         sI5/C2o/SnRDYWLmjn5TxWbCgRbIIOjq1Cw5CiR4PUvOxMno67YpRr7f24NBUE77mRUB
         hEgl0SHs7qK6u+8gvhEp9JCJjf1m45Ucz/Grr0B2ZEf+cLeq+MGWY+A8aMvflAYUxqn7
         eHItlxuEIVouEpLW3G+j/YUt+0JpI32zgc0jJ+r1WI/qfgrK23Ne+Arkh6wdmTQa6V+d
         HXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mn2QXsC9iXN6n0TPueHgxmDAwTtq1MsZU9RTs4Fr/hY=;
        b=fwyMH5fnQwQJdf7oGwNgaZa28+9Y3AsbI0wCxXQuQcmYPKGurgD1T0ASiQmfeefIMC
         U9dLv9iOqUow0Tg3dI8YEfcEZ8m15H1o64DCr1RRa03tQ1+rzhrPPpfHS9lZhNnUyE10
         ljhVkRFncGpivuW56xFLu4zw1aPZXHViLZ/CfYfD1Ac0hP0lnfvsSUxxmcGrxYZiEKQL
         cMuRaGE10jsBG08e77Btbf0qE4z/UeerFgCpEFCd7QwE4ZOlr+sJLZsRp+Lxqt11ldbl
         1Rb3GThG5E1QkBgcHQnbQXzB9iHvkIn/SQCzx4eYkrO8MtfaZqlp1XswZajM9RcjACvF
         tXtw==
X-Gm-Message-State: AOAM530bd+xcKdpLdt8zjFSkp+5WOSn24eONpfKkoGsoHTrDdNCIVxou
        s0ERE7YVplrEAADCjm5SDVis/p9xjYd0NTej
X-Google-Smtp-Source: ABdhPJzeNf7oxJEGq4s6m5Lmmed75zMgOvhAaBS/fsHPP2WD2ZRwBn/xnghBdV1wHXkZCeKsQX4U9Q==
X-Received: by 2002:a62:f252:0:b029:344:ea90:e913 with SMTP id y18-20020a62f2520000b0290344ea90e913mr3435106pfl.15.1627540661070;
        Wed, 28 Jul 2021 23:37:41 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id 33sm2414118pgs.59.2021.07.28.23.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 23:37:40 -0700 (PDT)
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
 <ed8824d5-0557-7d38-97bd-18d6795faa55@gmail.com>
 <YQF5/8Zb/iY5DS7f@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <1a5153d3-5cdc-58c5-858f-3c369d69e881@gmail.com>
Date:   Thu, 29 Jul 2021 14:37:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQF5/8Zb/iY5DS7f@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks for your time.

Tejun Heo wrote on 2021/7/28 11:38 下午:
> Hello,
> 
> On Wed, Jul 28, 2021 at 05:47:05PM +0800, brookxu wrote:
>> But considering stability issues(k8s), There are still many production environments use
>> cgroup v1 without kmem. If kmem is enabled, due to the relatively large granularity
>> of kmem, this feature can also prevent the abnormal open behavior from making the entire
>> container unavailable? but I currently do not have this scenario.
> 
> Now we are repeating the same points. This simply doesn't justify adding a
> user-facing feature that we have to maintain for eternity.

Ok, thanks you for your patient reply.

> Thanks.
> 
