Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAA28806A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 04:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgJICkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 22:40:07 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:45866 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJICkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:40:06 -0400
Received: by mail-il1-f207.google.com with SMTP id 18so5684595ilj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 19:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/vPsdNPBvKtbX2yFfD1uwNT/06XdsG2XB3HXtY9anCU=;
        b=EEv04CkteD6UvukD+aQtobeBPDd7xODR0nvH9azx10wHFWSJu3wOatI0NInNkePq5K
         erBfoaF9m8DPghJaZNupjiTqeIG55qFVeHyaOdkZlD5cOJiMzzoX83ScHuS2xMmqbJ/f
         c8sWiIn9Wffz3Pp0ZvFtyOcKZ+x3BTr7SG/D501S9tzXqY7wgGEtwdhoblIETlNtp5CI
         nCoPEA+8aRYs3x4Ckm252oJywYrP9uvreFAnb8tQcumdxMbL7xENC9SKe+OIWaZHMzXG
         PSLQRZMvGKpOUErhifPPErcuoFfoLej1qquLA+RSgogwjYs09lGnk2K5i1R9t2dphLXs
         OcaA==
X-Gm-Message-State: AOAM531WdQmjgOtoOYOrDDh+ymYh8zXr5IzDYWGHL9TdmZYHruR2uhqT
        T8yu2JUVtF0GH5shA7jZfJje2Dm5xPFYSurXsPUZXiuN44ER
X-Google-Smtp-Source: ABdhPJwtkYMALivaBfrUViip7NgYrqa7K9OXqz214KzVWdtu39kWhABMAytxVEbDrR/IiTJNPDuHyM2I0Jvcf+BF+qyKKnXvhScE
MIME-Version: 1.0
X-Received: by 2002:a92:9a8d:: with SMTP id c13mr9258613ill.233.1602211204976;
 Thu, 08 Oct 2020 19:40:04 -0700 (PDT)
Date:   Thu, 08 Oct 2020 19:40:04 -0700
In-Reply-To: <00000000000085be6f05b12a1366@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb48fb05b133ddf5@google.com>
Subject: Re: general protection fault in utf8_casefold
From:   syzbot <syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com>
To:     Su.Chung@amd.com, alexander.deucher@amd.com, chao@kernel.org,
        drosen@google.com, ebiggers@kernel.org, jaegeuk@kernel.org,
        jun.lei@amd.com, krisman@collabora.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        su.chung@amd.com, sunpeng.li@amd.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 91db9311945f01901ddb9813ce11364de214a156
Author: Su Sung Chung <Su.Chung@amd.com>
Date:   Mon Jul 8 15:31:39 2019 +0000

    drm/amd/display: refactor gpio to allocate hw_container in constructor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1012ee8b900000
start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1212ee8b900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1412ee8b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=05139c4039d0679e19ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12316e00500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e80420500000

Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
Fixes: 91db9311945f ("drm/amd/display: refactor gpio to allocate hw_container in constructor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
