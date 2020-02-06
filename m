Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEF1543CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBFMLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:11:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44063 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBFMLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:11:01 -0500
Received: by mail-io1-f65.google.com with SMTP id z16so6002013iod.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5ypeUhezswdodqQsbU9SWnGFQo0ivOjhcYZWG1yel4=;
        b=ANQfsSJx0TVvJ0yE7/xMtoKRdc32VruPGHelm+SiZelkiPK/C7EBMot2roAUmGEfpX
         u7NzBf6Qqq/y2oTMMi2LycOlMCOWbNjcXwv2bbxKCZ5lT7vzlsNDbMXEzkmmVZA6ugqm
         KOh/9jmCVh0ls2uO5bjE9VE/sR91ATZSYReTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5ypeUhezswdodqQsbU9SWnGFQo0ivOjhcYZWG1yel4=;
        b=BL7NQ31PVLQcKxTrZQAqs4YKJUm7+dx9SIedtjDDojbbAbWEfo8wZ63QUJ+R0EFfia
         iKIj5+8H9979xKDrT5ri8SU7JjuenV7vPtzN5EG/koFS6Ei3Ouo5gJnCPPBNNomZyGpz
         PXsXPvEKx9YQU3NRXsaV4x0x4IYZM9CZHQ+FdhNytnI3/k0FRbYCSRGvMtAVKXWY7hHc
         zVc/ty7XRu2g8CWz8zqQA15XU3ulDbK+eZdu7Vfop5HH3n7xOPfPPlpZ/7VcipsGocY8
         yiWFJCFQegTAfhlvOPX6+KsYgWiLyqwomgSCAbLNylHrm3YkVHwshSM+ghfj56cNiA5E
         YcHQ==
X-Gm-Message-State: APjAAAXaoUEgoDt4ux6xCcWXy4zYR3TOCdesnp4sSs4Yz/VtIU2366NW
        tRKtjz4IcI7h3McW1kONG1WdV0VWWBg9GxConRx3BBkX
X-Google-Smtp-Source: APXvYqygoWe+QHU1xhfCEI4QC9wheNYNqSP/jyiL+xTR/ulZDOzhtT8mgbj9kyf6o/MLnvZ4Oapw4esZUXuTkNK17Wc=
X-Received: by 2002:a02:9988:: with SMTP id a8mr34049152jal.33.1580991058855;
 Thu, 06 Feb 2020 04:10:58 -0800 (PST)
MIME-Version: 1.0
References: <1579005585-20249-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1579005585-20249-1-git-send-email-zhengbin13@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Feb 2020 13:10:48 +0100
Message-ID: <CAJfpegvibrehmHd6d+Kb6FGv6wS8iybGi+QdnnSW-iNMfQV2BQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use true,false for bool variable
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 1:32 PM Zheng Bin <zhengbin13@huawei.com> wrote:
>
> From: zhengbin <zhengbin13@huawei.com>
>
> Fixes coccicheck warning:
>
> fs/fuse/readdir.c:335:1-19: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/file.c:1398:2-19: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/file.c:1400:2-20: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/cuse.c:454:1-20: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/cuse.c:455:1-19: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:497:2-17: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:504:2-23: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:511:2-22: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:518:2-23: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:522:2-26: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:526:2-18: WARNING: Assignment of 0/1 to bool variable
> fs/fuse/inode.c:1000:1-20: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Thanks, applied.

Miklos
