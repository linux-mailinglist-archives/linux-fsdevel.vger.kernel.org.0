Return-Path: <linux-fsdevel+bounces-58890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65425B32DD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 08:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F631B63322
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3524467B;
	Sun, 24 Aug 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="eB85a7AW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D123CEF8;
	Sun, 24 Aug 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018440; cv=pass; b=dpFks6tMPvK097GgY0NkgdG3GUW0wpD99IRj6nVzTVDdZQgkAD4HzNGCYpd1L9mJ3vdCZiS+Q+vi2UGN4MWp7f0rHKFAC1tpVv/KP+VWtXl/1x5LFCoRJ9S8M6uEJfzyKftrQABml5kk2WCwflMeF/NbgDpUljGgD6GhQHj9eOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018440; c=relaxed/simple;
	bh=+4XoOBwthGbTDE9PU0DUIm1xaKeE3/th2pNghjeB5i0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=u1ANQO3KswEnXr14HkCT12GhgyqT7fU/M+bpAj3CqajiyhVAuNO4WtMnBJQu+vZ8Uhyy3wUlu+4zSPSycv2H+15KhVdLma6KLLQxZxQnClw0jiExb0OUpkhdATwZ0kZaA9+0bHO4l3Wu5QMkorZLolw5QU2y6roylHiWB/k8LIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=eB85a7AW; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756018408; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dzardkVqzZnifGLcaYi4bmitkepMEb8oakoncb+VQvmlgoJfO/2Z3CE0duAd9m/sD0KHP+UYktpk4Nx3l0teQFDTm9Lj6NoxjKmwa9l3ZUAVqrQI088EUxhymZHRGLb1FusbtO1nIdWkXCYkhXfqBzqSCcIygWJvA04ZCTLsrvo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756018408; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LCIkqG/tRneiiilxl8xXwZbENVetREmCB1vmx+zhNnI=; 
	b=VY/+AvvKTokwVXO/ZcpKuXiugtwCAHyMI1WVwtHHObNyN3SQnWlFVLHuhL7VDv/CD/xw5Gz+8BJq3jugRt28TMoMLbtu42a+uPbXF6jM4pdmcw9IjCxFzR3x8/6YvKc6ro+BZYIUGEUqiaPtOiOSjuftUrTV9W/XEwGtwyHexVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756018408;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LCIkqG/tRneiiilxl8xXwZbENVetREmCB1vmx+zhNnI=;
	b=eB85a7AW85vifSc34CnyqoAz8kqea+9A+0jZXQAYSI1nN8aiENwle2CtHGAR17Cf
	8IfokoV0wly+Q9YhikNVuWFyue2dr7reF85LsC2p3XG3RBiu0zJP0jNus/COAg5Mof6
	I/uA75CAtE05fntirSmgypnsLB5zUGTws7gzSku0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756018407325384.3192467565557; Sat, 23 Aug 2025 23:53:27 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sat, 23 Aug 2025 23:53:27 -0700 (PDT)
Date: Sun, 24 Aug 2025 10:53:27 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <198dada778e.ed8ccab115437.3102752488507757202@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 09/12] man/man2/open_tree.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112273b3413fe257506eb17a55fda0000ca0e09a7f2e4ac1c359e0adddad2b9d03fa24eb0015b84ffd8:zu08011227d8ea003d4d0ccd2d2540c7290000c4b397b06582726fdb91176843d6ae36498ee0c66abb641979:rf0801122c9742ec2d7fd45827a620cf2e0000a813831b7b5a12ce00a6b3d543b3e024b67e1b21a185726a366956ede2c4:ZohoMail

 ---- On Sat, 09 Aug 2025 00:39:53 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > +If
 > +.I flags
 > +does not contain
 > +.BR \%OPEN_TREE_CLONE ,
 > +.BR open_tree ()
 > +returns a file descriptor
 > +that is exactly equivalent to
 > +one produced by
 > +.BR openat (2)

This is not true. They differ in handling of automounts.
open_tree follows them in final component (by default),
and openat - not.

See reproducer in the end of this letter.

I suggest merely adding this:
> that is exactly equivalent to one produced by openat(2) (modulo automounts)

--
Askar Safin
https://types.pl/@safinaskar


// Root in initial user namespace

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

    // open(O_PATH) doesn't follow automounts
    {
        mount_debugfs ();
        {
            int fd = open ("/tmp/debugfs/tracing", O_PATH);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (!tracing_mounted ());
        umount_debugfs ();
    }

    // open_tree does follow automounts (by default)
    {
        mount_debugfs ();
        {
            int fd = open_tree (AT_FDCWD, "/tmp/debugfs/tracing", 0);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (tracing_mounted ());
        umount_debugfs ();
    }

    // open (O_PATH | O_DIRECTORY)
    {
        mount_debugfs ();
        {
            int fd = open ("/tmp/debugfs/tracing", O_PATH | O_DIRECTORY);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (tracing_mounted ());
        umount_debugfs ();
    }

    // AT_NO_AUTOMOUNT
    {
        mount_debugfs ();
        {
            int fd = open_tree (AT_FDCWD, "/tmp/debugfs/tracing", AT_NO_AUTOMOUNT);
            MY_ASSERT (fd >= 0);
            MY_ASSERT (close (fd) == 0);
        }
        MY_ASSERT (!tracing_mounted ());
        umount_debugfs ();
    }

    printf ("All tests passed\n");
    exit (0);
}


