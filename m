Return-Path: <linux-fsdevel+bounces-42-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73547C4B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45D11C20DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECBB18C2D;
	Wed, 11 Oct 2023 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNVWckEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A018B1E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:17:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30678F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:17:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so6392864f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697008643; x=1697613443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhK5ZZITA9PWclc67B5lQjGuI1Rti5S1fpJxVmbBRY=;
        b=TNVWckEjRNmiuyKqwHCq0e6NsSnQr26LQWFvaUd2u+yqWqn3OJwRy4c+UA9tWak6dt
         xcr3b1614AiXdjHbpFDFrePYSQ8GX/Ay829IEm6xxTey5+qP1lC/hKqS0c44RoCbwYsV
         g1b9g8RKMeGQKClBNFaFCTw6b3dzy8HQFw3CgmTFtd+60MugiKRuFxEMavjpWl3Sp/CY
         OnHYRDDz3qpuTCk0cUstoH7eGVzheTY2MxkcgeddQiWXLCwgTg0UuiVEg/0Yv9qdzPi6
         X6mL0/ionDNnuOVKwwDopz70UW73jlSj6/mKm7Z3p4be/F89juIjOzKYoWdv0sS8wO6t
         7oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697008643; x=1697613443;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayhK5ZZITA9PWclc67B5lQjGuI1Rti5S1fpJxVmbBRY=;
        b=OZ1+Kmqr96dha53KMEKvtCuzOMRQ4GGgIuVpxcnk+AkIKaAy8iGbBUKvmyNx5ByNZY
         5ugBeR3PD7j7oHNFXl0k8UKnyXKlXkyhe3ZKJTwxqXvZwcI1hNqp3aO3sc7QazH487XN
         2PmD9hf05vZwbx1eoJO0e8+wgptQJBqxtld4yqD2+mA4sVQfa9FOxmgZCS+WZuGNcuzy
         8f/fSN9EDLe0urcLjewQ6EEnCYnV3U3GmzyYlaaeQacd6KCssvmxLZ5vd5hJizrHJK1f
         GBOxleK+b8FC4+3jrkcO5cjB71UghD96iwS3agNDEnfARTQ6Ao5X8qaYC1wsk/ZNK41J
         kCUA==
X-Gm-Message-State: AOJu0YwE8Y3HtMC4+JPggQWo/cYf5NNTQa9jMeeQBumrUXfbV9DwDNYE
	57v/kRKDvKI86IyEFc8t+wxdUw==
X-Google-Smtp-Source: AGHT+IGSgMuPNZcSb/qoRef2LT95GhuxlKDkCfgKDCNsPI99qj2VC19cSkJtgFiebD0cnCw5aDp8BA==
X-Received: by 2002:adf:ef91:0:b0:31f:f1f4:ca8b with SMTP id d17-20020adfef91000000b0031ff1f4ca8bmr16220473wro.40.1697008643069;
        Wed, 11 Oct 2023 00:17:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v26-20020a5d591a000000b0030ada01ca78sm14562733wrd.10.2023.10.11.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:17:22 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:17:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
