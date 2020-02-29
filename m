Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872ED1745D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgB2JRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 04:17:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgB2JRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so3700924wme.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84l+/iPVMM8/hLUieRf6a7Y3yljDnv4PnRrTq7Jpkjg=;
        b=cHz9xliE+HoEvGGVsxnoiYK5Z1qN46G0Mos7GBEWEeSNyKHWDkuAbgFoR95CSxxsOa
         HTF0mdtS3RJmE/T0bulXETv1S8b4hXclA5AlrHUJSPX0nHUSIzHzBPY26jGmE6zUMH98
         x5fFgVI8aslBCQY7dRXSV4T5LmhJcNOG4lW6mT2qgaCo5Kgp6gWm2uCgo25D3YKjQ7t2
         ru7x4/D620selz0Olgymq1Gy97B3+sD1UG4dbClwyjujmy92q9XQ8PP94zUfWGGgJmvD
         O6zZpaLAiHT5Sk4CPJVRd0LCowPFB3cPJe56OZhSZLLvM/tmLOeoe8w1E/vraQxps5S0
         jlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84l+/iPVMM8/hLUieRf6a7Y3yljDnv4PnRrTq7Jpkjg=;
        b=cRphO9+fBxTdapJfGlnM09jVLdq9oMDCARg2qMsRjSgZu2+98H05vB1QBHJ+HQMyYX
         rxxkwlM3/IlA1shvsuCzFbGg/OK/YDtttzUIzM1t8iqHKfNNcfEOqV80Bln1zBDF2CNh
         Jju6aP2oZ26JVU8cg6JEMUZhnaPIUARfuSfPY0o97Tbgai4VvLEc39frlvSA3dKhHrfD
         KVv2lhEPNwcPo5bVSfgVgWZmEJ0HY6V/1P48AQW04iHK8PJSVq6KnEaecCQvXKLZTLPb
         uEBFWtf2otFDPpoVoJWdmRIa6QnpSVGBRjY74vy1kc+GxFxF3aw1I+BdFzymDTsWA0ka
         NNFw==
X-Gm-Message-State: APjAAAVdAVpSCzcoaKYif06mCwS5NX3hHb4eQnpGXN40HtEIjnSwZMAc
        sKwCe/91I9jaj5YDjKpX5tPdrtxNZ5LqNWhmCYM=
X-Google-Smtp-Source: APXvYqxfLRiVrnYhDu4x+AqoqT6WXSX/Yp2zDg70IB8IAjbVVRQuJ0ZHm+nq/8o1RcPnF9HGEur2CkpJXILJQTL0jqQ=
X-Received: by 2002:a1c:a789:: with SMTP id q131mr9556538wme.127.1582967824944;
 Sat, 29 Feb 2020 01:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 29 Feb 2020 10:16:53 +0100
Message-ID: <CAM9Jb+j46n3Ykca3_F0zb-7U1M5C8KmmH+3uzB1z7MqH60mQBA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page range
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, david@fromorbit.com,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

>
> Hi,
>
> This is V6 of patches. These patches are also available at.

Looks like cover letter is missing the motivation for the patchset.
Though I found it in previous posting. Its good to add it in the series
for anyone joining the discussion at later stages.

Thanks,
Pankaj

>
> Changes since V5:
>
> - Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
>   aligned request and clear poison only on page size aligned zeroing. So
>   I changed it accordingly.
>
> - Dropped all the modifications which were required to support arbitrary
>   range zeroing with-in a page.
>
> - This patch series also fixes the issue where "truncate -s 512 foo.txt"
>   will fail if first sector of file is poisoned. Currently it succeeds
>   and filesystem expectes whole of the filesystem block to be free of
>   poison at the end of the operation.
>
> Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
> these patches changed substantially. Especially signature of of
> dax zero_page_range() helper.
>
> Thanks
> Vivek
>
> Vivek Goyal (6):
>   pmem: Add functions for reading/writing page to/from pmem
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax: Use new dax zero page method for zeroing a page
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
>
>  drivers/dax/super.c           | 20 ++++++++
>  drivers/md/dm-linear.c        | 18 +++++++
>  drivers/md/dm-log-writes.c    | 17 ++++++
>  drivers/md/dm-stripe.c        | 23 +++++++++
>  drivers/md/dm.c               | 30 +++++++++++
>  drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
>  drivers/s390/block/dcssblk.c  | 15 ++++++
>  fs/dax.c                      | 59 ++++++++++-----------
>  fs/iomap/buffered-io.c        |  9 +---
>  include/linux/dax.h           | 21 +++-----
>  include/linux/device-mapper.h |  3 ++
>  11 files changed, 221 insertions(+), 91 deletions(-)
>
> --
> 2.20.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
