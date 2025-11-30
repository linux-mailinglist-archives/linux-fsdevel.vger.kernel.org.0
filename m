Return-Path: <linux-fsdevel+bounces-70267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA022C9495B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 01:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 278B84E2E50
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5E1F584C;
	Sun, 30 Nov 2025 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="cTTUT3M1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078B5477E
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764460896; cv=none; b=RdHiNx48YAMnCGAVtaZV+Mgec49xqaE+SgE0ukg8RbFA1Y+FneZtsyWUtwyxIhV+8vMSXvXr18aHDBkC23ykuRdfY8F9FJgPlqI+V9P5z7QnmQ6FnUf4lh4z/6tD/R4Tscbz00GDf0CAEa17AMDbEpxFqHMrBFbyOVP5V+8o6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764460896; c=relaxed/simple;
	bh=LSJ70a7sqpVfPbtWx1NwHyhEjI0E0jggLRDHw6XUKNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmlODYUYqYTWAVwfDQ1GHMLHaCf4tRWXoYRPwWPfGlvDVUl4Vc4bE8xXAUQhw2EmCr9lnd9v95RPqxX65GvOg868jiLbYoSlhyFcHfpNljrSJk/bgFqQVQSo5I2lsWwuwuoyTZ0ppiJEpzcI4pBHkZhPeHKI3NWXYB6Ub5TIbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=cTTUT3M1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764460882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srEr3LoKq1Czaq8I5z3/A4FoFBjqxOV0LMrfiR1/IRI=;
	b=cTTUT3M1OgZOXf9KsjND5eMtqvOa5Da+1AeeP4jR0sw0vC4IDg5Xa7CSv88SWqP6ld8c4U
	feLTIFGjsHi46wUcXcnZnBNFYyUA+k4gt6/btlcqIgvR4xvfo97KEbgbLW8O6jDXdJrKlx
	N47LnE5fWNIgP4vLf6QeSzk7h8hxo+Mf0b3ed+iyBgZDt5MyHgOMDd1kv+b3MkRIf/97oF
	Xk4+Fm9asGPOO/UHvFRyAPJkp7+BxqbSkXxGSQ7XQCxe3dquat/XoNWuSDCvFSrDBacD6P
	XPihqavrhekC6KevGwsdpq2omOGhg4neyyNLaEyfIuqzGpoqSCNpP7XeImwedA==
Date: Sat, 29 Nov 2025 21:01:05 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 06/15] VFS: introduce start_creating_noperm() and
 start_removing_noperm()
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Carlos Maiolino <cem@kernel.org>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Stefan Berger <stefanb@linux.ibm.com>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20251113002050.676694-7-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 11/12/25 9:18 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>
> xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
> which do not check permissions.
> This patch adds _noperm versions of these functions.
> [..]
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 316922d5dd13..a0d5b302bcc2 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1397,27 +1397,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>   	if (!parent)
>   		return -ENOENT;
>   
> -	inode_lock_nested(parent, I_MUTEX_PARENT);
>   	if (!S_ISDIR(parent->i_mode))
> -		goto unlock;
> +		goto put_parent;
>   
>   	err = -ENOENT;
>   	dir = d_find_alias(parent);
>   	if (!dir)
> -		goto unlock;
> +		goto put_parent;
>   
> -	name->hash = full_name_hash(dir, name->name, name->len);
> -	entry = d_lookup(dir, name);
> +	entry = start_removing_noperm(dir, name);
>   	dput(dir);
> -	if (!entry)
> -		goto unlock;
> +	if (IS_ERR(entry))
> +		goto put_parent;

This broke xdg-document-portal (and potentially other FUSE filesystems) 
by introducing a massive deadlock.

❯ doas cat /proc/40751/stack # main thread
[<0>] __fuse_simple_request+0x37c/0x5c0 [fuse]
[<0>] fuse_lookup_name+0x12c/0x2a0 [fuse]
[<0>] fuse_lookup+0x9c/0x1e8 [fuse]
[<0>] lookup_one_qstr_excl+0xd4/0x160
[<0>] start_removing_noperm+0x5c/0x90
[<0>] fuse_reverse_inval_entry+0x64/0x1e0 [fuse]
[<0>] fuse_dev_do_write+0x13a8/0x16a8 [fuse]
[<0>] fuse_dev_write+0x64/0xa8 [fuse]
[<0>] do_iter_readv_writev+0x170/0x1d0
[<0>] vfs_writev+0x100/0x2d0
[<0>] do_writev+0x88/0x130

d_lookup which was previously used here —from what I could understand by 
reading it— is cache-only and does not call into the FS's lookup at all.

This new start_removing_noperm calls start_dirop which calls 
lookup_one_qstr_excl which according to its own comment is the "one and 
only case when ->lookup() gets called on non in-lookup dentries". Well, 
->lookup() is the request back to the userspace FUSE server.. but the 
FUSE server is waiting for the write() to the FUSE device that invokes 
this operation to return! We cannot reenter the FUSE server 
from fuse_reverse_inval_entry.

x-d-p issue link: https://github.com/flatpak/xdg-desktop-portal/issues/1871

Reverting the fuse/dir.c changes has fixed that for me.

Thanks,
~val


