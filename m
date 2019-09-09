Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613A8AD21C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 05:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfIIDKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 23:10:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41289 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733190AbfIIDKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:10:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id h4so9333822oih.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 20:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=S7aYNtkvnekEqAVg7pbiUNXm6mcZGp2v22S0a/FhbJc=;
        b=dZb+/AG3oIFh8Kbq0vD3K4hvTa4qm7T4ecgIqz2cyLdAfwuMYTGZZhfh542SoBjnZC
         bYZ9mwPx6zARMjiF52zwLX96qBpkcbHx/vVhMW6233B8vQ8G2tXJmBSoPvJvXfOIovsA
         YBr+wIKzT6APJjpsXT+ndDEH0mHAaNptDmqazUF9ioeKDWWr3S+klo6238CCqrU0TCAN
         yUVD7ujt1/jTBIW+GOQ1afH49qlJqXdgMvKrBqkkNHTgjKoFgDghxldsZBuWNntEp+5w
         gKtyDmlvU/AtxblA6lq4Q7Gqr3ApQpriAB0of6Bdtf/kmkTcoktH+pIr4V4/u5QwuW3t
         ah4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=S7aYNtkvnekEqAVg7pbiUNXm6mcZGp2v22S0a/FhbJc=;
        b=NLFMi+YeB3+mwPJgY1+t7gx+QRutrxSCj3N/z3LZbMNcRaYPKxU41+VusjVQIBLklE
         Efb+68yhQ5/VXe9n84JkxwSwKWXwBO5VcfE7FYKpVu896nOrTLXrXS8xbqda/mvVsKT4
         vlT5wfXVAtOabaj9Fk+qU3x9zOf+toNCgcM+Grgj8dp6+nIgIWxfQkn09Nttd7Tc3hQ/
         EmXTXkWmlGoemsVcekLYAKuR7GcQeCsnG61fW5gp9EvI9o2e+nCnWT06xk+2Mz3SMEnJ
         /mQDS8vYWvwF8OGSmvobpYzpeD0YMy6SKs9Zx6QB2LyVoVtQ8xP1AQgCR4TNEBAISG3J
         A2gQ==
X-Gm-Message-State: APjAAAV7vblawtqGBFaXG4WRgikFi6SqYyeUylMl7Cz7iSoIbCYBKpTJ
        SDXcVwfi9VS1bfJC/mk6c0Y/mA==
X-Google-Smtp-Source: APXvYqxPnHRfQtjNgy/JTWDIXYyLtbi3aOQEbRnlF16SxYNzAiF5TVsE4sBxsLsSOhsE8/ZfEQT7oA==
X-Received: by 2002:a05:6808:342:: with SMTP id j2mr14283177oie.34.1567998633197;
        Sun, 08 Sep 2019 20:10:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a88sm5543655otb.0.2019.09.08.20.10.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 20:10:32 -0700 (PDT)
Date:   Sun, 8 Sep 2019 20:10:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
In-Reply-To: <20190908234722.GE1131@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1909081953360.1134@eggly.anvils>
References: <20190903084122.GH15734@shao2-debian> <20190908214601.GC1131@ZenIV.linux.org.uk> <20190908234722.GE1131@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Sep 2019, Al Viro wrote:
> On Sun, Sep 08, 2019 at 10:46:01PM +0100, Al Viro wrote:
> > On Tue, Sep 03, 2019 at 04:41:22PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -23.7% regression of vm-scalability.median due to commit:
> > > 
> > > 
> > > commit: 8bb3c61bafa8c1cd222ada602bb94ff23119e738 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git work.mount
> > > 
> > > in testcase: vm-scalability
> > > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	size: 16G
> > > 	test: shm-pread-rand
> > > 	cpufreq_governor: performance
> > > 	ucode: 0xb000036
> > 
> > That thing loses size=... option.  Both size= and nr_blocks= affect the
> > same thing (->max_blocks), but the parser keeps track of the options
> > it has seen and applying the parsed data to superblock checks only
> > whether nr_blocks= had been there.  IOW, size= gets parsed, but the
> > result goes nowhere.
> > 
> > I'm not sure whether it's better to fix the patch up or redo it from
> > scratch - it needs to be carved up anyway and it's highly non-transparent,
> > so I'm probably going to replace the damn thing entirely with something
> > that would be easier to follow.
> 
> ... and this
> +       { Opt_huge,     "deny",         SHMEM_HUGE_DENY },
> +       { Opt_huge,     "force",        SHMEM_HUGE_FORCE },
> had been wrong - huge=deny and huge=force should not be accepted _and_
> fs_parameter_enum is not suitable for negative constants right now
> anyway.

