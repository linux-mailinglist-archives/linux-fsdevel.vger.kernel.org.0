Return-Path: <linux-fsdevel+bounces-58106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6AB294D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 20:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A42B1962F56
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7E1E491B;
	Sun, 17 Aug 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="c+R/rb/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D01A9F8D;
	Sun, 17 Aug 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755456690; cv=pass; b=LA2Mmqe34S6GDu4HTAH3gJ3ycJMPK7cnsNd3HW8QeGUvtYYqSrhIOKPchBufY5HSAMXu3zXXv31lRcyW2YgjSAwAg6eN86mCJZa15Ejb3SYZM70bABDlbMTCl5QwpnkUnE0a6Iw525hrrbzcDZt5M18uey2OFBVlC31uTFmkjM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755456690; c=relaxed/simple;
	bh=55Akj2HO/Pgq3zZBcgV85sKUOLoer07lrhfWdY0HOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzuw/9KHlw7vzdkixGUK9KE+jtozC6SNhLDZ+Q96B7zdICb4qu43zAAfTCgNVJRLSrzqyyilWZCwbEQpz3qcGG87TS7S0CUluAvO7SFijz/XA8mQqFy4brIiGgOL7ML6n3wy/yGUAK4c9ETtujiBKWUh1M/T0MCEeYyxEZtRe7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=c+R/rb/N; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755456657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EVMjnrj3bYHaCcFDXMoES9St7dsf0BI8co0WPIotZnf2vu6zRlVdiTTr5BVOBl/mNfZvUUTRf3q+iCFEdI1IEAOsfkD/ImpRYOBGF1vx0fvjvFbTkchbHfePh3e9QJRxWVCy7PyTmFINuHNkQt0ybXWVpQwMFltm27j4jDLD+XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755456657; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2ei0vnbRoyr4z9B7uUCn2W87/nsXxYSWcAa07cJ+CHs=; 
	b=mk82VX3KQin78ilZFfK3f60K3XLROoEUl/fSGnCCT924OK4GnpDf1pKfNWeCe53TOqCH3K4t9njYopVaN8C/N+Rhw6bmfBmWJbqrt7A2IH62FHPj0dlDk1PwHIJFo//hQdvxZY7Fz0X3nahls8t9wqsrRoAnj4bUiZ6OKFjvbeQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755456657;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2ei0vnbRoyr4z9B7uUCn2W87/nsXxYSWcAa07cJ+CHs=;
	b=c+R/rb/N9hjsLMYd0FEWMgDnuWWWGAO8SvSVLBKYUaYAfk9QbICijSpkc1Rcoli6
	eo8TfzRTxY3AKE8uuTj4lyJM0agRs8iJXq+eh1ohFbev+hk5MnciE4p8zOIIH3nqm0y
	Wke3Jv98RhVQaFufa06Al8ZgHg4Q/TEuRsxjnBCw=
Received: by mx.zohomail.com with SMTPS id 1755456655864372.40472456009354;
	Sun, 17 Aug 2025 11:50:55 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	autofs@vger.kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	raven@themaw.net,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Date: Sun, 17 Aug 2025 21:50:48 +0300
Message-ID: <20250817185048.302679-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
References: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122756c3dccfe13bedd4275fb75600005bdb5dba817ad1ab1a0ef82912191a97f32a086171946f5bfc:zu0801122713868e6cc3835a012b80940e0000a90e456cd1a1c6cc0a59c1bbb0f7b0dd2f96e8f3d48bc969f2:rf0801122b2295acadff86e4dc5261c5ac0000fba55d523f3356505ee7f11a7a7b53f044683ee556e984b53cb10bb5e8:ZohoMail
X-ZohoMailClient: External

I just sent to fsdevel fix for that RESOLVE_NO_XDEV bug.

Aleksa Sarai <cyphar@cyphar.com>:
> No, LOOKUP_AUTOMOUNT affects all components. I double-checked this with
> Christian.

No. I just tested this. See tests (and miniconfig) in the end of this message.

statx always follows automounts in non-final components no matter what.
I tested this. And it follows automounts in final component depending on
AT_NO_AUTOMOUNT. I tested this too. Also, absolutely all other syscalls always
follow automounts in non-final components no matter what. With sole exception
for openat2 with RESOLVE_NO_XDEV. I didn't test this, but I conclude this
by reading code.

First of all, LOOKUP_PARENT's doc in kernel currently is wrong:
https://elixir.bootlin.com/linux/v6.17-rc1/source/include/linux/namei.h#L31

We see there:
#define LOOKUP_PARENT    BIT(10)    /* Looking up final parent in path */

This is not true. LOOKUP_PARENT means that we are resolving any non-final
component. LOOKUP_PARENT is set when we enter link_path_walk, which
is used for resolving everything except for final component.
And LOOKUP_PARENT is cleared when we leave link_path_walk.

