Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BF56C95D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGIMZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jul 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIMZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:25:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB9ADEA2
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Jul 2022 05:25:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w62so1671225oie.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jul 2022 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=rmE3Bmgon4GB7GUAq0lEHjTqTE8TyxhrhYXOBlkfhIA=;
        b=EpYgG7Leq+fYi27OZndgFxhlZa+c7bL+llQkyslgD/4ivp/aBSbm9eFxEdXqQKcTNP
         Dx6PlUXLxC9FZ0e6PWhcdq/X0K3TZEiifzM46uxkZzf7b23ERKk6zMdmEqykB37+xjey
         pYbFJ52QhwPAuTQegW78lWhk+H4wk70kX/TapQIFxK0zJBUS+BGWKuaXiwousfvnrs5L
         RARiG+o9F1vTTR+gHw3V3web9N5X3OhOEtZkkMj/rhdrXZ7DzI/LwvgrRclmwtJOy78T
         GHymKyROfJlsP1+6d6lS7d+oFN3BrDsW5VpESV4XNJuiXPaqWRJCcMXdQ/5ZjY7RSrM8
         FqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=rmE3Bmgon4GB7GUAq0lEHjTqTE8TyxhrhYXOBlkfhIA=;
        b=uuVFEKGlx/EZQ5Cuv1uoHN0Fcx5CVKseDn5CmGCvhigdLhy3UJXFKRptj3rtR8I53j
         911fJDOTjSZgkPQjKWbac90muGGDTz2T56CcSbdQvr1AqRAH6E0aTpj6L9OSzdPqQwNa
         7i8P8+tvrqj7AZxLF+ex1mAaVUztmLoyo4Nhyc1gdY+6kk+s+VT40hRqxhT4JbzxUA2/
         NEEEJrIe+hF/qc9LdNzWxQvfIxlnSdyTQwgH0bn/y4tUkV01Euc5mR/Yj6GvllxswP02
         Nmmj55kC1Je6jGGfuG2RObF5g/iJzDsdrkYcVjb3/UxB8sjTtNBOL4d7VIBMSCwE5OyD
         66SQ==
X-Gm-Message-State: AJIora/yFr2KvCOh8V0o2z/QSYyvmVPiG0i1U4pMnaO9+/lZ9RlPYM64
        rf2caYpiXdsUfWdZQTvBcH7feJCJu+lCAzBZZBc=
X-Google-Smtp-Source: AGRyM1vAvZOMAd9zSmAxDXGLCjmjsszI4jVcHub/nVW0jtLep2S3CY3MtBNnZ4dNxOg68Zvt10kzb1onR2CKFNtwjVE=
X-Received: by 2002:a05:6808:24a:b0:339:c49d:29a8 with SMTP id
 m10-20020a056808024a00b00339c49d29a8mr2541247oie.227.1657369516934; Sat, 09
 Jul 2022 05:25:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:6384:0:0:0:0 with HTTP; Sat, 9 Jul 2022 05:25:16
 -0700 (PDT)
Reply-To: dravasmit09@yahoo.com
From:   Dr Ava Smith <misslidko01@gmail.com>
Date:   Sat, 9 Jul 2022 12:25:16 +0000
Message-ID: <CADmtpXmwDJhTqJ-7seUKZE1q4E8WkYim__RqDJB7TCinRFjSXw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From Dr Ava Smith from United States
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
