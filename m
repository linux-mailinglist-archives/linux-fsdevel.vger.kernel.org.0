Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75F68EC35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBHJyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjBHJyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:54:38 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A36A7D
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 01:54:37 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1685cf2003aso22496593fac.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=SK4yg4hZ1/J9ykxuQXuMJ8wTplmXWZ+rUoPXQmXGHLI17Yz0/3kcyZp0WucDCQdTSS
         u5RmtTaXcbeSzbE+OIubLf9bmpQ7aKtVQagpWW38EhSFqRQhaXG+K1NbIppcuF3pl1cb
         JPoQRkqbL5uAiY/dt7zUxvq4LIuJk+rNI4U/NfG7+w68wpdO4H8QiPVgBgpAKCveuzu7
         +aoXN6t/uOgllbiUygZFQBBAcb4NFciPZJCGRsvawHgl2mFVgNNB8AAYUU9/OdGFFMP9
         kgunVNRP8DlhCRZfzxfm/BD4SXUccCfD6VNgv0Sfpk669HM1QLl+D7SuMOKtGoHjxaov
         iCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=Uk8HnWOLn8W4thJawSt14Y+XZfPnSOQTpge7DcazJlNQKgxkqV1ir74Ro7O04050eP
         f5P02P2ti/S81zZC/7GF2UUPEIGO4EYKy5Ok+rnW0FGRqir7lWKa7Cw8wQnM3qq7PedK
         AHYYuZIQrdVZScvLl/8BI5qABG7aCVshdXt38wtRTgxaNaxzSXbeAnMN0LHx/BxRdooB
         bX8877X4mtJ4QMxRkn1K1oe7GqDDBl05dEwrlrXXh06CXVn/+R/nEZn9Bj8Nwv2MoivI
         pSNmwj4QWAfUTyj1sxvY0AVmcAYyrRLTqZjcZ6f89y0t8OtnppMOx4rqCvVQ3IzJB/Fc
         +nRA==
X-Gm-Message-State: AO0yUKVJ2AWAcgi9H3sVk2nBsiceS8+daQiXSDbGfnpghv6whptiMiYO
        Z0Izpne9hrCgMzTh7fN9EEgA9zbCcA6HEnvUlp0=
X-Google-Smtp-Source: AK7set9Jv3aoswS5ST5xAwLKayC16Z8shntXJ7qWgscb/LsTffeS1YJG1uw6sxAchHLmAvqU06w1+urcXDQ5wWfnJuE=
X-Received: by 2002:a05:6870:808d:b0:16a:441:fb14 with SMTP id
 q13-20020a056870808d00b0016a0441fb14mr269664oab.60.1675850077045; Wed, 08 Feb
 2023 01:54:37 -0800 (PST)
MIME-Version: 1.0
Sender: sbinta301@gmail.com
Received: by 2002:a05:6358:e493:b0:f4:4cdb:bef6 with HTTP; Wed, 8 Feb 2023
 01:54:36 -0800 (PST)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Wed, 8 Feb 2023 01:54:36 -0800
X-Google-Sender-Auth: saYkpXdgGU6i5PXitLQQP8dVHrw
Message-ID: <CAK8e4Wvp+F0qoKA61acztXR0o9sf6kdkL=QP1Us9TTUMP274zA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Margaret Christopher
