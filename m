Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD01482742
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiAAKaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jan 2022 05:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jan 2022 05:30:07 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B81C061574
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jan 2022 02:30:07 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so32765927pjj.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jan 2022 02:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=XWTEnZRAXJCRrgksKYPhGSmbfO2KWtZTSQkrfWg4A7+43F1HCgScFIwHqkWojtgEgK
         2ZucgTv9uJ++qe9OrjROp2NvTMbHIw04ZchSPWZWpIXLp2z4UPduPgSWaIY4wTqiPk5/
         8Sy+sRjNVnhXntslBnMqetYyZjBfUrttjuEcnMTePIzX4Oo1lp6ULLNo8GrBnl63/AyZ
         p8OXu97CZjk2cmUKP5orHnpeIjr13BsBMNJQ455xvRzmpgBiofw6tW4ys2etEoN0N4AY
         vvB4Zvoi5qOiTEFdEKwuupdzgJsrmSr65ppyK1lmA9QFHzm+UGd28wG7y/qD6UAB03cZ
         I0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=vRCs0xuaqVfFZDFXfE1l0A0F/dK/64mFvh+PiU9CtlrZojPpw9l3j7uyY7ZFR8Gl2g
         5FZWDh/oyBBp2fnX2KVGXegJtgnjtoxDuGcrsyPkbj/qodMKwMvJ/Ez65bXXxqmtAV2Y
         XBc+64dYRA0aPft0zIxPxOn2y7wzijgoYIaR/Rqj9Vtskn35Zy8lu3TWgSq45wUi/vQQ
         USys+UuKMiJRtMOa8Chl171cZITDIi60q0aBd7jDD8iY/P9v0tjijrnhVmIGgkMWk9bR
         0iBocRMZMHwk8tyODatrYNN7uZSMbhCKrutm288L9Uh9EISg5n+H7vvs8qgenpHGomGB
         /T7w==
X-Gm-Message-State: AOAM530fJ9fvEMKI7gey3GCKrt0ZiMVJ0eKrtHPQ6cyWrP/W/oAr44DP
        yfjZQ++xG5ak5yrWU/rUGUSHDOry4RIy+5CP
X-Google-Smtp-Source: ABdhPJz2k8LcT8fmQmrIk//H8cpVDSgcG9ET0Is/MjYt359534Rm668MKHNRKFjOiRsKJcaeIocWfg==
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id c8-20020a170902b68800b00149a1d6c731mr12692867pls.145.1641033007348;
        Sat, 01 Jan 2022 02:30:07 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id u2sm30175378pjc.23.2022.01.01.02.29.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:30:07 -0800 (PST)
Message-ID: <61d02d2f.1c69fb81.e8593.2bf1@mx.google.com>
From:   vipiolpeace@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:29:51 +0200
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

