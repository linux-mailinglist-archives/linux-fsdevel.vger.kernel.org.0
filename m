Return-Path: <linux-fsdevel+bounces-18738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36D8BBE14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE3D1C20C4A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9E483CC8;
	Sat,  4 May 2024 20:40:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D91DFEB;
	Sat,  4 May 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714855219; cv=none; b=Z+D/f3rXnxMusu+O73paledxuZ+5Uxw0k2S+4YIbF5B3g7k0q1FqZZDO+q0oG/LFkYmoa0v9ZijanykXquOsaLAd29JtuaTY/IJ68adufhqQ95VTg9mJq3Vb8DoEPZQ/hvAKZYXVAX8Jcc+vP2wDzzE1GrRv9fPTTpVVPzBmFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714855219; c=relaxed/simple;
	bh=k/XD+dv3MxZmFwZdPoHXkMTpr91p/aWWjGh7RYBOmyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C74EHbBOInNJFFtSlkP6Ob0yk4guCYsZexRA5CkP0RX1Ay4BEyFcogxADiiNLL0ZanNhUMlpemIt7GSAa29C6warE5/kQCVD412WjWx4lRs3PrZb2nvMwjLfnrCT18oEYn0RM38sDoqWDIIhkNJGC0wM7KmiB1WnN0d+XE2gsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.30] (p4fee269d.dip0.t-ipconnect.de [79.238.38.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D3CFC61E5FE01;
	Sat,  4 May 2024 22:39:00 +0200 (CEST)
Message-ID: <bf4a737a-0c5b-4349-886d-4013683818ce@molgen.mpg.de>
Date: Sat, 4 May 2024 22:38:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] openat2: add OA2_CRED_INHERIT flag
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@ACULAB.COM>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
 <20240427112451.1609471-4-stsp2@yandex.ru>
Content-Language: en-US
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20240427112451.1609471-4-stsp2@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/24 13:24, Stas Sergeev wrote:
> This flag performs the open operation with the fs credentials
> (fsuid, fsgid, group_info) that were in effect when dir_fd was opened.
> dir_fd must be opened with O_CRED_ALLOW, or EPERM is returned.
> 
> Selftests are added to check for these properties as well as for
> the invalid flag combinations.
> 
> This allows the process to pre-open some directories and then
> change eUID (and all other UIDs/GIDs) to a less-privileged user,
> retaining the ability to open/create files within these directories.
> 
> Design goal:
> The idea is to provide a very light-weight sandboxing, where the
> process, without the use of any heavy-weight techniques like chroot
> within namespaces, can restrict the access to the set of pre-opened
> directories.
> This patch is just a first step to such sandboxing. If things go
> well, in the future the same extension can be added to more syscalls.
> These should include at least unlinkat(), renameat2() and the
> not-yet-upstreamed setxattrat().
> 
> Security considerations:
> - Only the bare minimal set of credentials is overridden:
>    fsuid, fsgid and group_info. The rest, for example capabilities,
>    are not overridden to avoid unneeded security risks.
> - To avoid sandboxing escape, this patch makes sure the restricted
>    lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
> - Magic /proc symlinks are discarded, as suggested by
>    Andy Lutomirski <luto@kernel.org>> - O_CRED_ALLOW fds cannot be passed via unix socket and are always
>    closed on exec() to prevent "unsuspecting userspace" from not being
>    able to fully drop privs.

What about hard links?

== snip ==
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stdarg.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/openat2.h>

#define O_CRED_ALLOW 0x2000000
#define OA2_CRED_INHERIT (1UL << 28)

#define SYS_openat2 437
long openat2(int dirfd, const char *pathname, struct open_how *how, size_t size) {
     return syscall(SYS_openat2, dirfd, pathname, how, size);
}


__attribute__ ((noreturn, format(printf, 1, 2)))
static void die(const char *restrict fmt, ...) {
     va_list ap;
     va_start(ap, fmt);
     vfprintf(stderr, fmt, ap);
     va_end(ap);
     _exit(1);
}

int main() {

     unlink("/tmp/d/test.dat");
     unlink("/tmp/d/hostname");
     if (rmdir("/tmp/d") != 0 && errno != ENOENT)
         die("/tmp/d: %m\n");
     
     umask(0);
     if (mkdir("/tmp/d", 0777) != 0)
         die("/tmp/d: %m\n");

     int dirfd = open("/tmp/d", O_RDONLY + O_CRED_ALLOW);
     if (dirfd == -1)
         die("/tmp/d: %m\n");

     if (setuid(1000) != 0)
         die("setuid: %m\n");

     if (link("/etc/hostname", "/tmp/d/hostname") == -1)
         die ("/etc/hostname: %m\n");

     if(openat(dirfd, "hostname", O_RDWR) != -1)
         die("/tmp/d/hostname could be opened by uid 1000");

     {   struct open_how how = { .flags = O_RDWR + OA2_CRED_INHERIT, .resolve = RESOLVE_BENEATH };
         if (openat2(dirfd, "hostname", &how, sizeof(how)) == -1)
             die("hostname: %m\n");
         printf("able to open /etc/hostname RDWR \n");
     }
}

== snip ==


buczek@dose:~$ gcc -O0 -Wall -Wextra -Werror -g -o test test.c
buczek@dose:~$ sudo ./test
able to open /etc/hostname RDWR
buczek@dose:~$


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

