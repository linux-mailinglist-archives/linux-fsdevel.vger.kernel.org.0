Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1580582783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiG0NTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiG0NTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:19:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39622F64B
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 06:19:18 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 123so7362174ybv.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=RZpiTMpnH4XUmv9EttExEMtOs4Z+fLR+9hkxhxV6ABn8mNQ7IUvDZh+w7tj5JlkUqJ
         iInXDZWiegJsBoBUUWlZAx6HIW1A8ltOJCZtXatZti/xIUFVDZKXQ0Xj8UPxVRhC2zg7
         q2oY6O4lep3ww5++7EIwNUZ4KENqPA/3P1rY/++m7Zc7qmuR0vnqLw5pczVCnPffwl+9
         PYf3vq38AbUKQrGLXSugO3sAvW0ONZJa0u5TBe85QrhpwJs6RA/VQCWBWfdb+/eCOK62
         Hc9WERYUZP4WvAR2DZaUn1GAKJm0SFoBlcasBkpKp0KTzqe32wXOuHKrSDD51o0YCHjT
         Oi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=Si/pun0CZcRNNBsFAajjYEICtz6ak4HABsdHlsnvo8OuUSJiCM5n/urF36g8K34V96
         HigOglyzvDlQT2UlubOFnuJTIgVmsZeGMpPcdURyTX1mxVfxgf4oHFuADT94Ug4lq5U9
         +sIqKjaBTYJ9NxTkZjI7gqe+e38H0wgMkXg+mTxWYwcufB5WF2J1UhQarYkQbogGKKAd
         YC+JofYcRCNoIpb9OeTrhEDK776SiIKwcg8MeTlhw1ZgE07YKcGvixK787riYvUs2zmk
         mPS4pJ9UfzdOG6yVUYfsgblQP+CIp4IgT29XScE1cJ6X62uGuquFgNTL8YcdONlydSCf
         SZHQ==
X-Gm-Message-State: AJIora/rMsoox44o9XKTmzgOMNF8vqi0wgyG6FjKPxVwSJCkadOH+07D
        XAo/jlM0N8GGx7NgTuPeZTeYoz9G9n9UNOxi8zo=
X-Google-Smtp-Source: AGRyM1t7Xky3BR1H+BurpZVXsDLUycdhXWNB5ImCY7+tsr3A3oibrCfqVJTdlicHFP8WqhQvrTXufjuH4C9OUjYjQ+s=
X-Received: by 2002:a25:3444:0:b0:671:7a0c:a119 with SMTP id
 b65-20020a253444000000b006717a0ca119mr4981784yba.146.1658927958191; Wed, 27
 Jul 2022 06:19:18 -0700 (PDT)
MIME-Version: 1.0
Sender: gonibulama424@gmail.com
Received: by 2002:a05:7108:4341:0:0:0:0 with HTTP; Wed, 27 Jul 2022 06:19:17
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Wed, 27 Jul 2022 06:19:17 -0700
X-Google-Sender-Auth: ysY-XLsypI1H6CNjHlRfcs4faKM
Message-ID: <CAG_A1pwjVt067r_dgEP8309+pzoVFaqs5hXq4Qzeo4zaRsHJRw@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Margaret Christopher
