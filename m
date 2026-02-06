Return-Path: <linux-fsdevel+bounces-76596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOSUNAcNhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:47:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35774FFE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27D4C300B285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE92D0620;
	Fri,  6 Feb 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+CeFl0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90C2877F4;
	Fri,  6 Feb 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392803; cv=none; b=Lp87GVpFG4qk78w79xgYNasSIHFJHBEMhFtcPrvjJqIVH29eflWdBVEYY3+LfLQ8sfQBARTZEpumMlpWVOChdZfu9oia6r+W+E0POZnWtV5dfR9bXyQuE0mT8aSjzgba/63xlXt+m5AZMJNyEd/BOUWkLQjOZRI5MUbtTn4Tskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392803; c=relaxed/simple;
	bh=MhNETv0IhsRLuQ3ixvARUQ0qQ08sqY7ZhIPw0IfKWSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M98fo0MLmEqi32nuPTpE8vRa6ofCDJaxbNChW4I9Kw6oCjUvZY1WG+jSbga/egg+Nm1HTaZ/rWnjKx9qbvDBh/tlyPpYOoQff+7hoOr82Gx4Lbz4ldm+Wq7f1tQou1sLtWGFRvurltaC9JwZrtd5NPSmH2UUl8yi8wfrR4ITuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+CeFl0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657ECC116C6;
	Fri,  6 Feb 2026 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770392803;
	bh=MhNETv0IhsRLuQ3ixvARUQ0qQ08sqY7ZhIPw0IfKWSY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Q+CeFl0hwS91Ta1c97g/uX381BcJ//9+TKmhG98Hr9Z7HdrMH5OlJ4XukiZcuGpie
	 2P9qzGzxAEPuputpzAphA5RrRAsjK6JKB9ipo8KIdzQSvW4KIL8YHMZwLTQqwiIzcf
	 9/9cLIFVk4MQlgzVuvJczzyzbJG19LYuDOUMF0yIGtFE+wPWVvmZ77/g5eMiurj21+
	 R+N/ZIMbKOQUTT3c5FDtxyL1fM+s13pSQREAgVSYpVZHyCfGPNge3KZUW8fKSWcXP9
	 0wwlvcQFdps2xJWX7F8nCB17mZLI7eTozdKlwXOptY01Fy/T/0qNb9JJB35xxcfv+W
	 ObHtPGjCdjgNw==
Message-ID: <6789380caa630c8efefce6862c77bf6780af45da.camel@kernel.org>
Subject: Re: [PATCH v4 0/3] kNFSD Signed Filehandles
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>, Chuck Lever
	 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Eric Biggers
	 <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 06 Feb 2026 10:46:41 -0500
In-Reply-To: <cover.1770390036.git.bcodding@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76596-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,brown.name,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35774FFE0F
X-Rspamd-Action: no action

On Fri, 2026-02-06 at 10:09 -0500, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehan=
dle
> guessing attacks.
>=20
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  A trusted NFS client holding a vali=
d
> filehandle can remotely access the corresponding file without reference t=
o
> access-path restrictions that might be imposed by the ancestor directorie=
s
> or the server exports.
>=20
> In order to acquire a filehandle, you must perform lookup operations on t=
he
> parent directory(ies), and the permissions on those directories may prohi=
bit
> you from walking into them to find the files within.  This would normally=
 be
> considered sufficient protection on a local filesystem to prohibit users
> from accessing those files, however when the filesystem is exported via N=
FS
> an exported file can be accessed whenever the NFS server is presented wit=
h
> the correct filehandle, which can be guessed or acquired by means other t=
han
> LOOKUP.
>=20
> Filehandles are easy to guess because they are well-formed.  The
> open_by_handle_at(2) man page contains an example C program
> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here=
's
> an example filehandle from a fairly modern XFS:
>=20
> # ./t_name_to_handle_at /exports/foo=20
> 57
> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>=20
>           ^---------  filehandle  ----------^
>           ^------- inode -------^ ^-- gen --^
>=20
> This filehandle consists of a 64-bit inode number and 32-bit generation
> number.  Because the handle is well-formed, its easy to fabricate
> filehandles that match other files within the same filesystem.  You can
> simply insert inode numbers and iterate on the generation number.
> Eventually you'll be able to access the file using open_by_handle_at(2).
> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, wh=
ich
> protects against guessing attacks by unprivileged users.
>=20
> Simple testing confirms that the correct generation number can be found
> within ~1200 minutes using open_by_handle_at() over NFS on a local system
> and it is estimated that adding network delay with genuine NFS calls may
> only increase this to around 24 hours.
>=20
> In contrast to a local user using open_by_handle(2), the NFS server must
> permissively allow remote clients to open by filehandle without being abl=
e
> to check or trust the remote caller's access. Therefore additional
> protection against this attack is needed for NFS case.  We propose to sig=
n
> filehandles by appending an 8-byte MAC which is the siphash of the
> filehandle from a key set from the nfs-utilities.  NFS server can then
> ensure that guessing a valid filehandle+MAC is practically impossible
> without knowledge of the MAC's key.  The NFS server performs optional
> signing by possessing a key set from userspace and having the "sign_fh"
> export option.
>=20
> Because filehandles are long-lived, and there's no method for expiring th=
em,
> the server's key should be set once and not changed.  It also should be
> persisted across restarts.  The methods to set the key allow only setting=
 it
