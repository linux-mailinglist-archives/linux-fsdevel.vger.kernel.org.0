Return-Path: <linux-fsdevel+bounces-74741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OObTF5IBcGmUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:28:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 235914CF6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C67A384ED2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7713C1999;
	Tue, 20 Jan 2026 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSN+IBTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209023D3308
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945739; cv=none; b=BnTu6vlGUNJNTDtaYkI+wYo8ifrdU5854GGiFoqCU7wVVoR2SBipnPtz/Vpx1o+/FHcbP5ePScw2RgzEcQhtPPYwIpK26yc5mWub5Z90yJr36+uNHLShC3ypw3gvgNxOp93ZcX3stv0fQc5z3om11cHwjm3Ypmrb8d7tr8w8V9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945739; c=relaxed/simple;
	bh=96b8Nubirwao54BkP50ZkP0NSv+GbSST6a8dD5+v4ms=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FRyqL7YsIcCk3/LqjzLmDr6BRzoVVaHCii+uuXPmvlcfc+7CTsPxKuXFAj5KiCNS73lTjxfu5qBh+Dpb8APTDJIhONiJQKkyXo0q8cikYl0wVd/Q4ZPqGgVnOwQeUN/puRHPslTlvNbJ5V01JtHmMgJIG/RxWDapBO+3z2moItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSN+IBTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD920C19421;
	Tue, 20 Jan 2026 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768945738;
	bh=96b8Nubirwao54BkP50ZkP0NSv+GbSST6a8dD5+v4ms=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YSN+IBTls9vtdpn3pRtNBdf73N0qA/tQk3w4RgvlWzio2fknpGVb/a0o7P7flK/1y
	 zzJtGo9wujbVTBo7Axx4HQ/eOiOPbO6DnlaRheiScvIv1C8xSZxJoQ9koobwUIo3/z
	 bcm+sMkCuZPeonMVjryuEdKbJLcNDMKql+Ek0XSn5s5bTJgS271HmzsqC3P/8RVnbU
	 03MMFgLCRnZ3UTWInrk2WkKm17NMBn3d1bcHjdTgKopkzmxW8tAteaboWwKj5BrV20
	 Y92l4G1JtVIu1HmY5gXGwvqSrpdFYgSn3e/bU6+kNyrad4sDexNfki+wGKWiarbNRN
	 562IzeWDAwUbg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C6BC1F40068;
	Tue, 20 Jan 2026 16:48:56 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 16:48:56 -0500
X-ME-Sender: <xms:SPhvaQtWESY-A74K_HEn66lmVvpKNm5MFxR6oEthFHsJh9f_m8HVhg>
    <xme:SPhvaYRYYoD8hzZ-gIklJVxdAnFdEQdnVq654EzYKHMt8mKFQ1HUDx-gqtBhm_VwW
    y-Z6EZs6GGoSKSpdopfG6bYC-99jxEd1TpQw3BiJGcJttr32OeEtWRt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
    hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
    lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SPhvaamXZA19JIcSMetmmNDyPupKYtpsGBX8RUilZqnOb0aJRtehUQ>
    <xmx:SPhvaeTpcVU1Wim3vGB6ES93L_VTC352WS9ZxeyR0pY82SdQj2k7jQ>
    <xmx:SPhvaf64sRrImZuiE0FT-3g9SeUWs7whMFXlvnbGOZ0KmNQDNm2Ajg>
    <xmx:SPhvaVEUXZXhb9_ub-oDB-zXsCXaXQzldUQIcPSpt844LE_RlPLPmA>
    <xmx:SPhvaZHRcYWU9BKUQSIRIo2WYqA9j8HDF7yWiIXBvkQ32EK5DSe3aB5a>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89A9B780070; Tue, 20 Jan 2026 16:48:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfQWKZtCjdVF
Date: Tue, 20 Jan 2026 16:48:31 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 almaz.alexandrovich@paragon-software.com,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com, "Theodore Tso" <tytso@mit.edu>,
 adilger.kernel@dilger.ca, "Carlos Maiolino" <cem@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <38bf1452-8cf8-477b-bcc3-9fe442033bc5@app.fastmail.com>
In-Reply-To: <20260120172608.GQ15551@frogsfrogsfrogs>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260120142439.1821554-2-cel@kernel.org>
 <20260120172608.GQ15551@frogsfrogsfrogs>
