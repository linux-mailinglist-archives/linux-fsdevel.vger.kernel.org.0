Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0685BB61A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 06:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIQEZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIQEY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:24:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AB46609
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 21:24:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so28036741ljg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=aV/tr1Tbe9aO+1NiuYMI6/qbsTacwaTMKUCbpc9zdIc=;
        b=ewGi3q/3NS5CK4LP2Mj5k2NgE4V44hHHVKK4U+Y0dHUSMvM09cMU9rk65odH1tN1Pf
         hGnd+J7tpeTC1aEeslzgjQskexFzULhRacqL3q4LHZnRR5Qw6tcGkMqcX7eh/V8wflRH
         4y6La7dbYT9+BWeVXjoo2nEwwjjPuLXG6TCasVxzjI7W9WJVoa7dakanRpfqy3CVqXUS
         qp0PJke7POmBJoQWaAAnntFG5ZFi5OD8gZC/mTJOhfqvtkISwP5+w/41enb2qWfv4hnV
         dRtvOZZ4itP+4W600JIeVb+usNno7/BLgTjvbnk/J1mHjv36B7aOeK4NwP3lYwr1Tq8y
         qNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aV/tr1Tbe9aO+1NiuYMI6/qbsTacwaTMKUCbpc9zdIc=;
        b=JfwtB7pO3ZKsT8TUXX1OsQ3L1pBb0YNpvzJePAKm193ydof//vq+4POTRgHb2IieCR
         MrNxdurY5mY0QnGdr62cP3y6FuKcicgVBXF0hxhb99I0SDhDdR/3ra6U9Z4PvaL1UV9k
         yJIIHKflSj2nRoSwD89vTiswFghdUjE+l5tjjQPiB0e30MQasRJBiZFTeSOoLpryAqlL
         6mIlQD+TzMobJrUgH1gjBB4V6DN+T56sLLVQsfnQP4jdeG5G39o0LvYEREsZ7A9X75CI
         3qG6t+aXi7asry5JGzxseQ84claaM5aX2Gu8ey0D+cGyGZDCpJYrjzwGFDGM4AwCyjg5
         QIDA==
X-Gm-Message-State: ACrzQf0VxCJeU2CunDlyzBAvgsiwA8ljSc1Ca6ynZqHTahVgCTyAUjkg
        t3qVj8ag6Uhehre+gyxPH1zbCzfSm/bKWbtB+AU=
X-Google-Smtp-Source: AMsMyM4EOTZDV2htTTYe+WipYEz6kJbuN/mLAlFQXvIRXTRk4jsxNb6BFnswxWQOUSGcH4WFFNPzCEzVzQRjEO0iFDI=
X-Received: by 2002:a05:651c:198e:b0:25e:6d28:3a0f with SMTP id
 bx14-20020a05651c198e00b0025e6d283a0fmr2445774ljb.321.1663388691953; Fri, 16
 Sep 2022 21:24:51 -0700 (PDT)
MIME-Version: 1.0
From:   Mrs Olivia Philip <mrsoliviaphilip208@gmail.com>
Date:   Sat, 17 Sep 2022 05:24:58 +0100
Message-ID: <CAO2rEeXtSuPp-jS4=4SKdri11E+F6ku4g0mbPUZVnOkmrkfr=w@mail.gmail.com>
Subject: Mrs. Olivia Philip
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Trusting Friend in God,
Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search and I decided to contact
you with believe you will be honest to fulfill my final wish before I
die.
Meanwhile, I am Mrs. Olivia Philip, 73 years, from USA, I am childless
and I am suffering from a pro-long cancer ill health and from all
indication my condition is critical, my doctors have confirmed that I
may not live beyond two months from now for the reason that tumor has
reached a critical stage which has defiled all forms of medical
treatment. Since my days are numbered, I=E2=80=99ve decided willingly to
fulfill my long-time promise to donate the sum Five Million Five
Hundred  And Twenty-Five Thousand United States
Dollars US$5,525,000) remaining in my foreign bank account over 9
years due to my health problem. This fund was obtained by me when I
was dealing on Gold.

My promise is to help the widows, handicapped, orphans and
underprivileged to build technical school and hospital for their
well-being. If you will be obedient to assist me fulfill my promise as
I said here kindly email me back to enable me introduce you to my bank
management as the foreign beneficiary & trustee to my deposit fund to
enable them check whether it will be possible to transfer my fund to
you for this Charity work of God. I have been trying to handle this
project for the past 4 years by myself hoping I will get better, but I
have seen that it won=E2=80=99t be possible anymore.

Please get back to me if you can handle the project for more details.
God Bless you
Mrs. Olivia Philip
