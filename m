Return-Path: <linux-fsdevel+bounces-73527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B85D1C300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D4130329C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C085314A6B;
	Wed, 14 Jan 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3kmpFwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC518B0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359819; cv=none; b=d+Ov6gIXqhhlDXLSHQRXhV8saRgc0xGOXJMbn2LSNA7KAA03JjJcFPDcbKN0W+Ngq+515Of2kXjdVR1JBL2uMR2np43oFgHmti76cxYRKCYYa4qxeBI8hrkkt8o4UcnKqlDgdDBTnKgmjS6FLIU36uWgjYCZ1uFfi7jzSp//+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359819; c=relaxed/simple;
	bh=vLnc9LnqMl5zQJvd5sVYyYqCjK2QtGtvP+tpBsVwvfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQrz7ROWPSo1z1IGFIlibWDtM9HXYNTlMfOyseuyY6Z+iIyK211y2Rtg3veTqiu3cwnC0tSii6zLQmfraTyLHmkACDw7mx/JW2FRhwGnqap8yTDPRNzxl46+T6lLb++NaApteXlqpM2bpRsFPS4kpDF5vXW509PYdWtTWruzlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3kmpFwN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c3e921afad1so3392595a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768359818; x=1768964618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4iWd9TygCS9lSZiyJguZ435vfrdxtAD9uaJeiXTYrE=;
        b=I3kmpFwN0Mh4fmJX0LgrS64ZBNTf3QkA2VLzy5DQA4F2og1CFCptqBWXheNIS4U2Zj
         BKe4GSINJxExqDwikQcaw7iRgr8QD3en1PKXDOKngP2au1HUf9/zpKQKbRRkAhOk+UP8
         mLLGiMAsrc8dgSOvsvyvoYGjS8++T42uqrZyVoprsfpjlDj2fR5V1/BWZds63jvDrGIL
         BY8MMOEVUq9Ra3zrg4Ukb2LrVxE3Ww0i8PERr8I4GlWGl0AyKRNB0Y2NPfqK6mpjPE+f
         IK8btbhqjrdEjX0i7boV6gNXBNoQAQrBWisZseiQTUy5oWp/zteh9QfRPYhR42GztN8P
         wpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768359818; x=1768964618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4iWd9TygCS9lSZiyJguZ435vfrdxtAD9uaJeiXTYrE=;
        b=GYoquAX3yAAhuE4KhBIPN4QGhGdYuyYHvEzBmn0PxtpvmGphkL9HGUaGKcci69QvFe
         t43PVWZzy4dYHZGcR7TgzxInlzI5RHIMsVhJPOjMwYBBUjEcHTpch8Uj6pIDfNta9e7r
         spuUcodhjldsIj2I28ZZ3+UuUGCRW+NC3oAsyYDObCc+t9osw2D9fb3tlsdYelcWZsJ7
         MJCGhZBsVa9YMJsdoAng40fTb2BVHLyq1Clg1JCyFu7YqrzYTTKTUiQX0SPf7pYJ7Exp
         YfdTmF+9lMJlYoFwEuRGMYm7k+zXGw1IjJvNvWcruoWHddX/HisApZmh2V7XwC5O++pC
         MsUA==
X-Forwarded-Encrypted: i=1; AJvYcCVlclLU+wvIHQw3C/abIXS4LzYxMt9WqXvYWs+dDBYX4Z+F65ReJpBhLua3PzBt14a75dM4s0QX+5gPj5G0@vger.kernel.org
X-Gm-Message-State: AOJu0YxChJP/BG78uVnCIun3NckWg7DTrbNJxjI4d1Xl8+vBEdxhVa/m
	PJOT+gif1t/9u0ZkZUkwaKTayl2F8WmSCCgcOsfF+3Sjzl08ixkt/KbX
