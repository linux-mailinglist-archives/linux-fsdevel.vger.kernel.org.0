Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF895E6848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIVQUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIVQUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:20:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EECDCE89
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 09:20:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t3so9261534ply.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=51pxdnyWuflqH2RvjuEZ6HyDxmt8iSvufcZFq9V0LWo=;
        b=KrP823m6KG+HwbjLvMLAOy9Tqwq+cBBpDWAYr+PJ/+UE6udblBXcXqeYcv/JRnm6Id
         EkVND7vPLFqZ5DoyP5hEj4rHmAaXrMGeBCn/tpsWqvDxSd4wo8HqoHT3VJPWpp/KnxWv
         K2aNK39Y7EB1mUw+q9dyXer9KLxUTKjzwoqfZIdW2lsdC5vtd3Z8oWyY1rGkHrKqB6iO
         qIaPn8uhlylyZBPBmMfTVcua0VQyWyxrEp1iSZ7eWu21/0n1GZmNOb4H4vV8q8DjiHlb
         BSS5WGN1PcNGIPvTkT36frsvmfA4P7sBcBzmFL5LNSB5zYZVwQSkvwRR2suhcjMDGTmy
         AW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=51pxdnyWuflqH2RvjuEZ6HyDxmt8iSvufcZFq9V0LWo=;
        b=BILyaEB6NN7CMct8rxL0ztPG7VS7uiTBcxoORhw94cPVMo2AfH/RvHJSn0P2dpu0kV
         6kl/mj7U6+qasZssSrhLR8kfZ3+OrYF2iamZ9G8Uq1GZ17iJALzNAm3okDb9smmiZnBY
         rpOlACUCb+UMHrUsD5iILZDPtq2lMtcVfD/NQqjYy3hNjWSa7elud09Xorca/Otpr7hA
         SZzwGRRw1zVccw8nCD5c6CMFdCrzVe3gvtcmCb2Yjf71dvl6nCIBxqdgHvZcRocuFuVo
         SW2IBwIHb3opNHfgbAn+wGpSy+XxtmP8KVTyik/NYuzJ2Ob3BLXCisd+XmuATQOrZ56g
         Dgag==
X-Gm-Message-State: ACrzQf2ind75r1efMgMTvzAB+ejTMgUrt02ToBViv95xYZQqtvPeVQB6
        82OxHu54w4WYDTiim2dUuyGWJm60XY3Om5y1UVI=
X-Google-Smtp-Source: AMsMyM7/OSHRH/UEqqjYSYsr9tuz00LeDUhfKuKJpjMWtx3j5Jjnner+CVdbZpwMsU9dH3wy+7irbQJ3AaP1Bg3wAqk=
X-Received: by 2002:a17:902:e841:b0:177:82b6:e6f7 with SMTP id
 t1-20020a170902e84100b0017782b6e6f7mr4177936plg.66.1663863635878; Thu, 22 Sep
 2022 09:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4a50:0:0:0:0 with HTTP; Thu, 22 Sep 2022 09:20:35
 -0700 (PDT)
From:   Bright Gawayn <gben74325@gmail.com>
Date:   Thu, 22 Sep 2022 21:50:35 +0530
Message-ID: <CA+nOVsZk3Jue-FiwOnEJV05mx_CNiE_AsA8wyi1BybAf1Huedw@mail.gmail.com>
Subject: URGENT FOR A BUSINESS PROPOSITION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_80,
        DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8943]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gben74325[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gben74325[at]gmail.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 


Dear Sir Good Day to you.
My name is Mr Bright Gawayn,
it's my pleasure to contact you today in
regards to a very lucrative business proposition.

we use a certain raw material in our
pharmaceutical firm for the manufacture of animal vaccines and many
more but my company can no longer import the material from Ukraine due
to the Russian invasion war to Ukraine.

My intention is to give you the new contact information of the local
manufacturer of this raw material in India and every details regarding
how to supply the material to my company if you're interested, my
company can pay in advance for this material.

Due to some reasons, which I will explain in my next email, I cannot
procure this material and supply it to my company myself due to the
fact that i am a staff in the company.

Please get back to me as soon as possible for full detail if you are interested.

Thanks, and regards
Bright.
