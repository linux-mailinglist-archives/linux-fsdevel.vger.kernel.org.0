Return-Path: <linux-fsdevel+bounces-58778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FEB31693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0915C5AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0321255D;
	Fri, 22 Aug 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="KXn0M6uP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922961EF09D;
	Fri, 22 Aug 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863037; cv=pass; b=arUTfo0J1OnhV8nlyVUZpMtmN6tnfm08orw4S9snUyoCPb/r9S/gEsH8kh8uDyB8bmwq63Sg7mSUox53D2lEiAe3qY9Nv3g4/KKgm1DPNn+1eu8PnX5+Wkp5b0CQe0l9dGXnYTAfXKVpYnv64OZuCdvxpZgGIWcMmni3vrpqlP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863037; c=relaxed/simple;
	bh=Xc9fGcRxHOpRTYp8eAb4c/KQR3pTj8IzR515rRlQgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsZi83eRSbmadS3XRQtUMfBmUFGT/jT+QYjBN4+1pK5Sk+f9boXVQLXgJ6E5/f+sRBKku+AdgouZl2E/T6zHivR6QXPkUiF7KcdlF5PI6kmiAXpx4FdUCWMABg9waUno//A6kBZOUFoGYYIo3kl/k/bkhGKh7TyuhrtlsArn1IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=KXn0M6uP; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755863009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JGoyCuORPt60rve65DZpc+bLrjnLzDpRFXwt4sq8pBUUmn9idBkqkMwJZQwE6g7hQHm7Aamk6OL9b2U1JKBe8BwUaebZnk1dYdvn0INNzHiFRZzbrnDoUpOY6cr9nyGMJYokKJcdeRktrntLtzbgqVIhRVbbRttmtclQ5Xzm8Zc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755863009; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BxNjMqD2Lnz8GJuZN+o6Cywq1aS+TJV21dRFTBSF/y0=; 
	b=OQBnEdv5CNBon8COfuuoGoJsnnj/rZvovO41Cnx8Wwu/bV/20BqUmarUCWUsLDYvgCYSSrlsr+eJQ5LP33TxxsllVt9hVVnT+HRwGjLW1X6dLvDkwjGoS9ZJNIC/n+AaoQ5FtqrcZLnHtJNeJkRoo6PiOvCwLNA/Y0abEn8HmRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755863009;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=BxNjMqD2Lnz8GJuZN+o6Cywq1aS+TJV21dRFTBSF/y0=;
	b=KXn0M6uPohnLLfBt/KQR4ciFTUsBwIUxYp7JTWvKiN1Z0m40lxquMe3B6GbvbTAI
	JiTeYu8Ss0CxeOgAXXFcWAS1LWffwljfpWIcNWAEky7EqDfMfBFF7Y+NfuQBHsCXrCf
	x4B1clM2d9LytqjcQCdqdlOynII6RU4vYq5d/fCs=
Received: by mx.zohomail.com with SMTPS id 1755863007052447.1758225837672;
	Fri, 22 Aug 2025 04:43:27 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH 0/1] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Fri, 22 Aug 2025 11:43:14 +0000
Message-ID: <20250822114315.1571537-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272a0f215f6355ed1055a3a174000046e781913bf56178989339b901f39bf959e1efe5ff64e5f4d6:zu08011227288ccea6c2cb7fff74bfb0630000aa21346168df707657a7cb470a9e92f528be02fb446d8ec690:rf0801122cd99bdc725e8e2d7bd424a39500000bb741444251f3d7c2a79beb2c3cf1052f960572b7e446419d6359f89e85:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

You will find C code I used for experiments below

Askar Safin (1):
  man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND

 man/man2/mount.2 | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

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

