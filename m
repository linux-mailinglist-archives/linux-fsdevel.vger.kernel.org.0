Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CF71FD7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjFBJSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 05:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjFBJSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:18:20 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3FC1726
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 02:17:34 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33b3349553dso15571055ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 02:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697448; x=1688289448;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuxfesV2mPlW/l31sNPK0qS4J6i6ybe/ktRDhYC5dGY=;
        b=He5jU2JyrgSuVXpI83C2tZt/NoN75vwkrSm3RDv2wvk4c33UNh6fK8R7WU3g+sVWAX
         jAVxCAKasDpLH1CzqHCswQqKsYgAuNzDu4izp1s9UR8WXcDHGGudQNNkxtBzkr8fu8xt
         QVVP07rCKgO4R7h6saQZCa9v5swPMQNKoBbIFlGdP7JBNSKyhziu7+OTWG+mgSmRQoI4
         kxroueFWSO1Yuw7X3RQ9YHJJ+Ta8wCIRhV6UE9RT9OaVHPClqW2dcRkP4g+gaKmkQSfE
         8KtYXpx06wbLwnVENF0cR0y9W0xjO2JMwUKK12Rmp7ReukIeLiMQefqhPFFI+vtC7tP4
         rk4Q==
X-Gm-Message-State: AC+VfDyIY2L3WgSfwVFE7ZRQIB55oB/rcg/GJw0UMjJtlqoszUGXNQKA
        u6SiiK5Fu+7O9iYwwe3q8I8U0gGp3xC5LgoQbHsnJ1mFBqwv
X-Google-Smtp-Source: ACHHUZ6PrrPccCLLqhjvMPqVcJ09RH2oN6qZjU14NNHk0BLRnmjkdIqN3eAT6rsZSocr698Ro1lJbItecytN8+uEC+2QXev7r1LK
MIME-Version: 1.0
X-Received: by 2002:a92:c048:0:b0:338:16ae:c8ca with SMTP id
 o8-20020a92c048000000b0033816aec8camr3790651ilf.2.1685697448454; Fri, 02 Jun
 2023 02:17:28 -0700 (PDT)
Date:   Fri, 02 Jun 2023 02:17:28 -0700
In-Reply-To: <6bb51cd9afb95f2a5bd9bd2a5113f6dcbf4aea07.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d322605fd22054a@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.cz, jeffm@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul@paul-moore.com, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

Tested on:

commit:         4432b507 lsm: fix a number of misspellings
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=166c541d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1095cd79280000

Note: testing is done by a robot and is best-effort only.
