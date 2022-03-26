Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8359B4E8090
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 12:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiCZL0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiCZL0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:26:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653BE29EB
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 04:25:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so10674198ply.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nnrikdUp38r1zybSPjaK+HicvbWarP0uDPkjT8xNwMM=;
        b=bJiXpWVtKf5khMWSzhvvPDbwvPaKLnsH8ngSS5Ma2K8EhyA91hVyuSCGuivjN1/7TE
         2NwAfQKkEJTmMKpuRSTMeIb1DSkq5n2m/ohT752FOnQEkCtvhV6fkbhQ0mjuUiyO3dMP
         WHfDGbKAaTX5UNUkgjRFt+kZ3N2OGC9YkkiT4WoX+XkLjDs33fGwAN5nensord3NZrRs
         vBl2SMWyO3tkylA7jYZoIUdcJ8bymUrOgudIq6W1ITg5OVjIHIfMMOUuRT7CUhV3xdNX
         jXoDW9UeExxP6ZS9Ld9jeu9X6YkieU4Fl9NEIbm/bSKndAcMlx4rqbRpzDHa1T+EqyUk
         uQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nnrikdUp38r1zybSPjaK+HicvbWarP0uDPkjT8xNwMM=;
        b=D/sNSqcVviB/kAL+y9sE/6VGM+jpxa9dTXN9xaDMxKGvT47Pv0f390OEaFa1cjpd2N
         f2ma6YfFVMqeqPdP+upKlbNyseLD0ABMtHzyE2YcUJgjmIT1txHjNk4IG6aOOnPTqR6a
         WqWjP1KfQMC/YHvmdQzv9p9ESWNJOIFUMoLBaKhXg8geWzi96D4G+xC8gPTVAa5zMr/P
         ONsdvsVRxhpc20bqUB34PuLJuaq5AMNV3bDtpCUUes35AEUqpsqSE2L6Up68cOS1yFkJ
         +nqERHdu/jegKyhyLjY4KHFViKEPUpRgi/JojOmySJCN+WLgCHU22C4qe6rD1rvUwEo/
         U33Q==
X-Gm-Message-State: AOAM531P5/7Ib8Jiwp69ez3I1PaVgSGwzBYz9Z2NWd6WLuq536+BkOFd
        csaFfukmFCEfMs0WMI+f4MqY2UuL3Klais6pGrg=
X-Google-Smtp-Source: ABdhPJypuUwf4faWQ2fwARFmCtU4Bk93vi6FnqX9Ei011kOQvT8OcLiZawZMXRw+s/hDFqV5StjeyrvSeJ/JnewGXj4=
X-Received: by 2002:a17:90b:3ec3:b0:1c7:24c4:e28f with SMTP id
 rm3-20020a17090b3ec300b001c724c4e28fmr30791984pjb.191.1648293901601; Sat, 26
 Mar 2022 04:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4b01:0:0:0:0 with HTTP; Sat, 26 Mar 2022 04:25:01
 -0700 (PDT)
From:   henry Delaunay <henry.dalaunay@gmail.com>
Date:   Sat, 26 Mar 2022 12:25:01 +0100
Message-ID: <CAENqMp93wwsAuR+mDhp8t+=X8T+jOxcODu+GnPALObX4vtiuDQ@mail.gmail.com>
Subject: IMMIGRER AU CANADA POUR Y VIVRE ET TRAVAILLER BELL CANADA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SUPERBE OPPORTUNITE !!!
IMMIGRER AU CANADA POUR Y VIVRE ET TRAVAILLER.
CADRES ET JEUNES DIPL=C3=94M=C3=89S BIENVENU !!!
La Compagnie BELL-CANADA en collaboration avec le Service de
Citoyennet=C3=A9 et Immigration au Canada lance une grande session de
Recrutement 2022.
  En effet nous recherchons avant tout des personnes capables sans
distinction de sexe qui pourront s'adapter =C3=A0 notre environnement de
travail.

CONDITIONS =C3=80 REMPLIR POUR TOUTE PERSONNE INT=C3=89RESS=C3=89E

1- =C3=8Atre =C3=A2g=C3=A9(e) entre 18 et 65 ans
2- =C3=8Atre titulaire au moins du BEPC BAC ou autres Dipl=C3=B4mes Profess=
ionnels
3- Savoir parler le fran=C3=A7ais ou l'anglais
4- Avoir de bonnes qualit=C3=A9s relationnelles
5- Avoir une bonne moralit=C3=A9

PS: Pour plus d'informations et le retrait du formulaire, veuillez
nous envoyer vos coordonn=C3=A9es si vous =C3=AAtes int=C3=A9ress=C3=A9s. v=
euillez nous
envoyer: NOM; PR=C3=89NOMS; =C3=82GE; PAYS;NATIONALIT=C3=89,PROFESSION,SEXE=
,NUM=C3=89RO
T=C3=89L=C3=89PHONE,ADRESSE: =C3=A0 l'adresse de la direction par =C3=89mai=
l qui est la
suivante : bellcanadabell@gmail.com

Pour confirmation de votre inscription et pour plus d'informations sur
les conditions =C3=A0 remplir et les pi=C3=A8ces =C3=A0 fournir pour votre =
dossier de
candidature.

Le charg=C3=A9 de l'information
