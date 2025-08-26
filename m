Return-Path: <linux-fsdevel+bounces-59171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A0B356F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DDA5E3723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DB2FAC10;
	Tue, 26 Aug 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="XUq9tLH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA582FABE9;
	Tue, 26 Aug 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197193; cv=pass; b=SptHhz/Ub2TXV2CiGMP4NYeXVNvQlkpe+MOFiysKcJ3RmyQLjoAD+D5e+5DAdGKzdYmkiNkE6bay/kVygP1txrboCCq4xqaj8y6enpVmjxr+Cihz/W89RhbJqWxEslmIUPwFBiSzL6zJaqsudwyBYPIplY8ozCnTwTQcBa1MEKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197193; c=relaxed/simple;
	bh=xDqTWkD413bsRteH6S6sDnUAuRAiBlPVWoHebAitgDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EodqI8WCOm0GCYiJRs+SxmqELQkb50JOJCIvv6dafjowE044vDpdLH3ZzIPI0EVmQjb++KpWdy5Lum6alH2FWgAuPcHCX2jwve9Hasm2hkq/DxPsioZyWEakk+zlCKGgxx6sQsaz9IAByP5/x65M7TTNJJXoS1kFrqIj7GevRo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=XUq9tLH/; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756197160; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dv1/dujZm9aXLZKXHTyF3A6i1zCSA4AGn3qPMr5XnmJgIuR7jjN3FQFbKSYUkh2I6oLMePwB+tlvyY3ULxAdtwzX0cH/446axTRT3NSfbs0Z17onyXY3uHlALfqyywfHFFvUKlLKFz4jRNrNjmuRZhlVcP82KYr0oZqv15HCs2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756197160; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cp2VyThOqzXrBZbk4XNMEHOH+F+J4N/dsv21eSWdPtY=; 
	b=kgxPO6nSJJeweQnEd8VE3W4UnZBXp7aa3K2XCAkMtm74ea/NuKYAXYqqS1GVZSGAynpXu1rQL6aadqwWEOf6K4ORpzs4+LFrSZRNEihOQ/bixKCQIo3eTwuZdPDxx1rJJWyySoo7sjVbldpz8jQwciY9/tsc0M8SjlrDITxpTcw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756197160;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Cp2VyThOqzXrBZbk4XNMEHOH+F+J4N/dsv21eSWdPtY=;
	b=XUq9tLH/Gg3l4RbpSkBsuqp4j98bB5ndIG+fch8FEEQhxfWNu8QE93a+57f9oLER
	JGza/VUQDlofbyzq5tgoYBl1swCDzk5toogP4tz1g0v/dq05JsQpy1xxrJP4cjavXMn
	NoteOCaA/jiwOQ/7D22K6FlBDfBNoKquSnTtwxDQ=
Received: by mx.zohomail.com with SMTPS id 1756197155875692.5001218667893;
	Tue, 26 Aug 2025 01:32:35 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH v3 0/2] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Tue, 26 Aug 2025 08:32:25 +0000
Message-ID: <20250826083227.2611457-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112275c7d1f0b67a7d372d8806cca000069fde9dc0235f465eb92954be00398cf4d3a55a784b9e87ad3:zu08011227e44a2f998f1f21c3a23229680000dc9b5be7336c48d656ae2f3aa334d6d5316442fd5bbdf03711:rf0801122c616f448e6235b285e1f2548b00008e7fff8ba25234b7db81b7c9539d9c5ec682dcd78dbf264f29a8aea64106:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

You will find C code I used for experiments below

v1: https://lore.kernel.org/linux-man/20250822114315.1571537-1-safinaskar@zohomail.com/
v2: https://lore.kernel.org/linux-man/20250825154839.2422856-1-safinaskar@zohomail.com/

Askar Safin (2):
  man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
  man2/mount.2: tfix (mountpoint => mount point)

 man/man2/mount.2 | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
2.47.2

// You need to be root in initial user namespace

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/syscall.h>
#include <sys/sysmacros.h>
#include <linux/openat2.h>

#define MY_ASSERT(cond) do { \
    if (!(cond)) { \
        fprintf (stderr, "%d: %s: assertion failed\n", __LINE__, #cond); \
        exit (1); \
    } \
} while (0)

