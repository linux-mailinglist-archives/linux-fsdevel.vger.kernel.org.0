Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2207B7A8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbjJDIro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbjJDIrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:47:43 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF7BCC
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 01:47:36 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6c49eec318aso2224582a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 01:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409256; x=1697014056;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=gWJG8HCYXtwMeLHLpYrlGC4ZORcWHf1Zzr73vV23t7JpDGIIZbj3W6FVk/iNQ1bp6z
         wj4LAle0Hp8zQvM3J7Wf8ikMj3AHiOXo4xdDVhDfgTqdjQ04SM5IBSOZphN/FDWbApUL
         GizoQtNKh7IGPZ4joYElgCjZF5h0n6RQiqVACUHoZWkFbCsO94aAGJMypklRtHPFo/NI
         rVmE+et62y+u/vVyerFEyY0sYrPcCaDQURWpSxZGUADShZNIIoMTXLVNEmVddledHEdU
         A8aXqgZWkLOF/srm1AC7iWpQH5y2XHFAfqsEzCGcqi37H48a+B0r+CcBtW7m1i8a/PFY
         JyGA==
X-Gm-Message-State: AOJu0YyyvhrJKb4K8zQaHcm9d2C8Bt9vPMBLgOQpM+dqeigOjJK1jA1Q
        HaOlbMsKJ74khoCM9j+DiIv69XB408/ituOzzhxt0I0bOTPK
X-Google-Smtp-Source: AGHT+IGb62ThBprNm5GhWjOOfTldkHlPz22Bc7sz14cZhd28gohTSBMPcReUTxIpvz5bBMRuXmxnjm36cU8y7SlkilB18jdpr+RG
MIME-Version: 1.0
X-Received: by 2002:a05:6830:11c7:b0:6c4:f28f:1fad with SMTP id
 v7-20020a05683011c700b006c4f28f1fadmr455032otq.1.1696409256111; Wed, 04 Oct
 2023 01:47:36 -0700 (PDT)
Date:   Wed, 04 Oct 2023 01:47:36 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ab3e00606e00fea@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
