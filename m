Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD347521379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbiEJLWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEJLW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 07:22:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2220724826B;
        Tue, 10 May 2022 04:18:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j14so16456657plx.3;
        Tue, 10 May 2022 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAG18UO/tcE+S05MnOeuxuMLEaWaJn7EzeFBAyc6xEI=;
        b=iKT7QYiaUQ8dZ1P3vmShQW0ThVsrrDG5/CHhH/XmT3yWc177RjBTpxPmI7ZnEwzEhE
         quwHAvT9et0uXnC+VeaF/RTEzIk3VWuucB3BscSJARj6R1SHVuDtx8nmpcBeubrE81yX
         7zSenZfp0IdwKCZMvLQgd/TsfOYG5EmlQHpZz/lHMA4prCoXa1Cj7XPxmOukbMNMYII6
         24jlbaFxEDzG2z4ln1f5RWkc2QRFMPTfIL92VcBsJS13KAS4Zl99c1tWdQJIncUqnMFS
         D6PGzf33NyyF8CklTafXFDAQEAloy0EPGB7csfjbZRvjrY+eNMV2ZsbFAD8+53kjZzWr
         Gpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAG18UO/tcE+S05MnOeuxuMLEaWaJn7EzeFBAyc6xEI=;
        b=1zv5ZLzhlbZPjZhOyy3cDI8as5L7sP7FFzkiF1Q6Lx9SSvRnW6OJ/rOrha2mIx7fsG
         0MVcriurEG1zC05xW+K9GaZttO/TWiuiwpYA//wMiKh6JgpIrqO48Ex3IIUkAE9sJC89
         Li3I1FpuuMZ+gB4j0RDUfHJp+LjtFaA+covOIYR92XkyEQ9oUhRC9rj7jlKP4qHDh5tJ
         6m7Mu0kV6Y+mFTETY5hSoyviFvC7FHvj9HcEdHjSgWz3Wf9KZHxjyr7X+4Kp77utbDly
         j6kU9lhyIbBfzDCk4RCmUU0nKPuyuMshSlAQp5H20b6BiecnqBqUd9AxoTDBXE2UHEW5
         TP/w==
X-Gm-Message-State: AOAM532/XzesZRSuPhmMbWRLN40FKUxKitUANfmO5u+F0f84N2XJ8CFv
        lBm4+WxcI1OGuqHh0Nc8Z6k=
X-Google-Smtp-Source: ABdhPJyar+0k/7nbZhwkZK7IxG/e7t/vnNzB2lZg7PhgLGknkbHzom5aqgDBwikrS+PFFHTrbWguMg==
X-Received: by 2002:a17:902:f68a:b0:15e:b12d:f4a1 with SMTP id l10-20020a170902f68a00b0015eb12df4a1mr20067951plg.166.1652181508606;
        Tue, 10 May 2022 04:18:28 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id h70-20020a638349000000b003c68eddba62sm4542314pge.89.2022.05.10.04.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:18:27 -0700 (PDT)
Date:   Tue, 10 May 2022 20:18:12 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <YnpJ9Mtf+pjx4JYm@hyeyoo>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
 <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
 <YnYd0hd+yTvVQxm5@hyeyoo>
 <20220509001637.GA6047@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509001637.GA6047@X58A-UD3R>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 09:16:37AM +0900, Byungchul Park wrote:
> On Sat, May 07, 2022 at 04:20:50PM +0900, Hyeonggon Yoo wrote:
> > On Fri, May 06, 2022 at 09:11:35AM +0900, Byungchul Park wrote:
> > > Linus wrote:
> > > >
> > > > On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
> > > > >
> > > > > Hi Linus and folks,
> > > > >
> > > > > I've been developing a tool for detecting deadlock possibilities by
> > > > > tracking wait/event rather than lock(?) acquisition order to try to
> > > > > cover all synchonization machanisms.
> > > > 
> > > > So what is the actual status of reports these days?
> > > > 
> > > > Last time I looked at some reports, it gave a lot of false positives
> > > > due to mis-understanding prepare_to_sleep().
> > > 
> > > Yes, it was. I handled the case in the following way:
> > > 
> > > 1. Stage the wait at prepare_to_sleep(), which might be used at commit.
> > >    Which has yet to be an actual wait that Dept considers.
> > > 2. If the condition for sleep is true, the wait will be committed at
> > >    __schedule(). The wait becomes an actual one that Dept considers.
> > > 3. If the condition is false and the task gets back to TASK_RUNNING,
> > >    clean(=reset) the staged wait.
> > > 
> > > That way, Dept only works with what actually hits to __schedule() for
> > > the waits through sleep.
> > > 
> > > > For this all to make sense, it would need to not have false positives
> > > > (or at least a very small number of them together with a way to sanely
> > > 
> > > Yes. I agree with you. I got rid of them that way I described above.
> > >
> > 
> > IMHO DEPT should not report what lockdep allows (Not talking about
> 
> No.
> 
> > wait events). I mean lockdep allows some kind of nested locks but
> > DEPT reports them.
> 
> You have already asked exactly same question in another thread of
> LKML. That time I answered to it but let me explain it again.
> 
> ---
> 
> CASE 1.
> 
>    lock L with depth n
>    lock_nested L' with depth n + 1
>    ...
>    unlock L'
>    unlock L
> 
> This case is allowed by Lockdep.
> This case is allowed by DEPT cuz it's not a deadlock.
> 
> CASE 2.
> 
>    lock L with depth n
>    lock A
>    lock_nested L' with depth n + 1
>    ...
>    unlock L'
>    unlock A
>    unlock L
> 
> This case is allowed by Lockdep.
> This case is *NOT* allowed by DEPT cuz it's a *DEADLOCK*.
>

Yeah, in previous threads we discussed this [1]

And the case was:
	scan_mutex -> object_lock -> kmemleak_lock -> object_lock
And dept reported:
	object_lock -> kmemleak_lock, kmemleak_lock -> object_lock as
	deadlock.

But IIUC - What DEPT reported happens only under scan_mutex and
It is not simple just not to take them because the object can be removed from the
list and freed while scanning via kmemleak_free() without kmemleak_lock and object_lock.

Just I'm still not sure that someone will fix the warning in the future - even if the
locking rule is not good - if it will not cause a real deadlock.

> ---
> 
> The following scenario would explain why CASE 2 is problematic.
> 
>    THREAD X			THREAD Y
> 
>    lock L with depth n
> 				lock L' with depth n
>    lock A
> 				lock A
>    lock_nested L' with depth n + 1
> 				lock_nested L'' with depth n + 1
>    ...				...
>    unlock L'			unlock L''
>    unlock A			unlock A
>    unlock L			unlock L'
> 
> Yes. I need to check if the report you shared with me is a true one, but
> it's not because DEPT doesn't work with *_nested() APIs.
>

Sorry, It was not right just to say DEPT doesn't work with _nested() APIs.

> 	Byungchul

[1] https://lore.kernel.org/lkml/20220304002809.GA6112@X58A-UD3R/

-- 
Thanks,
Hyeonggon
