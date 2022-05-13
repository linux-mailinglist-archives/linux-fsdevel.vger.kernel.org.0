Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB352661D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381324AbiEMP3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382121AbiEMP24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:28:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792822AE05
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:28:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv2so8347021pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=UP/wcI5i7Wn+NAXGibB5Cvxiqo4tDGbjDOHuX3Xmh0+IaTf6wweeWOUbVjSarIbjXE
         BMgZSYDJoEyXz7kRFC3lI/AatV2wRGuBhTKEutaZUeE3Anibu0x4lHmfyZJeXfh6IFbF
         QhNCBldxORZRIWpYytC0mPACh5u6H2Mt6rNwrb+gXV/B6fNj87DX9gYLg+rAh4uy4X1m
         JMwRxxmON3IccYxSyTcmE3nA8tgeaBNAVB7YLOgCoV/jjkQmr2EYxmQme/79/jNlYegU
         q0M/wT1BiVa4A8pvlM7Nx+2L97xBAgXujqSi/R3LmqJJOXsihsSmdiyf90rEz9MkiEus
         9pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=0LbQQJKUUsMm1UGBU1V/X0XDaFzeffsbnvPSCDagNGOEKbM4gJlhVKjMjtrFVRtRky
         S+FII4BoEfyn2fqq5HasUNzvy/fWBZJA/83XJ7r/9p8xpj+F3n02DJZPrkYdZdBbr0Ja
         QhXYgbB+B7KAK0LYOXOKk1OCIqbB0+nDwyzpZn5LIFYMT78rCfnVCxZvwrcnHRAr191i
         dUaqrHX+15hK5eqeZ6i1y8I9Lk5sxtwnreGRub35alaLSR8WzsVx1X7p3PsN/k3TqNZL
         bzECkjeOF5kW7ZACs7W6X6/jWMZJYEj0uyzfxFNeyKhz0ce3awqTtuqe1aVx6Q7ow8Cw
         6Z6Q==
X-Gm-Message-State: AOAM533ux0mIGfdRa11iStUmeihhNUC9MMlr0/7Fg6djq0AzpAo7a8Oc
        rTHIiOAc3FhvNdai/gsp1lXEBSRP7xqGXD5/D2o=
X-Received: by 2002:a17:903:18a:b0:15e:c983:7c14 with SMTP id
 z10-20020a170903018a00b0015ec9837c14mt3865500plg.9.1652455688566; Fri, 13 May
 2022 08:28:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a4d2:0:0:0:0 with HTTP; Fri, 13 May 2022 08:28:07
 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAGMjROebjV2xWGDB2Fd=2bYhPSVZe6sd-_2q_7J=qH+90T9ewg@mail.gmail.com>
References: <CAGMjROea--YTOdK7cKfPoCtgnAx=JnnrwVK7Zu3xZD8QZKh5YA@mail.gmail.com>
 <CAGMjROd8L2yWBg3eBKSGNBXVVYjeKexS2XiVef+4VSXaJWa-Ew@mail.gmail.com>
 <CAGMjROfsdFu4P7kueCOnQKqTeN0nEAMefr=t=G2f2+3SYvMxEA@mail.gmail.com> <CAGMjROebjV2xWGDB2Fd=2bYhPSVZe6sd-_2q_7J=qH+90T9ewg@mail.gmail.com>
From:   israel barney <sylvabou2018@gmail.com>
Date:   Fri, 13 May 2022 16:28:07 +0100
Message-ID: <CAGMjROeMsUQ+To1E=w9E73B4Ezep17XPa0+fgsi3yU0qgqtWcg@mail.gmail.com>
Subject: Hi
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings to you! Please did you receive my previous message? I need
your urgent response.

My regards,
Mr. Israel Barney.
