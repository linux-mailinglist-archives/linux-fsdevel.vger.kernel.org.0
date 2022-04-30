Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73F515F62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiD3RFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiD3RFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:05:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5473A70D
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 10:02:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ef5380669cso113345087b3.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=29xFCebUVJXjkMUXmm/ZAe/1iG/qqpmKTNgtZIQ1CdA=;
        b=ki8jZkGEWcPT3g9EkdfSdZkzhsnL890pdgm+fcXYECLJx7LdaZektTLWVHdOqN0L2Q
         e0BjC2if5JvjFtUp3sp9rpLQMUemmJ6awCtk6gLIoUAWghY7TphvL8QeA47MSMti5MQ8
         UHQ3UpABrfhY0JUhDQhMxROuRWEoqQDuuWTXDnNvFjCFjNHW+ebS5KTi/O/mJlIw5gyS
         WHAbybjHet2xEeryaiMlTR6jn6muOa2mfAv8YGjRUAb0YiN2AB5alUeAcjgrv7aFxTZf
         8njJvRkN+kONXfsgQIzsljeTHv5acmf8fwtW8oNnFWujNupiuHd1nQgl9faOI+zcu2zb
         BXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=29xFCebUVJXjkMUXmm/ZAe/1iG/qqpmKTNgtZIQ1CdA=;
        b=DoYmBS8/md2h8VyTBqQtAKE6vGgtoB7d1ZmC0Ua4ZPOWal2miar5F36/3XZcENOZAx
         LvTa4j6/+3YxDRE6o/3wZCsvlTLlq0CMiE0fNxc123jQugkRfOIUvZ9UDmLmwcnKmOgj
         bDShVq72OJcHB9l6uwrh+gWP9TfjX/TgtIOvDUK9KkoCr8oC9z2FqsAWOJpyUC5EqxLt
         vAQrwQNrqb5MyoFYpcmr62J5PECwvReEghSoNDnznsqyjHP5lLxPhJeiYrt8VVGDRSd/
         e2bHFqW2U2iuDTsasxp5M/8dAvw3ozxga81U3/s8GJ9/LMYgtrwKcW5rgh9sfyLyURX5
         ccdw==
X-Gm-Message-State: AOAM532MLXTVWgUmKOX/9Xl+UJrHoCL1v2xremzefnpvos7meF8j1eSQ
        9WhCr+oGA3qAAT1AoN4zKiWgifCBSeCehFVwVG8=
X-Google-Smtp-Source: ABdhPJz/Uh90at9vpDn3yerI/bxWdeIb0BN4ObLV68xzHeQcJtR1CO1uCXVNLi3CGKSWEsGeByQPP/M/Tc1IV7uSzTU=
X-Received: by 2002:a0d:e4c6:0:b0:2f7:b726:2e58 with SMTP id
 n189-20020a0de4c6000000b002f7b7262e58mr4876778ywe.275.1651338126982; Sat, 30
 Apr 2022 10:02:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: carterannette557@gmail.com
Sender: grassleyh081@gmail.com
Received: by 2002:a05:7000:b620:0:0:0:0 with HTTP; Sat, 30 Apr 2022 10:02:06
 -0700 (PDT)
From:   "Mrs. Anne" <annl10390c@gmail.com>
Date:   Sat, 30 Apr 2022 19:02:06 +0200
X-Google-Sender-Auth: 7CAWAeJH9Md9wSycvG_GvZ46qN8
Message-ID: <CACZBPbYCVC_eBvF7oTDct_LfsXccNbAoG9+wHGCCLqBsrQkS7g@mail.gmail.com>
Subject: Partnership deal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5294]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [annl10390c[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [grassleyh081[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [carterannette557[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings to you and how is your family? Excuse the way I'm addressing
you here, but that's because I have no other choice. I am Mrs. Anne
from UK. My story is connected with the war between Russia and
Ukraine. There is a great business opportunity that I would like to
share with you. If you're interested, it's something that will make us
both millions of dollars. I want you to reply me, I will give you more
details about me and the business. I will be waiting for your reply
soon.

Kind regards,
Mrs. Anne
