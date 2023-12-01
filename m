Return-Path: <linux-fsdevel+bounces-4545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E638005DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 09:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EC41C20C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FF1C2AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nxcj1EEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18131722
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 00:29:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-333030a6537so1316762f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 00:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701419385; x=1702024185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6gXHpNx+PkCBMhTqUU2Gt6us/auY/RnP3BapVW8urA=;
        b=Nxcj1EEP3W5OhLW6P/szyugdZ9pafYDaS+S/DGacY++8pmxzYij8y2meZDOHZJ9qWl
         3c8/qSq6s0uDQqgYsFw68fXy6+c00g+T6EgU03h4uJgxrNr2pbMYVhD6yrJ41T+Te5IB
         mn2kBRzCcKtzS3RZ3RrBI8m1FeF3HKxVOv81ySgHHvhktXsCqgETpGh6kQQNR6zz87Nv
         YJSoaMUfYLZvq80j9zcfShqausmE2tN6LCPUPDVKuhG78m7rUU46fQKTcBhSaYJPllI4
         /ovW4yWksP62kGXkv9lyeEvxs/VfU8ZxmhZoS9Lsr//FbxD/IEqjA257ZKssbsT013fi
         H3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419385; x=1702024185;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6gXHpNx+PkCBMhTqUU2Gt6us/auY/RnP3BapVW8urA=;
        b=eSsIm6CbPBIlDj9XrP6Q1xbZXSYEvPsT/zi0oz2uam6mbffclEF/7Vnx6TvB6AFPKv
         Sg6F5ClRGfVru6eIVIp2y4kItGQweG4WbE+Ah2+Ihkp0k0EMuoxi4NorqV/yETKGXV5U
         QvBton5Jl6hhAWr8qCYjNoFAG4Yg+PEh5U0CK518Z69cFY+NSAXqxSk8f0gYoCORoNnx
         FLQurKczvqQ4fxrNA32V7KUmo4ddwUTD9Evf8lXieXY8mPoy2Cc/a2azlaGMsHMSXSDk
         wTRLQcfr9UxL0g8dHj1HNYSIBoS6TyLcqmT/YuIwXBI7ggQVSoSXnlwUlhlP+E2vUzv6
         N2DQ==
X-Gm-Message-State: AOJu0YxBCqLUBvjG7BH/z9ZJTVG8xCbQUgaN7WXl8RyQAlC2iJUs6hFT
	BJyxv0zNVxa8HdczvRchnid/2A==
X-Google-Smtp-Source: AGHT+IG7Z9E6bM65aRDTHTzyOLkphb4DBCEpAlIP/e0W+vdlWBx5h9150tj/aopIboeccIuVQh3bRw==
X-Received: by 2002:a5d:4488:0:b0:332:ca0b:5793 with SMTP id j8-20020a5d4488000000b00332ca0b5793mr530324wrq.19.1701419385016;
        Fri, 01 Dec 2023 00:29:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b00333040a4752sm3577547wrm.114.2023.12.01.00.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:29:44 -0800 (PST)
