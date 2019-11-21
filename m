Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF21057C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKURBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:01:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKURBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:01:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGx9lI115164;
        Thu, 21 Nov 2019 17:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=smb47EpitmLlTtC+OH/ts2qiMK7UOBlf21eck/qRXMI=;
 b=RP671506JhO+tBWaMtppuirKwKGmuxP0rCG/loc5G4SBqwEOCONFfHgM6G+x5Z0/INtu
 PSdoh+KLNuhOE8s29ygtWao3zXDvAsgXehJiyU+g+lwPVHGx80defi65lCZuB2Y2xNIp
 v4d5doluGopkm+7g3xL4DjuASqW3MX8huVc9M4A5UmolUhvzA/2evPMJ4tMVc9wAw8e7
 VDLCyV/nHxOg4NqhNFqT4hGiW8+kC1KTbPtp+na6BF7Te/LveX2uouiGaek6pHdpSmPb
 zuYt/4F6ykAB0S5CaiDwOJsEP8Dky2GY8n0JvfsFvWPiVvWdL+WtlotaFNhRpefnAT8K lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8hu5p91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 17:01:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGx91u057259;
        Thu, 21 Nov 2019 17:01:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wd47xa5ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 17:01:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xALH18ir024843;
        Thu, 21 Nov 2019 17:01:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 09:01:08 -0800
Date:   Thu, 21 Nov 2019 09:01:07 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     andreas.gruenbacher@gmail.com
Cc:     xfs <linux-xfs@vger.kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH] generic: test splice() with pipes
Message-ID: <20191121170107.GM6211@magnolia>
References: <20190829161155.GA5360@magnolia>
 <20190830004407.GA5340@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830004407.GA5340@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:44:07PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Andreas Grünbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
> 
> This is a regression test to check for correct operation.
> 
> XXX Andreas: Since you wrote the C reproducer, can you send me the
> proper copyright and author attribution statement for the C program?

Ping?  Andreas, can I get the above info so I can get this moving again?

--D

> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  .gitignore            |    1 
>  src/Makefile          |    2 -
>  src/splice-test.c     |  173 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/720     |   41 ++++++++++++
>  tests/generic/720.out |    7 ++
>  tests/generic/group   |    1 
>  6 files changed, 224 insertions(+), 1 deletion(-)
>  create mode 100644 src/splice-test.c
>  create mode 100755 tests/generic/720
>  create mode 100644 tests/generic/720.out
> 
> diff --git a/.gitignore b/.gitignore
> index c8c815f9..26d4da11 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -112,6 +112,7 @@
>  /src/runas
>  /src/seek_copy_test
>  /src/seek_sanity_test
> +/src/splice-test
>  /src/stale_handle
>  /src/stat_test
>  /src/swapon
> diff --git a/src/Makefile b/src/Makefile
> index c4fcf370..2920dfb1 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -28,7 +28,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> -	fscrypt-crypt-util bulkstat_null_ocount
> +	fscrypt-crypt-util bulkstat_null_ocount splice-test
>  
>  SUBDIRS = log-writes perf
>  
> diff --git a/src/splice-test.c b/src/splice-test.c
> new file mode 100644
> index 00000000..d3c12075
> --- /dev/null
> +++ b/src/splice-test.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 ?????????????????????????????
> + * Author: 
> + *
> + * Make sure that reading and writing to a pipe via splice.
> + */
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <err.h>
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#define SECTOR_SIZE 512
> +#define BUFFER_SIZE (150 * SECTOR_SIZE)
> +
> +void read_from_pipe(int fd, const char *filename, size_t size)
> +{
> +	char buffer[SECTOR_SIZE];
> +	size_t sz;
> +	ssize_t ret;
> +
> +	while (size) {
> +		sz = size;
> +		if (sz > sizeof buffer)
> +			sz = sizeof buffer;
> +		ret = read(fd, buffer, sz);
> +		if (ret < 0)
> +			err(1, "read: %s", filename);
> +		if (ret == 0) {
> +			fprintf(stderr, "read: %s: unexpected EOF\n", filename);
> +			exit(1);
> +		}
> +		size -= sz;
> +	}
> +}
> +
> +void do_splice1(int fd, const char *filename, size_t size)
> +{
> +	bool retried = false;
> +	int pipefd[2];
> +
> +	if (pipe(pipefd) == -1)
> +		err(1, "pipe");
> +	while (size) {
> +		ssize_t spliced;
> +
> +		spliced = splice(fd, NULL, pipefd[1], NULL, size, SPLICE_F_MOVE);
> +		if (spliced == -1) {
> +			if (errno == EAGAIN && !retried) {
> +				retried = true;
> +				fprintf(stderr, "retrying splice\n");
> +				sleep(1);
> +				continue;
> +			}
> +			err(1, "splice");
> +		}
> +		read_from_pipe(pipefd[0], filename, spliced);
> +		size -= spliced;
> +	}
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +}
> +
> +void do_splice2(int fd, const char *filename, size_t size)
> +{
> +	bool retried = false;
> +	int pipefd[2];
> +	int pid;
> +
> +	if (pipe(pipefd) == -1)
> +		err(1, "pipe");
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		close(pipefd[1]);
> +		read_from_pipe(pipefd[0], filename, size);
> +		exit(0);
> +	} else {
> +		close(pipefd[0]);
> +		while (size) {
> +			ssize_t spliced;
> +
> +			spliced = splice(fd, NULL, pipefd[1], NULL, size, SPLICE_F_MOVE);
> +			if (spliced == -1) {
> +				if (errno == EAGAIN && !retried) {
> +					retried = true;
> +					fprintf(stderr, "retrying splice\n");
> +					sleep(1);
> +					continue;
> +				}
> +				err(1, "splice");
> +			}
> +			size -= spliced;
> +		}
> +		close(pipefd[1]);
> +		waitpid(pid, NULL, 0);
> +	}
> +}
> +
> +void usage(const char *argv0)
> +{
> +	fprintf(stderr, "USAGE: %s [-rd] {filename}\n", basename(argv0));
> +	exit(2);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	void (*do_splice)(int fd, const char *filename, size_t size);
> +	const char *filename;
> +	char *buffer;
> +	int opt, open_flags, fd;
> +	ssize_t ret;
> +
> +	do_splice = do_splice1;
> +	open_flags = O_CREAT | O_TRUNC | O_RDWR | O_DIRECT;
> +
> +	while ((opt = getopt(argc, argv, "rd")) != -1) {
> +		switch(opt) {
> +		case 'r':
> +			do_splice = do_splice2;
> +			break;
> +		case 'd':
> +			open_flags &= ~O_DIRECT;
> +			break;
> +		default:  /* '?' */
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		usage(argv[0]);
> +	filename = argv[optind];
> +
> +	printf("%s reader %s O_DIRECT\n",
> +		   do_splice == do_splice1 ? "sequential" : "concurrent",
> +		   (open_flags & O_DIRECT) ? "with" : "without");
> +
> +	buffer = aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> +	if (buffer == NULL)
> +		err(1, "aligned_alloc");
> +
> +	fd = open(filename, open_flags, 0666);
> +	if (fd == -1)
> +		err(1, "open: %s", filename);
> +
> +	memset(buffer, 'x', BUFFER_SIZE);
> +	ret = write(fd, buffer, BUFFER_SIZE);
> +	if (ret < 0)
> +		err(1, "write: %s", filename);
> +	if (ret != BUFFER_SIZE) {
> +		fprintf(stderr, "%s: short write\n", filename);
> +		exit(1);
> +	}
> +
> +	ret = lseek(fd, 0, SEEK_SET);
> +	if (ret != 0)
> +		err(1, "lseek: %s", filename);
> +
> +	do_splice(fd, filename, BUFFER_SIZE);
> +
> +	if (unlink(filename) == -1)
> +		err(1, "unlink: %s", filename);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/720 b/tests/generic/720
> new file mode 100755
> index 00000000..b7f09c40
> --- /dev/null
> +++ b/tests/generic/720
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test No. 720
> +#
> +# Test using splice() to read from pipes.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $TEST_DIR/a
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs generic
> +_require_test
> +
> +rm -f $seqres.full
> +
> +src/splice-test -r $TEST_DIR/a
> +src/splice-test -rd $TEST_DIR/a
> +src/splice-test $TEST_DIR/a
> +src/splice-test -d $TEST_DIR/a
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/720.out b/tests/generic/720.out
> new file mode 100644
> index 00000000..b0fc9935
> --- /dev/null
> +++ b/tests/generic/720.out
> @@ -0,0 +1,7 @@
> +QA output created by 720
> +concurrent reader with O_DIRECT
> +concurrent reader with O_DIRECT
> +concurrent reader without O_DIRECT
> +concurrent reader without O_DIRECT
> +sequential reader with O_DIRECT
> +sequential reader without O_DIRECT
> diff --git a/tests/generic/group b/tests/generic/group
> index cd418106..f75d4e60 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -569,3 +569,4 @@
>  564 auto quick copy_range
>  565 auto quick copy_range
>  719 auto quick quota metadata
> +720 auto quick rw pipe splice
