Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A3F000A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfKEOje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 09:39:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKEOje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:39:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id i10so962768wrs.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XipGVcDA90hw/DWzrmMfx0UZTBR7b8DWoTarwfXUJmE=;
        b=GIM3tUC0FnaTG6iz/8p26wdFtCrV6x4dXecgGh0TUDV+vDDvNKicu8WFtnit4ffzo6
         9Ig4wA/Z8NmbBmk+s7i+WaNiaZTNeV/pgDfczNQGd+CKMCGEOv7KFTrFRoFk3EoJn0JM
         t12U6QX53ZO/N59oUssJCsqQXgCod6KKgc19qVgPqwQ81uUxkXklYHgLJQwsMOj6sXih
         H9I5aCeZu7V5ioKhz01m9wo0dpnq4W3DMwekF2aMBiMDXz/BxJq0c3FjiuB9IB+ZcLol
         7hWglPNJlkDtdyHoiTjY3RYgKoY7Pzx9VbOI39YpY3SiPDtNkVK3g3fpNVHk82SKaeI7
         a6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XipGVcDA90hw/DWzrmMfx0UZTBR7b8DWoTarwfXUJmE=;
        b=aS/fWTjOez3YhTNAQSWhLtN8Qe5s6q6d31VgfvUP+bGB4/ikRznj1U4Y6TznCRLOiU
         KYnLd+HvTrv8B/3wBMDnh9G/4KGjTzcMQToQvPHiBjYDKR7atTRKUem6WOgLGG4KGr99
         modltrKs1i/9Ty715hudjewYlBf2YIMOPKX2ZdI+oU4AuERbveyazP1hbATT3pHWvPgC
         ZZ/0HdsAPrUb5oiOJctcocMEva4Rmlr6MvO8ypEvd6IoBu4yu2NV2RqY9QPap0xFMea+
         V/5akmZCGcvqHGwxqza0k3LuWlSm35b24Pf+fA/p2tiKXjqF7kU4IF/cQ2VFOWWv/EOo
         hk1g==
X-Gm-Message-State: APjAAAWEb7ByNv1IkCvF95gjeNuS4LzOuAwl6Cb3M034Zy0CU/WTqO0j
        Au5BydTbTNNTsoZ3uYDQpsS8e8S1VhKVN1E6
X-Google-Smtp-Source: APXvYqwix/HQ5vCvRVyWuSmESnFcnuNYdDTlWuVqQ3XpKaz29vL8vJw35phuNnVM9YkcaFubHpG4jQ==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr19584411wrq.381.1572964770566;
        Tue, 05 Nov 2019 06:39:30 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id b1sm13836968wrw.77.2019.11.05.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 06:39:29 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:39:23 +0100
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: KCSAN: data-race in fat16_ent_put / fat_search_long
Message-ID: <20191105143923.GA87727@google.com>
References: <00000000000016a19d0596980568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000016a19d0596980568@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 05 Nov 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ccaac8e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=11010f0000e50c63c2cc
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in fat16_ent_put / fat_search_long
> 
> write to 0xffff8880a209c96a of 2 bytes by task 11985 on cpu 0:
>  fat16_ent_put+0x5b/0x90 fs/fat/fatent.c:181
>  fat_ent_write+0x6d/0xf0 fs/fat/fatent.c:415
>  fat_chain_add+0x34e/0x400 fs/fat/misc.c:130
>  fat_add_cluster+0x92/0xd0 fs/fat/inode.c:112
>  __fat_get_block fs/fat/inode.c:154 [inline]
>  fat_get_block+0x3ae/0x4e0 fs/fat/inode.c:189
>  __block_write_begin_int+0x2ea/0xf20 fs/buffer.c:1968
>  __block_write_begin fs/buffer.c:2018 [inline]
>  block_write_begin+0x77/0x160 fs/buffer.c:2077
>  cont_write_begin+0x3d6/0x670 fs/buffer.c:2426
>  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
>  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
>  cont_expand_zero fs/buffer.c:2353 [inline]
>  cont_write_begin+0x17a/0x670 fs/buffer.c:2416
>  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
>  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
>  generic_cont_expand_simple+0xb0/0x120 fs/buffer.c:2317
> 
> read to 0xffff8880a209c96b of 1 bytes by task 11990 on cpu 1:
>  fat_search_long+0x20a/0xc60 fs/fat/dir.c:484
>  vfat_find+0xc1/0xd0 fs/fat/namei_vfat.c:698
>  vfat_lookup+0x75/0x350 fs/fat/namei_vfat.c:712
>  lookup_open fs/namei.c:3203 [inline]
>  do_last fs/namei.c:3314 [inline]
>  path_openat+0x15b6/0x36e0 fs/namei.c:3525
>  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
>  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
>  __do_sys_open fs/open.c:1115 [inline]
>  __se_sys_open fs/open.c:1110 [inline]
>  __x64_sys_open+0x55/0x70 fs/open.c:1110
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ==================================================================

I was trying to understand what is happening here, but fail to see how
this can happen. So it'd be good if somebody who knows this code can
explain. We are quite positive this is not a false positive, given the
addresses accessed match.

The two bits of code in question here are:

static void fat16_ent_put(struct fat_entry *fatent, int new)
{
	if (new == FAT_ENT_EOF)
		new = EOF_FAT16;

	*fatent->u.ent16_p = cpu_to_le16(new);   <<== data race here
	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
}

int fat_search_long(struct inode *inode, const unsigned char *name,
		    int name_len, struct fat_slot_info *sinfo)
{
	struct super_block *sb = inode->i_sb;
	struct msdos_sb_info *sbi = MSDOS_SB(sb);
	struct buffer_head *bh = NULL;
	struct msdos_dir_entry *de;
	unsigned char nr_slots;
	wchar_t *unicode = NULL;
	unsigned char bufname[FAT_MAX_SHORT_SIZE];
	loff_t cpos = 0;
	int err, len;

	err = -ENOENT;
	while (1) {
		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
			goto end_of_dir;
parse_record:
		nr_slots = 0;
		if (de->name[0] == DELETED_FLAG)
			continue;
		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))  <<== data race here
			continue;
		if (de->attr != ATTR_EXT && IS_FREE(de->name))
			continue;
		<snip>
}

Thanks,
-- Marco
