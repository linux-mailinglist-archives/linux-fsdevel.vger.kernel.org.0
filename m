Return-Path: <linux-fsdevel+bounces-32453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13B9A5952
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 05:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E992821FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2985187FE4;
	Mon, 21 Oct 2024 03:50:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F514A90;
	Mon, 21 Oct 2024 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482612; cv=none; b=OyyTh5CTqtUTbPqO0WNgSfzCsbJe4tFtOHIm59MG9w6FTmbufZnqUFSxzznFQkOJU6HrcdEBluwznIi+gN49Sgd94uBmocLGbbqgrZQ5qI0D0VJEQ2N6GrxLXWblFblwCIcveJBbFuQMhllOdENiG0mS9YQ+oExBdJIfKvoIbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482612; c=relaxed/simple;
	bh=VBVq64KzIeORvBH6bdB4o5p4FZIgXwfweBCOqWHtGJ4=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cvnvquIzs8BeyMF3afQEq4zyVRBecX3GPpkWBCU96oLuarGTqqI9GN4IRagHPNhl2stebSigtK+QLWZbyvSyfIWLwx7cDk0Yx0+rFAVNSIrmh5W5mowgBxronOlzNq6V+q8VKu10lLEUa8S171FXRbbBIUIZyt0kj+mCYiTC0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XX1Xb5Q1Pz4f3jkv;
	Mon, 21 Oct 2024 11:49:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F345E1A092F;
	Mon, 21 Oct 2024 11:50:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBnm8dlzxVnYwe6Eg--.31108S2;
	Mon, 21 Oct 2024 11:50:00 +0800 (CST)
Subject: Re: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
To: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>,
 joannelkoong@gmail.com, josef@toxicpanda.com
References: <6715ae99.050a0220.10f4f4.003b.GAE@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: hdanton@sina.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com,
 syzkaller-bugs@googlegroups.com
Message-ID: <4901e9a6-f870-c30a-d910-732843d91a0f@huaweicloud.com>
Date: Mon, 21 Oct 2024 11:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6715ae99.050a0220.10f4f4.003b.GAE@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBnm8dlzxVnYwe6Eg--.31108S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrKF4xGF4UGF1UXr48Xrb_yoW5Jr17pr
	W8GrZrKrWUtry8JF17XFyjgryqqr98Z3yUXFyUWFy8u3W5Jr1q9r4IqrWjgr4UGr48Xr10
	qF15Ar1Fv3WkXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/21/2024 9:30 AM, syzbot wrote:
> syzbot has bisected this issue to:
>
> commit 5d9e1455630d0f464f169bbd637dbb264cbd8ac8
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Sep 30 13:45:18 2024 +0000
>
>     fuse: convert fuse_notify_store to use folios
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120dc25f980000
> start commit:   15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=110dc25f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=160dc25f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=65d101735df4bb19d2a3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623e830580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16582f27980000
>
> Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
> Fixes: 5d9e1455630d ("fuse: convert fuse_notify_store to use folios")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> .

It seems fuse_notify_store invokes folio_zero_range() incorrectly. The
third argument of folio_zero_range() should be the to-copy length
instead of the total length. The following patch will fix the problem:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5edad55750b0..87e39c9343c4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1668,7 +1668,7 @@ static int fuse_notify_store(struct fuse_conn *fc,
unsigned int size,
                err = fuse_copy_page(cs, &page, offset, this_num, 0);
                if (!folio_test_uptodate(folio) && !err && offset == 0 &&
                    (this_num == folio_size(folio) || file_size == end)) {
-                       folio_zero_range(folio, this_num,
folio_size(folio));
+                       folio_zero_range(folio, this_num,
folio_size(folio) - this_num);
                        folio_mark_uptodate(folio);
                }
                folio_unlock(folio);

Will post a formal patch later.



