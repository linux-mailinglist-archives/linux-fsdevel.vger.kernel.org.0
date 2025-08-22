Return-Path: <linux-fsdevel+bounces-58801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F9B31958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB73BA0112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9C2FF146;
	Fri, 22 Aug 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="H6P7nQlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2472FB607;
	Fri, 22 Aug 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869043; cv=pass; b=nT1AgxWbuomwNGTKrVO9V80LJOWVT8EQfyXEvNsvJLK9JAdX4XeT9GqvNFxQEXX4ZW6xrAq6Qo8DG7xVg5bRXnTKi7NRnwqLo3ZvZk2LN+pYCTtXXXIILjYOlFmInxIkiwchDeSTLmhGuqQDSCz78gTTkvBUGEZj5xQViISxn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869043; c=relaxed/simple;
	bh=hS10M9D0MjARmLuvX057Y1+5NabUmzv3EtCmSRNOYdI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JYSQ9NZR/IUIGvCPfcFY+zrVRUCvkY9PCwvLArRlAw5tP9cRDcldeimvcGsEuocQcrOgkXa+Drpb/hBjEnIaFo2cWEQGXYSalDVLqiceCNQ4ppFvAX/1XmvhUaTOhSVw0S4AvjHcG5q7HNJQVyFaluDvnqIZJvTIRMQiTEftH1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=H6P7nQlf; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755869014; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lJBwHEFYnjfnxzSc29NkBs50PxyGfIDL/YfEcFG8dgWXOMxFyleLe6SaEHgL5hE4t9jnmWPVwpXaRObCmHbZC9fZbEfJIVgphBXG49W6dxY8r0HKdJ72teHRgqnYUNRChuWl5wNwb6ePx1YhHEo4cWHAo8FPUWoU3Oiqk6Q3sbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755869014; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SquxFdqgRAf0eFyRtSOn/VGvVMNK/UWQeTj/wSGTNBs=; 
	b=XN/uDwCqVVZxhrpzqUzyu8vC8pubndY6zLhKhXOFqqO81UHUeqk3s678JLe9R+thFNLDB2wP8scb4FbtamN80rh4Ib2rjSFkEtHlA7e91SW132HzqHc2Yoqto9PWt4Afo42+EKyK1uPRTSwd7Wcte8/Au9dAj08ckSMjofEzA0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755869014;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=SquxFdqgRAf0eFyRtSOn/VGvVMNK/UWQeTj/wSGTNBs=;
	b=H6P7nQlfzT7y6uCXd02VcIutHCcLwHYig7x93OfaTw26eCMXdUpPtMBnoSMypgQP
	/sC0GA3vw8VLsRGVaQzTzQYTM3NZ5aiKMK1e7g/+TY+m4l+8XGOWyt/CLV2Jgzw6W1F
	kch9MAelCmYfPmciFUt+dxBuo8Rr80LG3iKsbgJY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755869012379466.3148447572763; Fri, 22 Aug 2025 06:23:32 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 22 Aug 2025 06:23:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:23:32 +0400
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
Message-ID: <198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-5-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-5-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 05/12] man/man2/fspick.2: document "new" mount API
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
Feedback-ID: rr080112275a08d9283bf32069554e8fda00009e9cc01c24194ce33ee027c571aff909e22c3567602ab70a45:zu080112270adc7b7244954b05feac5d1f00008cf72f4f34fb1309a632c994320c0e167fad382ea8d3bd99a6:rf0801122c86e3abddd1ed669929cd4af800008466f30edfd3de379413a9b199b4649e78c63acd896c0b34b51934c553d2:ZohoMail

 ---- On Sat, 09 Aug 2025 00:39:49 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > +The above procedure is functionally equivalent to
 > +the following mount operation using
 > +.BR mount (2):

This is not true.

fspick adds options to superblock. It doesn't remove existing ones.

mount(MS_REMOUNT) replaces options. I. e. mount(2) call provided in
example will unset all other options.

In the end of this message you will find C code, which proves this.

Also, recently I sent patch to mount(2) manpage,
which clarifies MS_REMOUNT | MS_BIND behavior.
This is somewhat related.
The patch comes with another reproducer.
Here is a link: https://lore.kernel.org/linux-man/20250822114315.1571537-1-safinaskar@zohomail.com/

--
Askar Safin
https://types.pl/@safinaskar

// You need to be root (non-initial user namespace will go)

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
#include <sys/vfs.h>
#include <sys/sysmacros.h>
#include <sys/statvfs.h>
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

    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", MS_SYNCHRONOUS, NULL) == 0);
        {
            struct statfs buf;
            memset (&buf, 0, sizeof buf);
            MY_ASSERT (statfs ("/tmp/a", &buf) == 0);
            MY_ASSERT (buf.f_flags & ST_SYNCHRONOUS);
            MY_ASSERT (!(buf.f_flags & ST_RDONLY));
        }
        {
            int fsfd = fspick (AT_FDCWD, "/tmp/a", FSPICK_CLOEXEC);
            MY_ASSERT (fsfd >= 0);
            MY_ASSERT (fsconfig (fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0) == 0);
            MY_ASSERT (fsconfig (fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0) == 0);
            MY_ASSERT (close (fsfd) == 0);
        }
        {
            struct statfs buf;
            memset (&buf, 0, sizeof buf);
            MY_ASSERT (statfs ("/tmp/a", &buf) == 0);
            MY_ASSERT (buf.f_flags & ST_SYNCHRONOUS);
            MY_ASSERT (buf.f_flags & ST_RDONLY);
        }
        MY_ASSERT (umount ("/tmp/a") == 0);
    }

    {
        MY_ASSERT (mount (NULL, "/tmp/a", "tmpfs", MS_SYNCHRONOUS, NULL) == 0);
        {
            struct statfs buf;
            memset (&buf, 0, sizeof buf);
            MY_ASSERT (statfs ("/tmp/a", &buf) == 0);
            MY_ASSERT (buf.f_flags & ST_SYNCHRONOUS);
            MY_ASSERT (!(buf.f_flags & ST_RDONLY));
        }
        MY_ASSERT (mount (NULL, "/tmp/a", NULL, MS_REMOUNT | MS_RDONLY, NULL) == 0);
        {
            struct statfs buf;
            memset (&buf, 0, sizeof buf);
            MY_ASSERT (statfs ("/tmp/a", &buf) == 0);
            MY_ASSERT (!(buf.f_flags & ST_SYNCHRONOUS));
            MY_ASSERT (buf.f_flags & ST_RDONLY);
        }
        MY_ASSERT (umount ("/tmp/a") == 0);
    }

    printf ("All tests passed\n");
    exit (0);
}


