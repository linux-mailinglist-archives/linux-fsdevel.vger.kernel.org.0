Return-Path: <linux-fsdevel+bounces-7321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB1823903
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 00:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5051B1C241B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38421EB5C;
	Wed,  3 Jan 2024 23:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047B1EB20;
	Wed,  3 Jan 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d420aaa2abso43774075ad.3;
        Wed, 03 Jan 2024 15:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323343; x=1704928143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZmO2Em5SAGxslvJYxxMr85h0YnmF3m11vf/R6PL49E=;
        b=fQQSIUGWWAZpygvt8r/YzPXsoXS8ZRrT8Su4u0n2+dkRBnlvWfReRZWtWIMkvC61kI
         Q0b5XMgsDWn3jrbW//V33GJAQ0v1j+uA2C7lYI9uQB6K7AnERd1hxVOc2esXqqDAEM7C
         zZBz+1ZsDROA3UWPNdOLTUhUdowwFLn8FmS+87leS3L5mHq6Kox1fd4sQsb2Fq2o/h+l
         iyJ3YMeAviE2Q7zWpDAN0z/QVjFv/irKp2a+eibnSVnzOVxFv827luhVuTsH5yoI7SqF
         a+YwJEXMO11aJxW/CqKVmgEjiU+7GelM/b71ZizqXInt6MZ/HeT7qsYscGmVbOnqYcgi
         ifEg==
X-Gm-Message-State: AOJu0YxiaY9z0LqlQp64zkFnITt03tQDzOxtfLOy0oIIqMCBT2tk37pO
	6vzus9MxtKvmSUTbXVa2mhA=
X-Google-Smtp-Source: AGHT+IEx1EUGxeDBn6VkvBIHx/9b6r5vaU4+g2u2SIxomWqkcQCb6zhm54+bpvg/Vff1UcElOzYnaA==
X-Received: by 2002:a17:903:41cb:b0:1d4:1623:89ff with SMTP id u11-20020a17090341cb00b001d4162389ffmr9747816ple.83.1704323343030;
        Wed, 03 Jan 2024 15:09:03 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b001cfc2e0a82fsm24281340pls.26.2024.01.03.15.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 15:09:02 -0800 (PST)
Message-ID: <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
Date: Wed, 3 Jan 2024 15:09:00 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de>
 <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org> <20240103090204.GA1851@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240103090204.GA1851@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 01:02, Christoph Hellwig wrote:
> So you can use file->f_mapping->inode as I said in my previous mail.

Since struct address_space does not have a member with the name "inode",
I assume that you meant "host" instead of "inode"? If so, how about
modifying patch 06 of this series as shown below? With the patch below
my tests still pass.

Thanks,

Bart.


---
  block/fops.c       | 11 -----------
  fs/fcntl.c         | 15 +++++++++++----
  include/linux/fs.h |  1 -
  3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 138b388b5cb1..787ce52bc2c6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -620,16 +620,6 @@ static int blkdev_release(struct inode *inode, 
struct file *filp)
  	return 0;
  }

-static void blkdev_apply_whint(struct file *file, enum rw_hint hint)
-{
-	struct bdev_handle *handle = file->private_data;
-	struct inode *bd_inode = handle->bdev->bd_inode;
-
-	inode_lock(bd_inode);
-	bd_inode->i_write_hint = hint;
-	inode_unlock(bd_inode);
-}
-
  static ssize_t
  blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
  {
@@ -864,7 +854,6 @@ const struct file_operations def_blk_fops = {
  	.splice_read	= filemap_splice_read,
  	.splice_write	= iter_file_splice_write,
  	.fallocate	= blkdev_fallocate,
-	.apply_whint	= blkdev_apply_whint,
  };

  static __init int blkdev_init(void)
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 18407bf5bb9b..cfb52c3a4577 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file, 
unsigned int cmd,
  static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
  			      unsigned long arg)
  {
-	void (*apply_whint)(struct file *, enum rw_hint);
  	struct inode *inode = file_inode(file);
  	u64 __user *argp = (u64 __user *)arg;
  	u64 hint;
@@ -318,11 +317,19 @@ static long fcntl_set_rw_hint(struct file *file, 
unsigned int cmd,

  	inode_lock(inode);
  	inode->i_write_hint = hint;
-	apply_whint = inode->i_fop->apply_whint;
-	if (apply_whint)
-		apply_whint(file, hint);
  	inode_unlock(inode);

+	/*
+	 * file->f_mapping->host may differ from inode. As an example,
+	 * blkdev_open() modifies file->f_mapping.
+	 */
+	if (file->f_mapping->host != inode) {
+		inode = file->f_mapping->host;
+		inode_lock(inode);
+		inode->i_write_hint = hint;
+		inode_unlock(inode);
+	}
+
  	return 0;
  }

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 293017ea2466..a08014b68d6e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1944,7 +1944,6 @@ struct file_operations {
  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
  				unsigned int poll_flags);
-	void (*apply_whint)(struct file *, enum rw_hint hint);
  } __randomize_layout;

  /* Wrap a directory iterator that needs exclusive inode access */


