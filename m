Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20348769F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347147AbiAGLhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 06:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiAGLhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:37:24 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8DC0611FD
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 03:37:23 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id c10so3470601vkn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jan 2022 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IUJi736R0fM5QA8g0ZKaoRCbopQfasktyrrBv4+8QM0=;
        b=ArtkHmHS3sjdrR5xR5owDb9E7e/NgSHbaFg2qtDGKfOY3H93jCtKV/wcMP/R0Vn9wA
         zp8z5CaaM21E9sDAHy5Ik1DZmh2HwznhD/BMjQZ+jjm2RO0+G2vB6jg6Omhhxj04G2q6
         4MUpwb93GWHcFXfu5HQoXwccVMuQm+HX4ZUPrr35BVEcLuRRHp6X1ULa5JKVkfCl5CCH
         TdHqZ9yj1Sw2ub7wl0VbNziuLWCLaqm+iuYQSZBJQP3m4SGPbZEUPX4MCkbgdDZP/y1u
         fT9aXGQFrg+jIucHxNg2XR64xYtTbHvHczLeaw5hocZ0MRSA+ooeajPX/s8Po99Lv3PO
         DQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IUJi736R0fM5QA8g0ZKaoRCbopQfasktyrrBv4+8QM0=;
        b=nSI1p5siAcnjYYGxmv+xNrEyPjqGQ8vuMvtpGuu8FzpS8RH3m8eg2C3y6do+pidmvp
         R3dmC2GXVVThbpDB2f5EX9gh3UvVPKPJ+SXCsCiygZoOZS2/bretXGWYXU0Vq1u/R3t8
         bSC7ZpnMbEDBYAQeARPVFfGSt8KwMKjvDnPssnuEX3EgE0zFScdonI0U3xTAXdwgCY0Y
         17+YnauSq3hNPV5qEdkF26dPh9xCCJEaUlr4ZthoYHL1R89IhCFWmQJE/UAFrhOayWzj
         Y5rU4jT55CTDJXoHiAYLelTP+vr54lNxsS9GnbZNIXgIxsZ1tEVHMO5oc1Ct4iB2lNeV
         ANrQ==
X-Gm-Message-State: AOAM530h4pa9G2GjFX6TM4hutepOI4P39gK1GKHaKbCa+XBq9RJQuPoe
        LJvoxnGBcaFP3j6Sfinr1AQNq4S4/t8fOoJxxuk=
X-Google-Smtp-Source: ABdhPJwWqHsOmArASXlQUF3OWj0Vpm5oPnIlVdZpZclcwPMXHVhBCEKnMiURDrMH31o+nDhGHPdIJFWq2/USq8WOFTQ=
X-Received: by 2002:a1f:2bc7:: with SMTP id r190mr4254586vkr.0.1641555442712;
 Fri, 07 Jan 2022 03:37:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:e8ce:0:0:0:0:0 with HTTP; Fri, 7 Jan 2022 03:37:22 -0800 (PST)
Reply-To: kodjikokou09@gmail.com
From:   kodji kokou <abrahammusa31@gmail.com>
Date:   Fri, 7 Jan 2022 11:37:22 +0000
Message-ID: <CADKVqRvfyQ2TxgOD+GwEqSkxDs5WdEwxw3YP3Rd+5084eii-4A@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Szanowny Beneficjentu,


We wsp=C3=B3=C5=82pracy z mi=C4=99dzynarodowym funduszem walutowym, fundusz=
em Union
Togolaise de Banque & Kuwait na rzecz rozwoju gospodarczego kraj=C3=B3w
arabskich oraz organizacj=C4=85 Narod=C3=B3w Zjednoczonych (ONZ) Katar Char=
ity,
niniejszym oficjalnie powiadamiamy Pa=C5=84stwa o wyp=C5=82acie spadku.

Otrzymujesz nagrod=C4=99 i prawo do otrzymania kwoty (350 000 USD) z
funduszu Kuwejtu na rzecz rozwoju gospodarczego kraj=C3=B3w arabskich i
organizacji charytatywnej Qatar Charity we wsp=C3=B3=C5=82pracy z Union
Togolaise de Banque.

Po dok=C5=82adnych badaniach i =C5=9Bledztwach dotycz=C4=85cych os=C3=B3b, =
kt=C3=B3re maj=C4=85
otrzyma=C4=87 spadek z programu Kuwejcki Fundusz na rzecz Arabskiego
Rozwoju Gospodarczego, odkryli=C5=9Bmy, =C5=BCe jeste=C5=9B w to zaanga=C5=
=BCowany, a Tw=C3=B3j
adres e-mail zosta=C5=82 wybrany spo=C5=9Br=C3=B3d tych, kt=C3=B3rzy nie ot=
rzymali jeszcze
p=C5=82atno=C5=9Bci spadkowej.

Dlatego w=C5=82a=C5=9Bnie teraz korzystamy z tej okazji, aby oficjalnie
poinformowa=C4=87 Ci=C4=99, =C5=BCe Twoja p=C5=82atno=C5=9B=C4=87/=C5=9Brod=
ek o warto=C5=9Bci (350 000 USD)
zosta=C5=82 zatwierdzony, podpisany i zwolniony do natychmiastowego
przelewu.

Ten fundusz/p=C5=82atno=C5=9B=C4=87 jest dla Ciebie dziedzictwem za bycie w=
=C5=9Br=C3=B3d beneficjent=C3=B3w.

Jest sponsorowany i inicjowany przez Qatar Charity, MFW i Kuwait Fund
for Arab Economic Development oraz Bank =C5=9Awiatowy i Union Togolaise de
Banque. Stan Kuwejtu utrzymuje r=C3=B3wnie=C5=BC swoje wsparcie i wk=C5=82a=
d do
zasob=C3=B3w innych mi=C4=99dzynarodowych instytucji rozwojowych, takich ja=
k
Arab Fundusz na rzecz rozwoju gospodarczego i spo=C5=82ecznego, afryka=C5=
=84ski
bank rozwoju, mi=C4=99dzynarodowy fundusz Qatar Charity oraz mi=C4=99dzynar=
odowe
stowarzyszenie na rzecz rozwoju za po=C5=9Brednictwem funduszu kuwejckiego.


Kiedy odkryjemy i zauwa=C5=BCymy, =C5=BCe nie otrzyma=C5=82e=C5=9B jeszcze =
swojego
funduszu spadkowego, zalecamy skontaktowanie si=C4=99 z nami w sprawie
p=C5=82atno=C5=9Bci w celu natychmiastowego =C5=BC=C4=85dania p=C5=82atno=
=C5=9Bci.

skontaktuj si=C4=99 ze mn=C4=85 na ten e-mail (kodjikokou09@gmail.com)


Z powa=C5=BCaniem,
Z powa=C5=BCaniem,
kodji kokou
Union Togolaise de Banque
