Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B912F0CC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 07:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAKGPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 01:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKGPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 01:15:08 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719CC061786
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jan 2021 22:14:28 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y13so9275641ilm.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jan 2021 22:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T5hbpvO6kC7jbpYLUp5H7SZ2AaZgu4Bm4w/83lViui0=;
        b=lDYHAlRz1nrQdbARpYdib8A625NMRkZoUpU5bvc88+6qRULb4ArGIwXJ++4Zq/FDo7
         o3DILPFgKJAMttMCzVXlhInh89O7xUZrInhVAJC3PhXwHBFpjAlgGm9bML9ptFUclqeV
         fdPIPXubIZrVWoHbVf1h3AhE7K0gJqELEfKsMB5N9ErYED9FpIJja6CjeJXmZYdDqZcx
         LJUQyYUT0FQImm3sLP1e6aRmjOaLjpA94LP5HdJGzIHHQG1CepY3zjp/UdF7nBfWMA5G
         eA+63vJQM96gthvehrHNcO/tQ/mVDR8MrsvtC8dX+iDUYWblck7jrwFJ+t4oHtGZviMm
         2TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T5hbpvO6kC7jbpYLUp5H7SZ2AaZgu4Bm4w/83lViui0=;
        b=YSempD0+YWTbhyd9mspPyrGI1C6fM6RLVPBNaeFNP0il9NLnH5hz30vYuDY8TLBw7D
         CzooBZRPysg3vZlokX/bPgtllY9U0/3ykd3JM6DTkroZ5UccfujGDKcVxUd3NlSv5OXR
         jCf5bSfYvKHTx9Pgr10HzqZ2vLzNZT+qUYysoZ5b7cHCY7cc9aXzOJUnjAlpwjtTCdVw
         pDJQiWsqClC2Zr7g1UV0d7nMzaEn+0osjhhyEsvbTbVMwzIhBeRgT6cGQ2nI7F/0YeZ9
         +Lk1QEwVt8NGGJmZmidNY0+/Yy9bAlDccumsgohJ6OwTd+2EkSy8Z9pxJG482eQYSqnJ
         ilzA==
X-Gm-Message-State: AOAM5336xNOZoYRzVqZXWb+0trrepSouIyXMVFnecvlUgdLKgZkHGJBC
        Z6k7klvDwhsozYidvM59RY3Bsq4UoKNqlqJcXQ4CXLmOItY=
X-Google-Smtp-Source: ABdhPJxdIP5x6y3NIDLahsC0S2OAiZps0t+suAps2he2NOK6UgEG0H8/j+ZAeIILCTOxwhdqQbJBzk7jXDVDbb95How=
X-Received: by 2002:a92:60b:: with SMTP id x11mr14533733ilg.11.1610345667827;
 Sun, 10 Jan 2021 22:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20210111043541.11622-1-liuzhengyuan@tj.kylinos.cn>
