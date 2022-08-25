Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4A5A0D97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiHYKMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbiHYKMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656FA8971
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a133so14851400oif.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=WVrT7yqPOntKnWuTcnp6ohm3aNDR6rm+M1fFy6pz7vT/eTpe6Bz04l/hwBHVsmFl9/
         2gMa3vpPv6kDgqus/73kHxePi2+SFjK7hGwLUQsON5UrXcsH51ZCUHJYKvubA7y0SE3B
         nV5qZ/GVFVSrCwmaLxcce8/5cieRMojRGpXBLloMsxLt6sFvRP89Qi53C1I2xAcrLzh5
         aFRAbeUP58g4/sC3jgOuHpHRHfNgaZCeKSZsioIFzCJLwMbU5ZktlSra12ftemzrORH/
         lpPjWLS6Ze6aGHHFLHdi9eAzh5l/1Fm6I2X27JtV4z6OxqFg6D0pXPkrLO8gSOdnzdN0
         6W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=MQ0/4xejU4o/5cQK6QnZYLiU/62gH50NvPX88hQj1xHWUIuFaZHfP5cENDn3MQl+BD
         nsGqs+18Dr4y14+jqAh1bagduEoMx5nG43jE3RN6N6Po/DbWzsN84lfJrZJ9Z/F8zp1t
         pSves16eRqxEmOn5WyTyGtky8JZVqChVR+u35mMkRy/vDjqS6QMePiP1gDjQPhC1cSUR
         VuKLhWR/Hb1/aodq/aJTsgj+cfZcCu8Jg/ZLBuqvyvDpeUbgihjb8k1mawgB2Y8E/RIz
         pMzivtADd1mUgC7riNuBJzJIa9Gj1/3hj3le+udw1agbPr4ulkTc/uphD8r401O3FHOo
         T9tg==
X-Gm-Message-State: ACgBeo19Uw0Qm6JYOct2xm9t7HAYzRP7XTc/o8oVRd4x2WZD9A7rLZHw
        75d9anmvWkvSxAL3d+KQBHPXo2L1McmMg9vF2Pk=
X-Google-Smtp-Source: AA6agR7XaHizPFBcl5BKqSkBv3mcq9L64QPIwA41PYTssY+wl8mbHGGS6kNbkL7S0M9D/teAM3HO1Aiho/BQnQVc/0E=
X-Received: by 2002:aca:b01:0:b0:345:4295:e9b2 with SMTP id
 1-20020aca0b01000000b003454295e9b2mr1456901oil.28.1661422329139; Thu, 25 Aug
 2022 03:12:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 03:12:08
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 10:12:08 +0000
Message-ID: <CAHi6=KY3-s6LUMt6WvNKm+pTNDSVzdCyjsTepPywmG=n6rT-Mw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bok draga, mogu li razgovarati s tobom, molim te?
