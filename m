Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77D62DCE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 14:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbiKQNex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 08:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQNeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:34:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AB6D4B3;
        Thu, 17 Nov 2022 05:34:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bs21so3863063wrb.4;
        Thu, 17 Nov 2022 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhKVrw7KFZLn19rEhcnsVCkZk3EVXEQ/dtAysM5yqZs=;
        b=B/L/OYCqdPqaKN60Yirvyp/xs6JOCIuqb66bFgjcdBJLtXQiw6xc0AU1s84FHbe2e/
         PnhxqJqULnV9dP7+GxBXDOKu178DEr6M2AZ2K5iwUgDVPBoed7qcgMVuHD0aZhSlJVkV
         DebKnQNJ2VEIwLKXBluPepo7zDBVzEmX9qMd6lZCeRtNd/F36g2jv40nLdWKNLtgwsxk
         NB2E1XRBB/NKNcIIvzJ9CaB4FQVqDSykkae7b8Q9MA00G5SJU3csOMdPL6ZhJy29z7kI
         koosCRasnhwU+u6BI+BQeyObnmjjzR2p/wocFa7BEBuDs6ETP/rPngfmmzVVWDdTCjap
         qCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhKVrw7KFZLn19rEhcnsVCkZk3EVXEQ/dtAysM5yqZs=;
        b=HF2qWE4PQTW9pEsbZhACWqnbW+24lDiQGL1cGWc9dP36zsjVAnV/XVKezWwpJ8finU
         /eQUXqKhXc1kVJkYvzfwegsZDQ/AL08UvlwhzCTNrq0o5h+YXa9tAuRySGQjABSd3ruc
         bkszt488XIPuTAlxeOx3XzL5lEObsm7fKZDARTL9AqWL0LBLkanZaWNa+OT3b7eCa2JI
         VwlvY/H3UM58Q3pr8GTbuge8dfTUnjfAosQz37JN1PKa7EG+D56jJe765Uvm//zZoIBx
         958GWMP8Jt/LefJGbcd+Dusx01j6KqmLzpY29h0cI6zy+F/nMgL6+ZbLtV0lpzi2fQVI
         b/ww==
X-Gm-Message-State: ANoB5pmVpUN1dG6rY3TqMck6m5jPDtMiGYFajI498cjyeDXe82Cd0ug5
        MG4wy5Nk4JQpILEeIWvGRv1goClc9+RfMw==
X-Google-Smtp-Source: AA0mqf5/+mRn66/+kGSXe1ZnQM3zgaeAFTVcX4rccGy0llnt7XV8Gpo+YfaUqoTAQE+IvVmvsdgJ0Q==
X-Received: by 2002:adf:f843:0:b0:241:bcae:987f with SMTP id d3-20020adff843000000b00241bcae987fmr306084wrq.619.1668692086759;
        Thu, 17 Nov 2022 05:34:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cf75f56105sm1653285wmq.41.2022.11.17.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:34:46 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:34:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Denis Arefev <arefev@swemel.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] namespace: Added pointer check in copy_mnt_ns()
Message-ID: <202211171954.d4Dr5tHz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116091255.84576-1-arefev@swemel.ru>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Denis,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Denis-Arefev/namespace-Added-pointer-check-in-copy_mnt_ns/20221116-171424
patch link:    https://lore.kernel.org/r/20221116091255.84576-1-arefev%40swemel.ru
patch subject: [PATCH] namespace: Added pointer check in copy_mnt_ns()
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
fs/namespace.c:3518 copy_mnt_ns() error: we previously assumed 'p' could be null (see line 3518)

Old smatch warnings:
fs/namespace.c:4059 mount_setattr_prepare() error: uninitialized symbol 'err'.

vim +/p +3518 fs/namespace.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  3494  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  3495  	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
^1da177e4c3f41 Linus Torvalds    2005-04-16  3496  	 * as belonging to new namespace.  We have already acquired a private
^1da177e4c3f41 Linus Torvalds    2005-04-16  3497  	 * fs_struct, so tsk->fs->lock is not needed.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3498  	 */
909b0a88ef2dc8 Al Viro           2011-11-25  3499  	p = old;
cb338d06e9716c Al Viro           2011-11-24  3500  	q = new;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3501  	while (p) {
143c8c91cee7ef Al Viro           2011-11-25  3502  		q->mnt_ns = new_ns;
d29216842a85c7 Eric W. Biederman 2016-09-28  3503  		new_ns->mounts++;
9559f68915024e Al Viro           2013-09-28  3504  		if (new_fs) {
9559f68915024e Al Viro           2013-09-28  3505  			if (&p->mnt == new_fs->root.mnt) {
9559f68915024e Al Viro           2013-09-28  3506  				new_fs->root.mnt = mntget(&q->mnt);
315fc83e56c699 Al Viro           2011-11-24  3507  				rootmnt = &p->mnt;
315fc83e56c699 Al Viro           2011-11-24  3508  			}
9559f68915024e Al Viro           2013-09-28  3509  			if (&p->mnt == new_fs->pwd.mnt) {
9559f68915024e Al Viro           2013-09-28  3510  				new_fs->pwd.mnt = mntget(&q->mnt);
315fc83e56c699 Al Viro           2011-11-24  3511  				pwdmnt = &p->mnt;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3512  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3513  		}
909b0a88ef2dc8 Al Viro           2011-11-25  3514  		p = next_mnt(p, old);
909b0a88ef2dc8 Al Viro           2011-11-25  3515  		q = next_mnt(q, new);
ff6985ba29d455 Denis Arefev      2022-11-16  3516  		if (!q || !p)
4ce5d2b1a8fde8 Eric W. Biederman 2013-03-30  3517  			break;
ff6985ba29d455 Denis Arefev      2022-11-16 @3518  		while (!p && (p->mnt.mnt_root != q->mnt.mnt_root))
                                                                       ^
The ! needs to be removed.

4ce5d2b1a8fde8 Eric W. Biederman 2013-03-30  3519  			p = next_mnt(p, old);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3520  	}
328e6d9014636a Al Viro           2013-03-16  3521  	namespace_unlock();
^1da177e4c3f41 Linus Torvalds    2005-04-16  3522  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3523  	if (rootmnt)
f03c65993b98ee Al Viro           2011-01-14  3524  		mntput(rootmnt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3525  	if (pwdmnt)
f03c65993b98ee Al Viro           2011-01-14  3526  		mntput(pwdmnt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3527  
741a2951306061 JANAK DESAI       2006-02-07  3528  	return new_ns;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3529  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

