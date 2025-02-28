Return-Path: <linux-fsdevel+bounces-42802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D3A48E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331707A8F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E6176ADE;
	Fri, 28 Feb 2025 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk1mjLGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAF1A28D;
	Fri, 28 Feb 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709246; cv=none; b=o88mU+LVMn9kfJ69Er6328oZgIWcoEjm84HXioBY9QtgZQx3d071SgZMKyb7+DNPG/m8dcbHswRA3RTXsUDNXYDv+J+vvB0t65RIB/FapXAtC2KSkHSG5CpIxs6XMZy2z8QWga2o9VQrfQC4LQpWVlnnBAb7geD9q2qbHZPFVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709246; c=relaxed/simple;
	bh=7WFigR8PWtm8/d1Y0FXLhl+hAJVSGkErgH/Vsf6Qs8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpAK0a+EABBmxjkk8SY0ZooM/uoHaPH857xa+cEjzpuPRTybNveQvFPlqUz4DGMY8br7vr6F4OAixNH1jne20WyA60iBlObV+0I7ZD97+9gKzyMTSxNeNsJIhDMYmixi07eD45NPdKdq7jpT2hmaSFtUsZO8yye9/sXeXt/iSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk1mjLGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7A8C4CEDD;
	Fri, 28 Feb 2025 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709245;
	bh=7WFigR8PWtm8/d1Y0FXLhl+hAJVSGkErgH/Vsf6Qs8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk1mjLGDRE1AHOMeILzc1whZf8HUsDk5f7JbeDWPR/Kd2iUxWiGN+OhFHmGcQfQuP
	 A/Xt7GXZ4o72Rozc/Vha0hn9baoBWrf0FNClNwSc1ndpDMJRPRgNHQ5wTlBYO+Tbb/
	 hkc+FLiViMwOqinNaSZsNhgYll8qUnwuQKXPQP/g6QL9XOb8Y6gfGBRKmSwFqp5Xgl
	 z1+ui3uZFbWWeIZZBsRS843o4bTIPI1m1EoZxVgzR1RDgTBRyE7za9SvpLXZBMBjDV
	 FHTPxQS73dltUNuKwl0rHbx2UxbT2iCCUgO+0WFHKlYL5t9MhNzsuloJ35xk+3OHOx
	 WIEBF1wt62tnQ==
Date: Thu, 27 Feb 2025 18:20:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] README: add supported fs list
Message-ID: <20250228022045.GA6229@frogsfrogsfrogs>
References: <20250227200514.4085734-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227200514.4085734-1-zlang@kernel.org>

On Fri, Feb 28, 2025 at 04:05:14AM +0800, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> David Sterba suggests to have a supported fs list in fstests:
> 
> https://lore.kernel.org/fstests/20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m742e4f1f6668d39c1a48450e7176a366e0a2f6f9
> 
> I think that's a good suggestion, so I send this patch now. But tell the truth,
> it's hard to find all filesystems which are supported by fstests. Especially
> some filesystems might use fstests, but never be metioned in fstests code.
> So please review this patch or send another patch to tell fstests@ list, if
> you know any other filesystem is suppported.
> 
> And if anyone has review point about the support "level" and "comment" part,
> please feel free to tell me :)
> 
> Thanks,
> Zorro
> 
>  README | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..055935917 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,85 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +With xfs was ported to Linux, so was xfstests, now it only supports Linux.

   When

> +
> +As xfstests has some test cases are good to run on some other filesystems,

                   many test cases that can be run

> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.
> +
> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +
> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| AFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2/3/4   |  L3+  | N/A                                                     |

What do the plus and minus mean?

> ++------------+-------+---------------------------------------------------------+
> +| Exfat      |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| FUSE       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| GFS2       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Glusterfs  |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| JFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| pvfs2      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| ubifs      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| udf        |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Virtiofs   |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| 9p         |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+

This roughly tracks with my observations over the years.

--D

> +
>  _______________________
>  BUILDING THE FSQA SUITE
>  _______________________
> -- 
> 2.47.1
> 
> 

