Return-Path: <linux-fsdevel+bounces-3793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447827F88B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0082281822
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AF3FF1;
	Sat, 25 Nov 2023 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoVO7vUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002119E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 22:59:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b399f0b6fso10549555e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 22:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700895588; x=1701500388; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jv56Dw/13rdERqX56wyZWfTEhu+Zdb+87UC8Y/SSDI=;
        b=IoVO7vUgAPfRSCePo0uYhgYPy7L3G4xnOmuQnvVjx/0kJmhWBcMCFT+Jqk/cEAtUUa
         7V/2mmZf3ASkjiqaGMOBUpM+3wGORLBhCU0AOj9mScpW+11FjOyhXwFtIzMrCH6TyHLS
         a7s8+Df6VFpUbMFI+B5UB6o6SH/qWtV58ve9XZXMD2KP9OhV90U2Wn+JRT6ArlGxcUJH
         GK7/dB4cZ85iaKSWtD3X5aDmuuDrQTLEhhMdl7bG3QIWqzSEwXeKGWaRRoebHBmEmJcz
         EHsyu+WVJv3sSRkWkGrFN+Hl5DPZ75lAMvcjyRHi7vjVz9YdQzc3jSWy35U+3l93MEkI
         FLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700895588; x=1701500388;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jv56Dw/13rdERqX56wyZWfTEhu+Zdb+87UC8Y/SSDI=;
        b=sdxUrJvU4ZSMr4edR2Xhrhb/8KJ8Ybo8X1vF89TRtDJAVArOiHyBSU95A73FHJkP+G
         UAOxGH5LKNkuNjNWUjwoTG/zTC1/XBw0zD5nWznbBIODB/69NraHmGbaKH/5guC09/lh
         xbcu3YyRX0xemjRRBvmrnZtZYng6FjViQHFHXx8+851bplJKhyoLRUrsSrQTwR9YXFfE
         JwrqvctofyUHFRWN87M73XkxsR3hza0pDkSHVSvo27etTPuL5Hfp58BuoZsuhaGQwGNX
         UDqfS8AlgDyLr4+hWk7TCKUCq5EKoH6S8bQVSAR+QWk4gLTFIhk2k2ctx7veUXF+saAL
         /DMQ==
X-Gm-Message-State: AOJu0Yx79XCI/Sp529z3cK3I56dHYHry4Q9+rQ8GadWofyNbRLLeL5cV
	x1kkKT2e5hH5ez268WtCSUesWg==
X-Google-Smtp-Source: AGHT+IE0H38nrVlmsa1+mXam7+u2KQDJktnXjDn6D3EDkxDsBXvxWXcWdOoy/SNYk/aKOMrGECN6vg==
X-Received: by 2002:a05:600c:3c82:b0:40b:3820:acf4 with SMTP id bg2-20020a05600c3c8200b0040b3820acf4mr428430wmb.3.1700895588376;
        Fri, 24 Nov 2023 22:59:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c419600b0040a3f9862e3sm2587550wmh.1.2023.11.24.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 22:59:48 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 25 Nov 2023 09:59:45 +0300
To: oe-kbuild@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.dcache-misc 10/18] fs/dcache.c:2062
 __d_obtain_alias() warn: variable dereferenced before check 'inode' (see
 line 2059)
Message-ID: <c1712d34-7c60-4491-aee7-7ae9177c2c4c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache-misc
head:   0695819b3988e7e4d8099f8388244c1549d230cc
commit: 8a0af412cf8ba3a000a0e00c0c5dd411b9a0fc2a [10/18] kill d_instantate_anon(), fold __d_instantiate_anon() into remaining caller
config: i386-randconfig-141-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241915.3OrRNpQB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241915.3OrRNpQB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311241915.3OrRNpQB-lkp@intel.com/

smatch warnings:
fs/dcache.c:2062 __d_obtain_alias() warn: variable dereferenced before check 'inode' (see line 2059)

vim +/inode +2062 fs/dcache.c

f9c34674bc60e5 Miklos Szeredi    2018-01-19  2057  static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2058  {
8a0af412cf8ba3 Al Viro           2023-11-18 @2059  	struct super_block *sb = inode->i_sb;
                                                                                 ^^^^^^^^^^^
Unchecked dereference

8a0af412cf8ba3 Al Viro           2023-11-18  2060  	struct dentry *new, *res;
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2061  
f9c34674bc60e5 Miklos Szeredi    2018-01-19 @2062  	if (!inode)
                                                            ^^^^^^
NULL check is too late

f9c34674bc60e5 Miklos Szeredi    2018-01-19  2063  		return ERR_PTR(-ESTALE);
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2064  	if (IS_ERR(inode))
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2065  		return ERR_CAST(inode);
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2066  
8a0af412cf8ba3 Al Viro           2023-11-18  2067  	res = d_find_any_alias(inode); /* existing alias? */
f9c34674bc60e5 Miklos Szeredi    2018-01-19  2068  	if (res)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


