Return-Path: <linux-fsdevel+bounces-77258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBnbONZ9kmliuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 03:15:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3BA1409D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 03:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74863013D47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF58285C9F;
	Mon, 16 Feb 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="GP2wQelf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E123EAA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208138; cv=none; b=OgJznjYc6IKNEid1Lv1fb0FPQ/IzaAesHQZAx9pVuovdoCpyZoSihwYTw+TJksbR7VsHIl5LgtFi2QNOn5drifRY2rMq3g1ZjRZYMSnT1EIJ/GiAZ6QQM7MKQpFBvGC/0osWK8dtBKya8+PTvsFnPgj/jB6ht4dnZC+XuN7IszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208138; c=relaxed/simple;
	bh=1FCj4Y9pz/hy5DjQzcr7+nnBTjXTVmOB4qNl63Hc/pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cOqYMaBcdz8AeO+EoJjQ3AM/CfqFDYRFrnNRw3QCQhgMSAkhKBquv4jMPdC4o4Ht3mb02PPW3VX0mrf/8AwN6GmKuHqYKewbYb6tc7FamYdNWN1rwnG3U62AFe6u2dEFPGzG3FuKpuxTv7oDnMRXIcEvpU/UkuUJ0hE5wErok2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=GP2wQelf; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A44FB240027
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 03:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771208133; bh=k3EzpFU/t1ws3r8PN0AZTb2r4wxGY13vZPXCuTkwBKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=GP2wQelfMhpkLWaDHUPReaW3jZf+gn+/m3p1XE016zDCfh9Xg/FgM0mKoqaZdPZlp
	 O0/C1+/+vCPtYXXHNdzq1mIH6aLptPlpMAXpeGZbnKeT2gsayfNBrIhwQDwuUk7v0U
	 hIYh7JbVgMYokOl32UolFCllhJNChOmEw4B7dGeiwnNfAssJTd6d3fu5Wsi6AArCxq
	 xPmL4iJ0MLaHxr+TIUX7BeQwbkZCdez3u5VLK8foJ9h4i6o824+ZXV33RV5UPtKtNb
	 dmNSgEX4aBoXBFNv1U3f9X4Qhqs/C+0lFkVCD7XinjfE4q1MW/OBuKn9LzetC2lKkV
	 xDcjTSC2YyFRw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fDmZr1c4Hz6txj;
	Mon, 16 Feb 2026 03:15:32 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: slava@dubeyko.com,  glaubitz@physik.fu-berlin.de,  frank.li@vivo.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hfsplus: fix uninit-value by validating catalog
 record size
In-Reply-To: <20260214002100.436125-1-kartikey406@gmail.com>
References: <20260214002100.436125-1-kartikey406@gmail.com>
Date: Mon, 16 Feb 2026 02:15:33 +0000
Message-ID: <87seb1v3gc.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77258-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,posteo.net:mid,posteo.net:dkim,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A3BA1409D9
X-Rspamd-Action: no action

Deepanshu Kartikey <kartikey406@gmail.com> writes:

> Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp(). The
> root cause is that hfs_brec_read() doesn't validate that the on-disk
> record size matches the expected size for the record type being read.
>
> When mounting a corrupted filesystem, hfs_brec_read() may read less data
> than expected. For example, when reading a catalog thread record, the
> debug output showed:
>
>   HFSPLUS_BREC_READ: rec_len=520, fd->entrylength=26
>   HFSPLUS_BREC_READ: WARNING - entrylength (26) < rec_len (520) - PARTIAL READ!
>
> hfs_brec_read() only validates that entrylength is not greater than the
> buffer size, but doesn't check if it's less than expected. It successfully
> reads 26 bytes into a 520-byte structure and returns success, leaving 494
> bytes uninitialized.
>
> This uninitialized data in tmp.thread.nodeName then gets copied by
> hfsplus_cat_build_key_uni() and used by hfsplus_strcasecmp(), triggering
> the KMSAN warning when the uninitialized bytes are used as array indices
> in case_fold().
>
> Fix by introducing hfsplus_brec_read_cat() wrapper that:
> 1. Calls hfs_brec_read() to read the data
> 2. Validates the record size based on the type field:
>    - Fixed size for folder and file records
>    - Variable size for thread records (depends on string length)
> 3. Returns -EIO if size doesn't match expected
>
> Also initialize the tmp variable in hfsplus_find_cat() as defensive
> programming to ensure no uninitialized data even if validation is
> bypassed.
>
> Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/ [v1]
> Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/ [v2]
> Link: https://lore.kernel.org/all/20260212014233.2422046-1-kartikey406@gmail.com/ [v3]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v4:
> - Move hfsplus_cat_thread_size() as static inline to header file as
>   suggested by Viacheslav Dubeyko
>
> Changes in v3:
> - Introduced hfsplus_brec_read_cat() wrapper function for catalog-specific
>   validation instead of modifying generic hfs_brec_read()
> - Added hfsplus_cat_thread_size() helper to calculate variable-size thread
>   record sizes
> - Use exact size match (!=) instead of minimum size check (<)
> - Use sizeof(hfsplus_unichr) instead of hardcoded value 2
> - Updated all catalog record read sites to use new wrapper function
> - Addressed review feedback from Viacheslav Dubeyko
>
> Changes in v2:
> - Use structure initialization (= {0}) instead of memset()
> - Improved commit message to clarify how uninitialized data is used
> ---
>  fs/hfsplus/bfind.c      | 46 +++++++++++++++++++++++++++++++++++++++++
>  fs/hfsplus/catalog.c    |  4 ++--
>  fs/hfsplus/dir.c        |  2 +-
>  fs/hfsplus/hfsplus_fs.h |  9 ++++++++
>  fs/hfsplus/super.c      |  2 +-
>  5 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9b89dce00ee9..4c5fd21585ef 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -297,3 +297,49 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
>  	fd->bnode = bnode;
>  	return res;
>  }
> +
> +/**
> + * hfsplus_brec_read_cat - read and validate a catalog record
> + * @fd: find data structure
> + * @entry: pointer to catalog entry to read into
> + *
> + * Reads a catalog record and validates its size matches the expected
> + * size based on the record type.
> + *
> + * Returns 0 on success, or negative error code on failure.
> + */
> +int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
> +{
> +	int res;
> +	u32 expected_size;
> +
> +	res = hfs_brec_read(fd, entry, sizeof(hfsplus_cat_entry));
> +	if (res)
> +		return res;
> +
> +	/* Validate catalog record size based on type */
> +	switch (be16_to_cpu(entry->type)) {
> +	case HFSPLUS_FOLDER:
> +		expected_size = sizeof(struct hfsplus_cat_folder);
> +		break;
> +	case HFSPLUS_FILE:
> +		expected_size = sizeof(struct hfsplus_cat_file);
> +		break;
> +	case HFSPLUS_FOLDER_THREAD:
> +	case HFSPLUS_FILE_THREAD:
> +		expected_size = hfsplus_cat_thread_size(&entry->thread);

Should we check fd->entrylength < HFSPLUS_MIN_THREAD_SZ here before
calling hfsplus_cat_thread_size(), so we don't read uninitialized
nodeName.length at call sites that don't zero-initialize entry?
hfsplus_readdir() already does this check for thread records.

Cheers,
C. Mitrodimas

> +		break;
> +	default:
> +		pr_err("unknown catalog record type %d\n",
> +		       be16_to_cpu(entry->type));
> +		return -EIO;
> +	}
> +
> +	if (fd->entrylength != expected_size) {
> +		pr_err("catalog record size mismatch (type %d, got %u, expected %u)\n",
> +		       be16_to_cpu(entry->type), fd->entrylength, expected_size);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..6c8380f7208d 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -194,12 +194,12 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
>  int hfsplus_find_cat(struct super_block *sb, u32 cnid,
>  		     struct hfs_find_data *fd)
>  {
> -	hfsplus_cat_entry tmp;
> +	hfsplus_cat_entry tmp = {0};
>  	int err;
>  	u16 type;
>  
>  	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
> -	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
> +	err = hfsplus_brec_read_cat(fd, &tmp);
>  	if (err)
>  		return err;
>  
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index cadf0b5f9342..d86e2f7b289c 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -49,7 +49,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
>  	if (unlikely(err < 0))
>  		goto fail;
>  again:
> -	err = hfs_brec_read(&fd, &entry, sizeof(entry));
> +	err = hfsplus_brec_read_cat(&fd, &entry);
>  	if (err) {
>  		if (err == -ENOENT) {
>  			hfs_find_exit(&fd);
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 45fe3a12ecba..e811d33861af 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -506,6 +506,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
>  		       void **data, blk_opf_t opf);
>  int hfsplus_read_wrapper(struct super_block *sb);
>  
> +static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
> +{
> +	return offsetof(struct hfsplus_cat_thread, nodeName) +
> +	       offsetof(struct hfsplus_unistr, unicode) +
> +	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
> +}
> +
> +int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
> +
>  /*
>   * time helpers: convert between 1904-base and 1970-base timestamps
>   *
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index aaffa9e060a0..e59611a664ef 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -567,7 +567,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
>  	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
>  	if (unlikely(err < 0))
>  		goto out_put_root;
> -	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> +	if (!hfsplus_brec_read_cat(&fd, &entry)) {
>  		hfs_find_exit(&fd);
>  		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
>  			err = -EIO;

