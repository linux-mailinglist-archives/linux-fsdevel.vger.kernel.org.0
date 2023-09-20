Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2C7A894E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjITQOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjITQOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:14:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8BEB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 09:14:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c108e106f0so16145331fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695226470; x=1695831270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqLW4uQhQhK4+86cd9RFSgawxgwYrx/QVTSLHhlo+zQ=;
        b=T9gB7r013q4/pXFeP2jz4K3/ekLc7tAIsCCXhM8iqbAGN4uVy+22ypN28wcCCyarDI
         L3ZqK84M74AHcrRRJNgonkkOfWl7NUpZUviIdIkeoJ5vodK6UidA8/LXRZfJXc1iUYna
         uZnI8OrYHyiuqx/rpg6QFj0B7un5MGxubcsQt7a2ids83Q8sKFHwB4hF8ebtvazpa6Lf
         M40iylmio/foHTh7xgvM/zL6Xp64ygLc7g3CsszBa5dBaycXEl6KUVbxx8XTVLaEByPf
         TRO2Oyeq/EraKiFHoIzbheFsMlIIKPX8LosfhPEeEYNOkFe0x2M3n2PC7bTmy4/CF78/
         gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695226470; x=1695831270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqLW4uQhQhK4+86cd9RFSgawxgwYrx/QVTSLHhlo+zQ=;
        b=Sp4nui3X2NLiMoVJQ7NkB3Ln9Zr5oYKLunp0nRH6nrf5kgLrwpkB3PfZ32MFsxQLpD
         Sg3fES+cn0cTfFQgUL/8+GRrv4Jaz0454uKkbDKJ12eM4wOgY1YFxuV2mrlEsaQy+VAT
         LJk8p0Q/gOE1WLKqcAH/Dlgsukuuc9Qb0Edw5ACO/TjxK5nN4NJGXta8+uMD2ebUmxxc
         eneTRk3bD5v5ozZJ3ffx2Fzmion7pHLp5n7N0IZmix0wovGfXCLtlSDfji95iZKaEtPh
         2McuKMENnKjcj5Jdb+mln1kef4UnpWJSLghRKRpTaaBb3uNrd+qcT02cAAvZ+ECWGNmQ
         OtVQ==
X-Gm-Message-State: AOJu0YwCwOlnRtxBOD6Xe1R889Ma/SQVcWgn22eCWk2FTUHCFnFzkMGu
        ikEtRGL4xsKM0n9e5FwMY+MexMJTgCOg/js4zuuyUQ51PgknvTYl
X-Google-Smtp-Source: AGHT+IFooVhYqJ0FBcreGD4p2YCN/iDqpGKVKVXOPGbBs4dpUKh+lY0z3i3yfwCi9MZrCqK461lbYhQQQcDidqZx7mQ=
X-Received: by 2002:a2e:9957:0:b0:2bf:fbe7:67dd with SMTP id
 r23-20020a2e9957000000b002bffbe767ddmr2407322ljj.28.1695226470147; Wed, 20
 Sep 2023 09:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner> <CAKPOu+9uO=wbTnesZ-jCw5E+AY1fwvcXykBtEQYOzHTyEeP_8g@mail.gmail.com>
 <20230920-kabine-senden-e1a137f3d7cc@brauner>
In-Reply-To: <20230920-kabine-senden-e1a137f3d7cc@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 20 Sep 2023 18:14:19 +0200
Message-ID: <CAKPOu+-w1d04tQETKdNmGknnNkfpVsVZLUYi1t1Ln6BXX5Umsg@mail.gmail.com>
Subject: Re: When to lock pipe->rd_wait.lock?
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 5:50=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> I don't think so, O_NOTIFICATION/watch queue pipes allow userspace to
> use pipe_read() and pipe_write() but prevent the usage of splice. The
> spinlock is there for post_one_notification() which is called from
> kernel context.

Oohh, that was watch_queue, not wait_queue! This is how I
misunderstood your previous email.

So the spinlock is used in pipe_write() only just in case this is a
O_NOTIFICATION_PIPE. If I understand this correctly, it means the
spinlock could be omitted for the majority of pipes that are not
O_NOTIFICATION_PIPE?
Do you think it could be a worthy optimization to make the spinlock
conditional? I mean, how many pipes are there usually, and how many of
these are really O_NOTIFICATION_PIPE? This is a very rare exotic
feature, isn't it?
