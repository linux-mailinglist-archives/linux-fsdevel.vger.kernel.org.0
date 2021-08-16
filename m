Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7F3ECCC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhHPCst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:48:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1441C061764;
        Sun, 15 Aug 2021 19:48:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h17so24921973ljh.13;
        Sun, 15 Aug 2021 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ek7ku5pzAIW7bPVgrzyzxLQzx4qAfj45w3UfCpvp4ME=;
        b=Z3+Q5Wh28hwoZquCVOlPnqqEayj53MCAaun+CHrQmpaUcSeuQ6HPahzkA1ehgNkZEU
         elUH8JKQRedtvoSvntnl1ZGaYmklZ34ymRe5nsu213pOwWWToTqOgwiqg9D2iJyfV3+I
         SUpXk/1r8n7wy9hO6IdcNmkxokmuKf0ud+WYzHr99dedYFAlHbllb5uW6rSYrgV0Kg1f
         4OOjGDbuU5RUfQohLkSHsoxsx9spJANWLLFH42H2qGAFLKnmlbpuIRgdYjxgcmi/l90P
         VXje6nqKebD11U9j9urEL6hSzILH9XfCTMur/6uRcEnrgq4pMYKcP+jYpXcLxegjk6TV
         bvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ek7ku5pzAIW7bPVgrzyzxLQzx4qAfj45w3UfCpvp4ME=;
        b=m4CEiOfnpNPaOECJAQ+X+4AnzAndchi4fb+leQJKTuV4PLuXeuz7vBkSDnY4y0a5Yy
         7XyrExMij7njgzH5bqCaJ1bk0sR88OjCKTEyvwz6d+dhhntC4OKPhIkd20EM4ioXjiYx
         qvvDHzDiZh9+jBZOgMBQWolcJ9OfKe1dDMAfYnBf3bUrjn7SNaz0iuPu4XbVnxkWXh4G
         /6y1s+GVLYrhIcHDTB//Fx3dTxyxL7lAL62kQufUpJSwV4pcliKYqd/1OhR9t5Jk2f2z
         OtGu21cmpTXYpxfpKUGI9mTxsusvgDM4VVeR6Xp81UpQYAYL48BhfBjw8zNqwojfdCf4
         GZxA==
X-Gm-Message-State: AOAM531FVyrbnBQGMLCrTI6rWwIx0CQp1gztKJu8vLaM2mwuxeJC0w10
        VA4Nei2AC20WQXmcndWEhfQ=
X-Google-Smtp-Source: ABdhPJyFZh1QCZx/JQlCBWRfNvOjXF3gHZGMYx2/0YB1v6Nt/3Fl9TI6zNovVKHrlnk2QZtWaHPwJQ==
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr11206844ljn.139.1629082094650;
        Sun, 15 Aug 2021 19:48:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b12sm425392lfs.152.2021.08.15.19.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 19:48:14 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: 
Date:   Mon, 16 Aug 2021 05:46:59 +0300
Message-Id: <20210816024703.107251-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Date: Mon, 16 Aug 2021 04:08:46 +0300
Subject: [RFC PATCH 0/4] fs/ntfs3: Use new mount api and change some opts

This series modify ntfs3 to use new mount api as Christoph Hellwig wish
for.
https://lore.kernel.org/linux-fsdevel/20210810090234.GA23732@lst.de/

It also modify mount options noatime (not needed) and make new alias
for nls because kernel is changing to use it as described in here
https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/

I would like really like to get fsparam_flag_no also for no_acs_rules
but then we have to make new name for it. Other possibility is to
modify mount api so it mount option can be no/no_. I think that would
maybe be good change. 

I did not quite like how I did nls table loading because now it always
first load default table and if user give option then default table is
dropped and if reconfigure is happening and this was same as before then
it is dropped. I try to make loading in fill_super and fs_reconfigure
but that just look ugly. This is quite readible so I leave it like this.
We also do not mount/remount so often that this probebly does not
matter. It seems that if new mount api had possibility to give default
value for mount option then there is not this kind of problem.

I would hope that these will added top of the now going ntfs3 patch
series. I do not have so many contributions to kernel yet and I would
like to get my name going there so that in future it would be easier to
contribute kernel.

Kari Argillander (4):
  fs/ntfs3: Use new api for mounting
  fs/ntfs3: Remove unnecesarry mount option noatime
  fs/ntfs3: Make mount option nohidden more universal
  fs/ntfs3: Add iocharset= mount option as alias for nls=

 Documentation/filesystems/ntfs3.rst |   4 -
 fs/ntfs3/super.c                    | 391 ++++++++++++++--------------
 2 files changed, 196 insertions(+), 199 deletions(-)

-- 
2.25.1

