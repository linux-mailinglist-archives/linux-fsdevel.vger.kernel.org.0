Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6410A52797F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiEOT3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEOT3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 15:29:37 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1E27CEE
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 12:29:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id w187so23806420ybe.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=DMUWO0ynk/rpM+QD0WMgkL9JB6boPabsDdg0IWsnjTSKKEudYKJ/6jKiU4qOtYMIeA
         KyYOg69wWo3bBjvE5YzeHm17ePL9PyO98jBa/7tlT3viCadH+PIGEEtMZ42T0jdt3n1E
         YJkWwHBcbhVZI7JxpllGtA13wW+kzMmznqsiqC3CNUj5SZbA5REcLgA9es+POiMtL7uS
         2+8klS7o1ZXCrifaL1H/AoNVuxct92SoKcNBJ44NZhlXXEoFNtfdKieRPL7/4/DTiNWf
         EHDUaNEVC23zjVh3IPCPAw9lSzwZr89BdnvhSQ3jW29xl1TPehNtsd+ul9LeStOcGQKW
         N5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Mt1fyvZuHkw0WPZp3xFDj3cqo6npCDoGBK/tF3Bp/x4DHQ5oL60oilSQaB1ES0341A
         Z/+MtpPACt5JVHfmg8XcVqrmRVhFEtbt+WyjOvSfUL3Jp3g29zVA8rTzib+qi9RYMZ0H
         FkJuxS206Cd4TNiPijG53tJODwu4oj7qq1IuVUIDGh42q0OW8Nd/0FAo4n67EvguR7UF
         OoaiFNaBCCy5ZZGdibrpLR+v5OwYQmTk3RqsPnReN3ozeaazib7WxSVSY7xlvgdXu7pR
         knRcYCl5tceOEnd8j7VdsH+90hdgPth8EMoGz69scKYriaLn6Kgg5ZRY7zXKDr5RkqLw
         C0gA==
X-Gm-Message-State: AOAM530PUAcM4KbT/ZP3pU5nHD/06g0hh5c7Jt33hDozLAs/QqEF/8+G
        McO+57ZzX78o9MvR0z3NM2rrpGTimoacmAosbYs=
X-Google-Smtp-Source: ABdhPJy8Lv+lsliAN1ayS+omTe2bPc+ObxtAunTsrOhTcISjYxvfZG4AzdV4l8Z/hw4Vo7PpUMz4+5qKSRIhXvuFsKI=
X-Received: by 2002:a25:23d4:0:b0:64d:6e1f:d309 with SMTP id
 j203-20020a2523d4000000b0064d6e1fd309mr6379219ybj.208.1652642975168; Sun, 15
 May 2022 12:29:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:510e:b0:2ad:1077:d463 with HTTP; Sun, 15 May 2022
 12:29:34 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <drwilliam48@gmail.com>
Date:   Sun, 15 May 2022 12:29:34 -0700
Message-ID: <CAFd1zB2RHA1ae9GMr0SPi-JETSzM85cTtPB3tLySEWNyJ6q81g@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drwilliam48[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drwilliam48[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
