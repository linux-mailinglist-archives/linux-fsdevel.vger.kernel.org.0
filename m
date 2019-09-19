Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1BB7EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbfISQXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 12:23:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41763 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404275AbfISQXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:23:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id x4so1546998ybo.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+9FtpcbTf/S+1iSNHoXFplH9p7Dlqz4kRGuE3OEUFmY=;
        b=lmtUvi2T5RJu2QwBxQarKB6c7V9f/6scgnTxwOjy/a/DDJXYbwgwh64kzG4K3IDYfy
         SNa6f792sGiPSPORVOKfLdZ3rgAvJz9nNhGlHqW0DFNP71IjhxXfzJijFr9LOgaepBCL
         wNDaHy9yLSkbqOzTP2+x/jAyMCtwIdKp8/Ha1+JuJUIO8cPuz7IZTrevdyTWoXyDgQPx
         RKFS7Yaw3ZUJ7mPdhiRwZU4uzGt+2g/vwbLrkob6L90iJ3GJJ2z1SrrghrRn0P6Ag9CX
         3WP/saI+vjZatsXfEVXgPn/qQkznOsYQu9njUP9LClIF8+Mw6KPXt5nyy66m53u0y+QG
         6/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+9FtpcbTf/S+1iSNHoXFplH9p7Dlqz4kRGuE3OEUFmY=;
        b=V1vJDL3QS5wALWupkvCXG2ZWHJOkTRxM3vlsdBxLHfTYfSRiG4QZCh6regVy1YJnBG
         10SwY02Hncymqonu1iKEEH3CIRBFlNqD8LYkINj+kABoJ3AF+8oEPUEBWUCrJaVVQh5n
         ZDnOh26EGchCz4QUKiZnGjsDCx5kFKzDximC5eEZ+eEZYLpjtuUe4gSuVblmpvlV1Qeq
         DJjQH/eKQKlfCtkh1tczOdg6Qy5SWFXCL2nGiL/usEMS99kIQgfZMcPSf9V5l2iKsPvm
         3AhYGbgx0Twv3D0twJttU3ogh76U+Id9Gfw5WCWoI6WCIHEwb1pP2UjDDAzz+fzYcfuf
         yMuw==
X-Gm-Message-State: APjAAAUdio2FvtPeLRw+AcTe4CjvLZRPmUxwBsiQS24IFk1QdRIG7Vui
        vNtDgeGaGJ+IINNt+YObxMPPBsvPBK5V2cAWjnjhp0RPiDs8UQ==
X-Google-Smtp-Source: APXvYqxNgeGX2JCRTBTyh69KPtW7x7DHwYnRXEv6dv/schqcy8OWVLbchNYLkDpofYY8ctW2UeuUXjXGQwZ5q6/oBGk=
X-Received: by 2002:a25:9d06:: with SMTP id i6mr7598139ybp.445.1568910216714;
 Thu, 19 Sep 2019 09:23:36 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 19 Sep 2019 12:23:26 -0400
Message-ID: <CAOg9mSR8PB9WEoKSHBzhmRLQEA==qMJd3NPyNAnzHqe0khzbpw@mail.gmail.com>
Subject: [GIT PULL] orangefs: a fix and a cleanup
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e=
:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.4-ofs1

for you to fetch changes up to e6b998ab62be29eb244fdb0fa41dcb5a8ad065f2:

  orangefs: remove redundant assignment to err (2019-09-12 14:17:16 -0400)

----------------------------------------------------------------
Orangefs: a fix and a cleanup

fix: way back in the stone age (2003) mode was set to the magic
     number "755" in what is now fs/orangefs/namei.c(orangefs_symlink).
     =C5=81ukasz Wrochna reported it and Artur =C5=9Awigo=C5=84 sent in a p=
atch to change
     it to octal. Maybe it shouldn't be a magic number at all but rather
     something like "S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH"...

cleanup: Colin Ian King found a redundant assignment and sent in a
         patch to remove it.

----------------------------------------------------------------
Artur =C5=9Awigo=C5=84 (1):
      orangefs: Add octal zero prefix

Colin Ian King (1):
      orangefs: remove redundant assignment to err

 fs/orangefs/inode.c | 2 +-
 fs/orangefs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
