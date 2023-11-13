Return-Path: <linux-fsdevel+bounces-2802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68B7EA28A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 19:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FADE1F221D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950A22EF7;
	Mon, 13 Nov 2023 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtzLPZrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF72231F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 18:06:20 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E12F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 10:06:19 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d122e0c85so28035336d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898778; x=1700503578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OOyP4HGPLZfbscvLdPNJ6jUz6uuQNDl4ThZcDvNOS8=;
        b=HtzLPZrW0+BGEZi/EvR4Pm1dgNR3HCLtW6PgxIuvEmdAndIOjUBS7R7c1HoagMZFuV
         7R6HAK7thTZlU7i6oGporFBgrvKEL5auEMhi9tCGEXv49rG4iCBuOO8xZTo3KJEY/BLy
         p+Rz5wPrtGvjN98yPSG5TMeIDZbpzTDNEE+aVptAYiMIJFUUy/ACdIhsCpJ8YlrIdx6c
         kyY1KVRhfdqVWYZzsYKVdL8lIzjAOT9ciOAimZXZuTEVpFLIMIakipx0ZbsMoppa7lgs
         tw3OFcVjBCtTRbqiz+FKVAVq2/Gio/pu4SvE4j9dAEQxCPVWB/Xhz8Eq7v5RaJ0NDKev
         IoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898778; x=1700503578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OOyP4HGPLZfbscvLdPNJ6jUz6uuQNDl4ThZcDvNOS8=;
        b=Ff48RHoQUPp0napSa/OgCsRLm26rDvHVIZhaLJLQfi+CfHgG/1ELCl58jX9EH02Syz
         yzXnxjB/0mxIv0urrwJbMuCh1SctVdXFIMd0Rmv3ybmZZzgC0sZbsr1xbxkuRprMNzXg
         64fJNAzAaoeXi7tcrHp3V4DRkOt+Ef9g0PRxXXxDfz9LsZJ1Z940Ssq5bVvf5MvEI+jg
         FopuVgfB2TZ1NkBlkrSX7oTHDXwiKhA0//WlGh5hbo5a84Om/30Cy7FKfdcCV/5Vwhfx
         iXVFbDdOC1KWrwMYwABlM+Lr5RCckiMwe6BZlMRY4Fm39aHmo0QSOeJMbzIM3n5DOHHH
         Xa/Q==
X-Gm-Message-State: AOJu0YzJh1OsIgrKuSR9Np023f49ICBX6ZerHYQrVFLA0JLUXcByHrlt
	PBiHAoLfsICfnMXm0TE9gSU=
X-Google-Smtp-Source: AGHT+IGyVixjN9yp5Q58U8VgP3g0g7Cg7z/i8NGIgxfDOgeqX/rZ1TiPXlCinQz6mKjM/ez8c0bOCg==
X-Received: by 2002:a05:6214:a48:b0:675:b8ee:e3a1 with SMTP id ee8-20020a0562140a4800b00675b8eee3a1mr6782113qvb.7.1699898778295;
        Mon, 13 Nov 2023 10:06:18 -0800 (PST)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id jy20-20020a0562142b5400b00671ab3da5d0sm2197928qvb.105.2023.11.13.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:06:18 -0800 (PST)
Sender: Tavian Barnes <tavianator@gmail.com>
From: tavianator@tavianator.com
To: cel@kernel.org
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	hughd@google.com,
	jlayton@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Date: Mon, 13 Nov 2023 13:06:16 -0500
Message-ID: <20231113180616.2831430-1-tavianator@tavianator.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <168814734331.530310.3911190551060453102.stgit@manet.1015granger.net>
References: <168814734331.530310.3911190551060453102.stgit@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 30 Jun 2023 at 13:49:03 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> The current cursor-based directory offset mechanism doesn't work
> when a tmpfs filesystem is exported via NFS. This is because NFS
> clients do not open directories. Each server-side READDIR operation
> has to open the directory, read it, then close it. The cursor state
> for that directory, being associated strictly with the opened
> struct file, is thus discarded after each NFS READDIR operation.
>
> Directory offsets are cached not only by NFS clients, but also by
> user space libraries on those clients. Essentially there is no way
> to invalidate those caches when directory offsets have changed on
> an NFS server after the offset-to-dentry mapping changes. Thus the
> whole application stack depends on unchanging directory offsets.
>
> The solution we've come up with is to make the directory offset for
> each file in a tmpfs filesystem stable for the life of the directory
> entry it represents.
>
> shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
> directory offset (an loff_t integer) to the memory address of a
> struct dentry.

I believe this patch is responsible for a tmpfs behaviour change when
a directory is modified while being read.  The following test program

#include <dirent.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
	const char *tmp = "/tmp";
	if (argc >= 2)
		tmp = argv[1];

	char *dir_path;
	if (asprintf(&dir_path, "%s/foo.XXXXXX", tmp) < 0)
		err(EXIT_FAILURE, "asprintf()");

	if (!mkdtemp(dir_path))
		err(EXIT_FAILURE, "mkdtemp(%s)", dir_path);

	char *file_path;
	if (asprintf(&file_path, "%s/bar", dir_path) < 0)
		err(EXIT_FAILURE, "asprintf()");

	if (creat(file_path, 0644) < 0)
		err(EXIT_FAILURE, "creat(%s)", file_path);

	DIR *dir = opendir(dir_path);
	if (!dir)
		err(EXIT_FAILURE, "opendir(%s)", dir_path);

	struct dirent *de;
	while ((de = readdir(dir))) {
		printf("readdir(): %s/%s\n", dir_path, de->d_name);
		if (de->d_name[0] == '.')
			continue;

		if (unlink(file_path) != 0)
			err(EXIT_FAILURE, "unlink(%s)", file_path);

		if (creat(file_path, 0644) < 0)
			err(EXIT_FAILURE, "creat(%s)", file_path);
	}

	return EXIT_SUCCESS;
}

when run on Linux 6.5, doesn't print the new directory entry:

tavianator@graphene $ uname -a
Linux graphene 6.5.9-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 26 Oct 2023 00:52:20 +0000 x86_64 GNU/Linux
tavianator@graphene $ gcc -Wall foo.c -o foo
tavianator@graphene $ ./foo
readdir(): /tmp/foo.wgmdmm/.
readdir(): /tmp/foo.wgmdmm/..
readdir(): /tmp/foo.wgmdmm/bar

But on Linux 6.6, readdir() never stops:

tavianator@tachyon $ uname -a
Linux tachyon 6.6.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 08 Nov 2023 16:05:38 +0000 x86_64 GNU/Linux
tavianator@tachyon $ gcc foo.c -o foo
tavianator@tachyon $ ./foo
readdir(): /tmp/foo.XnIRqj/.
readdir(): /tmp/foo.XnIRqj/..
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
readdir(): /tmp/foo.XnIRqj/bar
...
foo: creat(/tmp/foo.TTL6Fg/bar): Too many open files

POSIX says[1]

> If a file is removed from or added to the directory after the most recent
> call to opendir() or rewinddir(), whether a subsequent call to readdir()
> returns an entry for that file is unspecified.

so this isn't necessarily a *bug*, but I just wanted to point out the
behaviour change.  I only noticed it because it broke one of my tests in
bfs[2] (in a non-default build configuration).

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.html
[2]: https://github.com/tavianator/bfs/blob/main/tests/gnu/ignore_readdir_race_notdir.sh

