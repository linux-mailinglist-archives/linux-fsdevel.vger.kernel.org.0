Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5924406FF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhIJQum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIJQuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:50:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E0C061574;
        Fri, 10 Sep 2021 09:49:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w6so1522789pll.3;
        Fri, 10 Sep 2021 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ycLk39mqr2VW20gmuwiS1O96iwebvsbUDKPqz1r4HLs=;
        b=SwFAicqGFHYDPBgQbXLMJQ0UcmZY8lvUK61PawM7D0Nd1XWOmic8A7dtlSBGftYXPp
         xi3UTO+1z1xbIjIbsiLJ8Q/9xUUKAh0J4i3hAOX/qhS/9pi0c9P6bG7g8G0gM0uAkb6P
         K7S/4G77KHQ4gsQHrP+7672jpkYyigpoj8a+VGveTJ/c/oUqO6Gd3qDKWw+OVXuKg4IK
         4qcpP/7Ha7F4kKM6LtlzziDVjx5YW6ESH4ILyPv5J8P1YHi9ghGRcFADXvv22+gJsMX0
         P7S2+oxpmBjT4bpeQbiwz4FR8BkP7FZ5aViXGFWZfpnrMbegmWV4S2CLRrM0IKHIePu2
         9anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ycLk39mqr2VW20gmuwiS1O96iwebvsbUDKPqz1r4HLs=;
        b=z/QQBv/Djc1pBH3QleAZAYC2QUJm5p+c2mKqzm3reBffFBMSMdQN5062jITwIMtBSj
         z/IuNYgg1rDMP6DZyqJfYFFV0Q4fzOkGcKWihhQTlfhhJ5XNoqEaSobs6sOhcHKjUpSq
         M9b7eY6wS64DZpDHId4k/xlxkbP1JYhjrNpQPg+ej6GZ8j8y87t3so7OlH8dTIRzf4vj
         6VJAIOBjxBXUjzHZACDUORQ2NvgZVZkRrJ8Ag0BGBJ3ckZto2MlUOmTQLNqyKcg6DUdM
         loOGI92a2fqpgCh7L2sQywnPvnpIDd0qqlUNNmFrh4BQhKTq5X16XUpifN+6jbri2m2K
         83HQ==
X-Gm-Message-State: AOAM530KY1VfTUqvv40UBHY7FFier9EjVSERusCNTK2Bb1NDET78ekF7
        Q3Cmo0vg6X6aJeW6Hk5eIh8=
X-Google-Smtp-Source: ABdhPJx6HayHTsEYB+vEWqNfBLiFbx5o1vkHH89e13ig1jxEYIceWRXoq8Ca5ZyyZw58QBDwmVSJ6A==
X-Received: by 2002:a17:90b:4b51:: with SMTP id mi17mr616793pjb.120.1631292569014;
        Fri, 10 Sep 2021 09:49:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l185sm5569198pfd.62.2021.09.10.09.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:49:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Sep 2021 06:49:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <YTuMl+cC6FyA/Hsv@slm.duckdns.org>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTiugxO0cDge47x6@kroah.com>
 <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 10:11:53AM +0800, taoyi.ty wrote:
> The scenario is the function computing of the public
> cloud. Each instance of function computing will be
> allocated about 0.1 core cpu and 100M memory. On
> a high-end server, for example, 104 cores and 384G,
> it is normal to create hundreds of containers at the
> same time if burst of requests comes.

This type of use case isn't something cgroup is good at, at least not
currently. The problem is that trying to scale management operations like
creating and destroying cgroups has implications on how each controller is
implemented - we want the hot paths which get used while cgroups are running
actively to be as efficient and scalable as possible even if that requires a
lot of extra preparation and lazy cleanup operations. We don't really want
to push for cgroup creation / destruction efficiency at the cost of hot path
overhead.

This has implications for use cases like you describe. Even if the kernel
pre-prepare cgroups to low latency for cgroup creation, it means that the
system would be doing a *lot* of managerial extra work creating and
destroying cgroups constantly for not much actual work.

Usually, the right solution for this sort of situations is pooling cgroups
from the userspace which usually has a lot better insight into which cgroups
can be recycled and can also adjust the cgroup hierarchy to better fit the
use case (e.g. some rapid-cycling cgroups can benefit from higher-level
resource configurations).

So, it'd be great to make the managerial operations more efficient from
cgroup core side but there are inherent architectural reasons why
rapid-cycling use cases aren't and won't be prioritized.

Thanks.

-- 
tejun
