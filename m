Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A375AB66C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIBQYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiIBQYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:24:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236FC0B7C
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 09:24:12 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3378303138bso21184907b3.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Sep 2022 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=Z+Xp8bM+Tc5Cb//1+J/3WiluH1x+V94WeK/DDQE/0Gzhaz4CaJyi7fUlneLsoZiYTA
         GIJtFzw+gEwfLK9UxXf2P4bp0PK5BXx84BLtjLXeQ/yeYHp/pQmBS3/wpg4yLVuXSQE7
         j4CcnwBNzXisqHb7cYAN+en4GLEewnpCEkLpOpO3mf5YIaQ94y8t/ucf7ZlGjc7u+cF5
         UIM5zFBRymzhc7hCwbRbq6ACtPVQEREDo+7Sj5yXa9d+6gSWM+UMpVwYx//73JPTe/c6
         o7yZ77zLmQipDXl4N2IQP6MG1of3+eNvt+yUiFJKl7nyFgG5EDf2k/KnEDfy+gIrK6Q0
         kcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=AGIh5SqxwsnbIHpE3XKSnR4m6/+vMrwVzvqGZ2+l3bysm7sBYsPnTc6gHUmJ2r2NjU
         egqqpMSlH5QfOy8B5ibTAWVWZPjcoldFMhWMK05j0fDHgqXhncdMC6Mp+T9do6sfqv7o
         8ozsSRYV4hJbcCvvOsF8KOepOVOJ5pcVX8mk3pTNJdJDiwKPrZLXTs19jqDJJFIcdZJ+
         0G/rIrmAQhasN48lyMrEP8sHAgbq3xXzcUZQGeQClMyh6ZLzj6JzG8dH5OJ/8nRBnjEb
         JOoflRZbZ7MilHh6O6jHpaK9RjvFgkI6jfwJzmzj1AN9LdseAeSBNcuxMf9ILRMv06/7
         HT1Q==
X-Gm-Message-State: ACgBeo0Q2dAHnuNFWD7dZTrdy1q+MLgqXnNqPBvYZlTytCGzoPXOQ+5c
        rEDziCoqOY40ONdUV09tgqwP9XQYldHraZV7Yr8=
X-Google-Smtp-Source: AA6agR5Ro+PGHtweeejaNtgoqCmvKSqeaTp7jaP5TE88BgXs6b0E5xPsLIvtNM2UCDIqGffvPbmFyh8Mii6O3kH2xBk=
X-Received: by 2002:a81:598b:0:b0:33d:d632:312a with SMTP id
 n133-20020a81598b000000b0033dd632312amr27935494ywb.501.1662135851209; Fri, 02
 Sep 2022 09:24:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6919:4381:b0:d9:7890:eac1 with HTTP; Fri, 2 Sep 2022
 09:24:10 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle <michellegood044@gmail.com>
Date:   Fri, 2 Sep 2022 16:24:10 +0000
Message-ID: <CAJ5e1jb1fK26zn57x=8meG=WpWP3ZY_1JqSZjoB0Nz+XA+eRgA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7464]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegood044[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegood044[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