In-Reply-To: <20210111043541.11622-1-liuzhengyuan@tj.kylinos.cn>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Mon, 11 Jan 2021 14:14:16 +0800
Message-ID: <CAOOPZo43hUpEeJxHkk_kL14E-9mP=v_+cdUo5wD6OqUFRBw=8g@mail.gmail.com>
Subject: Re: [PATCH] fs/quota: fix the mismatch of data type
To:     Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:35 PM Zhengyuan Liu
<liuzhengyuan@tj.kylinos.cn> wrote:
>
> From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
>
> When doing fuzzing test to quota, an error occurred due to the
> mismatch of data type:
>
>     Quota error (device loop0): qtree_write_dquot: Error -1244987383 occu=
rred while creating quota
>     Unable to handle kernel paging request at virtual address ffffffffb5c=
b0071
>     Mem abort info:
>       ESR =3D 0x96000006
>       EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>       SET =3D 0, FnV =3D 0
>       EA =3D 0, S1PTW =3D 0
>     Data abort info:
>       ISV =3D 0, ISS =3D 0x00000006
>       CM =3D 0, WnR =3D 0
>     swapper pgtable: 64k pages, 48-bit VAs, pgdp=3D0000000023980000
>     [ffffffffb5cb0071] pgd=3D00000000243f0003, p4d=3D00000000243f0003, pu=
d=3D00000000243f0003, pmd=3D0000000000000000
>     Internal error: Oops: 96000006 [#1] SMP
>     Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft=
_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nftn
>     CPU: 1 PID: 1256 Comm: a.out Not tainted 5.10.0 #31
>     Hardware name: XXXX XXXX/Kunpeng Desktop Board D920L11K, BIOS 0.23 07=
/22/2020
>     pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
>     pc : dquot_add_space+0x30/0x258
>     lr : __dquot_alloc_space+0x22c/0x358
>     sp : ffff80001c10f660
>     x29: ffff80001c10f660 x28: 0000000000000001
>     x27: 0000000000000000 x26: 0000000000000000
>     x25: ffff800011add9c8 x24: ffff0020a2110470
>     x23: 0000000000000400 x22: 0000000000000400
>     x21: 0000000000000000 x20: 0000000000000400
>     x19: ffffffffb5cb0009 x18: 0000000000000000
>     x17: 0000000000000020 x16: 0000000000000000
>     x15: 0000000000000010 x14: 65727471203a2930
>     x13: 706f6f6c20656369 x12: 0000000000000020
>     x11: 000000000000000a x10: 0000000000000400
>     x9 : ffff8000103afb5c x8 : 0000000800000000
>     x7 : 0000000000002000 x6 : 000000000000000f
>     x5 : ffffffffb5cb0009 x4 : ffff80001c10f728
>     x3 : 0000000000000001 x2 : 0000000000000000
>     x1 : 0000000000000400 x0 : ffffffffb5cb0009
>     Call trace:
>      dquot_add_space+0x30/0x258
>      __dquot_alloc_space+0x22c/0x358
>      ext4_mb_new_blocks+0x100/0xe88
>      ext4_new_meta_blocks+0xb4/0x110
>      ext4_xattr_block_set+0x4ec/0xce8
>      ext4_xattr_set_handle+0x400/0x528
>      ext4_xattr_set+0xc4/0x170
>      ext4_xattr_security_set+0x30/0x40
>      __vfs_setxattr+0x7c/0xa0
>      __vfs_setxattr_noperm+0x88/0x218
>      __vfs_setxattr_locked+0xf8/0x120
>      vfs_setxattr+0x6c/0x100
>      setxattr+0x148/0x240
>      path_setxattr+0xc4/0xd8
>      __arm64_sys_setxattr+0x2c/0x40
>      el0_svc_common.constprop.4+0x94/0x178
>      do_el0_svc+0x78/0x98
>      el0_svc+0x20/0x30
>      el0_sync_handler+0x90/0xb8
>      el0_sync+0x158/0x180
>
> In this test case, the return value from get_free_dqblk() could be
> info->dqi_free_blk, which is defined as unsigned int, but we use
> type int in do_insert_tree to check the return value, and therefor we
> may get a negative duo to the transformation. This negative(as aboved
> said -1244987383) then can transmit to dquots in __dquot_initialize(),
> and once we access there can trigger above panic.
>
>         __dquot_initialize():
>                 dquot =3D dqget(sb, qid);
>                 if (IS_ERR(dquot)) {
>                         /* We raced with somebody turning quotas off... *=
/
>                         if (PTR_ERR(dquot) !=3D -ESRCH) {
>                                 ret =3D PTR_ERR(dquot);
>                                 goto out_put;
>                         }
>                         dquot =3D NULL;
>                 }
>                 got[cnt] =3D dquot;
>
> Try to fix this problem by making the data type consistent.
>
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
> ---
>  fs/quota/quota_tree.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index c5562c871c8b..f898a550a3ee 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -81,11 +81,11 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *inf=
o, uint blk, char *buf)
>  }
>
>  /* Remove empty block from list and return it */
> -static int get_free_dqblk(struct qtree_mem_dqinfo *info)
> +static ssize_t get_free_dqblk(struct qtree_mem_dqinfo *info)
>  {
>         char *buf =3D getdqbuf(info->dqi_usable_bs);
>         struct qt_disk_dqdbheader *dh =3D (struct qt_disk_dqdbheader *)bu=
f;
> -       int ret, blk;
> +       ssize_t ret, blk;
>
>         if (!buf)
>                 return -ENOMEM;
> @@ -295,11 +295,12 @@ static uint find_free_dqentry(struct qtree_mem_dqin=
fo *info,
>  }
>
>  /* Insert reference to structure into the trie */
> -static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *d=
quot,
> +static ssize_t do_insert_tree(struct qtree_mem_dqinfo *info, struct dquo=
t *dquot,
>                           uint *treeblk, int depth)
>  {
>         char *buf =3D getdqbuf(info->dqi_usable_bs);
> -       int ret =3D 0, newson =3D 0, newact =3D 0;
> +       int newson =3D 0, newact =3D 0;
> +       ssize_t ret =3D 0;
>         __le32 *ref;
>         uint newblk;
>
> @@ -335,7 +336,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *in=
fo, struct dquot *dquot,
>                         goto out_buf;
>                 }
>  #endif
> -               newblk =3D find_free_dqentry(info, dquot, &ret);
> +               newblk =3D find_free_dqentry(info, dquot, (int*)&ret);
>         } else {
>                 ret =3D do_insert_tree(info, dquot, &newblk, depth+1);
>         }
> @@ -352,7 +353,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *in=
fo, struct dquot *dquot,
>  }
>
>  /* Wrapper for inserting quota structure into tree */
> -static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
> +static inline ssize_t dq_insert_tree(struct qtree_mem_dqinfo *info,
>                                  struct dquot *dquot)
>  {
>         int tmp =3D QT_TREEOFF;
> --
> 2.20.1
>
>
>
The fuzzing test program showed as following:

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <linux/loop.h>

static unsigned long long procid;

struct fs_image_segment {
        void* data;
        uintptr_t size;
        uintptr_t offset;
};

#define IMAGE_MAX_SEGMENTS 4096
#define IMAGE_MAX_SIZE (129 << 20)

#define sys_memfd_create 319

static unsigned long fs_image_segment_check(unsigned long size,
unsigned long nsegs, struct fs_image_segment* segs)
{
        if (nsegs > IMAGE_MAX_SEGMENTS)
                nsegs =3D IMAGE_MAX_SEGMENTS;
        for (size_t i =3D 0; i < nsegs; i++) {
                if (segs[i].size > IMAGE_MAX_SIZE)
                        segs[i].size =3D IMAGE_MAX_SIZE;
                segs[i].offset %=3D IMAGE_MAX_SIZE;
                if (segs[i].offset > IMAGE_MAX_SIZE - segs[i].size)
                        segs[i].offset =3D IMAGE_MAX_SIZE - segs[i].size;
                if (size < segs[i].offset + segs[i].offset)
                        size =3D segs[i].offset + segs[i].offset;
        }
        if (size > IMAGE_MAX_SIZE)
                size =3D IMAGE_MAX_SIZE;
        return size;
}
static int setup_loop_device(long unsigned size, long unsigned nsegs,
struct fs_image_segment* segs, const char* loopname, int* memfd_p,
int* loopfd_p)
{
        int err =3D 0, loopfd =3D -1;
        size =3D fs_image_segment_check(size, nsegs, segs);
        int memfd =3D syscall(sys_memfd_create, "syzkaller", 0);
        if (memfd =3D=3D -1) {
                err =3D errno;
                goto error;
        }
        if (ftruncate(memfd, size)) {
                err =3D errno;
                goto error_close_memfd;
        }
        for (size_t i =3D 0; i < nsegs; i++) {
                if (pwrite(memfd, segs[i].data, segs[i].size,
segs[i].offset) < 0) {
                }
        }
        loopfd =3D open(loopname, O_RDWR);
        if (loopfd =3D=3D -1) {
                err =3D errno;
                goto error_close_memfd;
        }
        if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
                if (errno !=3D EBUSY) {
                        err =3D errno;
                        goto error_close_loop;
                }
                ioctl(loopfd, LOOP_CLR_FD, 0);
                usleep(1000);
                if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
                        err =3D errno;
                        goto error_close_loop;
                }
        }
        *memfd_p =3D memfd;
        *loopfd_p =3D loopfd;
        return 0;

error_close_loop:
        close(loopfd);
error_close_memfd:
        close(memfd);
error:
        errno =3D err;
        return -1;
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
volatile unsigned long size, volatile unsigned long nsegs, volatile
long segments, volatile long flags, volatile long optsarg)
{
        struct fs_image_segment* segs =3D (struct fs_image_segment*)segment=
s;
        int res =3D -1, err =3D 0, loopfd =3D -1, memfd =3D -1,
need_loop_device =3D !!segs;
        char* mount_opts =3D (char*)optsarg;
        char* target =3D (char*)dir;
        char* fs =3D (char*)fsarg;
        char* source =3D NULL;
        char loopname[64];
        if (need_loop_device) {
                memset(loopname, 0, sizeof(loopname));
                snprintf(loopname, sizeof(loopname), "/dev/loop%llu", proci=
d);
                if (setup_loop_device(size, nsegs, segs, loopname,
&memfd, &loopfd) =3D=3D -1)
                        return -1;
                source =3D loopname;
        }
        mkdir(target, 0777);
        char opts[256];
        memset(opts, 0, sizeof(opts));
        if (strlen(mount_opts) > (sizeof(opts) - 32)) {
        }
        strncpy(opts, mount_opts, sizeof(opts) - 32);
        if (strcmp(fs, "iso9660") =3D=3D 0) {
                flags |=3D MS_RDONLY;
        } else if (strncmp(fs, "ext", 3) =3D=3D 0) {
                if (strstr(opts, "errors=3Dpanic") || strstr(opts,
"errors=3Dremount-ro") =3D=3D 0)
                        strcat(opts, ",errors=3Dcontinue");
        } else if (strcmp(fs, "xfs") =3D=3D 0) {
                strcat(opts, ",nouuid");
        }
        res =3D mount(source, target, fs, flags, opts);
        if (res =3D=3D -1) {
                err =3D errno;
                goto error_clear_loop;
        }
        res =3D open(target, O_RDONLY | O_DIRECTORY);
        if (res =3D=3D -1) {
                err =3D errno;
        }

error_clear_loop:
        if (need_loop_device) {
                ioctl(loopfd, LOOP_CLR_FD, 0);
                close(loopfd);
                close(memfd);
        }
        errno =3D err;
        return res;
}

