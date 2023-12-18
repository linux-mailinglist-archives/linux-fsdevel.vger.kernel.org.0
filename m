Return-Path: <linux-fsdevel+bounces-6352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E981685C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 09:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777F21C225A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0FA11CA8;
	Mon, 18 Dec 2023 08:39:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66610941;
	Mon, 18 Dec 2023 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Stsrj5Fbsz9xyN0;
	Mon, 18 Dec 2023 16:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E2862140D02;
	Mon, 18 Dec 2023 16:22:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD35HQaAYBlpHPFAg--.32332S2;
	Mon, 18 Dec 2023 09:22:01 +0100 (CET)
Message-ID: <4ddaa086a8fe8583e7bfae69fe40daab8c4ac3c1.camel@huaweicloud.com>
Subject: Re: [PATCH v8 23/24] ima: Make it independent from 'integrity' LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Mon, 18 Dec 2023 09:21:42 +0100
In-Reply-To: <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD35HQaAYBlpHPFAg--.32332S2
X-Coremail-Antispam: 1UD129KBjvAXoWftr1UJF1kAw1fGrWUuw1ftFb_yoW5WFWDGo
	Zav3sxJr48WFyfCay8KFnavFWkuan8G3yfArWkXFWDK3W7KryDW347Ww1rJFW3Zr45KrZr
	CwnrtayUJF9rt3Wkn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5O+CQACse

On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IM=
A
> own integrity metadata (ima_iint_cache structure, with IMA-specific field=
s
> from the integrity_iint_cache structure), and by managing it directly fro=
m
> the 'ima' LSM.
>=20
> Move the remaining IMA-specific flags to security/integrity/ima/ima.h,
> since they are now unnecessary in the common integrity layer.
>=20
> Replace integrity_iint_cache with ima_iint_cache in various places
> of the IMA code.
>=20
> Then, reserve space in the security blob for the entire ima_iint_cache
> structure, so that it is available for all inodes having the security blo=
b
> allocated (those for which security_inode_alloc() was called). Adjust the
> IMA code accordingly, call ima_iint_inode() to retrieve the ima_iint_cach=
e
> structure. Keep the non-NULL checks since there can be inodes without
> security blob.
>=20
> Don't include the inode pointer as field in the ima_iint_cache structure,
> since the association with the inode is clear. Since the inode field is
> missing in ima_iint_cache, pass the extra inode parameter to
> ima_get_verity_digest().
>=20
> Finally, register ima_inode_alloc_security/ima_inode_free_security() to
> initialize/deinitialize the new ima_iint_cache structure (before this tas=
k
> was done by iint_init_always() and iint_free()). Also, duplicate
> iint_lockdep_annotate() for the ima_iint_cache structure, and name it
> ima_iint_lockdep_annotate().
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h          | 109 ++++++++++++++++++++++----
>  security/integrity/ima/ima_api.c      |  15 ++--
>  security/integrity/ima/ima_appraise.c |  25 +++---
>  security/integrity/ima/ima_init.c     |   2 +-
>  security/integrity/ima/ima_main.c     |  96 ++++++++++++++++++-----
>  security/integrity/ima/ima_policy.c   |   2 +-
>  security/integrity/integrity.h        |  53 -------------
>  7 files changed, 194 insertions(+), 108 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a27fc10f84f7..d1c339a340f8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -60,7 +60,7 @@ extern const char boot_aggregate_name[];
> =20
>  /* IMA event related data */
>  struct ima_event_data {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	struct file *file;
>  	const unsigned char *filename;
>  	struct evm_ima_xattr_data *xattr_value;
> @@ -119,6 +119,86 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
> =20
> +/* IMA iint action cache flags */
> +#define IMA_MEASURE		0x00000001
> +#define IMA_MEASURED		0x00000002
> +#define IMA_APPRAISE		0x00000004
> +#define IMA_APPRAISED		0x00000008
> +/*#define IMA_COLLECT		0x00000010  do not use this flag */
> +#define IMA_COLLECTED		0x00000020
> +#define IMA_AUDIT		0x00000040
> +#define IMA_AUDITED		0x00000080
> +#define IMA_HASH		0x00000100
> +#define IMA_HASHED		0x00000200
> +
> +/* IMA iint policy rule cache flags */
> +#define IMA_NONACTION_FLAGS	0xff000000
> +#define IMA_DIGSIG_REQUIRED	0x01000000
> +#define IMA_PERMIT_DIRECTIO	0x02000000
> +#define IMA_NEW_FILE		0x04000000
> +#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> +#define IMA_MODSIG_ALLOWED	0x20000000
> +#define IMA_CHECK_BLACKLIST	0x40000000
> +#define IMA_VERITY_REQUIRED	0x80000000
> +
> +#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
> +				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> +#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
> +				 IMA_HASHED | IMA_COLLECTED | \
> +				 IMA_APPRAISED_SUBMASK)
> +
> +/* IMA iint subaction appraise cache flags */
> +#define IMA_FILE_APPRAISE	0x00001000
> +#define IMA_FILE_APPRAISED	0x00002000
> +#define IMA_MMAP_APPRAISE	0x00004000
> +#define IMA_MMAP_APPRAISED	0x00008000
> +#define IMA_BPRM_APPRAISE	0x00010000
> +#define IMA_BPRM_APPRAISED	0x00020000
> +#define IMA_READ_APPRAISE	0x00040000
> +#define IMA_READ_APPRAISED	0x00080000
> +#define IMA_CREDS_APPRAISE	0x00100000
> +#define IMA_CREDS_APPRAISED	0x00200000
> +#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
> +				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
> +				 IMA_CREDS_APPRAISE)
> +#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED |=
 \
