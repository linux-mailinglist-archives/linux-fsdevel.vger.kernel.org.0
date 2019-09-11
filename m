Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D389EAF494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfIKDGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 23:06:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38412 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIKDGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 23:06:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so12727832pfe.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ToqU88e+zIONDbAmAaeed4bpHi5rp/NhRDe8AL6V1EE=;
        b=HHRClUiEOYovMXc+KYT7krStg+DwX3jTB1i/Pd2udmMyxK190iv0O1Iyvtg/aNYBzh
         qgw7xVwgNN+8Q7gKEvglwBidYsgfLkCQRxDlthXdCmArkm5WzWkLTsWU3ORTM2tCU3oY
         3+ch2vYXhesgp5BMO7T1BY/R/xJKDXX6OBYJVZtaMUAu94pnism2g7yzf+gBHV16laDO
         vr6x5zrftQIn0694NOFv7BmCTgnc5QE6fRHCGgZwJ9+oo2UwZGZCM/fcz2qmK+CnVAw9
         hgd9Yz72Kmck1Swa3lHB5XzPmwtZW/TrqMe1jGKkpUldGf5DJSwuvqVJTe8cz3shJgNR
         39XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ToqU88e+zIONDbAmAaeed4bpHi5rp/NhRDe8AL6V1EE=;
        b=HCzK0dTS8fSoRagePUUaQKFBR7pmTienMS/Doyda3JeBMvxmif66LpVGCMPdr8SWen
         EB4lQTyLnpIMzudUIzRC4hCCu7Sa/r75LTX9VB2FDkyobpPCfHeTWeplrqtEWkFFg7dI
         D3qyDjHCCJzY7FgdNr1/XkXbW7dQWhzY4BiiKhlweOiZOR7Vl0tIGkjEam9G9HQwWgf8
         S6Ac+HzJPJV0U0h1G0mZdK9FNEM8cQnwMkoelkGMWydVFiOo1EiSZBgOl/wKlbIUvwkU
         V8CkpFWBs3y53OCudMHyN7lOX7q17q5BqHFBSNqO0Z5vVuxpy4t9DYqm1hPlCloeytW4
         xXyg==
X-Gm-Message-State: APjAAAUt+VzENpmyJ0J2bVY+v9GQuWUWMNKx0PH9MGgt6kiJ903uIIM9
        HjCF6/lzwY/vRtBqAXK6fv3/HA==
X-Google-Smtp-Source: APXvYqxTOSfjHKIaEDeTEjttkexa5CbnE2m2M24eJGGGS5JQGxNCuWNZsLFXbsC1FS2Vd/hqEB+1PA==
X-Received: by 2002:a17:90a:3546:: with SMTP id q64mr2932797pjb.13.1568171158851;
        Tue, 10 Sep 2019 20:05:58 -0700 (PDT)
Received: from [100.112.91.228] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id f128sm27345869pfg.143.2019.09.10.20.05.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 20:05:58 -0700 (PDT)
Date:   Tue, 10 Sep 2019 20:05:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Hugh Dickins <hughd@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
In-Reply-To: <alpine.LSU.2.11.1909092301120.1267@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1909101930140.1518@eggly.anvils>
References: <20190903084122.GH15734@shao2-debian> <20190908214601.GC1131@ZenIV.linux.org.uk> <20190908234722.GE1131@ZenIV.linux.org.uk> <alpine.LSU.2.11.1909081953360.1134@eggly.anvils> <20190909035653.GF1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1909092301120.1267@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Sep 2019, Hugh Dickins wrote:
> On Mon, 9 Sep 2019, Al Viro wrote:
> > 
> > Anyway, see vfs.git#uncertain.shmem for what I've got with those folded in.
> > Do you see any problems with that one?  That's the last 5 commits in there...
> 
> It's mostly fine, I've no problem with going your way instead of what
> we had in mmotm; but I have seen some problems with it, and had been
> intending to send you a fixup patch tonight (shmem_reconfigure() missing
> unlock on error is the main problem, but there are other fixes needed).
> 
> But I'm growing tired. I've a feeling my "swap" of the mpols, instead
> of immediate mpol_put(), was necessary to protect against a race with
> shmem_get_sbmpol(), but I'm not clear-headed enough to trust myself on
> that now.  And I've a mystery to solve, that shmem_reconfigure() gets
> stuck into showing the wrong error message.

