Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFD65D1F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjADL7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 06:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbjADL7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:59:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B31B1D0;
        Wed,  4 Jan 2023 03:59:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o15so25363828wmr.4;
        Wed, 04 Jan 2023 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ7g43yeFEdHpj10PompOYHIr0cHFQF71QMr+oMaves=;
        b=G1LgyYFT/Lkivs2XYaRTUJ80unLJrliTTqQuLIwNA5tQS3byAdibus/57RD4JPCw1J
         5VBifp0LSHdJGcDSTYZICOles4jG41ih1M5d9+eqgbVy16YvmhOaQ/Lsht4r1Byyq2s7
         sXyINieCS7SqDa694VtWHIwHKHwf3SQcEaJwIZ6gtHiFbO/ZUxMkXRx2OSlcteGSj6x/
         Tz8JvhP/r0hmXRb/e5IvLClmlogoqFKBYNJQ1xVt1bc8d7L42YUKhRqlRx/23YfT2tZw
         NAKQrldmBij1S6eAE4bMEZldmeEqzmFwTGt4g+Cr0jxCJLz83LxEhPPOu/XQChNVVEAr
         iCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ7g43yeFEdHpj10PompOYHIr0cHFQF71QMr+oMaves=;
        b=17xYBJXN01HNAKqsuoGpu9gl7DfSWaw2u7JRdKfJpJB03VpXSt151iDNfe1jDXBuHZ
         ksLdogHOLsDPLM2y1U7QyB7h+2B8j4TvSSXnvBotTpITwTmjbutuyqEAeQTWrDbTAyrG
         dqTMehn/OMRaPAJK65mHOI/J5M8wEFyq0ykZgxSTzUB+MsMPACfjIoRcUaEmiExz5dcM
         clQNIIBnhCjbMXI6BCAfc04jes5mqjPQH+AzHhZd9wqBaLkTFb3PY1TIznaxNkLg0ewY
         nwrrE10/2DzJ0RohURRRDCS+CA9NeAi2EtEu0JrITa9cPo0KJfA7iAKhCAkPMjxkIA3r
         Yg9w==
X-Gm-Message-State: AFqh2krSePvkKtuVvUQ/OxeqAmWY9Djkd9g5BYX7iV98vQiEZz4I7kY8
        Y5FhzBRBliG4R/hfEy3JFG8=
X-Google-Smtp-Source: AMrXdXv4Q84TnQCE5ksibHnf+NQDrI+GZXTnLALoLGQVU2OEMSIddRzRtvcZyHZQyAxktj4bAOBALw==
X-Received: by 2002:a05:600c:3b1c:b0:3c6:e60f:3f66 with SMTP id m28-20020a05600c3b1c00b003c6e60f3f66mr32999816wms.29.1672833567559;
        Wed, 04 Jan 2023 03:59:27 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003d1e34bcbb2sm1878973wmb.13.2023.01.04.03.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 03:59:27 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:59:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/4] fs/sysv: Change the signature of dir_get_page()
Message-ID: <202301041814.3Lbh2QfK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231075717.10258-3-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Fabio,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/fs-sysv-Use-the-offset_in_page-helper/20221231-155850
base:   git://git.infradead.org/users/hch/configfs.git for-next
patch link:    https://lore.kernel.org/r/20221231075717.10258-3-fmdefrancesco%40gmail.com
patch subject: [PATCH 2/4] fs/sysv: Change the signature of dir_get_page()
config: xtensa-randconfig-m031-20230101
compiler: xtensa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/sysv/dir.c:190 sysv_add_link() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +190 fs/sysv/dir.c

