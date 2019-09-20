Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C16B94B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfITP6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 11:58:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfITP6l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1263F308FBFC;
        Fri, 20 Sep 2019 15:58:41 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C33F51001B12;
        Fri, 20 Sep 2019 15:58:36 +0000 (UTC)
Date:   Fri, 20 Sep 2019 17:58:13 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
Message-ID: <cover.1568994791.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 20 Sep 2019 15:58:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

This is a small fix of a typo (or, more specifically, some remnant of
the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
with "H" is used in man page and everywhere else, it's probably worth
to make the name used in the fcntl.h UAPI header in line with it.
The two follow-up patches update usage sites of this constant in kernel
to use the new spelling.

The old name is retained as it is part of UAPI now.

Changes since v2[1]:
 * Updated RWF_WRITE_LIFE_NOT_SET constant usage
   in drivers/md/raid5-ppl.c:ppl_init_log().

Changes since v1[2]:
 * Changed format of the commit ID in the commit message of the first patch.
 * Removed bogus Signed-off-by that snuck into the resend of the series.

[1] https://lkml.org/lkml/2018/10/30/34
[2] https://lkml.org/lkml/2018/10/26/88

Eugene Syromiatnikov (3):
  fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint name
  drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
  drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET

 drivers/md/raid5-ppl.c           | 2 +-
 drivers/md/raid5.c               | 4 ++--
 fs/fcntl.c                       | 2 +-
 include/uapi/linux/fcntl.h       | 9 ++++++++-
 tools/include/uapi/linux/fcntl.h | 9 ++++++++-
 5 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.1.4

