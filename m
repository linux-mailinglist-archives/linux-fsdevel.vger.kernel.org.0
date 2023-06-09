Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56204729B06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjFINFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjFINFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:05:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEE130D8
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 06:05:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565de4b5be5so25174657b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686315943; x=1688907943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jt8xvqC2nPhBwkNP4OUqRm94IjtUiSOb8Mmp+FzN9Mk=;
        b=t5QTYuRK0di0z1o55MZaORz3xMCtAxan1FaLB/ffcAlR93intIIQy6MJ0N06SNrhC1
         3SPwTBSe0C3LrVqUT8tMnQaJq255vWq5I1aH/trIDMlKnMUMZz9An1f+wt+5WYp6XBjU
         mJS0oWoxxdNaH+BCSKXE1jE4nK9SsqCs5nES6nUMXowKZLq063TCBwhHdBGBEPDA9zjW
         MYiecrBjQKByerGm5giQ+tK50ACP1dA8wSXyjBo1Nno0Gxv16QbNLEN/r1np4qSan6cI
         B1zn41qOhHJBa2YxTfx6H/JueFvzL6mvCwr6VX4QlE3NmYJEYdt0abs68zAjO8BvbKhW
         5EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686315943; x=1688907943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jt8xvqC2nPhBwkNP4OUqRm94IjtUiSOb8Mmp+FzN9Mk=;
        b=ga+LH7fhAtKM7tfscIY+k8A3/LU561TmUMFaAqIKszOqQu/rC2kpmVnzrqCqbTSlqN
         Tpsf/3pMoB4T0QeVn4Avrg+q+TuFrk7devjx67x7lFyc6m002QD866zfXV6zaY0YVht/
         6eHUIg7z3UbcIspTsmCgCxIvDFRnlU+0wekcYMU5MSrAc02TJuO3wZlV2/1zu7lFZ9fH
         V+n/iaq8Sru92ITea3H/A0QRiPSyxVbupeuF84NV9sSHSK/39rdAVXdnD0vRgLP3eAJj
         R1ArkYix0YcHCpwhPk5CdjbZcEqhivca0FZV6uiZpNYiO8jHqhKDS9lHZjhUhd9oLrcg
         5eQg==
X-Gm-Message-State: AC+VfDx8RPnytKCA1zP9YwYuPeok6AjtNwt6ZoMMk2PsE9O3q0S7If8i
        ZhHqPtQOfiBUeJZaxdxIYhexXBAjOZa79yc=
X-Google-Smtp-Source: ACHHUZ7QoU2zQfij1jE77i3FaSipHaW0/XKcHSRc3sXUAhZ5HvUY1L0EiqlaYqU3IZEhVkf6uHE/7TN7YbakvIg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:ad4f:0:b0:565:ba21:8123 with SMTP id
 l15-20020a81ad4f000000b00565ba218123mr823294ywk.1.1686315942787; Fri, 09 Jun
 2023 06:05:42 -0700 (PDT)
Date:   Fri,  9 Jun 2023 13:05:39 +0000
In-Reply-To: <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
Mime-Version: 1.0
References: <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609130540.1643605-1-aliceryhl@google.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
From:   Alice Ryhl <aliceryhl@google.com>
To:     miguel.ojeda.sandonis@gmail.com, brauner@kernel.org
Cc:     amiculas@cisco.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miguel Ojeda writes:
> That would be great, thanks Christian! (Cc'ing Alice for binderfs -- I
> think Rust Binder is keeping binderfs in C for the moment, but if you
> are willing to try things, they are probably interested :)

Yeah, Rust binder already needs bindings to a lot of other parts of the
kernel, so I decided to not rewrite the binderfs part for now to cut
down on the number of subsystems I would need to upstream bindings for.
Upstreaming bindings has proved to be a lot of work.

If someone else wants to upstream the filesystem bindings that binderfs
would need, then we can certainly look into using them in Rust binder.

Alice

