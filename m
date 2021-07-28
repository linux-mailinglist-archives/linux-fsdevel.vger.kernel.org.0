Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18933D923C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhG1Pis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhG1Pis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:38:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3AFC061757;
        Wed, 28 Jul 2021 08:38:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10666963pjq.2;
        Wed, 28 Jul 2021 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DHb1viiq/M1erLr2X07zcQ77mhbJoJfUhPFzGDRbbgk=;
        b=eCuSx67rfqyMOyriSQb1ffa/WuN7WKoJYkCifLb4icEiL3Na9lr1lgBva/EV3IsW1j
         SC9BTzDRtxiJrFSJabc9C2jIqi0Mtyl42GPLBULan6SY56jK364YbFbOJwS4pR5ae3Ts
         azWrICO+Ts7LoJwkmgYNcXI6IS6OqjD5CA9ohdhhq3ob/kql5wHVkXBi5alr5MqT4tg+
         NWm0++pZ/XJbL04cDL4YZR6SS/6TqRu82e98h8+C6Q9DdnxJNxiK73ypXVpVYAmrCnko
         GgOoPUP/0ncWvxHFncNrSuribzkOrjsWtplELgnujfG+9iWLyn1es1Q6WMNsem+f7lWO
         X0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DHb1viiq/M1erLr2X07zcQ77mhbJoJfUhPFzGDRbbgk=;
        b=UJ38o5uygs222FsvRi0w229j2dnnRhdQUb3o4CkCL5tyo/9prtS4qWIg87zV7D/ZRy
         rRfBrMLesNqxvjl8Jz74mGNLP3X3OJJJ6ATzx2HuuQsTZLtElpvsVQRv3F4NehKVFQ2Z
         T6MmAduVWcu0eR6c1ukfMXOhaOdqeMvSyiNaI64ewM3muDL9s8uXw4nVgCEWA820R2nL
         ZJ/VvmrASN63N3ivXX+C+AU3Kf5LDjSmYUMKadfFDKT5cgbJ93KVReCI837BbmON0WRE
         PXyz+lqGYQtUArdlAbkNmGcpVAqM3DdF6NchmG/p4y5EV3B9zOAhQMBqZJJZlkMyVRUH
         kmsw==
X-Gm-Message-State: AOAM5320GXcoj2YKr3R014bt/gtsUHv2wfROxTdgnOeeUcXo3+9DHbdf
        rK2b7Qcg7OvglzPYYw9iIxE=
X-Google-Smtp-Source: ABdhPJxAJ6n0FO1TcmsdoSCEaC1XspNv7XkZHHNHeyT9JJfKfQxQ+5RKqYotOFj+A5tEEgr7BH8fCQ==
X-Received: by 2002:a63:6f8c:: with SMTP id k134mr387286pgc.35.1627486724843;
        Wed, 28 Jul 2021 08:38:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3784])
        by smtp.gmail.com with ESMTPSA id f4sm82823pgi.68.2021.07.28.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 08:38:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 28 Jul 2021 05:38:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
Message-ID: <YQF5/8Zb/iY5DS7f@mtj.duckdns.org>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
 <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
 <YQA1D1GRiF9+px/s@mtj.duckdns.org>
 <ca2bdc60-f117-e917-85b1-8c9ec0c6942f@gmail.com>
 <YQEKNPrrOuyxTarN@mtj.duckdns.org>
 <ed8824d5-0557-7d38-97bd-18d6795faa55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8824d5-0557-7d38-97bd-18d6795faa55@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Jul 28, 2021 at 05:47:05PM +0800, brookxu wrote:
> But considering stability issues(k8s), There are still many production environments use
> cgroup v1 without kmem. If kmem is enabled, due to the relatively large granularity
> of kmem, this feature can also prevent the abnormal open behavior from making the entire
> container unavailable? but I currently do not have this scenario.

Now we are repeating the same points. This simply doesn't justify adding a
user-facing feature that we have to maintain for eternity.

Thanks.

-- 
tejun
