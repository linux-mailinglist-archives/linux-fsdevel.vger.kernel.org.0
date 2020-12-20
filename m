Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5B2DF840
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 05:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLUEak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 23:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUEaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:30:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6725FC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Dec 2020 20:29:59 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id w127so7741054ybw.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Dec 2020 20:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XNHnX108dcC6dFa1KqE0tu77rI+BgWC8zRdH1sessdw=;
        b=SsD0PZxIcYEKdWkUIwUQlVGqZ65BDkF2tgtl2kuCnH7uMomc+9zCoQlT1sjXygIl3Z
         P6pvlgyj38lh9eEo7d4AaE+s5YWaz7MLEBXz0xlOeeeYfkOonUzyHbRa2iJgwoH2TWkt
         dmS2A3awBCiQwr27/Jske5u7ICkl7rHJLncym4+St8y1qGgr9Y/cU5r/o2Flzd9NS4wj
         yY1sl+BDSD847F+STQoz4QN2O0PSQpBadK/fGqP0SLJF9cJSorlIeFyDPSf7SdYhhZ6v
         ODeTSAVvlU0gmfvGTiAtpnLqDribALjQAfHbl2ocm6EYmBX4BdqxVGJD+1xzif4VPTLP
         7+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XNHnX108dcC6dFa1KqE0tu77rI+BgWC8zRdH1sessdw=;
        b=nUZolBzziNCx1O3Dh8O8GArQo3FtRiIaQqz2JKPXyjQterINsVtlHcD17k5z6zZUoN
         6GgJ6oAmOfsy5CzTDo0998wtbSeLmkmbXnyVAa4MlglEkvD0BXLqFXNzzwR9NKJsKb7p
         KM6PpA6fb6UbGklKgIxpE7+64ZczOD3iKg9zD+uG+HaTTN+tT9g/JyYmce2oCoO2DaJq
         E2XOQbvOeh4NCV9eHTsLe4jntUgPpavxIG4xleIosuFAWweKN/+JUmsh5Dx/MfatBdK7
         RZKdYlZdmntQPbrm6R2DFHZBHpZq/pX24PjMhyiqnPyC9129xiFynFk7XcaABicyQEtU
         mKmQ==
X-Gm-Message-State: AOAM533bZtF2qC5zbIQ0mTENgJfdSookfVlNoGqgRlXryQY/sd3JBLvT
        4mbd7G2Ctg716TuUQwsiW7LStBnlJ+awVMzyrL0zBOhbn5ebjvfq
X-Google-Smtp-Source: ABdhPJymzc49qkkhWkeDheqnszkguHP/MGovIjdQzBUbLLUrriuoDNHvOawgkghBdKTd1Z+cZfZ002IYjtceH0SoKiM=
X-Received: by 2002:a4a:4592:: with SMTP id y140mr9593624ooa.26.1608494796752;
 Sun, 20 Dec 2020 12:06:36 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sun, 20 Dec 2020 15:06:25 -0500
Message-ID: <CAOg9mSTwWmVWZVsWd6eUmqrzLpSDii0hyYLCRN_edH3uBhUmaA@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Mike Marshall <hubcapsc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 2c85ebc57b3e1817b6ce1a6b703928e113a90442:

  Linux 5.10 (2020-12-13 14:41:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.11-ofs1

for you to fetch changes up to c1048828c3dbd96c7e371fae658e5f40e6a45e99:

  orangefs: add splice file operations (2020-12-16 16:14:08 -0500)

----------------------------------------------------------------
orangefs: add splice file operations

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: add splice file operations

 fs/orangefs/file.c | 2 ++
 1 file changed, 2 insertions(+)
