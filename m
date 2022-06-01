Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB953AA85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355885AbiFAPyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiFAPyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:54:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F204D633
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 08:54:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e4so2449763ljb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DfuNNrg3LnuPaFBzeGNj9xFXiRXwcq80wlotU2s1MKk=;
        b=iKOGLIYIBkSMiqOKetuFOM02OtNPYLzBGX3GhsuJKyqnt+TAQ592s0jUCEurn/GS/b
         DJ831dJJqkdykzYk2NH5yjdMpFToLyo7HsR4lO7uJJVEuOHOnK7Jcc5f27MI8Hu1U5Sk
         zGVVQI3hPl7gykXn/0UF0jk73188v+bwKpMTnIOVVKjufwkdfmzMhFAsvnjk8rZU4AhC
         c+f2b6fjf/B/kLPQbiAr5ah0tsncajXqgafcYJ54k70I3YRfkFMK1d8EqDmWkIgFnaxk
         CaGau2r1Sd+ehjqU583+5QafYI5FxI/uukYsGh6kSE8YbziZBT94Oa538LuYVW18oQvo
         65ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DfuNNrg3LnuPaFBzeGNj9xFXiRXwcq80wlotU2s1MKk=;
        b=oPSuqeeuODk/H1sb2QofdxFy91D/Dge95GkkNQ1J8wKAeObkZ5CU6yqQXU7pE24mID
         x3lCn5coFRCgEA/cJqGOJsTTwrfl4PQM6K9z8qrGhfVj5b7UG0HZvSnSTzvITIChFsgD
         OQe/0IxojxyYwkPYjT4NHFmpxEa/92nyeEjhGznH0Rhsy/QN45R2mzYtK5H3C+o1wfH9
         D7tdLR/M5KbNmj16T2+H/+/azXDsATeGyC79ehHQWYo+LpIUv8E5t3ZVwLgX1HCcbojW
         hzuQvImrraNMEg2TmvfemfWpSvhiwOmTuI/Q2q5c6kvhY1+j30hr3gLBAh/LActUJEEP
         BLBw==
X-Gm-Message-State: AOAM533B7RuByXn6k3e/jaMygUoSq5YkFqDMW9o/jDacMkx4poiG9hZl
        zzwqv9PgxAjABJEh+oWxH0Pn/ZqtTmDqRUpzwQ==
X-Google-Smtp-Source: ABdhPJxzb2DihUcOu8ENYFa39rOJmvMntGdpR2fwpsBt8Q9rtTxNXGLaVujOiH/2JIo99jv1mofLS3y0hpugin8oVeQ=
X-Received: by 2002:a2e:a796:0:b0:255:485d:49b with SMTP id
 c22-20020a2ea796000000b00255485d049bmr12783247ljf.215.1654098854268; Wed, 01
 Jun 2022 08:54:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:4410:b0:1e5:1864:63b0 with HTTP; Wed, 1 Jun 2022
 08:54:13 -0700 (PDT)
From:   RHONDA MILLLER <mahoneypatricia55@gmail.com>
Date:   Wed, 1 Jun 2022 17:54:13 +0200
Message-ID: <CAMj9NgCrY52x+fCXJJ5w3af=OHwuoRyZER6UHV0ndQrWZLBvgw@mail.gmail.com>
Subject: =?UTF-8?Q?Your_reward_Covid=2D19_stimulation_compensation_of_=E2=82=AC?=
        =?UTF-8?Q?1=2E500=2C000=2E00=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.2 required=5.0 tests=ADVANCE_FEE_2_NEW_FORM,
        BAYES_80,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FILL_THIS_FORM,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_LOAN,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 Attention  Beneficiary:

We hereby inform you that the UN Compensation Committee has decided to
compensate you. You have been selected to receive the UN Covid-19
Incentive Compensation Package worth =E2=82=AC1.500,000.00 in the ATM VISA
CARD.

The selection process was performed using a computerized United
Nations (UN)email selection system from a database of more than
79,980,000 e-mail addresses from all continents of the world from
which your e-mail address was selected. Therefore, we recommend that
you contact our grant using the contact information below to receive
your Covid-19 Incentive Package worth =E2=82=AC1.500,000.00.

Contact person: Mrs.Rhonda Miller
EMAIL: (ronmiller1@indamail.hu)
Be sure to include your details below as required:

1. Your full name:
2. Your address:
3. Your phone:
4. Your country / occupation:

Thanks
Mrs. Belinda Hart
Director of the Center for Disease Control and Prevention
