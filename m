Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D073987DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFBLUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 07:20:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52898 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBLUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:16 -0400
Received: by mail-il1-f199.google.com with SMTP id d7-20020a056e020c07b02901d77a47ab82so1265292ile.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=fUuOkxrIdoQmAb56CsmjGA6rmm8IFaIzsgB206kzii4=;
        b=P+l+cNeBpBg0GtK/4pALGZ7KpEFwZRUfCYMPtAgZEMZxj7aUpqB2ufa1MPunzLbKmv
         KYvHpoCAHU+G1JSxV4I/8l/Dytt63E2owFJKWOL6f3rfwr4iyzxwtOQWhLaXaV+gpXYP
         9OMHoqzpVlz3ngTX5dfkc0o1+k1yqp5zTBrou2+5E/JI0C1RahDqd7h8wVTtKunDcZe3
         VrL0GR3Ea31TKi/EIlDiYfDcrFXH4/DnQvU2axvSU+Fl3ZXh1LuBDDwzrLSUJi0kPsJj
         x3XGS2iHIMdFyYxgMR5GRUSeJZigT/Pp4N3IJ/ASd23epy4+LfJO+Bw3bG5n+yxs8tmE
         l5/w==
X-Gm-Message-State: AOAM533CcozORXQbTZV9cbVvJtxVcT7+I1Sl74UhrW08n+gROjU40Njq
        KLIwG61bHqz2+p9Ensz3DG+s/C/N3JVh/sN4g2ygO1DKTkrd
X-Google-Smtp-Source: ABdhPJz7V5+svtllpxH9nzf4ovxVaVuS5+ylKIbKxC0l1D+WwRHYpJWQy/Nm9+9mMbCvDsJopVTIjAVhfqs6ZSYfC97n2tcnqNcJ
MIME-Version: 1.0
X-Received: by 2002:a92:c5ad:: with SMTP id r13mr14881585ilt.238.1622632713370;
 Wed, 02 Jun 2021 04:18:33 -0700 (PDT)
Date:   Wed, 02 Jun 2021 04:18:33 -0700
In-Reply-To: <YLdo77SkmGLgPUBi@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b451b05c3c69e4d@google.com>
Subject: Re: [syzbot] WARNING in idr_get_next
From:   syzbot <syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     anmol.karan123@gmail.com, bjorn.andersson@linaro.org,
        coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org,
        ebiggers@google.com, ebiggers@kernel.org, eric.dumazet@gmail.com,
        fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        necip@google.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz fixed qrtr: Convert qrtr_ports from IDR to XArray

unknown command "fixed"

>
> On Wed, Jun 02, 2021 at 03:30:06AM -0700, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 43016d02cf6e46edfc4696452251d34bba0c0435
>> Author: Florian Westphal <fw@strlen.de>
>> Date:   Mon May 3 11:51:15 2021 +0000
>
> Your bisect went astray.
