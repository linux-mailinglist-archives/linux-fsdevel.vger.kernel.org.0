Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5924444931
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCT6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCT6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:58:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57AC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 12:55:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g184so3308633pgc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Nov 2021 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4vUof8fUQpZayqZUZwKxDEJwhK3uZOTyNtJzrd1K0WM=;
        b=ZqKGHc4PTxrFqRTG1w4sL4HZUwwyoM1w5ttGbGAp+/JQMT+/r3+OPPXxjgrDsCHY98
         6BEgB9gbkM86AemhNMlTWOAT5dyExwPfABSlQ9l7R5Eywq/r1iuTsKzPx4ozCRF2PPLh
         sTtgcSpZbWEWdquCUgqiSpaWffgbIQymxQ0yV9WK2syDefBo2Io3zFSThjM7e3tFbwu2
         jZHrEH8Ue7J/BfIJaJxYdN5JpLZL/QZwwnyTqymkKQi1Zc4m3U+c9Pd4BnXJ2I/9m+rf
         uusMhh3sv1fkirqSR+DiQzK/0QDFzmaJQHgPtxuit4wEtuzIfRNhWI2395+T5JWq5+Gy
         7l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4vUof8fUQpZayqZUZwKxDEJwhK3uZOTyNtJzrd1K0WM=;
        b=PODYwoYvqMbnTPWjo75sv3Lzkf3GaMt84HtdPPypccoeC4RZLUwcQu8H5oT5gv9TGX
         aPyeFvyVlfpgaQmMwP7Lb+cXFLpBqDbusEY//j5CGbItARNc4hVMzN2USkxoCCfX/NHR
         UrtrJKnlErJlj6Y0/cdGA8N9azBtdzwc+8solNnnbatRv3vcpjKVzezZIYZ/UJYrSywG
         jA2QAVvJqm3uLc9JvbH2XAIW/xGEXMYlyMh4vuBFiO54h4FjRXXJE/jFUUJ0AQJUoy8Y
         p17zdk9/f9ImvA4xrE9C1Be3Zx05xoThgtrAaGvrGI3Yv/Vzrpru3sj5c9U4+Mhximap
         9O7A==
X-Gm-Message-State: AOAM532UF07eyQb3sTho/hg8FBkId9/4K1E6NQXMT8sqTou9MY1qAS9t
        JDmoAJTDRxBG18zqTaxikWXMYFtKNvkyXUnCgW4=
X-Google-Smtp-Source: ABdhPJz3tDR4pyVHgakSsAfh2nkoxpghs+JZTM3EPAyLhuEN6uXrsKZiw0ghrjpv1Vc+/Y/0nQQmeERBh9E3nvSJVTU=
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id
 s4-20020a056a00194400b00438d0026e35mr47111714pfk.20.1635969341407; Wed, 03
 Nov 2021 12:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fd88:0:0:0:0 with HTTP; Wed, 3 Nov 2021 12:55:40
 -0700 (PDT)
Reply-To: greogebrown@gmail.com
From:   george brown <eddywilliam0002@gmail.com>
Date:   Wed, 3 Nov 2021 20:55:40 +0100
Message-ID: <CAP8Jzx+rbsacADCicfN75s5dBz6kxx-zvY-S+JLG-KWVoaCuGg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hallo

Mein Name ist George Brown. Ich bin von Beruf Rechtsanwalt. Ich m=C3=B6chte
dir anbieten
der n=C3=A4chste Angeh=C3=B6rige meines Klienten. Sie erben die Summe von (=
8,5
Millionen US-Dollar)
Dollar, die mein Mandant vor seinem Tod auf der Bank hinterlie=C3=9F.

Mein Mandant ist ein B=C3=BCrger Ihres Landes, der mit seiner Frau bei
einem Autounfall gestorben ist
und einziger Sohn. Ich habe Anspruch auf 50% des Gesamtfonds, w=C3=A4hrend
50% dies tun werden
sein f=C3=BCr dich.
Bitte kontaktieren Sie meine private E-Mail hier f=C3=BCr weitere
Details:greogebrown@gmail.com

Vielen Dank im Voraus,
Herr George Brown,
