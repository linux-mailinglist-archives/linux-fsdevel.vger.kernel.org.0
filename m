Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445DE4070D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhIJSNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhIJSNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:13:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4802AC061574;
        Fri, 10 Sep 2021 11:12:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r3so4575808ljc.4;
        Fri, 10 Sep 2021 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yAS2V26MFTPXdp5D+1VvRXcpwyS1dkM+dGnCynSdaik=;
        b=QZCMZ92pfp0Aw7elF0GYvXcwRYYzg/cDsaEmEba4f+WIMOVwz64HZqjB1pjqWaqukb
         BIwSvfvT4DWFNxpLG6dqJIBwAdLbGHF5xXrKnAarI5o91JevyqVgKYgwE2SaxNHrunCS
         41lNXtxFKbJ3d1/82AzOiHGuEiHzg7/4kipXZOrwcZ87+wKE/3L7czuJk+oxX/0d73E+
         uJKdkUoRTBaP30HwMX4u4SGP4p5MrIDNZdNwZ7xq99qXL5FvCE6QdiJ0WfJSNj1ERa8l
         hbcqa6ILYPJB1hgBsrFvgArXvSZEZ1WXL7ylaUIYasJ2G85yWH7wzbrFjioLsLpt0W0Y
         mfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yAS2V26MFTPXdp5D+1VvRXcpwyS1dkM+dGnCynSdaik=;
        b=zHOU7J7QnQEUUdfXZQY4UZd5wL7GNgcw1juctFIYyh6rvDzY2uK8yqMO/rTsgpdYQX
         JtPFno51tuf8VQ+wm+nys/cKmNpSRX+oImUur0vO8o4Ee+j4De3vxmt6MAPZ7rju0SO1
         69xklyRzactUovh6h7mOPUjxUs+bUW7ky4QH0NVq0fOnZryvHlgBr20mZ3DzNHNqUdtv
         +brsSLLeeQoO0mY+wcunaqR2VeSqaB9Cp3NUOCbgTeybGpTVnM44oekzQK/lHr5CrXYT
         YQPxLN0F3SgEWHCAA2lWg70Hn7ZLYIO2UVfFNIIrvY8XYnhpGatLswEpG3BS3nyI15Mp
         Uwhw==
X-Gm-Message-State: AOAM533JIDq4Gb5gKcW6CrvW2t5SNislwP31UI4m+t0tSYNYjGKyielq
        2yajt/G7aS9YPQTWi1NsE/EQ41ri65H1OA==
X-Google-Smtp-Source: ABdhPJyv+ihp3UJkL+McKA/31v+I+WB/lbUcXTkXIuSsRWwmYlY+S/nkN2pZwedAzLWpLNtlfn1zyg==
X-Received: by 2002:a2e:bb93:: with SMTP id y19mr5072294lje.79.1631297549627;
        Fri, 10 Sep 2021 11:12:29 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id o16sm623643lfu.45.2021.09.10.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:12:28 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:12:27 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: fs/ntfs3: Runtree implementation with rbtree or others
Message-ID: <20210910181227.4tr3xn2aooeo2lvw@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

Konstantin you have wrote in ntfs_fs.h in struct runs_tree:

/* TODO: Use rb tree instead of array. */
struct runs_tree {
	struct rb_root root;

	struct ntfs_run *runs;
	size_t count; /* Currently used size a ntfs_run storage. */
	size_t allocated; /* Currently allocated ntfs_run storage size. */
};


But right now it is not array. It is just memory. Probably some early
comment, but I check that little bit and I think rb tree may not be good
choice. Right now we allocate more memory with kvmalloc() and then make
space for one entry with memmove. I do not quite understand why cannot
memory be other way around. This way we do not memmove. We can just put
new entry to other end right?

Also one thing what comes to my mind is to allocate page at the time. Is
there any drawbacks? If we do this with rb_tree we get many small entrys
and it also seems to problem. Ntfs-3g allocate 4kiB at the time. But
they still reallocate which I think is avoidable.

Also one nice trick with merging two run_tree togethor would be not to
allocate new memory for it but just use pointer to other list. This way
we can have big run_tree but it is in multi page. No need to reallocate
with this strategy. 

I just want some thoughts about this before starting implementation. If
you think rb_tree would be right call then I can do that. It just seems
to me that it might not be. But if search speed is big factor then it
might be. I just do not yet understand enogh that I can fully understand
benefits and drawbacks.

  Argillander

