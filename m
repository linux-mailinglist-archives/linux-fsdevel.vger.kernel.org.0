Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7499545CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiFJG44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiFJG4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:56:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D69A0051
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 23:56:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h23so1957529ljl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 23:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=IZnWLy5VTez2x9hehvQwytbIideYP1HMf0sALs0d2IeALEOqzMUSnhHHNARgPHvzei
         BXTgtNl/CCsagPWKcnX4/O6H6pxHLcRxovj8nurOcjnvFYEWpvgoiO84tMXSPu+vIBv3
         lVj/xgYnazkHfio5w1ZmsvF3Jb+utt5VJEWjgMaNd010NAeYABuf674eBz//AQ7w3TeO
         HhQNYJdg6boaiYpjzaR6LNOifkczFhmjQ/67g6NuaKwWkjMhNVzp5CJtI/Sj9zcgihYY
         niXX4hoQXInjKZcRtg1woNu+maTZWUZ4LPBX6CrjeBnA4fqzLEwZqUCcpGS/pSW0DhD+
         MHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=XdPR8dzbBUnKYXLJtQodvUKSvV2qUv9A/0KcZrsuIllIM8q+7V8dnlzyiydh+3U2uR
         bW0k6lzh20r4xPZe++X23FBaKjFU3YZbfVVnI3bSqblfCezmIScTV68LYer5ukKjoYoJ
         Ax5KeFgIATBI+tQoqd/jH6yMxAQP//RsXJT9aohTAXd6xKQxP2s0CuHp5lL7k4Jo5TFb
         dEBpuCdz+n2HDVunZkRoCBM7TJR1gHFmWLFvYwlJ6XxDaPyqMiSz6SR8upcXT2zB+4+A
         fCaF4qcrJxIXwqPXcJj2GKpURNd0qhNO1zO5vvq0F6ttK7Q4TR9l85RGH8BoBKFGgPv+
         NsmA==
X-Gm-Message-State: AOAM530HhBpR9Ae1+hTQWLIA1Mnm34vzOyvYNtZJ1/eqLV+Y343sJdlb
        hprAQ3wV46Zv0plO5CMwVUX+KRq/5gfIOhY0MWc=
X-Google-Smtp-Source: ABdhPJwb+DfSadj8a6HNZxzTXGGmR/hNLKBxN4HbBiRmNApDiDk3smXLjnjelxPI1+S07jf5TOLbqsRmmFBsQBu96Xs=
X-Received: by 2002:a2e:8749:0:b0:255:81b8:163e with SMTP id
 q9-20020a2e8749000000b0025581b8163emr18359994ljj.463.1654844210713; Thu, 09
 Jun 2022 23:56:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:21c6:0:b0:13e:9173:8cf2 with HTTP; Thu, 9 Jun 2022
 23:56:49 -0700 (PDT)
Reply-To: mohammedsaeeda619@gmail.com
From:   Mohammed Saeed <janetobeid266@gmail.com>
Date:   Thu, 9 Jun 2022 23:56:49 -0700
Message-ID: <CAFxRUkvCe-zRYrTKWE9mN8evEm7bg2NPnJ0__zRdO=Ct1wrb7A@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
