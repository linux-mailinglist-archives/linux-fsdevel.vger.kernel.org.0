Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBA4A2FCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiA2N2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346162AbiA2N23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:28:29 -0500
Received: from mail-out-3.itc.rwth-aachen.de (mail-out-3.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEABC061714;
        Sat, 29 Jan 2022 05:28:28 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2AOAAAqQPVh/6QagoZaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFGBQEBAQELAYMlWGoMhD2II4hwA4VMi26LGIF8CwEBAQEBA?=
 =?us-ascii?q?QEBAQgBNQoCBAEBhQUCg2ACJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEBBQSBHIUvOQ2GQgEBAQECASMPATsLEAsRAwECAQICJgICEAQzCA4KBAWDB?=
 =?us-ascii?q?YJ1IQQLrSx6gTGBAYNOAYUHgSEGCQGBBioBhyuHLoIpgRWDKj6CYwKEeIJlB?=
 =?us-ascii?q?JIrBgGBDhwQIA+BKwSSeoMnAUaneYIoB4IQVGWLAZFDg12WIAKRVJZKjQ+ZM?=
 =?us-ascii?q?wIEAgQFAhaBYYIVMz5PgjUBMxM+FwIPjiwWg0+FFIVLQTICNgIGAQoBAQMJg?=
 =?us-ascii?q?jqDCiYThj8BgQ8BAQ?=
IronPort-Data: A9a23:w9Fko64VwbAT5N5upQgjzwxRtO3GchMFZxGqfqrLsTDasY5as4F+v
 jQaDTiCOv/ZMWv1eNpyb421oRhVvZfTn95lTgdv/yw0Zn8b8sCt6fZ1j6vTF37IcpeTHBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFx2XqPp8Zj2tQy2YHjUlvU0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOkKmVgJdNWc
 s6YpF2P1j6Do019WovNfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplsp+yZQp3B6n2iP0yCBdAMnlHI6Rc5+qSSZS/mZT7I0zuaWTww/h+SVpqeIRe4PlrASRH+
 boUJVjhbDja3L7wmenjDLMywJ19cKEHP6tG0p1k5TTQAvA7WtbMWaLR/vdCwysww8lHFvbTY
 YwVZFKDaTyZP0wQYA1IVMlWcOGAqEC8YxN2uVivgfAOvGLv3ChXz5XSGY+AEjCNbYAP9qqCn
 UrF8mniCRYdN/SUySCC93Oxg6nIhyyTcIsRDLiQ8v9snU3WyGsODhEfSVq8p7++kEHWc9tTL
 EYO+zsnq4A98UWqSp/2WBjQiGCFpBk0SddWEvN87ACL17qS5ByWQHUHJhZMYt0ruMIsQBQ60
 16ShNLuA3pkt7j9YXac8KqE6D2pNSULIGsqeyAJV00G7sPlrYV1iQjAJv5nEaionpjwHBnz3
 TmBr245nbp7pcoK0biruFDOmT6hoJnPQSYr6QjNGGGo9AV0YMiifYPA1LTAxexfMIaUXhya4
 D0N3dKB8OBLBJ3LmCHlrPgxIYxFLs2taFX06WOD1bF4n9hx0xZPpbxt3Qw=
IronPort-HdrOrdr: A9a23:+PWSU6s74xGnDaIUa3POFx4W7skDWdV00zEX/kB9WHVpmgXxrb
 HWoB19726TtN9xYgBFpTnkAsO9qBznhORICOUqTNWftWrdyQyVxeNZnOjfKlTbckWUltK1s5
 0QDpSWYOeQMbEQt7eD3ODXKada/DBFysyVbCXlokuECWxRGsRdBstCZTpz23cZeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,326,1635199200"; 
   d="scan'208";a="149722743"
Received: from rwthex-s4-a.rwth-ad.de ([134.130.26.164])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 29 Jan 2022 14:28:27 +0100
Received: from localhost (92.201.204.180) by rwthex-s4-a.rwth-ad.de
 (2a00:8a60:1:e500::26:164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 29 Jan
 2022 14:28:26 +0100
Date:   Sat, 29 Jan 2022 14:28:26 +0100
From:   Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>
To:     Kees Cook <keescook@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <YfVA+jfyW9c8UC7J@bogen>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202201281347.F36AEA5B61@keescook>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Originating-IP: [92.201.204.180]
X-ClientProxiedBy: rwthex-s1-b.rwth-ad.de (2a00:8a60:1:e500::26:153) To
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:30:12PM -0800 Kees Cook wrote:
> On Fri, Jan 28, 2022 at 09:26:09AM +0100, Magnus Groß wrote:
> > On Wed, Jan 26, 2022 at 10:31:42PM -0800 Kees Cook wrote:
> > > On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > > > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groß wrote:
> > > > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > > > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > > > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > > > MIME-Version: 1.0
> > > > > Content-Type: text/plain; charset=UTF-8
> > > > > Content-Transfer-Encoding: 8bit
> > > > > 
> > > > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > > > > 
> > > > > Specifically consider an ELF binary with the following PT_LOAD segments:
> > > > > 
> > > > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > > > > 
> > > > > Note how the last segment is actually the first segment and vice versa.
> > > > > 
> > > > > Since total_mapping_size() only computes the difference between the
> > > > > first and the last segment in the order that they appear, it will return
> > > > > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > > > > did not happen before that change.
> > > > > 
> > > > > Strictly speaking total_mapping_size() made that assumption already
> > > > > before that patch, but the issue did not appear because the old
> > > > > load_addr_set guards never allowed this call to total_mapping_size().
> > > > > 
> > > > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > > > fix this by comparing the correct first and last segments in
> > > > > total_mapping_size().
> > > > 
> > > > Ah, nice. Yeah, this is good.
> > > > 
> > > > > Signed-off-by: Magnus Groß <magnus.gross@rwth-aachen.de>
> > > > 
> > > > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > > > Cc: stable@vger.kernel.org
> > > > Acked-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Andrew, can you pick this up too?
> > > 
> > > -Kees
> > > 
> > 
> > May I also propose to include this patch in whatever mailing-list
> > corresponds to the 5.16.x bugfix series?
> > It turns out that almost all native Linux games published by the Virtual
> > Programming company have this kind of weird PT_LOAD ordering including
> > the famous Bioshock Infinite, so right now those games are all
> > completely broken since Linux 5.16.
> > 
> > P.S.: Someone should probably ask Virtual Programming, what kind of
> > tooling they use to create such convoluted ELF binaries.
> 
> Oh, actually, this was independently fixed:
> https://lore.kernel.org/all/YVmd7D0M6G/DcP4O@localhost.localdomain/
> 
> Alexey, you never answered by question about why we can't use a proper
> type and leave the ELF_PAGESTART() macros alone:
> https://lore.kernel.org/all/202110071038.B589687@keescook/

Oh sorry, I didn't see that there was already a patch floating around
that fixed the issue, otherwise I would have not wasted so much time on
debugging this.
Oh well, doesn't matter now, I still learned a lot about kernel
development and debugging with kgdb, I will probably be able to make
some use of that knowledge in the future for another kernel patch.

> > P.S.: Someone should probably ask Virtual Programming, what kind of
> > tooling they use to create such convoluted ELF binaries.
> 
> Does "strings" provide any hints? :)

It seems to be crosstool-ng
(https://github.com/crosstool-ng/crosstool-ng):

readelf -p .comment bioshock.i386

String dump of section '.comment':
[  0]  GCC: (crosstool-NG 1.17.0) 4.6.3
[ 21]  GCC: (Ubuntu 4.9.1-16ubuntu6) 4.9.1
[ 45]  GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2


Not sure though if crosstool-ng outputs these weird ELF binaries in
general or if it's just a bug.

--
Magnus

> > 
> > > > 
> > > > -Kees
> > > > 
> > > > > ---
> > > > >  fs/binfmt_elf.c | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > > > index f8c7f26f1fbb..0caaad9eddd1 100644
> > > > > --- a/fs/binfmt_elf.c
> > > > > +++ b/fs/binfmt_elf.c
> > > > > @@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > > > >  static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> > > > >  {
> > > > >  	int i, first_idx = -1, last_idx = -1;
> > > > > +	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
> > > > >  
> > > > >  	for (i = 0; i < nr; i++) {
> > > > >  		if (cmds[i].p_type == PT_LOAD) {
> > > > > -			last_idx = i;
> > > > > -			if (first_idx == -1)
> > > > > +			/*
> > > > > +			 * The PT_LOAD segments are not necessarily ordered
> > > > > +			 * by vaddr. Make sure that we get the segment with
> > > > > +			 * minimum vaddr (maximum vaddr respectively)
> > > > > +			 */
> > > > > +			if (cmds[i].p_vaddr <= min_vaddr) {
> > > > >  				first_idx = i;
> > > > > +				min_vaddr = cmds[i].p_vaddr;
> > > > > +			}
> > > > > +			if (cmds[i].p_vaddr >= max_vaddr) {
> > > > > +				last_idx = i;
> > > > > +				max_vaddr = cmds[i].p_vaddr;
> > > > > +			}
> > > > >  		}
> > > > >  	}
> > > > >  	if (first_idx == -1)
> > > > >  		return 0;
> > > > >  
> > > > > -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> > > > > -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> > > > > +	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
> > > > >  }
> > > > >  
> > > > >  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> > > > > -- 
> > > > > 2.34.1
> > > > 
> > > > -- 
> > > > Kees Cook
> > > 
> > > -- 
> > > Kees Cook
> 
> -- 
> Kees Cook
