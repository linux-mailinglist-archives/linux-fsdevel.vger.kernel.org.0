Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B051550BD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiFSPWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiFSPWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:22:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8BE6C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:22:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id p5so2350133pjt.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=m2mUyoaor2hptOGubBROFIl8t6yI7iMfoaIaDNittBM4FpDDH5RLJV+KfcHLwAy5bM
         djERaBOEczeEYnflwP5BnR3k7ckpTJxh5oAJ5RFu4bylKkyKo7IJcVajkuedc41mz6GU
         RKE4qZprlRmbVrphK+etE1b+0mJNIKM72Woz+eLLCyE27I7V3ZCzV18csJO9tkYX3Ynm
         5L6EfkCQ8FoXQSAKul6wYe9yXGDDIf8SO1A8iclASHSFGIpeIQBbip+j1TMEieO60+oH
         gQUIqh72w/A5CHcgGvtqHlDKRPoWOmpnR83wUjnlukNoLSOa06Iec6YfiQdj16qNzepr
         nb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=SlXHnyu/LqbwOmH4Ml15QfZo7U5luK4CO3rMYFB1C7ulVGmdp1rxVicrIf+uoQ+Wto
         lGT5J9siilzFebC1V11/bImvsAJ6j84Lik4arT3VYd7P1003ZmfuoE8LF58wztmFtlmo
         zlC2qGjbJw9LSmOdPb0ttRs+2NCLO337rsx8n/hhifFd72iZQPyQrf/VDLAwIHOoBPa0
         Kt+aDLHGOX7u8T3NuQVKtYK8qugBvDcK6R0FjLMl/aycPFBUbaqUjF2Fr8RrIbj5dFBz
         fl0Abl60nyO+M1Z2bw+w5qdrBnc1Qx8+FKTyduAyhN05u6IgyOZc/XgwuAxCR/qmQEYZ
         YATw==
X-Gm-Message-State: AJIora+a9aV5wxgdhGGdnB5V3nC6eSJy3pKFthsQ4HXHVa7jopVZOmNa
        bHVeeRjEA1UnjnKOwpkKBWGOsZVke+wjORZv640=
X-Google-Smtp-Source: AGRyM1ud0cPbsSJ7VM6+2QJav3qlyR0w/UYmiGF8lwbVjco5znUWfFcXgHLTOT34ufPMuzIGPs0NbFb1r16wyszXwQ8=
X-Received: by 2002:a17:90a:4544:b0:1ec:8065:b77f with SMTP id
 r4-20020a17090a454400b001ec8065b77fmr12049627pjm.164.1655652166604; Sun, 19
 Jun 2022 08:22:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: tw390032@gmail.com
Received: by 2002:a17:90b:1a90:0:0:0:0 with HTTP; Sun, 19 Jun 2022 08:22:46
 -0700 (PDT)
From:   "Dr. Tracy Williams." <drtracywilliams12@gmail.com>
Date:   Sun, 19 Jun 2022 08:22:46 -0700
X-Google-Sender-Auth: 1KjXF-hYwo69sSSo83QosOiv8Xo
Message-ID: <CAH-phouv83nxQLN7bjJDf0OtjMVeRZrYvQNP6B+8cPWCU92H3Q@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hello Dear,

how are you today,I hope you are doing great. It is my great pleasure
to contact you,I want to make a new and special friend,I hope you
don't mind. My name is Tracy Williams

from the United States, Am a french and English nationality. I will
give you pictures and more details about my self as soon as i hear
from you in my email account bellow,
Here is my email address; drtracywilliams89@gmail.com


Please send your reply to my PRIVATE  mail box.
Thanks,

Tracy Williams.
