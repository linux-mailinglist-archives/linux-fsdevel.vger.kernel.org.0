Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8749F510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbiA1I0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiA1I0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:26:14 -0500
Received: from mail-out-2a.itc.rwth-aachen.de (mail-out-2a.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F50C061714
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 00:26:13 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2APAACBo/Nh/6QagoZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBRgYBAQELAYFRgixqhEmII4ZLggchnFGBfAsBAQEBAQEBAQEIAT8CB?=
 =?us-ascii?q?AEBhQUCg18CJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBQSBHIUvR?=
 =?us-ascii?q?oZCAQEBAQMjDwE7CxALEQMBAgECAiYCAhAEMwgOCgQFhhsBrwl6gTGBAYhWg?=
 =?us-ascii?q?ScJAYEGKgGHK4cugimBFYMqPoddgmUEkhQGAYEOHDAPlCmDKEandoIoB4IQV?=
 =?us-ascii?q?GScQoNMliYCkVKWSKY8AgQCBAUCFoFhghUzPk+CaVEXAg+OLBaOLkEyOAIGA?=
 =?us-ascii?q?QoBAQMJgjqDCiYTh08BAQ?=
IronPort-Data: A9a23:C2DECq3Y9XoWpBqgBPbD5e5wkn2cJEfYwER7XKvMYLTBsI5bpzwOy
 2ccDDiCbquCNGOmco8nOt/ioUMG7ZSGm95nHAZo3Hw8FHgiRegppDi6BhqqY3nCfpWroGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9BGQ7InQLlbGILes1htZGEk0GE/NtTo5w7Rj2tcy0YDia++wk
 YqaT/P3aQfNNwFcbzp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFontR5fMebS4K8bhL
 wr15OzjojmJr09F5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z4
 Y1juZuecCwQEoqcxMU4czBTDghMBPgTkFPHCSDXXc271VLac3b8hu4ySUhwJ5IE+qN+DSdC+
 JT0KhhUNUzF3rnuhujlDLAy2qzPL+GyVG8bknRpwjfEFrApW5fYWI3Q+sNYmT45jcBDG7DSa
 qL1bBIzNk6YMkQn1lE/OMkXl9r22VXGfRJKuXCeoJQ+oE3C9VkkuFTqGJ+PEjCQfu1Wk0uDr
 WXB/EzyAgsdMd2CzHyC6H3ErubMhSbTXIMUCa39+Pl3hlGa2m0UDlsRT1TTiee4kEmWSd9ZK
 lJS/isosLh081akCMT+NzW1qn+JshMGXvJAFuwh8wCKzOzf5APxLmwFSCNRLdI9uMIoSDgCy
 FCEhZXqCCZpvbnTTmiSnp+QrDWvKW0QKEcBeyYPTk0C+daLiIUyiA/fC9ZqCqK4iNzzFhnuz
 D2Q6isznbMeiYgMzarTwLzcqyizupjEXksuukDeGHi68gM8bYLja4HABUXn0Mus5b2xFjGp1
 EXoUeDHhAzSJflhTBCwfdg=
IronPort-HdrOrdr: A9a23:sWQt/qGtukwdgirjpLqFaZHXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdpZJkh8erwW5VoMkmsjaKdgLNhdotKOTOLhILGFvAE0WKP+Vzd8k7Fh6RgPM
 VbAs5D4bTLZDAU4/oSizPIcerIteP3lJxA8t2uqkuFIzsLV4hQqyNCTiqLGEx/QwdLQbAjEo
 CH28ZBrz28PVwKc8WSHBA+LqT+juyOsKijTQ8NBhYh5gXLpyiv8qTGHx+R2Qpbey9TwI0l7X
 POn2XCl+qeWrCAu1HhPl3ontRrcejau5h+7Qu3+4oowwDX+0eVjUJaKvi/VX4O0aWSAR0R4a
 LxSl8bTr5OAjXqDyyISFLWqnTd+Sdr5Hn4xVCCh3z/5cT/WTIhEsJEwZlUax3D9iMbzadBOY
 9wrhakXqBsfGT9deXGlqj1fgAvklDxrWspkOYVgXAaWYwCaKVJpYha+E9OCp8PEC/z9YhiSY
 BVfYnhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdzs0CmXUL8o47VvB/lq
 35G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJK26WKUSPLtBzB5rnw6SHnIndJNvaCqDg4KFC5q
 gpYWkoxlLaIXiedvFm9Kc7gyzwfA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="422091"
Received: from rwthex-s4-a.rwth-ad.de ([134.130.26.164])
  by mail-in-2a.itc.rwth-aachen.de with ESMTP; 28 Jan 2022 09:26:10 +0100
Received: from localhost (2a02:908:1066:22e0:95a5:b322:26dd:ff8d) by
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Jan 2022 09:26:09 +0100
Date:   Fri, 28 Jan 2022 09:26:09 +0100
From:   Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>
To:     Kees Cook <keescook@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <YfOooXQ2ScpZLhmD@fractal.localdomain>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202201262230.E16DF58B@keescook>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Originating-IP: [2a02:908:1066:22e0:95a5:b322:26dd:ff8d]
X-ClientProxiedBy: rwthex-w4-b.rwth-ad.de (2a00:8a60:1:e500::26:167) To
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:31:42PM -0800 Kees Cook wrote:
> On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groß wrote:
> > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > > 
> > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > > 
> > > Specifically consider an ELF binary with the following PT_LOAD segments:
> > > 
> > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > > 
> > > Note how the last segment is actually the first segment and vice versa.
> > > 
> > > Since total_mapping_size() only computes the difference between the
> > > first and the last segment in the order that they appear, it will return
> > > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > > did not happen before that change.
> > > 
> > > Strictly speaking total_mapping_size() made that assumption already
> > > before that patch, but the issue did not appear because the old
> > > load_addr_set guards never allowed this call to total_mapping_size().
> > > 
> > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > fix this by comparing the correct first and last segments in
> > > total_mapping_size().
> > 
> > Ah, nice. Yeah, this is good.
> > 
> > > Signed-off-by: Magnus Groß <magnus.gross@rwth-aachen.de>
> > 
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Andrew, can you pick this up too?
> 
> -Kees
> 

May I also propose to include this patch in whatever mailing-list
corresponds to the 5.16.x bugfix series?
It turns out that almost all native Linux games published by the Virtual
Programming company have this kind of weird PT_LOAD ordering including
the famous Bioshock Infinite, so right now those games are all
completely broken since Linux 5.16.

P.S.: Someone should probably ask Virtual Programming, what kind of
tooling they use to create such convoluted ELF binaries.

> > 
> > -Kees
> > 
> > > ---
> > >  fs/binfmt_elf.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index f8c7f26f1fbb..0caaad9eddd1 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > >  static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> > >  {
> > >  	int i, first_idx = -1, last_idx = -1;
> > > +	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
> > >  
> > >  	for (i = 0; i < nr; i++) {
> > >  		if (cmds[i].p_type == PT_LOAD) {
> > > -			last_idx = i;
> > > -			if (first_idx == -1)
> > > +			/*
> > > +			 * The PT_LOAD segments are not necessarily ordered
> > > +			 * by vaddr. Make sure that we get the segment with
> > > +			 * minimum vaddr (maximum vaddr respectively)
> > > +			 */
> > > +			if (cmds[i].p_vaddr <= min_vaddr) {
> > >  				first_idx = i;
> > > +				min_vaddr = cmds[i].p_vaddr;
> > > +			}
> > > +			if (cmds[i].p_vaddr >= max_vaddr) {
> > > +				last_idx = i;
> > > +				max_vaddr = cmds[i].p_vaddr;
> > > +			}
> > >  		}
> > >  	}
> > >  	if (first_idx == -1)
> > >  		return 0;
> > >  
> > > -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> > > -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> > > +	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
> > >  }
> > >  
> > >  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> > > -- 
> > > 2.34.1
> > 
> > -- 
> > Kees Cook
> 
> -- 
> Kees Cook
