Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570350DC39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiDYJTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbiDYJRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:17:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A32ACB
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 02:14:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m23so6183009ljc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2m/c+HTiq67jsqWp8uamRbhLl470hiH704V1w+W3v9Y=;
        b=jV5IejTqKww9m5p2E3yNQoiDCHrSSoaYJ3RY8jrK5RJIfuJKMJnhPA2hpcfritboFZ
         PtwudkHZI90wkTCh89wZ/ZLgMpRXCsBif78tpHGswieki2saZE09X+Py03vNMQFL8VeW
         Sxq7JRJG+8Nxo6zcMa5qNW4FOvd19mQuxzXdaGBoKVLaI8aP7s1zM1AFmXKE/Sv1rlTg
         kFj0F2r6n8Zz8+cQclaODn8M0sEuG/MDsnmCGPGQkMXmQjI/3d6gjW23BdJW3YXjeI75
         +ozjklICqXoASiKXEaofCQJOGYBERtJldGz/ZW7LQ+5aOIefBj/AQqxb717YKb6N3In4
         kpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=2m/c+HTiq67jsqWp8uamRbhLl470hiH704V1w+W3v9Y=;
        b=tpccz4H4/JTPJDmmcG4NUdRs5PvUtgDzH6XwVP0PBxxeWoTyKND3KYhf2nMgeQz+Ib
         Fm2rRUVTjULXhchOEC86e+vv26YFFH0Up6G3ADEKK2TjBuoCmvMFdsKU6Kb0sF9hd+MR
         J15uZm7W7oAqgCiRAf9Fy4Z1vbrH5D1wTfQGsPASxhZkOhmANP73o1IWvuzNKFtfAkD9
         nvorRclc18+T24DMiKfWcsmpERga4UGzFutIbF77l/a2voVUp66zZyabrKzy8w2CSA2S
         jM4yVedOvAc0W4Zap5KIOQ55lSBKWOxDsvL9nBr0oFz/T0xMAwflPicdfUMeDR4xzJ9P
         nb5Q==
X-Gm-Message-State: AOAM532Y+GEkfEVYD+9ICLHyJzoI8Dbx0Zdyufi6wqGMEFiVjU0CsXRe
        5Y3p+/cQScO0Ux8Wq7XkRKNXCIDbXidQbSccnKw=
X-Google-Smtp-Source: ABdhPJwnAmzVDZEbgIuacSMejMgpglIadnKh9wnDut6EIH7XY/Z0j9KYfxScd9/xbBLjtK8ZkyjMrwSGVHh2Yl2wsks=
X-Received: by 2002:a2e:8e91:0:b0:24d:aac1:f855 with SMTP id
 z17-20020a2e8e91000000b0024daac1f855mr10924742ljk.28.1650878076217; Mon, 25
 Apr 2022 02:14:36 -0700 (PDT)
MIME-Version: 1.0
Sender: mitchfastloans@gmail.com
Received: by 2002:a9a:4c46:0:b0:1b9:a92f:831f with HTTP; Mon, 25 Apr 2022
 02:14:35 -0700 (PDT)
From:   "Warren E. Buffett" <wbuffett534@gmail.com>
Date:   Mon, 25 Apr 2022 02:14:35 -0700
X-Google-Sender-Auth: lso87YkEPt6Ye27_zdq51q-nJ0s
Message-ID: <CAKMcEtNZ3DF9U48w6KuGxkHuhp3Q9=DbevKHtk+RjZc4==qcdQ@mail.gmail.com>
Subject: Darowizna !!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Drogi Zwyci=C4=99zco,


 Nazywam si=C4=99 Warren E. Buffett, jestem ameryka=C5=84skim magnatem
biznesowym, inwestorem i filantropem. Jestem odnosz=C4=85cym najwi=C4=99ksz=
e
sukcesy inwestorem na =C5=9Bwiecie. G=C5=82=C4=99boko wierz=C4=99 w zasad=
=C4=99 "dawania za
=C5=BCycia". Mam jedn=C4=85 ide=C4=99, kt=C3=B3ra nigdy nie zmieni=C5=82a s=
i=C4=99 w moim umy=C5=9Ble, =C5=BCe
powiniene=C5=9B u=C5=BCywa=C4=87 swojego bogactwa, aby pomaga=C4=87 ludziom=
 i zdecydowa=C5=82em
si=C4=99 przekaza=C4=87 { 3,500,000.00 Euro } Trzy Miliony Pi=C4=99=C4=87se=
t Tysi=C4=99cy Euro
losowo wybranym ludziom na ca=C5=82ym =C5=9Bwiecie. Kiedy otrzymasz ten e-m=
ail,
powiniene=C5=9B liczy=C4=87 si=C4=99 jako szcz=C4=99=C5=9Bciarz, poniewa=C5=
=BC Tw=C3=B3j adres e-mail
zosta=C5=82 wybrany online podczas losowego wyszukiwania.


Prosz=C4=99 odezwij si=C4=99 do mnie szybko, abym wiedzia=C5=82, =C5=BCe Tw=
=C3=B3j adres e-mail
jest poprawny.


Odwied=C5=BA t=C4=99 stron=C4=99: https://en.wikipedia.org/wiki/Warren_Buff=
ett lub
wyszukaj moje nazwisko w google, aby uzyska=C4=87 wi=C4=99cej informacji:
(Warren E. Buffett).


Z niecierpliwo=C5=9Bci=C4=85 czekam na odpowied=C5=BA.


Z powa=C5=BCaniem,
Pan Warren E. Buffett
Dyrektor Generalny: Berkshire Hathaway

http://www.berkshirehathaway.com/
