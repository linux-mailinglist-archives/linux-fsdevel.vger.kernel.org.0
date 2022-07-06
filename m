Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62F5568F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiGFQ3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFQ3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:29:11 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A461F2E8
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 09:29:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10be0d7476aso15172625fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=QgMMumAAdkFl9uP6HoPKg/Fb6bE3fKeDI5uL0zTPdqc4MWWKxeRbkLfsuizRb/Un/T
         qGQqY2EhMDYqozwlz5yE2c9XwIaD3wJ+yOP1XvKGiwdG2zakondN+iZDq936YG396p5r
         HXVDzkcWSoL8tJjEaexi6AGQKZd9XmRTySFIP75iM2VcHmWwuPSsBwlcvbQ7ea8BLviM
         94zSK/25kgvVaUfCpVdtWjzUs9QxsqfD/X9o/tqojkK6eRDrThU/WKnTkwcHRxIls6la
         6bx55gaI48mJYnY1IyEakDkeUdBTH+nWs6vs5YOasum8Xc5Ikr5Fx/GV35GC1FQoiNxy
         WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=4hU9XeuFDxvHD540yQ2WSfmgXL8Zl2BWTF6RKwqIQUHs17JriIUOUnenwob4Dl88C8
         /6aSlo0J+C1iyzaNlfFUA7WhJWOrp/06qr7wk30IA+wMrTDitMP5SSCD6vQ+FByNRcjH
         1b9acL/qIu0ORVv5xYaTBSyfynfx5xhHbznUPw88iMA13S6ksBIPVtEN4dRtoLkEtrlv
         1wrDA/7HFJDqyUGbJrs+uAk0DDmHJT4F3u/9NMxBgSDscWgjWC6J33soEiJmR8Unr3YN
         wP7T5fGhGf6qsm+cosjCJIWik0l7h28889DV3XPNkH0kiYAqSiG4HWG6eMKYeEC3ZO/R
         Qt2A==
X-Gm-Message-State: AJIora+lLvF+YEH8rV0wn4za0QF4mPBDAjgvLK9NevEoL7jnT2qnX4TV
        1gz/BXU0xAQjh/Sp9dY3zT5ib4D3h0yewpbD1ME=
X-Google-Smtp-Source: AGRyM1sYIDQaipmK1HIxCIfXWusHCGVoFn3KHi3mv10f6b9/HhrHnMgE+fQlYptfnfke+U0OK2ab7TIRG505IRdV2GU=
X-Received: by 2002:a05:6870:7022:b0:10b:f0ea:d441 with SMTP id
 u34-20020a056870702200b0010bf0ead441mr12099099oae.39.1657124948656; Wed, 06
 Jul 2022 09:29:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:29:08 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:29:08 +0000
Message-ID: <CAFSKFDb+3nsLYO5L=H4xpNs7sNRxwrb8q_Rv7mL=k7u_Jvi-Eg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
