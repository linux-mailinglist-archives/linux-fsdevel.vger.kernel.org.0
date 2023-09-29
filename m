Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8637B3752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjI2Pxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjI2Pxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:53:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA586139
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 08:53:37 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4459941271
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696002816;
        bh=Yz63+1IerqgOxssIJi97yKZjGDoqmA2Fx86PcxES4dE=;
        h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Type;
        b=mPdxYdrTOAgu0ysh7f1r5ndkT63cXyeyB4PTJd4yOOgma/5zQYpH8OvPZEtHCmCA8
         LmIxX4rNr9eTqHGoSWQnfgoCI+YRZKBUj6CLNOASI+3d+wOsnTb3JUVzsYiDE1ceN2
         yMHeyP8pLLTwzVyqvLUh0WOz85WeWjEtCsXrwBT8Aok2qRHVL+TVmbbmCTzHpvmFZE
         /pJny8DNroXcRSrAiKxFfuFxwU4Yv3qtsvAWCuvR1tDxkMGvIM3Dg0S5lIlK3sYPl2
         vkEyzCjUiYbqgUnAeQG+jyPBnLYU7g1le4trEDuVEzIFWusKCjOEqYDOHQIf7Bd18W
         7nWHxhobtybmg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9f282713fso1191502866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 08:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696002816; x=1696607616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz63+1IerqgOxssIJi97yKZjGDoqmA2Fx86PcxES4dE=;
        b=Bx6Yr3r49LHIqb8RgIqBZjYDJSMhfYqmPwp1+9mFlFJnnNrCMn0ln3jSIyCrI+JvzO
         dzO6fA35vrMUhh2nGI2Mr9WTcGymduiUhDbmDL6l3sT7nTHnlCaY7NUJ6jQ58EmjXLEt
         7SErtBJyXcektSgiGMlp/Rw/i1lheXJpLybSH4J8IqDGYp4utUcduOmEbNqzZVBSb3ow
         Idr7ZQbbbd/+cS73YU5SoqFJEFAsRTTfHDPQmegUZkIP+B+HrYNHqzIV7TdjyzOrvKAJ
         iFQXFNGqbTzpVxJrZaKCpqSoJ81zVoc9YwTP1KKm8R+yxlI0WxSv2A5z0oi7SUzi6lC+
         yNDA==
X-Gm-Message-State: AOJu0YxhiamGliTECTohgPLHTXZB4IN9r/a++rCQTxgIwe9kj4O0XwSU
        bilkiX4dtDMTZ9D2U/QY1SQoydyI1QCli8UQ/QJDmh5fb/nRIcEDDvqxAttbT408sjLZL0vk5oA
        HZuNu4yp2Iq+XdVoOdpkCUgC5k9ecKhyj02/aMUXEH1A=
X-Received: by 2002:a17:906:8a43:b0:9a9:e525:8705 with SMTP id gx3-20020a1709068a4300b009a9e5258705mr3878953ejc.57.1696002815711;
        Fri, 29 Sep 2023 08:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKWt/taLIaMrT+2uh0mXOaEz1vmvD+UNATJRDoNil2zUFB36Us0hF4Z65XN4bML7LDbXpAQ==
X-Received: by 2002:a17:906:8a43:b0:9a9:e525:8705 with SMTP id gx3-20020a1709068a4300b009a9e5258705mr3878930ejc.57.1696002815388;
        Fri, 29 Sep 2023 08:53:35 -0700 (PDT)
Received: from amikhalitsyn (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id fy20-20020a170906b7d400b0099bccb03eadsm12485440ejb.205.2023.09.29.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:53:34 -0700 (PDT)
Date:   Fri, 29 Sep 2023 17:53:33 +0200
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Cai Xinchen <caixinchen1@huawei.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG?] fsconfig restart_syscall failed
Message-Id: <20230929175333.31a7e9c608cb3b2425b7dd44@canonical.com>
In-Reply-To: <20230922-drillen-muschel-c9bd03acfe00@brauner>
References: <84e5fb5f-67c5-6d34-b93b-b307c6c9805c@huawei.com>
        <20230922-drillen-muschel-c9bd03acfe00@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Sep 2023 10:08:36 +0200
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Sep 22, 2023 at 10:18:24AM +0800, Cai Xinchen wrote:
> > Hello:
> > =A0 I am doing some test for kernel 6.4, util-linux version:2.39.1.
> > Have you encountered similar problems? If there is a fix, please
> > let me know.
> > Thank you very much
> >=20
> > --------------------------------------------------
> >=20
> > util-linux version 2.39.1 call mount use fsopen->fsconfig->fsmount->clo=
se
> > instead of mount syscall.
> >=20
> > And use this shell test:
> >=20
> > #!/bin/bash
> > mkdir -p /tmp/cgroup/cgrouptest
> > while true
> > do
> > =A0=A0=A0=A0=A0=A0=A0 mount -t cgroup -o none,name=3Dfoo cgroup /tmp/cg=
roup/cgrouptest
>=20
>=20
> > in mount syscall, no function will check fs->phase, and fc is recreate
> > in monnt syscall. However, in fdconfig syscall, fc->phase is not initia=
l as
> > FS_CONTEXT_CREATE_PARAMS, restart_syscall will return -EBUSY. fc is cre=
ated
> > in fsopen syscall.
>=20
> Mount api system calls aren't restartable so that doesn't work. cgroup2
> doesn't have this issue, only cgroup1 has. So cgroup1_get_tree() should
> probably be fixed if anyone cares.
>=20

Dear colleagues,

I've met the same issue a few years ago and tried to fix it:
https://lore.kernel.org/all/20200923164637.13032-1-alexander.mikhalitsyn@vi=
rtuozzo.com/

but didn't come into agreement about this.

Kind regards,
Alex
