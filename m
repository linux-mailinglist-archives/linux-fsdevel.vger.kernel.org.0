Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958004497E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 16:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhKHPPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 10:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbhKHPOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:14:09 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2EC061570
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 07:11:24 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so25990641ott.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=riXI/27ziaQi7dWmrAT/6xKqxJrcgSZhoSNHpKrR1xI=;
        b=eBsa3I0JxkIGSJ/zfNuIECLsea12lxWK2I673+pmXGzqIJEGSUAIIdWrnS+xZOzIQd
         ZkM2JbLo9kcRs8cpqqu/Fe2EpXGHjW6+xiOh2UdMfUMxdoXqxZo0pasfeXehTDb6H8H3
         ump4uczyNf8lxCqyKLbzadBZOJngcF8waTtaVWks1T7+Ui3gRx7lv9VF/UccZ3bU8/gW
         EMzk0V8eHHWrG/lZSYnUETlzn7aTNhpq31OjYnzqCkJQowk1chp59vdtxxTYUNuiT+Wf
         fD5iNdUnI3AnL03ephDKQYf3zcSwPanarVcGDBsxgOO/RO0rCXgyJhocYJSbFeEKw7t9
         cjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=riXI/27ziaQi7dWmrAT/6xKqxJrcgSZhoSNHpKrR1xI=;
        b=3DRodlW8rj6E+lbrbtIuaxT0TqXokl3niEyp0+Um3nvFRh1Cy79nj0pOlmYj/PVghP
         PMHaaFIhxGBAKYeW9iHUiCgrXnUVfPT8AeaX8K7Ra7np7YSF7/Z/GjzfYupnLfwibs+9
         krESlZW7fxiFZliCIFY5a1q+R/WlG6u66PsVrSMn5Tsgc3jMZ1yoEl1UpY4vPDmk2DLs
         2yAR9lauaGE76dMwhQMYPKAhUrsYuCSGsI+Ls3YZ7pM20E+8P8TkMwuTAUYVpnJgbHLP
         V2AsGmAleYSs+hd7hgReVbcNflMjgqgsGb7q2fFtrlWcvFuZa/zcTVJ5/gmQ1V9HbRii
         EtVQ==
X-Gm-Message-State: AOAM531FqO4ecHLMIEMqTSMRGx1znnH4i5RN0ca3/GiQCzTM9Bf5QhcO
        eS+7+8WPkAChvpEWSB2Y/okUy+2qFIqX71EW5jycScpvhORKag==
X-Google-Smtp-Source: ABdhPJxa9fdW7wPEGzFVKV9obq8uMPyTggzXVf4FGt5W/232oKDWvdEjW9jz+SH5X1l09EOyvhGjW3wAW+eCbqmczl8=
X-Received: by 2002:a05:6830:2b2b:: with SMTP id l43mr374613otv.45.1636384284135;
 Mon, 08 Nov 2021 07:11:24 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 8 Nov 2021 10:11:13 -0500
Message-ID: <CAOg9mSSOwQcMfwaVtqRe-WAF_LEjQzqWB+G-_ks4j=2J6s1s9g@mail.gmail.com>
Subject: [GIT PULL] orangefs: three fixes from other folks...
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux
tags/for-linus-5.16-ofs1

for you to fetch changes up to ac2c63757f4f413980d6c676dbe1ae2941b94afa:

  orangefs: Fix sb refcount leak when allocate sb info failed.
(2021-10-11 14:25:41 -0400)

----------------------------------------------------------------
orangefs: three fixes from other folks...

Fix sb refcount leak when allocate sb info failed: Chenyuan Mi

fix error return code of orangefs_revalidate_lookup(): Jia-Ju Bai

Remove redundant initialization of variable ret: Colin Ian King

----------------------------------------------------------------
Chenyuan Mi (1):
      orangefs: Fix sb refcount leak when allocate sb info failed.

Colin Ian King (1):
      orangefs: Remove redundant initialization of variable ret

Jia-Ju Bai (1):
      fs: orangefs: fix error return code of orangefs_revalidate_lookup()

 fs/orangefs/dcache.c | 4 +++-
 fs/orangefs/super.c  | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)
