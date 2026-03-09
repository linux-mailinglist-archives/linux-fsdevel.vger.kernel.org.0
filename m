Return-Path: <linux-fsdevel+bounces-79879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCLZIPc0r2kPQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 22:00:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D400124141B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 22:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CDC3137601
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 20:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBE2367D1;
	Mon,  9 Mar 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brl1k4b2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D393ECBCE
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089798; cv=pass; b=rBotwcpd67+0zrI5oIj1H0l+PdRUYo3ABGMJAudPmwLpxo66iGNMZ6D3EjAkKVPg+TQMWG4Gfrp1N6mnW9zEHI6z7Qx58ZWHAbns3ykUWQ2lDODMlWRKh1hzoS01sWc/2pLtnlH/6hsakbljJqJL02Fy+fvr22BTwQLUYGuHwLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089798; c=relaxed/simple;
	bh=DpY1+5ZLFty2qUUwcxBedQ08mbz4NqnH9CJ5HbhDqSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS71kLjtKG2phmxOuvN7TiC3jPr3VyYsPSQXOc60zI8zAKcBS/vHKSh2H4XlJd4HLUYnk48dTiO4IrKap5sPbn9O1+ghr7uTJ4iMxsrZkyL8cL4mRAAXrV27QwJqKpXRkeDOMFRR34afcGwljgAEDwFzuScRI4JMs4OZliUYVw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brl1k4b2; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so8781745f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 13:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773089796; cv=none;
        d=google.com; s=arc-20240605;
        b=Y61UZ4Da+amwjq76bWqZ/tQcs9lWdABP1eNtnB56EPjPNjW2jBUkiePggTNyzpnG//
         I042PMsOlZSnubkBRDWInWICdEuVTCmcPLyqHFDkm3UEXuCD0+5K1dB/z4wPuvvCOjUk
         p1j4m2tlyPTKtT8dJX7qdO3e/yozx554hPWCwM+c7lj+hMnF+jCwW56K+5IHfzKQm5xB
         JDVh7IZfywjxKgpAlXnsLPMHB6EDRpFlKUelxCCX+mJiC9bdA/BGIZlmxRLoITal5DmM
         xOSENdCxKC93NMJMaGr53In1DfmJ+KAC9x+H21s3vhKZeqquy9GNK4cKEzq1+dNQUgLh
         Qlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJ/IW2/A11N7X/hXefg4Hp0XyobRCNWdnikI9Sb5Sx4=;
        fh=h/dfvY/M0fgQSU5sjMaOGS/FGT8IM9WVJs5hcX5Rb08=;
        b=Bmu5OEyk0ekOW4GOTtNKK25L27KwGQQobwj+lyyfwbQWvSB0uT0W1/Fjug3lUdeREK
         haiHHzZHd/K54ybQMHUzUHZpTG0Cj0kRR12TksY7AQxGIeS+YI6rV7zP6LBNa7niIJI0
         TN8EMxMpgUGypc4FQnRxwznFlKHKbNhN7cdO1oBOs+mmXBHYSepba6lYCEevWzWrOMLP
         inVP2mQ18IENbIZwnA+zXixH6TdWE8KF51rjowoocJtlC4Cs+rEbkXg5qT3WuzJOmcwb
         Onvl1ey//k6HFVFFCJpXYMM1YC2P04BNm+yfZtKtGo1Qv6j4q73Ho8HvPTAk3uXxhon2
         07rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773089796; x=1773694596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ/IW2/A11N7X/hXefg4Hp0XyobRCNWdnikI9Sb5Sx4=;
        b=brl1k4b2zAu+KuBREX8lya2Szl+8+htk5VO2RVis36cAtZiHmCkB52ebTe4wmyAuJn
         0XP5MahaejGUIl+CMgHU3uNSHIRYzbhPijdNqKLaqeh1+wybDHbHh+7+G209MH/AcefN
         LJ+cydnpMK76LH0UGKiF36I/6v/3GDpEtzlSmfC+wTFdAOb8SNyGuNec+7+8PnVDKddM
         JrJQpybbKaZcyPL79X6K4RnBxkfrKTTW9wfKsV04gaF2KhDNjEdMpPHhsjGRFSieQK/f
         ngIb4cZ/bApV6b53ECG3P4ex9277g/crXPEB3iVReT6i27Hz5q+Wiz4rTm2HQRbKoLxN
         gQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773089796; x=1773694596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJ/IW2/A11N7X/hXefg4Hp0XyobRCNWdnikI9Sb5Sx4=;
        b=ELvzCXorDcyhTyxKcVAoUMo4Uh6venqRfMYI+HFsze+Mqv5DJJ1ydYsAfqo4jg7F1P
         pybdTvNzU9fGxyiHu3SO09wVd7SKmPxzTsImr5KxcGvzWw3Ik52sK4Nyj5Qo5dFuQMAY
         X6nta0FRW3S4RFtY4jBPoMyeYoZ0Dk699sdZhZVy1rVPa6KGjsCuTOhwfmwG3p2jRc91
         TDFhYG/PXUvQoZSB6GM7lmqMQDfnXxs4A7uUMkJMVUE5EIBt3NjrwtqL4DtW3J6mfWKu
         qvCTimadaz1/+iOD9RLC4sMQUQFeZiRpPfWYgHM+41VENYrm39aGaTxsbgLcoqZaTpW6
         7wyQ==
