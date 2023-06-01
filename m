Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC571F443
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjFAU5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjFAU53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:57:29 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB8195
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 13:57:28 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77496ce1b52so31786039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 13:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653047; x=1688245047;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+l1U73mbKH9j4OejDCTya2AgY4321krTJ/ukN0/34Q=;
        b=LazNvZUqvhuLkBZBYJ0uxKY/wrLzJHEVt30/8prj19a2MyLY3ke3qIcme+fZdFRdUt
         /ZNbrFU7IhhpVRRzXoJXj5rk7uv8XhMkR3Q+eskfMIfD9zvwT37Q/twzsONisMElBBP3
         GmS9hnzq9D0pAMQV1CfliFl5/ZuOXQ6ymzgAKJMfvM9o4e7bUJyXzuhogcD+cdy+K5MX
         raNXL8ePJMtP/0WdUrtVjbyY0ick91xHkq7AQ21FJ5tfDI5UvTEuVzaSQEqaEVk4Dp/X
         c5J6ii1YBb9+8W13jbq9u4vNOHaNXAp947gAmYnS94SPGDMz3/a394vbhc5MsFu+Bz8C
         pYvQ==
X-Gm-Message-State: AC+VfDwfAA8fb1058+J96LnXEXX+uTOj6fYWkbx9LversRkjZYOrfwiJ
        bmJT+Ho1WS67S4ZUu50onZm6Qe30u4x+WkFbZOX5P7snGJMi
X-Google-Smtp-Source: ACHHUZ7bUwXBbZVCrZNRxrQa5023b/GTViYVQBHHLxfBXUh0nMyBSQxMYlCW5YBYKTlxmQRiZvA4raYDP+qvoq/e80zbSI2rTWxg
MIME-Version: 1.0
X-Received: by 2002:a5d:8f89:0:b0:770:2afa:25ae with SMTP id
 l9-20020a5d8f89000000b007702afa25aemr325298iol.1.1685653047714; Thu, 01 Jun
 2023 13:57:27 -0700 (PDT)
Date:   Thu, 01 Jun 2023 13:57:27 -0700
In-Reply-To: <ffde7908-be73-cc56-2646-72f4f94cb51b@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001faca405fd17af1b@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

Tested on:

commit:         929ed21d Merge tag '6.4-rc4-smb3-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c69fed280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1159c149280000

Note: testing is done by a robot and is best-effort only.
