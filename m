Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97AE74EB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 11:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGKJzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGKJza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:55:30 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30CA8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 02:55:26 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b434ccc504so5400279fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689069326; x=1691661326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcloSHs79l9WLtw5wCq7rljrtMphumU2bij75yt+08U=;
        b=ecsbmpX21882w6B5pdoD5D8auhB4GdRNBlZrQPRrlaf2PuymLdl8gGVooo0iGZABny
         nN6s/BXXCDj9z0XUc2KHY0zamgoTzzG5QLMP1OVs0Zo23szzik7e0gc0fpzlOlPk+sYl
         0uqbOY94NARH8oJUrMV3D3o16Fg8zGPu45vpyQy2BOWlPNCZROG67CFclqwvm5qLaelJ
         2LErUvw/r7CF6G8z6m4orQKFhYAUmRp6Q7t62wA40LrXLsdeRqtLua1ROY0qjLzk/4pJ
         pmA+SMCV98NrUDZRrW/+zX64tG4rU+Y+FhpxEjBYdLbw3kArYhaIeMmCezTQXJS3GMDw
         4TKA==
X-Gm-Message-State: ABy/qLZYZ0ZXi7QlNyL/9ppNIgtygm1HQMebuKVD2MbaQFE1Ot1GzKPH
        DsouTdFOmF3MMc5j5f3vHO6tfTyRDZjZisLt1THEVLH+nrO+
X-Google-Smtp-Source: APBJJlG+Y2stJI6lo+xrfpFL0vzaKSDOn/mZxf8Cf2lChooL8gNyzSBg1zJaCt6wJiO6k1leSV57zO96Wz6zgVVABI47EAn4TrM5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d8ae:b0:1b4:71b0:749 with SMTP id
 dv46-20020a056870d8ae00b001b471b00749mr1062532oab.3.1689069326128; Tue, 11
 Jul 2023 02:55:26 -0700 (PDT)
Date:   Tue, 11 Jul 2023 02:55:26 -0700
In-Reply-To: <CAOQ4uxgQodMoCLvO6TGPiR3dKOhbtYKrDHzmu-gkaRAO8iSLTQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f59ee06003319ec@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_init_uuid_xattr
From:   syzbot <syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com

Tested on:

commit:         0a3bf81d ovl: auto generate uuid for new overlay files..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16079b6ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b592c1f562f0da80ce2c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
