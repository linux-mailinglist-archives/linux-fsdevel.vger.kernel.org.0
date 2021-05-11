Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37668379C62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 04:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEKCC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 22:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEKCCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 22:02:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9907C061574;
        Mon, 10 May 2021 19:01:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b7so23186082ljr.4;
        Mon, 10 May 2021 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ioUucnPMgSC35CAEteVQQzvC39GoLoRBdeWSll6aTjw=;
        b=W3w/DGZ0s20SCuV3fP+RzIHYkBmaYWNGNYcga+8x0AR159vBXyDAdsv2XeUNECZtHQ
         GJtHneEjES6alZ9O+W0D3ZIObK4RBChEYeETe4paAHwUDAZfw5/tMB5v3iC8b6FSQB9h
         NvdqBbTCPvzG+uJyojGhKDHUnemC8m125BuTddH914jtpFcm5z2+lJHHoXSxRk2WEqu4
         JkDUPdGiVjsN1LGuRHZss6KFW5d1gDtCOQMCxWRt2+H35KyhJGa/V03TDZnc+Dkt+Plj
         4ITLpJ8BYcn+9YYx+q1LGeO0xzwEBnByAwo0ikcXWpNYrhc/0Eh/q2lHwn1VLy/UpG5d
         jZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ioUucnPMgSC35CAEteVQQzvC39GoLoRBdeWSll6aTjw=;
        b=IKE28lxW5gqmkHsf434vKOlioK715hcVAuwZK1biE+VqmxAFh9If/QJgL1hJZSN1SP
         GAhQ7/pBr9FPHUzOF7+I51uRusMHMwxA5cVvCH6AvlWaj/ZxhPcQjEpBubjldfwQqhza
         PB4WiLbeO63kxKiFpEba60470vivAFqja6FWGZd7Z/mAx4NJQAoUVelbp65vaRGwenGt
         FwrM+18y/ad/r/PCSCKLKZtydDR0EEJFAYHbFmyeVVdjPIlbgAsLle/nbmTn+wOh7wFT
         rH9LUwttPSDgCcQZUJmZfEZTbHS3BuZ9xRzpmAKZE/l80e7EXgiqGt+CBxez+jysQ/K6
         i8aQ==
X-Gm-Message-State: AOAM532ieky3yZIKl0SXd21ek+AfD5GX4aGExQT+1DkACCh7zn7+XOUq
        s5UQuCtFnFBxYQuHSk2rPwzaE6Fc/aCH76ZvlcU=
X-Google-Smtp-Source: ABdhPJw6KPlnNtVpQ+JK5HiMrKbA3XNWidJlNU3GyUMmZ1Yc478mHRK91Ujyr4kaQwSCW7TpH05qlwK86qUi5aYm24U=
X-Received: by 2002:a2e:b8d2:: with SMTP id s18mr22527423ljp.148.1620698477409;
 Mon, 10 May 2021 19:01:17 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 May 2021 21:01:06 -0500
Message-ID: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
Subject: Compile warning with current kernel and netfs
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Noticed the following netfs related new warning when compiling cifs.ko
with the current 5.13-rc1

  CC [M]  /home/smfrench/cifs-2.6/fs/cifs/fscache.o
  CHECK   /home/smfrench/cifs-2.6/fs/cifs/fscache.c
/home/smfrench/cifs-2.6/fs/cifs/fscache.c: note: in included file
(through include/linux/fscache.h,
/home/smfrench/cifs-2.6/fs/cifs/fscache.h):
./include/linux/netfs.h:93:15: error: don't know how to apply mode to
unsigned int enum netfs_read_source
  CC [M]  /home/smfrench/cifs-2.6/fs/cifs/cache.o
  CHECK   /home/smfrench/cifs-2.6/fs/cifs/cache.c
/home/smfrench/cifs-2.6/fs/cifs/cache.c: note: in included file
(through include/linux/fscache.h,
/home/smfrench/cifs-2.6/fs/cifs/fscache.h):
./include/linux/netfs.h:93:15: error: don't know how to apply mode to
unsigned int enum netfs_read_source

It doesn't like this enum in include/linux/netfs.h:

enum netfs_read_source {
        NETFS_FILL_WITH_ZEROES,
        NETFS_DOWNLOAD_FROM_SERVER,
        NETFS_READ_FROM_CACHE,
        NETFS_INVALID_READ,
} __mode(byte);

-- 
Thanks,

Steve
