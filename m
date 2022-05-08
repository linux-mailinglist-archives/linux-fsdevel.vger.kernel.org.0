Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82FB51EAD5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 04:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352236AbiEHCTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiEHCTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 22:19:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423111152
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 19:15:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id be20so12576512edb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Cr4jqiwCZqgvtQ1mPAG6hA/aEXX0FhXJr8HGvR+MOF4=;
        b=hIE5zwv2rTKn+CswdyopQHf0jMYKWFxRBF6odjeCxWBM/WRdVHzPYHl78NQfbEd29K
         9enqxTUB9ZAvVAoyjF8AWhpC+f5IVcnJoMj+unQol6NBiW/KIRN+RPaYSq7RoP62yjw1
         2X5NuVc9b98bRcPhXJz7ydAIkaPKYIMfoxEKnd5fu9ZsX03fmWcqseP8+bykpooAanlU
         h5RINDqd4mWKTcsWni5bShtEPJLQkkRYT8dOneNqwF1lDvdzymwuLYp+4P1W1ToIwe8o
         DNyWfhk7sajXrmDQAaFVYyGNgCHChouTJ3BZcW21ISZxH2nUIlO4cSJ32UEeiIotkomt
         QV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Cr4jqiwCZqgvtQ1mPAG6hA/aEXX0FhXJr8HGvR+MOF4=;
        b=l/vF2VnVnxS4oDG1cq0apMDpdhs+g9Km++vGuU/S5RxWEsvPEWz8A1ExE2iIGT/ogC
         RzAkVC4TeXEz0iIAdAq+D13/t28oNmdeYCk78dGQvFYYYfm1dbRuBllrMp7BysTHUyqj
         +rpX8z16a4KOIp9qr7LWaF3RZGJqGyltg/jfkZmsV3YBCZy/02KimPQhEP1EMQglXRJg
         mrb3VV4LFQNXM5jo09VBqqZqmc8mVrmZawinXqm2DPPMQey9W7GGOMKM82qMBI753Ft7
         h5M2KrrlJNRR6ZTvahfav0dPu8cWBI2Mt/gFqP+W4XBtYllMHoEGYG9XZdrvdY3lvz1D
         MgxA==
X-Gm-Message-State: AOAM5320l1NzG29OQtziz/fdqhQNhJDX0f0AmjyXJlHRjtBHBNEuXAV1
        4qOKXcjBayztT4VYCz8hOyyGjTdRRyWRNNMIk6Y=
X-Google-Smtp-Source: ABdhPJzTI/QqRCdwIAmphqF9OzyyYNq5Vx7Ax17gRaKdquRTzXBKHWHIi7p9/pNhdRsw+jE0joTHzv2TJm/aPiu3TUo=
X-Received: by 2002:a50:ed0e:0:b0:425:e476:f4ed with SMTP id
 j14-20020a50ed0e000000b00425e476f4edmr10770566eds.32.1651976112082; Sat, 07
 May 2022 19:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:3554:0:0:0:0:0 with HTTP; Sat, 7 May 2022 19:15:11 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. David Kabore" <dkabore16@gmail.com>
Date:   Sat, 7 May 2022 19:15:11 -0700
Message-ID: <CANLKR0vzXK+xff8dc1NLRToAvTmMja99WOdUionm413PVRoNow@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dkabore16[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dkabore16[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello,
I'm Mr. David Kabore, how are you doing hope you are in good health,
the Board irector try to reach you on phone several times Meanwhile,
your number was not connecting. before he ask me to send you an email
to hear from you if you are fine. hope to hear you are in good Health.

Thanks,
Mr. David Kabore.
