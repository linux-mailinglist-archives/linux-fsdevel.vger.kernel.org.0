Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88755B5B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiILNqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiILNqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:46:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB271FCD8;
        Mon, 12 Sep 2022 06:46:44 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3454e58fe53so101808167b3.2;
        Mon, 12 Sep 2022 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=rx0FZgTO9IBRagj5Cbyi8/i3+E1D6OoMHMzWe4zqNzk=;
        b=azbUkrG7cwFkn9DeX7B5eU2E6cvjPeREaFlQ3AMkCzsas9cqfPY2dD8gSX+0lK4GHY
         kDqnIfB3KCzkuergCYvfNcznscxCLlJyA25Uah4+iXR01P7grHLV6PMTfYkdXt1xR3YR
         lc2yxAoS6HW4CvhmgZtD4sO9oIvZtFjcWJSM4ZoUz6PpvNFh3SrI+6SX4kF5o1CluuSb
         mBZx5Lyt2pEbRMSII2JzyKV/7H/n+DTotm++iXGDyqCKY1Qhh2xf6PlWrhXfQEGN0ytx
         9SIRSeHPYJAWfcMtZSs1voPA+NghqMFwX6LYOPk3RRe4zmtuGp2POVzyWcCZeoGU4A0n
         P6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rx0FZgTO9IBRagj5Cbyi8/i3+E1D6OoMHMzWe4zqNzk=;
        b=2XsOtkx2PxL784GR1GtNKD1uMya1kWe3zU+0tDV2h8aJ6JCMB/Amf1ulaGZ0E8U6Hc
         yt7irHtNYZ/UHbPngi3Zy34CymjaSrTXc1cVSVysOmU50DU+Hmr3aaUIh1qOMU2zEq7a
         PtDAfmvaZMDu2uhP3luzFF7rBNWBLxCxlbnK3Kge23V9JxJ46QyroXwBLiYIT4eRMwcw
         VL3MUqoXOWdoTCSJFaUXyeX+mlzZlmD1YGdeWA2Os2Mkl1Iy/SHxZ5N3JqwwmUpdPMRX
         /8r7iKF0LCNLYDDWg84SYqRut4/2y2cLpfVGmMvjPGMgRfdK/5S50k2GhQIcsJRLho5T
         B6Qg==
X-Gm-Message-State: ACgBeo1Dr996gtPz1nuLh+fW7rLPrnBADRRBxiJ6Cv5dpS7A6Nw+hYik
        OhfQFeKg9qsk4DTcWiVCJDOK0u5ted/aHjxQyXAJnHqqLcc=
X-Google-Smtp-Source: AA6agR7npTsXp5Eh0fjwXRhZVPwc+KWxi6IL4YUNFlFsuoKzYxKVXYjVnaz/m2qfW/MtX7cnzsfFlehsR+kcMKFmHdE=
X-Received: by 2002:a0d:f2c6:0:b0:329:c117:c990 with SMTP id
 b189-20020a0df2c6000000b00329c117c990mr22531545ywf.464.1662990403462; Mon, 12
 Sep 2022 06:46:43 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 12 Sep 2022 15:46:32 +0200
Message-ID: <CAKXUXMzQDy-A5n8gvHaT9s21dn_ThuW0frCgm_tXMHPUhLY2zA@mail.gmail.com>
Subject: State of RFC PATCH Remove CONFIG_DCACHE_WORD_ACCESS
To:     Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joe, hi Ben,

While reviewing some kernel config, I came across
CONFIG_DCACHE_WORD_ACCESS and tried to understand its purpose.

Then, I discovered this RFC patch from 2014 that seems never to have
been integrated:

https://lore.kernel.org/all/1393964591.20435.58.camel@joe-AO722/
[RFC] Remove CONFIG_DCACHE_WORD_ACCESS

The discussion seemed to just not continue and the patch was just not
integrated by anyone.

In the meantime, the use of CONFIG_DCACHE_WORD_ACCESS has spread into
a few more files, but replacing it with
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS still seems feasible.

Are you aware of reasons that this patch from 2014 should not be integrated?

I would spend some time to move the integration of this patch further
if you consider that the patch is not completely wrong.


Best regards,

Lukas