On my "swap" for the mpol_put(): no, the race against shmem_get_sbmpol()
is safe enough without that, and what you have matches what was always
done before. I rather like my "swap", which the previous double-free had
led me to, but it's fine if you prefer the ordinary way. I was probably
coming down from some over-exposure to iput() under spinlock, but there's
no such complications here.

> 
> Tomorrow....
> 
> Oh, and my first attempt to build and boot that series over 5.3-rc5
> wouldn't boot. Luckily there was a tell-tale "i915" in the stacktrace,
> which reminded me of the drivers/gpu/drm/i915/gem/i915_gemfs.c fix
> we discussed earlier in the cycle.  That is of course in linux-next
> by now, but I wonder if your branch ought to contain a duplicate of
> that fix, so that people with i915 doing bisections on 5.4-rc do not
> fall into an unbootable hole between vfs and gpu merges.

Below are the fixups I arrived at last night (I've not rechecked your
tree today, to see if you made any changes since).  But they're not
enough: I now understand why shmem_reconfigure() got stuck showing
the wrong error message, but I'll have to leave it to you to decide
what to do about it, because I don't know whether it's just a mistake,
or different filesystem types have different needs there.

My /etc/fstab has a line in for one of my test mounts:
tmpfs                /tlo                 tmpfs      size=4G               0 0
and that "size=4G" is what causes the problem: because each time
shmem_parse_options(fc, data) is called for a remount, data (that is,
options) points to a string starting with "size=4G,", followed by
what's actually been asked for in the remount options.

So if I try
mount -o remount,size=0 /tlo
that succeeds, setting the filesystem size to 0 meaning unlimited.
So if then as a test I try
mount -o remount,size=1M /tlo
that correctly fails with "Cannot retroactively limit size".
But then when I try
mount -o remount,nr_inodes=0 /tlo
I again get "Cannot retroactively limit size",
when it should have succeeded (again, 0 here meaning unlimited).

That's because the options in shmem_parse_options() are
"size=4G,nr_inodes=0", which indeed looks like an attempt to
retroactively limit size; but the user never asked "size=4G" there.

I think this problem, and some of what's fixed below, predate your
rework, and would equally affect the version in mmotm: I just didn't
discover these issues when I was testing that before.

Hugh

--- aviro/mm/shmem.c	2019-09-09 14:10:34.379832855 -0700
+++ hughd/mm/shmem.c	2019-09-09 23:29:28.467037895 -0700
@@ -3456,7 +3456,7 @@ static int shmem_parse_one(struct fs_con
 		ctx->huge = result.uint_32;
 		if (ctx->huge != SHMEM_HUGE_NEVER &&
 		    !(IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
-		    has_transparent_hugepage()))
+		      has_transparent_hugepage()))
 			goto unsupported_parameter;
 		ctx->seen |= SHMEM_SEEN_HUGE;
 		break;
@@ -3532,26 +3532,26 @@ static int shmem_reconfigure(struct fs_c
 
 	spin_lock(&sbinfo->stat_lock);
 	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
-	if (ctx->seen & SHMEM_SEEN_BLOCKS) {
+	if ((ctx->seen & SHMEM_SEEN_BLOCKS) && ctx->blocks) {
+		if (!sbinfo->max_blocks) {
+			err = "Cannot retroactively limit size";
+			goto out;
+		}
 		if (percpu_counter_compare(&sbinfo->used_blocks,
 					   ctx->blocks) > 0) {
 			err = "Too small a size for current use";
 			goto out;
 		}
-		if (ctx->blocks && !sbinfo->max_blocks) {
-			err = "Cannot retroactively limit nr_blocks";
+	}
+	if ((ctx->seen & SHMEM_SEEN_INODES) && ctx->inodes) {
+		if (!sbinfo->max_inodes) {
+			err = "Cannot retroactively limit inodes";
 			goto out;
 		}
-	}
-	if (ctx->seen & SHMEM_SEEN_INODES) {
 		if (ctx->inodes < inodes) {
 			err = "Too few inodes for current use";
 			goto out;
 		}
-		if (ctx->inodes && !sbinfo->max_inodes) {
-			err = "Cannot retroactively limit nr_inodes";
-			goto out;
-		}
 	}
 
 	if (ctx->seen & SHMEM_SEEN_HUGE)
@@ -3574,6 +3574,7 @@ static int shmem_reconfigure(struct fs_c
 	spin_unlock(&sbinfo->stat_lock);
 	return 0;
 out:
+	spin_unlock(&sbinfo->stat_lock);
 	return invalf(fc, "tmpfs: %s", err);
 }
 
