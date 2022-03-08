Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C64D1FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbiCHSKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 13:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349385AbiCHSKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:10:48 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F052E41
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 10:09:51 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dc242a79beso200781717b3.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+G+dOa5d8t9TVnKXBrmGWkOu0SsmIWEAH8q9HzbCF5I=;
        b=lv61dmaDlY/21bZBcnh/djVKY2mRp++3ufJow9xInzs8EuDtTPboV9k3sYD9zBzJl/
         sSW+aUs3otHCcC1QNx+vADbjjSSnHv96xJJ+pLp8YtUPtG2YRtJEp8yslbDtsvcNkXHF
         oVDwQMML/UcG1ZvAifMAS0dCsbkEKLx67Mu9bHXnBH04oGz/CDqno9M7cQS7FK/vPJan
         R814WcsEefmQwrNj2sot3wymPhJmS6rlei6RFW0sKExG99ZsS+ddJfnKiM9bHvLttnGt
         7n1ZR5wPGNS/d6miPXuviGxjScW4B44CoWH0ghzWfwa7Cy49HMXNRA2gCzFQoXboXPfo
         yXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+G+dOa5d8t9TVnKXBrmGWkOu0SsmIWEAH8q9HzbCF5I=;
        b=XeOeJeH5STp0YqnWcICiw9g3LOiEEP1LaOZq7oECWWIrhwN87iAQKc1ELLp4ZPS3Us
         /Hnd/mYuTFzgm7jOfk9BSjGKa0/JHFtJubz26NxXKjV2MW6pzsNEogZ7Z92b5PJzQeJG
         RpaUV5l8rsoq6Zg1MV9//qzCOFz3TFx9Zy/Jn9No5OAIpE5MJ8Ku7FTPheGTJ77+Kf2H
         qlgGpY5sACPKSiRoVsX4Ija2dFeV5dH/qFJLbl3HbtNnl8b3t8ISW9K9hHlYGaXvT5xQ
         uzecknRtxQ5lrTRaA40Biem4nUTPaAmSBmtcuGEg1sZMWhv16/ew+k+ggvFse01ZR/gy
         wuqw==
X-Gm-Message-State: AOAM531dYcJXkZl7qHYbTNKq9vIYRpJ2AfnRfU3wgWD4Vr7p7OtOpxfe
        Vk8BRfaf4Oe+U1yYUlK696aZYDNjJsl3avm307A=
X-Google-Smtp-Source: ABdhPJzuruJ+HhlCorgdRJjB5MsqYiqhWZLstxodQoiP2OTU5bwFfcAuameqpDge2/rL6ZsOSObKfmZoZLYisULcRek=
X-Received: by 2002:a81:15c9:0:b0:2dc:4bf9:41ea with SMTP id
 192-20020a8115c9000000b002dc4bf941eamr13429127ywv.145.1646762990939; Tue, 08
 Mar 2022 10:09:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:33c8:b0:236:3f09:dc48 with HTTP; Tue, 8 Mar 2022
 10:09:50 -0800 (PST)
Reply-To: bell.bellcanada@gmail.com
From:   BELL CANADA <sabrina.buhatini009@gmail.com>
Date:   Tue, 8 Mar 2022 19:09:50 +0100
Message-ID: <CAAjpWVGS9YyusaUBYLxOs_-5tf3dOdAWhBU_5FQfzR0pG7+t_w@mail.gmail.com>
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
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sabrina.buhatini009[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sabrina.buhatini009[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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
