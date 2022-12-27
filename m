Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB2657157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 00:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiL0Xyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Dec 2022 18:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL0Xyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:54:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC106265
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 15:54:37 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g20so1499743pfb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 15:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=xbsqSQDw/Z+yvUnm1+/bd37S1CGCwYm3bDqcZLgekfA=;
        b=JaNRvRdB7MpGg+7L4xHbVjRVEWC9JAVX0Dp+4lxICwsW7YvKwqp60dVC8UwT5JnHES
         /CLrojtMg0uwZZaxVdA7OtSctztjxAPfHKmJHBiPh+n2LFAf7CJJkTXS6tttuPKhX/5Q
         z/E2+KwWe6nwZN9V0oKQJxtQwcIkrMQbav6E4eo/df9wvvCmvDlNplV6AKyt71cr1MFr
         FjcPuFcggmYneG8KUu8akR+/885lLrdCs7oizB0L3yomTthehfSkOm1SqSmzyPFn3/J1
         HGQgD8XFxzXUzgjsS1Nz6rEbQfT8xhhNuPWMMkgmxmYIKB7Umo61+8kedvBulIzYFtF7
         Ba4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbsqSQDw/Z+yvUnm1+/bd37S1CGCwYm3bDqcZLgekfA=;
        b=oezeX+GMA+9Rib5a6DQx4zJOmnllQD0GnH5Pg/x2y2tbVHQtgXTFHD2qyzBvY7jlJq
         joY25BJsBTQjZZHeyTh3klOdMZIrpnhm4Ice4JLJ8lvdha0xK6GclxVb2EHeMD1TGY5D
         6vCvhucGyheNocnhbiKvyZOUPEo0sM0HIev8oSSNsdGkMRZ5Pt6NlpF0k2md57RVDAsg
         7ycye6gBBENBMYaYSFqxzG+uzjO9PRVzK16KaETNEDNYIVb+grxzrJ77946jDySO72SM
         Qu+At8nyHmVa2vMHr27Ayv2C+pHjfN6oCm805kjjNHIMZwCpwSGPuuEHXQ0Ro1uK2Nc4
         W5bQ==
X-Gm-Message-State: AFqh2krdtXvnzu0vQjQnEoeRHZA8e5MJcdjjNGzyLBlmfkcYsln6Qhva
        IHgItNoRojXDFHUURrhnI3E=
X-Google-Smtp-Source: AMrXdXtL3QbsZdB/LXXEO4G56sVTvw+QXYg8qq8udRKlqHiHXls8Kh4m3knYSmhXBQemWU86ie3B/A==
X-Received: by 2002:aa7:90d9:0:b0:580:df2d:47c4 with SMTP id k25-20020aa790d9000000b00580df2d47c4mr13428034pfk.19.1672185277408;
        Tue, 27 Dec 2022 15:54:37 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id x28-20020aa7941c000000b0055f209690c0sm9114026pfo.50.2022.12.27.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:54:37 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pAJmF-0003so-0i ; Wed, 28 Dec 2022 08:54:35 +0900
Subject: Re: [GIT PULL] acl updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <20221227183115.ho5irvmwednenxxq@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org> <29161.1672154875@jrobl> <20221227183115.ho5irvmwednenxxq@wittgenstein>
From:   hooanon05g@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14928.1672185275.1@jrobl>
Date:   Wed, 28 Dec 2022 08:54:35 +0900
Message-ID: <14929.1672185275@jrobl>
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
> Hey, I'll try to take a look before new years.
>
> But what xfstests exactly is reporting a failure?
> What xfstests config did you use?
> How can I reproduce this?
> Did you bisect it to this series specifically?

It is not xfstests.
It is just a part of my local tests for another security issue.
Now I am trying creating a simplest reproducible senario, but it may
take some time. May be a few weeks.
So I'd say "Have nice holidays, and thanx for the reply."


J. R. Okajima
