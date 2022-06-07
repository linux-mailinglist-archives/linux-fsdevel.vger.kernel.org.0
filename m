Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8046754056E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbiFGR0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbiFGRZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:25:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A4F102756
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 10:22:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e5so2844855wma.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=FiBrJHe4O7a1jVjDC6KDblj58lHTisWp/3XyOE41fEU=;
        b=WxAEbK/c1+6rZHeXMUiyM8+nw7m8EVFY1wkTktnGOYH58Uhg5v5BisAVsouZPUlUMc
         GwkVYfBQ563bmGeNkJjJJ1Hi/EvKrBC10XnPVxTQcGBOvJam6PNPD/iZY9gncRDKm2/j
         O6EfWRrfk8VYBtEhQzCqbOIjj0BhZx6XN/YsUSWPmBCkLrI69OMidAgrMkfi3ZC3wMPH
         PLPfORbDcSqV85O0BHj2CoxA+0MOc+cH8lbH3bfgWT8uM7FcxCxya0tgIGjoxjb3MLAB
         uZyWsbJLNNs/Vc74iFqzJEUqfiYU0hqt839tT2PZ6pHvuEBgcuG8GC94rXmHj4tiraRr
         kyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=FiBrJHe4O7a1jVjDC6KDblj58lHTisWp/3XyOE41fEU=;
        b=VOHjvav/0n/XPm02gQDHt543ehzV0ShRONW5jP8t2Aai+UpkhAlQky5K7+d4a2VmTU
         56j3+xNUT3I+b4uzq9BbH7Jw7nX9RTk4bEPMpFkJtgavP1ikx/AlQJ/S9WUrB/FSn6r6
         HvP5yiPXlAakmb00eQl8DenyDxMDOcGNb2ELO6HvrjHmt3EZ9IA+L8OXwfSQHX/0oTeZ
         6SV54O3RDVsedAKM2b487tQLsjwmFB69oBTTA82kE4qFGhZfh8W6k5Noa2zlZNG2+BLo
         WPq9SAU6LKck5SCe9R/8Shl/yzwOmZcVLaEvVUzAPH67oYOItz0UCaCul4NQp7eNv66e
         UozA==
X-Gm-Message-State: AOAM5317/rsZCa2t5yJJuhe2MdXcMhYUlfwaIbxiNbG3wcAtYI7jOW9I
        iuh4unrH1MZnhgQVr0Q+yx8SQyD4qh2Zhj+o5Aw=
X-Google-Smtp-Source: ABdhPJy4rVC6QAelmiTBt2HGG+UwGSzM83jZnY0bpExX9vxwprg6VorUO+DhGo7tdNB41of58cspjdAvRjGjb4dqGEM=
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id
 p186-20020a1c29c3000000b003509797b38fmr59763148wmp.22.1654622570329; Tue, 07
 Jun 2022 10:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c44c:0:0:0:0:0 with HTTP; Tue, 7 Jun 2022 10:22:49 -0700 (PDT)
Reply-To: u022957@gmail.com
From:   Janeth Utuah <seynaboudiouf755@gmail.com>
Date:   Tue, 7 Jun 2022 18:22:49 +0100
Message-ID: <CAJLqW3NyF8SCxhkHE2XeQ2icH5O_kh+3sPRabM_xafYjv-U0fA@mail.gmail.com>
Subject: Greetings from Janeth !!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Greetings!!

I am Janeth Utuah.

I need your support to relocate and invest in your country.
I ask for your help because I don't have knowledge about business and
the rules that guide your country for a safe investment.

Will you promise to be sincere with me?

Please contact me for more details!

Kind regards,
Janeth
