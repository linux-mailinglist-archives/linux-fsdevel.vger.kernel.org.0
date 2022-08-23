Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9659EAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiHWSZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHWSZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:25:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD97E03D
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 09:42:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o204so9189472oia.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=I2B5IMyQc4PlyUqQEthZV6KZuLYFHrzZsWfbUhzgVaqwggMxciplLK4/AF2kt8GSmr
         R/UYHXTPEjaEJoLOmxqvmcKv/pXfSvkOVBfWpMskIsvwYpYGqkiDYna6N6PdDzh/66mp
         iwDqFoEOHotvATJyBekA/riEVhD3JmfIZB4djeB/RpnTxtyGAcZnaTwq6NAq05E7WGSP
         T2k+dELOEHvGuzlirMiWO1+37kRyt3m+DzJ2b3KelNVZcZDdPDDInPzxXDqcpeXL1RII
         FvyCJGkEoU680IXHgK/r3OZ88ixUEpy1L1FVj33QkKMNEor3tKoEpSX9Se+qQeCUVqg9
         nPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=x3Lua3/3WC5lQB1OBswhnrQDMn3PCOx5F5nkDG2FuNaiPUhQykBLLVgKf4wMwA93jL
         0P7miFwJLKhRHAZxPynHXmvoNzTGIKGF8tgrdUIEO7XB+KGqSSvRaQTUaBcBqScl2oUz
         lDIafTYJJxgBEglu2v8VwsHo/9hm78Kh4ep/Hs1CPJbn60Vt9ifopmtZTqgTytlrdQ83
         zA3m54RXj3aqf2GwTjlWIeSPO+QXX5df5UOAH+SqcHSEbvQuljKMyijjore9KjA5Z7wP
         v/UdzlzLTHkp5jv/onpUzSgyNTe0IwgnpaH86bH2aqOOezcEcBUGbxKXjV3SRHr+u+pF
         7Y1g==
X-Gm-Message-State: ACgBeo0UOHiGGIsK0OHYA8R9MAbfaVPPJtD3b5EXRu5g+5bWVmeX8Mr1
        qjNdSRS+5ywpIjGmDGZ7oOEYlZ9J4whepekYPJQ=
X-Google-Smtp-Source: AA6agR59fuyL9XCFMbTnPCA8zJHg50t/rrgsiFgdDZqqvy/CuYVr2cMxrmW97DutW2oQvJu2Qbhif346T7ihs+jZ+2s=
X-Received: by 2002:a05:6808:118e:b0:337:b6f3:67ca with SMTP id
 j14-20020a056808118e00b00337b6f367camr1629493oil.111.1661272966666; Tue, 23
 Aug 2022 09:42:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:2204:b0:32a:3d8f:8c7e with HTTP; Tue, 23 Aug 2022
 09:42:46 -0700 (PDT)
Reply-To: rw7017415@gmail.com
From:   Richard Wilson <catherinemartinezmtk@gmail.com>
Date:   Tue, 23 Aug 2022 16:42:46 +0000
Message-ID: <CAL_q8eUk_BPf5DxkfNNSYk9jDSc5oTejzSRaw0-9hgpJ_kbdmg@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr's Richard Wilson
