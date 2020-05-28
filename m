Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721E21E5A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgE1IIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 04:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE1IIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 04:08:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E2C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 01:08:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so2177770wml.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ddrkb4Yjz2pSFmbm21qlVk0tHBAyv7WP9tJyprn/I6I=;
        b=PM1BFFu0apcuMUKSopUBN/eNbUBf1HrceCXOhzyGPhLxTCv4d4cjEukkW635e63vcm
         i2MPBFETKnx44OuW42YWPRTC75Hn7/J1H2bRosoeRnEDLoLFwSyeerevDTRZdCMgU7jO
         tvmd29zp6vuBXRNi2I99p1T43nF7uWAGJmFEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ddrkb4Yjz2pSFmbm21qlVk0tHBAyv7WP9tJyprn/I6I=;
        b=HL5fEKoRA6FeQZd1IEL2sW5moGVT3q2DzklTK68uXmHy7b7diWGookdNABHac7WLrH
         U5nUOgJu4/xPYPfe3ud8PQsFS7YuwPfkcaqwOD7TvWfETFDiiyNfDq/XWMkpleU5RdPM
         urtCqX6veJz9HlONV0bA3RGSzCZq9w0zI1ea/dbAnq0spSF3o0j6TnRwR5EM38pJec+g
         oe1LHDcgRdbtkdNPD1PV5/49EYYH9QhQuz1GKuvGWzgwnkhnxO/Q7xI/FzhoCy2Oqtyy
         Ip1ovOWwTq/jUlEqzXH9HSsri/dAuUWt2ZuWQOLWHaDNHCl4HyTJ2tI5yYpw/3LER2WS
         oMpg==
X-Gm-Message-State: AOAM533St0bDGDRvXfxJ2+bfr9vd/wvyCXTK77k9BRNtqUhwEcTOHOH1
        l5QU9Igj85YoIAMOa1RaXvTWtA==
X-Google-Smtp-Source: ABdhPJxjDXucNVywnC2RwHPUi2DYVDTqW5iS27i7mKBccZljKK0SPVGbzZuj/xdf3aHBkf+7tW2n7g==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr2076118wmf.163.1590653300755;
        Thu, 28 May 2020 01:08:20 -0700 (PDT)
Received: from noodle ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id u13sm5108211wmm.6.2020.05.28.01.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 01:08:20 -0700 (PDT)
Date:   Thu, 28 May 2020 11:08:12 +0300
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200528080812.GA21974@noodle>
References: <20200527104848.GA7914@nixbox>
 <20200527125805.GI11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527125805.GI11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 12:58:05PM +0000, Luis Chamberlain wrote:
> Eric since you authored the code which this code claism to fix, your
> review would be appreciated.
> 
> On Wed, May 27, 2020 at 01:48:48PM +0300, Boris Sukholitko wrote:
> > Successful get_subdir returns dir with its header.nreg properly
> > adjusted. No need to drop the dir in that case.
> 
> This commit log is not that clear to me
> can you explain what happens
> without this patch, and how critical it is to fix it. How did you
> notice this issue?

Apologies for being too terse with my explanation. I'll try to expand
below.

In testing of our kernel (based on 4.19, tainted, sorry!) on our aarch64 based hardware
we've come upon the following oops (lightly edited to omit irrelevant details):

