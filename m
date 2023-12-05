Return-Path: <linux-fsdevel+bounces-4910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1A806381
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45E51C2082D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC3D267
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GuQe3qqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFFB1A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:48:12 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c6839373f8so214317a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701816492; x=1702421292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHy1w+JD5Q88xP819aNUz9Tjru/lN5k69ip+1MV5fIc=;
        b=GuQe3qqmqob7Ke6tvQ3YOAsq8m4tFwyf39FvwHEiqxzE7ePNnGP/DJZ40K7azZcsEp
         LWruNcicNHIWnXIydMNnc89xsii/2KjpYAFMnBgK84j7iQUYG2XOuiRln5Tv36pnVJCk
         XxXd475mc7E1o7ZDQ1sPQOxCbP553M/XJScSzasF/hS1o9j4A/Jb6vPFUmHYTYn5dE0o
         Jo/zrVNOoitZ/wFfagRVF43DhsZj1KGOZy9FPNnqTE/Br1Vt08i4C33okM+rG6M3DM5h
         xLWQ9xQKB+/b8/iek/BSbpYkam1RrmxyTnZdssZ3lj7oR3FKFL7d4rPAvr6JHHpBDerf
         6HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816492; x=1702421292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHy1w+JD5Q88xP819aNUz9Tjru/lN5k69ip+1MV5fIc=;
        b=r91v7a0owa03ajeCaWB7YXKGzrUV7/GvgobCiQiaCTVfWqmUQjpEqitZQAPQ+DIo1u
         +2LfUmc5qA9n/OqQ1L9tfZAG+xvBvjki/IExvPgdZhPSMLaU/M/9uW13hxynJGOgx7JN
         G+qfesNMvuBTYLwhC3bU0L6VF92ogzpg1sDV9HC6D+iBsCV3I1ixRhE4VrROyPBCkvCQ
         SltPOlZDNr7HXQn7vGQHao4R07u6By1ln68mWCda8ZDH2Vtbb37PbhsYnXfePA9Cim1a
         78OEshvx/CeqSlf9wf7ZBLKxA38KJE/+rEbsDVux+lC0uRP0h3d6HhiLY6mi12kDMxmJ
         I9Ww==
X-Gm-Message-State: AOJu0YyPsdpkjr3nd18JGN4ZV1sEy0tF3Hg8cmD0FEFOy+eb1Fk6VKKs
	CyPuf+EDljrJojtIhEKRuBNKAQ==
X-Google-Smtp-Source: AGHT+IHV+/zbqOXUZF1KsLLitWZprjzUeTRGvvEl6r3XYdQ37wEk+553SfBH6ejLGj81oyHjOFLtuQ==
X-Received: by 2002:a17:90a:52:b0:286:ab7f:af5e with SMTP id 18-20020a17090a005200b00286ab7faf5emr2265102pjb.24.1701816491965;
        Tue, 05 Dec 2023 14:48:11 -0800 (PST)
Received: from localhost ([2620:10d:c090:600::2:6d30])
        by smtp.gmail.com with ESMTPSA id px10-20020a17090b270a00b0028098225450sm6082389pjb.1.2023.12.05.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:48:11 -0800 (PST)
Date: Tue, 5 Dec 2023 17:48:09 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 02/46] fscrypt: add per-extent encryption support
Message-ID: <20231205224809.GA15355@localhost.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5e91532d4f6ddb10af8aac7f306186d6f1b9e917.1701468306.git.josef@toxicpanda.com>
 <20231205035820.GE1168@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205035820.GE1168@sol.localdomain>

