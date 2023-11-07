Return-Path: <linux-fsdevel+bounces-2207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D47E3485
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 05:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F13280EE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 04:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38947947B;
	Tue,  7 Nov 2023 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNqp7n1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE48F6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 04:27:53 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C648110
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 20:27:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507bd644a96so7507576e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699331270; x=1699936070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz4ibFEani6ikAiwKtvYQFIOOBnNzX2wLnv6rOwCCMs=;
        b=GNqp7n1p66wPlnB4E/S3CX+7x5J6beEzFXIv/prYoqTcsPbzO4SVmaVMGWDxh7lObN
         iBovWIZ2P4EJmBEc+MkFXX+r73s0gJ7APcmP0utgD6+/OdoI2F8wmIfBn+fWQpNOhkkT
         vqg49l4XVxJTyff01ai/ha0+MPrE1pL4CRuk8fxWy6TncAF7wjWoQmIOOfn2lJRhHP8M
         6oTCM1p5DOWOpIrze+KGn+WZqnnpULP/dJ5uzD9wlzH+XtRUxYD9gXzLRcwZ3dhyEKcL
         RqO7UbUcXH7GSajFKHVfEfvMo2wX+dmVyU8RsqxO3upjtnCf2XDMTvCLsksEIZIcolrZ
         BO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699331270; x=1699936070;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bz4ibFEani6ikAiwKtvYQFIOOBnNzX2wLnv6rOwCCMs=;
        b=OL45yqTtJL3ibyxDYzZ/zMnrxnIvlLpL7sMosrGRamn6I/XFRpdhc6Fo6xRwMYSmWQ
         7XhcrLnL6g/cTxyZYBE6N+9fSYqH+Dmadi9LQIYjCr6pC7l1U1i8BY/CUCI/ShjF4N/t
         AbdXcoreEgHx3R52xGiOwuIC4xB4+uMPeCqMScONAFETd7JYYG04itQzTEVy5ElV6WaE
         GfTbjJNlq/hNAw4AjqK4by70tNJZ3b7cOvRkYk4mLjo35Hgpofvvo3FYbIiTVkXPriYd
         rX4rksiK5hzzf+tn5FWRluZ1+BzaHhvM5RP25sVnvivV/rEZu/wqipcgttvpgyK5qEah
         KRSA==
X-Gm-Message-State: AOJu0YzL3KK2k0A7WuInjEynbQmnHIbycJD8nuwj2JzyiBDkZQXfWpNS
	267NKdCXxocsEt7VirkHQ9AiSQ==
X-Google-Smtp-Source: AGHT+IFk9UPUznehgtsFa3wG1YIBTyBLMwYw8zTr1jNMtB7C1OcB8sHn4sRwgOB6wi5Zu5GGegmbOw==
X-Received: by 2002:ac2:4850:0:b0:507:a089:caf4 with SMTP id 16-20020ac24850000000b00507a089caf4mr23066306lfy.60.1699331270333;
        Mon, 06 Nov 2023 20:27:50 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d26-20020a50cd5a000000b0053dab756073sm5148167edj.84.2023.11.06.20.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:27:50 -0800 (PST)
Date: Tue, 7 Nov 2023 07:27:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Zhou Jifeng <zhoujifeng@kylinos.com.cn>,
	miklos@szeredi.hu
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Subject: Re: [PATCH] fuse: Track process write operations in both direct and
 writethrough modes
Message-ID: <70dde24c-5aee-4752-a14e-74ffdc6f7359@kadam.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>