Now let's look here:
https://elixir.bootlin.com/linux/v6.17-rc1/source/fs/namei.c#L1447

	if (!(lookup_flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&

We never return -EISDIR in this "if" if we are in non-final component
thanks to LOOKUP_PARENT here. We fall to finish_automount instead.

Again: if this is non-final component, then LOOKUP_PARENT is set, and thus
LOOKUP_AUTOMOUNT is ignored. If this is final component, then LOOKUP_AUTOMOUNT
may affect things.

Code below tests that:
- statx always follows non-final automounts
- statx follow final automounts depending on options

The code doesn't test other syscalls, they can be added if needed.

The code was tested in Qemu on Linux 6.17-rc1.

I'm not trying to insult you in any way.

Again: thank you a lot for your work! For openat2 and for these mans.

Askar Safin

====

miniconfig:

CONFIG_64BIT=y

CONFIG_EXPERT=y

CONFIG_PRINTK=y
CONFIG_PRINTK_TIME=y

CONFIG_TTY=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y

CONFIG_PROC_FS=y
CONFIG_DEVTMPFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_DEBUG_FS=y
CONFIG_USER_EVENTS=y
CONFIG_FTRACE=y
CONFIG_MULTIUSER=y
CONFIG_NAMESPACES=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y


CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y

CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y

CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=y

CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

====

/*
Author: Askar Safin
Public domain

Make sure your kernel is compiled with CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=y

If all tests pass, the program
should print "All tests passed".
Any other output means that something gone wrong.

This program requires root in initial user namespace
*/

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
#include <linux/openat2.h>

#define MY_ASSERT(cond) do { \
    if (!(cond)) { \
        fprintf (stderr, "%s: assertion failed\n", #cond); \
        exit (1); \
    } \
} while (0)

bool
tracing_mounted (void)
{
    struct statx tracing;
    if (statx (AT_FDCWD, "/tmp/debugfs/tracing", AT_NO_AUTOMOUNT, 0, &tracing) != 0)
        {
            perror ("statx tracing");
            exit (1);
        }
    if (!(tracing.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT))
        {
            fprintf (stderr, "???\n");
            exit (1);
        }
    return tracing.stx_attributes & STATX_ATTR_MOUNT_ROOT;
}

void
mount_debugfs (void)
{
    if (mount (NULL, "/tmp/debugfs", "debugfs", 0, NULL) != 0)
        {
            perror ("mount debugfs");
            exit (1);
        }
    MY_ASSERT (!tracing_mounted ());
}

void
umount_debugfs (void)
{
    umount ("/tmp/debugfs/tracing"); // Ignore errors
    if (umount ("/tmp/debugfs") != 0)
        {
            perror ("umount debugfs");
            exit (1);
        }
}

int
main (void)
{
    // Init
    {
        if (chdir ("/") != 0)
            {
                perror ("chdir /");
                exit (1);
            }
        if (unshare (CLONE_NEWNS) != 0)
            {
                perror ("unshare");
                exit (1);
            }
        if (mount (NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) != 0)
            {
                perror ("mount(NULL, /, NULL, MS_REC | MS_PRIVATE, NULL)");
                exit (1);
            }
        if (mount (NULL, "/tmp", "tmpfs", 0, NULL) != 0)
            {
                perror ("mount tmpfs");
                exit (1);
            }
    }
    if (mkdir ("/tmp/debugfs", 0777) != 0)
        {
            perror ("mkdir(/tmp/debugfs)");
            exit (1);
        }

    // statx always follows automounts in non-final components. With AT_NO_AUTOMOUNT and without AT_NO_AUTOMOUNT
    {
        mount_debugfs();
        {
            struct statx readme;
            if (statx (AT_FDCWD, "/tmp/debugfs/tracing/README", 0, 0, &readme) != 0)
                {
                    perror ("statx");
                    exit (1);
                }
        }
        MY_ASSERT (tracing_mounted ());
        umount_debugfs();

        mount_debugfs();
        {
            struct statx readme;
            if (statx (AT_FDCWD, "/tmp/debugfs/tracing/README", AT_NO_AUTOMOUNT, 0, &readme) != 0)
                {
                    perror ("statx");
                    exit (1);
                }
        }
        MY_ASSERT (tracing_mounted ());
        umount_debugfs();
    }

    // statx follows automounts in final components if AT_NO_AUTOMOUNT is not specified
    {
        mount_debugfs();
        {
            struct statx tracing;
            if (statx (AT_FDCWD, "/tmp/debugfs/tracing", 0, 0, &tracing) != 0)
                {
                    perror ("statx");
                    exit (1);
                }
            if (!(tracing.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT))
                {
                    fprintf (stderr, "???\n");
                    exit (1);
                }

            // Checking that this is new mount, not automount point itself
            MY_ASSERT (tracing.stx_attributes & STATX_ATTR_MOUNT_ROOT);
        }
        MY_ASSERT (tracing_mounted ());
        umount_debugfs ();

        mount_debugfs();
        {
            struct statx tracing;
            if (statx (AT_FDCWD, "/tmp/debugfs/tracing", AT_NO_AUTOMOUNT, 0, &tracing) != 0)
                {
                    perror ("statx");
                    exit (1);
                }
            if (!(tracing.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT))
                {
                    fprintf (stderr, "???\n");
                    exit (1);
                }

            MY_ASSERT (!(tracing.stx_attributes & STATX_ATTR_MOUNT_ROOT));
        }
        MY_ASSERT (!tracing_mounted ());
        umount_debugfs ();
    }

    printf ("All tests passed\n");
    exit (0);
}

