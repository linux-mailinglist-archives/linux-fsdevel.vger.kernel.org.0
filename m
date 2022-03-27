Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AF4E894D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Mar 2022 20:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiC0SQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiC0SQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:16:51 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6ED193EC
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 11:15:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t7so10612478qta.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzh21Ro6IEaZ5p55vH/LLx6bOR50txHPSwPIloDfM0c=;
        b=S2QLdptwVR+e1f9C7KEJNO12yiHPDUOmfaVLlI+rGVxqgvPQtkrifHShz5Xi4eUFtt
         OIgwb02KOVVGhUAr8NcvxTdGXiCLfbe9cRPP74UUm6Shta48y3A4Ga5lKVFjEcnd/72z
         A3bR3+f6wLftmUAUJEubJrBlukd+BIRQ9CWOynwfWsKDtZ9zHVb7aBuaitTSyVL9aVrO
         d7uzOkuDGypU1WXlDT53cnwUQt20s9tEsmZOBbwaaQn9JlitQzlFVZohvRV6N0KoxAQA
         wUY4IdI7tfF2eRjoNGcasmBSrN8TGN9imUH/sVHtQebzm5NEgOYc9DpvCUNe/EbIgQpP
         8UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzh21Ro6IEaZ5p55vH/LLx6bOR50txHPSwPIloDfM0c=;
        b=UPExV2ygUMlXTl2F7DVJLXlzYguVqIuaqo5dz802L5qpCSP+iv9kG0KTNqU8/DNWkW
         EzRmPlioH00FJdHFNzptTwVD1ZWVAt+yNmoC33zv8DicSNlYkRJZNeBM0vHxT35cTAY6
         TRQZjZlJCMJfVz65BuuHcvfIAzoBO9QSEO/JdxlH/Isxmn7jyPPUNfrewKjfh/wMGLRA
         Lg4Rh3BxIuDHS8wlZvwH3v5T0Kn18muXTreQo+yjcaj59g9c5LQLuznEMV2RqbPENvOQ
         hk3pQ5O0u6YaM2PTYnaDxkApmD2lYaz33ucaLlW/rK5UTw4qjCHe7fYXT3UTKBdku4HU
         ZehQ==
X-Gm-Message-State: AOAM530/nX00JjD12H9DpgQnOO35kP+wQx8W+AWIwrJ4/VqXwDvNb8cH
        yhCCXWDj1WwstAeF7GqnegV7h1mis0H4jFaTvFcXyNiJVOg=
X-Google-Smtp-Source: ABdhPJwgOksmRTAiMobQcjPhf6FYRXAJCcSbk0siks775H89KdKS2FPWFtS1oUoPN/QNWkg13Hju07LL9sse0UzroAE=
X-Received: by 2002:a05:622a:18a4:b0:2e1:e7a5:98ba with SMTP id
 v36-20020a05622a18a400b002e1e7a598bamr18587078qtc.424.1648404911251; Sun, 27
 Mar 2022 11:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan> <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan> <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
 <20220323142835.epitipiq7zc55vgb@quack3.lan> <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
 <CAOQ4uxgkV8ULePEuxgMp2zSsYR_N0UPdGZcCJzB49Ndeyo2paw@mail.gmail.com> <20220325092911.fnttlyrvw7qzggc7@quack3.lan>
In-Reply-To: <20220325092911.fnttlyrvw7qzggc7@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 27 Mar 2022 21:14:59 +0300
Message-ID: <CAOQ4uxi6G+VtPzKQwrvZfo_cCF8067vgOAPHrYB6ZZAqujKF1A@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I think I might have misunderstood you and you meant that the
> > SINGLE_DEPTH_NESTING subcalls should be eliminated and then
> > we are left with two lock classes.
> > Correct?
>
> Yeah, at least at this point I don't see a good reason for using
> SINGLE_DEPTH_NESTING lockdep annotation. In my opinion it has just a
> potential of silencing reports of real locking problems. So removing it and
> seeing what complains would be IMO a way to go.
>

Agreed. In fact, the reason it was added is based on a misunderstanding
of mutex_lock_nested():

Commit 6960b0d909cd ("fsnotify: change locking order") changed some
    of the mark_mutex locks in direct reclaim path to use:
      mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);

    This change is explained:
     "...It uses nested locking to avoid deadlock in case we do the final
      iput() on an inode which still holds marks and thus would take the
      mutex again when calling fsnotify_inode_delete() in destroy_inode()."

Pushed the fix along with conversion of all backends to fsnotify_group_lock()
to fan_evictable branch, which I am still testing.

It's worth noting that I found dnotify to be not fs reclaim safe, because
dnotify_flush() is called from any filp_close() (problem is explained in the
commit message), which contradicts my earlier argument that legacy
backends "must be deadlock safe or we would have gotten deadlock
reports by now".

So yeh, eventually, we may set all legacy backends NOFS, but I would like
to try and exempt inotify and audit for now to reduce the chance of regressions.

Thanks,
Amir.