> +				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
> +				 IMA_CREDS_APPRAISED)
> +
> +/* IMA iint cache atomic_flags */
> +#define IMA_CHANGE_XATTR	0
> +#define IMA_UPDATE_XATTR	1
> +#define IMA_CHANGE_ATTR		2
> +#define IMA_DIGSIG		3
> +#define IMA_MUST_MEASURE	4
> +
> +/* IMA integrity metadata associated with an inode */
> +struct ima_iint_cache {
> +	struct mutex mutex;	/* protects: version, flags, digest */
> +	u64 version;		/* track inode changes */
> +	unsigned long flags;
> +	unsigned long measured_pcrs;
> +	unsigned long atomic_flags;
> +	unsigned long real_ino;
> +	dev_t real_dev;
> +	enum integrity_status ima_file_status:4;
> +	enum integrity_status ima_mmap_status:4;
> +	enum integrity_status ima_bprm_status:4;
> +	enum integrity_status ima_read_status:4;
> +	enum integrity_status ima_creds_status:4;
> +	struct ima_digest_data *ima_hash;
> +};
> +
> +extern struct lsm_blob_sizes ima_blob_sizes;
> +
> +static inline struct ima_iint_cache *ima_iint_inode(const struct inode *=
inode)
> +{
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	return inode->i_security + ima_blob_sizes.lbs_inode;
> +}
> +
>  extern const int read_idmap[];
> =20
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> @@ -152,7 +232,7 @@ int ima_calc_field_array_hash(struct ima_field_data *=
field_data,
>  			      struct ima_template_entry *entry);
>  int ima_calc_boot_aggregate(struct ima_digest_data *hash);
>  void ima_add_violation(struct file *file, const unsigned char *filename,
> -		       struct integrity_iint_cache *iint,
> +		       struct ima_iint_cache *iint,
>  		       const char *op, const char *cause);
>  int ima_init_crypto(void);
>  void ima_putc(struct seq_file *m, void *data, int datalen);
> @@ -267,10 +347,10 @@ int ima_get_action(struct mnt_idmap *idmap, struct =
inode *inode,
>  		   struct ima_template_desc **template_desc,
>  		   const char *func_data, unsigned int *allowed_algos);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func)=
;
> -int ima_collect_measurement(struct integrity_iint_cache *iint,
> +int ima_collect_measurement(struct ima_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
>  			    enum hash_algo algo, struct modsig *modsig);
> -void ima_store_measurement(struct integrity_iint_cache *iint, struct fil=
e *file,
> +void ima_store_measurement(struct ima_iint_cache *iint, struct file *fil=
e,
>  			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -280,7 +360,7 @@ int process_buffer_measurement(struct mnt_idmap *idma=
p,
>  			       const char *eventname, enum ima_hooks func,
>  			       int pcr, const char *func_data,
>  			       bool buf_hash, u8 *digest, size_t digest_len);
> -void ima_audit_measurement(struct integrity_iint_cache *iint,
> +void ima_audit_measurement(struct ima_iint_cache *iint,
>  			   const unsigned char *filename);
>  int ima_alloc_init_template(struct ima_event_data *event_data,
>  			    struct ima_template_entry **entry,
> @@ -318,17 +398,17 @@ int ima_policy_show(struct seq_file *m, void *v);
>  #define IMA_APPRAISE_KEXEC	0x40
> =20
>  #ifdef CONFIG_IMA_APPRAISE
> -int ima_check_blacklist(struct integrity_iint_cache *iint,
> +int ima_check_blacklist(struct ima_iint_cache *iint,
>  			const struct modsig *modsig, int pcr);
>  int ima_appraise_measurement(enum ima_hooks func,
> -			     struct integrity_iint_cache *iint,
> +			     struct ima_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, const struct modsig *modsig);
>  int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
>  		      int mask, enum ima_hooks func);
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *fi=
le);
> -enum integrity_status ima_get_cache_status(struct integrity_iint_cache *=
iint,
> +void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
> +enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
>  					   enum ima_hooks func);
>  enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_=
value,
>  				 int xattr_len);
> @@ -337,14 +417,14 @@ int ima_read_xattr(struct dentry *dentry,
>  void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
> =20
>  #else
> -static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> +static inline int ima_check_blacklist(struct ima_iint_cache *iint,
>  				      const struct modsig *modsig, int pcr)
>  {
>  	return 0;
>  }
> =20
>  static inline int ima_appraise_measurement(enum ima_hooks func,
> -					   struct integrity_iint_cache *iint,
> +					   struct ima_iint_cache *iint,
>  					   struct file *file,
>  					   const unsigned char *filename,
>  					   struct evm_ima_xattr_data *xattr_value,
> @@ -361,14 +441,13 @@ static inline int ima_must_appraise(struct mnt_idma=
p *idmap,
>  	return 0;
>  }
> =20
> -static inline void ima_update_xattr(struct integrity_iint_cache *iint,
> +static inline void ima_update_xattr(struct ima_iint_cache *iint,
>  				    struct file *file)
>  {
>  }
> =20
> -static inline enum integrity_status ima_get_cache_status(struct integrit=
y_iint_cache
> -							 *iint,
> -							 enum ima_hooks func)
> +static inline enum integrity_status
> +ima_get_cache_status(struct ima_iint_cache *iint, enum ima_hooks func)
>  {
>  	return INTEGRITY_UNKNOWN;
>  }
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 597ea0c4d72f..f3363935804f 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -131,7 +131,7 @@ int ima_store_template(struct ima_template_entry *ent=
ry,
>   * value is invalidated.
>   */
>  void ima_add_violation(struct file *file, const unsigned char *filename,
> -		       struct integrity_iint_cache *iint,
> +		       struct ima_iint_cache *iint,
>  		       const char *op, const char *cause)
>  {
>  	struct ima_template_entry *entry;
> @@ -201,7 +201,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct in=
ode *inode,
>  				allowed_algos);
>  }
> =20
> -static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
> +static bool ima_get_verity_digest(struct ima_iint_cache *iint,
> +				  struct inode *inode,
>  				  struct ima_max_digest_data *hash)
>  {
>  	enum hash_algo alg;
> @@ -211,7 +212,7 @@ static bool ima_get_verity_digest(struct integrity_ii=
nt_cache *iint,
>  	 * On failure, 'measure' policy rules will result in a file data
>  	 * hash containing 0's.
>  	 */
> -	digest_len =3D fsverity_get_digest(iint->inode, hash->digest, NULL, &al=
g);
> +	digest_len =3D fsverity_get_digest(inode, hash->digest, NULL, &alg);
>  	if (digest_len =3D=3D 0)
>  		return false;
> =20
> @@ -237,7 +238,7 @@ static bool ima_get_verity_digest(struct integrity_ii=
nt_cache *iint,
>   *
>   * Return 0 on success, error code otherwise
>   */
> -int ima_collect_measurement(struct integrity_iint_cache *iint,
> +int ima_collect_measurement(struct ima_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
>  			    enum hash_algo algo, struct modsig *modsig)
>  {
> @@ -280,7 +281,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>  	memset(&hash.digest, 0, sizeof(hash.digest));
> =20
>  	if (iint->flags & IMA_VERITY_REQUIRED) {
> -		if (!ima_get_verity_digest(iint, &hash)) {
> +		if (!ima_get_verity_digest(iint, inode, &hash)) {
>  			audit_cause =3D "no-verity-digest";
>  			result =3D -ENODATA;
>  		}
> @@ -338,7 +339,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>   *
>   * Must be called with iint->mutex held.
>   */
> -void ima_store_measurement(struct integrity_iint_cache *iint,
> +void ima_store_measurement(struct ima_iint_cache *iint,
>  			   struct file *file, const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -382,7 +383,7 @@ void ima_store_measurement(struct integrity_iint_cach=
e *iint,
>  		ima_free_template_entry(entry);
>  }
> =20
> -void ima_audit_measurement(struct integrity_iint_cache *iint,
> +void ima_audit_measurement(struct ima_iint_cache *iint,
>  			   const unsigned char *filename)
>  {
>  	struct audit_buffer *ab;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index 1dd6ee72a20a..d71df7deacb7 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -85,7 +85,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct i=
node *inode,
>  }
> =20
>  static int ima_fix_xattr(struct dentry *dentry,
> -			 struct integrity_iint_cache *iint)
> +			 struct ima_iint_cache *iint)
>  {
>  	int rc, offset;
>  	u8 algo =3D iint->ima_hash->algo;
> @@ -106,7 +106,7 @@ static int ima_fix_xattr(struct dentry *dentry,
>  }
> =20
>  /* Return specific func appraised cached result */
> -enum integrity_status ima_get_cache_status(struct integrity_iint_cache *=
iint,
> +enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
>  					   enum ima_hooks func)
>  {
>  	switch (func) {
> @@ -126,7 +126,7 @@ enum integrity_status ima_get_cache_status(struct int=
egrity_iint_cache *iint,
>  	}
>  }
> =20
> -static void ima_set_cache_status(struct integrity_iint_cache *iint,
> +static void ima_set_cache_status(struct ima_iint_cache *iint,
>  				 enum ima_hooks func,
>  				 enum integrity_status status)
>  {
> @@ -152,8 +152,7 @@ static void ima_set_cache_status(struct integrity_iin=
t_cache *iint,
>  	}
>  }
> =20
> -static void ima_cache_flags(struct integrity_iint_cache *iint,
> -			     enum ima_hooks func)
> +static void ima_cache_flags(struct ima_iint_cache *iint, enum ima_hooks =
func)
>  {
>  	switch (func) {
>  	case MMAP_CHECK:
> @@ -276,7 +275,7 @@ static int calc_file_id_hash(enum evm_ima_xattr_type =
type,
>   *
>   * Return 0 on success, error code otherwise.
>   */
> -static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache=
 *iint,
> +static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint=
,
>  			struct evm_ima_xattr_data *xattr_value, int xattr_len,
>  			enum integrity_status *status, const char **cause)
>  {
> @@ -443,7 +442,7 @@ static int modsig_verify(enum ima_hooks func, const s=
truct modsig *modsig,
>   *
>   * Returns -EPERM if the hash is blacklisted.
>   */
> -int ima_check_blacklist(struct integrity_iint_cache *iint,
> +int ima_check_blacklist(struct ima_iint_cache *iint,
>  			const struct modsig *modsig, int pcr)
>  {
>  	enum hash_algo hash_algo;
> @@ -478,7 +477,7 @@ int ima_check_blacklist(struct integrity_iint_cache *=
iint,
>   * Return 0 on success, error code otherwise
>   */
>  int ima_appraise_measurement(enum ima_hooks func,
> -			     struct integrity_iint_cache *iint,
> +			     struct ima_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, const struct modsig *modsig)
> @@ -603,7 +602,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  /*
>   * ima_update_xattr - update 'security.ima' hash value
>   */
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *fi=
le)
> +void ima_update_xattr(struct ima_iint_cache *iint, struct file *file)
>  {
>  	struct dentry *dentry =3D file_dentry(file);
>  	int rc =3D 0;
> @@ -640,7 +639,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *=
idmap,
>  				   struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode =3D d_backing_inode(dentry);
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	int action;
> =20
>  	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
> @@ -648,7 +647,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *=
idmap,
>  		return;
> =20
>  	action =3D ima_must_appraise(idmap, inode, MAY_ACCESS, POST_SETATTR);
> -	iint =3D integrity_iint_find(inode);
> +	iint =3D ima_iint_inode(inode);
>  	if (iint) {
>  		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
>  		if (!action)
> @@ -674,12 +673,12 @@ static int ima_protect_xattr(struct dentry *dentry,=
 const char *xattr_name,
> =20
>  static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
> =20
>  	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
>  		return;
> =20
> -	iint =3D integrity_iint_find(inode);
> +	iint =3D ima_iint_inode(inode);
>  	if (!iint)
>  		return;
>  	iint->measured_pcrs =3D 0;
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/i=
ma_init.c
> index 63979aefc95f..393f5c7912d5 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -44,7 +44,7 @@ static int __init ima_add_boot_aggregate(void)
>  	static const char op[] =3D "add_boot_aggregate";
>  	const char *audit_cause =3D "ENOMEM";
>  	struct ima_template_entry *entry;
> -	struct integrity_iint_cache tmp_iint, *iint =3D &tmp_iint;
> +	struct ima_iint_cache tmp_iint, *iint =3D &tmp_iint;
>  	struct ima_event_data event_data =3D { .iint =3D iint,
>  					     .filename =3D boot_aggregate_name };
>  	struct ima_max_digest_data hash;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 2a9ca5fa4317..b28e49f53ca4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -114,7 +114,7 @@ static int mmap_violation_check(enum ima_hooks func, =
struct file *file,
>   *
>   */
>  static void ima_rdwr_violation_check(struct file *file,
> -				     struct integrity_iint_cache *iint,
> +				     struct ima_iint_cache *iint,
>  				     int must_measure,
>  				     char **pathbuf,
>  				     const char **pathname,
> @@ -125,9 +125,9 @@ static void ima_rdwr_violation_check(struct file *fil=
e,
>  	bool send_tomtou =3D false, send_writers =3D false;
> =20
>  	if (mode & FMODE_WRITE) {
> -		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
> +		if (atomic_read(&inode->i_readcount)) {
>  			if (!iint)
> -				iint =3D integrity_iint_find(inode);
> +				iint =3D ima_iint_inode(inode);
>  			/* IMA_MEASURE is set from reader side */
>  			if (iint && test_bit(IMA_MUST_MEASURE,
>  						&iint->atomic_flags))
> @@ -153,7 +153,7 @@ static void ima_rdwr_violation_check(struct file *fil=
e,
>  				  "invalid_pcr", "open_writers");
>  }
> =20
> -static void ima_check_last_writer(struct integrity_iint_cache *iint,
> +static void ima_check_last_writer(struct ima_iint_cache *iint,
>  				  struct inode *inode, struct file *file)
>  {
>  	fmode_t mode =3D file->f_mode;
> @@ -192,12 +192,12 @@ static void ima_check_last_writer(struct integrity_=
iint_cache *iint,
>  static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode =3D file_inode(file);
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
> =20
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>  		return;
> =20
> -	iint =3D integrity_iint_find(inode);
> +	iint =3D ima_iint_inode(inode);
>  	if (!iint)
>  		return;
> =20
> @@ -209,7 +209,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  			       enum ima_hooks func)
>  {
>  	struct inode *backing_inode, *inode =3D file_inode(file);
> -	struct integrity_iint_cache *iint =3D NULL;
> +	struct ima_iint_cache *iint;

Argh, really sorry...

Last minute change after restoring the non-NULL checks, it seems I
didn't revert all the changes completely (missing =3D NULL).

>  	struct ima_template_desc *template_desc =3D NULL;
>  	char *pathbuf =3D NULL;
>  	char filename[NAME_MAX];
> @@ -248,7 +248,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  	inode_lock(inode);
> =20
>  	if (action) {
> -		iint =3D integrity_inode_get(inode);
> +		iint =3D ima_iint_inode(inode);
>  		if (!iint)
>  			rc =3D -ENOMEM;
>  	}
> @@ -564,11 +564,11 @@ static int ima_file_check(struct file *file, int ma=
sk)
>  static int __ima_inode_hash(struct inode *inode, struct file *file, char=
 *buf,
>  			    size_t buf_size)
>  {
> -	struct integrity_iint_cache *iint =3D NULL, tmp_iint;
> +	struct ima_iint_cache *iint, tmp_iint;

Same here. Will send v9 after I get more reviews.

Thanks

Roberto

>  	int rc, hash_algo;
> =20
>  	if (ima_policy_flag) {
> -		iint =3D integrity_iint_find(inode);
> +		iint =3D ima_iint_inode(inode);
>  		if (iint)
>  			mutex_lock(&iint->mutex);
>  	}
> @@ -578,7 +578,6 @@ static int __ima_inode_hash(struct inode *inode, stru=
ct file *file, char *buf,
>  			mutex_unlock(&iint->mutex);
> =20
>  		memset(&tmp_iint, 0, sizeof(tmp_iint));
> -		tmp_iint.inode =3D inode;
>  		mutex_init(&tmp_iint.mutex);
> =20
>  		rc =3D ima_collect_measurement(&tmp_iint, file, NULL, 0,
> @@ -688,7 +687,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap =
*idmap,
>  				    struct inode *inode)
> =20
>  {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	int must_appraise;
> =20
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> @@ -699,8 +698,8 @@ static void ima_post_create_tmpfile(struct mnt_idmap =
*idmap,
>  	if (!must_appraise)
>  		return;
> =20
> -	/* Nothing to do if we can't allocate memory */
> -	iint =3D integrity_inode_get(inode);
> +	iint =3D ima_iint_inode(inode);
> +	/* iint is NULL if security_inode_alloc() was not called on inode. */
>  	if (!iint)
>  		return;
> =20
> @@ -720,8 +719,8 @@ static void ima_post_create_tmpfile(struct mnt_idmap =
*idmap,
>  static void __maybe_unused
>  ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>  {
> -	struct integrity_iint_cache *iint;
>  	struct inode *inode =3D dentry->d_inode;
> +	struct ima_iint_cache *iint =3D ima_iint_inode(inode);
>  	int must_appraise;
> =20
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> @@ -732,8 +731,8 @@ ima_post_path_mknod(struct mnt_idmap *idmap, struct d=
entry *dentry)
>  	if (!must_appraise)
>  		return;
> =20
> -	/* Nothing to do if we can't allocate memory */
> -	iint =3D integrity_inode_get(inode);
> +	iint =3D ima_iint_inode(inode);
> +	/* iint is NULL if security_inode_alloc() was not called on inode. */
>  	if (!iint)
>  		return;
> =20
> @@ -936,7 +935,7 @@ int process_buffer_measurement(struct mnt_idmap *idma=
p,
>  	int ret =3D 0;
>  	const char *audit_cause =3D "ENOMEM";
>  	struct ima_template_entry *entry =3D NULL;
> -	struct integrity_iint_cache iint =3D {};
> +	struct ima_iint_cache iint =3D {};
>  	struct ima_event_data event_data =3D {.iint =3D &iint,
>  					    .filename =3D eventname,
>  					    .buf =3D buf,
> @@ -1145,6 +1144,60 @@ static int __maybe_unused ima_kernel_module_reques=
t(char *kmod_name)
>  	return 0;
>  }
> =20
> +#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
> +
> +/*
> + * It is not clear that IMA should be nested at all, but as long is it m=
easures
> + * files both on overlayfs and on underlying fs, we need to annotate the=
 iint
> + * mutex to avoid lockdep false positives related to IMA + overlayfs.
> + * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> + */
> +static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *ima_=
iint,
> +					     struct inode *inode)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
> +
> +	int depth =3D inode->i_sb->s_stack_depth;
> +
> +	if (WARN_ON_ONCE(depth < 0 || depth >=3D IMA_MAX_NESTING))
> +		depth =3D 0;
> +
> +	lockdep_set_class(&ima_iint->mutex, &iint_mutex_key[depth]);
> +#endif
> +}
> +
> +static int ima_inode_alloc_security(struct inode *inode)
> +{
> +	struct ima_iint_cache *iint =3D ima_iint_inode(inode);
> +
> +	/* Called by security_inode_alloc(), it cannot be NULL. */
> +	iint->ima_hash =3D NULL;
> +	iint->version =3D 0;
> +	iint->flags =3D 0UL;
> +	iint->atomic_flags =3D 0UL;
> +	iint->ima_file_status =3D INTEGRITY_UNKNOWN;
> +	iint->ima_mmap_status =3D INTEGRITY_UNKNOWN;
> +	iint->ima_bprm_status =3D INTEGRITY_UNKNOWN;
> +	iint->ima_read_status =3D INTEGRITY_UNKNOWN;
> +	iint->ima_creds_status =3D INTEGRITY_UNKNOWN;
> +	iint->measured_pcrs =3D 0;
> +	mutex_init(&iint->mutex);
> +	ima_iint_lockdep_annotate(iint, inode);
> +	return 0;
> +}
> +
> +static void ima_inode_free_security(struct inode *inode)
> +{
> +	struct ima_iint_cache *iint =3D ima_iint_inode(inode);
> +
> +	if (!iint)
> +		return;
> +
> +	kfree(iint->ima_hash);
> +	mutex_destroy(&iint->mutex);
> +}
> +
>  static struct security_hook_list ima_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
>  	LSM_HOOK_INIT(file_post_open, ima_file_check),
> @@ -1156,6 +1209,8 @@ static struct security_hook_list ima_hooks[] __ro_a=
fter_init =3D {
>  	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
>  	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
>  	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
> +	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
> +	LSM_HOOK_INIT(inode_free_security, ima_inode_free_security),
>  #ifdef CONFIG_SECURITY_PATH
>  	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
>  #endif
> @@ -1179,10 +1234,15 @@ static int __init init_ima_lsm(void)
>  	return 0;
>  }
> =20
> +struct lsm_blob_sizes ima_blob_sizes __ro_after_init =3D {
> +	.lbs_inode =3D sizeof(struct ima_iint_cache),
> +};
> +
>  DEFINE_LSM(ima) =3D {
>  	.name =3D "ima",
>  	.init =3D init_ima_lsm,
>  	.order =3D LSM_ORDER_LAST,
> +	.blobs =3D &ima_blob_sizes,
>  };
> =20
>  late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index f69062617754..c0556907c2e6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -49,7 +49,7 @@
>  #define DONT_HASH	0x0200
> =20
>  #define INVALID_PCR(a) (((a) < 0) || \
> -	(a) >=3D (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8)=
)
> +	(a) >=3D (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
> =20
>  int ima_policy_flag;
>  static int temp_ima_appraise;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index 7a97c269a072..671fc50255f9 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -20,59 +20,6 @@
>  #include <linux/audit.h>
>  #include <linux/lsm_hooks.h>
> =20
> -/* iint action cache flags */
> -#define IMA_MEASURE		0x00000001
> -#define IMA_MEASURED		0x00000002
> -#define IMA_APPRAISE		0x00000004
> -#define IMA_APPRAISED		0x00000008
> -/*#define IMA_COLLECT		0x00000010  do not use this flag */
> -#define IMA_COLLECTED		0x00000020
> -#define IMA_AUDIT		0x00000040
> -#define IMA_AUDITED		0x00000080
> -#define IMA_HASH		0x00000100
> -#define IMA_HASHED		0x00000200
> -
> -/* iint policy rule cache flags */
> -#define IMA_NONACTION_FLAGS	0xff000000
> -#define IMA_DIGSIG_REQUIRED	0x01000000
> -#define IMA_PERMIT_DIRECTIO	0x02000000
> -#define IMA_NEW_FILE		0x04000000
> -#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> -#define IMA_MODSIG_ALLOWED	0x20000000
> -#define IMA_CHECK_BLACKLIST	0x40000000
> -#define IMA_VERITY_REQUIRED	0x80000000
> -
> -#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
> -				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> -#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
> -				 IMA_HASHED | IMA_COLLECTED | \
> -				 IMA_APPRAISED_SUBMASK)
> -
> -/* iint subaction appraise cache flags */
> -#define IMA_FILE_APPRAISE	0x00001000
> -#define IMA_FILE_APPRAISED	0x00002000
> -#define IMA_MMAP_APPRAISE	0x00004000
> -#define IMA_MMAP_APPRAISED	0x00008000
> -#define IMA_BPRM_APPRAISE	0x00010000
> -#define IMA_BPRM_APPRAISED	0x00020000
> -#define IMA_READ_APPRAISE	0x00040000
> -#define IMA_READ_APPRAISED	0x00080000
> -#define IMA_CREDS_APPRAISE	0x00100000
> -#define IMA_CREDS_APPRAISED	0x00200000
> -#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
> -				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
> -				 IMA_CREDS_APPRAISE)
> -#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED |=
 \
> -				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
> -				 IMA_CREDS_APPRAISED)
> -
> -/* iint cache atomic_flags */
> -#define IMA_CHANGE_XATTR	0
> -#define IMA_UPDATE_XATTR	1
> -#define IMA_CHANGE_ATTR		2
> -#define IMA_DIGSIG		3
> -#define IMA_MUST_MEASURE	4
> -
>  enum evm_ima_xattr_type {
>  	IMA_XATTR_DIGEST =3D 0x01,
>  	EVM_XATTR_HMAC,


