Return-Path: <linux-fsdevel+bounces-6057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79482813021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C91F22219
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805F4B5C2;
	Thu, 14 Dec 2023 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYm++aFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB61115;
	Thu, 14 Dec 2023 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702557004; x=1734093004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvVBbq/R1WpuDErjSUPhnSoW7RqoKzGO7l8wwj8Lx1E=;
  b=fYm++aFqXe3TpXAxCPx0WqyJIcg9jGicjbgkXXwxX43aRLwZaZxY1qrI
   w/qzgyk2NImrLFBMdpsKxZi8EyaFu+zCuteY6j0dgQD76JtuiXDsZxOJZ
   7KbhopPCYGp+8Z04IqbP8QI5ITee0BaWKJG0mGK10o1PIuPl7Xa7aFtbK
   y3OjjFP89jDlRDbjmtW8JdcWGf7DheksmF+n1miPvy3JEwnrRfIyHYYZ8
   TFVEekuvDamwJy9+M+2B8nPoGz3arqxLjJQup35ZCyq4tJoHiNa8FL1fC
   EThz+1GUiUdjMt6A6zG7Mih/wCbIe0EaAW0aUab72IdivBENgl/mrXObg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16662861"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="16662861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 04:30:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="840268415"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="840268415"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2023 04:30:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDkqk-000M3S-2A;
	Thu, 14 Dec 2023 12:29:58 +0000
Date: Thu, 14 Dec 2023 20:29:46 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
	ebiggers@kernel.org, jaegeuk@kernel.org, tytso@mit.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH 5/8] ext4: Set the case-insensitive dentry operations
 through ->s_d_op
Message-ID: <202312142039.u2475qPS-lkp@intel.com>
References: <20231213234031.1081-6-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213234031.1081-6-krisman@suse.de>

