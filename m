Return-Path: <linux-fsdevel+bounces-50531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6523ACCFEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F69188F1E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E3253954;
	Tue,  3 Jun 2025 22:35:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CCC24A07C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990115; cv=none; b=V6KrYuo1x9UOJkUToMWM5fS9wJSg0LmD+chmi4lqF68d/SPWW4Fhpxwm2HYeQc3VNTJ2cpaY/CgpjqPryX+X4Z+QfpeZTt2QNU+1lACcXppV2SF5i/Zwib3ghVW9BDC4pP4UfrT2HLBNtPIc0eVlYX9EUCg7kjuMzLOxfdLd90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990115; c=relaxed/simple;
	bh=7ngBQjX9Q91ssI5lebIYGFFeYZ2yHNUu6b3oaCH742s=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=rMVrka0nhXm0NmHWQHpuP9wpXLnMPDEkdhskWOQYA2sIHi4rfwSNZc8BZSYl9YXZKQU4VlMLvGeJvvmI0prDi0BLnrbVq1CSg1yE23kPR8pVi8iMamnwcc0AmeYX8Ra5DdbiIqtkSYlcpkpjlw9FnjtCOkjxy9nTkLuhpnCn6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id MZvJuGVfW9ZMtMZvLuFZ3Y; Tue, 03 Jun 2025 15:16:00 -0700
X-CMAE-Analysis: v=2.4 cv=b66y4sGx c=1 sm=1 tr=0 ts=683f7421
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FP58Ms26AAAA:8 a=NEAV23lmAAAA:8 a=ib7_shvKizCky_gvI0gA:9
 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <2d23004d-862d-44c4-814b-3a7f453a4448@squashfs.org.uk>
Date: Tue, 3 Jun 2025 23:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 news@phoronix.com
Subject: [ANN] Squashfs-tools 4.7 released
Cc: phillip.lougher@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBanUkbAAABwj8+bRKvywtzLQ7zm35FWJ9r0768jwJuVQlMozUCnOdmXs10uDPhLFlYTSKHfC30RhNW32RcFMzGO2htduwZzg1uazGh3UqhvMZ6lFcPH
 pBG4S96l/77wx45ZPZn9mWRNbPq/9nvq6ENKsT50d3rp2pIk238y1acqlxSlKfOSlSruKV3Qw2wlkxQsWG8p05vtWHY9XD+iH1NOXh76wtSjSSUzE/oTKojX
 wIIPoxOcLJbAsD1qTepZsuuAo5u3bIJesE5+8vDu+2D1kYybToMHCuixJ+FzGjPl/Un/vIAY+Fhnxr1e54a1HA==

Hi,

I'm pleased to announce the release of Squashfs tools 4.7.

The release can be downloaded either from Sourceforge, or GitHub.

https://sourceforge.net/projects/squashfs/files/latest/download

https://github.com/plougher/squashfs-tools/archive/refs/tags/4.7.tar.gz

There are substantial improvements to the tools in this release, in
particular Mksquashfs can now be 20% to more than ten times faster
(dependant on source media and input files).  The help system has also
been completely rewritten and improved for Mksquashfs/Unsquashfs/
Sqfstar/Sqfscat.  There are also new options for building reproducible
images, and a lot of other improvements.

A summary of the changes is below.  Please see the README file in
the release tarball for more information.  The README can also be
read here

https://github.com/plougher/squashfs-tools/blob/master/Documentation/4.7/README

Thanks

Phillip

Summary of changes
------------------

1. Mksquashfs now reads files in parallel from the input directories

    1.1. This can significantly increase I/O when reading lots of small files,
         and/or the input media benefits from parallel reading e.g. modern SSD
         drives, or network filesystems etc.
    1.2  In cases where speed of I/O is the bottleneck in Mksquashfs, this can
         make Mksquashfs run significantly faster, in some cases Mksquashfs can
         be more than ten times faster.
    1.3. New -small-readers option to specify number of parallel small file
         reader threads (files less than a block size).  Default 4 threads.
    1.4. New -block-readers option to specify number of parallel block reader
         threads (files one block or larger).  Default 4 threads.
    1.5. New -single-reader option to specify a single reader thread, similar to
         previous Mksquashfs versions.

