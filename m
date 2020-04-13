Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07DD1A69FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgDMQaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:30:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbgDMQan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:30:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGScpt053507;
        Mon, 13 Apr 2020 16:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+lCPxqLW3zLzVwISE9Gl/6KfsNEUm+EJ5wdSF8pmbso=;
 b=zJPj2u2u56DiIYGpHm1joppYLyFpE+gEscz8lXfYb9V+tfIk+LOLEBzk9RmxuoVHkXug
 Br1TGFggyVk+8x/SrLSVKC5sjRhYMO9E1F7hygIlZbqOkrrIDuo9zIvb6l13NBnC2n7m
 9Xq4x++mBtN6X5AcHHAdsNjsF4yfitIn+R9av8OQkT+mBAOMkBqMNseVzLi9eycsX6D4
 w7vOC4mPI8ebY3m3uyddBUWheLbvpAguIZ78ZFL8jMYftUUao0i0ZJKH2ey5K2yeFF+w
 bqYd1uN7JTzGb8EOTCcnTVTusgejy+EeuqT8BL72rx6z0T4Ix72EbeKIo9wFL3g6+fNw FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30b5aqyj6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:30:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGRuG2004910;
        Mon, 13 Apr 2020 16:30:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30bqpcfh4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:30:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DGURtq016930;
        Mon, 13 Apr 2020 16:30:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:30:27 -0700
