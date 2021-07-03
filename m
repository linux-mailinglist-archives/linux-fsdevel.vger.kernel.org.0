Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65D3BA8B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhGCM2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGCM17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 08:27:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71897C061762;
        Sat,  3 Jul 2021 05:25:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq39so10733584lfb.12;
        Sat, 03 Jul 2021 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cy0BjY4SGsOtD+0aYuKWWBuuDcZGS8pdU5MZL4LzLB0=;
        b=sWL0mVP0TmLKdMiSa7irAG8Hh1PzaUupZXcWvFYoxHPjW1KlAAaCc8U6nhV5Rdf7Et
         7Z9GY/nHjC1MiJjVeOT/owlAZD9BBBChicPBZ+rK/J4OPlK2nHw9CurpnQIcvbgg5Hfl
         4ytMlFQGTU5QwjGuK6PYTaduUK0gjfaCBUV4EGHtyUiWXzLStBH1V4hMbCJfuB0U3GLA
         qpK7kpihvUerVzf40L+kpkam7TzO6uNIFjoNHONsc6C9vWpqMpQkZ/1x4CuAcHmZWxN+
         rYyOMzuUOepCWoFv9nEvqdh4wGUgsxh2q5Ota90AZqu3uPZorWTx2bB7ocdH13qihyOB
         f+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cy0BjY4SGsOtD+0aYuKWWBuuDcZGS8pdU5MZL4LzLB0=;
        b=kpRUnZBhomG4OcPXPgXVJqdXfj4cNsg1sGflauTz410tIerU3doeIyUi1zKPZlILHi
         OxTss/LkH5NvvsMbTP6qPPqVqp3r7zjFaJemqTEBnr2vVPERpIeUhUVnAaR/OKSqkoGI
         mM6dAWRWmZ8LUcKEceLEv6PXhlHK/bQ5/3z22mM6BQNyUJU74/kUL9hTwFC1YGUIgJcj
         iXmPWj6OpTMwuG7zon3e+WhgSwj6sGUyVB/u+nlagXG57FooK3apFHbCcK69enESKK7V
         l4baAK63pLpA/l2vzOHYaNBs5o7Sc8vvvTgImPQBf69s+y4mO6PqbDMoohptQLaYpaJB
         eEhA==
X-Gm-Message-State: AOAM530xHR7ugQingLol/R/QFfqRnC8hfuvEhpzSykvorKAehnjIuxbj
        /j+cLD0HpcZUgWLRcq5UzNmLa27+n/Ug7X/zMIk=
X-Google-Smtp-Source: ABdhPJyvh5/4xIn2I/ri8OhG3KgLGIRYtbGrdkx6hh4a/zypOoMhXu8t8U7jLo4q5k0xRPRp/9WdgvHChbhL4gSa2Nk=
X-Received: by 2002:ac2:5149:: with SMTP id q9mr3498019lfd.313.1625315122445;
 Sat, 03 Jul 2021 05:25:22 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 3 Jul 2021 07:25:10 -0500
Message-ID: <CAH2r5mu4qE+BPdLkVz=JvUPrbU2D7cUS15S_PBEgbr17VxgaYA@mail.gmail.com>
Subject: Test results on latest ksmbd
To:     COMMON INTERNET FILE SYSTEM SERVER 
        <linux-cifsd-devel@lists.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I ran the buildbot (SMB3 regression tests from Linux) against the
kernel server with the recent updates from Namjae et al.  All tests
continue to pass.  Good news.  ksmbd seems to be making good progress.

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/49

FYI - An earlier run hit an intermittent problem in mainline (5.14-rc)
in the scheduler (not a problem with the server, the client side was
running on very current mainline which appears to have this
intermittent problem which I have also seen running unrelated tests):
       [ 4826.261325] RIP: 0010:cfs_rq_is_decayed.part.93+0x13/0x18



-- 
Thanks,

Steve