2. Rewritten and improved help system (Mksquashfs/Unsquashfs/Sqfstar/Sqfscat)

    2.1. Help text now uses the full width of the terminal (rather than being
         pre-formatted to 80 columns).
    2.2. The help text is now automatically paged (using pager, less or more).
    2.3. The tools now print a summary on failure to parse the command line (or
         encountering other errors that prevent the tool from running), rather
         than displaying the help text.
    2.4. The help text can be displayed in full, by section, or by option using
         regex matching.
    2.5. New -help-all option to display all help text
    2.6. New -help-section option to display help for a particular section
    2.7. New -help-option to display all options matching regex.
    2.8. New -help-comp option to display compressor options for given
         compressor.

3. New options for building reproducible filesystems (Mksquash/Sqfstar)

   3.1 Low level timestamp setting options extended
      -mkfs-time inode sets the fs creation time to the latest inode timestamp
      -inode-time inode sets all inode timestamps to the latest inode timestamp
      -root-time inode sets the root dir timestamp to the latest inode timestamp

   3.2 New easier to remember shorthand options
      -repro builds a reproducible fs image, it is shorthand for -mkfs-time inode
      -repro-time <time> builds a reproducible fs image, it is shorthand for
       specifying -mkfs-time <time> and -inode-time <time>.

4. Elimination of "fragment block stall" and -(not-)reproducible options

   A technical issue called "the fragment block stall" has been eliminated in
   this release in a way that generates a reproducible ordering of files in the
   filesystem image.  This can increase performance by 20% or more, in addition
   to the parallel reader performance improvements.

   This "fragment block stall" was introduced in release 4.4 (2019) to produce
   a reproducible ordering of files in the filesystem image, but which led to a
   reduction in parallelisation and performance.  Due to this reduction, the
   previous behaviour was retained and enabled using the -not-reproducible option.
   As the "fragment block stall" has now been removed, the options
   -not-reproducible and -reproducible now do nothing, but are still recognised
   for backwards compatibility.

5. Other improvements for Mksquashfs/Sqfstar

    3.1. New -force-file-mode option, which sets all file (non-directory)
         permissions to the given mode.
    3.2. New -force-dir-mode option, which sets all directory permissions to
         the given mode.
    3.3. -root-mode and above new -force-file-mode/-force-dir-mode options
         now take a symbolic mode in addition to an octal mode.
    3.4. New -info-file option, which prints files written to the filesystem to
         a file rather than stdout.  Allows -info-file to be used in conjunction
         with the progress bar.
    3.5. New -pseudo-dir (or -pd) option which supplies a default directory
         if any directories in a pseudo file definition pathname doesn't exist.
    3.6. New pseudo file 'h' definition which creates a hard link to a file,
         and follows symbolic links.
    3.7. Previously if a directory was missing (or not a directory) in a
         Pseudo file definition pathname, the pseudo file definition would be
         ignored.  This has been hardened to a fatal error.

6. Other improvements for Unsquashfs/Sqfscat

    4.1. New -mem option, which sets the amount of memory to be used,
         K, M and G can be used to specify Kbytes, Mbytes and Gbytes.
    4.2. New -mem-percent option, which sets the amount of memory to be
         used as percentage of available physical memory.
    4.3. Memory specified is limited to 75% of physical memory or less.

7. New environment variable SQFS_CMDLINE (Mksquashfs/Unsquashfs/Sqfstar/Sqfscat)

    If set, this is used as the directory to write the file sqfs_cmdline
    which contains the command line arguments given to Mksquashfs etc.  Intended
    to be used to debug scripts/discover what is being passed to Mksquashfs.

