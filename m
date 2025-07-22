Return-Path: <linux-fsdevel+bounces-55692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B615B0DD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B607B2F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB62ED86F;
	Tue, 22 Jul 2025 14:11:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073D2ED873
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193469; cv=none; b=jkQQNfL4gC68McXjoOzfebhHU07ee1/7xqYAFRHmNyZlT00qi4gDCm6SPU54W7OoN5MoxOw0ux9Pd2tSMWaL5Rvc70I/gVWVBEma3E+2pIvebWmxMo7WJDlgiGJtl3l0G0+seNyfeW/uZOji1CuZ7CErDtSdrgoFi2FoqTmu4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193469; c=relaxed/simple;
	bh=VB0GTDPOnYLB9L9qzHXgQJSz13IwEW6z3IsWG9ccK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS/7VMOM2LG5keEHJPbkGJZsY9gxk0NWn5dcAv/nNIQAqJ6YfsYZ5wOfVagrtfAhBzSNMne02jiC3okkLYv9c8uGMoG1+ez0cyjz/cNN00yoLx/wq9BRmpKtiJ6+QiGwa7CXa/MYCqXLB187ivqUQqgcE+OPi7thx9XyV4qDYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C4952116B;
	Tue, 22 Jul 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BC27132EA;
	Tue, 22 Jul 2025 14:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Or97Cfqbf2gsIgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 14:11:06 +0000
Date: Tue, 22 Jul 2025 16:11:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Eggert <eggert@cs.ucla.edu>, linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 2/2] Add listxattr04 reproducer
Message-ID: <20250722141104.GC84869@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-2-4be1e52e97c6@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-xattr_bug_repr-v4-2-4be1e52e97c6@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 5C4952116B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Hi Andrea,

FYI Andrea's LTP reproducer for a bug introduced in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b0ba61df5a1
and fixed in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=800d0b9b6a8b

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> simple_xattr_list to always include security.* xattrs").

> Bug can be reproduced when SELinux and ACL are activated on inodes as
> following:

>     $ touch testfile
>     $ setfacl -m u:myuser:rwx testfile
>     $ getfattr -dm. /tmp/testfile
>     Segmentation fault (core dumped)

> The reason why this happens is that simple_xattr_list() always includes
> security.* xattrs without resetting error flag after
> security_inode_listsecurity(). This results into an incorrect length of the
> returned xattr name if POSIX ACL is also applied on the inode.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
>  testcases/kernel/syscalls/listxattr/Makefile      |   2 +
>  testcases/kernel/syscalls/listxattr/listxattr04.c | 108 ++++++++++++++++++++++
>  3 files changed, 111 insertions(+)

> diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
> index be0675a6df0080d176d53d70194442bbc9ed376c..0d672b6ea5eec03aab37ee89316c56e24356c1d9 100644
> --- a/testcases/kernel/syscalls/listxattr/.gitignore
> +++ b/testcases/kernel/syscalls/listxattr/.gitignore
> @@ -1,3 +1,4 @@
>  /listxattr01
>  /listxattr02
>  /listxattr03
> +/listxattr04
> diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
> index c2f84b1590fc24a7a98f890ea7706771d944aa79..e96bb3fa4c2c6b14b8d2bc8fd4c475e4789d72fe 100644
> --- a/testcases/kernel/syscalls/listxattr/Makefile
> +++ b/testcases/kernel/syscalls/listxattr/Makefile
> @@ -6,4 +6,6 @@ top_srcdir		?= ../../../..

>  include $(top_srcdir)/include/mk/testcases.mk

> +listxattr04: LDLIBS	+= $(ACL_LIBS)
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr04.c b/testcases/kernel/syscalls/listxattr/listxattr04.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..473ed45b5c2da8ff8e49c513eeb82158ec2dc066
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> + * simple_xattr_list to always include security.* xattrs").
> + *
> + * Bug can be reproduced when SELinux and ACL are activated on inodes as
> + * following:
> + *
> + *     $ touch testfile
> + *     $ setfacl -m u:myuser:rwx testfile
> + *     $ getfattr -dm. /tmp/testfile
> + *     Segmentation fault (core dumped)
> + *
> + * The reason why this happens is that simple_xattr_list() always includes
> + * security.* xattrs without resetting error flag after
> + * security_inode_listsecurity(). This results into an incorrect length of the
> + * returned xattr name if POSIX ACL is also applied on the inode.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
> +
> +#include <pwd.h>
> +#include <sys/acl.h>
> +#include <sys/xattr.h>
> +
> +#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
> +#define TEST_FILE       "test.bin"
> +
> +static acl_t acl;
> +
> +static void verify_xattr(const int size)
> +{
> +	char buf[size];
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (listxattr(TEST_FILE, buf, size) == -1) {
> +		if (errno != ERANGE)
> +			tst_brk(TBROK | TERRNO, "listxattr() error");

The original verifier from RH bugreport check sizes and also works if size > -1
is returned, but I guess it's not necessary, because Andrea's reproducer works
as expected (fails on affected 6.16-rc1 based openSUSE kernel, works on 6.15.x).

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2369561
> +
> +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "listxattr() correctly read attributes length");
> +}
> +
> +static void run(void)
> +{
> +	int size;
> +
> +	size = listxattr(TEST_FILE, NULL, 0);
> +	if (size == -1)
> +		tst_brk(TBROK | TERRNO, "listxattr() error");
> +
> +	verify_xattr(size);
> +}
> +
> +static void setup(void)
> +{
> +	int res;
> +
> +	if (!tst_selinux_enabled())
> +		tst_brk(TCONF, "SELinux is not enabled");
> +
> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
> +
> +	acl = acl_from_text(ACL_PERM);
> +	if (!acl)
> +		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
> +
> +	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
> +	if (res == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "acl_set_file()");
> +
> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (acl)
> +		acl_free(acl);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "800d0b9b6a8b"},
> +		{}
> +	}
> +};
> +
> +#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
> +	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
> +#endif

