Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2B3F3FC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhHVOcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhHVOcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:32:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086ABC061575;
        Sun, 22 Aug 2021 07:31:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k5so32091172lfu.4;
        Sun, 22 Aug 2021 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=43NEJMr0brhfqyLpY3hPgyhFUTczXVAcWbtRqQQyC5A=;
        b=J9W4isTpQ7OZPErXo2Mo5+7UuchHyNqHkA9qicXQ6SUt28hTjkMSUbdxek7WJNTLH3
         e/7zXFAS+OKy+QwoeecamSGbZrUmEADanAgWlevCplyFPEz1QFwRxBDM/DLhhKx0Fcgn
         RR2TEfLnwuw+LWpT8UWve0nXC6fZ4vg2qwiKAICwvuirZK46rCH8yBui3UMdLIRFrCcO
         PVcYI9gAznpTHpJNLL3DYhLMBaXdsEt8s+6A4Jsf37XVS3G2QuASGYV8FvhVOKSruBvQ
         x60ifTGzB3okCjtsDVIAXEshTWKOEDzgRoO4N9yG2Nw2i2neINv27pxBMdzMQzdrlwQw
         nIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=43NEJMr0brhfqyLpY3hPgyhFUTczXVAcWbtRqQQyC5A=;
        b=Lld/hEkKdgH3nvSWOAYsc7ZhSe39HDBjSxm4loMbI3xxwXHrbW2G1XFMlVyTfYymhO
         S5mqHScd8IdsHrngbinR1NG9yVRw0siXZ8Ha3opjthXJUvBqCmv4WKp1js2ZdLNDbl6+
         uvn56lHq/bW9U8+QEAtRQ+BljHs1MIpHnhmjbP6G41i2CIrer22NOoqLWHh9dmy19PZ3
         iOqYhsU0v1HLDcqMdUCRyn/1Tte1VCj1nLssVKZYXUva72MD6NOsyTA2EQRIjyDgnJ5X
         Qxy1BoZEF3u2Hr2y306nO3GyBBrbYG7JtSqhmJZsC/rX0Wdh4X/7vqBaoxpXHAN41Tdi
         XJww==
X-Gm-Message-State: AOAM533ziSF5ENXfRrOo8T84aqVQNWJJAIdA7YrwZHGKu/FriXc0uNn7
        VvLIuNgmAS3Hk9Hkq9O1TuE=
X-Google-Smtp-Source: ABdhPJyzVxUfiTwOFDSY/OKNym6ckuZ8IweoE+bquKIj4ImmrkFXBxw2dEjDxAulAE1byO3rREsV2w==
X-Received: by 2002:a05:6512:3888:: with SMTP id n8mr22711423lft.468.1629642696113;
        Sun, 22 Aug 2021 07:31:36 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id k23sm1121170ljg.73.2021.08.22.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:31:35 -0700 (PDT)
Date:   Sun, 22 Aug 2021 17:31:33 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     viro@zeniv.linux.org.uk,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dsterba@suse.cz, aaptel@suse.com, willy@infradead.org,
        rdunlap@infradead.org, joe@perches.com, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com, dan.carpenter@oracle.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210822143133.4meiisx2tbfgrz5l@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
 <20210822122003.kb56lexgvv6prf2t@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210822122003.kb56lexgvv6prf2t@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 22, 2021 at 02:20:03PM +0200, Pali Rohár wrote:
> On Thursday 29 July 2021 16:49:37 Konstantin Komarov wrote:
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > new file mode 100644
> > index 000000000..b4369c61a
> > --- /dev/null
> > +++ b/fs/ntfs3/file.c
> > @@ -0,0 +1,1130 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *
> > + * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
> > + *
> > + *  regular file handling primitives for ntfs-based filesystems
> > + */
> > +#include <linux/backing-dev.h>
> > +#include <linux/buffer_head.h>
> > +#include <linux/compat.h>
> > +#include <linux/falloc.h>
> > +#include <linux/fiemap.h>
> > +#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
> > +#include <linux/nls.h>
> > +
> > +#include "debug.h"
> > +#include "ntfs.h"
> > +#include "ntfs_fs.h"
> > +
> > +static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
> > +{
> > +	struct fstrim_range __user *user_range;
> > +	struct fstrim_range range;
> > +	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
> > +	int err;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (!blk_queue_discard(q))
> > +		return -EOPNOTSUPP;
> > +
> > +	user_range = (struct fstrim_range __user *)arg;
> > +	if (copy_from_user(&range, user_range, sizeof(range)))
> > +		return -EFAULT;
> > +
> > +	range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
> > +
> > +	err = ntfs_trim_fs(sbi, &range);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (copy_to_user(user_range, &range, sizeof(range)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
> > +	u32 __user *user_attr = (u32 __user *)arg;
> > +
> > +	switch (cmd) {
> > +	case FAT_IOCTL_GET_ATTRIBUTES:
> > +		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
> > +
> > +	case FAT_IOCTL_GET_VOLUME_ID:
> > +		return put_user(sbi->volume.ser_num, user_attr);
> > +
> > +	case FITRIM:
> > +		return ntfs_ioctl_fitrim(sbi, arg);
> > +	}
> > +	return -ENOTTY; /* Inappropriate ioctl for device */
> > +}
> 
> Hello! What with these two FAT_* ioctls in NTFS code? Should NTFS driver
> really implements FAT ioctls? Because they looks like some legacy API
> which is even not implemented by current ntfs.ko driver.

I was looking same thing when doing new ioctl for shutdown. These
should be dropped completly before this gets upstream. Then we have
more time to think what ioctl calls should used and which are
necessarry.

> Specially, should FS driver implements ioctl for get volume id which in
> this way? Because basically every fs have some kind of uuid / volume id
> and they can be already retrieved by appropriate userspace tool.

My first impression when looking this code was that this is just copy
paste work from fat driver. FITRIM is exactly the same. Whoever
copyed it must have not thinked this very closly. Good thing you
bringing this up.

I didn't want to just yet because there is quite lot messages and
things which are in Komarov todo list. Hopefully radio silence will
end soon. I'm afraid next message will be "Please pull" for Linus
and then it cannot happend because of radio silence.

