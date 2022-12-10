Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4F648F7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJPgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLJPgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:36:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C651A05A
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 07:36:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 82so5470233pgc.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 07:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elWpkMu9uvmX8KORhhsGTHHeksVLQvKNN2+y014piN4=;
        b=7fIxFc8PdxVzLipmWL1/2K8U2jb4YdayUP83JWdobun6jWZnkt5AQLHTgCp4mihs3Q
         gYscd/jzLsGz68h/AvlgX0h898iBcUzkMO3zE/fPHUrWGP+gaZK3A63hOb0ksAUK170J
         4PftAzLeQnJ6HPFCCiZSInjCSUhjJhFbu7mLxapVEPqKcwdWntRdAbAdUeqH5u9pdnAo
         WojW+n/+vHMOfEGvI8TIfk+qm2dwVVno+P6dBfCBD2NnIJisn2m4g4rHjT3kLoSiUo/a
         uLsgWFi/rwignXbuSW2IsliI0uuS+abrPNkhW2sBW8tip3l/gXU7dAIwS4YBoya2pNGJ
         WWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=elWpkMu9uvmX8KORhhsGTHHeksVLQvKNN2+y014piN4=;
        b=3vZOHs2i8t12vymC8ijHMNf1/STZgRDkPaTzA3ko48rlo2EtFMm7hMV9L7BnKA7y9/
         aYZ0Qxu9vCeQqaRvjMg+x+Rf9nSOUvl8ZGbH1fdD+F4+6oKgrl3+NyRv18egEYgXLkQK
         EWhl9/vjwCqoOVgLSGYlrXflUAjeruKzxD8JgffRasd2irPL6Rbi3Uvn70+/shkDv1yc
         jwUUCz33qCXH4FLA6S8Pew5hWkBlCl725/pon50wiqUdHXcOcazcdwQKEoois4W/dTLk
         t/rchsx9eWudSxW9Dn+pXq2dHdv/98YB07gqq9r7u1I3yb8nhdq75YYwTGkHi2Vw+uWa
         5D8Q==
X-Gm-Message-State: ANoB5pmD1SffBB2NIxaflnwae9fcUHC8DZO7yDn6U1syL2OdMcA+SiUx
        00qZ1ZsgkJQeUBTs9OxETDF6Ig==
X-Google-Smtp-Source: AA0mqf5+prjSl5p6SdIXE3naieXMpu9y8y5yGy2EBVyl/iqUBUAgUwsPW5GZfOxg2lBPdXaHKLgZKw==
X-Received: by 2002:a05:6a00:1c96:b0:578:451c:84a9 with SMTP id y22-20020a056a001c9600b00578451c84a9mr31296pfw.2.1670686567976;
        Sat, 10 Dec 2022 07:36:07 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w124-20020a628282000000b005774f19b41csm2899198pfd.88.2022.12.10.07.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 07:36:07 -0800 (PST)
Message-ID: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
Date:   Sat, 10 Dec 2022 08:36:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Writeback fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Just a single writeback fix from Jan, for sanity checking adding freed
inodes to lists.

Please pull!


The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/writeback-2022-12-08

for you to fetch changes up to d6798bc243fabfcb86c1d39168f1619304d2b9f9:

  writeback: Add asserts for adding freed inode to lists (2022-11-24 07:21:51 -0700)

----------------------------------------------------------------
writeback-2022-12-08

----------------------------------------------------------------
Jan Kara (1):
      writeback: Add asserts for adding freed inode to lists

 fs/fs-writeback.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
Jens Axboe