> once, afterward it cannot be changed.  A separate patchset for nfs-utils
> contains the userspace changes required to set the server's key.
>=20
> I had planned on adding additional work to enable the server to check whe=
ther the
> 8-byte MAC will overflow maximum filehandle length for the protocol at
> export time.  There could be some filesystems with 40-byte fileid and
> 24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
> 8-byte MAC appended.  The server should refuse to export those filesystem=
s
> when "sign_fh" is requested.  However, the way the export caches work (th=
e
> server may not even be running when a user sets up the export) its
> impossible to do this check at export time.  Instead, the server will ref=
use
> to give out filehandles at mount time and emit a pr_warn().
>=20
> Thanks for any comments and critique.
>=20
> Changes from encrypt_fh posting:
> https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@ha=
mmerspace.com
> 	- sign filehandles instead of encrypt them (Eric Biggers)
> 	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
> 	- rebase onto cel/nfsd-next (Chuck Lever)
> 	- condensed/clarified problem explantion (thanks Chuck Lever)
> 	- add nfsctl file "fh_key" for rpc.nfsd to also set the key
>=20
> Changes from v1 posting:
> https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspa=
ce.com
> 	- remove fh_fileid_offset() (Chuck Lever)
> 	- fix pr_warns, fix memcmp (Chuck Lever)
> 	- remove incorrect rootfh comment (NeilBrown)
> 	- make fh_key setting an optional attr to threads verb (Jeff Layton)
> 	- drop BIT() EXP_ flag conversion
> 	- cover-letter tune-ups (NeilBrown, Chuck Lever)
> 	- fix NFSEXP_ALLFLAGS on 2/3
> 	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
> 	- move MAC signing into __fh_update() (Chuck Lever)
>=20
> Changes from v2 posting:
> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspa=
ce.com
> 	- more cover-letter detail (NeilBrown)
> 	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
> 	- fix key copy (Eric Biggers)
> 	- use NFSD_A_SERVER_MAX (NeilBrown)
> 	- remove procfs fh_key interface (Chuck Lever)
> 	- remove FH_AT_MAC (Chuck Lever)
> 	- allow fh_key change when server is not running (Chuck/Jeff)
> 	- accept fh_key as netlink attribute instead of command (Jeff Layton)
>=20
> Changes from v3 posting:
> https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspa=
ce.com
> 	- /actually/ fix up endianness problems (Eric Biggers)
> 	- comment typo
> 	- fix Documentation underline warnings
> 	- fix possible uninitialized fh_key var
>=20
> Benjamin Coddington (3):
>   NFSD: Add a key for signing filehandles
>   NFSD/export: Add sign_fh export option
>   NFSD: Sign filehandles
>=20
>  Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
>  Documentation/netlink/specs/nfsd.yaml       |  6 ++
>  fs/nfsd/export.c                            |  5 +-
>  fs/nfsd/netlink.c                           |  5 +-
>  fs/nfsd/netns.h                             |  2 +
>  fs/nfsd/nfsctl.c                            | 37 ++++++++-
>  fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
>  fs/nfsd/trace.h                             | 25 ++++++
>  include/uapi/linux/nfsd/export.h            |  4 +-
>  include/uapi/linux/nfsd_netlink.h           |  1 +
>  10 files changed, 225 insertions(+), 9 deletions(-)
>=20
>=20
> base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287


Nice work, Ben. This looks good to me!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

