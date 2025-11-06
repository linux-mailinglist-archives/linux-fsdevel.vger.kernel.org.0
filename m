Return-Path: <linux-fsdevel+bounces-67379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C8FC3D700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00834E38DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FF301482;
	Thu,  6 Nov 2025 20:57:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A02FD68F
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462672; cv=none; b=c7sPUC92qGjPJrZ7SSvij1RsMMvOv9rayg6OkQlyYEo04BlfVh6GvTkM1lNl/WMexo7955epkoW0Tn+XwtC7qVxPdO13e85BLK3bY9zS+dQAvxfJd7qoc8qjCMajwWE38b4w8A4o38mJEZ4+MH7hocr4qzSMmhodIAaY72H3MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462672; c=relaxed/simple;
	bh=6GWdQZqDh6iLjFWGU83di6wYktBlWJE+2/B9aqABrK4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=rmxiYjWpMtDIVgjq7bSuvkvlcZqeuXytj9GIHW/ERXH8ncwgGf/3PGgZcNnWeSede/ohBqt1yTaw/N5x9yhzXuXZOky4nxDjw2SZcUMgkZ0z8OKWpGD+o0tp8SjQPc+L8SnmVCbJ5XvZJ3T4KDTebvya8E8sVgUeChX34E60j7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.101] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id H6kcvlDNYGd6lH6khv24LD; Thu, 06 Nov 2025 13:38:40 -0700
X-CMAE-Analysis: v=2.4 cv=Pu3KrwM3 c=1 sm=1 tr=0 ts=690d0750
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=FP58Ms26AAAA:8 a=8qvT9VI5aC9_x6Ad74oA:9
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
Feedback-ID: 5ec2995d04bbfe91082a90771fc28be7:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <39b4d88c-693d-4191-ae4b-9c547f8365ef@squashfs.org.uk>
Date: Thu, 6 Nov 2025 20:38:34 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [ANN] Squashfs-tools 4.7.3 released
To: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 news@phoronix.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLhAdYkjtkZheHH1v374K3N+4VwJN4S6mPpNb+/idl9xvUCK6/ARk/NtL1XqnTn4HGaS9WfCdNEMqcHZLNksdMwHLyx23kEUb20GJ7h7CVaLJ0tgx9gx
 6GdG7U9MlFeHjVJOGcPNLZ/oL/y61LT6xEabrIcBqNY84ZEMy4k7XnryvMSdoTSVtNqCM9HgHIjRgNqZFx9JfHTiZvq1vMPUXlRy98uQxcZgOYjShcfDa6Fk
 Jg/U66RlVwrd91oYRlcm3TG0ZMLAoZUxPKzhexJfrXY=

Hi,

I'm pleased to announce the release of Squashfs tools 4.7.3.

The release can be downloaded either from GitHub or Sourceforge.

https://github.com/plougher/squashfs-tools/releases/download/4.7.3/squashfs-tools-4.7.3.tar.gz

https://sourceforge.net/projects/squashfs/files/latest/download

This is the third update to the 4.7 release, and it has some nice
improvements in addition to the improvements in the major 4.7 release
earlier this year.  Filesystems can now be streamed to STDOUT, sparse
file reading has been optimised, there is a new Align() action and the
documentation is now formatted in Github markdown which makes it easier
to read and navigate.

A summary of the changes is below.  Please see the README.md file in
the release tarball for more information.  The README.md can also be
read here

https://github.com/plougher/squashfs-tools/blob/master/Documentation/4.7.3/README.md

Thanks

Phillip

Summary of changes
------------------

1. Mksquashfs/Sqfstar can now stream output filesystem to STDOUT.

    1.1. New -stream option which directs filesystem to STDOUT.  This can be used
	to send the output of Mksquashfs to another computer via ssh, where
	there isn't enough disk space on the host computer.
    1.2. New -fix option to fix-up the streamed filesystem.  The streamed
	filesystem will have the super-block written to the end of the
	filesystem.  The -fix option writes the super-block to the usual start
	of the filesystem.
    1.3. Unsquashfs has been extended to recognise a streamed filesystem with the
	super-block at the end.

2. Reading of sparse files has been optimised

    2.1. If the filesystem supports the SEEK_DATA lseek operation, this is used
	to skip holes when reading sparse files.  This can produce a 240 times
	speed improvement.
    2.2. Holes which are multiple Squashfs data blocks in size are now handled
	as large multi-block sparse regions, which further speed up sparse file
	handling.  This can produce a six times speed improvement (in total 1500
	times).

3. New Align(value) action, which will align file to <value>

    3.1. Any file which matches test operator(s) will be aligned to <value> byte
	boundary, where <value> is a pure power of two and 64 Megabytes or less.
    3.2. Any file which has an alignment applied will be separately compressed
	and not packed into a fragment block.

4. Squashfs tools documentation has been formatted in GitHub markdown

    4.1. New CHANGES.md changelog file
    4.2. New 4.7.3 README.md
    4.3. New USAGE.md, USAGE-MKSQUASHFS.md, USAGE-UNSQUASHFS.md, USAGE-SQFSTAR.md
	and USAGE-SQFSCAT.md


