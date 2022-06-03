Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5753C953
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbiFCLaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbiFCLaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:30:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA53C704
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:30:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so10036610wrg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jun 2022 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=bmosYdlvJI0Y/CFkqkE+BHmBmJAX71AWTJVNhm8A5c0hEz4NHWV/CrPoumMjLz012J
         jfrBBohGSawRbRFoRKiBrJANtRsNmI5xBU5CvixrMCDYHXKOt3mUaJan2renbXbwsXHd
         Hz+qSPRnDOXmIsfRi+IfHpmfOsgw1tUv3DpmLQbUxuA0B7ATMF6t682ZDwOvXABxLZVO
         PJ7RIX/2w5YrfS8ZhicunAo52QbrVGlS+tRCKTgUPmg0+uw/k17VCyKJv92v0XHDvEwH
         +r3Q42Kn1qS0wMvHcsUDSe8BjaWb4ptz0M5b4DcbhcUyrXzz1W1CL6zhIzXSgbTJKGRr
         o8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=NOY8Kv1fkU5TDP/kOHIjLP90g/Nx9Qe4h3RtUn23IGmH3XTFmqI5o4sx2EEmsz3gvJ
         aPqnXhHGlPojobKlpwi1eluviqF0RxnRc6wb+MAe9+3nvWGjcYfKmQlbFTGReM1sbU0v
         JlUY9wRHozOUXIzPpWInQI7avSRvHg4n0VABoRrcXl4y4l1kM/wL4rgGeQrwcDl10zH/
         G4tYBCsSYB9TAQY5Cp6GdqPLS5LJYjqoKGXIBRhqomy/h28ak1tJfcElIWMZC7xohnug
         RAD+oJkg7sFAbylSdbC/yJ0VTF5FgSTL8MhcM++Hz1VX47w4Y/4m7gCtUkqrS0nWvaAe
         EvgA==
X-Gm-Message-State: AOAM533LB6CBnR9avxe7Xb/M+x15IMhiMpS9e3fgEcb4Yga8rPGAr+QQ
        DAH5y9r0/MHMTjSVFKK9FLjdKqEMWDXw7rx1zyU=
X-Google-Smtp-Source: ABdhPJyOa3g6x7XP36+UV4CuNXWxr5PFL5mtXjhKuaXIKP16+9oblr2bELYJvePBVWTvpJDl25XGhpcIKSVms1VvJt4=
X-Received: by 2002:adf:d1e9:0:b0:211:7ef1:5ace with SMTP id
 g9-20020adfd1e9000000b002117ef15acemr8134247wrd.282.1654255809644; Fri, 03
 Jun 2022 04:30:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64ed:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 04:30:09 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <mariamabdul888@gmail.com>
Date:   Fri, 3 Jun 2022 04:30:09 -0700
Message-ID: <CAP9xyD1Q3FfbF4uYb-1dwbaqKfv+o87VSSQMHLLJpYWisWzbNA@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hello,

Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