Date:   Mon, 13 Apr 2020 09:30:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     fstests@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
Message-ID: <20200413163025.GB6742@magnolia>
References: <20200413054419.1560503-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054419.1560503-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:44:19PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add XXX to test per file DAX operations.
> 
> The following is tested[*]
> 
>  1. There exists an in-kernel access mode flag S_DAX that is set when
>     file accesses go directly to persistent memory, bypassing the page
>     cache.  Applications must call statx to discover the current S_DAX
>     state (STATX_ATTR_DAX).
> 
>  2. There exists an advisory file inode flag FS_XFLAG_DAX that is
>     inherited from the parent directory FS_XFLAG_DAX inode flag at file
>     creation time.  This advisory flag can be set or cleared at any
>     time, but doing so does not immediately affect the S_DAX state.
> 
>     Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
>     and the fs is on pmem then it will enable S_DAX at inode load time;
>     if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> 
>  3. There exists a dax= mount option.
> 
>     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> 
>     "-o dax=always" means "always set S_DAX (at least on pmem),
>                     and ignore FS_XFLAG_DAX."
> 
>     "-o dax"        is an alias for "dax=always".
> 
>     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> 
>  4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
>     be set or cleared at any time.  The flag state is copied into any
>     files or subdirectories when they are created within that directory.
> 
>  5. Programs that require a specific file access mode (DAX or not DAX)
>     can do one of the following:
> 
>     (a) Create files in directories that the FS_XFLAG_DAX flag set as
>         needed; or
> 
>     (b) Have the administrator set an override via mount option; or
> 
>     (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
>         must then cause the kernel to evict the inode from memory.  This
>         can be done by:
> 
>         i>  Closing the file and re-opening the file and using statx to
>             see if the fs has changed the S_DAX flag; and
> 
>         ii> If the file still does not have the desired S_DAX access
>             mode, either unmount and remount the filesystem, or close
>             the file and use drop_caches.
> 
>  6. It's not unreasonable that users who want to squeeze every last bit
>     of performance out of the particular rough and tumble bits of their
>     storage also be exposed to the difficulties of what happens when the
>     operating system can't totally virtualize those hardware
>     capabilities.  Your high performance sports car is not a Toyota
>     minivan, as it were.
> 
> [*] https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v6 (kernel patch set):
> 	Start versions tracking the kernel patch set.
> 	Update for new requirements
> 
> Changes from V1 (xfstests patch):
> 	Add test to ensure moved files preserve their flag
> 	Check chattr of non-dax flags (check bug found by Darrick)
> ---
>  tests/xfs/999     | 272 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |  22 ++++
>  tests/xfs/group   |   1 +
>  3 files changed, 295 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 000000000000..3ca04b98c517
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,272 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
> +#
> +# FSQA Test No. 999 (temporary)
> +#
> +# Test setting of DAX flag
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!
> +
> +dax_dir=$TEST_DIR/dax-dir
> +dax_sub_dir=$TEST_DIR/dax-dir/dax-sub-dir
> +dax_inh_file=$dax_dir/dax-inh-file
> +dax_non_inh_file=$dax_dir/dax-non-inh-file
> +non_dax=$TEST_DIR/non-dax
> +dax_file=$TEST_DIR/dax-dir/dax-file
> +dax_file_copy=$TEST_DIR/dax-file-copy
> +dax_file_move=$TEST_DIR/dax-file-move
> +data_file=$TEST_DIR/non-dax-dir/data-file
> +
> +_cleanup() {
> +	rm -rf $TEST_DIR/*
> +}
> +
> +trap "_cleanup ; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_xfs_io_command "lsattr"
> +_require_xfs_io_command "statx"
> +_require_test

This might be a good time to introduce a few new helpers:

_require_scratch_dax ("Does $SCRATCH_DEV support DAX?")
_require_scratch_dax_mountopt ("Does the fs support the DAX mount options?")
_require_scratch_daX_iflag ("Does the fs support FS_XFLAG_DAX?")

Also, I think this should be split into two tests.  One test to check
the correct operation of FS_XFLAG_DAX, because the flag has behaviors
that always apply even if the test/scratch devices are not pmem; and a
second test to check the S_DAX operation if the system under test
actually has pmem.

> +
> +#
> +# mnt_opt's we expect
> +# ''
> +# '-o dax=off'
> +# '-o dax=inode'
> +# '-o dax'
> +# '-o dax=always'
> +function remount_w_option {
> +	mnt_opt=$1
> +	export MOUNT_OPTIONS=""
> +	export TEST_FS_MOUNT_OPTS=""
> +	_test_unmount &> /dev/null
> +	_test_mount $mnt_opt &> /dev/null
> +}
> +
> +function check_dax_mount_option {
> +	mnt_opt=$1
> +	_fs_options $TEST_DEV | grep -qw '$mnt_opt'
> +	if [ "$?" == "0" ]; then
> +		echo "FAILED: to mount FS with option '$mnt_opt'"
> +	fi
> +}
> +
> +function check_xflag_dax {
> +	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null

s/xfs_io/$XFS_IO_PROG/g

> +	if [ "$?" != "0" ]; then
> +		echo "FAILED: Did NOT find FS_XFLAG_DAX on $1"
> +	fi
> +}
> +
> +function check_s_dax {
> +	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`

Also, the statx bits mean this test needs:

_require_xfs_io_command statx -r

So that we skip the test on old userspace.

--D

> +	masked=$(( $attr & 0x2000 ))
> +	if [ "$masked" != "8192" ]; then
> +		echo "FAILED: Did NOT find S_DAX flag on $1"
> +	fi
> +}
> +
> +function check_no_xflag_dax {
> +	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
> +	if [ "$?" == "0" ]; then
> +		echo "FAILED: Found FS_XFLAG_DAX on $1"
> +	fi
> +}
> +
> +function check_no_s_dax {
> +	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
> +	masked=$(( $attr & 0x2000 ))
> +	if [ "$masked" == "8192" ]; then
> +		echo "FAILED: Found S_DAX flag on $1"
> +	fi
> +}
> +
> +echo "running tests..."
> +
> +remount_w_option ""
> +check_dax_mount_option "dax=inode"
> +
> +echo "   *** mark dax-dir as dax enabled"
> +mkdir $dax_dir
> +xfs_io -c 'chattr +x' $dax_dir
> +check_xflag_dax $dax_dir
> +
> +echo "   *** check file inheritance"
> +touch $dax_inh_file
> +check_xflag_dax $dax_inh_file
> +check_s_dax $dax_inh_file
> +
> +echo "   *** check directory inheritance"
> +mkdir $dax_sub_dir
> +check_xflag_dax $dax_sub_dir
> +
> +echo "   *** check changing directory"
> +xfs_io -c 'chattr -x' $dax_dir
> +check_no_xflag_dax $dax_dir
> +check_no_s_dax $dax_dir
> +
> +echo "   *** check non file inheritance"
> +touch $dax_non_inh_file
> +check_no_xflag_dax $dax_non_inh_file
> +check_no_s_dax $dax_non_inh_file
> +
> +echo "   *** check that previous file stays enabled"
> +check_xflag_dax $dax_inh_file
> +check_s_dax $dax_inh_file
> +
> +echo "   *** Reset the directory"
> +xfs_io -c 'chattr +x' $dax_dir
> +check_xflag_dax $dax_dir
> +
> +# Set up for next test
> +touch $dax_file
> +touch $non_dax
> +
> +#
> +#                      inode flag
> +# ./
> +#   + dax-dir/             X
> +#     + dax-sub-dir/       X
> +#     + dax-inh-file       X
> +#     + dax-non-inh-file
> +#     + dax-file           X
> +#   + non-dax
> +#
> +
> +# check mount overrides
> +# =====================
> +
> +echo "   *** Check '-o dax'"
> +remount_w_option "-o dax"
> +check_dax_mount_option "dax=always"
> +
> +echo "   *** non-dax inode but overrides to be effective"
> +check_no_xflag_dax $non_dax
> +check_s_dax $non_dax
> +
> +echo "   *** Check for non-dax inode to be dax with mount option"
> +check_no_xflag_dax $dax_non_inh_file
> +check_s_dax $dax_non_inh_file
> +
> +
> +echo "   *** Check '-o dax=never'"
> +remount_w_option "-o dax=never"
> +check_dax_mount_option "dax=never"
> +
> +check_xflag_dax $dax_dir
> +check_xflag_dax $dax_sub_dir
> +check_xflag_dax $dax_inh_file
> +check_no_s_dax $dax_inh_file
> +check_no_xflag_dax $dax_non_inh_file
> +check_no_s_dax $dax_non_inh_file
> +check_no_xflag_dax $non_dax
> +check_no_s_dax $non_dax
> +check_xflag_dax $dax_file
> +check_no_s_dax $dax_file
> +
> +
> +echo "   *** Check '-o dax=inode'"
> +remount_w_option "-o dax=inode"
> +check_dax_mount_option "dax=inode"
> +
> +check_xflag_dax $dax_dir
> +check_xflag_dax $dax_sub_dir
> +check_xflag_dax $dax_inh_file
> +check_s_dax $dax_inh_file
> +check_no_xflag_dax $dax_non_inh_file
> +check_no_s_dax $dax_non_inh_file
> +check_no_xflag_dax $non_dax
> +check_no_s_dax $non_dax
> +check_xflag_dax $dax_file
> +check_s_dax $dax_file
> +
> +
> +# Check non-zero file operations
> +# ==============================
> +
> +echo "   *** Verify changing FS_XFLAG_DAX flag"
> +
> +mkdir $TEST_DIR/non-dax-dir
> +$here/ltp/fsx $options -N 20000 $data_file > $tmp.log 2>&1 &
> +pid=$!
> +check_no_xflag_dax $data_file
> +check_no_s_dax $data_file
> +
> +if [ ! -n "$pid" ]; then
> +	echo "FAILED to start fsx"
> +else
> +	# toggle inode flag back and forth.
> +	# s_dax should not change while fsx is using file.
> +	xfs_io -c 'chattr +x' $data_file &> /dev/null
> +	check_xflag_dax $data_file
> +	check_no_s_dax $data_file
> +	xfs_io -c 'chattr -x' $data_file &> /dev/null
> +	check_no_xflag_dax $data_file
> +	check_no_s_dax $data_file
> +	xfs_io -c 'chattr +x' $data_file &> /dev/null
> +	check_xflag_dax $data_file
> +	check_no_s_dax $data_file
> +fi
> +
> +wait $pid
> +status=$?
> +if [ "$status" != "0" ]; then
> +	echo "FAILED: fsx exited with status : $status"
> +	head $dax_file.fsxlog
> +fi
> +pid=""
> +
> +echo 2 > /proc/sys/vm/drop_caches
> +
> +echo "   *** Verify S_DAX change on drop_caches"
> +# s_dax should change after drop_caches
> +check_xflag_dax $data_file
> +check_s_dax $data_file
> +
> +
> +# Check inheritance on cp, mv
> +# ===========================
> +
> +echo "   *** check making 'data' dax with cp"
> +cp $non_dax $dax_dir/conv-dax
> +check_xflag_dax $dax_dir/conv-dax
> +check_s_dax $dax_dir/conv-dax
> +
> +echo "   *** check making 'data' non-dax with cp"
> +rm -f $data_file
> +cp $dax_dir/conv-dax $data_file
> +check_no_xflag_dax $data_file
> +check_no_s_dax $data_file
> +
> +echo "   *** Moved files 'don't inherit'"
> +mv $non_dax $dax_dir/move-dax
> +check_no_xflag_dax $dax_dir/move-dax
> +check_no_s_dax $dax_dir/move-dax
> +
> +echo "   *** Moved files preserve their flag"
> +mv $dax_file $TEST_DIR/move-dax
> +check_xflag_dax $TEST_DIR/move-dax
> +check_s_dax $TEST_DIR/move-dax
> +
> +echo "   *** Check file chattr of non-dax flags"
> +xfs_io -c 'chattr +s' $dax_inh_file
> +xfs_io -c 'chattr -s' $dax_inh_file
> +
> +echo "   *** Check '-o dax=garbage'"
> +remount_w_option "-o dax=garbage"
> +_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR
> +if [ "$?" == "0" ]; then
> +	echo "ERROR: fs mounted with '-o dax=garbage'"
> +fi
> +
> +status=0 ; exit
> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> new file mode 100644
> index 000000000000..3a4f970a5073
> --- /dev/null
> +++ b/tests/xfs/999.out
> @@ -0,0 +1,22 @@
> +QA output created by 999
> +running tests...
> +   *** mark dax-dir as dax enabled
> +   *** check file inheritance
> +   *** check directory inheritance
> +   *** check changing directory
> +   *** check non file inheritance
> +   *** check that previous file stays enabled
> +   *** Reset the directory
> +   *** Check '-o dax'
> +   *** non-dax inode but overrides to be effective
> +   *** Check for non-dax inode to be dax with mount option
> +   *** Check '-o dax=never'
> +   *** Check '-o dax=inode'
> +   *** Verify changing FS_XFLAG_DAX flag
> +   *** Verify S_DAX change on drop_caches
> +   *** check making 'data' dax with cp
> +   *** check making 'data' non-dax with cp
> +   *** Moved files 'don't inherit'
> +   *** Moved files preserve their flag
> +   *** Check file chattr of non-dax flags
> +   *** Check '-o dax=garbage'
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 522d4bc44d1f..816883a268bf 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -511,3 +511,4 @@
>  511 auto quick quota
>  512 auto quick acl attr
>  513 auto mount
> +999 auto
> -- 
> 2.25.1
> 
