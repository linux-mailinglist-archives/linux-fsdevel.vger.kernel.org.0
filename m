Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B75F9D8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiJJL1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiJJL1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:27:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CB6D573;
        Mon, 10 Oct 2022 04:27:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so16552503wrh.5;
        Mon, 10 Oct 2022 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eORThfCwUva1cFHbc3EqKdmKtUPJThTOAvohfNEg30=;
        b=ovGmz7VJJ+z7JTTJax93xxaTI4YfHUkE2wpeLYGcXX4TZvsZrlEAl/mJHQc04yIDVF
         TTfQEXK7RMysAuu+gi4gDfxceMP4o8Xgn3xm3F3Q9HYLHs2Twp03dmNJ3QyLsEO3+Hod
         hnGWvrs8BdpQ5XJTnptYYUykKLfzLukZ0nnLf8PAww+eYudr7+Z+29xNt39zaAO1WfGa
         uBuAYTTHfwff4bMsp6E9jYaYOt8q7P/CEtCvdlsRrp9wWa/Jbry+Q77EcG0lhm8aYrAX
         grBQ2LEj6gjmf1c7vSL0PPXpi50EfxY9Gr8kEcQECzn3STG92miJqbjvor/5KAj84ggz
         mluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4eORThfCwUva1cFHbc3EqKdmKtUPJThTOAvohfNEg30=;
        b=yJpQ+zTwpfE1y2UtEjS5lMqh6DPESg696VlleozT4OYp436mKB9w0Be3WYeG2MioUs
         FgTmFPXfiZgTtEdUI0N3lIMo4QEsrUc9Ey4gsoRKULRt6CVyDrKHWIduODbI0z/y9abx
         QUdVqRlZbbBjZtt4tTRqJtCDWqy68Ded3wiopx5ksJ4NdJLjwzke/7aIUaU/Jw5HEsT4
         k1QkBmL6cXsloYeHlueihhdesXFt3xzCrBV71OZ4uATBNu9kKtQ3IJ5gJdXhTtSlWfqj
         tA6sz4NA+02guejj1kXg+kOQjiA3fB/83E954c7dkZ/tGwDLJ7tAqKaSBUYUhto+SPWI
         AT5w==
X-Gm-Message-State: ACrzQf2WQGYsKr3hm3AHenYe4q2sU56ZDNioGduOnTYMurpIU5ABfH3q
        rTy+MhCVAyb0dCrzlmWEadmbCuJanss=
X-Google-Smtp-Source: AMsMyM74gcdhxOtXcR0YLV610oaQuaVu4aBmNKfscThPQIuYcqLbOgq/Dfg3UacTLuQemQD75kDEjg==
X-Received: by 2002:a5d:6da2:0:b0:22e:42ff:2f8 with SMTP id u2-20020a5d6da2000000b0022e42ff02f8mr10934771wrs.269.1665401239675;
        Mon, 10 Oct 2022 04:27:19 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003b476cabf1csm240298wmg.26.2022.10.10.04.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:27:19 -0700 (PDT)
Message-ID: <9c404576-856b-6935-f2e3-c4d0749f16ea@gmail.com>
Date:   Mon, 10 Oct 2022 12:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: pt-PT
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH v2 0/5] fs/ntfs3: Fix and rename hidedotfiles mount option
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
- Add documentation for hidedotfiles mount option.

The current implementation of the hidedotfiles has some problems, namely:
- there is a bug where enabling it actually disables it and vice versa
- it only works when creating files, not when moving or renaming them
- it is not listed in the enabled options list by the mount command
- its name differs from the equivalent hide_dot_files mount option
  used by NTFS-3G, making it incompatible with it for no reason

This series of patches tries to fix those problems.

Daniel Pinto (5):
  fs/ntfs3: fix hidedotfiles mount option by reversing behaviour
  fs/ntfs3: make hidedotfiles mount option work when renaming files
  fs/ntfs3: add hidedotfiles to the list of enabled mount options
  fs/ntfs3: document the hidedotfiles mount option
  fs/ntfs3: rename hidedotfiles mount option to hide_dot_files

 Documentation/filesystems/ntfs3.rst | 6 ++++++
 fs/ntfs3/frecord.c                  | 9 +++++++++
 fs/ntfs3/inode.c                    | 2 +-
 fs/ntfs3/super.c                    | 6 ++++--
 4 files changed, 20 insertions(+), 3 deletions(-)
