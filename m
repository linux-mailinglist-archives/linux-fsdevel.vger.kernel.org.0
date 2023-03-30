Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222496CFBF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjC3GwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjC3GwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:52:20 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785276EA5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 23:52:19 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w4-20020a5d9604000000b0074d326b26bcso11012926iol.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 23:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680159138; x=1682751138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k698rTxpw1G7UdVEzDkIoajH8YiFHEimBPB/dvNYzw=;
        b=UrOjPlOXlcTEQPOU5a46QjoyxQa9NYdGlkIacN9ERoiMF4yRL3F95Ckp9pc2KPOFaI
         yx678D4M+BpMQovXWHJsmCZeurhjjXTOlSpwq3v80t5rdFX/8RJ/ULdpvJTlT9WhuHob
         oHWJIbjiUnfpPNDFvm1TqG4FeAhYJYYSjYtGd074gx9AoBTkjh7riy7s8yb9/aBvn1yL
         9oGeIye16iZDmmfr8b2e52qEVWmxCHDCdWzecGDm22/gO+BaQJOzBarw+EAUroFgMfuA
         30y7ee8COleFa9wUeIDorQmZdjFma+l1zY5NFYZYcsENw2QZe6lIFb+dYCH7N3fxPYZE
         U2wQ==
X-Gm-Message-State: AO0yUKVV59tJjgeKlGCPaoCCvfn79ktNmsrmO3fFgOPNRY750Xlt914H
        7B0BiYjhLk9X0haTH8myChhZ5t687kEN1C3eddwqReml60B3
X-Google-Smtp-Source: AK7set/X36rzcM9MPUmmEPjyd/TpcgSXoj6cJUMY6Nib+DO596nSzLxV75aN6U2fpMqdUy95PTHyD4O0ib/0X1sSTqJyr5FeaJ/x
MIME-Version: 1.0
X-Received: by 2002:a02:2941:0:b0:3ec:dc1f:12d8 with SMTP id
 p62-20020a022941000000b003ecdc1f12d8mr9243880jap.4.1680159138647; Wed, 29 Mar
 2023 23:52:18 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:52:18 -0700
In-Reply-To: <20230330-tinsmith-grimace-008b39c60399@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0139105f81888eb@google.com>
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Read in ida_free (3)
From:   syzbot <syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com

Tested on:

commit:         07cd4f12 fs: drop peer group ids under namespace lock
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git b4/vfs-mount_setattr-propagation-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=163d4771c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac3859139c685c4f597
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