Hi Gabriel,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev tytso-ext4/dev linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/dcache-Add-helper-to-disable-d_revalidate-for-a-specific-dentry/20231214-074322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20231213234031.1081-6-krisman%40suse.de
patch subject: [PATCH 5/8] ext4: Set the case-insensitive dentry operations through ->s_d_op
config: arc-vdk_hs38_defconfig (https://download.01.org/0day-ci/archive/20231214/202312142039.u2475qPS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312142039.u2475qPS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142039.u2475qPS-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/super.c: In function '__ext4_fill_super':
>> fs/ext4/super.c:5496:15: error: 'struct super_block' has no member named 's_encoding'
    5496 |         if (sb->s_encoding)
         |               ^~


vim +5496 fs/ext4/super.c

  5215	
  5216	static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
  5217	{
  5218		struct ext4_super_block *es = NULL;
  5219		struct ext4_sb_info *sbi = EXT4_SB(sb);
  5220		ext4_fsblk_t logical_sb_block;
  5221		struct inode *root;
  5222		int needs_recovery;
  5223		int err;
  5224		ext4_group_t first_not_zeroed;
  5225		struct ext4_fs_context *ctx = fc->fs_private;
  5226		int silent = fc->sb_flags & SB_SILENT;
  5227	
  5228		/* Set defaults for the variables that will be set during parsing */
  5229		if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
  5230			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
  5231	
  5232		sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
  5233		sbi->s_sectors_written_start =
  5234			part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
  5235	
  5236		err = ext4_load_super(sb, &logical_sb_block, silent);
  5237		if (err)
  5238			goto out_fail;
  5239	
  5240		es = sbi->s_es;
  5241		sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
  5242	
  5243		err = ext4_init_metadata_csum(sb, es);
  5244		if (err)
  5245			goto failed_mount;
  5246	
  5247		ext4_set_def_opts(sb, es);
  5248	
  5249		sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
  5250		sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
  5251		sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
  5252		sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
  5253		sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
  5254	
  5255		/*
  5256		 * set default s_li_wait_mult for lazyinit, for the case there is
  5257		 * no mount option specified.
  5258		 */
  5259		sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
  5260	
  5261		err = ext4_inode_info_init(sb, es);
  5262		if (err)
  5263			goto failed_mount;
  5264	
  5265		err = parse_apply_sb_mount_options(sb, ctx);
  5266		if (err < 0)
  5267			goto failed_mount;
  5268	
  5269		sbi->s_def_mount_opt = sbi->s_mount_opt;
  5270		sbi->s_def_mount_opt2 = sbi->s_mount_opt2;
  5271	
  5272		err = ext4_check_opt_consistency(fc, sb);
  5273		if (err < 0)
  5274			goto failed_mount;
  5275	
  5276		ext4_apply_options(fc, sb);
  5277	
  5278		err = ext4_encoding_init(sb, es);
  5279		if (err)
  5280			goto failed_mount;
  5281	
  5282		err = ext4_check_journal_data_mode(sb);
  5283		if (err)
  5284			goto failed_mount;
  5285	
  5286		sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
  5287			(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
  5288	
  5289		/* i_version is always enabled now */
  5290		sb->s_flags |= SB_I_VERSION;
  5291	
  5292		err = ext4_check_feature_compatibility(sb, es, silent);
  5293		if (err)
  5294			goto failed_mount;
  5295	
  5296		err = ext4_block_group_meta_init(sb, silent);
  5297		if (err)
  5298			goto failed_mount;
  5299	
  5300		ext4_hash_info_init(sb);
  5301	
  5302		err = ext4_handle_clustersize(sb);
  5303		if (err)
  5304			goto failed_mount;
  5305	
  5306		err = ext4_check_geometry(sb, es);
  5307		if (err)
  5308			goto failed_mount;
  5309	
  5310		timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
  5311		spin_lock_init(&sbi->s_error_lock);
  5312		INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
  5313	
  5314		err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
  5315		if (err)
  5316			goto failed_mount3;
  5317	
  5318		err = ext4_es_register_shrinker(sbi);
  5319		if (err)
  5320			goto failed_mount3;
  5321	
  5322		sbi->s_stripe = ext4_get_stripe_size(sbi);
  5323		/*
  5324		 * It's hard to get stripe aligned blocks if stripe is not aligned with
  5325		 * cluster, just disable stripe and alert user to simpfy code and avoid
  5326		 * stripe aligned allocation which will rarely successes.
  5327		 */
  5328		if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
  5329		    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
  5330			ext4_msg(sb, KERN_WARNING,
  5331				 "stripe (%lu) is not aligned with cluster size (%u), "
  5332				 "stripe is disabled",
  5333				 sbi->s_stripe, sbi->s_cluster_ratio);
  5334			sbi->s_stripe = 0;
  5335		}
  5336		sbi->s_extent_max_zeroout_kb = 32;
  5337	
  5338		/*
  5339		 * set up enough so that it can read an inode
  5340		 */
  5341		sb->s_op = &ext4_sops;
  5342		sb->s_export_op = &ext4_export_ops;
  5343		sb->s_xattr = ext4_xattr_handlers;
  5344	#ifdef CONFIG_FS_ENCRYPTION
  5345		sb->s_cop = &ext4_cryptops;
  5346	#endif
  5347	#ifdef CONFIG_FS_VERITY
  5348		sb->s_vop = &ext4_verityops;
  5349	#endif
  5350	#ifdef CONFIG_QUOTA
  5351		sb->dq_op = &ext4_quota_operations;
  5352		if (ext4_has_feature_quota(sb))
  5353			sb->s_qcop = &dquot_quotactl_sysfile_ops;
  5354		else
  5355			sb->s_qcop = &ext4_qctl_operations;
  5356		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
  5357	#endif
  5358		memcpy(&sb->s_uuid, es->s_uuid, sizeof(es->s_uuid));
  5359	
  5360		INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
  5361		mutex_init(&sbi->s_orphan_lock);
  5362	
  5363		ext4_fast_commit_init(sb);
  5364	
  5365		sb->s_root = NULL;
  5366	
  5367		needs_recovery = (es->s_last_orphan != 0 ||
  5368				  ext4_has_feature_orphan_present(sb) ||
  5369				  ext4_has_feature_journal_needs_recovery(sb));
  5370	
  5371		if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb)) {
  5372			err = ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block));
  5373			if (err)
  5374				goto failed_mount3a;
  5375		}
  5376	
  5377		err = -EINVAL;
  5378		/*
  5379		 * The first inode we look at is the journal inode.  Don't try
  5380		 * root first: it may be modified in the journal!
  5381		 */
  5382		if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
  5383			err = ext4_load_and_init_journal(sb, es, ctx);
  5384			if (err)
  5385				goto failed_mount3a;
  5386		} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
  5387			   ext4_has_feature_journal_needs_recovery(sb)) {
  5388			ext4_msg(sb, KERN_ERR, "required journal recovery "
  5389			       "suppressed and not mounted read-only");
  5390			goto failed_mount3a;
  5391		} else {
  5392			/* Nojournal mode, all journal mount options are illegal */
  5393			if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
  5394				ext4_msg(sb, KERN_ERR, "can't mount with "
  5395					 "journal_async_commit, fs mounted w/o journal");
  5396				goto failed_mount3a;
  5397			}
  5398	
  5399			if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
  5400				ext4_msg(sb, KERN_ERR, "can't mount with "
  5401					 "journal_checksum, fs mounted w/o journal");
  5402				goto failed_mount3a;
  5403			}
  5404			if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
  5405				ext4_msg(sb, KERN_ERR, "can't mount with "
  5406					 "commit=%lu, fs mounted w/o journal",
  5407					 sbi->s_commit_interval / HZ);
  5408				goto failed_mount3a;
  5409			}
  5410			if (EXT4_MOUNT_DATA_FLAGS &
  5411			    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
  5412				ext4_msg(sb, KERN_ERR, "can't mount with "
  5413					 "data=, fs mounted w/o journal");
  5414				goto failed_mount3a;
  5415			}
  5416			sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
  5417			clear_opt(sb, JOURNAL_CHECKSUM);
  5418			clear_opt(sb, DATA_FLAGS);
  5419			clear_opt2(sb, JOURNAL_FAST_COMMIT);
  5420			sbi->s_journal = NULL;
  5421			needs_recovery = 0;
  5422		}
  5423	
  5424		if (!test_opt(sb, NO_MBCACHE)) {
  5425			sbi->s_ea_block_cache = ext4_xattr_create_cache();
  5426			if (!sbi->s_ea_block_cache) {
  5427				ext4_msg(sb, KERN_ERR,
  5428					 "Failed to create ea_block_cache");
  5429				err = -EINVAL;
  5430				goto failed_mount_wq;
  5431			}
  5432	
  5433			if (ext4_has_feature_ea_inode(sb)) {
  5434				sbi->s_ea_inode_cache = ext4_xattr_create_cache();
  5435				if (!sbi->s_ea_inode_cache) {
  5436					ext4_msg(sb, KERN_ERR,
  5437						 "Failed to create ea_inode_cache");
  5438					err = -EINVAL;
  5439					goto failed_mount_wq;
  5440				}
  5441			}
  5442		}
  5443	
  5444		/*
  5445		 * Get the # of file system overhead blocks from the
  5446		 * superblock if present.
  5447		 */
  5448		sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
  5449		/* ignore the precalculated value if it is ridiculous */
  5450		if (sbi->s_overhead > ext4_blocks_count(es))
  5451			sbi->s_overhead = 0;
  5452		/*
  5453		 * If the bigalloc feature is not enabled recalculating the
  5454		 * overhead doesn't take long, so we might as well just redo
  5455		 * it to make sure we are using the correct value.
  5456		 */
  5457		if (!ext4_has_feature_bigalloc(sb))
  5458			sbi->s_overhead = 0;
  5459		if (sbi->s_overhead == 0) {
  5460			err = ext4_calculate_overhead(sb);
  5461			if (err)
  5462				goto failed_mount_wq;
  5463		}
  5464	
  5465		/*
  5466		 * The maximum number of concurrent works can be high and
  5467		 * concurrency isn't really necessary.  Limit it to 1.
  5468		 */
  5469		EXT4_SB(sb)->rsv_conversion_wq =
  5470			alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
  5471		if (!EXT4_SB(sb)->rsv_conversion_wq) {
  5472			printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
  5473			err = -ENOMEM;
  5474			goto failed_mount4;
  5475		}
  5476	
  5477		/*
  5478		 * The jbd2_journal_load will have done any necessary log recovery,
  5479		 * so we can safely mount the rest of the filesystem now.
  5480		 */
  5481	
  5482		root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
  5483		if (IS_ERR(root)) {
  5484			ext4_msg(sb, KERN_ERR, "get root inode failed");
  5485			err = PTR_ERR(root);
  5486			root = NULL;
  5487			goto failed_mount4;
  5488		}
  5489		if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
  5490			ext4_msg(sb, KERN_ERR, "corrupt root inode, run e2fsck");
  5491			iput(root);
  5492			err = -EFSCORRUPTED;
  5493			goto failed_mount4;
  5494		}
  5495	
