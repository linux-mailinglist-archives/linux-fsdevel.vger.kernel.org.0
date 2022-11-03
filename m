Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C836188E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 20:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCToS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCToR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:44:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3B1CB17
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:44:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so8087989ejd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F73NVh4G3T8S2yU6hsKMODcKxPv5yAwi4/v2CzLveEg=;
        b=KVnkgAFjjkl9n+rm/oZKENhs6RKrqltUzzJ6tjSEd5aBgeBud65YYMIo94P8IRRCnB
         JHFMyMhXBlUXVaL+knKT2Pkp8uC0s0Zf2dM88KEosi92h25NpSD4Bj/6M+FqG+ZmavqZ
         xhZJFhh064eZshWoexLt3Yb9OB5V49HgndfM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F73NVh4G3T8S2yU6hsKMODcKxPv5yAwi4/v2CzLveEg=;
        b=zjzftQmtEqOamcfaHvcfaievKD9OZJJOiSgiIOcz8YynsHZPfXBPJddzN3SBKKdbJT
         v4djwXFq3yA0EArsHsqfScG+WEBYyuyIHay3TvhlHd6CNXpov9pg7ByKOPOtpH90eBG7
         pH0IvcJM0UCvqzpP6aIaCIx77AkrVYFTB8dSkBECkbfnKKjFWK+zPJpS3j65j3+2yvBK
         9G66rI1WrppA8MHl0ZGULh85fs3jqdDz1TBMQe+YO/VVhxjO1wkelHEeIJPMZnSAJXoR
         N0PqKyFuktRlOscBM4q//GiYTlGuehv6puboErQmD/gDRw52tcqV5YasD0rBVgbZISxe
         xmdQ==
X-Gm-Message-State: ACrzQf3QlGC/t22YGXmAnF5nbFuZy8cYej1zKS81PZzLbaftwryNe/8X
        R69HiT2+PpA6qczApmhKsv3DiaK9Yeeyyr/ZKcY7jA==
X-Google-Smtp-Source: AMsMyM5ANFOKjZj2yIVNDYDiQ3nCa7qxoied3mzht3cE4j4IfN/LdAJLNmHmKpHWljc2OX8PMv3XprDEwHQe6D0neHU=
X-Received: by 2002:a17:906:371a:b0:7ad:c01c:6fa0 with SMTP id
 d26-20020a170906371a00b007adc01c6fa0mr26238935ejc.267.1667504655022; Thu, 03
 Nov 2022 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com>
In-Reply-To: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Nov 2022 20:44:04 +0100
Message-ID: <CAJfpegsU5ezACm_6CDSJfcN5fqz5vWje6UE_erNefr_e03nuaw@mail.gmail.com>
Subject: Re: [GIT PULL] fuse fixes for 6.1-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Nov 2022 at 20:42, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Hi Linus,
>
> Please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

Sorry, this was meant to be:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.1-rc4

Thanks,
Miklos
