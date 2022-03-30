Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036A14ECDAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350716AbiC3UDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 16:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiC3UDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:03:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E158139BA6;
        Wed, 30 Mar 2022 13:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CBB5B81E41;
        Wed, 30 Mar 2022 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F031C340EC;
        Wed, 30 Mar 2022 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648670518;
        bh=D6t+1GcBH79l7qhD0Q85c+NZyKW0vagPZr/Wc9lOaa8=;
        h=Date:To:From:Subject:From;
        b=jc/p1Y3/iUNbO/272k2HXr67HedR/6vUGUcApbnpVHGxTW4jOeh/zLdzoBdbNcLKv
         pbTzRmpSGCr8qjyq83RA3B34uBaKtlgXRfwBtw1deujybErOH/e9FL89qqXTRSCE6W
         ffAqpHYPwvBi/FDvUKZsNrY78bCJeq/F4LlzzUZA=
Date:   Wed, 30 Mar 2022 13:01:57 -0700
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: mmotm 2022-03-30-13-01 uploaded
Message-Id: <20220330200158.2F031C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to

   https://www.ozlabs.org/~akpm/mmotm/

mmotm-readme.txt says

README for mm-of-the-moment:

https://www.ozlabs.org/~akpm/mmotm/

This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
more than once a week.

You will need quilt to apply these patches to the latest Linus release (5.x
or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
https://ozlabs.org/~akpm/mmotm/series

The file broken-out.tar.gz contains two datestamp files: .DATE and
.DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
followed by the base kernel version against which this patch series is to
be applied.

This tree is partially included in linux-next.  To see which patches are
included in linux-next, consult the `series' file.  Only the patches
within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
linux-next.


A full copy of the full kernel tree with the linux-next and mmotm patches
already applied is available through git within an hour of the mmotm
release.  Individual mmotm releases are tagged.  The master branch always
points to the latest release, so it's constantly rebasing.

	https://github.com/hnaz/linux-mm

The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is also available at

	https://github.com/hnaz/linux-mm



This mmotm tree contains the following patches against 5.17:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret.patch
* mailmap-update-vasily-averins-email-address.patch
* memcg-sync-flush-only-if-periodic-flush-is-delayed.patch
* revert-mm-madvise-skip-unmapped-vma-holes-passed-to-process_madvise.patch
* ocfs2-fix-crash-when-mount-with-quota-enabled.patch
* nilfs2-fix-lockdep-warnings-in-page-operations-for-btree-nodes.patch
* nilfs2-fix-lockdep-warnings-during-disk-space-reclamation.patch
* nilfs2-get-rid-of-nilfs_mapping_init.patch
* mm-munlock-remove-fields-to-fix-htmldocs-warnings.patch
* mm-munlock-add-lru_add_drain-to-fix-memcg_stat_test.patch
* mm-kfence-fix-objcgs-vector-allocation.patch
* mailmap-update-kirills-email.patch
* mmhwpoison-unmap-poisoned-page-before-invalidation.patch
* mm-kasan-fix-__gfp_bits_shift-definition-breaking-lockdep.patch
* tools-vm-page_owner_sortc-remove-c-option.patch
* doc-vm-page_ownerrst-remove-content-related-to-c-option.patch
* mm-kmemleak-reset-tag-when-compare-object-pointer.patch
* userfaultfd-mark-uffd_wp-regardless-of-vm_write-flag.patch
* mm-fix-unexpected-zeroed-page-mapping-with-zram-swap.patch
* mm-compaction-fix-compiler-warning-when-config_compaction=n.patch
* hugetlb-do-not-demote-poisoned-hugetlb-pages.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
  mm.patch
* stacktrace-add-interface-based-on-shadow-call-stack.patch
* arm64-scs-save-scs_sp-values-per-cpu-when-switching-stacks.patch
* arm64-implement-stack_trace_save_shadow.patch
* kasan-use-stack_trace_save_shadow.patch
* mm-shmem-make-shmem_init-return-void.patch
* mm-shmem-make-shmem_init-return-void-fix.patch
* mm-memcg-remove-unneeded-nr_scanned.patch
* mm-memcg-mz-already-removed-from-rb_tree-if-not-null.patch
* mm-use-mmap_assert_write_locked-instead-of-open-coding-it.patch
* mm-mmu_gather-limit-free-batch-count-and-add-schedule-point-in-tlb_batch_pages_flush.patch
* mm-mremap-use-helper-mlock_future_check.patch
* documentation-sysctl-document-page_lock_unfairness.patch
* mm-page_alloc-simplify-update-of-pgdat-in-wake_all_kswapds.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
* mm-discard-__gfp_atomic.patch
* mm-remove-unnecessary-void-conversions.patch
* mm-munlock-protect-the-per-cpu-pagevec-by-a-local_lock_t.patch
* mm-khugepaged-sched-to-numa-node-when-collapse-huge-page.patch
* mm-vmscan-reclaim-only-affects-managed_zones.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone.patch
* mm-vmscan-sc-reclaim_idx-must-be-a-valid-zone-index.patch
* mm-z3fold-declare-z3fold_mount-with-__init.patch
* mm-z3fold-remove-obsolete-comment-in-z3fold_alloc.patch
* mm-z3fold-minor-clean-up-for-z3fold_free.patch
* mm-z3fold-remove-unneeded-page_mapcount_reset-and-clearpageprivate.patch
* mm-z3fold-remove-confusing-local-variable-l-reassignment.patch
* mm-z3fold-move-decrement-of-pool-pages_nr-into-__release_z3fold_page.patch
* mm-z3fold-remove-redundant-list_del_init-of-zhdr-buddy-in-z3fold_free.patch
* mm-z3fold-remove-unneeded-page_headless-check-in-free_handle.patch
* mm-compaction-use-helper-isolation_suitable.patch
* mm-add-selftests-for-migration-entries.patch
* mm-migration-remove-unneeded-local-variable-mapping_locked.patch
* mm-migration-remove-unneeded-out-label.patch
* mm-migration-remove-unneeded-local-variable-page_lru.patch
* mm-migration-fix-the-confusing-pagetranshuge-check.patch
* mm-migration-use-helper-function-vma_lookup-in-add_page_for_migration.patch
* mm-migration-use-helper-macro-min-in-do_pages_stat.patch
* mm-migration-avoid-unneeded-nodemask_t-initialization.patch
* mm-migration-remove-some-duplicated-codes-in-migrate_pages.patch
* mm-migration-fix-potential-page-refcounts-leak-in-migrate_pages.patch
* mm-migration-fix-potential-invalid-node-access-for-reclaim-based-migration.patch
* mm-migration-fix-possible-do_pages_stat_array-racing-with-memory-offline.patch
* ksm-count-ksm-merging-pages-for-each-process.patch
* ksm-count-ksm-merging-pages-for-each-process-fix.patch
* mm-untangle-config-dependencies-for-demote-on-reclaim.patch
* mm-page_alloc-do-not-calculate-nodes-total-pages-and-memmap-pages-when-empty.patch
* mm-memory_hotplug-reset-nodes-state-when-empty-during-offline.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node-checkpatch-fixes.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-rmap-fix-cache-flush-on-thp-pages.patch
* dax-fix-cache-flush-on-pmd-mapped-pages.patch
* mm-rmap-introduce-pfn_mkclean_range-to-cleans-ptes.patch
* mm-pvmw-add-support-for-walking-devmap-pages.patch
* dax-fix-missing-writeprotect-the-pte-entry.patch
* mm-simplify-follow_invalidate_pte.patch
* zram-add-a-huge_idle-writeback-mode.patch
* damon-vaddr-test-tweak-code-to-make-the-logic-clearer.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* ia64-fix-typos-in-comments.patch
* ia64-ptrace-fix-typos-in-comments.patch
* ia64-replace-comments-with-c99-initializers.patch
* ocfs2-replace-usage-of-found-with-dedicated-list-iterator-variable.patch
* ocfs2-remove-usage-of-list-iterator-variable-after-the-loop-body.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* proc-fix-dentry-inode-overinstantiating-under-proc-pid-net.patch
* proc-fix-dentry-inode-overinstantiating-under-proc-pid-net-checkpatch-fixes.patch
* proc-sysctl-make-protected_-world-readable.patch
* kernel-pid_namespace-use-null-instead-of-using-plain-integer-as-pointer.patch
* get_maintainer-honor-mailmap-for-in-file-emails.patch
* lib-test_meminit-optimize-do_kmem_cache_rcu_persistent-test.patch
* lib-kconfigdebug-remove-more-config__value-indirections.patch
* lib-test_stringc-add-strspn-and-strcspn-tests.patch
* lib-stringc-simplify-strspn.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* pipe-make-poll_usage-boolean-and-annotate-its-access.patch
* list-fix-a-data-race-around-ep-rdllist.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* fatfs-remove-redundant-judgment.patch
* rapidio-remove-unnecessary-use-of-list-iterator.patch
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-oom_killc-fix-vm_oom_kill_table-ifdeffery.patch
* selftests-vm-add-test-for-soft-dirty-pte-bit.patch
* kselftest-vm-override-targets-from-arguments.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  mutex-subsystem-synchro-test-module-fix.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