Hi Zhou,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Jifeng/fuse-Track-process-write-operations-in-both-direct-and-writethrough-modes/20231028-150119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20231028065912.6084-1-zhoujifeng%40kylinos.com.cn
patch subject: [PATCH] fuse: Track process write operations in both direct and writethrough modes
config: x86_64-randconfig-161-20231103 (https://download.01.org/0day-ci/archive/20231107/202311070338.uJNMq6Sh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070338.uJNMq6Sh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311070338.uJNMq6Sh-lkp@intel.com/

smatch warnings:
fs/fuse/file.c:1359 fuse_cache_write_iter() error: uninitialized symbol 'err'.

vim +/err +1359 fs/fuse/file.c

55752a3aba1387 Miklos Szeredi    2019-01-24  1302  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1303  {
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1304  	struct file *file = iocb->ki_filp;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1305  	struct address_space *mapping = file->f_mapping;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1306  	ssize_t written = 0;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1307  	struct inode *inode = mapping->host;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1308  	ssize_t err;
56597c4ddc107c Zhou Jifeng       2023-10-28  1309  	ssize_t count;
8981bdfda7445a Vivek Goyal       2020-10-09  1310  	struct fuse_conn *fc = get_fuse_conn(inode);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1311  
8981bdfda7445a Vivek Goyal       2020-10-09  1312  	if (fc->writeback_cache) {
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1313  		/* Update size (EOF optimization) and mode (SUID clearing) */
c6c745b81033a4 Miklos Szeredi    2021-10-22  1314  		err = fuse_update_attributes(mapping->host, file,
c6c745b81033a4 Miklos Szeredi    2021-10-22  1315  					     STATX_SIZE | STATX_MODE);
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1316  		if (err)
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1317  			return err;
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1318  
8981bdfda7445a Vivek Goyal       2020-10-09  1319  		if (fc->handle_killpriv_v2 &&
9452e93e6dae86 Christian Brauner 2023-01-13  1320  		    setattr_should_drop_suidgid(&nop_mnt_idmap,
9452e93e6dae86 Christian Brauner 2023-01-13  1321  						file_inode(file))) {
8981bdfda7445a Vivek Goyal       2020-10-09  1322  			goto writethrough;
8981bdfda7445a Vivek Goyal       2020-10-09  1323  		}
8981bdfda7445a Vivek Goyal       2020-10-09  1324  
84c3d55cc474f9 Al Viro           2014-04-03  1325  		return generic_file_write_iter(iocb, from);
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1326  	}
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1327  
8981bdfda7445a Vivek Goyal       2020-10-09  1328  writethrough:
5955102c9984fa Al Viro           2016-01-22  1329  	inode_lock(inode);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1330  
56597c4ddc107c Zhou Jifeng       2023-10-28  1331  	count = generic_write_checks(iocb, from);
56597c4ddc107c Zhou Jifeng       2023-10-28  1332  	if (count <= 0)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1333  		goto out;

Missing error code?

ea9b9907b82a09 Nicholas Piggin   2008-04-30  1334  
56597c4ddc107c Zhou Jifeng       2023-10-28  1335  	task_io_account_write(count);
56597c4ddc107c Zhou Jifeng       2023-10-28  1336  
5fa8e0a1c6a762 Jan Kara          2015-05-21  1337  	err = file_remove_privs(file);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1338  	if (err)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1339  		goto out;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1340  
c3b2da31483449 Josef Bacik       2012-03-26  1341  	err = file_update_time(file);
c3b2da31483449 Josef Bacik       2012-03-26  1342  	if (err)
c3b2da31483449 Josef Bacik       2012-03-26  1343  		goto out;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1344  
2ba48ce513c4e5 Al Viro           2015-04-09  1345  	if (iocb->ki_flags & IOCB_DIRECT) {
1af5bb491fbb41 Christoph Hellwig 2016-04-07  1346  		written = generic_file_direct_write(iocb, from);
84c3d55cc474f9 Al Viro           2014-04-03  1347  		if (written < 0 || !iov_iter_count(from))
4273b793ec6875 Anand Avati       2012-02-17  1348  			goto out;
64d1b4dd826d88 Christoph Hellwig 2023-06-01  1349  		written = direct_write_fallback(iocb, from, written,
64d1b4dd826d88 Christoph Hellwig 2023-06-01  1350  				fuse_perform_write(iocb, from));
4273b793ec6875 Anand Avati       2012-02-17  1351  	} else {
596df33d673d9d Christoph Hellwig 2023-06-01  1352  		written = fuse_perform_write(iocb, from);
4273b793ec6875 Anand Avati       2012-02-17  1353  	}
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1354  out:
5955102c9984fa Al Viro           2016-01-22  1355  	inode_unlock(inode);
e1c0eecba1a415 Miklos Szeredi    2017-09-12  1356  	if (written > 0)
e1c0eecba1a415 Miklos Szeredi    2017-09-12  1357  		written = generic_write_sync(iocb, written);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1358  
ea9b9907b82a09 Nicholas Piggin   2008-04-30 @1359  	return written ? written : err;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1360  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


