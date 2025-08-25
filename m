Return-Path: <linux-fsdevel+bounces-59085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D2B3445D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75211888A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394FA2F39AC;
	Mon, 25 Aug 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="QVoFywjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E251CEAC2;
	Mon, 25 Aug 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132735; cv=pass; b=TZmbPezJVOX+uY6R+ICO6bRsoGIs3Qtwa+oMyjPnHLlpt2AGWQoHWVTNCqZxQW39ord6pRKIrKmmQQuLpkoWHAooVbDqDx8C/241Rkr9OSyBYoslBNhtlw+OkChni2cCupLYWm5ygigLonC6zRBj3W+jDpXRJ8qE1Z2lwNjAXaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132735; c=relaxed/simple;
	bh=JyDsaTf2cmqkYBpIopEfs+Rm8oxWFihlc2DtOtbSh9c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tomUT5jOY547hwjUjbNImuTm+jbeYwOXh87DpM3y7moT/meWBA1ujylFIHL8GQS5sO3ZL+KhYHHTFpoigRZiDwle/q5p4/Fvx6hayrN4btHwGcMSnyrnVXWgok2AVICWOIuLRlbmsj3HpsRNQVgPljNXi/+sJ6Ptwnp6zXAw2c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=QVoFywjx; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756132707; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EjolHzsQrkYIvdt51bMWyO1LtXlcLE2FdU7VHAIXZ1yx+u3VrGtP7qhMrUWE50PNZCh79yCoJ2DFKB6pElWj5/4ngphrbhEP8W4GPDtD55b8VBcXoy51LJgchLMo7bS0mOsXkB+i1p4l/7aPtR39odHsjxAgS7z/T/cIWmpl3hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756132707; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BT0rrVzpyCgI24zRL6FXBl0HT7KvkigH00uEW7fga0I=; 
	b=lyc6lhbGSdVgl3fztWk9EViUMmBbdTFFMwRrYN/rC8oSRNNErKXsuhYW3bJq5STvrSP/l+UnfZu+XTqZK5lbAAcawu1GfRyejAmZXcxeLadJj5zwA+0bsRaZI/cPCw8nOhbXCQPbOCRdf0ZgrHejueRbpV87LHrAJF4oz/Z3QyA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756132707;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=BT0rrVzpyCgI24zRL6FXBl0HT7KvkigH00uEW7fga0I=;
	b=QVoFywjxisJwIhxyTfzB93AfZC9dpDhn5Sg46BbWdyvABEbrqUr8ugUQ0316jZ9f
	vMm1tgluNjKZ181xAyhuYd44pHJmRFOcP2bv3bhjBw2unBaAcHEoQntLvum+/hfIqfr
	/m8enyeZnLIz1AwRJ1mVf5x9aFNBparq18I5oZl4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756132705461122.44899931909401; Mon, 25 Aug 2025 07:38:25 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 07:38:25 -0700 (PDT)
Date: Mon, 25 Aug 2025 18:38:25 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Ian Kent" <raven@themaw.net>
Cc: "autofs mailing list" <autofs@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"cyphar" <cyphar@cyphar.com>, "viro" <viro@zeniv.linux.org.uk>,
	"NeilBrown" <neil@brown.name>
Message-ID: <198e1aa84a6.fad5ff4026331.4114043174169557399@zohomail.com>
In-Reply-To: <f83491c4-e535-4ee2-a2a8-935ccebec292@themaw.net>
References: <198cb9ecb3f.11d0829dd84663.7100887892816504587@zohomail.com> <f83491c4-e535-4ee2-a2a8-935ccebec292@themaw.net>
Subject: Re: Serious error in autofs docs, which has design implications
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
Feedback-ID: rr08011227b35657434efceb686dab333d00007e6fa32192badf5076c93ae95307de2670814652bea61ed230:zu080112276d926ede09271d2132fb10440000b6d6b82197b85fb0b1f8b78b6c7b33588a37136e9d1f63300c:rf0801122c153d2d5b1eb5ea3415cc0229000076842eb0585f3c55b61fe757099c73fa51584f153e871cb9c62c52ff925c:ZohoMail

 ---- On Fri, 22 Aug 2025 16:31:46 +0400  Ian Kent <raven@themaw.net> wrote --- 
 > On 21/8/25 15:53, Askar Safin wrote:
 > > autofs.rst says:
 > >> mounting onto a directory is considered to be "beyond a `stat`"
 > > in https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/filesystems/autofs.rst#L109
 > >
 > > This is not true. Mounting does not trigger automounts.
 > 
 > I don't understand that statement either, it's been many years

Let me explain.

Some syscalls follow (and trigger) automounts in last
component of path, and some - not.

stat(2) is one of syscalls, which don't follow
automounts in last component of supplied path.

Many other syscalls do follow automounts.

autofs.rst calls syscalls, which follow automounts,
as "beyond a stat".

Notably mount(2) doesn't follow automounts in second argument
(i. e. mountpoint). I know this, because I closely did read the code.
Also I did experiment (see source in the end of this letter).
Experiment was on 6.17-rc1.

But "autofs.rst" says:
> mounting onto a directory is considered to be "beyond a `stat`"

I. e. "autofs.rst" says that mount(2) does follow automounts.

This is wrong, as I explained above. (Again: I did experiment,
so I'm totally sure that this "autofs.rst" sentence is wrong.)

Moreover, then "autofs.rst" proceeds to explain why
DCACHE_MANAGE_TRANSIT was introduced, based on this wrong fact.

So it is possible that DCACHE_MANAGE_TRANSIT is in fact, not needed.

I'm not asking for removal of DCACHE_MANAGE_TRANSIT.

I merely point error in autofs.rst file and ask for fix.

And if in process of fixing autofs.rst you will notice that
DCACHE_MANAGE_TRANSIT is indeed not needed, then,
of course, it should be removed.

--
Askar Safin
https://types.pl/@safinaskar

====

// This code is public domain
// You should be root in initial user namespace

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
#include <sys/wait.h>
#include <linux/openat2.h>
#include <linux/nsfs.h>

#define MY_ASSERT(cond) do { \
    if (!(cond)) { \
        fprintf (stderr, "%d: %s: assertion failed\n", __LINE__, #cond); \
        exit (1); \
    } \
} while (0)

#define MY_ASSERT_ERRNO(cond) do { \
    if (!(cond)) { \
        fprintf (stderr, "%d: %s: %m\n", __LINE__, #cond); \
        exit (1); \
    } \
} while (0)

static void
mount_debugfs (void)
{
    if (mount (NULL, "/tmp/debugfs", "debugfs", 0, NULL) != 0)
        {
            perror ("mount debugfs");
            exit (1);
        }
}

int
main (void)
{
    MY_ASSERT_ERRNO (chdir ("/") == 0);
    MY_ASSERT_ERRNO (unshare (CLONE_NEWNS) == 0);
    MY_ASSERT_ERRNO (mount (NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == 0);
    MY_ASSERT_ERRNO (mount (NULL, "/tmp", "tmpfs", 0, NULL) == 0);
    MY_ASSERT_ERRNO (mkdir ("/tmp/debugfs", 0777) == 0);
    mount_debugfs ();
    MY_ASSERT_ERRNO (mount (NULL, "/tmp/debugfs/tracing", "tmpfs", 0, NULL) == 0);
    execlp ("/bin/busybox", "sh", NULL);
    MY_ASSERT (false);
}


