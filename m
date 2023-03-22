Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F36C4227
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 06:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCVFYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCVFYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:24:30 -0400
X-Greylist: delayed 218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 22:23:58 PDT
Received: from p3plwbeout18-03.prod.phx3.secureserver.net (p3plsmtp18-03-2.prod.phx3.secureserver.net [173.201.193.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C92D15C
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 22:23:58 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id eqtXp0r6cqG36eqtXpCYIz; Tue, 21 Mar 2023 22:20:20 -0700
X-CMAE-Analysis: v=2.4 cv=csVeL30i c=1 sm=1 tr=0 ts=641a9014
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=k__wU0fu6RkA:10 a=FP58Ms26AAAA:8 a=NEAV23lmAAAA:8
 a=dnHKQ0aXFSJ-3baA9N4A:9 a=jGIlq7wQ_eTbAL2R:21
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  eqtXp0r6cqG36
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1peqtW-0004WB-LA; Wed, 22 Mar 2023 05:20:19 +0000
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net
Cc:     phillip@squashfs.org.uk
Subject: [ANN] Squashfs-tools 4.6 released
Date:   Wed, 22 Mar 2023 05:26:15 +0000
Message-Id: <20230322052615.28048-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfKhpO4QD0b9vlYESM0WPR/W2B2zY/Ft11vkO+MWtkuPmPo4j4w5ZkWZDCnjCoNPpMLaQGDwTt2lTUB6wmMwNqk4IwrRWKwjrJ0VVh8+dkjgvQL0cy3pZ
 ncieL2zPkpIFtBAPJ+ZLruMWNGjLs30rndJ8pcIA1xd6GpMDlVUbUJwA+hFajsN5S+d8EtvgSWyCI7XCZsqhnPQK3SIm47msNNODMR/CulUo3IhVvLlH+rPh
 SqhRMvSRQaNkHlgkTN9nfA==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm pleased to announce the release of Squashfs tools 4.6.

The release can be downloaded either from Sourceforge, or GitHub.

https://sourceforge.net/projects/squashfs/files/latest/download

https://github.com/plougher/squashfs-tools/archive/refs/tags/4.6.tar.gz

A summary of the changes is below.  Please see the README-4.6 file in
the release tarball for more information and the USAGE files.

Phillip

1. Summary of changes
---------------------

1. Extended attribute handling improved in Mksquashfs and Sqfstar

	1.1.New -xattrs-exclude option to exclude extended attributes from files
	    using a regular expression.
	1.2 New -xattrs-include option to include extended attributes from files
	    using a regular expression.
	1.3 New -xattrs-add option to add extended attributes to files.
	1.4 New Pseudo file xattr definition to add extended attributes to
	    files.
	1.5 New xattrs-add Action to add extended attributes to files
	    (Mksquashfs only).

2. Extended attribute handling improved in Unsquashfs

	2.1 New -xattrs-exclude option to exclude extended attributes from files
	    using a regular expression.
	2.2 New -xattrs-include option to include extended attributes from files
	     using a regular expression.
	2.3 Extended attributes are now supported in Pseudo file output.

3. Other major improvements

	3.1 Unsquashfs can now output Pseudo files to standard out.
	3.2 Mksquashfs can now input Pseudo files from standard in.
	3.3 Squashfs filesystems can now be converted (different block size
	    compression etc) without unpacking to an intermediate filesystem or
	    mounting, by piping the output of Unsquashfs to Mksquashfs.
	3.4 Pseudo files are now supported by Sqfstar.
	3.5 "Non-anchored" excludes are now supported by Unsquashfs.

4. Mksquashfs minor improvements

	4.1 A new -max-depth option has been added, which limits the depth
	    Mksquashfs descends when creating the filesystem.
	4.2 A new -mem-percent option which allows memory for caches to be
	    specified as a percentage of physical RAM, rather than requiring an
	    absolute value.
	4.3 A new -percentage option added which rather than generating the full
	    progress-bar instead outputs a percentage.  This can be used with
	    dialog --gauge etc.
	4.4 -mkfs-time, -all-time and -root-time options now take a human date
	    string, in addition to the seconds since the epoch of 1970 00:00
	    UTC.  For example "now", "last week", "Wed Mar 8 05:55:01 GMT 2023"
	    are supported.
	4.5 -root-uid, -root-gid, -force-uid and -force-gid options now take a
	    user/group name in addition to the integer uid/gid.
	4.6 A new -mem-default option which displays default memory usage for
	    caches in Mbytes.
	4.7 A new -no-compression option which produces no compression, and it
	    is a short-cut for -noI, -noD, -noF and -noX.
	4.8 A new -pseudo-override option which makes pseudo file uids and gids
	    override -all-root, -force-uid and -force-gid options.  Normally
	    these options take precedence.

5. Unsquashfs minor improvements

	5.1 New -all-time option which sets all file timestamps to <time>,
	    rather than the time stored in the filesystem inode.  <time> can be
	    an integer indicating seconds since the epoch (1970-01-01) or a
	    human string value such as "now", "last week", or
	    "Wed Feb 15 21:02:39 GMT 2023".
	5.2 New -full-precision option which uses full precision when displaying
	    times including seconds.  Use with -linfo, -lls, -lln and -llc
	    options.
	5.3 New -match option where Unsquashfs will abort if any extract file
	    does not match on anything, and can not be resolved.
	5.4 New -percentage option added which rather than generating the full
	    progress-bar instead outputs a percentage.  This can be used with
	    dialog --gauge etc.

6. Sqfstar minor improvements

	6.1 New -ignore-zeros option added which allows tar files to be
	    concatenated together and fed to Sqfstar.  Normally a tarfile has
	    two consecutive 512 byte blocks filled with zeros which means EOF
	    and Sqfstar will stop reading after the first tar file on
	    encountering them. This option makes Sqfstar ignore the zero filled
	    blocks.
	6.2 A new -mem-percent option which allows memory for caches to be
	    specified as a percentage of physical RAM, rather than requiring an
	    absolute value.
	6.3 A new -percentage option added which rather than generating the full
	    progress-bar instead outputs a percentage.  This can be used with
	    dialog --gauge etc.
	6.4 -mkfs-time, -all-time and -root-time options now take a human date
	     string, in addition to the seconds since the epoch of 1970 00:00
	     UTC.  For example "now", "last week", "Wed Mar 8 05:55:01 GMT 2023"
	     are supported.
	6.5 -root-uid, -root-gid, -force-uid and -force-gid options now take a
	     user/group name in addition to the integer uid/gid.
	6.6 A new -mem-default option which displays default memory usage for
	    caches in Mbytes.
	6.7 A new -no-compression option which produces no compression, and it
	    is a short-cut for -noI, -noD, -noF and -noX.
	6.8 A new -pseudo-override option which makes pseudo file uids and gids
	    override -all-root, -force-uid and -force-gid options.  Normally
	    these options take precedence.
	6.9 Do not abort if ZERO filled blocks indicating end of the TAR archive
	    are missing.

7. Other minor improvements

	7.1 If Mksquashfs/Unsquashfs fails to execute generating the manpages
	    because they have been cross-compiled, fall back to using the
	    pre-built manpages.
	7.2 Add new Makefile configure option USE_PREBUILT_MANPAGES to always
	    use pre-built manpages rather than generating them when "make
	    install" is run.

8. Major bug fixes

	8.1 Following a symlink in Sqfscat or where -follow-symlinks option is
	    given with Unsquashfs, incorrectly triggered the corrupted
	    filesystem loop detection code.
	8.2 In Unsquashfs if a file was not writable it could not add extended
	    attributes to it.
	8.3 Sqfstar would incorrectly reject compressor specific options that
	    have an argument.
	8.4 Sqfstar would incorrectly strip pathname components in PAX header
	    linkpath if symbolic.
	8.5 Sqfstar -root-uid, -root-gid and -root-time options were documented
	    but not implemented.
	8.6 Mksquashfs -one-file-system option would not create empty mount
	    point directory when filesystem boundary crossed.
	8.7 Mksquashfs did not check the close() return result.
