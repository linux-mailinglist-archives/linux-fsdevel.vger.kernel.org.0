Return-Path: <linux-fsdevel+bounces-59094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B9B34642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A18F1A81315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB973275AFC;
	Mon, 25 Aug 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="M5tZA1Nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DC233D85;
	Mon, 25 Aug 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136961; cv=pass; b=OP40zUJrfGDwzgR+/95296IkkPZHlzl/bnq2bPpP2Y8FQIGClQ3EkNXf0FhYe5R8tLheMsXAhw4COCsK99ejTmGeECfpSCfTZhmCOk5DV03LMrtqgvGCEubWcAPN0cXx1hJibAnBGgxNM1mlFpLUskRO4pjXLaJsIEhzG0KGTVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136961; c=relaxed/simple;
	bh=NHhGyTC0CIDD3nexoTzGCRdJXob9bOWVrY7Sx72p54I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJZjPwHeW9CqEFI48i9BMS5LlnmRHtur/xm9D/9BHdvpItG7+d4sucdYr1nQv6swPjtFYNiYM1+AhorIzAIXBIbCZzH7h+9GDtZKfPqbL21f9P/JmccZ3hSUTA431OAcdEQQh1rIEP+PKoN0VsO4JQeSChCUxSfNyjMMuyimxmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=M5tZA1Nl; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756136932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MRjlxNmE4xUYTct0dQSRagWGTJtb+XNvwRIRmFTkwP17VqVKZLSxnQEYPJav5CxedmppGKWirOOlZCkGe/hDR+HP/t5ddQgsXWujP/xiD2drXcJCQiq5mlT3/HKYXkeoz/nHGHYELDWt1PoR6tCFqbMlKRyFVnNRqlj5KOEpBcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756136932; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V51R1iwyrmIj748S/Lu12/RnCnSxNIFUCGC/ghODhMQ=; 
	b=KJWI3nC2yBHJkq0yt7t8CXq9bibORFTRw8HgyJ1FifBDcU84OmBFDUBSHYjzhfOoCh7kWOJIqshBF7ZD/3OeABYSbrlqJlRVY0s6YtsT0RnY4mGytJ71lXbyFxgdu7W+u+wE893fDAKg1CP1hhJ6+dzW/wdbKsv+Po4jhQhTj+U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756136932;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=V51R1iwyrmIj748S/Lu12/RnCnSxNIFUCGC/ghODhMQ=;
	b=M5tZA1Nljahg+K6pBPF9afUX9L1kRaYWoCAKnooW0bMTZxK2cnA/spZN/e6bCshj
	Ah4knSQ9rE80Ov7F0moDMJeJ2H8+d0oGEzSqrcbemeyNonUVbBcJip5dtZUxMx8trmz
	d2hQdJ/JLCbosMYX4os56pZGaaFOegMS/TL1A27s=
Received: by mx.zohomail.com with SMTPS id 1756136929960496.92655408087285;
	Mon, 25 Aug 2025 08:48:49 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH v2 0/1] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Mon, 25 Aug 2025 15:48:38 +0000
Message-ID: <20250825154839.2422856-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272d2c216ff3da290558e2750400003e42034302ec1870eeaf87d378ee03381bac80c72a0665d558:zu080112272e3f51a11e5ee7a518369a880000be5fd7925b765a9a46a9627d98f198b9f84a0c0ec753279acf:rf0801122c19da234dafb63a0c24bdd7b40000225c498ce742e8c51f947d53d0926b6cdb40513a5cd41e6779c2e6c9f811:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

You will find C code I used for experiments below

v1: https://lore.kernel.org/linux-man/20250822114315.1571537-1-safinaskar@zohomail.com/

Askar Safin (1):
  man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND

 man/man2/mount.2 | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

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

