Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47424FDC89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiDLKbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379945AbiDLKUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057A19C2D
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:23:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c64so9442032edf.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpGgrYpSIgSYsbwRoSJXdqR7Ogmpyz2cUzMjtpteMcE=;
        b=HXUMtIyTN3yEQZ9VA4ytLKQ6tffEcVtX5xyuxDgEKO4nGqy7tvTcoM71MKQQ5PtdNz
         4qyZ+LqCQT9rx0WqslcXUqpf9DAMpd7+2F7+4VI5i7/4E1YcYDrddRwdOuYD3oIBbwJs
         rO7kWrRYrpdwSGS4SDKDL+rd3wGZjLDjQcTb23W4CTG/PXjPS6FhO3/YT1c3F9H7hBYB
         4EETJQ88Ki3eVG12Z2nFt232UAD4ufb2UP01B8+LYTtu0dSseV7Cku2g5HxV/qahquca
         MiiLHkWdC5PqTMDV8gGYKljYQY16rQVF2oI9UfdjEK1MIIn0QhfT157qvMugv6EL7V9w
         FTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpGgrYpSIgSYsbwRoSJXdqR7Ogmpyz2cUzMjtpteMcE=;
        b=bHWU14RufGSpG89rMaK1KEwy82oyc5cyvkAPxht/q2gW/y+F/j8KLHVysSFpKTjsA8
         Gyhna7+wKONXt9aX0twV9E0vIP/6lp45I+gPJs8182YqOkMNcSgrPW3eQNZrJo4oMUuu
         bqL4cDHYls0PrvaXAa/8fxek90qYhtoewHL/UdOnpZO20ORzKRmZUL2WetlebB3xP6LT
         TK835loOhO9oHuzMQhokg5iWDFBuBaW5e19Ma4q8ZubAIPBH4HGMLMjOzH8WgMDgIFmI
         TwZ3z9AJ7MKwVarKrRoP7aQfPv8GAvT6rbEmDKGZOPUg5W81hBRxvv4ud1OLK8HvKf+q
         L/DQ==
X-Gm-Message-State: AOAM530EHUZN561pQmoO6Uas1kdLKxsDwMDlFfOp1y/Bwl51ML2Cxx2l
        TWjK8PRqOjFflD8vGHE5sLesolDK1Hzb6EPcGZk=
X-Google-Smtp-Source: ABdhPJyT9yM2fZv4ja8aDlbMDL7KVPm7I9YtvK7AbouIP6ur1BacwtyAc3na7VZohUj6xeX4aE8E93pYDfCayJeQzQI=
X-Received: by 2002:a05:6402:1111:b0:416:2ac8:b98e with SMTP id
 u17-20020a056402111100b004162ac8b98emr37622596edv.236.1649755426641; Tue, 12
 Apr 2022 02:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406085459.102691-1-cccheng@synology.com> <20220406085459.102691-2-cccheng@synology.com>
 <87h771ueov.fsf@mail.parknet.co.jp>
In-Reply-To: <87h771ueov.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Tue, 12 Apr 2022 17:23:35 +0800
Message-ID: <CAHuHWtmYdRzh=4_ou_u=KdpQi8nSr0=XKX4JLaq+=jCaN_47cA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fat: make ctime and mtime identical explicitly
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
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

On Sun, Apr 10, 2022 at 11:43 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Hm, this changes mtime includes ctime update. So, the question is, this
> behavior is compatible with Windows's fatfs behavior? E.g. Windows
> updates mtime on rename?
>
> If not same behavior with Windows, new behavior is new incompatible
> behavior, and looks break fundamental purpose of this.
>
> I was thinking, we ignores ctime update (because fatfs doesn't have) and
> always same with mtime. What behavior was actually compatible with
> Windows?
>

If possible, to ignore ctime update may be a better choice that doesn't
affect mtime. But we need an initial value for ctime when the inode is
loaded.

One possible option is to use mtime. Although ctime won't be updated
anymore, when mtime is changed, ctime needs to take effect. Otherwise
the next time the inode is loaded, ctime will be inconsistent. That is,
ctime is still updated indirectly by mtime. It seems impossible to avoid
updating ctime, or do we just show ctime a non-sense value?

Thanks.
