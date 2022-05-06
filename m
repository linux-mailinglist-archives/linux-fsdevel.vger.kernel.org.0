Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0E51E0CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444299AbiEFVNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiEFVNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 17:13:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0A6F48F
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 14:09:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q4so5702340plr.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=DCL4ASSQyWhAON34kE5OIISSqSj3rOCfF8Ciqjh+lsqRdCfgeusA5Vwv0XnJkYI/K8
         PpoBtZS88yuL3et/lZLKleXxq4URSZD9f6MROtdldcj3gOmiMCUI/6TV1Dl/T+qpwJiw
         M0N+RaWrDo6cEqXCC4jcgWP8yqP5i27fdlJmL+Z22MNaap80xcYhj1kcUEIwB2pTrZYY
         bvvbxOCDGxpg/KNpF54H7KtPoC+ybJ/VsbbP4Y4Ldgfhj+OsOwqpuNJpDXQhyZEajcO2
         TQ+8Ad8csIfLm6I1rNVsM3KaAaNUHUcZcLEHvw01t2/Qn5zFCtxGu68RLxA3LTyrzGSv
         07+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=MGAeuzXTsSZr4eKjCoid8Xk4LQeEiOGOGfmSCjYxhQlNB1Le4wJ3ePMuSnWVNKjDyI
         /D0PYSbDOEwIT1pQpNo34Ij4NK8NgKSc4yab7aMuoKmTUFu3sLe7y4cwo58wZy84vUVy
         xh6xlnq6wFFnIa9qaJqDOQUNJD/UsLxm1VMSlO3C2oJMCxa5kB9uz2bFIDWAKI48RzJ2
         1NCWnC/NRQHz4Vg4B6qmyGkLKcyH/w867Dvm5sqtCJpWbMEpXKn7WIGSRrPTKxIaEenR
         vA1uEoTFupz/9y2Zp0d4On6Inw0RTyR0EJuOnFKgUNHchKAZStg/r6r8IMiAZ3u+nMUH
         JyRg==
X-Gm-Message-State: AOAM531vy/Ub3/LVGZ2b6CTL6P5XHqk7sRQDs5uIcO6g6Fu9N6RC+PEz
        2p0LkrM13+wtwHCe6bMHaXsYeQWjfr4QAC/daA==
X-Google-Smtp-Source: ABdhPJwp4Ke3UOg5WGZvnc+9zoj6LuBlmjaWEumAhXp6nyRAoOsi+A9K7QpSIh/DOmfrS0/kdtzDsFQAu7yldmf5qAo=
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id
 s1-20020a170902a50100b00153f95629f0mr5613774plq.120.1651871367333; Fri, 06
 May 2022 14:09:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:09:26 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:09:26 +0000
Message-ID: <CAD_xG_qmkaecRMLoM=8Av+-AOUpQv=7REEM0B2SR_6pXvr6_sQ@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4850]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
