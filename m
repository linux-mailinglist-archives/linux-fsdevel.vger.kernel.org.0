Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CA582625
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiG0MK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiG0MK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:10:56 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03C23BCE
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 05:10:52 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id a63so14650684vsa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=EY0waVmGLUine/s8tHPgn0tmi4Bk+in0wnLge/5sSUsqNY6CGR8QmnhW3ZUpcwYCmR
         evCf0CWCUgDQOzklDWK7muJ3civznvYwrNikajSautwWWRzQ/XrPYLyoQhxJpPWXzOMX
         cg6Tc6AT9PLIHXixiwApvLE8hTiamEXFr4t2SNy+bpnEvvhaIzIlY4o4xgU9IKsqsRfj
         YkMH2sCl0anh6FZjJX1GrEf+1HFAKAIzW3p1olJPn56lwr29IcDDWPQ6SPkkzSZbAjgj
         BbcpusOCXSp8LEY8APDPqPk0ZmjT62ardhuk/hu92MHm49Kf1dp7s6qjTlYA8k3xsl4i
         dVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=b2XgvBbzvM1JQNPDOJV0n+IkdatkePwzJFipAtQKWkdDC+/0SY3QtqqNfcoehssPva
         huP2KIIUSiddn45uZA+U+zMNs2lyv+PeF5lqtuA1srDE1n515Jx15PM2xpvOA6d/+NA4
         PDQyk2esZxJaPGKD+CKGZhJPXnTB91oCLvgxmSTJ3sq/Ggkk6jVzvtOx7CkyQf5nVXaf
         EuDSk2s0rwkTvSZyPJfzoaqTJIBAT2IbPMLDznCuF9Dkq0QokcBULQDCVSGzZ6ZFhcJk
         73F4O1zEQaXXKqq89MtI22qDAVXy0gBu1UQh++Ib7eP+XICUuFSZFmZjotG450+9HMpc
         O7dQ==
X-Gm-Message-State: AJIora840Zku2+o+LPhYJppBQqr1F7LupraXhbeqlf45j2aNpuXoZEJp
        c0XNP6jaNqYT9TbwbZ7qQWSbEmJYhMaxr1Thl0M=
X-Google-Smtp-Source: AGRyM1sZ8vsGV3lo3RC3emo00Mp7BzKX9wKrYfMQd34cZ1ceZVJv/PBzZMk2D4dVUmoINVokLcydzxc0fwOqnchB/YY=
X-Received: by 2002:a67:f649:0:b0:358:5ffc:7b3b with SMTP id
 u9-20020a67f649000000b003585ffc7b3bmr4770886vso.67.1658923851138; Wed, 27 Jul
 2022 05:10:51 -0700 (PDT)
MIME-Version: 1.0
Sender: hadjara.sawadou@gmail.com
Received: by 2002:a59:c74c:0:b0:2d7:23d2:7328 with HTTP; Wed, 27 Jul 2022
 05:10:50 -0700 (PDT)
From:   Mimi Hassan <mimihassan971@gmail.com>
Date:   Wed, 27 Jul 2022 13:10:50 +0100
X-Google-Sender-Auth: aru1spH_Vggc9EL-XZnivgP23YY
Message-ID: <CAKFm-kEa-aGta+mLLNg_xt7PHta03q12L3WSKe3rmoCCjmF-Uw@mail.gmail.com>
Subject: I WILL TELL YOU HOW TO GO ABOUT IT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad and i was diagnosed with cancer
about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
