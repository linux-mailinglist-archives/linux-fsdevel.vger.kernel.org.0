Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A360BF90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 02:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJYAbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 20:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJYAbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:31:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38631187A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 15:54:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso7413501wmb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERFYp0mOHQ40Ljy/QoLZznLrnvPKRCf2gpPWYyho3G0=;
        b=Y4BE0PKe7h4yShyyXGOdZ+y6zrw08ELPq/enDR9h85G4tBuldPrLohJE56Y9tElIej
         uisJJQNch22XePVxNPIrpasst4KuwzHO0C/U2DmBUFBbi6tSbTZXdqGSsefe02fajUNq
         kSkUz/yoCxiFxEXC8YhIEEHe18WYxdKUZ0Osv5O3J+i2M6C+yq97t6m5AAgc+PCT3eq3
         1VQ0AHfyqLGsQNfN6ngw/ckbU2pT2WUVY7TEBQEgZ9l23wil3fRdKgjA+2mRaaX5Qfkp
         8r63zQC4gxFm7wSA4WhrukYMtWsY1Wuhp08Ku0gWA2eCh9ZnMfINCcP28WAo+ga/It4m
         dS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERFYp0mOHQ40Ljy/QoLZznLrnvPKRCf2gpPWYyho3G0=;
        b=b1J39mbVtCnGtD5VLqqlspq+WeatCzjx1+Q7uET+ThR0j0bTIAtVd9ZrSgddY4dZPp
         oTGghHDAWP7eIVp/KlUZUsNLOVPn5oh891GknDfeVjabtR77p/nrcppajTiu1cJYVYHA
         Yap3SxnJsFRRjzHxuzWOfuEEsQ/F+Nc86iDsqivbQa/nGsb5mayxz+K+580LHzNft14f
         5F7KyoghEjT9haPTPq+nAY155w6CrSaQfmRfz2XuHEgShkwH+sncIX8qsVEn1QdUF4G+
         7VRcLArLLd82cXK28GvGPcE43Ruw3q52t0MKvEQG+D9OYUHlTUvA3iY5Eb08b9suPuTp
         SWrQ==
X-Gm-Message-State: ACrzQf1ppLHkl6Fp2YRTFwJTDoumiuBtuXfDNSR5/SrU+4xMBYrNVeVD
        sDVgLtX5jauOkYZhXqQ16yBUGp5Lc270oakdk3tTTpf1
X-Google-Smtp-Source: AMsMyM5ajjQ14qwXOM6+h3vqzwRGMYTZ4TQYi2yyptHo8Vomtt4BoUWPM0v1GHAYi5IKpmuNstFyE7povexLMin02x8=
X-Received: by 2002:a1c:f009:0:b0:3b4:9398:49c9 with SMTP id
 a9-20020a1cf009000000b003b4939849c9mr44655412wmb.174.1666652047150; Mon, 24
 Oct 2022 15:54:07 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Geery <geerbot3@gmail.com>
Date:   Mon, 24 Oct 2022 15:53:54 -0700
Message-ID: <CA+mLQwDLRiqnWo5DD0JQumvzHdQK6u=jkXeLtDRW2C618b2WRw@mail.gmail.com>
Subject: 
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unsubscribe linux-fsdevel geerbot3@gmail.com
