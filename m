Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0751CF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388539AbiEFDa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 23:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352476AbiEFDaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 23:30:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FC5A15A
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 20:27:13 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id o4-20020a0566022e0400b0065ab2047d69so2223894iow.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 May 2022 20:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=37bCll7mxNrrOwuF3WZ8doqxjI8jkuHjWkx8QHqFY1itN13VkNGMEwZagu4xVoNmwQ
         mMnKLLtXF9bu4sYClmTwjcML3YxQVTZ8ii7a2EfyydoG2ZRsqOiPk8+GxBN2NFmqRj7J
         xSA/qxQr4iUGPv0ZTNcvz4uYXtRph4uFxS+PQjYtKaxeAzk6H+6Pq8HHfVC8gwwhhwZ5
         Jb2oipGe3Zq8h6S+pDlC5tqmgRzlxn8IPTHpEsJc/H5EWgmtsnnG7O4g1VY3WldzfzXm
         5kuwWThToDn3vt9Xl4tdDxH3vgTweOt39pAxx2wtwyRGgc33v+wfj3wIiMxyOppM58C/
         kiyg==
X-Gm-Message-State: AOAM530nFcF3hNXP8qJhlbLZPBS4fRcCQYbzsQ0/N+HId3blqERd0NAn
        GENsp5XWQXdEl233Sh/h7ZLmK0Ruj68iuTqqParqtldO4P7b
X-Google-Smtp-Source: ABdhPJyasqX5oxM5Yv8PbXwSyn0fWRPp2AgQrPVu+ljQ1EikqoQmL5VHB/sAxMXahjzDLdO69sBE/BYzVYlJGUCz/AlQ6T3dWt+e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194e:b0:2cc:4e4c:fc9a with SMTP id
 x14-20020a056e02194e00b002cc4e4cfc9amr526421ilu.178.1651807633045; Thu, 05
 May 2022 20:27:13 -0700 (PDT)
Date:   Thu, 05 May 2022 20:27:13 -0700
In-Reply-To: <000000000000b07a8c05b35e5f65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000347cd305de4f6fa1@google.com>
Subject: Re: KCSAN: data-race in do_epoll_ctl / do_epoll_wait
From:   syzbot <syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alexander.h.duyck@intel.com,
        dave@stgolabs.net, kuni1840@gmail.com, kuniyu@amazon.co.jp,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        soheil@google.com, sridhar.samudrala@intel.com,
        syzkaller-upstream-moderation@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
