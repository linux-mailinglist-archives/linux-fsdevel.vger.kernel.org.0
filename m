Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97667A4807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjIRLLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjIRLLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:14 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E3131
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:35 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ab724f59deso7639263b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695035435; x=1695640235;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG7RNbFAvJay0quXxW463SyUC+6Xd6Vr6g5CQxbRyKw=;
        b=VrfwL5DcZXyE46wVflHQoxixAAfaqct1yLsYi6b+HnOSy4pP/7xiogtiJ9ssDKdeFr
         Kx9dAFuJuRbX4/XkWEJbZZ/os/dti69w9PEVXoQ55pnQlAy1OvyvS4AZk8jHeiU6CwcM
         O5PF4NlXXaysOOZfVAvBDZ24KpbXqE6k0L56YVR20etDjjFNuWHJaUo2yvH1ysq5L6w4
         xMXpy6WLldVQIce0BqdE0m2LZUTN1ysW/eQn3psX1ZgRp+D30vFtvmevr2+8DkuWezlk
         UQrlYtME94eXhPFe+CWeKfwOHyqCLeaBYTKt9eK39s6RtiOTXnxi5owNelvAt/Ij3tym
         jp6A==
X-Gm-Message-State: AOJu0YxPIWl+2As2l1uX4KtUltdsA1evKyEoqpbf5coMpfNIJeqIyEW7
        QvoeJ33BRHa8AQv+Bbi9TuNpA3/aCXhP3HKEkeeLEbMD3FtG
X-Google-Smtp-Source: AGHT+IFMGEFDrk8h5J/P5zRFgXO+m2zzRmcowl4TZZZyXd+aLihSja0xcslK/DwDuxq5LiZ4k2MrePVWc5ZK+2eoqls0aIp/GYZ3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1829:b0:3a7:7c00:49c2 with SMTP id
 bh41-20020a056808182900b003a77c0049c2mr4088966oib.6.1695035435172; Mon, 18
 Sep 2023 04:10:35 -0700 (PDT)
Date:   Mon, 18 Sep 2023 04:10:35 -0700
In-Reply-To: <20230918-dorfbewohner-neigung-ab3250854717@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feca6e0605a0307d@google.com>
Subject: Re: [syzbot] [overlayfs] WARNING in setattr_copy
From:   syzbot <syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com

Tested on:

commit:         f8edd336 overlayfs: set ctime when setting mtime and a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=124fa964680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=450a6d7e0a2db0d8326a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
