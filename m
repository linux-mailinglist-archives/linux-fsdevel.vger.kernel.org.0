Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0CE582457
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiG0Kah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG0Kaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:30:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F89FF3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 03:30:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h132so15554618pgc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=O28LB3VJeo/kKOVhLcFL4DSdRmxftwkXFxjSliaVTfs=;
        b=VCMubn+Xlb/DmCZl2pGfF9KDt7HzEd0+ho4I91ni8fm+vPUvS6t9f4gChhQbNl3DQ8
         sDVuWE7BL3YtPLf2KPfUHChSA5UeLQ0JwD4XNvaGib2L6RAyDo+hz8iF5j8bfqXJ3CKR
         dbku8UqFZUzYRXTV+JdVChpRVz7nFnINmmKv4g/jUVMRvl/K6xI59fgQAj2qf/DeLA+X
         nHt8H13nF/zUmt1ijGKMlcj6zJ9JW1UtMW0cCB/NnHUjsgM3R0VBbClfkcxee7I8JbRe
         mKbWpTGVXrcFig2I++FTLDtJAm35uSQYD4qSmHDx45bBRHwArbul6l3cjPSBnbHbfqkO
         b4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=O28LB3VJeo/kKOVhLcFL4DSdRmxftwkXFxjSliaVTfs=;
        b=Kq4M7wUmKt9kYYSJ4dXXh4dKrDIBJQuF+3wJSWRR1ysjo93XmodpxCOnKgUToUwS06
         U38Z31QPZnepQ8istsgD5hewCuPclf8cYvEVndMffltlRAuGsy5WPgQBm0bGgEI+I7C9
         3LjdVlYYAJJUOyyE/6Z24JSjUoCZDY6Y2QQtPqd7yWeMucHu/rzhk+XREBoc6YEMRNZU
         rGhzB9xxvfRqIReDxyu/7eeVEla1a7HYrlk1DXdPrZtJQ/PhHwPNwg7q+H40GyjKG2nY
         IK0qy5SV3GmBfCfcnxn9FT/B12F9Ty5LH/RfjrKPArG2Dxn9Ncz/+0uc+Hi5BrLbbjEh
         k9NQ==
X-Gm-Message-State: AJIora+9FeclgduT0SZqke1upANq5+0LNt2I6Xk6lcADs7G7TrXAxWq3
        NVqyLpM1mlMg3P5b+mPoqDve6WKgYFEFbyIs9Mw=
X-Google-Smtp-Source: AGRyM1t0VEyMEulxgRmqaTe8AK4wZHpcHICTYgA1mWDjd1k04IxO9JEosrkFWpHM3iluRXvssG4na7EAtgZ8Nx4z18o=
X-Received: by 2002:a63:8a42:0:b0:41a:8419:4e4a with SMTP id
 y63-20020a638a42000000b0041a84194e4amr18951562pgd.534.1658917834196; Wed, 27
 Jul 2022 03:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:419d:b0:42:ce88:5865 with HTTP; Wed, 27 Jul 2022
 03:30:33 -0700 (PDT)
Reply-To: keenjr73@gmail.com
From:   "Keen J. Richardson" <kuntemrjoshua@gmail.com>
Date:   Wed, 27 Jul 2022 10:30:33 +0000
Message-ID: <CAFhr1xC30S3prMtmUZOJh0H3v=R4kA4tgJ3LFRcGj0dW0MSgXw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Keen J. Richardson
