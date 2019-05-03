Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC212B57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfECKQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 06:16:06 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:40091 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECKQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 06:16:06 -0400
Received: by mail-it1-f200.google.com with SMTP id j8so4290631ita.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=VY5QfBCQ6cHgC3w4AwM2J35rgHSu4rJkyZTjPIyHDV6EP3Ay4Xp+CS5L3JpXLQLITn
         CG1ufMUBBlxVg+zEde0pVuXWYicSMmyXs731P1qM3nEMjS4VQzQAsLfUxrLV/jyjA+hY
         gUz/azx84NPIXjZIwocK6NL7UChCqNSiv0PxKK8qALlGJEFLfmPxmA8LIbDSfsdrJAJw
         ptXF9eR5/0ohJxSo1qusftx0watIRSXM8x/4QWQHc5jjuHNdClRath7Pu40FnSAq9kgB
         EB3Cx5NlK0X8vpIttvOt2u72HebSvRLJhQmLugb4/m/n9vrEyHgwpUF7TDnwYOnrvkm9
         B2CA==
X-Gm-Message-State: APjAAAXVXPFW1ojvPU55nQvrvMaguOLc+jBp/dzGmpYf+gwwoSbhZ7xC
        9gtdLZFYlX12rOQee2GSs7bry/qTJQ1mrGiY7t4fFWZCdXVn
X-Google-Smtp-Source: APXvYqy4HCDetetZ/MKz0/4sqoObInvZQcLO6v7qu4qICZHOauUnCv5FVa1RLnzhrK6Gc6y3A1FXGqK6CQ75w+SjuILMJV2PZ0AW
MIME-Version: 1.0
X-Received: by 2002:a02:a402:: with SMTP id c2mr6320642jal.13.1556878565206;
 Fri, 03 May 2019 03:16:05 -0700 (PDT)
Date:   Fri, 03 May 2019 03:16:05 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6796c0587f9097c@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This bug is marked as fixed by commit:
vfs: namespace: error pointer dereference in do_remount()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
