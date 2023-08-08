Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B21773EDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjHHQh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjHHQhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:37:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9447F5;
        Tue,  8 Aug 2023 08:53:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso3255192a91.2;
        Tue, 08 Aug 2023 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509999; x=1692114799;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc7u3pVQBq46Mma3c41IRkv2aI1kzf2Sp7UqgYywek0=;
        b=ShqHbumPVyvR7hMFmmR8pLeGldIVcepHVR/9kknDYTa4igimG/C/EulormMNMEZ5YI
         FBq9fuODGvXdsSIYR4mcRAujDGkeJSKEErKpZrkR3fStNgX5c3h31De+knd5pNNd2fmj
         7Q4QCat/8h8aN1l5rtVYCMUoz5+aYYTkkmjJRs6DxMybPUo2XWdH5kHgUOXOrxu7eOnl
         pRJEKewvS195qW8N+YkKhkdnnC6pgfVzW73OHod2l/PTLV30+mwmDkY2SvvU+XoIoDg1
         QzxuD0suwwLM5B275wdse1eXXXt7y/3G5p3SC44aNPMeKVUhDIIkCAXz0NBK0nRiHWn5
         oJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509999; x=1692114799;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc7u3pVQBq46Mma3c41IRkv2aI1kzf2Sp7UqgYywek0=;
        b=ecs55SbrUho1VAzh1rvyhE+cPBJ9VewbJfxA1A6Zed4UIfkfxP+le8lx0bg6BGUcDM
         HDH3Ci+ERH4mlCNX0QXL8ti32bx99+CLwlZU7gt2PKqQcaL5syvXDwYJQjyVhMYcMDii
         AUHNigQyYk1qQ77pS5YDs9XXkhnDAZPC1gJ2N8oL5rAaZb/dLI2yXFNlA380t9tG5PQw
         X4Omns2J0vtAaqJqk0inVSF940EIEyFJzilxGR69PFx5j/JmeAvpyjH1cSeJUsWMqMa1
         phrmSponvK+TolmD1ndrIVMEaa7xqdp1fP83LG+JCvJZGXPxl5HfJnZUFUNHnDRdkNV8
         XkcQ==
X-Gm-Message-State: AOJu0YxXrV5sh4P6OfLeHuZ3pzLgOAJXS77PXxsPCSY+ATTre3uhEyC2
        oxU1LuYGiTZkVo5mvQNcYoE/TIruc3QWn6s9f+kq9yWth2U=
X-Google-Smtp-Source: AGHT+IEJ1AQvyHuiu0zGUNSGA8g43uy6P+N5S7w+frRGs89r74VrtsPl6b414NNq+Y6F9xpTgBP+L1f9pk+y28IRee4=
X-Received: by 2002:a4a:9208:0:b0:56c:e554:d7e6 with SMTP id
 f8-20020a4a9208000000b0056ce554d7e6mr10200063ooh.3.1691483011514; Tue, 08 Aug
 2023 01:23:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:696:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 01:23:30 -0700 (PDT)
In-Reply-To: <20230808-eingaben-lumpen-e3d227386e23@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 10:23:30 +0200
Message-ID: <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/23, Christian Brauner <brauner@kernel.org> wrote:
> It adds two new exports of filp_close_sync() and close_fd_sync() without
> any users. That's not something we do and we also shouldn't encourage
> random drivers to switch to sync behavior.
>

They don't need to be exported for the patch to work.

> That rseq thing is completely orthogonal and maybe that needs to be
> fixed and you can go and convince the glibc people to do it.
>

This is not a glibc problem, but rseq problem -- it should not be
lumped into any case which uses task_work_add.

> And making filp_close() fully sync again is also really not great.

The patch is not doing it.

> Simplicity wins out and if all codepaths share the same behavior we're
> better off then having parts use task work and other parts just not.
>

The difference is not particularly complicated.

> Yes, we just did re-added the f_pos optimization because it may have had
> an impact. And that makes more sense because that was something we had
> changed just a few days/weeks before.
>

I don't think perf tax on something becomes more sensible the longer
it is there.

> But this is over 10 year old behavior and this micro benchmarking isn't
> a strong selling point imho. We could make close(2) go sync, sure. But
> I'm skeptical even about this without real-world data or from a proper
> testsuite.
>

I responded to this in my mail to Eric.

> (There's also a stray sysctl_fput_sync there which is scary to think that
> we'd ever allow a sysctl that allows userspace to control how we close
> fds.)
>

This is a leftover from my tests -- I added a runtime switch so can I
flip back and forth, most definitely not something I would expect to
be shipped.

-- 
Mateusz Guzik <mjguzik gmail.com>
