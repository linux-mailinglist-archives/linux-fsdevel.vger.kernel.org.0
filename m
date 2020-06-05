Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1F1F0106
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgFEUfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEUfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:35:19 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B915C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 13:35:19 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id m18so2536567vkk.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dI/o3zqoFJTQTyPwk8zjbJe5AJzBQrv4EHuQ9RGAI9Q=;
        b=wHT2TXbwShbPj2HTSEqMKrrq8Y+m9MsG5pbNo2KaIP1s1qFsbCiGPSmDc0OLNVoDDP
         4RX/OBu288piUQFNRoeuQ8vmj1O7CBW7LM92Ong3x1Dd4pXvcNsQRChs/Ri6eV9SSTxR
         ME6bk3xf8pMt0FKkJzVAoCGhbpoY3mnd5x0o82m7wjfxkD3OnlBlAzuPjtBTmeQBwFuo
         0i/aMEvy3NPUQ+OO10bdcFRhkxHvYJf9hEUiztVM8dP++itpSgO6cEESzAEudy2ShCgr
         eOkVF+1Py01DS9OBurJlTxEwyuc7NcZ7HNdtIxzv3ePL85wLpd3iCV1ErNskp9PKWXG3
         gf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dI/o3zqoFJTQTyPwk8zjbJe5AJzBQrv4EHuQ9RGAI9Q=;
        b=OEfI0K9Xj/X1aJJtNyohrnfGKoJpR30rvovfcCBMws9Bk3zIjzhBsXG8qJ0RcoM7XB
         oIWWD6HGFrfV6RyrQwjWIKEuvcyiGSbOTp553K+YJGqHmTf2J0k8MrxZlQ4i+k13LNO+
         0Y+m/ydC84tx+Is1SREIqkMDHGQ4Jex23SEVTy+BbVULqHYX6cEqH7fSn6OTodzz/7s6
         J0Tfivpr2T4aGmE5jvJPBEeELS7A3YLJbA8cdMP3kT6hbShI+DW1MzQ+8wBko8Dmfgmb
         dCWE6t4r+RZ7TVK4PcWKJaXoIxv2bkKsE61cFBowC+P1U9Y4R+7N+qsrgMmc/IsJwwBU
         4RPQ==
X-Gm-Message-State: AOAM5321lD81qq9oD6syUuqnmkaIKr2kyvo/iwGu9bGF2m4n0TR3HowC
        /frASUqOs/XWo60whVTAzwt7S3wOVsFP2arptAVAWf+4Ey+vfg==
X-Google-Smtp-Source: ABdhPJzCNhbJo0wKj27waEK1Z6VBp0kemK75SzAV3GHESE2Bwu/Zs3OIbO8Ahu3aQO/Miii5ue171r09gOO0sbNL/90=
X-Received: by 2002:a05:6122:302:: with SMTP id c2mr8679014vko.42.1591389318823;
 Fri, 05 Jun 2020 13:35:18 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 5 Jun 2020 16:35:07 -0400
Message-ID: <CAOg9mSSXvhmuDci_Tiu4gGEWc4oF4JXAZFUJ9Zh6VyDiTf0iZw@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.8-ofs1

for you to fetch changes up to 0df556457748d160013e88202c11712c16a83b0c:

  orangefs: convert get_user_pages() --> pin_user_pages() (2020-05-29
16:25:04 -0400)

----------------------------------------------------------------
orangefs: a conversion and a cleanup...

Conversion: John Hubbard's conversion from get_user_pages() to pin_user_pages()

cleanup: Colin Ian King's removal of an unneeded variable initialization.

----------------------------------------------------------------
Colin Ian King (1):
      orangefs: remove redundant assignment to variable ret

John Hubbard (1):
      orangefs: convert get_user_pages() --> pin_user_pages()

 fs/orangefs/orangefs-bufmap.c | 9 +++------
 fs/orangefs/orangefs-mod.c    | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)
