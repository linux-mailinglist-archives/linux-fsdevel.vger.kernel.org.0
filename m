Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB0477256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhLPM5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbhLPM5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778D6C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 04:57:03 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v138so64421590ybb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=biYeWwH5pOPzMNJkloFSKISWZUVhTjLo4qMJtwrAr2s=;
        b=IWyGT8xnMvMxUvLvHbL9sBDVZ3xrOZPGGqtIdcts54iWV/rv5gaJ3XgQYDNqDd2zhI
         4N2oJ0CHkbhYC0u0TFnqEz9J0WmAEa4YuyrvvXewRVevtr/eLkLCPRFOH+3m5dAHTUFa
         CF0k4/2VLFCiToj9ChF+2zZgEpmKKP34HcLsyTJS8PrdrOEp+Ak3bpdwMOgBRg/fqAhV
         RnIoiMZ+2dDGjZOnQ7fVC69xPY582Kw45GReckrOJQUFLvT0GPwzYvo9mBGEOVoutRHm
         CM7WbaGdQO1kGVNmyahfFS2aOA2gI9Tj2Wf4f+fYqbC/Jv5RnYpHPsNSBOuXshbaUcYs
         X6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=biYeWwH5pOPzMNJkloFSKISWZUVhTjLo4qMJtwrAr2s=;
        b=ytQHsjaEUe/PSguJCfXrWHuRmgfbB3VadZpLQSBRl8npxMuajm/iUqtuRMTTFeNETI
         CP4jpJ3R3Ezj6RENod6tPx1RtaBb/vRsJvwFRXBKTjMLbaQ4O8+w4JO2Jh8Q4bn5Nsxd
         V+mOM7DeZ+2Ptza07m4gZiroLxKLvBLVuIHcVqBm69DwyAB9roJuqFLNoOLooEl5sYQz
         9T53OC1g/hB+BgwuvaZaA67T2lcW9b1CA86jXOg4q/TdUtXHRriQzkP6hFMRx9vTxNqF
         bIpFO4NT1PnXdPJGjdAZn0DxNR8xIfaTEvsoMa/ux6yAHM1Dp+ogVRdKUjeBJKZUDzhi
         uwkQ==
X-Gm-Message-State: AOAM530aMD7rVVnkl8HSFGzMj8orn1YllpBG6Npg7hJFgJckjmfJKl72
        0ln4zMcnFFO2srLD8qHPqA1jkvprwYTPd5Tf9Os=
X-Google-Smtp-Source: ABdhPJxWtjV9w6el0ReUJTBesdGj1Bpauj/5jrxJQTOfqpnTfVjy0u9QjMb5DsUd4/27Kp5krDyPVrMek8p4sXN9Tqw=
X-Received: by 2002:a5b:904:: with SMTP id a4mr12732889ybq.727.1639659422757;
 Thu, 16 Dec 2021 04:57:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:790b:b0:6e:28d:4c00 with HTTP; Thu, 16 Dec 2021
 04:57:02 -0800 (PST)
Reply-To: marvinphillip002@gmail.com
From:   marvin phillip <hellooffic685@gmail.com>
Date:   Thu, 16 Dec 2021 12:57:02 +0000
Message-ID: <CAEg9HJE-cLLv_xfYVagA=-YhPV=DXUbf-qBetieHPBdhgmPv=w@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bun=C4=83 ziua, V=C4=83 rug=C4=83m s=C4=83 fi=C8=9Bi informat c=C4=83 acest=
 e-mail care a ajuns la
c=C4=83su=C8=9Ba dvs. po=C8=99tal=C4=83 nu este o eroare, ci v-a fost adres=
at =C3=AEn mod
special pentru a fi luat =C3=AEn considerare. Am o propunere de
(7.500.000,00 USD) l=C4=83sat=C4=83 de regretatul meu client, Inginerul Car=
los,
care poart=C4=83 acela=C8=99i nume cu tine, care obi=C8=99nuia s=C4=83 lucr=
eze =C8=99i a locuit
aici, =C3=AEn Lome, Togo. R=C4=83posatul meu client =C8=99i familia au fost=
 implica=C8=9Bi
=C3=AEntr-un accident de ma=C8=99in=C4=83 care le-a luat via=C8=9Ba. . V=C4=
=83 contactez =C3=AEn
calitate de rud=C4=83 apropiat=C4=83 a defunctului, astfel =C3=AEnc=C3=A2t =
s=C4=83 pute=C8=9Bi primi
fondurile =C3=AEn cazul cererilor. Dup=C4=83 r=C4=83spunsul dvs. rapid, v=
=C4=83 voi
informa modalit=C4=83=C8=9Bile de executare a acestui leg=C4=83m=C3=A2nt, c=
ontacta=C8=9Bi-m=C4=83 pe
acest e-mail (marvinphillip002@gmail.com)
