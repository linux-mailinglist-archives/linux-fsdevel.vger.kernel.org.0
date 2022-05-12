Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEB524CD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350394AbiELMaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiELMaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 08:30:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48313F35;
        Thu, 12 May 2022 05:30:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id fu47so4142381qtb.5;
        Thu, 12 May 2022 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQiqWZrRB16NjkMXC8fmeM9ZM7iEqMa7fAB1175TsNU=;
        b=J4Wo8R/RXOEPe2RWiqzhHzUROd03ArSLwuEPWLGf7VH3rWrna1foPjpdXq/4CgxYvw
         kVsm0nmBVJWfirWrjJntlY70InwtG9jV10rLiMIJCOqZOqyvY/uYUvfVv2rmwLdtgjO4
         LJ/JqUmEGhjCfetlFvtnUQQRlVOhQwvsyZQ/d/D9w6gcbgP8KDjy77uszhBuHr23+vY0
         yMYDnBjxCxNZqzQ7u5Rwy94NdSFLkbPrR/ZIbJrFxL8pwhUYVYv4ycnQY918TyBtf/MU
         Vo5e+Ut9ED7Kzx2fVPQAZlkDRSwvPu7xfcf2wTEvU+ENxzP0ypFjwTLdkdbJFm6YAygI
         Efig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQiqWZrRB16NjkMXC8fmeM9ZM7iEqMa7fAB1175TsNU=;
        b=YZu5lfiN5tgm0AK5bNE5QgHqviH+/aOH3SO0YpXr+8DwzZLUSEKV/XqUcnxboxN0Tr
         jo7YNrLeXR3fJmatziu/wAINuarQZW60HT1yzWSLdadMFY1TJ7aGBmyU7KY3r1e4NqFm
         v0dmhAMREOtoETHhm3/FPIV49d6znIQgL6+Lh7ObT9I4acR7GRMuqjXyBUsRovckZy2N
         zicKYM6qYCYPa5ZN2fgcfovL8wsJryjpVBCQGHplNEsQ/UwUkLGmaGgFVcNx7XpRDYYE
         jzogxPy+3bg801W1/Rv/fzYXCGJiC8CAgbdmJjvCqqIwOb8EEpYtLEDi7A95WYQu33NH
         M3OQ==
X-Gm-Message-State: AOAM531MJNxR0aO2ireXtnFArUNU2GrrJHwUOxBzCqk31sOtJ5bd9tDP
        9CLKPSQSMTadK7VtkFKIoYkxQZsYLrukZN3KF7c=
X-Google-Smtp-Source: ABdhPJxOS1aZ0rU0taKVCsDSMHPuSnwD6+3BnAnqqD7B/ow5mFt1jkOJoR+8Cd5aaioOa/rG15ya5VTtA02SsQQoi0o=
X-Received: by 2002:ac8:4e46:0:b0:2e1:b933:ec06 with SMTP id
 e6-20020ac84e46000000b002e1b933ec06mr28865970qtw.684.1652358618712; Thu, 12
 May 2022 05:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
In-Reply-To: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 May 2022 15:30:07 +0300
Message-ID: <CAOQ4uxjOOe0aouDYNdkVyk7Mu1jQ-eY-6XoW=FrVRtKyBd2KFg@mail.gmail.com>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
To:     Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Thu, May 12, 2022 at 2:09 PM Simon Ser <contact@emersion.fr> wrote:
>
> Hi all,
>
> I'm a user-space developer working on Wayland. Recently we've been
> discussing about security considerations related to FD passing between
> processes [1].
>
> A Wayland compositor often needs to share read-only data with its
> clients. Examples include a keyboard keymap, or a pixel format table.
> The clients might be untrusted. The data sharing can happen by having
> the compositor send a read-only FD (ie, a FD opened with O_RDONLY) to
> clients.
>
> It was assumed that passing such a FD wouldn't allow Wayland clients to
> write to the file. However, it was recently discovered that procfs
> allows to bypass this restriction. A process can open(2)
> "/proc/self/fd/<fd>" with O_RDWR, and that will return a FD suitable for
> writing. This also works when running the client inside a user namespace.
> A PoC is available at [2] and can be tested inside a compositor which
> uses this O_RDONLY strategy (e.g. wlroots compositors).
>
> Question: is this intended behavior, or is this an oversight? If this is

Clients can also readlink("/proc/self/fd/<fd>") to get the path of the file
and open it from its path (if path is accessible in their mount namespace).
Would the clients typically have write permission to those files?
Do they need to?

> intended behavior, what would be a good way to share a FD to another
> process without allowing it to write to the underlying file?
>

If wayland can use a read-only bind mount to the location of the files that it
needs to share, then re-open will get EROFS.

Thanks,
Amir.
