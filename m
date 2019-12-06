Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC85114EFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFKZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 05:25:49 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49496 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbfLFKZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:25:49 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB6APlYS001446
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Dec 2019 05:25:47 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB6APf4o015813
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Dec 2019 05:25:46 -0500
Received: by mail-qv1-f71.google.com with SMTP id g6so3886168qvp.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 02:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=iTp7Q0LC13BTmcaDzvUDNCKm0YiwERAvXAhvOGv2zyA=;
        b=OuwfonMULmipDx3niK/2fmc3OVQ1Ok8BZv/i9dPVctRyn0RBQ/Djs0Y6tCrW/AGlxu
         InlcabZwBiJjQW/+cXtvEQsY2mHAKhrMCR81W8pVXqxEQmBv1VypBY3fIuFNcqxfISpO
         41PRUQ0qMieVErKDcXa4hy/bhncxwMvV0+B1/66HdRhsdZdYKPfY9j719SS4lnOy8WjF
         QluiefwbXMIUE9rl9Wm9Te/SpKGW8Cjp1VPXqjFAW7ZNZ+OmdrtQJVThb3ghjTgHSUvk
         gWcXtn9iEI6Uwf13c26TUVtrAl+H3FRC60la4XhDYbc0ROwT7cbSkH/dRGJqwKI2Tcxu
         ie0g==
X-Gm-Message-State: APjAAAU0PF0mWbtxit/eNb+0+BNVMVJaw3gX7Thtl7dGCdQ2DTDJBiUW
        tiEs5rc1mvPcN51otGOrvd3b7tNkH9F/vP95aYSwEZLkAhQa3OSX1FVl4Cbv8AN3qYaJ1Se8yNs
        KcfQPX4oQxFOvvNaYuVWsNTF1d1UTfmN3pxyg
X-Received: by 2002:a37:9a46:: with SMTP id c67mr13155671qke.308.1575627941395;
        Fri, 06 Dec 2019 02:25:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZMU1mUOXObYclXm7ZUlvWykdYorRU6QPSIvyLh9zuWYWu9hVyLbbLi31cMFkuAxTzO96NMg==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr13155652qke.308.1575627941082;
        Fri, 06 Dec 2019 02:25:41 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 62sm5700268qkk.102.2019.12.06.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:25:39 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <namjae.jeon@samsung.com>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com, dwagner@suse.de,
        nborisov@suse.com
Subject: Re: [PATCH v5 02/13] exfat: add super block operations
In-reply-to: <20191125000326.24561-3-namjae.jeon@samsung.com>
References: <20191125000326.24561-1-namjae.jeon@samsung.com> <CGME20191125000628epcas1p28c532d9b7f184945c40e019ce9ef0dd0@epcas1p2.samsung.com>
 <20191125000326.24561-3-namjae.jeon@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 06 Dec 2019 05:25:38 -0500
Message-ID: <81423.1575627938@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Nov 2019 19:03:15 -0500, Namjae Jeon said:
> This adds the implementation of superblock operations for exfat.

>  fs/exfat/super.c | 738 +++++++++++++++++++++++++++++++++++++++++++++++

> +static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct exfat_sb_info *sbi = sb->s_fs_info;
> +	struct exfat_mount_options *opts = &sbi->options;
> +	struct inode *root_inode;
> +	int err;
> +
> +	if (opts->allow_utime == -1)
> +		opts->allow_utime = ~opts->fs_dmask & 0022;

This throws a warning when building with W=1:

  CC [M]  fs/exfat/super.o
fs/exfat/super.c: In function 'exfat_fill_super':
fs/exfat/super.c:552:24: warning: comparison is always false due to limited range of data type [-Wtype-limits]
  552 |  if (opts->allow_utime == -1)
      |                        ^~

which means that opts->allow_utime will never get set. Except for
the use of -1 to show an uninitialized value, all the other uses  don't
care about sign/unsigned, so let's make it signed....

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- a/fs/exfat/exfat_fs.h	2019-12-06 05:17:58.344590227 -0500
+++ b/fs/exfat/exfat_fs.h	2019-12-06 05:18:25.429222169 -0500
@@ -210,7 +210,7 @@
 	unsigned short fs_fmask;
 	unsigned short fs_dmask;
 	/* permission for setting the [am]time */
-	unsigned short allow_utime;
+	short allow_utime;
 	/* charset for filename input/display */
 	char *iocharset;
 	unsigned char utf8;


