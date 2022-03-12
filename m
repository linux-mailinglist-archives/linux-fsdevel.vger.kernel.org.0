Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350864D7085
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiCLTQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCLTQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:16:36 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B76EB33
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 11:15:29 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bg10so25841574ejb.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+G+dOa5d8t9TVnKXBrmGWkOu0SsmIWEAH8q9HzbCF5I=;
        b=hW/BK7Et18drP1cPpla/D8YUjXG5E2X7AZ8zkRCr4Jll1aS+VjS2woYrX0BETIugw2
         Hygoane8Dg2OF9YO7MI+n26tv5+dDc7Ny7wYkzOTZZlZJeuqj5dl92BgAlLWCgZBTgdf
         KMt6JCD7qS3sqQluCtGNiiHvtQEY2euX3roQhAcbSqMz8k78nhmrMcsUIf105Xxu0xeE
         XcSNv2H3dbMerNQoQOInHcFfvnCV1Fm82tSyywcszlTzWlVYtLB3g+dMDk+ySG47QBgp
         s1QEYG63dP7z+yc4HZsIojU3wmWL5mBmc598UwF+t5MQGZLrmKWuU6o7G5ZekXoFCed1
         MCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+G+dOa5d8t9TVnKXBrmGWkOu0SsmIWEAH8q9HzbCF5I=;
        b=Y+SRCizz3b/P0E+OdfE8il+G22Yx0YB9oDPIR6bXF47wcTkCknNhK4wY9XnJv+GL03
         OzGu7usi+V7TH+jT5kZWKWSMAvcVIvCU0817JH89ERnW0lJm815tdTB8jbypufFGjQBH
         8eyIGsLnxsyMyAnoIVdsrOZ8IRRhzGqzAfwydaV2QrzaCdw1AnXFHW6EzALy7kzZMXe2
         jdimIkg8dmH77mGQHYfHN7s2zIfl+KriIDFp0em3tSh/vYEoy+ill5OiYHBbdRCbDFq6
         7i1x/7VO3u/NGymp5XiR8gI4CaUjsXTN7ON9E2EBDfN9hRFp2mXpC12CvxKarDga+kNP
         b4ow==
X-Gm-Message-State: AOAM530DC+N4zio99WYqU2QUD8uYf6aa9Ok47ICYgiEXFTtZtJK7Eq3Z
        abKOs4mdo+RzgASh2FMJJazSvk6pS6RK1fgz+Ro=
X-Google-Smtp-Source: ABdhPJxUNH77BaeCSOqN0gy5MTzoE7CzfWQqGWI5vtDLrzIQOfg0U1hXoIQW75rTT3E/54AzYwDyo8gqvfdutohlDHA=
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id
 i6-20020a170906264600b006d5d889c92bmr13453386ejc.696.1647112528369; Sat, 12
 Mar 2022 11:15:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6400:1cc:0:0:0:0 with HTTP; Sat, 12 Mar 2022 11:15:27
 -0800 (PST)
Reply-To: bell.bellcanada@gmail.com
From:   BELL CANADA <laetitiamaura002@gmail.com>
Date:   Sun, 13 Mar 2022 03:15:27 +0800
Message-ID: <CAK4Np7S3D_1Ana1z=724AUcrsF+P8bzUkFGwhh9WK-nAdFerJA@mail.gmail.com>
Subject: IMMIGRER AU CANADA POUR Y VIVRE ET TRAVAILLER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [laetitiamaura002[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [laetitiamaura002[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SUPERBE OPPORTUNITE !!!
IMMIGRER AU CANADA POUR Y VIVRE ET TRAVAILLER.
CADRES ET JEUNES DIPLOMES BIENVENU !!!
La Compagnie BELL-CANADA en Collaboration avec le Service de
Citoyennet=C3=A9 et Immigration au Canada lance une grande session de
Recrutement 2022. En effet nous recherchons avant tout des personnes
capables sans
distinction de sexe qui pourront s'adapter =C3=A0 notre environnement de tr=
avail.
CONDITIONS A REMPLIR POUR TOUTE PERSONNE INT=C3=89RESS=C3=89E

1- =C3=8Atre =C3=A2g=C3=A9(e) entre 18 et 65 ans
2- =C3=8Atre titulaire au moins du BEPC BAC ou autres Dipl=C3=B4mes Profess=
ionnels
3- Savoir parler le fran=C3=A7ais ou l'anglais
4- Avoir de bonnes qualit=C3=A9s relationnelles
5- Avoir une bonne moralit=C3=A9

PS: Pour plus d'informations et le retrait du formulaire, veuillez
nous envoyer vos coordonn=C3=A9es Si vous =C3=AAtes int=C3=A9ress=C3=A9s. v=
euillez nous
envoyer: NOM; PR=C3=89NOMS; =C3=82GE; PAYS;NATIONALIT=C3=89,PROFESSION,SEXE=
,NUM=C3=89RO
T=C3=89L=C3=89PHONE,ADRESSE: =C3=A0 l'adresse de la direction par =C3=89mai=
l qui est la
suivante : bell.bellcanada@gmail.com

pour confirmation de votre inscription et pour plus d'informations sur
les conditions =C3=A0 remplir et les pi=C3=A8ces =C3=A0 fournir pour votre =
dossier de
candidature.

Le charg=C3=A9 de l'information