Sorry you've been spending time redisovering these, Al: I sent David
the tmpfs fixes (Cc'ing you and Andrew and lists) a couple of weeks
ago - but had no idea until your mail that the "loss of size" was
behind this vm-scalability regression report.

Ah, not for the first time, I missed saying "[PATCH]" in the subject:
sorry, that may have rendered it invisible to many eyes.

Here's what Andrew has been carrying in the mmotm tree since I sent it:
I'm sure we'd both be happy for you to take it into your tree.  I had
expected it to percolate through from mmotm to linux-next by now,
but apparently not.

From: Hugh Dickins <hughd@google.com>
Subject: tmpfs: fixups to use of the new mount API

Several fixups to shmem_parse_param() and tmpfs use of new mount API:

mm/shmem.c manages filesystem named "tmpfs": revert "shmem" to "tmpfs"
in its mount error messages.

/sys/kernel/mm/transparent_hugepage/shmem_enabled has valid options
"deny" and "force", but they are not valid as tmpfs "huge" options.

The "size" param is an alternative to "nr_blocks", and needs to be
recognized as changing max_blocks.  And where there's ambiguity, it's
better to mention "size" than "nr_blocks" in messages, since "size" is
the variant shown in /proc/mounts.

shmem_apply_options() left ctx->mpol as the new mpol, so then it was
freed in shmem_free_fc(), and the filesystem went on to use-after-free.

shmem_parse_param() issue "tmpfs: Bad value for '%s'" messages just
like fs_parse() would, instead of a different wording.  Where config
disables "mpol" or "huge", say "tmpfs: Unsupported parameter '%s'".

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1908191503290.1253@eggly.anvils
Fixes: 144df3b288c41 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |   80 ++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

--- a/mm/shmem.c~tmpfs-fixups-to-use-of-the-new-mount-api
+++ a/mm/shmem.c
@@ -3432,13 +3432,11 @@ static const struct fs_parameter_enum sh
 	{ Opt_huge,	"always",	SHMEM_HUGE_ALWAYS },
 	{ Opt_huge,	"within_size",	SHMEM_HUGE_WITHIN_SIZE },
 	{ Opt_huge,	"advise",	SHMEM_HUGE_ADVISE },
-	{ Opt_huge,	"deny",		SHMEM_HUGE_DENY },
-	{ Opt_huge,	"force",	SHMEM_HUGE_FORCE },
 	{}
 };
 
 const struct fs_parameter_description shmem_fs_parameters = {
-	.name		= "shmem",
+	.name		= "tmpfs",
 	.specs		= shmem_param_specs,
 	.enums		= shmem_param_enums,
 };
