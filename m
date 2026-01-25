Return-Path: <linux-fsdevel+bounces-75384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP6LC7otdmnEMwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:50:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1381141
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F75300BD98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D5A324701;
	Sun, 25 Jan 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M89xD5TT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664114BF92;
	Sun, 25 Jan 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352606; cv=none; b=XiAIDceuvFsjlHQkj1vg5qWwo4koDsiPrBSnRS9VmVNZdYdnOu5Tycfgg6m0lwPOAaeBMUAuI+2mJavr3uJa00esKqLQlB4MOfcEghad/JIiduF3WeU1Loc1vnxY7J5daoJ33geXIHO3/W2LibkIg+ZakwXLcLcPi9+J7WpDj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352606; c=relaxed/simple;
	bh=Qb77RiWgyHm5SU1GmS1LMhqiQbtCFBFXaWxM/S1HaDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIVjqD3CMdXhJnGzUOii0EmiKVuTHws+JSQqshY5geS656QD/iaqtsvdcWtQ8qzyYbKjajdWRwnjM5rs4Qg9byA0ecICR2AxMnIPU+bWcHspEL44+Q1kgkuzYJM3o+Yv3zTocORwcDqRQe4FY5ilcllT9Nl8vGjPmmMztitwNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M89xD5TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70185C19421;
	Sun, 25 Jan 2026 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769352606;
	bh=Qb77RiWgyHm5SU1GmS1LMhqiQbtCFBFXaWxM/S1HaDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M89xD5TT4e8L24TFAy59ViAy3loqol6G07UhfkgnivqN0T1QHIeXLK6KufoCrmnXv
	 kekwqOI8IRA4bMgS3j6olFfRKZTjyIBt4fMtWD+6LFJ0ZGBnPwkx1Vvk3JrvMW2Ll4
	 zC5Vge1F4V9gjzvpVRyB4bOSiYG1Efwk0TeU8NIXylAL1tIZq8vI4gcuC9uXB2RLeh
	 JBN9Hl+6DYuHM7nuJ5FN1dElHztg8/NLO1X1HlWuX25qrluftOw7nVx6DrXppnlOtZ
	 MyTpao/Eq+4i/v4tPdubm9C3tLQzM8HcEkPI3lCw90Wg6LIyuqGLw6gE9EaZT2Y1at
	 1DQ8tqzm59ruQ==
Date: Sun, 25 Jan 2026 16:50:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
	linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