X-Gm-Message-State: AOJu0YwDohuIQw+HGZSbZFmbZE8OBnnHM579vOMRhobMmY33sxSDiTJj
	zx0bG7Ju3LHPT3aDR/NsSEYJYPB83zE+UGyep+oiZrMpHFEkAbqRZY8AVF/FGLwTzECpL/3+qHT
	6gV0jOGL79J9OZKh82M+aiJrS0YHyd02Qvq9oWPs=
X-Gm-Gg: ATEYQzwyT81TO8vWYB3hRJtpNMK3+GwmaHlUwLQ81SnuljJL3DDfgSPxIJoTH0g9T2U
	iqR+w/YkPexjGeMcB1iY68C9pTDldjsPXiFgXb2JiXSnWvtc0dKoRtjPHfkPgjdTvDH8ILaaQ31
	Ig9yM3G/A1Ok0690HWYzSk2Pyvof7I+U3wLWYbYy9qQNpLScC71fX8WeFLC+g85EUTwfWBv9XOX
	kGaYi0DRP9roAjM3LbMknuTSmXB9M/UxnmNw06vR1BwVjmL7BW3H+7+51Ivwv7ntyYj/VcVsD8C
	XnCo+A==
X-Received: by 2002:a05:6000:1a87:b0:439:c157:256f with SMTP id
 ffacd0b85a97d-439da882138mr22222465f8f.33.1773089795303; Mon, 09 Mar 2026
 13:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
In-Reply-To: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Mar 2026 13:56:24 -0700
X-Gm-Features: AaiRm51aXVMFxKsJbR-LD3_2zLUFOipVvVtcthTE8DDfi3fO_HuzfXz46BmMPm8
Message-ID: <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D400124141B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79879-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:37=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> Hi Joanne,
>
> After commit aa35dd5cbc06 ("iomap: fix invalid folio access after
> folio_end_read()") my zoned btrfs test setup hangs. I've bisected it to
> this commit and reverting fixes my problem. The last thing I see in
> dmesg is:
>
> [    9.387175] ------------[ cut here ]------------
> [    9.387320] WARNING: fs/iomap/buffered-io.c:487 at
> iomap_read_end+0x11c/0x140, CPU#5: (udev-worker)/463
> [    9.387431] Modules linked in:
> [    9.387502] CPU: 5 UID: 0 PID: 463 Comm: (udev-worker) Not tainted
> 6.19.0-rc1+ #385 PREEMPT(full)
> [    9.387626] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.17.0-9.fc43 06/10/2025
> [    9.387810] RIP: 0010:iomap_read_end+0x11c/0x140
> [    9.387886] Code: 00 48 89 ef 48 3b 04 24 0f 94 04 24 44 0f b6 34 24
> e8 b8 88 69 00 48 89 df 48 83 c4 08 41 0f b6 f6 5b 5d 41 5e e9 54 e7 e8
> ff <0f> 0b e9 48 ff ff ff ba 00 10 00 00 eb 9d 0f 0b e9 53 ff ff ff 0f
> [    9.388096] RSP: 0018:ffffc90000e279c0 EFLAGS: 00010206
> [    9.388178] RAX: ffff888111c6b800 RBX: ffffea0004363900 RCX:
> 0000000000000000
> [    9.388281] RDX: 0000000000000000 RSI: 0000000000000400 RDI:
> ffffea0004363900
> [    9.388386] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000001
> [    9.388491] R10: ffffc90000e279a0 R11: ffff888111c6c168 R12:
> ffffffff81e5cdb0
> [    9.388585] R13: ffffc90000e27c58 R14: ffffea0004363900 R15:
> ffffc90000e27c58
> [    9.388690] FS:  00007f6e03fdfc00(0000) GS:ffff8882b4c13000(0000)
> knlGS:0000000000000000
> [    9.388793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.388873] CR2: 00007f6e03280000 CR3: 00000001106d7006 CR4:
> 0000000000770eb0
> [    9.388967] PKRU: 55555554
> [    9.389006] Call Trace:
> [    9.389044]  <TASK>
> [    9.389087]  iomap_readahead+0x23c/0x2e0
> [    9.389167]  blkdev_readahead+0x3d/0x50
> [    9.389222]  read_pages+0x56/0x200
> [    9.389277]  ? __folio_batch_add_and_move+0x1cf/0x2d0
> [    9.389354]  page_cache_ra_unbounded+0x1db/0x2c0
> [    9.389423]  force_page_cache_ra+0x96/0xb0
> [    9.389470]  filemap_get_pages+0x12f/0x490
> [    9.389532]  filemap_read+0xed/0x400
> [    9.389590]  ? lock_acquire+0xd5/0x2b0
> [    9.389633]  ? blkdev_read_iter+0x6b/0x180
> [    9.389678]  ? lock_acquire+0xe5/0x2b0
> [    9.389720]  ? lock_is_held_type+0xcd/0x130
> [    9.389761]  ? find_held_lock+0x2b/0x80
> [    9.389813]  ? lock_acquired+0x1e9/0x3c0
> [    9.389864]  blkdev_read_iter+0x79/0x180
> [    9.389911]  ? local_clock_noinstr+0x17/0x110
> [    9.389975]  vfs_read+0x240/0x340
> [    9.390033]  ksys_read+0x61/0xd0
> [    9.390083]  do_syscall_64+0x74/0x3a0
> [    9.390143]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    9.390204] RIP: 0033:0x7f6e048c5c5e
> [    9.390255] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03
> 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f
> 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
> [    9.390447] RSP: 002b:00007ffdf50cded0 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000000
> [    9.390529] RAX: ffffffffffffffda RBX: 000000013aa55200 RCX:
> 00007f6e048c5c5e
> [    9.390619] RDX: 0000000000000200 RSI: 00007f6e0327f000 RDI:
> 0000000000000014
> [    9.390704] RBP: 00007ffdf50cdee0 R08: 0000000000000000 R09:
> 0000000000000000
> [    9.390789] R10: 0000000000000000 R11: 0000000000000202 R12:
> 0000000000000000
> [    9.390866] R13: 000055d5f99fa270 R14: 000055d5f96e5cb0 R15:
> 000055d5f96e5cc8
> [    9.390967]  </TASK>
> [    9.390997] irq event stamp: 54269
> [    9.391044] hardirqs last  enabled at (54279): [<ffffffff8138ac02>]
> __up_console_sem+0x52/0x60
> [    9.391141] hardirqs last disabled at (54288): [<ffffffff8138abe7>]
> __up_console_sem+0x37/0x60
> [    9.391240] softirqs last  enabled at (53796): [<ffffffff81304768>]
> irq_exit_rcu+0x78/0x110
> [    9.391327] softirqs last disabled at (53787): [<ffffffff81304768>]
> irq_exit_rcu+0x78/0x110
> [    9.391420] ---[ end trace 0000000000000000 ]---
>
> I haven't debugged this further yet, maybe you have an idea what
> could've caused it. On my side it's trivial to reproduce, so if you
> can't reproduce it just yell.

