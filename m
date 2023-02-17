Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB469A40B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBQCyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 21:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjBQCyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:54:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509854D04
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 18:54:12 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j6so124163plh.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 18:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBcdwEX6FT21aGltCWNGTHy4YpVdXGqa74J3HNN+qvU=;
        b=gNH7rvfTjPO+9k6L/YbXU7YNiCz6oKQTlE25wcwFWgf6ITvNYXoA7TgNtqfRS1QOks
         d2yExmrD/f0WlVPGGZTG3gnV4h4U9UZodpBjevDobFQxMdrhvLljwfr12vLjinYrN/mQ
         zqUkLv99JLx9ajgQaZiQ2KAy41KmJHrRIMouN5HnH+NQxKeEN3Rq+Ju4tAvy3uRK0nu7
         vGIH7wGBy08nwKExZww040DseWXKZPAdFeIPKlgNr71vyzaGxq6uzwj8PBHCGHcWZS6d
         TAh/hqhkpfWgsn6zm80dl6b1I1BL4hYQwgTKA+HB4KAyrJuZWAC0MmBgmN5dcdEBkY9x
         phQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBcdwEX6FT21aGltCWNGTHy4YpVdXGqa74J3HNN+qvU=;
        b=xCgDcAXam/LwrkpdNMfbHY4+WxC+85qQmLK1UB/iuPQf/0YBoYQZtfOij31xQ/F/lt
         /qAzUBqB/jaGg+KEOgOB8mnXOOUdrzXjBzt12cfZ5iyKOIer0DRiwNmuYRSp22tSazko
         GtVDUyAXDGu3bdFm08FVGSVBOhq3TtxsCRXcKGfiqNq+F6TwViLjVjf8O4YWzRhQp+G2
         2G7S/G9edjq9IH+yxfce8dPY4Xejq/bJh1RetIUDGZVpJ5D35E2ekDe8ZQCfG193xdp/
         dZaw5Z5AwG/tjUEiWnZ+ikaHTvfGE2QsL3Un1igqP+HfrND+Bp0KvfMvBLV3zB2vPzS4
         BX2A==
X-Gm-Message-State: AO0yUKVQEslZ9thmZW8OaFj8uRVXlQRJxIhsTFmo64ND/ZtN+EzklaE0
        N/VcEWdmZdjurV0Ffxn4c2radg==
X-Google-Smtp-Source: AK7set+xE/5g9g0P5EfNekFnPwk8H7gUJcIS42o9jqT2HEf34uVDC44sJ3IzM30pDFY9y8ukMJ3s1w==
X-Received: by 2002:a17:902:ea0a:b0:19a:7060:948 with SMTP id s10-20020a170902ea0a00b0019a70600948mr152816plg.1.1676602452095;
        Thu, 16 Feb 2023 18:54:12 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r6-20020a170902be0600b00198b0fd363bsm1988322pls.45.2023.02.16.18.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 18:54:11 -0800 (PST)
Message-ID: <754b3cc0-c420-3257-9569-833c42f93808@kernel.dk>
Date:   Thu, 16 Feb 2023 19:54:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL for-6.3] Make building the legacy dio code conditional
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

We only have a few file systems that use the old dio code, make them
select it rather than build it unconditionally.

Please pull!


The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.3/dio-2023-02-16

for you to fetch changes up to 9636e650e16f6b01f0044f7662074958c23e4707:

  fs: build the legacy direct I/O code conditionally (2023-01-26 10:30:56 -0700)

----------------------------------------------------------------
for-6.3/dio-2023-02-16

----------------------------------------------------------------
Christoph Hellwig (2):
      fs: move sb_init_dio_done_wq out of direct-io.c
      fs: build the legacy direct I/O code conditionally

 fs/Kconfig          |  4 ++++
 fs/Makefile         |  3 ++-
 fs/affs/Kconfig     |  1 +
 fs/direct-io.c      | 24 ------------------------
 fs/exfat/Kconfig    |  1 +
 fs/ext2/Kconfig     |  1 +
 fs/fat/Kconfig      |  1 +
 fs/hfs/Kconfig      |  1 +
 fs/hfsplus/Kconfig  |  1 +
 fs/internal.h       |  4 +---
 fs/jfs/Kconfig      |  1 +
 fs/nilfs2/Kconfig   |  1 +
 fs/ntfs3/Kconfig    |  1 +
 fs/ocfs2/Kconfig    |  1 +
 fs/reiserfs/Kconfig |  1 +
 fs/super.c          | 24 ++++++++++++++++++++++++
 fs/udf/Kconfig      |  1 +
 17 files changed, 43 insertions(+), 28 deletions(-)

-- 
Jens Axboe

