Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F515BBDF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIRNR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRNR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:17:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33091EAE2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 06:17:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t65so24526274pgt.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Df3F7i2pCzvH2h8KfKMYPo8SteGe8NAjeHDx3E/0m5I=;
        b=cMi+Gseq053XXDWcoCoirNdKHdCQ72N+7Ve0mImUknalWL/hvpjza3FEfAsSC45ZTq
         PSVedXvcAaxZD+tiRfHJaPhf0xvg+e1GS4BHADk07nYLI9Lkq6YwZCSE1PXenmUnNn5+
         JQTHd13JSUd/7bs8//TaTcNenqaPgQO0HNVGiw7vOZUmDlwOnVwTCIGcaxBhhJfTF2vc
         Km4ikdMPM05u01Q1GOlzGZpFZw8YMLfCvqkToYxJZe6MoCG7LaT+amYD0NnbkxMMq3Oj
         XCeZsLwJOoU2uFxylOU/pDTVW5JpgVqDJZK/ocK9GNM8xeEUnZ815JiM9r5f0uwKH9gk
         uXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Df3F7i2pCzvH2h8KfKMYPo8SteGe8NAjeHDx3E/0m5I=;
        b=Jpi+vPCoM5wimpnJq9DmeXZv3PkFujOsEbKvmtUVE/vcVx9PRtPfJ83ky2eqHci160
         7STC2hUu8+EvGJ7TUHDu1ExE4740Nh02fiH+X2SeA5ycyaxIMdp05ai5wXI9AyJDHXOQ
         HLPq+NoO5E9c6vJGpJVylg8mnKL+JfMo4Y2toPXZ0eBjlulF1P1A9Vw3le+dLStnKxkT
         kasym+3E2ukX16dTv92/jzW3LYr+vQg+Z78SEqJtIGerVYUt6qNKQcAZIi2HJ1h9FyLv
         mvRZP7+wP9ebLKoroSozW0QZD0pmpSF1aQn+TNmUeEGbzG6LbhkiSaP2FAm2C9CqY9nZ
         6/Fw==
X-Gm-Message-State: ACrzQf01BsYhoGjSLUWmM1bYXfSrahAz7LDwmP+GYVG1vj8sQMTMLrQV
        agbktuxfbY/YtqgX+gRH6bbb46FFjjGn4NBhCIQsCMP90g==
X-Google-Smtp-Source: AMsMyM7xBdfLKkfop7mEgOyd8wRs16sopaMsi+dO4IQqqM3XuFGLmhW56Hg7Y1giorX3zHFmyfl4pGEjRApL10wdrCU=
X-Received: by 2002:a63:1a1f:0:b0:438:d11b:e23d with SMTP id
 a31-20020a631a1f000000b00438d11be23dmr11535828pga.335.1663507045396; Sun, 18
 Sep 2022 06:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com> <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
 <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com> <Yx/iGX+xGdqlnH73@ZenIV> <CAJfpegs=H+mUw1BeVnpSxtUeRGnjza-+0=uXxN2KRpvZESXTAA@mail.gmail.com>
In-Reply-To: <CAJfpegs=H+mUw1BeVnpSxtUeRGnjza-+0=uXxN2KRpvZESXTAA@mail.gmail.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Sun, 18 Sep 2022 15:17:14 +0200
Message-ID: <CANXojcwi5X4SC9Pvsh2Jw8Pwj4BS0ews=3x=jfO_Vg-Dr3f+zA@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Yu-li Lin <yulilin@google.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

for your information, as developer of a FUSE filesystem using the SFTP
protocol (over SSH) there is an extension :

https://datatracker.ietf.org/doc/html/draft-ietf-secsh-filexfer-extensions-00#section-8

to create and get the temporary folder on the server.

Maybe it's useful.

Stef Bon
https://github.com/stefbon/OSNS
https://osns.net/
