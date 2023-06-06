Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1C72482F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjFFPsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFFPsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:48:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0EE43;
        Tue,  6 Jun 2023 08:48:05 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bad3013ed55so882540276.0;
        Tue, 06 Jun 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686066485; x=1688658485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ONGiTjryN6GD7x+xFKYju8C2z5nIeGtvGOioZNnU/U=;
        b=hi2WPoWy60JbpwaFsVjN9zNp6WFQGls7ERGpIzbNziF9isQjZtZXfa47yVs9LbQ97C
         m83n589RduXbDEgwo5bsvbc+YxZZDH7rbAiJtWEX6F33Bq/AAFLTbm/gZhOnq2S9Udc1
         rnLD1pTFNtfrXOudkX/Zt40rJiUHVCefa0HlXsmDUq6jNtV13XrWzhZsEGVQ49h+R3C8
         +8nvP0zD30tsX2iVVYXh/0CTj1Fj8Yw28A+f12C9P3oMAl/Kne51zypE7fLZsKUUfTQ2
         wv+0WYfpdUOeDGHJcNq83Wj6Y4ttgbDfXYFlJcVhfA5LEUqrEwZ9N7stEvt9Va2yhsoG
         UEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066485; x=1688658485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ONGiTjryN6GD7x+xFKYju8C2z5nIeGtvGOioZNnU/U=;
        b=Hz6cmWmEachVd4Fq+KqbZQTmo2OjnXkOHaNo1EVHZhpaaXWzsHpkXPVcvdxa5TykU+
         1bNSC5yJB08ApBpA1DGHG/fqtmQynkMT/7S/5HJ8nsl70Ueu+wq1wQlBa7wyp8paeWpj
         sxsufZdLkHMvxam6tB6oYNG5z9zfU447WyChm+Y3D3mOHhQ9Gbx/Ir9AiT2qv8MlyVHU
         Zx+M1KLDr20HOSo+YjTFN0M3STvXRVIfRebNa01kGSHCKSQm9PvW38tbR57ew/PXV8UX
         YtEFqKmhfuulh0+mT0vKOmjzH9dzv+ZY3X/E2ZuNNL6WoXygnzN8TQ0YLi7dit2LfcL4
         AwCg==
X-Gm-Message-State: AC+VfDyeLS9SoLm75SiDKCxgD8aqCEXRx3Z3aNLMXDfnDp/JmhTwyPLI
        SVY0zIZCubu2rK1gjVsPDjnJPwghPQKMdQDDrn4=
X-Google-Smtp-Source: ACHHUZ5p6OEn2LB+FAVJnyEqVA+2Boc+8078eohVh6Hf0DHjLFeF+msH9EZ1kDDBR7xuh6HNC1IPBbwlZt7YsaCnojc=
X-Received: by 2002:a81:4c57:0:b0:567:7dc3:2618 with SMTP id
 z84-20020a814c57000000b005677dc32618mr2611220ywa.1.1686066484784; Tue, 06 Jun
 2023 08:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
In-Reply-To: <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
From:   Askar Safin <safinaskar@gmail.com>
Date:   Tue, 6 Jun 2023 18:47:28 +0300
Message-ID: <CAPnZJGDsoq5wjPFjhCU4xLvrCA4x5jT-E6B7BMMid_M57PKOCA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks a lot for the answer

On Tue, Jun 6, 2023 at 5:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>  - if requests are stuck (e.g. network is down) then the requester
> process can't be frozen and suspend will still fail

Unfortunately, this is exactly the problem I sometimes face. If
network is up, then suspend works normally. But if network is down
(and I'm trying to access sshfs filesystem in that moment), then
suspend doesn't work.

So, it seems your solution is not for me

> Solution to both these are probably non-kernel: impacted servers need
> to receive notification from systemd when suspend is starting and act
> accordingly.
Okay, I will probably forward this to sshfs devs

--=20
Askar Safin
