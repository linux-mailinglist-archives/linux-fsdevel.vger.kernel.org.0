Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41A7814E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 23:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjHRVuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbjHRVtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:49:32 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034A3C34
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:49:31 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf0b05bbbeso20096105ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692395371; x=1693000171;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htaUE46w/jpYC6GT7fp3ZjxKV5A/VMyj18jALNrVscc=;
        b=AfyoeQ+v8eLAmECH9I0kDMGBoMI8WFNzk8iWuMdFuHj7Gq2AanxyAQezGy+tdsHsoC
         UB+UJbzB+tNTFLbmARVITzeR1ufXwycaJwlhzIfuT91DNS8GY7m+ghzyluME5gz1hPsh
         lb+NImdqSqlDVgSHWu+xnYbOMOLg9etapWzMXzvtbWWbiWV4p0K5Jf1Y1VmE1iqkrC3I
         bJeatElQXwq+6WasU2fDixCsYhhySbFRYk/BF++6FOyaU9bfwmHBnb8cnTVRCGzWSHTw
         AqDNlAzZVZev1MZxO15aU5pEOA4LLtY7zVvsfFRYf4i/GbPIm6V9RPCyWiZrdYtj/z+c
         TlCA==
X-Gm-Message-State: AOJu0YzEZTanR2dMUeDg1ULMYxpl8Yn1h++wr14uLP/fYbbYAEFoG7E4
        9P65Ij9a5JAqK5102kaiCAYAROm5Suen+9pyuZ9ZP9iKUUDI
X-Google-Smtp-Source: AGHT+IEopbrZK9WaQ3DK9uOGyDRimniWVNSjuyIQEZW05tCpOq3HSBrweE8epEmU42rAUfq9ZdMzCGUXU4KTs7VqsrNiciOWveJa
MIME-Version: 1.0
X-Received: by 2002:a17:903:22cd:b0:1b8:9533:65b0 with SMTP id
 y13-20020a17090322cd00b001b8953365b0mr131968plg.5.1692395371136; Fri, 18 Aug
 2023 14:49:31 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:49:30 -0700
In-Reply-To: <ZN/fVHbQA81Zk0Db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea8eaa0603398076@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com

Tested on:

commit:         47e4a92b f2fs: avoid false alarm of circular locking
git tree:       https://github.com/jaegeuk/f2fs.git g-dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16b569efa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