Hi Johannes,

Thanks for your report and for bisecting this.

A few questions:
1.  From the stack trace it looks like this is happening during a
block device read triggered by udev-worker's device probing. Does this
trigger for you consistently when the zoned device is probed or only
when running the btrfs xfstests generic/648?

2.  I tried to repro your setup by running:
sudo modprobe null_blk nr_devices=3D2 zoned=3D1 zone_size=3D256
zone_nr_conv=3D8 memory_backed=3D1
sudo mkdir -p /mnt/test && sudo mkdir -p /mnt/scratch
sudo mkfs.btrfs -f /dev/nullb0
sudo mount /dev/nullb0 /mnt/test
sudo ./check generic/648

with local.config set to:
TEST_DEV=3D/dev/nullb0
TEST_DIR=3D/mnt/test
SCRATCH_DEV=3D/dev/nullb1
SCRATCH_MNT=3D/mnt/scratch
export FSTYP=3Dbtrfs

but I=E2=80=99m not seeing the hang or the WARNING in dmesg show up.  I am
running it with PREEMPT(full) enabled. Does this match your setup or
are you doing something differently? Are you using null_blk or an
actual zoned device? If you are using null_blk, what module parameters
are you using?

3. If you're able to repro this consistently, would you be able to add
these lines right above the WARN_ON on line 487 and sharing what it
prints out?

+++ b/fs/iomap/buffered-io.c
@@ -484,6 +484,17 @@ static void iomap_read_end(struct folio *folio,
size_t bytes_submitted)
                 * to the IO helper, in which case we are responsible for
                 * unlocking the folio here.
                 */
+               if (bytes_submitted) {
+                       struct inode *inode =3D folio->mapping->host;
+                       struct block_device *bdev =3D inode->i_sb->s_bdev;
+
+                       pr_warn("bytes_submitted=3D%zu folio_size=3D%zu
blkbits=3D%u isize=3D%lld "
+                               "logical_bs=3D%u physical_bs=3D%u\n",
+                               bytes_submitted, folio_size(folio),
inode->i_blkbits,
+                               i_size_read(inode),
+                               bdev ? bdev_logical_block_size(bdev) : 0,
+                               bdev ? bdev_physical_block_size(bdev) : 0);
+               }
                WARN_ON_ONCE(bytes_submitted);
                folio_unlock(folio);
        }

Thanks,
Joanne
>
> Byte,
>
>      Johannes
>

