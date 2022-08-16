Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB28595A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiHPLtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiHPLtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:49:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A72219
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 04:23:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c2so555617plo.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=eng/60HOJm3cMZBAfSieZjPR5rs1cyF92HglfPz2FRA=;
        b=E9XKdrntiAlXHPN4uEUNhNGeF7wrtzyo+MAv2Fkqq1NPpLZAy++bP8DyiWgpnxqIUW
         8GVCbTWL64dtIpjcJRGu7IDYhNqe+ViKfnovfOLBuq27OJjLZ9qLfyXkftJgRjFJ7JMS
         7OKF/k1bofVSx4CIHrECfzeqY/IoMNCPCqwhCXDWCFtT+PXuS/gqI9DLsgVhIgp/4Jhm
         QNXRFy+37mY9j/x/rUua5jj1/zqfU0RcG7nCJqly+zlxyQMNp59s7mB+XP2jBI5ozBNs
         T3qFZ1shTeHsgoKR+TyQhMTPmUHKAGUbAPBO6OMI39Xel+MVd8zGDWnn9DRGZIRw1dAR
         1M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=eng/60HOJm3cMZBAfSieZjPR5rs1cyF92HglfPz2FRA=;
        b=DLPpoCV3tYHKJ/+DfwAyYFCFsKYkJu9K1RQdJLe0NAUVEz6tMNjL9Cgwlm/BAfU+ep
         /dB0LK65TMIOZiz11ZX8RtjkKG3KsrkolPCZsV2t9lBIXVsHcesRrd49STNDBI+Bm1OH
         88tQqfGIXPACmBkGgyGM59NK14dMnKzzzbDU9hIkDAQBsKtqqyH9jteXRD3kH+cS/arz
         eH7HsrZxxa3S8cZcE6Ok/tHrjDrUz/+nfXVQX5oJhip6VMF4BltkhvyRccYaFpDS/MuM
         fcJXlJs3sX+1G1VfAHf6d9gZKDzZ5rjieiECyVcsEaFcZixVH9ZcoZyf6q2/elkhEGsd
         fHaA==
X-Gm-Message-State: ACgBeo1VmSv5Z60QcznCk7vhBahdjgXN0tfAoTLarf8vtKlGYj69tYKJ
        UYXvUXUruQwn+FumG1mUlvtNGjH/sCPK1D7k6B8=
X-Google-Smtp-Source: AA6agR4kiLvI1gV0HpchFlPXjdqDK4HCNN42pdECQvG50QA65o9yMleCnctbAhpq1XYuCrMYSJTr3Bt5bgLZ4o4Gk3Q=
X-Received: by 2002:a17:902:e748:b0:16f:953e:2770 with SMTP id
 p8-20020a170902e74800b0016f953e2770mr21243490plf.156.1660649009608; Tue, 16
 Aug 2022 04:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:a823:b0:8d:b87e:6cd8 with HTTP; Tue, 16 Aug 2022
 04:23:28 -0700 (PDT)
Reply-To: olgabohuslav@gmail.com
From:   Olga Bohuslav <drkenhas1@gmail.com>
Date:   Tue, 16 Aug 2022 13:23:28 +0200
Message-ID: <CAEMrevpaif1GwbE86K5XWPUt5zsXhaa1wEdA_1SWEJUAv4N+dA@mail.gmail.com>
Subject: Letter of Intent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A  CRY FROM UKRAINE & PLEASE READ!


I am writing to you because I need you to help me secure the remaining
of my family's life savings kept by my late husband outside Ukraine
for charity work.

As you know, our country has been in an endless war with Russia for
months now. I lost my husband, children and sisters to this war. All I
have left is my family's life savings kept by my late husband  outside
Ukraine which I am pleading to you in order for you to use it to
establish charity work in any country of your choice.


I have also lost all money and properties my husband and I acquired
over the years, except the money I mentioned above. As I am old and
weak, I want you to help me receive this savings and use 60% of it to
establish charity work while you keep 40% for your self.

I am weak and old and presently in an hospital, I am diagnosed with
Traumatic Brain Injury (TBI) as a result of gun shot and I have
contracted COVID-19..

I really need your help to establish charity work as the hospital
management has confirmed to me that I have limited time to spend here
on earth and as such, I have decided to give back to the society,
service to humanity which is the best work of life.

In your Interest, get back to me in order for me to direct you to the
bank where my family's funds are deposited.

Please pray that almighty God will accept my soul in peace whenever I
depart this sorrowful world.

May God guide and protect Ukraine and bless us all!

Kind regards,
Olga Bohuslav.
