Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35B59781E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiHQUkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHQUku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:40:50 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0A9BB71;
        Wed, 17 Aug 2022 13:40:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z8so7506169ile.0;
        Wed, 17 Aug 2022 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D7+PP+1VFVB5t/XZKXqn6MijouyQ2RbiiwpNQ7fWOz0=;
        b=GxR10IqzvjdBL/BaxMHXfPFWlt/83Q820CnMlzfL/hSA6gIjg68H5JxBTAxm/lIQ9V
         0i7QhTrDa78ijLCS/8IiS1qk+BXnh1u3ZfTWADKknLCpzJTkMTnshCMrM8bbU6lICwwb
         RCQuKPTUOu0D8Cgy371UL8SU/k/ojDGxNm5xleYWISXyMRA0ftmiHl/vFGUl4fMwVUiE
         z1H1UPyZeJQ9Tlv2v8NclqCye8Gg2GUrr30eChzEFN/qUfvS5j+sg9zCz0e1pgLG8XrE
         +2vNeyK8ULLM29Av+5YMtJVAXSvHFvwfYwHRC1ylSLIReEpCYtUq4ABsIR3S2vaqOt6g
         34cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D7+PP+1VFVB5t/XZKXqn6MijouyQ2RbiiwpNQ7fWOz0=;
        b=QNmyB2nZrX4fH0RaFdlgQCuP4te7dJmHbTG60Uf3nUMMfZ1OwVSGAw+jUTlk31qQSv
         GgtooEoQVhxp72wKX0PdjJCbdoWkwpWbu8r5XitvyMKMyr+M7uaakNG2n9QYYIDmBCkK
         ZTHq396cOAZBPFJTZGrBnWAAKVbrt3BnlozzhpEwn25dAiomJmL01qx0IRnRosO4WzgK
         8QbUgCH9wmpXumkBNDCndIsY5ucle5My9KdwRlslYxiQgy6CiSeXgk9cVv6d1/2c3IAj
         zNGEz5lA5xG0WHjmvBHGyO0PJUcy2RZuVSRUXjjsf98i68f1+dReLE5iD2EBJSWL7ooI
         uluw==
X-Gm-Message-State: ACgBeo0qlgrCm48oYlV/yBUD3Sqrg9ysYrlX/Ut6i0VKz9RiKD+TMhpJ
        JG4o/CHWrZNvwIau8PELcpeCXk5oJkjrh/KVCaxBGffsB6KOscbp
X-Google-Smtp-Source: AA6agR6Pkl8a8I0NGhaSmqIm0OjcWxsxxYn1fA+Kt0gIAQtc7Bo4Uukr+9wWczkLepZwrG+Tt2qdF9cNf7ysNCWyoII=
X-Received: by 2002:a92:cd8f:0:b0:2df:ff82:2e5f with SMTP id
 r15-20020a92cd8f000000b002dfff822e5fmr12835073ilb.72.1660768849569; Wed, 17
 Aug 2022 13:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-21-ojeda@kernel.org>
 <202208171317.F5D57135@keescook>
In-Reply-To: <202208171317.F5D57135@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 22:40:38 +0200
Message-ID: <CANiq72nzOQSd2vsh2_=0YpGNpY=7agokbgi_vBc5_GF4-02rsA@mail.gmail.com>
Subject: Re: [PATCH v9 20/27] scripts: add `rust_is_available.sh`
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> I think the min-tool-version.sh changes from patch 23 should be moved
> into this patch.

Yeah, it calls into that script with a "rustc" argument, which doesn't
work if somebody happened to run it by hand, so this makes sense.

However, the intention was to move each "big" new file into their own
patch to make a smaller Kbuild one (and only do that "new file"
additions in each patch), and then finally do all the modifications
and enable the Rust support in the Kbuild patch (which has the callers
into this script). Also the script is not intended to be called
directly anyway (since you need the Make environment, but you
definitely can), there is a Make target to help with that.

Hopefully that explains the logic behind the arrangement of the
patches, which was to make the patches as simple as possible. I am
happy to rearrange if you think it is more understandable that way.

Cheers,
Miguel
