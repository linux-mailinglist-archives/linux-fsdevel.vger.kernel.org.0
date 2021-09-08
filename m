Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90BC403DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbhIHQgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 12:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbhIHQgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:36:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80493C061575;
        Wed,  8 Sep 2021 09:35:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pi15-20020a17090b1e4f00b00197449fc059so1591888pjb.0;
        Wed, 08 Sep 2021 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OcymaPtn2yQq8RdWF6BFH20bMyFtxjOxZMFIB1OMhb4=;
        b=cEO/E0Ry4JDv4NAoZWlVwP4k205lyAd9w0Jc/1E0rCsSXw3qxpjooAnEo5b0LiZ/xh
         1cmfhhXIkymzyYy74CxqfFRkcGkxEeqgtwbcmUmMOkNEgfNyZNECXRyYhdC3TWU3C1wr
         RYo72dsDHQjeUlpJ7ZxqIgnRC0i4WwnJja8UvQ7EAgxQKkXrN4eymCpiHcJPG6g0QGA8
         1fdL5abIwfzLj6FxUwYFP5fiwW7rZUSkCJFGZOaOTXRaWkmRkbrJ+7uEWs7JEQ0dy4ji
         /jGHumraXj/+ujT5+g4BougNm+Fbf7wvpHnEOR+SoWoel7IC/QoSVu1xTlgMd7VHAL2l
         7/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OcymaPtn2yQq8RdWF6BFH20bMyFtxjOxZMFIB1OMhb4=;
        b=lEId6/rcLwTgnpWKqEg+WWPDN/ctdwXKdvLofL2WZSubx8jnak5nxV5DU2yO5RQnKO
         qpmUPT0WLxVQ1EWXbzgn2zuRvtnRQnhOqpyoc7jDreihuHmUeOsQiixAONZC4tCsdXIA
         5r27ePBJ3T1hWxetihS6Oka+FZUHv71rSEqmBJcWJ1ARES2Ee4XleezTfM1tNbfQXUuR
         Qj/ERb1x8FZfGHcqRILWq5LTCuFW9wdAIKgqEv7E5y07nsAK6ZpYQLOorYVUMQrurzgR
         if9QbwVYq2j06DYISF78fr43v7UsnNXUHaky7nBjVT6Ed+GFj60gmQATp4uHZjdmnySm
         WJdw==
X-Gm-Message-State: AOAM533xLShQSj71FDIqSQzXtRM6pUGdr6z3maxkAtxzAdzQBVtLXfT2
        AXGdgmAC5iel5pqDrgGCNohMVqvWAWg=
X-Google-Smtp-Source: ABdhPJwFoJ0ZNwF7ymnYu6dtcblvKpIG0O6/JViZFf+murQhyKST6yt150dDOceRGyev6kDMMDs6UQ==
X-Received: by 2002:a17:90a:e009:: with SMTP id u9mr5000361pjy.218.1631118912916;
        Wed, 08 Sep 2021 09:35:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q20sm3798099pgu.31.2021.09.08.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:35:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Sep 2021 06:35:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yi Tao <escape@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <YTjmP0EGEWGYhroM@slm.duckdns.org>
References: <cover.1631102579.git.escape@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Sep 08, 2021 at 08:15:11PM +0800, Yi Tao wrote:
> In order to solve this long-tail delay problem, we designed a cgroup
> pool. The cgroup pool will create a certain number of cgroups in advance.
> When a user creates a cgroup through the mkdir system call, a clean cgroup
> can be quickly obtained from the pool. Cgroup pool draws on the idea of
> cgroup rename. By creating pool and rename in advance, it reduces the
> critical area of cgroup creation, and uses a spinlock different from
> cgroup_mutex, which reduces scheduling overhead on the one hand, and eases
> competition with attaching processes on the other hand.

I'm not sure this is the right way to go about it. There are more
conventional ways to improve scalability - making locking more granular and
hunting down specific operations which take long time. I don't think cgroup
management operations need the level of scalability which requires front
caching.

Thanks.

-- 
tejun