On Mon, Dec 04, 2023 at 07:58:20PM -0800, Eric Biggers wrote:
> On Fri, Dec 01, 2023 at 05:10:59PM -0500, Josef Bacik wrote:
> > The file system indicates it wants to use per-extent encryption by
> > setting s_cop->set_extent_context.
> 
> It's actually s_cop->has_per_extent_encryption.
> 
> > diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> > index 1892356cf924..03c006e5c47d 100644
> > --- a/fs/crypto/fscrypt_private.h
> > +++ b/fs/crypto/fscrypt_private.h
> [...]
> > @@ -30,6 +30,8 @@
> >  #define FSCRYPT_CONTEXT_V1	1
> >  #define FSCRYPT_CONTEXT_V2	2
> >  
> > +#define FSCRYPT_EXTENT_CONTEXT_V1	1
> > +
> >  /* Keep this in sync with include/uapi/linux/fscrypt.h */
> >  #define FSCRYPT_MODE_MAX	FSCRYPT_MODE_AES_256_HCTR2
> >  
> > @@ -53,6 +55,28 @@ struct fscrypt_context_v2 {
> >  	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> >  };
> 
> Hmm, I think we're going to want fscrypt_context => fscrypt_inode_context too...
> Also FSCRYPT_FILE_NONCE_SIZE => FSCRYPT_NONCE_SIZE.  I guess don't worry about
> it for now, though.
> 
> > +/*
> > + * fscrypt_extent_context - the encryption context of an extent
> > + *
> > + * This is the on-disk information stored for an extent.  The policy and
> > + * relevante information is stored in the inode, the per-extent information is
> > + * simply the nonce that's used in as KDF input in conjunction with the inode
> > + * context to derive a per-extent key for encryption.
> > + *
> > + * At this point the master_key_identifier exists only for possible future
> > + * expansion.  This will allow for an inode to have extents with multiple master
> > + * keys, although sharing the same encryption mode.  This would be for re-keying
> > + * or for reflinking between two differently encrypted inodes.  For now the
> > + * master_key_descriptor must match the inode's, and we'll be using the inode's
> > + * for all key derivation.
> > + */
> > +struct fscrypt_extent_context {
> > +	u8 version; /* FSCRYPT_EXTENT_CONTEXT_V2 */
> > +	u8 encryption_mode;
> > +	u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
> > +	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> > +};
> 
> s/relevante/relevant/
> s/FSCRYPT_EXTENT_CONTEXT_V2/FSCRYPT_EXTENT_CONTEXT_V1/
> s/master_key_descriptor/master_key_identifier/
> 
> The second paragraph also contradicts the first, which says that the context
> "is simply the nonce".
> 
> Also, encryption_mode is there for the same reason as master_key_identifier,
> right?  The comment only mentions master_key_identifier.
> 
> > +/*
> > + * fscrypt_extent_info - the "encryption key" for an extent.
> > + *
> > + * This contains the dervied key for the given extent and the nonce for the
> > + * extent.
> > + */
> 
> s/dervied/derived/
> 
> > +struct fscrypt_extent_info {
> > +	refcount_t refs;
> > +	/* This is the extents nonce, loaded from the fscrypt_extent_context */
> > +	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> 
> s/extents/extent's/
> 
> > diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> > index b4002aea7cdb..4eeb75410ba8 100644
> > --- a/fs/crypto/inline_crypt.c
> > +++ b/fs/crypto/inline_crypt.c
> [...]
> > +/**
> > + * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
> > + * @bio: a bio which will eventually be submitted to the file
> > + * @inode: the file's inode
> > + * @ei: the extent's crypto info
> > + * @first_lblk: the first file logical block number in the I/O
> > + * @gfp_mask: memory allocation flags - these must be a waiting mask so that
> > + *					bio_crypt_set_ctx can't fail.
> > + *
> > + * If the contents of the file should be encrypted (or decrypted) with inline
> > + * encryption, then assign the appropriate encryption context to the bio.
> > + *
> > + * Normally the bio should be newly allocated (i.e. no pages added yet), as
> > + * otherwise fscrypt_mergeable_bio() won't work as intended.
> > + *
> > + * The encryption context will be freed automatically when the bio is freed.
> > + */
> > +void fscrypt_set_bio_crypt_ctx_from_extent(struct bio *bio,
> > +					   const struct inode *inode,
> > +					   const struct fscrypt_extent_info *ei,
> > +					   u64 first_lblk, gfp_t gfp_mask)
> > +{
> > +	const struct fscrypt_inode_info *ci;
> > +	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
> > +
> > +	if (!fscrypt_inode_uses_inline_crypto(inode))
> > +		return;
> > +	ci = inode->i_crypt_info;
> > +
> > +	fscrypt_generate_dun(ci, first_lblk, dun);
> > +	bio_crypt_set_ctx(bio, ei->prep_key.blk_key, dun, gfp_mask);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_from_extent);
> 
> Silently leaving the data unencrypted if
> !fscrypt_inode_uses_inline_crypto(inode) is dangerous.  I think you should just
> leave that part out.  It was already checked in fscrypt_load_extent_info().
> 
> Also, I think that for now we should keep things simple by doing the following
> instead of fscrypt_generate_dun():
> 
> 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE] = { first_lblk };
> 
> Note that these two changes would eliminate the need for the inode parameter to
> the function.
> 
> Please also make sure to update the function comment.  Note that the first line
> gives the function name incorrectly.
> 