Subject: Re: [PATCH v6 01/16] fs: Add case sensitivity flags to file_kattr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	TAGGED_FROM(0.00)[bounces-74741-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 235914CF6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Jan 20, 2026, at 12:26 PM, Darrick J. Wong wrote:
> On Tue, Jan 20, 2026 at 09:24:24AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Enable upper layers such as NFSD to retrieve case sensitivity
>> information from file systems by adding FS_XFLAG_CASEFOLD and
>> FS_XFLAG_CASENONPRESERVING flags.
>> 
>> Filesystems report case-insensitive or case-nonpreserving behavior
>> by setting these flags directly in fa->fsx_xflags. The default
>> (flags unset) indicates POSIX semantics: case-sensitive and
>> case-preserving. These flags are read-only; userspace cannot set
>> them via ioctl.
>> 
>> Relocate struct file_kattr initialization from fileattr_fill_xflags()
>> and fileattr_fill_flags() to vfs_fileattr_get() and the ioctl/syscall
>> call sites. This allows filesystem ->fileattr_get() callbacks to set
>> flags directly in fa->fsx_xflags before invoking the fill functions,
>> which previously would have zeroed those values. Callers that bypass
>> vfs_fileattr_get() must now zero-initialize the struct themselves.
>> 
>> Case sensitivity information is exported to userspace via the
>> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
>> system call.
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/file_attr.c           | 14 ++++++--------
>>  fs/xfs/xfs_ioctl.c       |  2 +-
>>  include/linux/fileattr.h |  3 ++-
>>  include/uapi/linux/fs.h  |  2 ++
>
> This ought to go to linux-api because you're changing the userspace api.
> Granted it's only adding a flag definition to an existing ioctl, but
> FS_XFLAG_CASEFOLD /does/ collide with Andrey's fsverity xflag patch...
>
> (The rest of the changes looks ok to me.)

Process question for Christian: Do you want to see a v7 of this
series with Cc: linux-api before proceeding, or are you taking
both Andrey's and mine and can resolve the conflict, or ... ?


> --D
>
>>  4 files changed, 11 insertions(+), 10 deletions(-)
>> 
>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> index 13cdb31a3e94..2700200c5b9c 100644
>> --- a/fs/file_attr.c
>> +++ b/fs/file_attr.c
>> @@ -15,12 +15,10 @@
>>   * @fa:		fileattr pointer
>>   * @xflags:	FS_XFLAG_* flags
>>   *
>> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
>> - * other fields are zeroed.
>> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
>>   */
>>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
>>  {
>> -	memset(fa, 0, sizeof(*fa));
>>  	fa->fsx_valid = true;
>>  	fa->fsx_xflags = xflags;
>>  	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
>> @@ -46,11 +44,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
>>   * @flags:	FS_*_FL flags
>>   *
>>   * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
>> - * All other fields are zeroed.
>>   */
>>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
>>  {
>> -	memset(fa, 0, sizeof(*fa));
>>  	fa->flags_valid = true;
>>  	fa->flags = flags;
>>  	if (fa->flags & FS_SYNC_FL)
>> @@ -84,6 +80,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>>  	struct inode *inode = d_inode(dentry);
>>  	int error;
>>  
>> +	memset(fa, 0, sizeof(*fa));
>> +
>>  	if (!inode->i_op->fileattr_get)
>>  		return -ENOIOCTLCMD;
>>  
>> @@ -323,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>>  {
>>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>>  	struct dentry *dentry = file->f_path.dentry;
>> -	struct file_kattr fa;
>> +	struct file_kattr fa = {};
>>  	unsigned int flags;
>>  	int err;
>>  
>> @@ -355,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>>  {
>>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>>  	struct dentry *dentry = file->f_path.dentry;
>> -	struct file_kattr fa;
>> +	struct file_kattr fa = {};
>>  	int err;
>>  
>>  	err = copy_fsxattr_from_user(&fa, argp);
>> @@ -434,7 +432,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>>  	struct filename *name __free(putname) = NULL;
>>  	unsigned int lookup_flags = 0;
>>  	struct file_attr fattr;
>> -	struct file_kattr fa;
>> +	struct file_kattr fa = {};
>>  	int error;
>>  
>>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
>> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
>> index 59eaad774371..f0417c4d1fca 100644
>> --- a/fs/xfs/xfs_ioctl.c
>> +++ b/fs/xfs/xfs_ioctl.c
>> @@ -496,7 +496,7 @@ xfs_ioc_fsgetxattra(
>>  	xfs_inode_t		*ip,
>>  	void			__user *arg)
>>  {
>> -	struct file_kattr	fa;
>> +	struct file_kattr	fa = {};
>>  
>>  	xfs_ilock(ip, XFS_ILOCK_SHARED);
>>  	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
>> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
>> index f89dcfad3f8f..709de829659f 100644
>> --- a/include/linux/fileattr.h
>> +++ b/include/linux/fileattr.h
>> @@ -16,7 +16,8 @@
>>  
>>  /* Read-only inode flags */
>>  #define FS_XFLAG_RDONLY_MASK \
>> -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
>> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
>> +	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
>>  
>>  /* Flags to indicate valid value of fsx_ fields */
>>  #define FS_XFLAG_VALUES_MASK \
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index 66ca526cf786..919148beaa8c 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -253,6 +253,8 @@ struct file_attr {
>>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
>> +#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
>> +#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
>>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>>  
>>  /* the read-only stuff doesn't really belong here, but any other place is
>> -- 
>> 2.52.0
>> 
>>

-- 
Chuck Lever

