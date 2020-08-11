Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396724213B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKUTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:19:37 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B2C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 13:19:37 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id k63so2911864oob.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=3BTC4gnIBbRJERka9/t/ZW4aUmC6qu/UB2oa0etR00M=;
        b=rg2nls/NMNR/oMdt6bIRyrX5OO61hMQILt09hoxlg26mTbdSqaaPMkiR6YgKhy4NM2
         PpWZNK4aoceiP/K6iRpqlLaoYgA4BE1ktqsn1KizelzzRkUlXVA9N7gchfFgJyEtuan4
         46Ls2HeTeVfH8+EuMeFhRyLUuHSiJXILvOUpYHm9WYwulAirmtL+/oqX5k1vkLfSENh6
         24yL0AG4hV/qZOeKc9GExduQRrxXbSLVnGoJjCDN/A/vHvl1uSYfjk6ybT+b8mbf+j6a
         gXXgmMmCRYU0Evu1RwfBA6jW9HVkolmkRZgp7MVNGX7k45D6t8C3rtulQ/wHPD9x6p0F
         ZvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3BTC4gnIBbRJERka9/t/ZW4aUmC6qu/UB2oa0etR00M=;
        b=BFrinWDBSCPkrupsDquXG1meeU0ICq3DnF8RoOunzBShVP5EABJnvmUue11iVuMJJe
         icLo/zU1xhY1ly1MTQlObhKybNQINb0XR8BGzEW/vSFBtaSujBHXqtKQhsfrJDu4S7rT
         hUFouP+KcFL9IjOUiocbM4syQF7IlelVsNPbbB56GTswRrj9TR/i+J4Y3UclfjpVvDS1
         BMKq6HJDAFYcDEvQiOfZPbyiz6mvzwZ2yemg8Hr+J7kvNPRg0RP50R9fIELjAmyQXJmZ
         c3eR3OXKvUCMfcfwjVpcLcL+HWr7EoXqX5oqapgxjTsy0uO7g7PbzDoncam7xoPZ6GG3
         c7gw==
X-Gm-Message-State: AOAM533vK+1Z7IyP1Ujhu7nAytDt8RxcMg1iB8s6HK2c0zogxRL1jChe
        N+dPXBS2AKNUBY/4vEWp5zSf2Ru7oHx0q6xJ8hYXuS5+0DQr7g==
X-Google-Smtp-Source: ABdhPJwsP6S/FDXCyGSf+ypL0M5emPAa/6e6yFE2RvOGFhtX9oVJWqJv/2eRDWi1RPYmqi29QeHJLnSr8rB553o+Bd0=
X-Received: by 2002:a4a:ac0e:: with SMTP id p14mr6791494oon.26.1597177176481;
 Tue, 11 Aug 2020 13:19:36 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 11 Aug 2020 16:19:25 -0400
Message-ID: <CAOg9mSQvhvavaUK94Y3XRdvRCOzEDc_rbOQV-NT4vjWzepf0zA@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.9-ofs1

for you to fetch changes up to e848643b524be9c10826c2cf36eebb74eef643d2:

  orangefs: remove unnecessary assignment to variable ret (2020-08-04
15:01:58 -0400)

----------------------------------------------------------------
orangefs: a fix and a cleanup...

Fix: Al Viro pointed out that I had broken some acl functionality
     with one of my previous patches.

cleanup: Jing Xiangfeng found and removed a needless variable assignment.

----------------------------------------------------------------
Jing Xiangfeng (1):
      orangefs: remove unnecessary assignment to variable ret

Mike Marshall (1):
      orangefs: posix acl fix...

 fs/orangefs/acl.c          | 19 ++++++++++---------
 fs/orangefs/orangefs-mod.c |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)
