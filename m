Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084246490BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLJUya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLJUyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:54:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237317061
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt4so6550709pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt64dSkBolv5ppRHuZCl9INs9gRIy8g6/q0FYPonc8Y=;
        b=Ifh8eOiGRlxikPlWsMEhiSDP/c8Qp0wbGyAR0aXli9q6BmS0J1bNZw955q3fVJMjZX
         mpFGthGrzk3Q1kvLqRR0nCw0IpBDePelJhYN9C9abALM3GUZP2FPdTv9J9+5h9wCkfmW
         q4mqemlfZSsKdBNfhWg2PO2baVI/2WcbRUaSQ01QMM/KQXOG7cAvX0QN8Y1M9c2i18y3
         zqLjqZVm8VFtsD5giRyaBkcl1N/zkMxa9+tUtpcARQvHqR2J6JqxVA4jL1GXja2TnyMp
         WP12UkzFAq+rTaThWsxnjOzopjAs8cmPeb+DB6zpgOwkYPkOzCc0CGAK1u6tK22wX1rf
         e7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt64dSkBolv5ppRHuZCl9INs9gRIy8g6/q0FYPonc8Y=;
        b=qwRnEuWzD9WJoW1TApMYNOjmMHpclymrimLFRUiNCQrcG7fVlWKjmUXiF+Y1/zu2SY
         Qsc95xBjPhcZCCZyNSftBxpOW+YJJuPgewsmw9mHQkLDDbjln2i2z9hy8O/JnTp99nPD
         dBt8z42QutspxlpPdOUDoarUfT3rA8q/jrnLmND3e3rBHE7v+m4mcX7cY7FDcHvQwlj9
         4Lyrc4Eihs20uJJ7tlFL8Rvd3OjfBK1w8yDXuVBFn9/bvAifGCkm23QlpAp6pe77AA97
         ZgSBi2k+51cKntIQdnj7KLkK+Z2ImFZYWJdmpRlMbqIp26r/0XurYdnf5h4TRmw5Gd5K
         VOYg==
X-Gm-Message-State: ANoB5pljeqICSBhh+ywbHWd5Xyqmkd3uvBYHXSm7WFtSzghUkb+AKr+j
        Q8CO8f+vdqh/ThO37gOZ5W6ma0I3ranrD6Hj
X-Google-Smtp-Source: AA0mqf6XRFKdZY9e7RMycepi/bZn42yRXCpEEIuviDXkF+0HDNLMgPK8SHMOJabQ/z5xyUJYcuz0/Q==
X-Received: by 2002:a17:90a:a894:b0:219:8e37:3d81 with SMTP id h20-20020a17090aa89400b002198e373d81mr10399274pjq.14.1670705660518;
        Sat, 10 Dec 2022 12:54:20 -0800 (PST)
Received: from [127.0.1.1] ([202.184.51.63])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a7b8900b001fd6066284dsm2864132pjc.6.2022.12.10.12.54.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:54:20 -0800 (PST)
Message-ID: <6394f1fc.170a0220.c72d1.5883@mx.google.com>
Date:   Sat, 10 Dec 2022 12:54:20 -0800 (PST)
From:   Maria Chevchenko <17jackson5ive@gmail.com>
X-Google-Original-From: Maria Chevchenko <mariachevchenko417@outlook.com>
Content-Type: multipart/alternative; boundary="===============2779167014701842487=="
MIME-Version: 1.0
Subject: Compliment Of The Day,
Reply-To: Maria Chevchenko <mariachevchenko417@outlook.com>
To:     linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--===============2779167014701842487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Please, i need your help; I have important business/project information that i wish to share with you. And, I want you to handle the investment. 
  Please, reply back for more information about this.
  Thank you.
--===============2779167014701842487==--
