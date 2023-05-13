Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F624701A78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEMWEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 May 2023 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMWEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 May 2023 18:04:36 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7392D4D;
        Sat, 13 May 2023 15:04:33 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba78626a362so106319276.1;
        Sat, 13 May 2023 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684015472; x=1686607472;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1V0rCHfQsNAxq8rG9fvNacE7vU9SPMILyZfexQ811dg=;
        b=GAQC+FFYJE9OnqH98L/sJFInJE7WXQWWkrBSww4AmIuhsuNXu1aR9gWt3vSINuiTJO
         BCBkwRChtr2lnks6QIHBP0D0vC60LxW0Y627GzlidQG9sVrxdn0I3cbjB+3guMP0pLzJ
         h0ugftZ3LHGsvZ8gYZR4/RSy/ZBB16lwwmZ5Gnx5z3q3dS5Wk7VLgktg7HjqW/kfHmHs
         ifv26ngYGFFugiqoz61r0WdkAZGnDfQOBtJR3mrAvRas4/h724XcZBwE4rn4mTJNQmRd
         dMnYa46LkWMbirDRqabNLUdT3bGLBAh65qo0+YEDubdq31m/qpzuBZAFFPugxyHUacWY
         x2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684015472; x=1686607472;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1V0rCHfQsNAxq8rG9fvNacE7vU9SPMILyZfexQ811dg=;
        b=CV+f1KQ3Shz5NBdrz6eC9UQs65imCd3IqF2thrC6/WzJDP0ozCTL5dEp1eeld1/Gsa
         VRZFfNtXGO6DDsHaIHHi5Rt9LvkqpdqPmnisUWSIBB3aFHL8bjjGkIlbjTb7tIm1WlmE
         HFCGdjaGeisD6oY+KoFh3FTMusUKhpBjf/oOUF6NwsYz6d/ktDtYnBbc1V9TFcWsLmVE
         5d+ZbIBrMYmLZ4bZkOjW+xXk7nfCR33BrrikRXA+awktAFsDCKB7OjtDm4J5W2whtGZw
         sl8gshw2x6MEPTskmyntN1EgecIdcFW4V9mFXyo4YjdsRBy3FOwdlCFFyKv3uDnkWCsH
         kEjQ==
X-Gm-Message-State: AC+VfDyZKFC6VoxAzJNVNB52aGHKvWzCU5ZlYhHAxJTQHp9uX8DNW5B/
        ILKGoB+9y4LBRAO26Pu/tJ/FSr7O8IFwh7tnXT53DelxrTvCqA==
X-Google-Smtp-Source: ACHHUZ5T519ROLrZla143VAUQQbQZPCiNULj4TyktxRu93pBgary7zGRpLncod7M+Guu1zyVdo93JLX8rAQiCh4D/o0=
X-Received: by 2002:a25:abce:0:b0:ba7:918d:bf3f with SMTP id
 v72-20020a25abce000000b00ba7918dbf3fmr787961ybi.1.1684015472489; Sat, 13 May
 2023 15:04:32 -0700 (PDT)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Sun, 14 May 2023 01:03:56 +0300
Message-ID: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

Will this patch fix a long-standing fuse vs suspend bug? (
https://bugzilla.kernel.org/show_bug.cgi?id=34932 )

Please, CC when answering

-- 
Askar Safin