X-Gm-Gg: AY/fxX7/TnWO6wK+NI86x6wiuqi2FRipwZkJzSoM1BPfoqR1X9TTDItBmwfRvcmXEJ+
	ZlprjfGys2yPrNyFsIwkxcW9gipx0U3wJGLdMFmYmBklUl/BsuwSZgwvZubWmbqcWz5MG92XIRX
	nb6jy3pG3alR9eKcjQZw7HVAnl1/EJ0zOOFVTsKghv3CrqkaA4QD2V29ijok0rKd6G5Zec2FZI2
	bbC1ejv27ADSltzZnUlnPJr6QRY/MZz/r3nxUJE1gdW49J0CSz54W8dZ9erCLDUErY2gdR5kAY0
	zDVE8pe1IKpc4XONuHL3l+heMltuUOy6t7crNb3tg614PJRoBLuuSowJE0NqxB/tl0Vh6i6LHai
	hfAOz0DanAkQyg6LDSUJsP30EgYMW1Ezvs5QtKTmjimNqU4DIgE/xA08SACosE5jd9l5n588ZuA
	UH/PZuHV0ZtKk6jHryvRT7Ajyoi6s9l49UYZ4b
X-Received: by 2002:a05:6a21:9981:b0:35f:6e12:186f with SMTP id adf61e73a8af0-38bed10aba1mr1273079637.23.1768359817571;
        Tue, 13 Jan 2026 19:03:37 -0800 (PST)
Received: from localhost ([45.142.165.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f6cdsm20940729a12.6.2026.01.13.19.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:03:36 -0800 (PST)
Date: Wed, 14 Jan 2026 11:03:33 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com" <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Message-ID: <aWcHhTiUrDppotRg@ndev>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
 <20260113081952.2431735-1-wangjinchao600@gmail.com>
 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>

On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> > between the MDB buffer lock and the folio lock.
> > 
> > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > lock while calling sb_bread(), which attempts to acquire the lock
> > on the same folio.
> 
> I don't quite to follow to your logic. We have only one sb_bread() [1] in
> hfs_mdb_commit(). This read is trying to extract the volume bitmap. How is it
> possible that superblock and volume bitmap is located at the same folio? Are you
> sure? Which size of the folio do you imply here?
> 
> Also, it your logic is correct, then we never could be able to mount/unmount or
> run any operations on HFS volumes because of likewise deadlock. However, I can
> run xfstests on HFS volume.
> 
> [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324

Hi Viacheslav,

After reviewing your feedback, I realized that my previous RFC was not in
the correct format. It was not intended to be a final, merge-ready patch,
but rather a record of the analysis and trial fixes conducted so far.
I apologize for the confusion caused by my previous email.

The details are reorganized as follows:

- Observation
- Analysis
- Verification
- Conclusion

Observation
============

Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2

For this version:
| time             |  kernel    | Commit       | Syzkaller |
| 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |

Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000

The report indicates hung tasks within the hfs context.

Analysis
========
In the crash log, the lockdep information requires adjustment based on the call stack.
After adjustment, a deadlock is identified:

task syz.1.1902:8009
- held &disk->open_mutex
- held foio lock
- wait lock_buffer(bh)
Partial call trace:
->blkdev_writepages()
        ->writeback_iter()
                ->writeback_get_folio()
                        ->folio_lock(folio)
        ->block_write_full_folio()
                __block_write_full_folio()
                        ->lock_buffer(bh)

task syz.0.1904:8010
- held &type->s_umount_key#66 down_read
- held lock_buffer(HFS_SB(sb)->mdb_bh);
- wait folio
Partial call trace:
hfs_mdb_commit
        ->lock_buffer(HFS_SB(sb)->mdb_bh);
        ->bh = sb_bread(sb, block);
                ...->folio_lock(folio)


Other hung tasks are secondary effects of this deadlock. The issue
is reproducible in my local environment usuing the syz-reproducer.

Verification
==============

Two patches are verified against the syz-reproducer.
Neither reproduce the deadlock.

Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
------------------------------------------------------

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..c641adb94e6f 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
        if (sb_rdonly(sb))
                return;

-       lock_buffer(HFS_SB(sb)->mdb_bh);
        if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
                /* These parameters may have been modified, so write them back */
                mdb->drLsMod = hfs_mtime();
@@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
                        size -= len;
                }
        }
-       unlock_buffer(HFS_SB(sb)->mdb_bh);
 }


Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
--------------------------------------------------------

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..ec534c630c7e 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
                sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
        }
 
+       unlock_buffer(HFS_SB(sb)->mdb_bh);
        if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags)) {
                struct buffer_head *bh;
                sector_t block;
@@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
                        size -= len;
                }
        }
-       unlock_buffer(HFS_SB(sb)->mdb_bh);
 }

Conclusion
==========

The analysis and verification confirms that the hung tasks are caused by
the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(sb, block)`.