First off thanks for the review, I'm currently going through it one by one, so
I've come to this bit and I've got a question.

The DUN has to be le64, so this strictly isn't ok.  So would you be ok with

__le64 first_lblk_le = le64_to_cpu(first_lblk;
u64 dun [BLK_CRYPTO_DUN_ARRAY_SIZE] = { first_lblk_le };

or do you want something different?  Additionally fscrypt_generate_dun() also
takes into account the data units per block bits, which as I'm typing this out
I'm realizing doesn't really matter for us even if we have different sectorsize
per pagesize.  I guess I'll put a big comment about why we're not using that in
there to make sure future Josef isn't confused.

> > +/**
> > + * fscrypt_mergeable_extent_bio() - test whether data can be added to a bio
> > + * @bio: the bio being built up
> > + * @inode: the inode for the next part of the I/O
> > + * @ei: the fscrypt_extent_info for this extent
> > + * @next_lblk: the next file logical block number in the I/O
> > + *
> > + * When building a bio which may contain data which should undergo inline
> > + * encryption (or decryption) via fscrypt, filesystems should call this function
> > + * to ensure that the resulting bio contains only contiguous data unit numbers.
> > + * This will return false if the next part of the I/O cannot be merged with the
> > + * bio because either the encryption key would be different or the encryption
> > + * data unit numbers would be discontiguous.
> > + *
> > + * fscrypt_set_bio_crypt_ctx_from_extent() must have already been called on the
> > + * bio.
> > + *
> > + * This function isn't required in cases where crypto-mergeability is ensured in
> > + * another way, such as I/O targeting only a single file (and thus a single key)
> > + * combined with fscrypt_limit_io_blocks() to ensure DUN contiguity.
> > + *
> > + * Return: true iff the I/O is mergeable
> > + */
> > +bool fscrypt_mergeable_extent_bio(struct bio *bio, const struct inode *inode,
> > +				  const struct fscrypt_extent_info *ei,
> > +				  u64 next_lblk)
> > +{
> > +	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> > +	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
> > +
> > +	if (!ei)
> > +		return true;
> > +	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
> > +		return false;
> > +	if (!bc)
> > +		return true;
> > +
> > +	/*
> > +	 * Comparing the key pointers is good enough, as all I/O for each key
> > +	 * uses the same pointer.  I.e., there's currently no need to support
> > +	 * merging requests where the keys are the same but the pointers differ.
> > +	 */
> > +	if (bc->bc_key != ei->prep_key.blk_key)
> > +		return false;
> > +
> > +	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
> > +	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_mergeable_extent_bio);
> 
> Similarly, I think we should keep things simple here.  With extent-based
> encryption not supporting any "weird" IV generation methods, the filesystem just
> needs to ensure that bios target a logically contiguous range in one file only.
> 
> It looks like btrfs already ensures that, as per the following code:
> 
> 	/*
> 	 * The contig check requires the following conditions to be met:
> 	 *
> 	 * 1) The pages are belonging to the same inode
> 	 *    This is implied by the call chain.
> 	 *
> 	 * 2) The range has adjacent logical bytenr
> 	 *
> 	 * 3) The range has adjacent file offset
> 	 *    This is required for the usage of btrfs_bio->file_offset.
> 	 */
> 	return bio_end_sector(bio) == sector &&
> 		page_offset(bvec->bv_page) + bvec->bv_offset + bvec->bv_len ==
> 		page_offset(page) + pg_offset;
> 
> 
> So I think you could just delete fscrypt_mergeable_extent_bio() and the
> IS_ENCRYPTED() special case in btrfs_bio_is_contig(), and everything would still
> work fine.
> 
> The existing fully general mergeability check is mainly for
> FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32, where the DUN can wrap around at random
> places, and for f2fs which can build bios containing data of many different
> files.  Without those, just "same file + contiguous logical blocks" suffices.
> 
> > +static struct fscrypt_extent_info *
> > +setup_extent_info(struct inode *inode, const u8 nonce[FSCRYPT_FILE_NONCE_SIZE])
> > +{
> > +	struct fscrypt_extent_info *ei;
> > +	struct fscrypt_inode_info *ci;
> > +	struct fscrypt_master_key *mk;
> > +	u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
> > +	int err;
> > +
> > +	ci = inode->i_crypt_info;
> > +	mk = ci->ci_master_key;
> > +	if (!mk)
> > +		return ERR_PTR(-ENOKEY);
> 
> mk being NULL here would be a bug, right?  Maybe WARN_ON_ONCE() on it?
> 
> > +
> > +	ei = kmem_cache_zalloc(fscrypt_extent_info_cachep, GFP_KERNEL);
> > +	if (!ei)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	refcount_set(&ei->refs, 1);
> > +	memcpy(ei->nonce, nonce, FSCRYPT_FILE_NONCE_SIZE);
> > +	ei->sb = inode->i_sb;
> > +
> > +	down_read(&mk->mk_sem);
> > +	/*
> > +	 * We specifically don't do is_master_key_secret_present() here because
> > +	 * if the inode is open and has a reference on the master key then it
> > +	 * should be available for us to use.
> > +	 */
> 
> ->mk_secret, not is_master_key_secret_present()
> 
> > +
> > +	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
> > +				  HKDF_CONTEXT_PER_FILE_ENC_KEY, ei->nonce,
> > +				  FSCRYPT_FILE_NONCE_SIZE, derived_key,
> > +				  ci->ci_mode->keysize);
> > +	if (err)
> > +		goto out_free;
> 
> Reusing HKDF_CONTEXT_PER_FILE_ENC_KEY here is misleading, as this isn't deriving
> a per-file key.  Cryptographically it's okay, since it's still following the
> same pattern with the 16-byte nonce, but I'm thinking it would be best to
> introduce a new HKDF context byte as follows:
> 
> 	#define HKDF_CONTEXT_PER_EXTENT_ENC_KEY 8 /* info=extent_nonce          */
> 
> > +/**
> > + * fscrypt_prepare_new_extent() - prepare to create a new extent for a file
> > + * @inode: the possibly-encrypted inode
> > + *
> > + * If the inode is encrypted, setup the fscrypt_extent_info for a new extent.
> > + * This will include the nonce and the derived key necessary for the extent to
> > + * be encrypted.  This is only meant to be used with inline crypto.
> > + *
> > + * This doesn't persist the new extents encryption context, this is done later
> > + * by calling fscrypt_set_extent_context().
> > + *
> > + * Return: The newly allocated fscrypt_extent_info on success, -EOPNOTSUPP if
> > + *	   we're not encrypted, or another -errno code
> > + */
> > +struct fscrypt_extent_info *fscrypt_prepare_new_extent(struct inode *inode)
> > +{
> > +	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> > +
> > +	if (!fscrypt_inode_uses_inline_crypto(inode))
> > +		return ERR_PTR(-EOPNOTSUPP);
> > +
> > +	get_random_bytes(nonce, FSCRYPT_FILE_NONCE_SIZE);
> > +	return setup_extent_info(inode, nonce);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_prepare_new_extent);
> 
> The behavior of this on failure is not clear.  AFAICS it actually does:
> 
> 	inode is not an encryted regular file, -EOPNOTSUPP
> 	else if inode does not have key set up, NULL dereference
> 	else if inode does not use inline crypto, -EOPNOTSUPP
> 
> But it's a bug for any of those three cases to be reached at all, right?  I.e.,
> this function is only for inodes for encrypted regular files that have already
> had their key set up, on filesystems that force the use of inline crypto?
> 
> I'm wondering if we should make all those cases trigger a WARN_ON_ONCE() and
> document the preconditions for this function appropriately.
> 

Agreed, I was actually using the NULL dereference case to find bugs where I
wasn't loading the context properly lol.

> > +/**
> > + * fscrypt_load_extent_info() - create an fscrypt_extent_info from the context
> > + * @inode: the inode
> > + * @ctx: the context buffer
> > + * @ctx_size: the size of the context buffer
> > + *
> > + * Create the file_extent_info and derive the key based on the
> > + * fscrypt_extent_context buffer that is probided.
> 
> s/file_extent_info/fscrypt_extent_info/
> s/probided/provided/
> 
> > + * Return: The newly allocated fscrypt_extent_info on success, -EOPNOTSUPP if
> > + *	   we're not encrypted, or another -errno code
> > + */
> > +struct fscrypt_extent_info *fscrypt_load_extent_info(struct inode *inode,
> > +						     u8 *ctx, size_t ctx_size)
> > +{
> > +	struct fscrypt_extent_context extent_ctx;
> > +	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
> > +	const struct fscrypt_policy_v2 *policy = &ci->ci_policy.v2;
> > +
> > +	if (!fscrypt_inode_uses_inline_crypto(inode))
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> Same comment as fscrypt_prepare_new_extent().  Should there be a WARN_ON_ONCE()
> here, and also an explicit check for the inode's key being set up?
> 
> > +	if (ctx_size < sizeof(extent_ctx))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	memcpy(&extent_ctx, ctx, sizeof(extent_ctx));
> > +
> > +	/*
> > +	 * For now we need to validate that the master key for the inode matches
> > +	 * the extent.
> > +	 */
> > +	if (memcmp(extent_ctx.master_key_identifier,
> > +		   policy->master_key_identifier,
> > +		   sizeof(extent_ctx.master_key_identifier)))
> > +		return ERR_PTR(-EINVAL);
> 
> extent_ctx.version and extent_ctx.encryption_mode both need to be validated.
> 
> Also, it would be helpful if there were appropriate warning messages (using
> fscrypt_warn()) upon seeing an unsupported extent context, similar to the
> messages that get printed when seeing an unsupported inode context.
> 
> > +EXPORT_SYMBOL(fscrypt_load_extent_info);
> 
> EXPORT_SYMBOL_GPL for any new exported symbols in fs/crypto/, please.
> 
> > +/**
> > + * fscrypt_put_extent_info() - free the extent_info fscrypt data
> 
> fscrypt_put_extent_info() - put a reference to an fscrypt extent info
> 
> > + * @ei: the extent_info being evicted
> 
> @ei: the extent info being evicted or NULL
> 
> (BTW, is the NULL support really needed?)
> 
> > + * Note this will unload the key from the block layer, which takes the crypto
> > + * profile semaphore to unload the key.  Make sure you're not dropping this in a
> > + * context that can't sleep.
> > + */
> 
> "Might sleep, since this may call blk_crypto_evict_key() which can sleep."
> 
> > +void fscrypt_put_extent_info(struct fscrypt_extent_info *ei)
> > +{
> > +	if (!ei)
> > +		return;
> > +
> > +	if (!refcount_dec_and_test(&ei->refs))
> > +		return;
> > +
> > +	fscrypt_destroy_prepared_key(ei->sb, &ei->prep_key);
> > +	memzero_explicit(ei, sizeof(*ei));
> > +	kmem_cache_free(fscrypt_extent_info_cachep, ei);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_put_extent_info);
> 
> This would look cleaner as:
> 
> 	if (ei && refcount_dec_and_test(&ei->refs)) {
> 		...
> 	}
> 
> > +
> > +/**
> > + * fscrypt_get_extent_info() - get a ref on the fscrypt extent info
> 
> fscrypt_get_extent_info() - get a reference to an fscrypt extent info
> 
> > + * @ei: the extent_info to get.
> > + *
> > + * Get a reference on the fscrypt_extent_info.
> > + *
> 
> An explanation here about why filesystems would need to use this would be
> useful.
> 
> > + * Return: the ei with an extra ref, NULL if there was no ei passed in.
> 
> Return: the ei with an extra ref, or NULL if ei was NULL.
> 
> > + */
> > +struct fscrypt_extent_info *fscrypt_get_extent_info(struct fscrypt_extent_info *ei)
> > +{
> > +	if (!ei)
> > +		return NULL;
> > +	refcount_inc(&ei->refs);
> > +	return ei;
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_get_extent_info);
> 
> Similarly, this would look cleaner as:
> 
> 	if (ei)
> 		refcount_inc(&ei->refs);
> 	return ei;
> 
> > diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> > index 701259991277..75a69f02f11d 100644
> > --- a/fs/crypto/policy.c
> > +++ b/fs/crypto/policy.c
> > @@ -209,6 +209,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
> >  		return false;
> >  	}
> >  
> > +	if (inode->i_sb->s_cop->has_per_extent_encryption) {
> > +		fscrypt_warn(inode,
> > +			     "v1 policies can't be used on file systems that use extent encryption");
> > +		return false;
> 
> Maybe "can't be used" => "aren't supported", to be consistent with the other
> message you're adding.
> 
> > +	}
> > +
> >  	return true;
> >  }
> >  
> > @@ -269,6 +275,12 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
> >  		}
> >  	}
> >  
> > +	if ((inode->i_sb->s_cop->has_per_extent_encryption) && count) {
> > +		fscrypt_warn(inode,
> > +			     "Encryption flags aren't supported on file systems that use extent encryption");
> > +		return false;
> > +	}
> 
> Maybe move this up to where count is being checked already, so that the code
> looks like:
> 
> 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
> 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64);
> 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32);
> 	if (count > 0 && inode->i_sb->s_cop->has_per_extent_encryption) {
> 		fscrypt_warn(inode,
> 				"Encryption flags aren't supported on file systems that use extent encryption");
> 		return false;
> 	}
> 	if (count > 1) {
> 
> > +/**
> > + * fscrypt_set_extent_context() - Set the fscrypt extent context of a new extent
> > + * @inode: the inode this extent belongs to
> > + * @ei: the fscrypt_extent_info for the given extent
> > + * @buf: the buffer to copy the fscrypt extent context into
> > + *
> > + * This should be called after fscrypt_prepare_new_extent(), using the
> > + * fscrypt_extent_info that was created at that point.
> > + *
> > + * Return: the size of the fscrypt_extent_context, errno if the inode has the
> > + *	   wrong policy version.
> > + */
> > +ssize_t fscrypt_set_extent_context(struct inode *inode,
> > +				   struct fscrypt_extent_info *ei, u8 *buf)
> > +{
> > +	struct fscrypt_extent_context *ctx = (struct fscrypt_extent_context *)buf;
> > +	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
> > +
> > +	if (ci->ci_policy.version != 2)
> > +		return -EINVAL;
> > +
> > +	ctx->version = 1;
> > +	memcpy(ctx->master_key_identifier,
> > +	       ci->ci_policy.v2.master_key_identifier,
> > +	       sizeof(ctx->master_key_identifier));
> > +	memcpy(ctx->nonce, ei->nonce, FSCRYPT_FILE_NONCE_SIZE);
> > +	return sizeof(struct fscrypt_extent_context);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_set_extent_context);
> 
> Well, this doesn't *set* an extent context.  It generates one.  Basically it's
> the extent equivalent of fscrypt_context_for_new_inode().  Maybe call this
> fscrypt_context_for_new_extent()?
> 
> Also, 'ci->ci_policy.version != 2' indicates a bug, so it should be a
> WARN_ON_ONCE().
> 
> Also, the literal 1 should be FSCRYPT_EXTENT_CONTEXT_V1.
> 
> Also, the expected size of the buffer needs to be documented (as it is for
> fscrypt_context_for_new_inode()).  It's FSCRYPT_SET_CONTEXT_MAX_SIZE, right?
> 
> It might be a good idea to also add the following:
> 
> 	BUILD_BUG_ON(sizeof(struct fscrypt_extent_context) >
>                      FSCRYPT_SET_CONTEXT_MAX_SIZE);
> > +/**
> > + * fscrypt_extent_context_size() - Return the size of the on-disk extent context
> > + * @inode: the inode this extent belongs to.
> > + *
> > + * Return the size of the extent context for this inode.  Since there is only
> > + * one extent context version currently this is just the size of the extent
> > + * context if the inode is encrypted.
> > + */
> > +size_t fscrypt_extent_context_size(struct inode *inode)
> > +{
> > +	if (!IS_ENCRYPTED(inode))
> > +		return 0;
> > +
> > +	return sizeof(struct fscrypt_extent_context);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_extent_context_size);
> 
> Huh, shouldn't the filesystem use the size from fscrypt_set_extent_context() (or
> fscrypt_context_for_new_extent() as I recommend calling it)?  Why is the above
> function necessary?

