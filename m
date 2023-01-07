Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDF660B3B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjAGBFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 20:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjAGBFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:05:02 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0387FEF0
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 17:05:02 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1442977d77dso3419728fac.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 17:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=WvKLBx7AVzFxUsuv4R0DwQXxkopPeR1FT9N7l0q0Pkqa6TXLrCNwAMskfkrP5x5Oh2
         2r4R5X/61efablIwSBQqxcaL5xQiVhtFm8maKK9/Cd8nPRhtC0rYmajcspiIazjiCtlz
         w1zIgKNc1qSvj4R5JyhsjW/tMz8g0B91R23shgdvxVzwvi5bwNLvSBovkySdqB/qo3f4
         dMlC+x2dY7HruNQABKCaE3XPdAjB1ffK75hAbdRNhHhTgOJqNFDkArDyKS/6vAlea6xR
         yGqRv2nrG/4HJgc6UOmxMQWVchECacUme0d7Pck7vSOj7f/Uefy0nsnJnDnWJKDRwxie
         vjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=aKBGKmOaqpm03cxl9LxJutdxP9Sf2GcF/gkP95NSx93lbYusLlVxrv0aI8jt9aNaTM
         lMhe3/sLIpZ99Yn5AePJqHQ+ybG5tTnFrvkSloIrBGe4P54RzTXXgutlTZXMJHNnKmtv
         WXiQQuTFkB9yDadagROxbbNCg0xnKgrRY4LRCMjc0hnOSWUByoTI7OrH5dsl5gEE+aeA
         qbGdOVfdhvW4nk74TrvSod6MWRL9fzjmWGeQPB+ZZtX80+AylgnfRezk3dGNK9DDibQp
         X/EQdSfARa2RA1WDvxK3cSY5wygLBudJ4sa1cNo1rTdyVO6Ir3YeKrqVIL3OCL5qV5az
         5Z1w==
X-Gm-Message-State: AFqh2ko04PacstwrTrI3pXSqu1duZnH2nENWvs/3t9kjhqm/J6xzOmAq
        Avbvt9jUivpW5Ti6OHn87FmroXUtZpdkWAKTM38=
X-Google-Smtp-Source: AMrXdXvpEzK3qQemSxHdD4xyNuT+vFwJbYlXzYeVGrRy19RGajxI5CrwqZbeolu6RxsjHj6oPWRqAXGxRULsKQtUOe8=
X-Received: by 2002:a05:6870:4b8d:b0:14f:d35e:b7fa with SMTP id
 lx13-20020a0568704b8d00b0014fd35eb7famr3510167oab.222.1673053501267; Fri, 06
 Jan 2023 17:05:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:05:00
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:05:00 -0800
Message-ID: <CAOD2y7kdejVAqX4V3T8feMPjid3jTUewcfeAR5-g=p3HmphfKQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
