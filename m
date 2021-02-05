Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F33107A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBEJTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 04:19:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36689 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhBEJQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612517004; x=1644053004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMHy9mauZI7e1sVPWfCEqVJfJvi997kqX2h4+a14EDA=;
  b=i3Ud+/kCN0CfhnyUyTil3+A90HpJ5f2mSGOVnCrOQD9FSge3mmj4I32J
   v+QCsQkjhNX13RAbflapBN46BF2O6ZSr7cco2AsDpXc2zTp5bhqwk0/6z
   OSPZxePFh61nfo7aqmtFAf3xfIwdSvQhxkVIuFpq4STlqOTLbc+gWDvxI
   TYKWOBp5Q9VK3bVzReZlDu0Hse2nXrOZVsTvavdWma8VEVfamRrANSORh
   GxtP9nfK2SAIuwB9cs9nN7OjvJtUezHEutQIhh3qTNexee0r8K2VC6pFf
   y1CCuw9S59CrAp1VOF8FYY5WaM/PlBSkDw7RiCOOH+cjyyObdamFB4GCh
   w==;
IronPort-SDR: 2xTjB3t/WDFAjby25gotouMHL+i0uBZe/glGi6fBDmBCTl5DweomlZSG126rm6sAw6ql8fVSVU
 VBH0G5F8bEI6q7D/bDpKGZPhUwvMk24IPdbD+cwkK0nLNzyOFHFTUgm62+Hz0iFS7DRh+VFNWm
 RrygUajJxlbodfMcZXkqd7WDI2+3NltYyQTYK2veezP5tmq/558kFcX7txVVmO4e/8eW5sfCXW
 f3mGOZ3Zr5yZDMAR/UWrH6BPGG6yCzgmqquLcjAM2q5PCcIBEcKBA+TcCTCJ8lWBjy+foeePNw
 rCk=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="263323652"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 17:21:44 +0800
IronPort-SDR: 7WZSqUXAY2TGYaYsS0bE2LeR6y3njNG1GFwBKVWbsWVGZYz8sPeY474JpnmqY5RebXiqcj6Z1T
 h++C9wsIdqxCf7raVqAiufvL7E0eHKzNf2uZbodRfzSZc/Ca3IzVG8c7bKlxX/m8ihV0vuDlOI
 JKvdUATl5QsOFobY0UswuS4ERiWnnPzdDe2bB11t5ddP3U3vni+QBYT/pNpC1usGzPj/H86Nzy
 t72vfW7FiJ/uz1yZlIefLY4Z/t5zxicAJM4SA8jyfWef/CnHm1JepFeuW555wgY2trfGI4nwBj
 2URzHGz82kYRbOM4gNfiRHuY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 00:57:21 -0800
IronPort-SDR: 6tMxU2EKirKVzIQYjx/kwmBw9CDy3kvs9CV1kkgzmXs2pXW1ndCZJAVzxevq/bpJaxMCqhc4fT
 +V3E61H0rI+Y9ndWJX8mH8ZNgLUE4TP2F5pJyTSSZVbOcVPOoax2p33FQkLFVFl474xgnLN/Zq
 gt0TCcbb7nyeEZcLhd3FqyV7imkCh/Hb22ASXgD44s550zhWGwVNGJ9u3vCqCWKMboj78S2VPI
 ceXBtVNhGNdemhc9aEIr5Rj7AUaxCmkd8EgaaXGT8ZXtZgkwVKrmgbvEmGYjqNBzeYZJwcRqtm
 53A=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 01:15:19 -0800
Date:   Fri, 5 Feb 2021 18:15:16 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v15 40/42] btrfs: zoned: serialize log transaction on
 zoned filesystems
Message-ID: <20210205091516.l3nkvig7swburnxx@naota-xeon>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David, could you fold the below incremental diff to this patch? Or, I
can send a full replacement patch.

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8be3164d4c5d..4e72794342c0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -143,6 +143,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	const bool zoned = btrfs_is_zoned(fs_info);
 	int ret = 0;