Date: Fri, 1 Dec 2023 11:29:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	"Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>,
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH v5 1/2] exfat: change to get file size from DataLength
Message-ID: <4308b820-7d69-42e6-8b07-205e81add314@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuezhang-Mo-sony-com/exfat-do-not-zero-the-extended-part/20231130-164222
base:   linus/master
patch link:    https://lore.kernel.org/r/PUZPR04MB6316F0640983B00CC55D903F8182A%40PUZPR04MB6316.apcprd04.prod.outlook.com
patch subject: [PATCH v5 1/2] exfat: change to get file size from DataLength
config: x86_64-randconfig-r081-20231130 (https://download.01.org/0day-ci/archive/20231201/202312010428.73gtRyvj-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312010428.73gtRyvj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312010428.73gtRyvj-lkp@intel.com/

smatch warnings:
fs/exfat/inode.c:525 exfat_direct_IO() warn: bitwise AND condition is false here

vim +525 fs/exfat/inode.c

5f2aa075070cf5b Namjae Jeon          2020-03-02  486  static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
5f2aa075070cf5b Namjae Jeon          2020-03-02  487  {
5f2aa075070cf5b Namjae Jeon          2020-03-02  488  	struct address_space *mapping = iocb->ki_filp->f_mapping;
5f2aa075070cf5b Namjae Jeon          2020-03-02  489  	struct inode *inode = mapping->host;
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  490  	struct exfat_inode_info *ei = EXFAT_I(inode);
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  491  	loff_t pos = iocb->ki_pos;
5f2aa075070cf5b Namjae Jeon          2020-03-02  492  	loff_t size = iocb->ki_pos + iov_iter_count(iter);
5f2aa075070cf5b Namjae Jeon          2020-03-02  493  	int rw = iov_iter_rw(iter);
5f2aa075070cf5b Namjae Jeon          2020-03-02  494  	ssize_t ret;
5f2aa075070cf5b Namjae Jeon          2020-03-02  495  
5f2aa075070cf5b Namjae Jeon          2020-03-02  496  	if (rw == WRITE) {
5f2aa075070cf5b Namjae Jeon          2020-03-02  497  		/*
5f2aa075070cf5b Namjae Jeon          2020-03-02  498  		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
5f2aa075070cf5b Namjae Jeon          2020-03-02  499  		 * so we need to update the ->i_size_aligned to block boundary.
5f2aa075070cf5b Namjae Jeon          2020-03-02  500  		 *
5f2aa075070cf5b Namjae Jeon          2020-03-02  501  		 * But we must fill the remaining area or hole by nul for
5f2aa075070cf5b Namjae Jeon          2020-03-02  502  		 * updating ->i_size_aligned
5f2aa075070cf5b Namjae Jeon          2020-03-02  503  		 *
5f2aa075070cf5b Namjae Jeon          2020-03-02  504  		 * Return 0, and fallback to normal buffered write.
5f2aa075070cf5b Namjae Jeon          2020-03-02  505  		 */
5f2aa075070cf5b Namjae Jeon          2020-03-02  506  		if (EXFAT_I(inode)->i_size_aligned < size)
5f2aa075070cf5b Namjae Jeon          2020-03-02  507  			return 0;
5f2aa075070cf5b Namjae Jeon          2020-03-02  508  	}
5f2aa075070cf5b Namjae Jeon          2020-03-02  509  
5f2aa075070cf5b Namjae Jeon          2020-03-02  510  	/*
5f2aa075070cf5b Namjae Jeon          2020-03-02  511  	 * Need to use the DIO_LOCKING for avoiding the race
5f2aa075070cf5b Namjae Jeon          2020-03-02  512  	 * condition of exfat_get_block() and ->truncate().
5f2aa075070cf5b Namjae Jeon          2020-03-02  513  	 */
5f2aa075070cf5b Namjae Jeon          2020-03-02  514  	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  515  	if (ret < 0) {
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  516  		if (rw & WRITE)

This code works and the checker doesn't complain about it, but for
consistency I think it should be if (rw == WRITE).

5f2aa075070cf5b Namjae Jeon          2020-03-02  517  			exfat_write_failed(mapping, size);
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  518  
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  519  		if (ret != -EIOCBQUEUED)
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  520  			return ret;
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  521  	} else
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  522  		size = pos + ret;
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  523  
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  524  	/* zero the unwritten part in the partially written block */
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30 @525  	if ((rw & READ) && pos < ei->valid_size && ei->valid_size < size) {

I think this should be rw == READ.

6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  526  		iov_iter_revert(iter, size - ei->valid_size);
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  527  		iov_iter_zero(size - ei->valid_size, iter);
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  528  	}
6642222a5afe775 Yuezhang.Mo@sony.com 2023-11-30  529  
5f2aa075070cf5b Namjae Jeon          2020-03-02  530  	return ret;
5f2aa075070cf5b Namjae Jeon          2020-03-02  531  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


