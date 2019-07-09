Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8D62F27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 06:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGIEIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 00:08:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37615 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfGIEIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:08:01 -0400
Received: by mail-io1-f72.google.com with SMTP id v3so15080801ios.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Tojd49K4TWJ2ahCpfLjRNApjFre4XIEC+uxSBIyo+38=;
        b=nsggdvsc0IuFVU5m2T/vvU/DnWISMHhX/j4OzxHoywNHc4H7wDy8OddeNtm+3ecAKJ
         t3C23bd04IBl6Pan8UtyYpeSCLlZx2nJBw3QrIxTIK7NjUNVzHE4ugyd2LcFVV5BDUxU
         9JztgnWLyAl6/OFozThUxcBieLZedz+iqVcc9imPvUF2WaQ7dBvWzJIcwLZEkmDKPxTM
         PUJmwUaqbGyvkiTjYZK3V0IA2d1o9TP2lfEk0o2yd6mq4ftsnBpz0slNOFvFp/7MlTAI
         iWdc5lcANF/f+lAmCK4kgKYVJCBBzS4/IG5VWIfxIzTpzfZGU5Ofi8IBrBXuJWVL2Fr6
         glPw==
X-Gm-Message-State: APjAAAWK/4JoxsCOHQ/YGCn5CXsJEsXRGnsd1onBJKxKp6RmcDuI9KWS
        c0KtIpCfgm+lVPvMTlbB8QX3GcQNcFfwgMeGN9ylw23nJjQ9
X-Google-Smtp-Source: APXvYqxm/mXCoJ5Hk6y8vR6v2IS4oj/n6X0W9JquEY5V/Gz6bIh3qzQKuPRQYew4ljT/GIOxZ10ZAdEqTPIVIKbtLtZFlys15uqe
MIME-Version: 1.0
X-Received: by 2002:a6b:cf17:: with SMTP id o23mr791127ioa.176.1562645280222;
 Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
Date:   Mon, 08 Jul 2019 21:08:00 -0700
In-Reply-To: <CAEf4BzZfqnFZRbDVo1-=Vph=NpOm1g=wGuV_O5Cniuxj9f9CsQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d676f2058d37b4a9@google.com>
Subject: Re: WARNING in __mark_chain_precision
From:   syzbot <syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, ast@kernel.org, bcrl@kvack.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com

Tested on:

commit:         b9321614 bpf: fix precision bit propagation for BPF_ST ins..
git tree:       https://github.com/anakryiko/linux bpf-fix-precise-bpf_st
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb3e6e7997c14f9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
