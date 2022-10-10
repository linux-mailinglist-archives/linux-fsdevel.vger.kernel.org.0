Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CE5F9DBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJJLlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiJJLlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:41:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80B6EF1F;
        Mon, 10 Oct 2022 04:41:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w18so16612529wro.7;
        Mon, 10 Oct 2022 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLGq1+RUh3PrwecWDEEn4QoJ194t8Cm1swty2LFq2C0=;
        b=JHS1k+yRHEfegsCk2bQWqkr0ojnsmKytgZC8U/sabwKebvTBzbN6Cm3f9PcQGcBFhk
         jBvLVYtkTRr5qN+mirsCx9Xor2iap608amHqsGICh6ZfvwOZTSbl62w/OiJ5mAhqPLvV
         dynrMl1X+LXDW/kAaq+QvqkCiHds9G5kRpLJYr4hSzEhuigX280E0qtEEZQILa1weysp
         KWqcdSxKG0+UBORmRS+V2GV3zGWSI2I3vc5jloGIV9D1rfFZk+3Y5lN7H1WtZqIsf/14
         pI1ypXwfqMua7IH8NlVXYP2f1Bo00LROwoHrPEvD8jyFchi9EFNmB+vzcW6cduuOC67O
         /zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iLGq1+RUh3PrwecWDEEn4QoJ194t8Cm1swty2LFq2C0=;
        b=2X4+I5c9Pa5b+Id+EXZNDpMI0ENMuOSX5NgwBrCryZo+lHTjHNNh0cCZLjcJCOqslD
         2SmHdfTYwysyu2+8HOml4zD/qbhEaj1sNk2PPeXyuP/PjWUdS2bvThNAC1Kx68Vjmj20
         LLfFJ5g4VYDZ+hhn85bHm2BMzaaqEjnTZ/d8ASmzsuKc6tcr74uAzgfeoyo+Iftaf67O
         ie9dp9zPk59CyVesBCthgVtxxTvAeiVzNXvK+xxURQeenfRhlOL5WITsjhsYrWRauWk/
         i+8GxdoN8aX0i1gPxM1/nMlTp1njAB0E/i8igWKZZE32/n/Q5d0M1sMchBhRR7wtVeyB
         zwTg==
X-Gm-Message-State: ACrzQf0BbHkhHzT/kWip9WiXHwYip8VIS0nuWYc5O6Bchyuzj3MHYBCb
        FGQrVx0P+KbL9FFR4IL3HT2CD081Ut4=
X-Google-Smtp-Source: AMsMyM5K65zbs1EdcjECCJ/+eItaJRr8U3ut88gE6prPBUkeB04tcwlWuTZOJqrthm3uKRj3hZyt0w==
X-Received: by 2002:adf:ec83:0:b0:22e:51e2:7fc7 with SMTP id z3-20020adfec83000000b0022e51e27fc7mr10832677wrn.229.1665402093059;
        Mon, 10 Oct 2022 04:41:33 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c48a700b003a5537bb2besm9647924wmp.25.2022.10.10.04.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:41:32 -0700 (PDT)
Message-ID: <c9b467dd-9294-232b-b808-48f62c3c2186@gmail.com>
Date:   Mon, 10 Oct 2022 12:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: pt-PT
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH v2 0/2] fs/ntfs3: Add system.ntfs_attrib_be extended attribute
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes v1->v2:
- Add documentation for the system.ntfs_attrib_be extended attribute

Improves compatibility with NTFS-3G by adding the system.ntfs_attrib_be
extended attribute.

Daniel Pinto (2):
  fs/ntfs3: add system.ntfs_attrib_be extended attribute
  fs/ntfs3: document system.ntfs_attrib_be extended attribute

 Documentation/filesystems/ntfs3.rst |  5 +++++
 fs/ntfs3/xattr.c                    | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)
