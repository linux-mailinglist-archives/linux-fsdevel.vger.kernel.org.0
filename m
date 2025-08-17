Return-Path: <linux-fsdevel+bounces-58086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FECB29216
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244541B23F8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43C242D88;
	Sun, 17 Aug 2025 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="GloQMCCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7147F4A;
	Sun, 17 Aug 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755417221; cv=pass; b=YZCHfnaLAE/3/xWhi8NI+3Baq6b0nRvGqLBwu4kl1q+ImpjJHi3JJJDhFSO1LwnC/IbdmO+D8uoA1/DAXTaYfs/zKK9PBi/Yx2APqq5r30Oba6l4De/wHLX2v+hqCqcSFuSU4qb9vnah8gLW3/xDiXONI4Z5OLTrp8DVtegsqfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755417221; c=relaxed/simple;
	bh=+A/lL2Vivktg9Fcjb1RlmK8N9LuyWC8xYg1ZWXsLqfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXIByBQcIWAzUZRWDCwEtZx9eRaNlU7p28NT6ZKX3CW6n8YBvGqiebEsBF6vlq5xaCSgAFotJ61Yz9Mae78IFn/TZKIu8cYErCKjJnzSVcHPjfWW7sDxqNyqwJKU5txythi5rXlTjx0imflzQQP3KLYiUhHVjCcvm7AUCuCfWjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=GloQMCCj; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755417184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XK9TUXUIImJ+S6YxKYji5AxuTW5lGuY8dd+ySQD4ic6g5ZDtTft9jYBjdCI+5FyosXuofqwB+nCkpkEFM7W0VGmSf64na/FokUFLwYLOw5pTk6sGkTREJJjB/90VsWUZY8fPbZpHUGm8gM9nJzXErl01GzxCs1romYVAWmn77p8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755417184; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FxEUlubSzS/ImSmy9LZfYIWs7jCDlWOHoKLlk40PBY4=; 
	b=E3FC664HU6sv2FfICrC6I2ocZIAHg3Wu62IZIDTidy3mS2+MG1I3wEDbngmIia/DSK2HopvDaZ9jY3obHlBApOMooPia9WscG77uG5ocWMZA8nem5XD5Us05VqOe3NYJiDapox1BupcV2oO9IG3dVufo5gOJYs9VwxVdPpJSWiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755417183;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FxEUlubSzS/ImSmy9LZfYIWs7jCDlWOHoKLlk40PBY4=;
	b=GloQMCCjcT4dXCZ2G2ZJdEWJgRqPoJbiEklJhtk+J8XF2yYPEtvD98cparmnXsgN
	GmDKDhQAdViSTL2lCQvyUXpHTq5nS2FyQ0+J+mIVX6Ic8VAZDDHBjG3CHfUszRZ6nhv
	WTsEmeuP54CPO+LOSkL33GMaBolI2yELwHnt6t0U=
Received: by mx.zohomail.com with SMTPS id 1755417180137848.3990767083374;
	Sun, 17 Aug 2025 00:53:00 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk,
	Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Date: Sun, 17 Aug 2025 10:52:52 +0300
Message-ID: <20250817075252.4137628-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122748e966da49482809fcfa4ba9000041892980e08522db2c57f7da5fd32461398966667a65ec4920:zu0801122761e17a577db9357d25cc90f1000019da1d41d054edff11faa48fb5cc9ad3192d1c4f5edfc9c349:rf0801122b16bfbc0e5b8ba3441d3450190000fa2c120cde899195b935c940a75f78d1882c67a53c1470cea4170e57be:ZohoMail
X-ZohoMailClient: External

I noticed that you changed docs for automounts.
So I dig into automounts implementation.
And I found a bug in openat2.
If RESOLVE_NO_XDEV is specified, then name resolution
doesn't cross automount points (i. e. we get EXDEV),
but automounts still happen!
I think this is a bug.
Bug is reproduced in 6.17-rc1.
In the end of this mail you will find reproducer.
And miniconfig.

If you send patches for this bug, please, CC me.

Are automounts actually used? Is it possible to deprecate or
remove them? It seems for me automounts are rarely tested obscure
feature, which affects core namei code.

This reproducer is based on "tracing" automount, which
actually *IS* already deprecated. But automount mechanism
itself is not deprecated, as well as I know.

Also, I did read namei code, and I think that
options AT_NO_AUTOMOUNT, FSPICK_NO_AUTOMOUNT, etc affect
last component only, not all of them. I didn't test this yet.
I plan to test this within next days.

Also, I still didn't finish my experiments. Hopefully I will
finish them in 7 days. :)

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

If that openat2 bug reproduces, then this program will
print "BUG REPRODUCED". If openat2 is fixed, then
the program will print "BUG NOT REPRODUCED".
Any other output means that something gone wrong,
i. e. results are indeterminate.

This program requires root in initial user namespace
*/

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/syscall.h>
#include <linux/openat2.h>

int
main (void)
{
    if (unshare (CLONE_NEWNS) != 0)
        {
            perror ("unshare");
            return 1;
        }
    if (mount (NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) != 0)
        {
            perror ("mount(NULL, /, NULL, MS_REC | MS_PRIVATE, NULL)");
            return 1;
        }
    if (mount (NULL, "/tmp", "tmpfs", 0, NULL) != 0)
        {
            perror ("mount tmpfs");
            return 1;
        }
    if (mkdir ("/tmp/debugfs", 0777) != 0)
        {
            perror ("mkdir(/tmp/debugfs)");
            return 1;
        }
    if (mount (NULL, "/tmp/debugfs", "debugfs", 0, NULL) != 0)
        {
            perror ("mount debugfs");
            return 1;
        }
    {
        struct statx tracing;
        if (statx (AT_FDCWD, "/tmp/debugfs/tracing", AT_NO_AUTOMOUNT, 0, &tracing) != 0)
            {
                perror ("statx tracing");
                return 1;
            }
        if (!(tracing.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT))
            {
                fprintf (stderr, "???\n");
                return 1;
            }
        // Let's check that nothing is mounted at /tmp/debugfs/tracing yet
        if (tracing.stx_attributes & STATX_ATTR_MOUNT_ROOT)
            {
                fprintf (stderr, "Something already mounted at /tmp/debugfs/tracing\n");
                return 1;
            }
    }
    if (chdir ("/tmp/debugfs") != 0)
        {
            perror ("chdir");
            return 1;
        }
    {
        struct open_how how;
        memset (&how, 0, sizeof how);
        how.flags = O_DIRECTORY;
        how.mode = 0;
        how.resolve = RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS;
        if (syscall (SYS_openat2, AT_FDCWD, "tracing", &how, sizeof how) != -1)
            {
                fprintf (stderr, "openat2 crossed automount point");
                return 1;
            }
        if (errno != EXDEV)
            {
                fprintf (stderr, "wrong errno");
                return 1;
            }
    }
    {
        struct statx tracing;
        if (statx (AT_FDCWD, "/tmp/debugfs/tracing", AT_NO_AUTOMOUNT, 0, &tracing) != 0)
            {
                perror ("statx tracing (2)");
                return 1;
            }
        if (!(tracing.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT))
            {
                fprintf (stderr, "???\n");
                return 1;
            }
        if (tracing.stx_attributes & STATX_ATTR_MOUNT_ROOT)
            {
                fprintf (stderr, "BUG REPRODUCED. Something mounted at /tmp/debugfs/tracing\n");
                return 0;
            }
        else
            {
                fprintf (stderr, "BUG NOT REPRODUCED\n");
                return 0;
            }
    }
}

