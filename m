Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C865CB24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 01:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjADA5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 19:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbjADA5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:57:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ABD17066
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jan 2023 16:57:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so34635705pju.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jan 2023 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq1c/AvLXgc2roO2z2plGhlTBLyuyX2cMgq0YW/fCgw=;
        b=qZ5jUlUANmMS58r1tOTXY8wBwc42KTBdlWAQWfX8z0ssl5FM4/DMZgkRGUq67yIfVU
         3jb0rXFvZ+BKQVXek50mKgV3hz6ILc3XpBr8sRGwmAPk3pD8z+2OURwl3hrXfDU52COu
         4RsD7qSybb59H6P1xwo4T2dlQeVy6H8r0ajUb7VqmXLo1IltP3sM49kQLkAuHknyOLk0
         nGN883RkJGZYQDpEwfRYBE71uNVl6uLhlPhwGy1ie4UYV+aHlvO8gwIgwgbUsNY1av+X
         Sd4mCmzYSvFcWpSEsa8CWQQLjM6EaKOeUd/QWA2uCgoAEKJ3IA3LqXXjpuqGo1n5IRXu
         dnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq1c/AvLXgc2roO2z2plGhlTBLyuyX2cMgq0YW/fCgw=;
        b=fW3WchFVOIe3FsO9HSb9lyNcgbCfCcVfc7iMj2Gq+RY6Sd3UprLFidCxmgbpdZ+bik
         AjYCF2Mhg4hCuDay5iC1SClxAxk/QKZr2nqutEZBaroCoFC9hLE9aUbm3HiJu8uVjXVY
         ezQoZpjW7EWmdl+7KGCHwdx2pPITQlNVWOipsB22H+Q2OZgDEUW2ZEMxWSaNwiUJW+/3
         GxhUvMlN8GZvk5mJV0PMhiit4aI1OFRUzkv3yy8xiauUfwRBnJQMs5akzxyP4HrPPgnO
         aAgU29qQO7jLwv+FLBhGbKskZgcPLnJ9fx3FqnKQzB9O0HK4/QiurLc6aWoE25p3Aawt
         xqFw==
X-Gm-Message-State: AFqh2kpAYKMCRfEnHUANJvnn5I/MEvAOAcCbMUYzkx+VOnNxu2ktprVg
        KKeF7UVskSxnLCfLHkti/rg=
X-Google-Smtp-Source: AMrXdXs4s9Lz0A+N5j+kqLcZfgXZcOBuL/993XjEjkBa+JrfKiBCKrzpRFobfm7nwW89cc1XSEwTEw==
X-Received: by 2002:a17:902:8c8b:b0:189:c536:c745 with SMTP id t11-20020a1709028c8b00b00189c536c745mr49691160plo.2.1672793850400;
        Tue, 03 Jan 2023 16:57:30 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902f60a00b00188fdae6e0esm7368698plg.44.2023.01.03.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:57:30 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pCs5w-0004Ns-J0 ; Wed, 04 Jan 2023 09:57:28 +0900
Subject: Re: [GIT PULL] acl updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
In-Reply-To: <20221227183115.ho5irvmwednenxxq@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org> <29161.1672154875@jrobl> <20221227183115.ho5irvmwednenxxq@wittgenstein>
From:   hooanon05g@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16854.1672793848.1@jrobl>
Date:   Wed, 04 Jan 2023 09:57:28 +0900
Message-ID: <16855.1672793848@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner:
> On Wed, Dec 28, 2022 at 12:27:55AM +0900, J. R. Okajima wrote:
	:::
> > I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).
>
> Hey, I'll try to take a look before new years.

Now it becomes clear that the problem was on my side.
The "acl updates for v6.2" in mainline has nothing to deal with it.
Sorry for the noise.


J. R. Okajima