@@ -3448,9 +3446,9 @@ static void shmem_apply_options(struct s
 				unsigned long inodes_in_use)
 {
 	struct shmem_fs_context *ctx = fc->fs_private;
-	struct mempolicy *old = NULL;
 
-	if (test_bit(Opt_nr_blocks, &ctx->changes))
+	if (test_bit(Opt_nr_blocks, &ctx->changes) ||
+	    test_bit(Opt_size, &ctx->changes))
 		sbinfo->max_blocks = ctx->max_blocks;
 	if (test_bit(Opt_nr_inodes, &ctx->changes)) {
 		sbinfo->max_inodes = ctx->max_inodes;
@@ -3459,8 +3457,11 @@ static void shmem_apply_options(struct s
 	if (test_bit(Opt_huge, &ctx->changes))
 		sbinfo->huge = ctx->huge;
 	if (test_bit(Opt_mpol, &ctx->changes)) {
-		old = sbinfo->mpol;
-		sbinfo->mpol = ctx->mpol;
+		/*
+		 * Update sbinfo->mpol now while stat_lock is held.
+		 * Leave shmem_free_fc() to free the old mpol if any.
+		 */
+		swap(sbinfo->mpol, ctx->mpol);
 	}
 
 	if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE) {
@@ -3471,8 +3472,6 @@ static void shmem_apply_options(struct s
 		if (test_bit(Opt_mode, &ctx->changes))
 			sbinfo->mode = ctx->mode;
 	}
-
-	mpol_put(old);
 }
 
 static int shmem_parse_param(struct fs_context *fc, struct fs_parameter *param)
@@ -3498,7 +3497,7 @@ static int shmem_parse_param(struct fs_c
 			rest++;
 		}
 		if (*rest)
-			return invalf(fc, "shmem: Invalid size");
+			goto bad_value;
 		ctx->max_blocks = DIV_ROUND_UP(size, PAGE_SIZE);
 		break;
 
@@ -3506,55 +3505,59 @@ static int shmem_parse_param(struct fs_c
 		rest = param->string;
 		ctx->max_blocks = memparse(param->string, &rest);
 		if (*rest)
-			return invalf(fc, "shmem: Invalid nr_blocks");
+			goto bad_value;
 		break;
+
 	case Opt_nr_inodes:
 		rest = param->string;
 		ctx->max_inodes = memparse(param->string, &rest);
 		if (*rest)
-			return invalf(fc, "shmem: Invalid nr_inodes");
+			goto bad_value;
 		break;
+
 	case Opt_mode:
 		ctx->mode = result.uint_32 & 07777;
 		break;
+
 	case Opt_uid:
 		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(ctx->uid))
-			return invalf(fc, "shmem: Invalid uid");
+			goto bad_value;
 		break;
 
 	case Opt_gid:
 		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(ctx->gid))
-			return invalf(fc, "shmem: Invalid gid");
+			goto bad_value;
 		break;
 
 	case Opt_huge:
-#ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
-		if (!has_transparent_hugepage() &&
-		    result.uint_32 != SHMEM_HUGE_NEVER)
-			return invalf(fc, "shmem: Huge pages disabled");
-
 		ctx->huge = result.uint_32;
+		if (ctx->huge != SHMEM_HUGE_NEVER &&
+		    !(IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
+		      has_transparent_hugepage()))
+			goto unsupported_parameter;
 		break;
-#else
-		return invalf(fc, "shmem: huge= option disabled");
-#endif
-
-	case Opt_mpol: {
-#ifdef CONFIG_NUMA
-		struct mempolicy *mpol;
-		if (mpol_parse_str(param->string, &mpol))
-			return invalf(fc, "shmem: Invalid mpol=");
-		mpol_put(ctx->mpol);
-		ctx->mpol = mpol;
-#endif
-		break;
-	}
+
+	case Opt_mpol:
+		if (IS_ENABLED(CONFIG_NUMA)) {
+			struct mempolicy *mpol;
+			if (mpol_parse_str(param->string, &mpol))
+				goto bad_value;
+			mpol_put(ctx->mpol);
+			ctx->mpol = mpol;
+			break;
+		}
+		goto unsupported_parameter;
 	}
 
 	__set_bit(opt, &ctx->changes);
 	return 0;
+
+unsupported_parameter:
+	return invalf(fc, "tmpfs: Unsupported parameter '%s'", param->key);
+bad_value:
+	return invalf(fc, "tmpfs: Bad value for '%s'", param->key);
 }
 
 /*
@@ -3572,14 +3575,15 @@ static int shmem_reconfigure(struct fs_c
 	unsigned long inodes_in_use;
 
 	spin_lock(&sbinfo->stat_lock);
-	if (test_bit(Opt_nr_blocks, &ctx->changes)) {
+	if (test_bit(Opt_nr_blocks, &ctx->changes) ||
+	    test_bit(Opt_size, &ctx->changes)) {
 		if (ctx->max_blocks && !sbinfo->max_blocks) {
 			spin_unlock(&sbinfo->stat_lock);
-			return invalf(fc, "shmem: Can't retroactively limit nr_blocks");
+			return invalf(fc, "tmpfs: Cannot retroactively limit size");
 		}
 		if (percpu_counter_compare(&sbinfo->used_blocks, ctx->max_blocks) > 0) {
 			spin_unlock(&sbinfo->stat_lock);
-			return invalf(fc, "shmem: Too few blocks for current use");
+			return invalf(fc, "tmpfs: Too small a size for current use");
 		}
 	}
 
@@ -3587,11 +3591,11 @@ static int shmem_reconfigure(struct fs_c
 	if (test_bit(Opt_nr_inodes, &ctx->changes)) {
 		if (ctx->max_inodes && !sbinfo->max_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
-			return invalf(fc, "shmem: Can't retroactively limit nr_inodes");
+			return invalf(fc, "tmpfs: Cannot retroactively limit inodes");
 		}
 		if (ctx->max_inodes < inodes_in_use) {
 			spin_unlock(&sbinfo->stat_lock);
-			return invalf(fc, "shmem: Too few inodes for current use");
+			return invalf(fc, "tmpfs: Too few inodes for current use");
 		}
 	}
 
_
