Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48604688AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBBX1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBBX1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:27:42 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA4E84193
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 15:27:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mf7so10678744ejc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=heWb1xMc0kW7nJACmZqD5FPkmEnTyUHQDiwcYuLjy4JwhpOrWLmFRkvJD6HKzdrF5h
         yG3m1TV0lCIOO8tCtXK+lWlgJiXua4IR+JbnMv8CtGvkDvpK3+I0UQBwD5CXCWbjDA+V
         oStuz8v0zUoiXfUNCsV04Yr1zxxCaqvzA7+BKEzrwNhDC5oGyfmZuZnMyktAR9XggEi6
         RQUyVsjyC0UpQzNKk/SbCoQ81x8W/FNj0UnHRLjcviES5qtECep+1kpSm+6WedRp3fFH
         EXGNdN6OnR/ZvLM6mEjhToXBSihr1o8Zg00aoXjIbdv+mYXP3jK8EXnSdD8cFg7srjFG
         Dx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=l8BD54ON/CSiMM7RQRo+PAyTSZy9V1iVe/P/1ZK42cMWoiBGi+f95QVjX9tTMILsdY
         3KoNgDKlekbQgsrXipQ2HvAZeBb/0MGCCPrRm/0ovKbt6hHmJ/rKGW8nJaclFfBL51nK
         k1fB764goyj2TckYlg2WhU48J/uNXOrj/JXG+AMJkm+zCR3dJjqVqFxyFaqQOoWN95Sj
         hqCYOqf4xLPSZkNrWph19Ziv0f5WVtPcn0GOL66+fdUdF9XOkSG+vBBdfHMbV2YM8/Au
         WTMekxQpkeNtmDW+jBRos8W8LUb3oED/nYEERsliKWmTDWxwJOEr3bM+Socq84rPMI8t
         pkWQ==
X-Gm-Message-State: AO0yUKUzOxyuOaH0512dK6IoWX4OgZSTS+MtVvYX453KPBk/N3td6pPF
        yN8yyBy+YFw2K/IrUD9Y5PRZSfoMnB3cW/NOrpg=
X-Google-Smtp-Source: AK7set//Vh4sVRJuzbpqu4kJR/bLi6/hkM8I8g+2xS5cMgoh7Da7f06HnK7YDuOltQCnTE3oSHcHr/WAN0j4OAYei1M=
X-Received: by 2002:a17:906:c243:b0:87b:d73c:b064 with SMTP id
 bl3-20020a170906c24300b0087bd73cb064mr2240865ejb.124.1675380412982; Thu, 02
 Feb 2023 15:26:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:2130:b0:87b:db63:de32 with HTTP; Thu, 2 Feb 2023
 15:26:52 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <chiogb003@gmail.com>
Date:   Fri, 3 Feb 2023 00:26:52 +0100
Message-ID: <CABa6GnkLC_m_7SOGtL_oOqUXjf8TWNj=AjSEgcd=mjgy=ODa-A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chiogb003[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [chiogb003[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
