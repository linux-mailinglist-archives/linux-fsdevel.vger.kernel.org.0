Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D85515E71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbiD3O43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiD3O42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:56:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567950B1B
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 07:53:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g6so20436833ejw.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA6CiMNXeQi4jrWuzim1se4QxPwAIuS5nm6sNF+ydNc=;
        b=p2t5+EAuybqzGetKyqtkpLmqBnwxJivRFFkcndKLNZlXq7YgvGARIITesfZuOizQaA
         qAKx540NFlzL9LczZq6xnSJtqNmtevWV4Kbro5//WB2U7hHYurhLDQEEGEZxZ2ubDUHw
         +O6PfFIN13sVr7n77/FoMcbabDElNkRFHXt9N0Hy++XbpuLbBnQCtf2ZGZkdHMfKG5MD
         5fdCIDwne1w9xHahU+Lv0vrEjunhGJJ98H8O93g2ybTMSsG7nuYwma9aiiOwiVUlaXtT
         ScTqliLSLFC0A/bAXX15TE1zd7Dj+5XxBaqPuD02RC0DpQNlw4IxRdn5QbQDh7yrOYa8
         xxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA6CiMNXeQi4jrWuzim1se4QxPwAIuS5nm6sNF+ydNc=;
        b=fodmnOK6bRBTmKX4fdnjTzRnyG/laGKyZ4rk6zXKKwdrKZxqIQNFo+pgVw7t/PjX8B
         sl0Qv75UbuNYPJAI9xErMcgZLiNbnonlYKILee6gFDl66WpanYidBj60SoF6jBeVS1LD
         7jrWK8NnvmRWHNygjcZzE1zA9xYKN+xWVyPI+tGf0L/CBWKultD0Ce+jxWXiuORZyhlJ
         BBl10o3ZsX3BHkuWPa7w5zK+gSaAAJVb0iBuhDPmAT0NZKMy1ktEMybuFU7pBK6JUkW6
         dLwiflN4fzNXaSHsTeNg7pxqvJbPu8CYvTuF/YWFWMe5IyW6snhmtxy16qzOXIphBwTy
         gL3w==
X-Gm-Message-State: AOAM533h7UakbcLVj2amFYYVjDPAdwAfITH4oRicFhh4i221QmmwUXTC
        WbHwfpfJB6aPA6c91roEXRzNiXmkSVOPn0de+l8=
X-Google-Smtp-Source: ABdhPJwV9O2S/uqLfRCMOG6kRcQR+P4USwTiS0TDqFgNdu9Yk4k1d7URwpSlqrYvMBlESAZeMKkZ30Ql7id+4mlzhVQ=
X-Received: by 2002:a17:907:2ce2:b0:6f3:af38:636 with SMTP id
 hz2-20020a1709072ce200b006f3af380636mr4012854ejc.629.1651330384228; Sat, 30
 Apr 2022 07:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220430044127.2384398-1-cccheng@synology.com>
 <20220430044127.2384398-3-cccheng@synology.com> <87sfpv3pxp.fsf@mail.parknet.co.jp>
In-Reply-To: <87sfpv3pxp.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Sat, 30 Apr 2022 22:52:53 +0800
Message-ID: <CAHuHWt=beDJBTzbEGumvtHYADnrP5VivwtyQK=Q9Yz2ZYDqpQA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fat: report creation time in statx
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 30, 2022 at 5:01 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
> > They are all in {cdate:16, ctime:16, ctime_cs:8} format, which ensures
> > crtime will be kept at the correct granularity (10 ms). The remaining
> > timestamps may be copied from the vfs inode, so we need to truncate them
> > to fit FAT's format. But crtime doesn't need to do that.
>
> Hm, maybe right.  I'm not checking fully though, then we can remove
> fat_truncate_time() in vfat_create/mkdir()?
>
> (Actually msdos too though, the state of timestamps for msdos is
> strange, mean on-disk and in-core timestamps are not sync. So not
> including for now)

Thanks for your insight! Indeed all the time truncations in these two
functions can be removed, because all the timestamps come from
fat_time_fat2unix() which ensures the granularity.

I'll update this change in the last commit later if there's no additional
issues.

Thanks.
