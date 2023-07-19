Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1C75A2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 01:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGSXR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGSXR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:17:27 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADA1FF1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:26 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ba5121da9eso306696fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689808646; x=1692400646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1T8DF+F7vOu3DoEylx/F408HNedc0v0qwNsF2STayI=;
        b=QjzKyK/sEHPGu7nfi7M5WUVyHiXpKJ7CHfDsAa6bS2R4KycTZ39SyOVwE/3/FzFAD5
         eaeNyNFUlkTFkrVceuyWKXSttWsrIkEiKbf9l2MeCWMMVgIXxVy714rD37AJiXLEsbS/
         DNhEWhmfR30C1Y89wg18LjfOl79o1SNwSDie9lI+Wz30EdUp9uCUwueIY/xhHMCX3GTU
         OVJQHrkOxtBcyLR+qg3feY/RXbAx8TNZ6sqnjUht4qnd+JYCFQ7g4bJ93bQNXptj7H+k
         cOZDPvR6/lh6hpQ+A8iFSoeIiwzvNIRKE4o/4rFgPEIUHkQ0pz9qk6mSSR09+fnU7pTw
         f4Dg==
X-Gm-Message-State: ABy/qLayp/g1PeeWE04JHBGF+2snX8bJG9/lU21dkQ9wZoPe7GS4jHhu
        C3+1X3B8ZZz2Ft7Fij07QdmdFDkjU38zShIGRR+we//jUV/UT8w=
X-Google-Smtp-Source: APBJJlHMdLIXEL5Z8pdzgF175WqoG6dc7Y9NRR89CqmCQgk0XwW4ggjoNBaRaxQUix9DhPrlC4MibSaHlLDSHIOP015wMq4PiWAd
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8c32:b0:1b0:e98:1637 with SMTP id
 ec50-20020a0568708c3200b001b00e981637mr4261353oab.10.1689808645863; Wed, 19
 Jul 2023 16:17:25 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:17:25 -0700
In-Reply-To: <566ffabfcc5a7de71205ec4e97245ca2@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001341b80600df3c7a@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/fortify-string.h
patch: **** unexpected end of file in patch



Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123c341aa80000

