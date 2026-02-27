Return-Path: <linux-fsdevel+bounces-78738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDUCNFC6oWlhwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:37:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A11B9F15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BDC31B3872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51F41C316;
	Fri, 27 Feb 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nIJznJMj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ug700Kk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ER0jE8ic";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9uX+LeD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6913242CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206258; cv=none; b=ZNJ5GX8jJ+0UJHjpAqA0pBwUlm90gxbNuvEATdkqLZuYoEkr3W62SpF/xcFwNvsnop9FkIrjsdGJfHza3VcO6vSju7Hxgvn2EhsX9kzJ6pAmFXtlnAfnMph8jcDJRZrr1Vx6ZaTT+iDrzNv9lwvcVr/4VoiH/lrFOlgq/OzUO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206258; c=relaxed/simple;
	bh=bTOgeqmoHmmj+yrDca/0uGQlldV4agyZFcBYKxuGa0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0yd+FZc9JUUlXRjkUuexO7NiNit31/Y/NQx1NRziRqA71S4ck1DUaXpeOdv+VyNr4d8SVEmDu8kmu2lrxEMVBw7d48QnTNHQbDYPOuZxARei+zpk2ZNB5IcE7L0kpbeOcKn/87teHR/AdazhdCaTuqo9h4CmYMnwquCYv2IaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nIJznJMj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ug700Kk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ER0jE8ic; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9uX+LeD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044085C43F;
	Fri, 27 Feb 2026 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFOw/CipdsoxjPCODfI4GMcSSYcQzdPIxtrDNHFZ3c4=;
	b=nIJznJMjktcoLwWwVlSLsfZIKyVFzo/o9dV4chF33xfSYsWOJJRK6OQH2Qlh2e0j9Z776P
	zP8GJHTJ0JR5r6Q5knxSQ2Uby1DpQpTn3QTDqgfT4vjwtaKI961zVQAirM6z6y6Se3gGVm
	dC2XlTgLDhv+5kxT1tiOzPMjN5/vlmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFOw/CipdsoxjPCODfI4GMcSSYcQzdPIxtrDNHFZ3c4=;
	b=3ug700KkirGOaxaxqZrb/7OLkoKkwkmUPN2sx97ELg3WLdiWDPYsZ2emzBNxSeGSITR8Wt
	+BekfokGwWGZsZCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFOw/CipdsoxjPCODfI4GMcSSYcQzdPIxtrDNHFZ3c4=;
	b=ER0jE8icm2+ekpA8i0zpk6jhD0QkDa63Lys7NGlSPMEgOf7R/SIQ/urMclT7P5wF0dHo64
	gZJlVrmMeZyvfrJoKD/+oh6WUnyDtbISa3L0loC8of+SjIw++hd8d+IElHU/maHN9qn9tq
	Cb5W0vQ9gqBwi+O+SOGHTXu20PiDbS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFOw/CipdsoxjPCODfI4GMcSSYcQzdPIxtrDNHFZ3c4=;
	b=h9uX+LeDvz4h+Bsig1IHp1e7FNcBVY8oNM9xDhV1deTySxlga2EZ2D4nppEBHXqM6cvozi
	A9oVBK1DnvmYbaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECECC3EA69;
	Fri, 27 Feb 2026 15:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 44bVOa24oWlHLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:30:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2030A06D4; Fri, 27 Feb 2026 16:30:53 +0100 (CET)
