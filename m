Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCCC7AD891
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjIYNGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjIYNGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:06:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DED111
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:06:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5789de5c677so4020033a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695647183; x=1696251983; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXglc8opTBOxqxBVnbKKZEfOjkArzaJ5mbcscFyV/Wo=;
        b=E9p/DdAhQv/UcBbrSHqMLXHKKFmTmAEugjpfcAaJIi0oAhHW91Fn3L148iHyI9tq6y
         1AXxdfTrMhS72Zy9gDH3x6BZX047nWgHv5SIYLenoGYIxmyhv/3Z0OHCspeSEWUjv/Dr
         5v3ZlzF9MCgA6c4GY0EVCOxSXAvWL66AAIUVTzUcrOiHt1xQuSXO/meOJiZwKRblOuuE
         cKIGL6pARcFlHbPhB2iJsp7kw3Bog0Y/ZW5yTM9A3tyq5lZSSMxCvErvB3dVJ9fa+G8q
         yvN079Vrw4bkbbYAlPNEYfEE1Ty6s7Y2UpwRLImeV4hkPd1Mji5zfoNrzlvslblzeye5
         9Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647183; x=1696251983;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXglc8opTBOxqxBVnbKKZEfOjkArzaJ5mbcscFyV/Wo=;
        b=Sn94qDFvhP7XXzvgZ8Akyc4FjOWaY0ljoxGj3KbSIMpQAmNULXUsj51uns0UGj/bCT
         +Hwkx91Ap46RqyyYJF1P6DuiYFZakOIAXMSDnK9HB8KCjhv7gx6DU7B/gOqrZYpG8ECN
         bkQ1hRASu6iA4c1VyuKffNS08+zHZociSoH82ELdqbw/tr61NHPssAAwEnG39tgF/aqQ
         lJeWy3L676TrNccvUMcUOGqi4VjS8ORCgct+lXm3bTflfiYxW1RoCmO6iCyD8d3G/MfS
         Q1Tp9DF/cqpMHei8TTNO2B/yduMlZuOD8qVA7RfYcZA3l8+jOKdgwby6vNQkHFKEgKU1
         jQXA==
X-Gm-Message-State: AOJu0YxzUSFh2gAt3uQDJKGbRSi5RN/xAbGFSmXmFEuCTiLXgiBV0oAB
        cPj24JRI0AF3GMRaqUTNHP4NtwjHs5cmSVohOgk=
X-Google-Smtp-Source: AGHT+IFXiu+hIuGpbMGnryBZPI9zrQcfgcwULkxd1ATRGTszst7B+kzsc3FXYgt1Oi/EhIFKc10wDAE9O22h3BLnnC4=
X-Received: by 2002:a17:90b:33cc:b0:268:553f:1938 with SMTP id
 lk12-20020a17090b33cc00b00268553f1938mr4364657pjb.4.1695647182818; Mon, 25
 Sep 2023 06:06:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.isaiahnwabudike01@gmail.com
Received: by 2002:a05:6a10:4410:b0:4e6:519f:124c with HTTP; Mon, 25 Sep 2023
 06:06:22 -0700 (PDT)
From:   "Mrs. Rita Hassan" <ritahassan02@gmail.com>
Date:   Mon, 25 Sep 2023 06:06:22 -0700
X-Google-Sender-Auth: yeq3_xtuipO1P77d2qeKwPgsd4c
Message-ID: <CAN0kuD_Mb6r_ybPEbbHkv8BKeKwvyedgB_EOczj0YvEYjcG2ZQ@mail.gmail.com>
Subject: Please I need your help,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,MONEY_NOHTML,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please I need your help,


Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before i die.

Meanwhile, I Am Mrs. Rita, 62 years old,I am suffering from a long
time cancer and from all indication my condition is really
deteriorating as my doctors have confirmed and courageously advised me
that I may not live beyond two months from now for the reason that my
tumor has reached a critical stage which has defiled all forms of
medical treatment.

As a matter of fact, registered nurse by profession while my husband
was dealing on Gold Dust and Gold Dory Bars till his sudden death the
year 2019 then I took over his business till date. In fact, at this
moment I have a deposit sum of $5.5million dollars with one of the
leading bank  but unfortunately I cannot visit the bank since I am
critically sick and powerless to do anything myself but my bank
account officer advised me to assign any of my trustworthy relative,
friends or partner with authorization letter to stand as the recipient
of my money but sorrowfully I don t have any reliable relative and no
child.

Therefore, I want you to receive the money and take 30% to take care
of yourself and family while 70% should be use basically on
humanitarian purposes mostly to orphanages home, Motherless babies
home, less privileged and disable citizens and widows around the
world. and as soon as I receive your respond I shall send you my
pictures, banking records and with full contacts of my banking
institution If you are interested in carrying out this task please
contact me for more details on this email. ( ritahassan02@gmail.com )

Hope to hear from you soon.

Yours Faithfully

Mrs. Rita Hassan
