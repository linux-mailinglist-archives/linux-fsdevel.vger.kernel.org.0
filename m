Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD51482780
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiAAMGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jan 2022 07:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiAAMGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jan 2022 07:06:36 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE5C061574
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jan 2022 04:06:36 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so10458609pji.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jan 2022 04:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=qbXiuBK9xbw8ycQAfb3pBZco+paIdXWnVvlVvcx0BCxODY4IJXCjijvfcrADa8/dix
         JTE3yhoAF/+uOK5++6XnPHmDURc7XjyM4OxWxtTIP+STgJLDfX/XDVxbhHcqCtMSMbbL
         BFZbF0zGcje0BRVD+ItZvG6so5WDgkdBqFN6IdUnkAzFp0Sw1NL4u1nfjKv5Jxjr3k1u
         AnP2kuADSBNZciWatbGfC+XtEMv0hLkkDB8QhqGCecvFxyejmhnlvLwyFu/XgDeHnlyM
         QrjV/GO+MZEz3wbCK9j298t20r7SXFfLQXVV6Xa4lGV0Xp7B4mCOgWqWM4Zx+105W6Lm
         FWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=ChPTZ7h5QnBH/bN+xu9FKw7tHDIM8xyOM5QUtg8fMj48+2H55BoOIgtD+F/b6oKCZs
         B8ZpBscX3L8GZQfbSaUdXWTH+P+iIW3AE9mTmVtXO6tEt/E+3Y8O732WihoejvbTxgiz
         pIZFhZ5ZM+iBClN5ImZzGSLjbLFNqAI9YUbI4DexSTjYOupysRk6rrDX5pKI+0hAsRy6
         fEaNIgIF2KW4DRQLb+AQ0L8Fo1BnK48Kuj57pEx24+UBj0pkAO7ltl1PIT0YYBVF4eiJ
         CJaUhGEqiurah8axXYBxtwHy9uyUBRPe4fJp0UiA7M2u2mrxAbvnS4Zcc5oHooxlx/96
         RUlQ==
X-Gm-Message-State: AOAM530OqMbKRYa6NfjN0iws+Cj4AHMl0Sr386p08oah1EIlwCY3kQgP
        mkKOvl1iNoSeA3iXVuz6WYc=
X-Google-Smtp-Source: ABdhPJyuTBvfcMzh8WKos9chgac93y1p++ixKiKsXUWLyB4JcH4GhSZmqc/zTl7nXXmeGjQ99q7twg==
X-Received: by 2002:a17:902:b944:b0:148:be4b:66dd with SMTP id h4-20020a170902b94400b00148be4b66ddmr38370554pls.63.1641038796201;
        Sat, 01 Jan 2022 04:06:36 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id kb1sm33652672pjb.45.2022.01.01.04.06.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:06:35 -0800 (PST)
Message-ID: <61d043cb.1c69fb81.e9f32.a180@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:06:19 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

