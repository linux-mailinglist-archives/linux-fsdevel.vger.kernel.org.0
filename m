Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862778A8D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjH1JVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjH1JU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:20:56 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B29D1A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:44 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5701dbeaf9fso84552a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214444; x=1693819244;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NjVq1Z/oMa2sXmtYIkTscVFUho6LoOShE43iizaRVs=;
        b=QLVwITcWUFHjibFzvdksteJktUH0KSEakgF03D76aglbvcUj1e9VEV7YL3nY1noH43
         6R3apv/1xTHDLhcSuhfWBcPicJtH3GXxi/aCm9HaKyK0aEVN84uXRF6EAZnMbLY3h4Qs
         KLODHd3f4N8+nRDrNSO0o6tWwLKdV7dmPX+ndVHodYGeGKuuNIsey4+TN1KMJkqLeI4M
         uIGUJGrsZj+sYS4WXpjhdXYwKqt/jHwWF8Keau1qZWinWu/RfGbnxAX9MXfEinSf5mgJ
         1fSds+K4Vs1Vh5dCAkQDFOc7yZe5dF+HDA16NwELf3XQfYwe8ZyXLuhe9nvJqBvjD7UA
         Q2zQ==
X-Gm-Message-State: AOJu0YyqJB7EDtykb4IP6HYAecanmbJKv0ocDBd494c3a+0pPff3DGxS
        WTugnu0dRuEBnrJHAONaQ3khZxXAlsXMs3XR1UlnoZcUsZAS
X-Google-Smtp-Source: AGHT+IG0MkwS3xq+4QRBiHb1ffpiMd+NgE4o23pZp7agZOIOwzF6/Y72A0vYPPtZOgLF0CCL4P9Q4R7ABgGr8n+lOYW6cBua1bKq
MIME-Version: 1.0
X-Received: by 2002:a63:3d04:0:b0:56b:cd71:6094 with SMTP id
 k4-20020a633d04000000b0056bcd716094mr4431669pga.1.1693214443852; Mon, 28 Aug
 2023 02:20:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 02:20:43 -0700
In-Reply-To: <20230828-schande-hungrig-b2a6ebffb5f6@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007459b80603f83591@google.com>
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz dup: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super

can't find the dup bug

