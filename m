Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0573656BA52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiGHNIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 09:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGHNI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:08:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EA26F3
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 06:08:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z13so27093217qts.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xHp6pFPauvUVGMaAi1JKSCFwXY5GCIPC+wlnxr52Wi8=;
        b=D9myR7Uh1CrtX6CWE5hONol/9tawcOMjqWZ7AvEt7tVqE2g3Hv2pmEKAJV70D+d3HT
         tcHuQuqAmyECj6T/O1mAwyQ/AZaCH9Mu3B/wjRI5Ljix0ctP7v7bXxgJkgt+CODgKdM7
         QQPjMIyay1SYkZbdCuNa0RY7FIYlaIGDuYe0OVo9s7tVor/384x7q2IFzMt8W7GYHbNP
         knPM6rmabTEgRtMU543qMW9GC6s2AFhLhLyL4xUekBRmLTimVyr4UBfZDSuh3j2ihJma
         bEWeh4xKmglvq2lWHaRFLJngU2QWNB9LMvsu2XGgibIu4D7u4ziAdY1xjy+di3+2Xl7U
         afJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xHp6pFPauvUVGMaAi1JKSCFwXY5GCIPC+wlnxr52Wi8=;
        b=UAOf5bykZzZyq2YlXhulfSlWEYQ+2DWq/DeJSSHC7XRyn5fmwlYaOWl7Ph4NYkugfi
         d+AgE09deR0tP3OAi7biJ95nC6y08MDppkIEnRzVgqJqvXo9u5x6f+TvameuGCt9Nlmn
         YTBI+OJ+jV5n2ik6noPc2cYN1dVsURIAtfAk8bbUptcNzK/xTsns0ccWNqQQIwUVN1vL
         KCFqXqsLjDAwpIv/otNSiktHpH1Vze0OAbSQMYV04JwkxH0NvJmgAenpoLOsAp6OtHRE
         SwnZhIYQcEV4SVfyCg5m6/LQUeoiW7it2BmtW65HfbBS9UIqrTtiisdgiV/8zxKpHZvz
         5H/w==
X-Gm-Message-State: AJIora+AXazNM+vImkVo5uia3I64AMlxct7SZQHK8KynkRO2mGlo35xp
        p+XhrqkZUVgCkCiHJ/teU4otsTfhiZylswdt5yU=
X-Google-Smtp-Source: AGRyM1t9uuo5iv3j5IO6wQ650AW5YzATQNUJB1/PBQFzBaaexo38+kz1imWagFdHXbQsn2Igm3WXfyvpICax7XzY8lQ=
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id
 y12-20020a0c8ecc000000b004732fa4df7cmr2612436qvb.55.1657285706660; Fri, 08
 Jul 2022 06:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1bce:0:0:0:0 with HTTP; Fri, 8 Jul 2022 06:08:26
 -0700 (PDT)
From:   "Frank Kliem Antiman[treat confidential]" <frankkleim@gmail.com>
Date:   Fri, 8 Jul 2022 06:08:26 -0700
Message-ID: <CAM45ac4daGjVwsz1sde3ZR+Lzb6e_eO9pBDBYuHXjc7APiyG6w@mail.gmail.com>
Subject: Mr. saLIF.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:833 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [frankkleim[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

I am Mr. Frank Salif Antiman, I am a banker. There is an immediate
opportunity of transferring  $9.3 Million out of our bank.  I would
like you to stand this chance that will yield both us great benefit.

I look forward to your earliest reply for the  details.

Thank you.
Salif.
