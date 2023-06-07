Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98899725CCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbjFGLOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbjFGLN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:13:59 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD604BA;
        Wed,  7 Jun 2023 04:13:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-556f2c24a28so7730097b3.1;
        Wed, 07 Jun 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686136437; x=1688728437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrJxdATXyWpfUu9r5bzsGo7jpJOQRgXwendTd3rc1FE=;
        b=aiOUFUqeLlVZtivXeuMxlIRytiQmCvbbISRdnDWJFCTV93pU6Tu8PVTdwB1vQ204pj
         Ncbb/gjSOvN3SwyDs5PBb8nFOPtvlnJxNCv9qcofK+c7CoGUc75gKCUfnzZ+euu21qix
         qn+o6BmItfsHrP7Ke5FxoI9QczQ5J3xPA5yXcp6wDBLBX4ZPx+gfuwp6Aw+o5r63n7Lu
         pLQQU6ALFiPN+oz+II84PrUwpHYYJvML3M3gshbKrWgNIq5TeDMmprvPJOlevrR2Jpdf
         DrydmW0E2rFBw9CDvqAySbCvaZJs1+GdU6qrV5xu0MWFz970EPZbZN2nWa5VS3gga0gB
         P+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136437; x=1688728437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrJxdATXyWpfUu9r5bzsGo7jpJOQRgXwendTd3rc1FE=;
        b=MUz9jlyGvT1QZaB/HvU4OcVK0qO+M0kHrfPKfh6MI/xumKx1QFSuliobj+0OW3kI0z
         ZlPap6Tw9YuiSro+8rLUpMbL6CgC6TuJE8KH9duSDzGH40NwHOxhyVDaWwM12pXHkQ0o
         bLIMDyvpy/0HhacLMZ4cesLTIsTM0UpoB8rPv4xDw47EvSVS9z3YWxAuV+OZIu3jf5ih
         ecC4Ds20haZ8CauwavuTaVOzpQnBC9dzZjSpTtH7QN+KS/vYBUTU53Dzdd9C+VP3G/zE
         zh+7Htb9/fuuawsPCEiLGI+lduQr3t4QBf6XdjfPSG30sGqvjfXmXkCpSGvL2xe/58yA
         h3yw==
X-Gm-Message-State: AC+VfDz5v5yPclvNaqeicCaSQuP/vidZlwAV1lKWUjoTJFVLxuz1xEds
        ZG/gQip0xjXfFG+aEmbQrD0ZAFL9amHRYXW5N90=
X-Google-Smtp-Source: ACHHUZ5gEYpTZhSH45XyjcrNKKw+KEn1RjUYSZUD37fuwbaQJUo28O8P4HoP+LwveAAA9KED5RCP6pwa9Lqdt44TxA4=
X-Received: by 2002:a81:7915:0:b0:569:e91c:ed8 with SMTP id
 u21-20020a817915000000b00569e91c0ed8mr1374564ywc.2.1686136436858; Wed, 07 Jun
 2023 04:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
In-Reply-To: <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
From:   Askar Safin <safinaskar@gmail.com>
Date:   Wed, 7 Jun 2023 14:13:20 +0300
Message-ID: <CAPnZJGB8XKtv8W7KYtyZ7AFWWB-LTG_nP3wLAzus6jHFp_mWfg@mail.gmail.com>
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

I found a workaround for sshfs+suspend problem!

On Tue, Jun 6, 2023 at 5:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
> Issues remaining:
>
>  - if requests are stuck (e.g. network is down) then the requester
> process can't be frozen and suspend will still fail.

> Solution to both these are probably non-kernel: impacted servers need
> to receive notification from systemd when suspend is starting and act
> accordingly.

Okay, so you said that the only way to solve the problem "network is
down" is to fix the problem at the sshfs side. Unfortunately, sshfs
project was closed ( https://github.com/libfuse/sshfs ). So the only
remaining option is to use some hack. And I found such a hack!

I simply added "-o ServerAliveInterval=3D10" to sshfs command. This will
cause ssh process exit if remote side is unreachable. Thus the bug is
prevented. I tested the fix and it works.

But this will mean that ssh process will exit in such situation, and
thus sshfs process will exit, too. If this is not what you want, then
also add "-o reconnect" option, this will restart connection if ssh
dies. So the final command will look like this:

sshfs -o reconnect,ServerAliveInterval=3D10 ...

This finally solved the problem for me.

But one issue still remains: if the network goes down and then you
immediately try to access sshfs filesystem and then you will try to
suspend (and ssh doesn't yet noticed that the network gone down), then
suspend will still fail. (I tested this situation, the suspend
actually fails.) But I don't think I even will reach such situation.
The lesser ServerAliveInterval you will set, the lower is probability
that you will reach such situation

--=20
Askar Safin