Message-ID: <f1b371ce-9fa7-4d1c-bcad-968d1706ac99@kadam.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920173445.3943581-5-bschubert@ddn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bernd,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bernd-Schubert/fuse-rename-fuse_create_open/20230921-013805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git for-next
patch link:    https://lore.kernel.org/r/20230920173445.3943581-5-bschubert%40ddn.com
patch subject: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
config: i386-randconfig-141-20230927 (https://download.01.org/0day-ci/archive/20231011/202310111259.WGjXat6p-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310111259.WGjXat6p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310111259.WGjXat6p-lkp@intel.com/

New smatch warnings:
fs/namei.c:3418 atomic_revalidate_open() warn: variable dereferenced before check 'got_write' (see line 3414)

Old smatch warnings:
fs/namei.c:1573 lookup_dcache() warn: passing zero to 'ERR_PTR'
fs/namei.c:1658 lookup_fast() warn: passing zero to 'ERR_PTR'
fs/namei.c:2189 hash_name() error: uninitialized symbol 'bdata'.
fs/namei.c:2600 __kern_path_locked() warn: inconsistent returns '&path->dentry->d_inode->i_rwsem'.
fs/namei.c:3480 lookup_open() error: uninitialized symbol 'error'.

vim +/got_write +3418 fs/namei.c

0bb53ce89df211 Bernd Schubert 2023-09-20  3391  static struct dentry *atomic_revalidate_open(struct dentry *dentry,
0bb53ce89df211 Bernd Schubert 2023-09-20  3392  					     struct nameidata *nd,
0bb53ce89df211 Bernd Schubert 2023-09-20  3393  					     struct file *file,
0bb53ce89df211 Bernd Schubert 2023-09-20  3394  					     const struct open_flags *op,
0bb53ce89df211 Bernd Schubert 2023-09-20  3395  					     bool *got_write)
0bb53ce89df211 Bernd Schubert 2023-09-20  3396  {
0bb53ce89df211 Bernd Schubert 2023-09-20  3397  	struct mnt_idmap *idmap;
0bb53ce89df211 Bernd Schubert 2023-09-20  3398  	struct dentry *dir = nd->path.dentry;
0bb53ce89df211 Bernd Schubert 2023-09-20  3399  	struct inode *dir_inode = dir->d_inode;
0bb53ce89df211 Bernd Schubert 2023-09-20  3400  	int open_flag = op->open_flag;
0bb53ce89df211 Bernd Schubert 2023-09-20  3401  	umode_t mode = op->mode;
0bb53ce89df211 Bernd Schubert 2023-09-20  3402  
0bb53ce89df211 Bernd Schubert 2023-09-20  3403  	if (unlikely(IS_DEADDIR(dir_inode)))
0bb53ce89df211 Bernd Schubert 2023-09-20  3404  		return ERR_PTR(-ENOENT);
0bb53ce89df211 Bernd Schubert 2023-09-20  3405  
0bb53ce89df211 Bernd Schubert 2023-09-20  3406  	file->f_mode &= ~FMODE_CREATED;
0bb53ce89df211 Bernd Schubert 2023-09-20  3407  
0bb53ce89df211 Bernd Schubert 2023-09-20  3408  	if (unlikely(open_flag & O_CREAT)) {
0bb53ce89df211 Bernd Schubert 2023-09-20  3409  		WARN_ON(1);
0bb53ce89df211 Bernd Schubert 2023-09-20  3410  		return ERR_PTR(-EINVAL);
0bb53ce89df211 Bernd Schubert 2023-09-20  3411  	}
0bb53ce89df211 Bernd Schubert 2023-09-20  3412  
0bb53ce89df211 Bernd Schubert 2023-09-20  3413  	if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
0bb53ce89df211 Bernd Schubert 2023-09-20 @3414  		*got_write = !mnt_want_write(nd->path.mnt);

Dereferenced

0bb53ce89df211 Bernd Schubert 2023-09-20  3415  	else
0bb53ce89df211 Bernd Schubert 2023-09-20  3416  		*got_write = false;

Here too.

0bb53ce89df211 Bernd Schubert 2023-09-20  3417  
0bb53ce89df211 Bernd Schubert 2023-09-20 @3418  	if (!got_write)

Checked too late.  But I think maybe it was supposed to check
if (!*got_write)?

0bb53ce89df211 Bernd Schubert 2023-09-20  3419  		open_flag &= ~O_TRUNC;
0bb53ce89df211 Bernd Schubert 2023-09-20  3420  
0bb53ce89df211 Bernd Schubert 2023-09-20  3421  	inode_lock_shared(dir->d_inode);
0bb53ce89df211 Bernd Schubert 2023-09-20  3422  	dentry = atomic_open(nd, dentry, file, open_flag, mode);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


