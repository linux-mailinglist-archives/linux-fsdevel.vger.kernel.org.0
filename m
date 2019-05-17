Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0407B216DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfEQKRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 06:17:03 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:58286 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfEQKRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 06:17:03 -0400
Received: by mail-it1-f199.google.com with SMTP id p23so5984328itc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 03:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=Z6BUlwRW7zYG1f0bn9MA5mDKW/jZLmjFMFvzBM2hrHxkHWf1TcCtQUsjhi4i0Z5Sbt
         DsnGpxz6naGDpbozjbNUz8jq4ZyH0bMYx05k8S3s9947yalSnzAJpYjzoAIMSL6FLzkk
         oAtwe74KVzBHlIPFsulnmmBdjiDOPW1/6rrb6njOdV2cgwED7Spflqg2iu3A0GyZfPXK
         f8ycsy5RD7JoyIYYIRUVGUx6DgHGM9GzwD1b5bA79i+mXO8nESxeaM8sL8fTeFqoP+91
         4JevnoK6tf/DaYMbEiGcwM6DfwjVmKliaZWQutQvqPnfri6msSkIw2crUH31VaQwZTxu
         +i2g==
X-Gm-Message-State: APjAAAUfTqJC0aOGXvm6dJmliXY95j7OGJBmQr5c+1wlkTVKw0UAlnff
        oMV86V67az2lGwhYAo+Y0w8RsMMeRmfWTxjTmKH+DohCYBhd
X-Google-Smtp-Source: APXvYqw1oALLAqN8e3Fodf0np8lqv+KYYXmmSFcJpfGLY48IypppnFKQuLhi4L+WpUvyZ4V0BGWmjPiSc8Glg/RO/7JGhSptNX8G
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148:: with SMTP id y8mr395593jao.8.1558088222942;
 Fri, 17 May 2019 03:17:02 -0700 (PDT)
Date:   Fri, 17 May 2019 03:17:02 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000eaf23058912af14@google.com>
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
