Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB26B8FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfITMum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 08:50:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34485 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfITMul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:50:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so7199425qke.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hQDTQjnSsW1VsG1oz7/x04n4JF0426dRW41K9FNadk=;
        b=ijzzmZ3nvF7W4G6FRYIveg83+VVXhZ1mbySwLz7P7vjbMH20YscYZLMa6yQ1Ei211J
         rauPw9Bs3NzG3FilFYH4usejb8l+vmPvaElVOhJAnFRWMrLoV0Awdey55Jm0QEJdgN+7
         4Pf3qhjAAVCv5g9GQovJ3UeJ3u7wLUaKGFQ85WtB8st4NoUKy9RWRdsaBTxMNzD1c01P
         e4c3briubZW7NQ8e9ltVbNKymhKjonZIDtBC5u4xkTxnNeKdY07M9/jPQTmjSzBGSunV
         OQaVqjiO1QXuxaypDk1MoJvp1JEAkFkjdTdHEAIWj720NGgurgqKPGGQsEa8yt+JrfkU
         IJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hQDTQjnSsW1VsG1oz7/x04n4JF0426dRW41K9FNadk=;
        b=L6vJR3lHZJsjTzTUhu9rcgqNf5tyHnFI5sNbXwKRRkyuAeBKhuq00F4bireJPlhEQ/
         jg3SiLue+u/Czlc2N2qebuXD+miKLy4v47a1j8j1GFASaoXmmBZngYjGvYA/e9KwLe2U
         pXTO7+qAt5iMmWYSiitQhwBpEq9L9QOHu6Jk1zLvCPJNt8tmrnet/+lavdtLxO/dZmRO
         htUhP3aTaENDCvyEtb8/36TthB+nH0lb+nbT1iBUfJiaUnvgPthwmOWywQ+hx/x8GT4A
         CcUb7SUW0baEGP2fozffWrkZnf9paBDyoMwtPM0K/kW27HcTvhA85+gURFzJE3941gLx
         aAzQ==
X-Gm-Message-State: APjAAAXgio0RvbMGM7unCO1JcMPR0TMXDb9kxjLUCWAgN9MEK0w8pK+F
        HUXo93xp+QqObaHRd6Msrx+QbQ==
X-Google-Smtp-Source: APXvYqznecK3jhF+TBvYQOTZsoN72Wk/TTjLaioqEkVwBlAC/rb6eqpqbrFQUgdUDhneH2y8w9Ptrg==
X-Received: by 2002:a37:a9c1:: with SMTP id s184mr3481758qke.360.1568983840132;
        Fri, 20 Sep 2019 05:50:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm931585qkc.123.2019.09.20.05.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 05:50:38 -0700 (PDT)
Message-ID: <1568983836.5576.194.camel@lca.pw>
Subject: Re: [PATCH -next] treewide: remove unused argument in lock_release()
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will@kernel.org>, torvalds@linux-foundation.org
Cc:     ast@kernel.org, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, tytso@mit.edu, jack@suse.com,
        linux-ext4@vger.kernel.org, tj@kernel.org, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, davem@davemloft.net,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        duyuyang@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, alexander.levin@microsoft.com
Date:   Fri, 20 Sep 2019 08:50:36 -0400
In-Reply-To: <20190920093700.7nfaghxdrmubp2do@willie-the-truck>
References: <1568909380-32199-1-git-send-email-cai@lca.pw>
         <20190920093700.7nfaghxdrmubp2do@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-20 at 10:38 +0100, Will Deacon wrote:
> On Thu, Sep 19, 2019 at 12:09:40PM -0400, Qian Cai wrote:
> > Since the commit b4adfe8e05f1 ("locking/lockdep: Remove unused argument
> > in __lock_release"), @nested is no longer used in lock_release(), so
> > remove it from all lock_release() calls and friends.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> 
> Although this looks fine to me at a first glance, it might be slightly
> easier to manage if you hit {spin,rwlock,seqcount,mutex,rwsem}_release()
> first with coccinelle scripts, and then hack lock_release() as a final
> patch. That way it's easy to regenerate things if needed.

I am not sure if it worth the extra efforts where I have to retest it on all
architectures, and the patch is really simple, but I can certainly do that if
you insist.

I have just confirmed the patch [1] also applied correctly to the latest
mainline, so it might be the best time just for Linus to merge it directly so it
does not introduce build errors later on?

[1]

https://lore.kernel.org/lkml/1568909380-32199-1-git-send-email-cai@lca.pw/
