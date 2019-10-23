Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A47E2007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbfJWP6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 11:58:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390259AbfJWP6u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:58:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7363DB4D8;
        Wed, 23 Oct 2019 15:58:48 +0000 (UTC)
Date:   Wed, 23 Oct 2019 17:58:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, Yong Sun <yosun@suse.com>
Subject: "New" ext4 features tests in LTP
Message-ID: <20191023155846.GA28604@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

we have in LTP some ext4 fs tests [1], which aimed to test at the time new ext4
features [2]. All of them are using The Flexible Filesystem Benchmark (ffsb)
- a filesystem performance measurement too [3]. Tests were contributed in 2009
and needs at least some cleanup.

I wonder whether testing these features is still relevant. And if yes, whether
they're covered in xfstests? After brief search in xfstests ext4 tests it
doesn't look like, at least not directly. Does it make sense to you to keep them?
(either to cleanup and keep them in LTP or rewrite and contribute to xfstests)

List of these tests [3]:
ext4-inode-version [4]
------------------
Directory containing the shell script which is used to test inode version field
on disk of ext4.

ext4-journal-checksum [5]
---------------------
Directory containing the shell script which is used to test journal checksumming
of ext4.

ext4-nsec-timestamps [6]
--------------------
Directory containing the shell script which is used to test nanosec timestamps
of ext4.

ext4-online-defrag [7]
------------------
Directory containing the shell script which is used to test online defrag
feature of ext4.

ext4-persist-prealloc [8]
---------------------
Directory containing the shell script which is used to test persist prealloc
feature of ext4.

ext4-subdir-limit [9]
-----------------
Directory containing the shell script which is used to test subdirectory limit
of ext4. According to the kernel documentation, we create more than 32000
subdirectorys on the ext4 filesystem.

ext4-uninit-groups [10]
------------------
Directory containing the shell script which is used to test uninitialized groups
feature of ext4.

Thanks for info.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/README
[2] http://ext4.wiki.kernel.org/index.php/New_ext4_features
[3] https://github.com/linux-test-project/ltp/blob/master/utils/ffsb-6.0-rc2/README
[4] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
[5] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
[6] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
[7] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
[8] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
[9] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
[10] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