int
main (void)
{
    // Init
    {
        MY_ASSERT (chdir ("/") == 0);
        MY_ASSERT (unshare (CLONE_NEWNS) == 0);
        MY_ASSERT (mount (NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp", "tmpfs", 0, NULL) == 0);
    }

    MY_ASSERT (mkdir ("/tmp/a", 0777) == 0);
    MY_ASSERT (mkdir ("/tmp/b", 0777) == 0);

    // MS_REMOUNT sets options for superblock
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_RDONLY, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // MS_REMOUNT | MS_BIND sets options for vfsmount
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND | MS_RDONLY, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/b/c") == 0);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // fspick sets options for superblock
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        {
            int fsfd = fspick (AT_FDCWD, "/tmp/a", 0);
            MY_ASSERT (fsfd >= 0);
            MY_ASSERT (fsconfig (fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0) == 0);
            MY_ASSERT (fsconfig (fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0) == 0);
            MY_ASSERT (close (fsfd) == 0);
        }
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // mount_setattr sets options for vfsmount
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        {
            struct mount_attr attr;
            memset (&attr, 0, sizeof attr);
            attr.attr_set = MOUNT_ATTR_RDONLY;
            MY_ASSERT (mount_setattr (AT_FDCWD, "/tmp/a", 0, &attr, sizeof attr) == 0);
        }
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/b/c") == 0);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // "ro" as a string works for MS_REMOUNT
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT, "ro") == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // "ro" as a string doesn't work for MS_REMOUNT | MS_BIND
    // Option string is ignored
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount ("/tmp/a", "/tmp/b", NULL, MS_BIND, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND, "ro") == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
        MY_ASSERT (mkdir ("/tmp/b/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/b/c") == 0);
        MY_ASSERT (umount ("/tmp/a") == 0);
        MY_ASSERT (umount ("/tmp/b") == 0);
    }

    // Removing MS_RDONLY makes mount writable again (in case of MS_REMOUNT | MS_BIND)
    // Same for other options (not tested, but I did read code)
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND | MS_RDONLY, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (umount ("/tmp/a") == 0);
    }

    // Removing "ro" from option string makes mount writable again (in case of MS_REMOUNT)
    // I. e. mount(2) works exactly as documented
    // This works even if option string is NULL, i. e. NULL works as default option string
    {
        typedef const char *c_string;
        c_string opts[3] = {NULL, "", "rw"};
        for (int i = 0; i != 3; ++i)
            {
                for (int j = 0; j != 3; ++j)
                    {
                        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, opts[i]) == 0);
                        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
                        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
                        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT, "ro") == 0);
                        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
                        MY_ASSERT (errno == EROFS);
                        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT, opts[j]) == 0);
                        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
                        MY_ASSERT (umount ("/tmp/a") == 0);
                    }
            }
    }

    // Removing MS_RDONLY makes mount writable again (in case of MS_REMOUNT)
    // I. e. mount(2) works exactly as documented
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_RDONLY, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        MY_ASSERT (errno == EROFS);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
        MY_ASSERT (umount ("/tmp/a") == 0);
    }

    // Setting MS_RDONLY (without other flags) removes all other flags, such as MS_NODEV (in case of MS_REMOUNT | MS_BIND)
    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", 0, NULL) == 0);
        MY_ASSERT (mknod ("/tmp/a/mynull", S_IFCHR | 0666, makedev (1, 3)) == 0);

        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
        {
            int fd = open ("/tmp/a/mynull", O_WRONLY);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (write (fd, "a", 1) == 1);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND | MS_NODEV, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == 0);
        MY_ASSERT (rmdir ("/tmp/a/c") == 0);
        MY_ASSERT (open ("/tmp/a/mynull", O_WRONLY) == -1);
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_BIND | MS_RDONLY, NULL) == 0);
        MY_ASSERT (mkdir ("/tmp/a/c", 0777) == -1);
        {
            int fd = open ("/tmp/a/mynull", O_WRONLY);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (write (fd, "a", 1) == 1);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (umount ("/tmp/a") == 0);
    }
    printf ("All tests passed\n");
    exit (0);
}

