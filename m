Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE77BCEE2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJHOQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHOQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:16:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C9AB
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 07:16:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so860623a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696774581; x=1697379381; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=iiNlVsACpMn4/XRVT3olDitv0kTaM5rS6K9cYysowPed8RT6ENppz62hv38g/AgL93
         8hM49+zOqMxm4Rrl+5jIgPDUz+bGfWAzFp1ae/knvB3zFEnIxfZNKT3D7iIsWbaB+g5M
         jJ5oaR6XWEq6UuE76Aeac/qfQmR+vMOGUdax5CYhkkKKNQUVwAJRAC7d50M1yv27q7+t
         eXrGfR4IMETEvQz13ho9HzjB0IYy48+wdfacMBCzu7q2tt3tQGyIhtApSj0TAf2i/51t
         TtvdLDjmAjYjqA8N8VncYk9rWuDeazvmNLfnIQpL7md9jDI/1usaFFTRl20nrorG6MXA
         mgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696774581; x=1697379381;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=sRMzhT5LfP0/2y/q6D6NMX1mHFhsfocja78SjhgeN7ks7MnahCGUYtFDSlmRHKVqGp
         6QBK4sOG6DSHL8VvAMRFcvkidBDSye1HpQ/DdN47nWaqMwfBD8VaJTIezVw8tIpg6kE+
         je7muvC2Iy9sfLfuUYXPrKNaviIRWuyIm5Gvo1enwyltko1Zdmk691tDCN8XO0yfq1rZ
         DJ+QU8FPgT+4Hao7sfqMU64FoyLaCmEmnJ9iWkHmueDzEkSwyXB4d0ewhjFIF5aVk13L
         aSsn8mdy37cb9/uxKiHi4fOwc33XAoSg9xLmWt63YyMSHGeUKBAJLb5L18NEBDs8Du5U
         aTZw==
X-Gm-Message-State: AOJu0YzLOPH5DtWOTo9VkDyoaRcmN1lluCelTbEpxPa0eXwupvqTzAzA
        kD+kHmBISCW9n8dgPTTtTLxVSqArtKR5u4pG8sU=
X-Google-Smtp-Source: AGHT+IFYAugRoGblZJ82Mj31PV0MM0EejsiFn60OUnbAKLmvEUZykVR68xRR8rPwkwbVNWs3hpuSo2jff5RCUP5DlZ4=
X-Received: by 2002:a17:90a:6b83:b0:26d:2635:5a7c with SMTP id
 w3-20020a17090a6b8300b0026d26355a7cmr11387798pjj.2.1696774581448; Sun, 08 Oct
 2023 07:16:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c685:b0:4da:425a:267e with HTTP; Sun, 8 Oct 2023
 07:16:21 -0700 (PDT)
Reply-To: stephenbord61@yahoo.com
From:   Stephen Bordeaux <samu7582369@gmail.com>
Date:   Sun, 8 Oct 2023 15:16:21 +0100
Message-ID: <CAGykCHoxfO5u_58dFbU0WPT8aVzX35qr5N48q-28aKV6ez5Hzw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dobr=C3=BD den

Jsem Stephen Bordeaux, pr=C3=A1vn=C3=AD z=C3=A1stupce z advok=C3=A1tn=C3=AD=
 kancel=C3=A1=C5=99e Bordeaux.
Kontaktoval jsem v=C3=A1s ohledn=C4=9B poz=C5=AFstalosti fondu zesnul=C3=A9=
ho Dr. Edwin ve
v=C3=BD=C5=A1i 8,5 milionu dolar=C5=AF, kter=C3=A9 maj=C3=AD b=C3=BDt repat=
riov=C3=A1ny na v=C3=A1=C5=A1 =C3=BA=C4=8Det.
Nav=C3=ADc v t=C3=A9to transakci chci, abyste odpov=C4=9Bd=C4=9Bli d=C5=AFv=
=C4=9Brn=C4=9B.

Stephen Bordeaux