int main(void)
{
         syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
        syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul)=
;
        syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);

memcpy((void*)0x20000000, "ext4\000", 5);
memcpy((void*)0x20000100, "./file0\000", 8);
*(uint64_t*)0x20000200 =3D 0x20010000;
memcpy((void*)0x20010000,
"\x20\x00\x00\x00\x00\x01\x00\x00\x0c\x00\x00\x00\xce\x00\x00\x00\x0f\x00\x=
00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\=
x20\x00\x00\x20\x00\x00\x00\xd2\xf4\x65\x5f\xd2\xf4\x65\x5f\x01\x00\xff\xff=
\x53\xef\x01\x00\x01\x00\x00\x00\xd1\xf4\x65\x5f\x00\x00\x00\x00\x00\x00\x0=
0\x00\x01\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x00\x00\x80\x00\x00\x00\x08\x=
00\x00\x00\x52\x47\x00\x00\x62\x01",
102);
*(uint64_t*)0x20000208 =3D 0x66;
*(uint64_t*)0x20000210 =3D 0x400;
*(uint64_t*)0x20000218 =3D 0x20010200;
memcpy((void*)0x20010200, "\x01\x00\x00\x00\x00\x00\x05\x00\x11", 9);
*(uint64_t*)0x20000220 =3D 9;
*(uint64_t*)0x20000228 =3D 0x560;
*(uint64_t*)0x20000230 =3D 0x20010300;
memcpy((void*)0x20010300, "\x03", 1);
*(uint64_t*)0x20000238 =3D 1;
*(uint64_t*)0x20000240 =3D 0x640;
*(uint64_t*)0x20000248 =3D 0x20010400;
memcpy((void*)0x20010400,
"\x03\x00\x00\x00\x13\x00\x00\x00\x23\x00\x00\x00\xce", 13);
*(uint64_t*)0x20000250 =3D 0xd;
*(uint64_t*)0x20000258 =3D 0x800;
*(uint64_t*)0x20000260 =3D 0;
*(uint64_t*)0x20000268 =3D 0;
*(uint64_t*)0x20000270 =3D 0xc00;
*(uint64_t*)0x20000278 =3D 0x20011600;
memcpy((void*)0x20011600, "\x50\x4d\x4d\x00\x50\x4d\x4d\xff", 8);
*(uint64_t*)0x20000280 =3D 8;
*(uint64_t*)0x20000288 =3D 0x4400;
*(uint64_t*)0x20000290 =3D 0x20000040;
memcpy((void*)0x20000040,
"\x11\x1f\xc0\xd9\x01\x00\x00\x00\x3a\x68\xc0\xa7\x79\x5f\xd6\x68\xd3\x22\x=
a7\xe4\x75\x56\x83\xe4\x09\x00\xcb\xb5\x8f\x17\xc7\x37\x03\x00\x00\x00",
36);
*(uint64_t*)0x20000298 =3D 0x24;
*(uint64_t*)0x200002a0 =3D 0x4800;
*(uint64_t*)0x200002a8 =3D 0x20012b00;
memcpy((void*)0x20012b00,
"\xed\x41\x00\x00\x00\x04\x00\x00\xd1\xf4\x65\x5f\xd2\xf4\x65\x5f\xd2\xf4\x=
65\x5f\x00\x00\x00\x00\x00\x00\x04\x00\x02",
29);
*(uint64_t*)0x200002b0 =3D 0x1d;
*(uint64_t*)0x200002b8 =3D 0x8c80;
*(uint64_t*)0x200002c0 =3D 0x20012c00;
memcpy((void*)0x20012c00,
"\x80\x81\x00\x00\x00\x18\x00\x00\xd1\xf4\x65\x5f\xd1\xf4\x65\x5f\xd1\xf4\x=
65\x5f\x00\x00\x00\x00\x00\x00\x01\x00\x0c\x00\x00\x00\x10\x00\x08\x00\x00\=
x00\x00\x00\x0a\xf3\x03\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x01\x00\x00\x00\x12\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x18\x00\x0=
0\x00\x02\x00\x00\x00\x04\x00\x00\x00\x14",
85);
*(uint64_t*)0x200002c8 =3D 0x55;
*(uint64_t*)0x200002d0 =3D 0x8d00;
*(uint8_t*)0x20013800 =3D 0;
syz_mount_image(0x20000000, 0x20000100, 0x40000, 9, 0x20000200, 0, 0x200138=
00);
memcpy((void*)0x20000b00, "./file0\000", 8);
memcpy((void*)0x20000b40, "security.ima\000", 13);
        syscall(__NR_setxattr, 0x20000b00ul, 0x20000b40ul,
0x20000b80ul, 0xeul, 0ul);
        return 0;
}
