Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA93D68A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhGZUrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhGZUrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:47:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10243C061757;
        Mon, 26 Jul 2021 14:27:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so1990514pjd.0;
        Mon, 26 Jul 2021 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JSRAHigjjv7jacJe2YWp7PNC+/ka4N08e26oEa0Aa9k=;
        b=vO1nimpqJXQrBZ4leSkrJbZ3YGN9W/wrYuISF3NMXbsvyu5WBRTVBPLgzSDPtziFHY
         65H0a01M7/XYZIgfxU4uK5mASWykWuPkZIBEVwxcNMsv33oYcbdpH3X/UEtBtxUBhHJ7
         KCiab6cMLIKyWwQv0u2adMUb3CABoGTf+7ucPvDa/5XAuRNrmBYhU9+Mu8oLct4KPSz5
         RyprRMzzHcB3avW1LFbxYoOEZPohajO1dR+/6UyfW4blYyGEKH41gU0Mcnuuv9TrlVDr
         yBkxT/UlBlptW8ZUfLXkjm5GpEWbBRfR3OCKYfmlOZHD7KBhURnkzjlm1hGSlBALOSK2
         mMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JSRAHigjjv7jacJe2YWp7PNC+/ka4N08e26oEa0Aa9k=;
        b=n8BiHfj2IamvjznMJq2Yzq4bq2FAaz/Fd2CU1XP6BFruAlB/YJC9z9TRHKWhRruY8r
         rWzLioZUPiMo+3QY+Xpj5GwcQ/VbHujc2Zx4CWHs9OzDB5XNFQpgxz4j4BGU3OR9ScSx
         zJlZKoYjcd0GRher02bvTagbjGY1oZmxdgD0bwSYl4DVf1bnTfgJF7WiiA3B9IXZPA+Q
         2y9E5/Up1+nEYFrdn3mf6rkZ2OsMQRE7eIxcyWxpUisdCkBlICGhoQgnU6YtotWOwbL9
         QHT9VvS8w8Z1hx/AlA/qDjV1VLkbH8ILpUreWsAwtFQ15W2ZwBO+BBCdgrBM0mrchj8P
         MlCg==
X-Gm-Message-State: AOAM530wOFkSnAir6ucFzqPfoJKW83bLE+U2mmDWhK1P/jAIr+yilEj2
        R0QA7RIpn3fa27ludEq8luk=
X-Google-Smtp-Source: ABdhPJyYVRL0saVwooPRPxJ4K4uUBUPzrtudK8F0glLyyc10Uyz1vq14/BR8QtWIaixVxbLjh3dYBw==
X-Received: by 2002:aa7:8148:0:b029:31b:10b4:f391 with SMTP id d8-20020aa781480000b029031b10b4f391mr19570569pfn.69.1627334850444;
        Mon, 26 Jul 2021 14:27:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id a8sm776556pgd.50.2021.07.26.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:27:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 11:27:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
Message-ID: <YP8ovYqISzKC43mt@mtj.duckdns.org>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:20:17PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Since the global open files are limited, in order to avoid the
> abnormal behavior of some containers from generating too many
> files, causing other containers to be unavailable, we need to
> limit the open files of some containers.
> 
> v2: fix compile error while CONFIG_CGROUP_MISC not set.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reported-by: kernel test robot <lkp@intel.com>

This is different from pid in that there's no actual limit on how many open
files there can be in the system other than the total amount of available
memory. I don't see why this would need a separate limit outside of memory
control. A couple machines I looked at all have file-max at LONG_MAX by
default too.

Thanks.

-- 
tejun
