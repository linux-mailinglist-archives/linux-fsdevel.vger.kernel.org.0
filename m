Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9637B6331
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbjJCIGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjJCIGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:06:41 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935EFAD
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 01:06:38 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c64edaa361so725765a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 01:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320398; x=1696925198;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3/2NqW9mmT03VqQNExZ1WshExaLoGoulxK0Isrbhfw=;
        b=badPNH1qeBwp7JjhPZPW0USoI0vvOFbj+6QNQGmBhaQQtXVL7BjXAKEEu/wOTboYEs
         IDTw+bYnppNgbpxTZYuinssvO5Qju9g83zif5BOrblHWrkwLbzuEmpbCxCxSY+omvIVz
         JLe0NDP6LsDzpg7jFgZ0LPJKNi4QHswLpuTfaFFWAY8+IqPiKzTdT3yCrPa6FfKFm3B8
         NfbqxppPMhj0nocpO4cGjyVM5jVFlTjXrp7WVlCzPpbPldd5CAnhgbYfgnXPGfFptZR6
         1AOtjrVOYUByAJ8hP0O4m6FrZ/fG1DB1boyXiFZ4QI1rjrGhlxO+XLUE/EM3Q87ju3Tq
         NLHQ==
X-Gm-Message-State: AOJu0YxjpeCN9WS9vuo1xubecohXXg6oOpRFyj6oJF3BTHc2VAYYu1YP
        r4eZFr0IttciGl5/AlyXctfFI4Oj8n7IkgGXD+BpHtWdTSHy
X-Google-Smtp-Source: AGHT+IHvp7PrTwxGiy8U8miYCuYFgnGiIsw0EIZoLoqOGVXyX4sMUzTfWVSkKU/1qrUSX1Sdo4ECGlic4zPUSXnlRVMYOfZUCHDK
MIME-Version: 1.0
X-Received: by 2002:a9d:7c81:0:b0:6b7:3eba:59d3 with SMTP id
 q1-20020a9d7c81000000b006b73eba59d3mr4004601otn.6.1696320397970; Tue, 03 Oct
 2023 01:06:37 -0700 (PDT)
Date:   Tue, 03 Oct 2023 01:06:37 -0700
In-Reply-To: <CAOQ4uxhgWHoauPKUDfmuvu9uyMC23gkKVgi98R7XgX6s+fuh7w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf12400606cb5e6b@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
From:   syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com

Tested on:

commit:         c7242a45 ovl: fix NULL pointer defer when encoding non..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11f4879e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=2208f82282740c1c8915
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