Message-ID: <aXYtmbL40r5wLgk2@kernel.org>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,kernel.org,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	TAGGED_FROM(0.00)[bounces-75384-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: BDF1381141
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:06:17PM +0000, Lorenzo Stoakes wrote:
> In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> shmem file setup functions to operate in terms of vma_flags_t rather than
> vm_flags_t.
> 
> This patch makes this change and updates all callers to use the new
> functions.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
>  drivers/gpu/drm/drm_gem.c                 |  5 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
>  drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
>  drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
>  drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
>  drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
>  fs/xfs/scrub/xfile.c                      |  3 +-
>  fs/xfs/xfs_buf_mem.c                      |  2 +-
>  include/linux/shmem_fs.h                  |  8 ++-
>  ipc/shm.c                                 |  6 +--
>  mm/memfd.c                                |  2 +-
>  mm/memfd_luo.c                            |  2 +-
>  mm/shmem.c                                | 59 +++++++++++++----------
>  security/keys/big_key.c                   |  2 +-
>  16 files changed, 57 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 9322a9287dc7..0bc36957979d 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl_size = secs->size + PAGE_SIZE;
>  
>  	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
> -				   VM_NORESERVE);
> +				   mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(backing)) {
>  		ret = PTR_ERR(backing);
>  		goto err_out_shrink;

As per this diff:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e4df43427394..be4dca2bc34e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -130,14 +130,15 @@ int drm_gem_object_init_with_mnt(struct drm_device *dev,
>  				 struct vfsmount *gemfs)
>  {
>  	struct file *filp;
> +	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
>  
>  	drm_gem_private_object_init(dev, obj, size);
>  
>  	if (gemfs)
>  		filp = shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
> -						 VM_NORESERVE);
> +						 flags);
>  	else
> -		filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
> +		filp = shmem_file_setup("drm mm object", size, flags);
>  
>  	if (IS_ERR(filp))
>  		return PTR_ERR(filp);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 26dda55a07ff..fe1843497b27 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -496,7 +496,7 @@ static int __create_shmem(struct drm_i915_private *i915,
>  			  struct drm_gem_object *obj,
>  			  resource_size_t size)
>  {
> -	unsigned long flags = VM_NORESERVE;
> +	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
>  	struct file *filp;
>  
>  	drm_gem_private_object_init(&i915->drm, obj, size);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index f65fe86c02b5..7b1a7d01db2b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -200,7 +200,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
>  		struct address_space *mapping;
>  		gfp_t mask;
>  
> -		filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
> +		filp = shmem_file_setup("i915-shmem-tt", size,
> +					mk_vma_flags(VMA_NORESERVE_BIT));
>  		if (IS_ERR(filp))
>  			return PTR_ERR(filp);
>  
> diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
> index 365c4b8b04f4..5f37c699a320 100644
> --- a/drivers/gpu/drm/i915/gt/shmem_utils.c
> +++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
> @@ -19,7 +19,8 @@ struct file *shmem_create_from_data(const char *name, void *data, size_t len)
>  	struct file *file;
>  	int err;
>  
> -	file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
> +	file = shmem_file_setup(name, PAGE_ALIGN(len),
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(file))
>  		return file;
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> index 61ec6f580b62..bd5f7d0b9b62 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> @@ -143,7 +143,7 @@ static void ttm_tt_fini_shmem(struct kunit *test)
>  	err = ttm_tt_init(tt, bo, 0, caching, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> -	shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
> +	shmem = shmem_file_setup("ttm swap", BO_SIZE, EMPTY_VMA_FLAGS);
>  	tt->swap_storage = shmem;
>  
>  	ttm_tt_fini(tt);
> diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> index 32530c75f038..6bd4c123d94c 100644
> --- a/drivers/gpu/drm/ttm/ttm_backup.c
> +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> @@ -178,5 +178,6 @@ EXPORT_SYMBOL_GPL(ttm_backup_bytes_avail);
>   */
>  struct file *ttm_backup_shmem_create(loff_t size)
>  {
> -	return shmem_file_setup("ttm shmem backup", size, 0);
> +	return shmem_file_setup("ttm shmem backup", size,
> +				EMPTY_VMA_FLAGS);
>  }
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 611d20ab966d..f73a5ce87645 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -330,7 +330,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
>  	struct page *to_page;
>  	int i, ret;
>  
> -	swap_storage = shmem_file_setup("ttm swap", size, 0);
> +	swap_storage = shmem_file_setup("ttm swap", size, EMPTY_VMA_FLAGS);
>  	if (IS_ERR(swap_storage)) {
>  		pr_err("Failed allocating swap storage\n");
>  		return PTR_ERR(swap_storage);
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index c753c79df203..fe0584a39f16 100644
> --- a/fs/xfs/scrub/xfile.c
> +++ b/fs/xfs/scrub/xfile.c
> @@ -61,7 +61,8 @@ xfile_create(
>  	if (!xf)
>  		return -ENOMEM;
>  
> -	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
> +	xf->file = shmem_kernel_file_setup(description, isize,
> +					   mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(xf->file)) {
>  		error = PTR_ERR(xf->file);
>  		goto out_xfile;
> diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> index dcbfa274e06d..fd6f0a5bc0ea 100644
> --- a/fs/xfs/xfs_buf_mem.c
> +++ b/fs/xfs/xfs_buf_mem.c
> @@ -62,7 +62,7 @@ xmbuf_alloc(
>  	if (!btp)
>  		return -ENOMEM;
>  
> -	file = shmem_kernel_file_setup(descr, 0, 0);
> +	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
>  	if (IS_ERR(file)) {
>  		error = PTR_ERR(file);
>  		goto out_free_btp;
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e2069b3179c4..a8273b32e041 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -102,12 +102,10 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
>  extern const struct fs_parameter_spec shmem_fs_parameters[];
>  extern void shmem_init(void);
>  extern int shmem_init_fs_context(struct fs_context *fc);
> -extern struct file *shmem_file_setup(const char *name,
> -					loff_t size, unsigned long flags);
> -extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> -					    unsigned long flags);
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags);
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size, vma_flags_t vma_flags);
>  extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
> -		const char *name, loff_t size, unsigned long flags);
> +		const char *name, loff_t size, vma_flags_t flags);
>  int shmem_zero_setup(struct vm_area_struct *vma);
>  int shmem_zero_setup_desc(struct vm_area_desc *desc);
>  extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 2c7379c4c647..e8c7d1924c50 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -708,6 +708,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  	struct shmid_kernel *shp;
>  	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	const bool has_no_reserve = shmflg & SHM_NORESERVE;
> +	vma_flags_t acctflag = EMPTY_VMA_FLAGS;
>  	struct file *file;
>  	char name[13];
>  
> @@ -738,7 +739,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  
>  	sprintf(name, "SYSV%08x", key);
>  	if (shmflg & SHM_HUGETLB) {
> -		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
>  		struct hstate *hs;
>  		size_t hugesize;
>  
> @@ -755,14 +755,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  		file = hugetlb_file_setup(name, hugesize, acctflag,
>  				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
>  	} else {
> -		vm_flags_t acctflag = 0;
> -
>  		/*
>  		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
>  		 * if it's asked for.
>  		 */
>  		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
> -			acctflag = VM_NORESERVE;
> +			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
>  		file = shmem_kernel_file_setup(name, size, acctflag);
>  	}
>  	error = PTR_ERR(file);
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 5f95f639550c..f3a8950850a2 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -469,7 +469,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>  					(flags >> MFD_HUGE_SHIFT) &
>  					MFD_HUGE_MASK);
>  	} else {
> -		file = shmem_file_setup(name, 0, VM_NORESERVE);
> +		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
>  	}
>  	if (IS_ERR(file))
>  		return file;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 4f6ba63b4310..a2629dcfd0f1 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -443,7 +443,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
>  
> -	file = shmem_file_setup("", 0, VM_NORESERVE);
> +	file = shmem_file_setup("", 0, mk_vma_flags(VMA_NORESERVE_BIT));
>  
>  	if (IS_ERR(file)) {
>  		pr_err("failed to setup file: %pe\n", file);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0adde3f4df27..97a8f55c7296 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3057,9 +3057,9 @@ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
>  }
>  
>  static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
> -					     struct super_block *sb,
> -					     struct inode *dir, umode_t mode,
> -					     dev_t dev, unsigned long flags)
> +				       struct super_block *sb,
> +				       struct inode *dir, umode_t mode,
> +				       dev_t dev, vma_flags_t flags)
>  {
>  	struct inode *inode;
>  	struct shmem_inode_info *info;
> @@ -3087,7 +3087,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
> +	info->flags = vma_flags_test(&flags, VMA_NORESERVE_BIT)
> +		? SHMEM_F_NORESERVE : 0;
>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -3140,7 +3141,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  #ifdef CONFIG_TMPFS_QUOTA
>  static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				     struct super_block *sb, struct inode *dir,
> -				     umode_t mode, dev_t dev, unsigned long flags)
> +				     umode_t mode, dev_t dev, vma_flags_t flags)
>  {
>  	int err;
>  	struct inode *inode;
> @@ -3166,9 +3167,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  	return ERR_PTR(err);
>  }
>  #else
> -static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				     struct super_block *sb, struct inode *dir,
> -				     umode_t mode, dev_t dev, unsigned long flags)
> +				     umode_t mode, dev_t dev, vma_flags_t flags)
>  {
>  	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
>  }
> @@ -3875,7 +3876,8 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
>  		return -EINVAL;
>  
> -	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
> +	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -3910,7 +3912,8 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode *inode;
>  	int error;
>  
> -	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> +	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto err_out;
> @@ -4107,7 +4110,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		return -ENAMETOOLONG;
>  
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
> -				VM_NORESERVE);
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -5108,7 +5111,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #endif /* CONFIG_TMPFS_QUOTA */
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
> -				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
> +				S_IFDIR | sbinfo->mode, 0,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto failed;
> @@ -5808,7 +5812,7 @@ static inline void shmem_unacct_size(unsigned long flags, loff_t size)
>  
>  static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				struct super_block *sb, struct inode *dir,
> -				umode_t mode, dev_t dev, unsigned long flags)
> +				umode_t mode, dev_t dev, vma_flags_t flags)
>  {
>  	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
>  	return inode ? inode : ERR_PTR(-ENOSPC);
> @@ -5819,10 +5823,11 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long vm_flags,
> +				       loff_t size, vma_flags_t flags,
>  				       unsigned int i_flags)
>  {
> -	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
> +	const unsigned long shmem_flags =
> +		vma_flags_test(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5835,13 +5840,13 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  	if (is_idmapped_mnt(mnt))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (shmem_acct_size(flags, size))
> +	if (shmem_acct_size(shmem_flags, size))
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, vm_flags);
> +				S_IFREG | S_IRWXUGO, 0, flags);
>  	if (IS_ERR(inode)) {
> -		shmem_unacct_size(flags, size);
> +		shmem_unacct_size(shmem_flags, size);
>  		return ERR_CAST(inode);
>  	}
>  	inode->i_flags |= i_flags;
> @@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>   *	checks are provided at the key or shm level rather than the inode.
>   * @name: name for dentry (to be seen in /proc/<pid>/maps)
>   * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>   */
> -struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> +				     vma_flags_t flags)
>  {
>  	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
>  }
> @@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
>   * @size: size to be set for the file
>   * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
>   */
> -struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
>  {
>  	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
>  }
> @@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
>   * @mnt: the tmpfs mount where the file will be created
>   * @name: name for dentry (to be seen in /proc/<pid>/maps)
>   * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>   */
>  struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long flags)
> +				       loff_t size, vma_flags_t flags)
>  {
>  	return __shmem_file_setup(mnt, name, size, flags, 0);
>  }
>  EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
>  
> -static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
> +static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
> +		vma_flags_t flags)
>  {
>  	loff_t size = end - start;
>  
> @@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>  	 * accessible to the user through its mapping, use S_PRIVATE flag to
>  	 * bypass file security, in the same way as shmem_kernel_file_setup().
>  	 */
> -	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
> +	return shmem_kernel_file_setup("dev/zero", size, flags);
>  }
>  
>  /**
> @@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>   */
>  int shmem_zero_setup(struct vm_area_struct *vma)
>  {
> -	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
> +	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
>  
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
> @@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>   */
>  int shmem_zero_setup_desc(struct vm_area_desc *desc)
>  {
> -	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
>  
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index d46862ab90d6..268f702df380 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>  					 0, enckey);
>  
>  		/* save aligned data to file */
> -		file = shmem_kernel_file_setup("", enclen, 0);
> +		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
>  		if (IS_ERR(file)) {
>  			ret = PTR_ERR(file);
>  			goto err_enckey;
> -- 
> 2.52.0
> 

BR, Jarkko

