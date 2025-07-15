Return-Path: <linux-fsdevel+bounces-54920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA09B0522B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32D31AA6070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193A26D4C3;
	Tue, 15 Jul 2025 06:51:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421226D4C1;
	Tue, 15 Jul 2025 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562312; cv=none; b=OUb2EpV8G9xBl4Ybmc9YoUFfcJ+9xIWaenlCSb3S/9p9ME0aunHqBiyjeCPXte7spebodC4AZ/hFdYCVqTJ9c9E0xWc37olpzIFSCdwIxOOrXpS8JX5jgTWLf/WsiA8hCxV72SiCxJqCo1TixCl+pi1z2CRDI5uvQzICTnzpVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562312; c=relaxed/simple;
	bh=HFzfum9lzdjuasUiRz6vBtdDoK+FzJtXZR93jq4ae3Y=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=DqYFdnuAffIWroJ0z+w5n+ntSLbmr6wUp8bvx7xabsxDQGYqJUlysnVoH2ZoWVffahqOyr2hl1r5TtuyW4mhR594l1sXNmj7M8OGXPG3ZYQRG7rcmHg6KECUX3dZD0vZVeZgo7kYa09XSTDG6qhhJg9njk86N2jDRalVg23yhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56F6pMKJ015674;
	Tue, 15 Jul 2025 15:51:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56F6pMmQ015671
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 15 Jul 2025 15:51:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
Date: Tue, 15 Jul 2025 15:51:21 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
Content-Language: en-US
Subject: [PATCH v2] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
In-Reply-To: <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

Since syzkaller can mount crafted filesystem images with inode->ino == 0
(which is not listed as "Some special File ID numbers" in fs/hfs/hfs.h ),
replace BUG() with pr_warn().

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..794d710c3ae0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		tree = HFS_SB(sb)->cat_tree;
 		break;
 	default:
-		BUG();
+		pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 		return false;
 	}
 
@@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	case HFS_CDR_FIL:
 		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
 	default:
-		BUG();
+		pr_warn("unexpected type %u at %s()\n", rec->type, __func__);
 		return 1;
 	}
 }
@@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
+			pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 			return -EIO;
 		}
 	}
-- 
2.50.1



