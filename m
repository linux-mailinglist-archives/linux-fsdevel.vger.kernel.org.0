Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54215A405E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2Adr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 20:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2Adq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:33:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C312FFFA
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Aug 2022 17:33:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so7355220wmk.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Aug 2022 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=BZ7RE6gY/mSGM3QZalAhGviaQWkPqTvxWfEzeRuzSog=;
        b=MaKWFWByhgKvmkxalibVmWK+iMEYrNlWC1PoG1yy5oZilLB7KomrYYNQ3Oml/XIFXy
         Ssud6x187dijJjPwrmZPB/LvhYRV//srOuyPmQld8gEAdaz49RIQlyiEoWKzThPcTeH2
         YmeoJKw9fwB5IPUGzbjFMpGxBEgh+XL88dHX+4TmpbtQd6WwPtGI6akntr/NfSFx5Li4
         lFoVlm97IkkWQ7dEQ9ZuoN5zilljBJbSZa5wuVxvwsWafffxJj2A+QQ+eZoJyIQaYH4K
         lax0PQmcd0t7k2HhvBZClxgnaoPbPSXPrZlDL6fStBD/tO2U5CIbNEeLUQD4rhwMBHT8
         n49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BZ7RE6gY/mSGM3QZalAhGviaQWkPqTvxWfEzeRuzSog=;
        b=LYbMWF8dBuXxpaLCKK39mN34bmO6TA1ArT5iHFSoJSfF7JqsEctste88XK6d39+lVl
         RVihh5QNxLmu2FN8YmghudxGHGuQqTfYMSr9uTKst4hU64nhmz2FFlsPGHBISik/1wqw
         A4wkcuHthFXBKJ/ZOJOPbU/Hx4JETU33Rnm8HBoRtI8vO38ccKtECCVkq4PGZ5SzMngZ
         zlbhpHySOfd9lCZG20+wFCRLqQdfLA/scu/NNEYXfL+z4Az2a2T+zbIXdQuvScQqS/4a
         G53teQyO/siT0qJNsmIm9XLXQ1hFy1Go9x5TGvXAdmWux3Xw81ETlc12rLoX5yl0RFIw
         mIyA==
X-Gm-Message-State: ACgBeo3/4FBSRTnqTteSfHP85lolNs8QTW4nYwGHKh+iv3N38kShsT/j
        ynYYhGW/SdkAu7K8AnPtJCCdvSp7ab+HmARu7w==
X-Google-Smtp-Source: AA6agR4QFU4tM0VtEeaerwKs8TLZtv5piMzHNaRnMPHrEjhwZ/b+1B93PEQvax2CbDiHV5L/egK4O7GFg6hDo2kO9E8=
X-Received: by 2002:a05:600c:358f:b0:3a6:145:3500 with SMTP id
 p15-20020a05600c358f00b003a601453500mr5653808wmq.64.1661733224514; Sun, 28
 Aug 2022 17:33:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:1e8a:0:0:0:0 with HTTP; Sun, 28 Aug 2022 17:33:44
 -0700 (PDT)
Reply-To: jamesmorganw7000@gmail.com
From:   James Morgan <bottikah2@gmail.com>
Date:   Mon, 29 Aug 2022 00:33:44 +0000
Message-ID: <CACeuYDrSF_AYbuUZYG_XrP7hiSkLy9RS=ta0Ez3pSesoM91NvA@mail.gmail.com>
Subject: James Morgan
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:330 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4810]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bottikah2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jamesmorganw7000[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bottikah2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

Kve=C3=B0ja til =C3=BE=C3=ADn,
=C3=89g heiti Mr.James Morgan, fr=C3=A1 Toulouse Frakklandi. =C3=89g hef =
=C3=BEj=C3=A1=C3=B0st af

=C3=9Cdv=C3=B6zlet neked,
A nevem Mr. James Morgan, Toulouse Franciaorsz=C3=A1gb=C3=B3l. R=C3=A1kbete=
gs=C3=A9gben
szenvedek, =C3=A9s az orvos azt mondja, hogy csak r=C3=B6vid id=C5=91m van =
az
=C3=A9letb=C5=91l. Az elm=C3=BAlt tizenk=C3=A9t =C3=A9vben aranyexporttal f=
oglalkoztam, miel=C5=91tt
megbetegszem a r=C3=A1k miatt. Rengeteg p=C3=A9nzt kerestem az arany =C3=A9=
s a gyapot
elad=C3=A1s=C3=A1b=C3=B3l, f=C3=A9rjhez mentem n=C3=A9hai feles=C3=A9gemmel=
, sok =C3=A9vnyi h=C3=A1zass=C3=A1g ut=C3=A1n
nem sz=C3=BCletett saj=C3=A1t gyermek=C3=BCnk. Nagyon beteg vagyok, =C3=A9s=
 az orvos
szerint nem fogom t=C3=BAl=C3=A9lni a betegs=C3=A9get.
A legrosszabb az eg=C3=A9szben az, hogy nincs csal=C3=A1dtagom vagy gyermek=
em,
aki =C3=B6r=C3=B6k=C3=B6lhetn=C3=A9 a vagyonomat. Ezt a levelet most a bete=
g=C3=A1gyam melletti
sz=C3=A1m=C3=ADt=C3=B3g=C3=A9p seg=C3=ADts=C3=A9g=C3=A9vel =C3=ADrom. 2,5 m=
illi=C3=B3 doll=C3=A1r van elhelyezve a
tengerent=C3=BAli Financial House-ban. =C3=A9s hajland=C3=B3 vagyok utas=C3=
=ADtani, hogy
az eml=C3=ADtett alapot =C3=B6nnek, mint k=C3=BClf=C3=B6ldi megb=C3=ADzotto=
mnak utalja =C3=A1t.
Jelentkezni fog a P=C3=A9nz=C3=BCgyi H=C3=A1zn=C3=A1l az alap ig=C3=A9nyl=
=C3=A9se miatt, hogy
engedj=C3=A9k =C3=A1t az alapot, de biztos=C3=ADtasz arr=C3=B3l, hogy az al=
ap 50%-=C3=A1t
felveszed, =C3=A9s 50%-ot a lelkem=C3=A9rt haz=C3=A1dban l=C3=A9v=C5=91 =C3=
=A1rvah=C3=A1zaknak adod.
pihenni, miut=C3=A1n elmentem. K=C3=B6vetkez=C5=91 e-mailemben elk=C3=BCld=
=C3=B6m =C3=96nnek a
let=C3=A9ti igazol=C3=A1s m=C3=A1solat=C3=A1t, amely lehet=C5=91v=C3=A9 tes=
zi, hogy k=C3=B6nnyed=C3=A9n
jelentkezzen =C3=A9s megkapja a p=C3=A9nzt. K=C3=A9rem, azonnal v=C3=A1lasz=
oljon nekem a
priv=C3=A1t e-mail c=C3=ADmemen, ahol gyorsan el=C3=A9rhetem e-mailjeimet
(jamesmorganw7000@gmail.com) tov=C3=A1bbi r=C3=A9szletek=C3=A9rt =C3=A9s =
=C3=BAtmutat=C3=A1s=C3=A9rt,
mivel =C3=A9letem v=C3=A9g=C3=A9t j=C3=A1rom a r=C3=A1kbetegs=C3=A9g miatt,=
 amely sz=C3=A1mos
szervk=C3=A1rosod=C3=A1st okoz a szervezetemben. Rem=C3=A9li, hogy a lehet=
=C5=91
leghamarabb megkapja v=C3=A1lasz=C3=A1t.
=C3=9Cdv=C3=B6zletem,
James Morgan