^1da177e4c3f41 Linus Torvalds        2005-04-16  174  int sysv_add_link(struct dentry *dentry, struct inode *inode)
^1da177e4c3f41 Linus Torvalds        2005-04-16  175  {
2b0143b5c986be David Howells         2015-03-17  176  	struct inode *dir = d_inode(dentry->d_parent);
^1da177e4c3f41 Linus Torvalds        2005-04-16  177  	const char * name = dentry->d_name.name;
^1da177e4c3f41 Linus Torvalds        2005-04-16  178  	int namelen = dentry->d_name.len;
^1da177e4c3f41 Linus Torvalds        2005-04-16  179  	struct page *page = NULL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  180  	struct sysv_dir_entry * de;
^1da177e4c3f41 Linus Torvalds        2005-04-16  181  	unsigned long npages = dir_pages(dir);
^1da177e4c3f41 Linus Torvalds        2005-04-16  182  	unsigned long n;
^1da177e4c3f41 Linus Torvalds        2005-04-16  183  	char *kaddr;
26a6441aadde86 Nicholas Piggin       2007-10-16  184  	loff_t pos;
^1da177e4c3f41 Linus Torvalds        2005-04-16  185  	int err;
^1da177e4c3f41 Linus Torvalds        2005-04-16  186  
^1da177e4c3f41 Linus Torvalds        2005-04-16  187  	/* We take care of directory expansion in the same loop */
^1da177e4c3f41 Linus Torvalds        2005-04-16  188  	for (n = 0; n <= npages; n++) {
4b8a9c0afda16b Fabio M. De Francesco 2022-12-31  189  		kaddr = dir_get_page(dir, n, &page);
^1da177e4c3f41 Linus Torvalds        2005-04-16 @190  		err = PTR_ERR(page);

This "err" assignment is a dead store (pointless/never used).

4b8a9c0afda16b Fabio M. De Francesco 2022-12-31  191  		if (IS_ERR(kaddr))
4b8a9c0afda16b Fabio M. De Francesco 2022-12-31  192  			return PTR_ERR(kaddr);
^1da177e4c3f41 Linus Torvalds        2005-04-16  193  		de = (struct sysv_dir_entry *)kaddr;
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  194  		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
^1da177e4c3f41 Linus Torvalds        2005-04-16  195  		while ((char *)de <= kaddr) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  196  			if (!de->inode)
^1da177e4c3f41 Linus Torvalds        2005-04-16  197  				goto got_it;
^1da177e4c3f41 Linus Torvalds        2005-04-16  198  			err = -EEXIST;
^1da177e4c3f41 Linus Torvalds        2005-04-16  199  			if (namecompare(namelen, SYSV_NAMELEN, name, de->name)) 
^1da177e4c3f41 Linus Torvalds        2005-04-16  200  				goto out_page;
^1da177e4c3f41 Linus Torvalds        2005-04-16  201  			de++;
^1da177e4c3f41 Linus Torvalds        2005-04-16  202  		}
^1da177e4c3f41 Linus Torvalds        2005-04-16  203  		dir_put_page(page);
^1da177e4c3f41 Linus Torvalds        2005-04-16  204  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  205  	BUG();
^1da177e4c3f41 Linus Torvalds        2005-04-16  206  	return -EINVAL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  207  
^1da177e4c3f41 Linus Torvalds        2005-04-16  208  got_it:
1023904333f9cb Fabio M. De Francesco 2022-12-31  209  	pos = page_offset(page) + offset_in_page(de);
^1da177e4c3f41 Linus Torvalds        2005-04-16  210  	lock_page(page);
f4e420dc423148 Christoph Hellwig     2010-06-04  211  	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
^1da177e4c3f41 Linus Torvalds        2005-04-16  212  	if (err)
^1da177e4c3f41 Linus Torvalds        2005-04-16  213  		goto out_unlock;
^1da177e4c3f41 Linus Torvalds        2005-04-16  214  	memcpy (de->name, name, namelen);
^1da177e4c3f41 Linus Torvalds        2005-04-16  215  	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
^1da177e4c3f41 Linus Torvalds        2005-04-16  216  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
26a6441aadde86 Nicholas Piggin       2007-10-16  217  	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
02027d42c3f747 Deepa Dinamani        2016-09-14  218  	dir->i_mtime = dir->i_ctime = current_time(dir);
^1da177e4c3f41 Linus Torvalds        2005-04-16  219  	mark_inode_dirty(dir);
^1da177e4c3f41 Linus Torvalds        2005-04-16  220  out_page:
^1da177e4c3f41 Linus Torvalds        2005-04-16  221  	dir_put_page(page);
^1da177e4c3f41 Linus Torvalds        2005-04-16  222  	return err;
^1da177e4c3f41 Linus Torvalds        2005-04-16  223  out_unlock:
^1da177e4c3f41 Linus Torvalds        2005-04-16  224  	unlock_page(page);
^1da177e4c3f41 Linus Torvalds        2005-04-16  225  	goto out_page;
^1da177e4c3f41 Linus Torvalds        2005-04-16  226  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