+	bool created = false;
 
 	/*
 	 * First check if the log root tree was already created. If not, create
@@ -152,8 +153,10 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		mutex_lock(&tree_root->log_mutex);
 		if (!fs_info->log_root_tree) {
 			ret = btrfs_init_log_root_tree(trans, fs_info);
-			if (!ret)
+			if (!ret) {
 				set_bit(BTRFS_ROOT_HAS_LOG_TREE, &tree_root->state);
+				created = true;
+			}
 		}
 		mutex_unlock(&tree_root->log_mutex);
 		if (ret)
@@ -183,16 +186,16 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 		}
 	} else {
-		if (zoned) {
-			mutex_lock(&fs_info->tree_log_mutex);
-			if (fs_info->log_root_tree)
-				ret = -EAGAIN;
-			else
-				ret = btrfs_init_log_root_tree(trans, fs_info);
-			mutex_unlock(&fs_info->tree_log_mutex);
-		}
-		if (ret)
+		/*
+		 * This means fs_info->log_root_tree was already created
+		 * for some other FS trees. Do the full commit not to mix
+		 * nodes from multiple log transactions to do sequential
+		 * writing.
+		 */
+		if (zoned && !created) {
+			ret = -EAGAIN;
 			goto out;
+		}
 
 		ret = btrfs_add_log_tree(trans, root);
 		if (ret)


On Thu, Feb 04, 2021 at 07:22:19PM +0900, Naohiro Aota wrote:
> This is the 2/3 patch to enable tree-log on zoned filesystems.
> 
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at the
> time of a log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same problem with mixed
> allocation.
> 
> Serializes log transactions by waiting for a committing transaction when
> someone tries to start a new transaction, to avoid the mixed allocation
> problem. We must also wait for running log transactions from another
> subvolume, but there is no easy way to detect which subvolume root is
> running a log transaction. So, this patch forbids starting a new log
> transaction when other subvolumes already allocated the global log root
> tree.
> 
> Cc: Filipe Manana <fdmanana@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c02eeeac439c..8be3164d4c5d 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
>  				       struct btrfs_root *log,
>  				       struct btrfs_path *path,
>  				       u64 dirid, int del_all);
> +static void wait_log_commit(struct btrfs_root *root, int transid);
>  
>  /*
>   * tree logging is a special write ahead log used to make sure that
> @@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_root *tree_root = fs_info->tree_root;
> +	const bool zoned = btrfs_is_zoned(fs_info);
>  	int ret = 0;
>  
>  	/*
> @@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  
>  	mutex_lock(&root->log_mutex);
>  
> +again:
>  	if (root->log_root) {
> +		int index = (root->log_transid + 1) % 2;
> +
>  		if (btrfs_need_log_full_commit(trans)) {
>  			ret = -EAGAIN;
>  			goto out;
>  		}
>  
> +		if (zoned && atomic_read(&root->log_commit[index])) {
> +			wait_log_commit(root, root->log_transid - 1);
> +			goto again;
> +		}
> +
>  		if (!root->log_start_pid) {
>  			clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
>  			root->log_start_pid = current->pid;
> @@ -173,6 +183,17 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
>  		}
>  	} else {
> +		if (zoned) {
> +			mutex_lock(&fs_info->tree_log_mutex);
> +			if (fs_info->log_root_tree)
> +				ret = -EAGAIN;
> +			else
> +				ret = btrfs_init_log_root_tree(trans, fs_info);
> +			mutex_unlock(&fs_info->tree_log_mutex);
> +		}
> +		if (ret)
> +			goto out;
> +
>  		ret = btrfs_add_log_tree(trans, root);
>  		if (ret)
>  			goto out;
> @@ -201,14 +222,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>   */
>  static int join_running_log_trans(struct btrfs_root *root)
>  {
> +	const bool zoned = btrfs_is_zoned(root->fs_info);
>  	int ret = -ENOENT;
>  
>  	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
>  		return ret;
>  
>  	mutex_lock(&root->log_mutex);
> +again:
>  	if (root->log_root) {
> +		int index = (root->log_transid + 1) % 2;
> +
>  		ret = 0;
> +		if (zoned && atomic_read(&root->log_commit[index])) {
> +			wait_log_commit(root, root->log_transid - 1);
> +			goto again;
> +		}
>  		atomic_inc(&root->log_writers);
>  	}
>  	mutex_unlock(&root->log_mutex);
> -- 
> 2.30.0
> 
