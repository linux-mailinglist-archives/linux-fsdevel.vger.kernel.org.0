Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABDD5FCAF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJLSul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJLSuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:50:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE278D77D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 11:50:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e20so21027268ybh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GzsUvBQiz/p5lBS4u/Z2dC0BuxrD0bfzLNa+CLSGG1E=;
        b=qnoUrTIxp/74AFQHKigfKrsnXOFO8n2XGP0u/3jtVgb22y+sDFvTeC+hEeRTxBGUSz
         xjP3fA91i99ibbHJpvFnRiQTEQJesuSNNgvs9x68VYP3X16be+qhMD8QlBebGvGj3mH9
         KUKKJRHnUhYw4aKplQUaOadEgzf6ybI1TyXBw9S6ug4hUgWroYBJRCxznJtNUvQlX28F
         HO8aH0VXBlplJT7JMuOA5EceH4m3WM/QG4Uzfm8LH8Euo13HybiuO+n4n8eSzZsd9+Dd
         d+b9Yg+6D8HUmcvquD0rS847lWCijqjlmgFOuDnW/fhQUJySPKBd/jHk1TMCit8YgVhk
         RwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzsUvBQiz/p5lBS4u/Z2dC0BuxrD0bfzLNa+CLSGG1E=;
        b=JJP737Q7HEcoQxkkYNxiQbigjl1cKcvMZMYprqIsRTNvooeUebXn920iYkG3V7vcLo
         qu0zZ9GaHBuP1rPmZP5pcz0idzbQ8DoU5iAXkNU9aCl07iD9Ff7MIyfdrOgEok9I0vR4
         zJ3Vm276mWuATinbACPX6uwn7ff803TeMOCNhFIMIrLWBWqvDJF/vDXWmpOUP/SKhnFa
         cNmIinPut7JPoRqg/ZEim5hukRju6BPGnv6gvN7Wb3ejCWYfetxe9FvNC7bnaAabdq38
         DP9od2+8GhOjH8bup34fEjx1t8Bk7JXjeHppgcyXLkVt5sFvHofauyasfoPFuUC8YMnr
         J3Ng==
X-Gm-Message-State: ACrzQf3sDcgJvh9XCTnYyjS4bSdAm5OP58K36onti9Q1fL1btsu2TVSa
        0dSdWrzgi4SbK2YT2IJvoq+oDyfYrHjJ6o0PByETPY8tqrD0XA==
X-Google-Smtp-Source: AMsMyM6QXOKF3otTiY1TmS0NmK+SvRkLLWOsbdFWJuZ+76kqo7wg6LMifor1pSg8eYXVzx1m7qTgAgIjlrsgWfG4Buc=
X-Received: by 2002:a05:6902:349:b0:695:9d03:e009 with SMTP id
 e9-20020a056902034900b006959d03e009mr27258423ybs.588.1665600638063; Wed, 12
 Oct 2022 11:50:38 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 12 Oct 2022 14:50:27 -0400
Message-ID: <CAOg9mSQAvtU3rJ-My-3MUE1Uv-nc5QYyhJBO4npk-wfdiBkMOA@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.1-ofs1

for you to fetch changes up to 2ad4b6f5e1179f3879b6d4392070039e32ce55a3:

  Orangefs: change iterate to iterate_shared (2022-10-03 13:05:38 -0400)

----------------------------------------------------------------
Orangefs: change iterate to iterate_shared

----------------------------------------------------------------
Mike Marshall (1):
      Orangefs: change iterate to iterate_shared

 fs/orangefs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