> 5496		if (sb->s_encoding)
  5497			sb->s_d_op = &generic_ci_dentry_ops;
  5498	
  5499		sb->s_root = d_make_root(root);
  5500		if (!sb->s_root) {
  5501			ext4_msg(sb, KERN_ERR, "get root dentry failed");
  5502			err = -ENOMEM;
  5503			goto failed_mount4;
  5504		}
  5505	
  5506		err = ext4_setup_super(sb, es, sb_rdonly(sb));
  5507		if (err == -EROFS) {
  5508			sb->s_flags |= SB_RDONLY;
  5509		} else if (err)
  5510			goto failed_mount4a;
  5511	
  5512		ext4_set_resv_clusters(sb);
  5513	
  5514		if (test_opt(sb, BLOCK_VALIDITY)) {
  5515			err = ext4_setup_system_zone(sb);
  5516			if (err) {
  5517				ext4_msg(sb, KERN_ERR, "failed to initialize system "
  5518					 "zone (%d)", err);
  5519				goto failed_mount4a;
  5520			}
  5521		}
  5522		ext4_fc_replay_cleanup(sb);
  5523	
  5524		ext4_ext_init(sb);
  5525	
  5526		/*
  5527		 * Enable optimize_scan if number of groups is > threshold. This can be
  5528		 * turned off by passing "mb_optimize_scan=0". This can also be
  5529		 * turned on forcefully by passing "mb_optimize_scan=1".
  5530		 */
  5531		if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
  5532			if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
  5533				set_opt2(sb, MB_OPTIMIZE_SCAN);
  5534			else
  5535				clear_opt2(sb, MB_OPTIMIZE_SCAN);
  5536		}
  5537	
  5538		err = ext4_mb_init(sb);
  5539		if (err) {
  5540			ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
  5541				 err);
  5542			goto failed_mount5;
  5543		}
  5544	
  5545		/*
  5546		 * We can only set up the journal commit callback once
  5547		 * mballoc is initialized
  5548		 */
  5549		if (sbi->s_journal)
  5550			sbi->s_journal->j_commit_callback =
  5551				ext4_journal_commit_callback;
  5552	
  5553		err = ext4_percpu_param_init(sbi);
  5554		if (err)
  5555			goto failed_mount6;
  5556	
  5557		if (ext4_has_feature_flex_bg(sb))
  5558			if (!ext4_fill_flex_info(sb)) {
  5559				ext4_msg(sb, KERN_ERR,
  5560				       "unable to initialize "
  5561				       "flex_bg meta info!");
  5562				err = -ENOMEM;
  5563				goto failed_mount6;
  5564			}
  5565	
  5566		err = ext4_register_li_request(sb, first_not_zeroed);
  5567		if (err)
  5568			goto failed_mount6;
  5569	
  5570		err = ext4_register_sysfs(sb);
  5571		if (err)
  5572			goto failed_mount7;
  5573	
  5574		err = ext4_init_orphan_info(sb);
  5575		if (err)
  5576			goto failed_mount8;
  5577	#ifdef CONFIG_QUOTA
  5578		/* Enable quota usage during mount. */
  5579		if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
  5580			err = ext4_enable_quotas(sb);
  5581			if (err)
  5582				goto failed_mount9;
  5583		}
  5584	#endif  /* CONFIG_QUOTA */
  5585	
  5586		/*
  5587		 * Save the original bdev mapping's wb_err value which could be
  5588		 * used to detect the metadata async write error.
  5589		 */
  5590		spin_lock_init(&sbi->s_bdev_wb_lock);
  5591		errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
  5592					 &sbi->s_bdev_wb_err);
  5593		EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
  5594		ext4_orphan_cleanup(sb, es);
  5595		EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
  5596		/*
  5597		 * Update the checksum after updating free space/inode counters and
  5598		 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
  5599		 * checksum in the buffer cache until it is written out and
  5600		 * e2fsprogs programs trying to open a file system immediately
  5601		 * after it is mounted can fail.
  5602		 */
  5603		ext4_superblock_csum_set(sb);
  5604		if (needs_recovery) {
  5605			ext4_msg(sb, KERN_INFO, "recovery complete");
  5606			err = ext4_mark_recovery_complete(sb, es);
  5607			if (err)
  5608				goto failed_mount10;
  5609		}
  5610	
  5611		if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
  5612			ext4_msg(sb, KERN_WARNING,
  5613				 "mounting with \"discard\" option, but the device does not support discard");
  5614	
  5615		if (es->s_error_count)
  5616			mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
  5617	
  5618		/* Enable message ratelimiting. Default is 10 messages per 5 secs. */
  5619		ratelimit_state_init(&sbi->s_err_ratelimit_state, 5 * HZ, 10);
  5620		ratelimit_state_init(&sbi->s_warning_ratelimit_state, 5 * HZ, 10);
  5621		ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
  5622		atomic_set(&sbi->s_warning_count, 0);
  5623		atomic_set(&sbi->s_msg_count, 0);
  5624	
  5625		return 0;
  5626	
  5627	failed_mount10:
  5628		ext4_quotas_off(sb, EXT4_MAXQUOTAS);
  5629	failed_mount9: __maybe_unused
  5630		ext4_release_orphan_info(sb);
  5631	failed_mount8:
  5632		ext4_unregister_sysfs(sb);
  5633		kobject_put(&sbi->s_kobj);
  5634	failed_mount7:
  5635		ext4_unregister_li_request(sb);
  5636	failed_mount6:
  5637		ext4_mb_release(sb);
  5638		ext4_flex_groups_free(sbi);
  5639		ext4_percpu_param_destroy(sbi);
  5640	failed_mount5:
  5641		ext4_ext_release(sb);
  5642		ext4_release_system_zone(sb);
  5643	failed_mount4a:
  5644		dput(sb->s_root);
  5645		sb->s_root = NULL;
  5646	failed_mount4:
  5647		ext4_msg(sb, KERN_ERR, "mount failed");
  5648		if (EXT4_SB(sb)->rsv_conversion_wq)
  5649			destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
  5650	failed_mount_wq:
  5651		ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
  5652		sbi->s_ea_inode_cache = NULL;
  5653	
  5654		ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
  5655		sbi->s_ea_block_cache = NULL;
  5656	
  5657		if (sbi->s_journal) {
  5658			/* flush s_sb_upd_work before journal destroy. */
  5659			flush_work(&sbi->s_sb_upd_work);
  5660			jbd2_journal_destroy(sbi->s_journal);
  5661			sbi->s_journal = NULL;
  5662		}
  5663	failed_mount3a:
  5664		ext4_es_unregister_shrinker(sbi);
  5665	failed_mount3:
  5666		/* flush s_sb_upd_work before sbi destroy */
  5667		flush_work(&sbi->s_sb_upd_work);
  5668		del_timer_sync(&sbi->s_err_report);
  5669		ext4_stop_mmpd(sbi);
  5670		ext4_group_desc_free(sbi);
  5671	failed_mount:
  5672		if (sbi->s_chksum_driver)
  5673			crypto_free_shash(sbi->s_chksum_driver);
  5674	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

