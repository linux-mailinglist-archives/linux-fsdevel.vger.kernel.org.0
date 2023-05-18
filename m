Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1E7078C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEREKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEREKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:10:22 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541C198D
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 21:10:21 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-434839b4544so481199137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 21:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684383020; x=1686975020;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDY3aDUnqqgT3t9es8nl/wZQPjrLqj0wzyc7akBZSuI=;
        b=LOHI/t+9Ut28TNqx8a95xh2JOvdPf7ARYw1RAtKQn4kzKLkSJ3JgDS8SRdX3qpxgtE
         L8Wp57fyk0bwgX7yl2rGLcbzPvkQfYSFHPIzK45QcAWplNKFvGQDiIEunMfbSV4tfzYz
         X3HqMQRIsRGZ/bw72wK5swoaOR9a9ZBxNuctmJw4CXA9AK+cVGlonBQlyRySsEOnou7u
         reip0NsPh4izp7OpiwApohJI3zD0wezN9Vmg0CBcEgq8h6f89RNxqRPPjveoDJE1+85Y
         mrK7BPKQvImdgHJKUNHjs70/GVElVP4gfImq2IjDhSnLUu5cTQfTuiErXEFebpMAfDZd
         KfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383020; x=1686975020;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDY3aDUnqqgT3t9es8nl/wZQPjrLqj0wzyc7akBZSuI=;
        b=KLGxlPjjWyhGn4WfgXfmyW9jDyXlwu4PLC3VpeA/zuvZqbR/qSuKT3yA0jy4IIGQ+d
         Xek5SKdX6rxnTWrRPjN1KCZted0dNcvNBwzxe1LFgMX1PNe/ivv8zz5Un5/RFekochNL
         0qqpNlPTUvQ2UFVkuZx1jd/f/M3poPc7GuGiLQ/F7Z1fgbRCKN1bVKqaS39W7TmNsCGo
         td2ADwnhQoTW6w54Be0B8/8UUSu7p66O7XcPYTqTzohEYQg6S2l0JrhrOlxpGliuf2rM
         qT/r17OMMrVILHN9YuQBS/iiuOLAZSwRafVGDp2Yn2ryDrB8cVxO2ZQb2dt2XLbG4Pbu
         zcAQ==
X-Gm-Message-State: AC+VfDzU+cEhAbnocJ6ZthshI7udAdRf+05o8IO4eCy7CbE9FRwyCdTQ
        Pq2EKwDOpOJjEAgg9NSQ5XVg/wux/iMAITDV4kY=
X-Google-Smtp-Source: ACHHUZ4UUWrL6/+vvjWa7rQzBupJ+su5zXu7g9l/qiwX0NhrC6z0xNnjpjA5Dusi6hNF+9HpZB8U+pR2qnZ9Uj4slP4=
X-Received: by 2002:a67:f614:0:b0:425:9cb1:8db0 with SMTP id
 k20-20020a67f614000000b004259cb18db0mr117606vso.1.1684383020054; Wed, 17 May
 2023 21:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:8d84:0:b0:3c4:7f04:af2d with HTTP; Wed, 17 May 2023
 21:10:19 -0700 (PDT)
Reply-To: officialeuromillions@gmail.com
From:   Euro Millions <samuelkellihan@gmail.com>
Date:   Thu, 18 May 2023 05:10:19 +0100
Message-ID: <CAMvykPM8-WsA4an_3OQHg4PBr2KbYK+seeXmyfHjnfBEbzzM2w@mail.gmail.com>
Subject: Aw
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Herzlichen Gl=C3=BCckwunsch, Sie haben am 16. May, 2023 =E2=82=AC650.000,00=
 bei den
monatlichen Euro Millions/Google Promo-Gewinnspielen gewonnen.

Bitte geben Sie die folgenden Informationen ein, damit Ihr
Gewinnbetrag an Sie =C3=BCberwiesen werden kann.
1.) Vollst=C3=A4ndiger Name:
2.) Telefon- und Mobilfunknummern:
3.) Postanschrift:
4.) Beruf:
5.) Geburtsdatum:
6.) Geschlecht:


Herr Anthony Deiderich
Online-Koordinator
