Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9B4CE36B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiCEHcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 02:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEHcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:32:12 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5B31527
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 23:31:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g1so21241473ybe.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 23:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=fItAEaeQIUtMzn4Yl8LE4cca/bBHs/8pponZDSptgoiGm1/Y6L2y3ptRoKaYT3JLTQ
         f7tJ7/XcykpyiFUH4c/K5VICO3vqaOgiM2YdoO+KRR2whro5+uIh/CCI/7IMLp8Bc3xf
         SDkfoYac3/5CnKR93bmI6Fsx2js7jfJdg08NCID8jFi0YxbGgRjOQVGdWnnpKYPFvL46
         42FoUGgi5NpdEA60/aKczUjUu82WlN72hLgXXTXB3w4yDAF0W45AJV9NkpQyBx1jvM31
         altSXMWKRTGFhNclAOCWSc+RWK8g3nOaSxFxD8jacefOjDwbndZwMOz7ZCqzA04Gt3fk
         O6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=rAblQiv04wPK8X69KYmcntRrQB0uSbH6TJXQxoNnl0vsDUkvPOn7QhDiujw9Y6y8kp
         Cu9jSVqLORgrXLt4ALSO9xsFvi6fHw63chl6JSy9Flp4hq4UTJqeWtRpntrwwHWR976o
         gZpFX+rDCezRksoJXMzS+jAdopyo8kq+kxZnBw/aiIhEsrkN1TaeeUZsVX/eVNsXJtS5
         i5/75kzT5pQTPoo/Pz6k2KyMdp6Dx9V481XjxHxmQRQZK3sDoYzJ1glTiVlPNEf39si9
         jsMow0Y9yocfqoxsou/sEdL9DFspEbjKFkm2Q1HxgBAihVkE1jRgk9giXVkRdszyYNSN
         RIag==
X-Gm-Message-State: AOAM530tZBJlzDqie+pVV9FCyoR4+mFJAVTWp3V2I8ctPzUkTXXm8koK
        X9WORdPTiI3BCJNmb2LQOK8rz7kPayOKL2GuZws=
X-Google-Smtp-Source: ABdhPJxiFsqQoF+ZtIW9wzAIPSsA7FVtkzYNrfa+yoYyq1EiZ3aVJmuNzJUV8TBJ77g/QbZR1citZMak1jaVgNtRot0=
X-Received: by 2002:a25:32d4:0:b0:628:9974:3baf with SMTP id
 y203-20020a2532d4000000b0062899743bafmr1600185yby.497.1646465481839; Fri, 04
 Mar 2022 23:31:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:738a:b0:210:6fe6:62e1 with HTTP; Fri, 4 Mar 2022
 23:31:21 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Fri, 4 Mar 2022 23:31:21 -0800
Message-ID: <CABo=7A1+yiT8NvSP8yeNiA5e-oFWw7Db_R=GZr22Sg5eh=oLWg@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2d listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1311]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gracebanneth[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