This is because we need to know how big the context is ahead of time before
searching down the b-tree to insert the file extent item, and we have to add
this size to the file extent item ahead of time.  The disconnect between when we
need to know how big it'll be and when we actually generate the context to save
on disk is the reason for there being two helpers.

The main reason for this is code separation.  I would have to have the context
on stack for the !fscrypt case if I were to only have one helper, because I
would need it there to generate the extent context to save on disk to pass it
around to all the things that add file extents, and I could use the length from
that.  Not a huge deal, but this way is a little cleaner.  You can see how I've
used the two helpers in later patches, but the general flow is

total_size = sizeof(our file extent);
total_size += fscrypt_extent_context_size(inode);

btrfs_insert_empty_item(path, total_size);

btrfs_fscrypt_save_extent_info(path, inode);

and then in btrfs_fscrypt_save_extent_info() we do

u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];

size = fscrypt_set_extent_context(inode, ctx);

Now the above case does seem like we could just uconditionally do something like

u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];

total_size = sizeof(our file extent);
ctx_size = fscrypt_set_extent_context(inode, ctx);
if (ctx_size < 0)
	goto error;
total_size += ctx_size;
btrfs_insert_empty_item(path, total_size);
copy_ctx_into_file_extent(path, ctx);

But there's some other file extent manipulation cases that aren't this clear
cut, so I'd have to pass this ctx around to be copied in.  And in the !encrypted
part we're paying a higher stack memory cost.

If you still don't like this I can rework it, but I wanted to explain my
reasoning before I went changing a bunch of stuff to make the new paradigm fit.

The rest of the comments make sense, I'll fix everything up.  Thanks,

Josef

