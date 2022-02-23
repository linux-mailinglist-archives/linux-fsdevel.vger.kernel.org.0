Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D796F4C1AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiBWSdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 13:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiBWScx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:53 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE941999
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 10:32:16 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d07ae0b1c0so221573117b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yNqoekfvML3w8SudVZAHNr3LBOzKBJK9Mn0jVBnOSJ8=;
        b=mVX0Up4THZLuo7Y2Pv6z3UB2AfLXLmkHp0ZEPfxh9Tc9qHPBbyigYvhB/5sydqwc/l
         SsWDiOs6nnmec+1bwtIonhNPJ8EPBaAXjcnG+9bc1byoSev/UEX0yWW86tdpTip73z2c
         ck8AHswGx7R1ExcOh+nMVeCXYWNoG4ufXheWWTgc1R4X7UtsSbq+UKTDKlsQQsRphTWV
         LPfwKKNKKzDXbYgtAaSq5ON3OL6MSNaTsHiW9bjBXOW3sTdhi7uOh3KvFNYbr8mh/v7K
         XBAmOTQ4/LwuigErqE6sGJ4M2xAswVyqX2eD+pViCyoWX3SO9YTQDauiX0hVGWqx46DF
         mwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=yNqoekfvML3w8SudVZAHNr3LBOzKBJK9Mn0jVBnOSJ8=;
        b=rjzFgB9D1QFUGJ6n3lm8ashNT/gnsEi1owIOIvc0SmsNnsZ2v1F7TgHjmQZi+WG00L
         eJzQc++S9aDJdtAqFccqzQTcDZ8xXdHFq0Xjq0ipdaHo6w99354BciU10lHdlCFCzTf9
         6+gWnPVGx6/O0qCf6036dWa77TneSJlm275zTaEkN02xAQD2WO80vjT5hkHDET0IMU8B
         IASaseR5coHthzyKQi5HWly7LL1Bxk0daQE4eQ/QqEq/jJVbzqbrdUOLXztTe0X0PluQ
         /eGSFLVe16FmlzMfVXK1J/tTKWAI+9kcqOfIyTH2jjzzA4xZTgvmmtPQT10NDyvXJ/g2
         Su6Q==
X-Gm-Message-State: AOAM531vmRoApWqyHTcGn/d1Qz0WxTweURsOrW+QWCqcSRo8duSJ1wzy
        DEyMPspELu8dXQWh12G+QM/QP7uvHBYexSb4WI0=
X-Google-Smtp-Source: ABdhPJzhBoHjW+cbx/pX/tqi4MVUglNrQkC1sijeStSsutZEU4aEpUqo3HyJG7o/WNqmC9LU98G5WILWR/BX+G2pNqY=
X-Received: by 2002:a81:f611:0:b0:2cf:aa3c:ab17 with SMTP id
 w17-20020a81f611000000b002cfaa3cab17mr886179ywm.410.1645641135904; Wed, 23
 Feb 2022 10:32:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:3e19:b0:20e:6caa:bb5d with HTTP; Wed, 23 Feb 2022
 10:32:15 -0800 (PST)
Reply-To: gisabelanv@gmail.com
From:   Isabel Guerrero <ayikaekue1@gmail.com>
Date:   Wed, 23 Feb 2022 18:32:15 +0000
Message-ID: <CADeH0Hsc0azsc5013JCELFpxwjt2MEdZJBe8xB0XHvL_pKO+iw@mail.gmail.com>
Subject: URGENT CONTACT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0677]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ayikaekue1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ayikaekue1[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Good day. I=E2=80=99ve not yet received your response to my previous=
 mail.
