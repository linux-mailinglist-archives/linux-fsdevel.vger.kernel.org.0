Return-Path: <linux-fsdevel+bounces-55774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF83B0E885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 04:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387C97AED43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744E19D88F;
	Wed, 23 Jul 2025 02:16:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555BF2F43;
	Wed, 23 Jul 2025 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237011; cv=none; b=UZ2PuM7Dotfv9XYPdkDgj1m4UY/eCaZZMmjivNu1izZftfPYr9XNUqptdNbBWRJaUWcg0EEH6iI7eIYwV5fwxAMQImJke1gXbo3dZVPPwd6WfL/ZuGeu5glzLUd79xXqIA3xC5rn7/hDpi73Xc21a4ZM0u4OY9PUef2cGnv0ziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237011; c=relaxed/simple;
	bh=pvxWFil2B7sifCFp7k+cVtk0exx8QZ8fKoaj5BURZ6k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oqh720SNmNtgG6lqyMmnJV6eni7PciYO7NIuFxPL5Rq5hbs/sVknEcHp7N/6j4w3fnfWVjCws+MS7g008eLWvJt5/FLNatbRmfejABgK2/CZWnQbq0MDPWL2B9HpAufTn/49cGYg+RbbR7WfEB9pgydPFXWWxD/dqoXedI5UKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56N2GRY0001481;
	Wed, 23 Jul 2025 11:16:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56N2GRAG001477
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Jul 2025 11:16:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
Date: Wed, 23 Jul 2025 11:16:28 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

With below change, legitimate HFS filesystem images can be mounted.

But is crafted HFS filesystem images can not be mounted expected result?

  # losetup -a
  /dev/loop0: [0001]:7185 (/memfd:syzkaller (deleted))
  # mount -t hfs /dev/loop0 /mnt/
  mount: /mnt: filesystem was mounted, but any subsequent operation failed: Operation not permitted.
  # fsck.hfs /dev/loop0
  ** /dev/loop0
     Executing fsck_hfs (version 540.1-Linux).
  ** Checking HFS volume.
     Invalid extent entry
  (3, 0)
  ** The volume   could not be verified completely.
  # mount -t hfs /dev/loop0 /mnt/
  mount: /mnt: filesystem was mounted, but any subsequent operation failed: Operation not permitted.

Also, are IDs which should be excluded from make_bad_inode() conditions
same for HFS_CDR_FIL and HFS_CDR_DIR ?


--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -358,6 +358,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
                inode->i_op = &hfs_file_inode_operations;
                inode->i_fop = &hfs_file_operations;
                inode->i_mapping->a_ops = &hfs_aops;
+               if (inode->i_ino < HFS_FIRSTUSER_CNID)
+                       goto check_reserved_ino;
                break;
        case HFS_CDR_DIR:
                inode->i_ino = be32_to_cpu(rec->dir.DirID);
@@ -368,6 +370,24 @@ static int hfs_read_inode(struct inode *inode, void *data)
                                      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
                inode->i_op = &hfs_dir_inode_operations;
                inode->i_fop = &hfs_dir_operations;
+               if (inode->i_ino < HFS_FIRSTUSER_CNID)
+                       goto check_reserved_ino;
+               break;
+       default:
+               make_bad_inode(inode);
+       }
+       return 0;
+check_reserved_ino:
+       switch (inode->i_ino) {
+       case HFS_POR_CNID:
+       case HFS_ROOT_CNID:
+       case HFS_EXT_CNID:
+       case HFS_CAT_CNID:
+       case HFS_BAD_CNID:
+       case HFS_ALLOC_CNID:
+       case HFS_START_CNID:
+       case HFS_ATTR_CNID:
+       case HFS_EXCH_CNID:
                break;
        default:
                make_bad_inode(inode);


