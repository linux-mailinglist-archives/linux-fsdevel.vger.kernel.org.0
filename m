Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC369633293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiKVCDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiKVCDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:03:34 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFBC7213;
        Mon, 21 Nov 2022 18:03:33 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-36cbcda2157so130672307b3.11;
        Mon, 21 Nov 2022 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MZ0+4cnAIfX8CYYRaiH5tv4rfyf0U7kZyCR7bDyQ238=;
        b=RJ+ecxNeq5OZaDvi87MRj0jKdDnKxJW6vlyOn6JrVyHunWT+N3e5eVwoeOSFQSeHZa
         q9MyKsYrms9MjHtQN5ujcD00hNVidMOBEcxNNn6intEqcJjsO2re35O9qg4dW+81A0yr
         NobhVUJdeN5vG0tJNtLeufzWfcUflEtcpqpv7chlvZ5JJsyTerUCzrd1duPQsMUDwedP
         LidfeZR15y3SMMMXK9+ppwuoYRhZHnxVLApxkXydLfXko838yO9RIbvvbktmH0wky6v+
         zPPW5QV+SoIcgzwmuEYuIQXrzgHUQaZ6M3V48gy8Lzc1RwbDJZnQKzjOpxoHLvnSn+fz
         NEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZ0+4cnAIfX8CYYRaiH5tv4rfyf0U7kZyCR7bDyQ238=;
        b=3MIKYwg1Cr8texsqOXKrZhy0zVY6DLfvj0uvGUtXpphZ0Syd2UZypOnfaeelopsM44
         VB0pCBP54kU7i5oyayD+bzh81RZugQXdNQ8/qMuiDQlXfF4kgghq36JxNlN5OwY0EFSm
         gEzfLg71/I/x7E4oHeqEbNGgdQ0kIFIO7tz8y3W29IKY2tpXmlKYUJS7n5Zq0I96rMAq
         h/J0jcP5l88ng2hg1l+Q3NBL6ZhAY7kTu7MtB3cPvYyiyluQKq9gCtqJqitculO6B0lI
         4r2PDitXHScolkSM7AJOYu+48nJCmZRo8r7azBM4uLdISoiCvSXVGwTU1LhNNMXE/Kke
         0Xfg==
X-Gm-Message-State: ANoB5pnaIi4Cc+h5roMQv3pAZ3oag9ZDpgj4VymXhRYKHjs/+swpprR9
        +TjBbUuCSC7eXZRHKCWB4BPnEtWcoUDQalK2XdyFmo6IIr9FbA==
X-Google-Smtp-Source: AA0mqf5WTEPcR1uyF8Gei17thsBbEMzCy12Xx8sABUso05SpPDnwmB8i02rN6v+5a/2gnxiJ6HqrYFpqcaJF98ZDpGg=
X-Received: by 2002:a05:690c:691:b0:391:c586:65ce with SMTP id
 bp17-20020a05690c069100b00391c58665cemr2439803ywb.65.1669082612716; Mon, 21
 Nov 2022 18:03:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:9f88:0:0:0:0:0 with HTTP; Mon, 21 Nov 2022 18:03:32
 -0800 (PST)
From:   Felipe Bedetti <felipebedetticosta@gmail.com>
Date:   Mon, 21 Nov 2022 23:03:32 -0300
Message-ID: <CAFO8usxTRUKjioUXk7thEhocooQkAbfUiyF9=Ari+bYcfCaxYg@mail.gmail.com>
Subject: Fw:Norah Colly
To:     linux fsdevel <linux-fsdevel@vger.kernel.org>,
        linux geode <linux-geode@lists.infradead.org>,
        linux hams <linux-hams@vger.kernel.org>,
        linux hexagon <linux-hexagon@vger.kernel.org>,
        linux hippi <linux-hippi@sunsite.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,TVD_SPACE_RATIO,T_PDS_SHORTFWD_URISHRT_FP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.5 SUSPICIOUS_RECIPS Similar addresses in recipient list
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [felipebedetticosta[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 TVD_SPACE_RATIO No description available.
        *  0.0 T_PDS_SHORTFWD_URISHRT_FP Apparently a short fwd/re with URI
        *      shortener
        *  1.6 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.7 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://bit.ly/3gkfct7