000:50:01.133 Unable to handle kernel paging request at virtual address 0000000000007a12
000:50:02.209 Process brctl (pid: 14467, stack limit = 0x00000000bcf7a578)
000:50:02.209 CPU: 1 PID: 14467 Comm: brctl Tainted: P                  4.19.122 #1
000:50:02.209 Hardware name: Broadcom-v8A (DT)
000:50:02.209 pstate: 60000005 (nZCv daif -PAN -UAO)
000:50:02.209 pc : unregister_sysctl_table+0x1c/0xa0
000:50:02.209 lr : unregister_net_sysctl_table+0xc/0x20
000:50:02.209 sp : ffffff800e5ab9e0
000:50:02.209 x29: ffffff800e5ab9e0 x28: ffffffc016439ec0 
000:50:02.209 x27: 0000000000000000 x26: ffffff8008804078 
000:50:02.209 x25: ffffff80087b4dd8 x24: ffffffc015d65000 
000:50:02.209 x23: ffffffc01f0d6010 x22: ffffffc01f0d6000 
000:50:02.209 x21: ffffffc0166c4eb0 x20: 00000000000000bd 
000:50:02.209 x19: ffffffc01f0d6030 x18: 0000000000000400 
000:50:02.256 x17: 0000000000000000 x16: 0000000000000000 
000:50:02.256 x15: 0000000000000400 x14: 0000000000000129 
000:50:02.256 x13: 0000000000000001 x12: 0000000000000030 
000:50:02.256 x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
000:50:02.256 x9 : feff646663687161 x8 : ffffffffffffffff 
000:50:02.256 x7 : fefefefefefefefe x6 : 0000000000008080 
000:50:02.256 x5 : 00000000ffffffff x4 : ffffff8008905c38 
000:50:02.256 x3 : ffffffc01f0d602c x2 : 00000000000000bd 
000:50:02.256 x1 : ffffffc01f0d60c0 x0 : 0000000000007a12 
000:50:02.256 Call trace:
000:50:02.256  unregister_sysctl_table+0x1c/0xa0
000:50:02.256  unregister_net_sysctl_table+0xc/0x20
000:50:02.256  __devinet_sysctl_unregister.isra.0+0x2c/0x60
000:50:02.256  inetdev_event+0x198/0x510
000:50:02.256  notifier_call_chain+0x58/0xa0
000:50:02.303  raw_notifier_call_chain+0x14/0x20
000:50:02.303  call_netdevice_notifiers_info+0x34/0x80
000:50:02.303  rollback_registered_many+0x384/0x600
000:50:02.303  unregister_netdevice_queue+0x8c/0x110
000:50:02.303  br_dev_delete+0x8c/0xa0
000:50:02.303  br_del_bridge+0x44/0x70
000:50:02.303  br_ioctl_deviceless_stub+0xcc/0x310
000:50:02.303  sock_ioctl+0x194/0x3f0
000:50:02.303  compat_sock_ioctl+0x678/0xc00
000:50:02.303  __arm64_compat_sys_ioctl+0xf0/0xcb0
000:50:02.303  el0_svc_common+0x70/0x170
000:50:02.303  el0_svc_compat_handler+0x1c/0x30
000:50:02.303  el0_svc_compat+0x8/0x18
000:50:02.303 Code: a90153f3 aa0003f3 f9401000 b40000c0 (f9400001) 

The crash is in the call to count_subheaders(header->ctl_table_arg).

Although the header (being in x19 == 0xffffffc01f0d6030) looks like a
normal kernel pointer, ctl_table_arg (x0 == 0x0000000000007a12) looks
invalid.

Trying to find the issue, we've started tracing header allocation being
done by kzalloc in __register_sysctl_table and header freeing being done
in drop_sysctl_table.

Then we've noticed headers being freed which where not allocated before.
The faulty freeing was done on parent->header at the end of
drop_sysctl_table.

From this we've started to suspect some infelicity in header.nreg
refcounting, thus leading us the __register_sysctl_table fix in the
patch.

Here is more detailed explanation of the fix.

The current __register_sysctl_table logic looks like:

1. We start with some root dir, incrementing its header.nreg.

2. Then we find suitable dir using get_subdir function.

3. get_subdir decrements nreg on the parent dir and increments it on the
   dir being returned. See found label there.

4. We decrement dir's header.nreg for the symmetry with step 1.

IMHO, the bug is on step 4. If another dir is being returned by
get_subdir we decrement its nreg. I.e. the returned dir nreg stays 1
despite having children added to it.

This leads eventually to the innocent parent header being freed.

> If you don't apply this patch what issue do you see?

For some unexplained reason, the crashes are very rare and require
stressing the system while creating and destroing network interfaces.

> 
> Do we test for it? Can we?
> 

With some printk tracing the issue is easy to see while doing simple
brctl addbr / delbr to create and destroy bridge interface.

Probably there is some SLUB debug option which may allow to catch the
faulty free.

Thanks,
Boris.

>   Luis
> 
> > 
> > Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
> > Fixes: 7ec66d06362d (sysctl: Stop requiring explicit management of sysctl directories)
> > ---
> >  fs/proc/proc_sysctl.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index b6f5d459b087..6f237f0eb531 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1286,8 +1286,8 @@ struct ctl_table_header *__register_sysctl_table(
> >  {
> >  	struct ctl_table_root *root = set->dir.header.root;
> >  	struct ctl_table_header *header;
> > +	struct ctl_dir *dir, *start_dir;
> >  	const char *name, *nextname;
> > -	struct ctl_dir *dir;
> >  	struct ctl_table *entry;
> >  	struct ctl_node *node;
> >  	int nr_entries = 0;
> > @@ -1307,6 +1307,7 @@ struct ctl_table_header *__register_sysctl_table(
> >  
> >  	spin_lock(&sysctl_lock);
> >  	dir = &set->dir;
> > +	start_dir = dir;
> >  	/* Reference moved down the diretory tree get_subdir */
> >  	dir->header.nreg++;
> >  	spin_unlock(&sysctl_lock);
> > @@ -1333,7 +1334,8 @@ struct ctl_table_header *__register_sysctl_table(
> >  	if (insert_header(dir, header))
> >  		goto fail_put_dir_locked;
> >  
> > -	drop_sysctl_table(&dir->header);
> > +	if (start_dir == dir)
> > +		drop_sysctl_table(&dir->header);
> >  	spin_unlock(&sysctl_lock);
> >  
> >  	return header;
> > -- 
> > 2.23.1
> > 
