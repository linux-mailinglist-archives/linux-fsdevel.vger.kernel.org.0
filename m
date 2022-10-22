Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E9608B22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJVJyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Oct 2022 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJVJyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:54:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2382FD097
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 02:06:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n83so5775289oif.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaaSLAJ+hgNGNq49WyPsh3ndDLo+mnrYcswrOHpJSv8=;
        b=nNMBkCIwl/6gK+toGqNRGG/YLL0fF324bx1qaOH1y4x3OIjxLq/HHYoLEQ6DIXVMhZ
         yBP/JqjfeKgn2zVw2pvLxCg6MQgOccj9D0PS+BxibSDKUMZPqFuO1BH9rucwVtk0imfk
         Uf1JB6y6hh5nwSF4l3nIHzMcJeO23qzW5xyKvOUo02NXv/UxA+fb1xfQ7gd0wj97+Png
         rtJzhayXE1f7/T0HHp6tTaPH4f4DE9rtLLXyoMLmdIeuEqEwHYp6KAIXioE2APt9Vqok
         QcnzNnKCtevhk7rrd2+8KLFUz2JMtjuKTuyIwbz60pUc4RihSWynNyvtYnVRFpjOFC8v
         n2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaaSLAJ+hgNGNq49WyPsh3ndDLo+mnrYcswrOHpJSv8=;
        b=lE06CalBsG9zJE52TkWCJJ5n+3XbaZI3rJzhE06P+Kn9PmNVcZM6o96lAiE7YSpYEU
         MW6SBoTQefSkoTh14Y3+LoQMwTK09SzXrxzzPjXlUnxRG6Ys4CQYLNUKpYUWW2R69su1
         grEQZpPYfc4F80KtYXxE/xtpEBr4wmG86jaSJI3UlTxjYj2dVTIKlEoex6SFnJ9VLml2
         pEj67xzWQ60L8qoV04gq2puB573AJQlNAcpGUeoUprVvbMcsq2RVu5eJYdB1xvAQRaqB
         yb5O6afVPsm/LLReXGsboumRw8xYouWOJYR3yB28qTHMkl5Ks6aGCsGsNaWTDb9RBy/y
         eYMg==
X-Gm-Message-State: ACrzQf2rKqo1OoM0O+OvftheRRditfqJuJgPJAizk3nIR5md25jl53bU
        O60JyQhDW8iw905kJlw5qBuqlyZnevI+5k9DyPPxCiIwc5M=
X-Google-Smtp-Source: AMsMyM7DV/UQjMDmfWUDARQEST583xXUpUhZuwI6Yo6QWpU1NylqbjJLzURvxWrib8B1x1GiMXZKxXX9K7ug1XjFr6Y=
X-Received: by 2002:a05:6808:13d2:b0:355:1770:c6ef with SMTP id
 d18-20020a05680813d200b003551770c6efmr21666671oiw.284.1666427448022; Sat, 22
 Oct 2022 01:30:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrs.susanelwoodhara17@gmail.com
Sender: mrs.arawayann01@gmail.com
Received: by 2002:a05:6838:aea5:0:0:0:0 with HTTP; Sat, 22 Oct 2022 01:30:47
 -0700 (PDT)
From:   Mrs Susan Elwood Hara <mrs.susanelwoodhara17@gmail.com>
Date:   Sat, 22 Oct 2022 08:30:47 +0000
X-Google-Sender-Auth: UfMdHY-IGn2vy7vhRxwr3_PMsYw
Message-ID: <CAAOf0OErkdBB+pkMfQKO+67_RwCPJjBUpQs9uCH=U1CN1QD5=w@mail.gmail.com>
Subject: GOD BLESS YOU AS YOU REPLY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7366]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.arawayann01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.susanelwoodhara17[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.susanelwoodhara17[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

GOD BLESS YOU AS YOU REPLY URGENTLY

 Hello Dear,
Greetings, I am contacting you regarding an important information i
have for you please reply to confirm your email address and for more
details Thanks
Regards
Mrs Susan Elwood Hara.