Date: Fri, 27 Feb 2026 16:30:53 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 13/14] selftests/xattr: sockfs socket xattr tests
Message-ID: <yqxanlt3h4h2dwtpzgywsrzozdry3oe3c4yg22x6wqm2grntbu@pazi2ufzrwfv>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-13-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-13-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78738-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 360A11B9F15
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:09, Christian Brauner wrote:
> Test user.* extended attribute operations on sockfs sockets. Sockets
> created via socket() have their inodes in sockfs, which now supports
> user.* xattrs with per-inode limits.
> 
> Tests fsetxattr/fgetxattr/flistxattr/fremovexattr operations including
> set/get, listing (verifies system.sockprotoname presence), remove,
> update, XATTR_CREATE/XATTR_REPLACE flags, empty values, size queries,
> and buffer-too-small errors.
> 
> Also tests per-inode limit enforcement: maximum 128 xattrs, maximum
> 128KB total value size, limit recovery after removal, and independent
> limits across different sockets.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../testing/selftests/filesystems/xattr/.gitignore |   1 +
>  tools/testing/selftests/filesystems/xattr/Makefile |   2 +-
>  .../filesystems/xattr/xattr_sockfs_test.c          | 363 +++++++++++++++++++++
>  3 files changed, 365 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/xattr/.gitignore b/tools/testing/selftests/filesystems/xattr/.gitignore
> index 5fd015d2257a..00a59c89efab 100644
> --- a/tools/testing/selftests/filesystems/xattr/.gitignore
> +++ b/tools/testing/selftests/filesystems/xattr/.gitignore
> @@ -1 +1,2 @@
>  xattr_socket_test
> +xattr_sockfs_test
> diff --git a/tools/testing/selftests/filesystems/xattr/Makefile b/tools/testing/selftests/filesystems/xattr/Makefile
> index e3d8dca80faa..2cd722dba47b 100644
> --- a/tools/testing/selftests/filesystems/xattr/Makefile
> +++ b/tools/testing/selftests/filesystems/xattr/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += $(KHDR_INCLUDES)
> -TEST_GEN_PROGS := xattr_socket_test
> +TEST_GEN_PROGS := xattr_socket_test xattr_sockfs_test
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/xattr/xattr_sockfs_test.c b/tools/testing/selftests/filesystems/xattr/xattr_sockfs_test.c
> new file mode 100644
> index 000000000000..b4824b01a86d
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/xattr/xattr_sockfs_test.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
> +/*
> + * Test extended attributes on sockfs sockets.
> + *
> + * Sockets created via socket() have their inodes in sockfs, which supports
> + * user.* xattrs with per-inode limits: up to 128 xattrs and 128KB total
> + * value size. These tests verify xattr operations via fsetxattr/fgetxattr/
> + * flistxattr/fremovexattr on the socket fd, as well as limit enforcement.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define TEST_XATTR_NAME		"user.testattr"
> +#define TEST_XATTR_VALUE	"testvalue"
> +#define TEST_XATTR_VALUE2	"newvalue"
> +
> +/* Per-inode limits for user.* xattrs on sockfs (from include/linux/xattr.h) */
> +#define SIMPLE_XATTR_MAX_NR	128
> +#define SIMPLE_XATTR_MAX_SIZE	(128 << 10)	/* 128 KB */
> +
> +#ifndef XATTR_SIZE_MAX
> +#define XATTR_SIZE_MAX 65536
> +#endif
> +
> +/*
> + * Fixture for sockfs socket xattr tests.
> + * Creates an AF_UNIX socket (lives in sockfs, not bound to any path).
> + */
> +FIXTURE(xattr_sockfs)
> +{
> +	int sockfd;
> +};
> +
> +FIXTURE_SETUP(xattr_sockfs)
> +{
> +	self->sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	ASSERT_GE(self->sockfd, 0) {
> +		TH_LOG("Failed to create socket: %s", strerror(errno));
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(xattr_sockfs)
> +{
> +	if (self->sockfd >= 0)
> +		close(self->sockfd);
> +}
> +
> +TEST_F(xattr_sockfs, set_get_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("fsetxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE)) {
> +		TH_LOG("fgetxattr returned %zd: %s", ret, strerror(errno));
> +	}
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +}
> +
> +/*
> + * Test listing xattrs on a sockfs socket.
> + * Should include user.* xattrs and system.sockprotoname.
> + */
> +TEST_F(xattr_sockfs, list_user_xattr)
> +{
> +	char list[4096];
> +	ssize_t ret;
> +	char *ptr;
> +	bool found_user = false;
> +	bool found_proto = false;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("fsetxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(list, 0, sizeof(list));
> +	ret = flistxattr(self->sockfd, list, sizeof(list));
> +	ASSERT_GT(ret, 0) {
> +		TH_LOG("flistxattr failed: %s", strerror(errno));
> +	}
> +
> +	for (ptr = list; ptr < list + ret; ptr += strlen(ptr) + 1) {
> +		if (strcmp(ptr, TEST_XATTR_NAME) == 0)
> +			found_user = true;
> +		if (strcmp(ptr, "system.sockprotoname") == 0)
> +			found_proto = true;
> +	}
> +	ASSERT_TRUE(found_user) {
> +		TH_LOG("user xattr not found in list");
> +	}
> +	ASSERT_TRUE(found_proto) {
> +		TH_LOG("system.sockprotoname not found in list");
> +	}
> +}
> +
> +TEST_F(xattr_sockfs, remove_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fremovexattr(self->sockfd, TEST_XATTR_NAME);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("fremovexattr failed: %s", strerror(errno));
> +	}
> +
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_sockfs, update_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE2, strlen(TEST_XATTR_VALUE2), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE2));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE2);
> +}
> +
> +TEST_F(xattr_sockfs, xattr_create_flag)
> +{
> +	int ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE2, strlen(TEST_XATTR_VALUE2),
> +			XATTR_CREATE);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EEXIST);
> +}
> +
> +TEST_F(xattr_sockfs, xattr_replace_flag)
> +{
> +	int ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE),
> +			XATTR_REPLACE);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_sockfs, get_nonexistent)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = fgetxattr(self->sockfd, "user.nonexistent", buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_sockfs, empty_value)
> +{
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME, "", 0, 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, NULL, 0);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_F(xattr_sockfs, get_size)
> +{
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, NULL, 0);
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +}
> +
> +TEST_F(xattr_sockfs, buffer_too_small)
> +{
> +	char buf[2];
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ERANGE);
> +}
> +
> +/*
> + * Test maximum number of user.* xattrs per socket.
> + * The kernel enforces SIMPLE_XATTR_MAX_NR (128), so the 129th should
> + * fail with ENOSPC.
> + */
> +TEST_F(xattr_sockfs, max_nr_xattrs)
> +{
> +	char name[32];
> +	int i, ret;
> +
> +	for (i = 0; i < SIMPLE_XATTR_MAX_NR; i++) {
> +		snprintf(name, sizeof(name), "user.test%03d", i);
> +		ret = fsetxattr(self->sockfd, name, "v", 1, 0);
> +		ASSERT_EQ(ret, 0) {
> +			TH_LOG("fsetxattr %s failed at i=%d: %s",
> +			       name, i, strerror(errno));
> +		}
> +	}
> +
> +	ret = fsetxattr(self->sockfd, "user.overflow", "v", 1, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENOSPC) {
> +		TH_LOG("Expected ENOSPC for xattr %d, got %s",
> +		       SIMPLE_XATTR_MAX_NR + 1, strerror(errno));
> +	}
> +}
> +
> +/*
> + * Test maximum total value size for user.* xattrs.
> + * The kernel enforces SIMPLE_XATTR_MAX_SIZE (128KB). Individual xattr
> + * values are limited to XATTR_SIZE_MAX (64KB) by the VFS, so we need
> + * at least two xattrs to hit the total limit.
> + */
> +TEST_F(xattr_sockfs, max_xattr_size)
> +{
> +	char *value;
> +	int ret;
> +
> +	value = malloc(XATTR_SIZE_MAX);
> +	ASSERT_NE(value, NULL);
> +	memset(value, 'A', XATTR_SIZE_MAX);
> +
> +	/* First 64KB xattr - total = 64KB */
> +	ret = fsetxattr(self->sockfd, "user.big1", value, XATTR_SIZE_MAX, 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("first large xattr failed: %s", strerror(errno));
> +	}
> +
> +	/* Second 64KB xattr - total = 128KB (exactly at limit) */
> +	ret = fsetxattr(self->sockfd, "user.big2", value, XATTR_SIZE_MAX, 0);
> +	free(value);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("second large xattr failed: %s", strerror(errno));
> +	}
> +
> +	/* Third xattr with 1 byte - total > 128KB, should fail */
> +	ret = fsetxattr(self->sockfd, "user.big3", "v", 1, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENOSPC) {
> +		TH_LOG("Expected ENOSPC when exceeding size limit, got %s",
> +		       strerror(errno));
> +	}
> +}
> +
> +/*
> + * Test that removing an xattr frees limit space, allowing re-addition.
> + */
> +TEST_F(xattr_sockfs, limit_remove_readd)
> +{
> +	char name[32];
> +	int i, ret;
> +
> +	/* Fill up to the maximum count */
> +	for (i = 0; i < SIMPLE_XATTR_MAX_NR; i++) {
> +		snprintf(name, sizeof(name), "user.test%03d", i);
> +		ret = fsetxattr(self->sockfd, name, "v", 1, 0);
> +		ASSERT_EQ(ret, 0);
> +	}
> +
> +	/* Verify we're at the limit */
> +	ret = fsetxattr(self->sockfd, "user.overflow", "v", 1, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENOSPC);
> +
> +	/* Remove one xattr */
> +	ret = fremovexattr(self->sockfd, "user.test000");
> +	ASSERT_EQ(ret, 0);
> +
> +	/* Now we should be able to add one more */
> +	ret = fsetxattr(self->sockfd, "user.newattr", "v", 1, 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("re-add after remove failed: %s", strerror(errno));
> +	}
> +}
> +
> +/*
> + * Test that two different sockets have independent xattr limits.
> + */
> +TEST_F(xattr_sockfs, limits_per_inode)
> +{
> +	char buf[256];
> +	int sock2;
> +	ssize_t ret;
> +
> +	sock2 = socket(AF_UNIX, SOCK_STREAM, 0);
> +	ASSERT_GE(sock2, 0);
> +
> +	/* Set xattr on first socket */
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	/* First socket's xattr should not be visible on second socket */
> +	ret = fgetxattr(sock2, TEST_XATTR_NAME, NULL, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +
> +	/* Second socket should independently accept xattrs */
> +	ret = fsetxattr(sock2, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE2, strlen(TEST_XATTR_VALUE2), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	/* Verify each socket has its own value */
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(sock2, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE2));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE2);
> +
> +	close(sock2);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

