Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323437A5221
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjIRSgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjIRSge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:36:34 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A3137
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:28 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5712ca11ee6so6703985eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062187; x=1695666987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL7t4GHuNYKyFje4T0iRFTpqFYTS+UOIKhf9ZmTQit4=;
        b=w+TEZor1Y4xYact0GvuqD8vmCvp4B8u61+TSvB2Tdl+9Z4soRNketstti8sXoQpMDH
         YoaEiT4vesTfS+Hbizke2zGf6NWJ8BUtA3iJYjwLV6JKWVN0AP/ZwmaAaG9C1OSpeElP
         xzdRquQokzJdd7JAD/Tlkjgoy8LgUOEOaSOBwv9OumG68LYt+MlrRkebya530zj4GtsH
         fPBIKaEj7RC9IkMRMoNtHtrgipkpr1rdQ6NH6DaRXqwF9V2BjIT2Uiuye55vdHxsNEU+
         Vfxs3m5OlETtyzhyxFfOjz2Wwpc/j68ch1zPbvv9JpRCfY/vm2/8LZx6K+xqrLxYRhp7
         ghgw==
X-Gm-Message-State: AOJu0YxVemBJuABt7ggB42Ovc1euZFxz/Mo8Q0MlTsWO2zw22GujsbIU
        GKj6/rwZ9O/eXkx1Omxp5arfmB5Zw8yQfHbOIKYs23+TS446
X-Google-Smtp-Source: AGHT+IHKojlF3DrjzfacrM8ON0QKndS3TFyKBRjiZYO1OODXGZpL+wOYt0U6a2mzN7TiYu16z4GdSgQOZJVCPNaBlJoYXEf1UR65
MIME-Version: 1.0
X-Received: by 2002:a4a:4151:0:b0:573:52fc:4901 with SMTP id
 x78-20020a4a4151000000b0057352fc4901mr3179529ooa.0.1695062187261; Mon, 18 Sep
 2023 11:36:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:36:27 -0700
In-Reply-To: <d576d53b-bce4-21d3-fddd-0e26e9b44f89@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b455e0605a66b2d@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in page_copy_sane
From:   syzbot <syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com

Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fddb62680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
dashboard link: https://syzkaller.appspot.com/bug?extid=c225dea486da4d5592bd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137cae54680000

Note: testing is done by a robot and is best-effort only.
