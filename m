Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF738453BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 22:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhKPV7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 16:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPV7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:59:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2234C061746
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 13:56:07 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v15so1646839ljc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 13:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGSDUZI7I1mvZPeQN3C3y+QjGBgnwjJfkAsVBmVdGZc=;
        b=a+XkYQtPqF5RRQI3wwC+zWQDcl6Jk2H5NnW1qWcUwoRaNbjxP1LUP2iIZVf5YnfnQ/
         bO6jsTt8flc9QzckB+29nGqqrlXfBqY13UDknpfbe/IDKUcqQx9JIzrKT2iQi0xPDnWt
         FRusVQ3k/e5mSfUl4UizYQcDxOCK+J9bpK4US5g4MlNOJpKNoYzVr+bM1fwpJeysjg8d
         BSslACmc0Kl1oCzQkbxv0VUJjYZJY9O0Tbr9LHc7AtWBIumaYbWSY/BAR0tzq9C9UvfD
         JHJ3alQND91uA/bqoZyRsjp94rux3o8yr2umKE7ZmbY1+LbsWA7jE5k24wSGkSHI7evH
         zp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGSDUZI7I1mvZPeQN3C3y+QjGBgnwjJfkAsVBmVdGZc=;
        b=F0TWTVeTCzZIyXlZVl1vg7q+RWJI+GCfymKCXmuREg6ltkRfZ7/aiE0U2mrzV8Y5Gw
         2nOjQ3NSBG5Gfk0OQLNUmgDWzl1T5AdXYi4/KmyMgvKq15YLDceEz6Q5cFbmK+1uaVQ9
         1HKqdZp8wYfygYcW2KemliGIGZAZ4hzqEZIAWGnDp+i5E16It/jmoPmKw9g6Xbw56FrM
         7dou8dm9P71BJ4sW0uRCQD0TPETWD9E2TQyJWkxQQTJ217Tdbow9VulMIclMYXXY7j62
         XMc3VsoG4LaDUVAMjB3q+vYyltBiftNutiP65U+SQuFH2/t4Qg9s0lBj28Ikb+HEwxIs
         N1kA==
X-Gm-Message-State: AOAM532Tbswob9tyY3v4Hj3zYN2CRyQ1SdD9yhnehqYhgvo4zNB/3xqs
        E/NKR7HP+0TLBSY8UOnL7n4LEf8QEfOM3wdF7WI/5A==
X-Google-Smtp-Source: ABdhPJwzHP0930XAephcBcY6fRf6ULC5mJHvkVbGVHylzeqR6CYm6Qg3QjVKhQ3+Jc052J/uw9QI1JzeKIkLSqhtA2I=
X-Received: by 2002:a05:651c:1142:: with SMTP id h2mr2513145ljo.35.1637099765832;
 Tue, 16 Nov 2021 13:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz> <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz> <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz> <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
 <YZOWD8hP2WpqyXvI@dhcp22.suse.cz> <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
In-Reply-To: <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Nov 2021 13:55:54 -0800
Message-ID: <CALvZod7FHO6edK1cR+rbt6cG=+zUzEx3+rKWT5mi73Q29_Y5qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Mina Almasry <almasrymina@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:27 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Yes, exactly. I meant that all this special casing would be done at the
> > shmem layer as it knows how to communicate this usecase.
> >
>
> Awesome. The more I think of it I think the ENOSPC handling is perfect
> for this use case, because it gives all users of the shared memory and
> remote chargers a chance to gracefully handle the ENOSPC or the SIGBUS
> when we hit the nothing to kill case. The only issue is finding a
> clean implementation, and if the implementation I just proposed sounds
> good to you then I see no issues and I'm happy to submit this in the
> next version. Shakeel and others I would love to know what you think
> either now or when I post the next version.
>

The direction seems reasonable to me. I would have more comments on
the actual code. At the high level I would prefer not to expose these
cases in the filesystem code (shmem or others) and instead be done in
a new memcg interface for filesystem users.
