Return-Path: <linux-fsdevel+bounces-70810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F945CA71D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5BE530A030B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE83191D2;
	Fri,  5 Dec 2025 10:11:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1A2F692F;
	Fri,  5 Dec 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929467; cv=none; b=mMuMN6D++6mZUryHn6FBJ45muDTqlQaQGeY5Zu+QGXcZYmONYX2k+n3wo5TtaWY4HGp2tAQmuW8u334ZstMSG16cRrNSf0u9q/ACYOwYJvdegihRugHk2BNQp2a/ZZI4jQCgoQSO6v4XbAofWOvMl+gXkR8whKCIcaw76fFKICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929467; c=relaxed/simple;
	bh=FHdfQItbH2ydjxQAPjN3s0y3F4LlAVdb42tL30KClnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRXMI1OFo44naVlB7viYSAZx9EbItnkMHHmcrGZH8vBxII0IKqQ6b7WQoAgqrPHKpGVYQ57RUNOLVTzXXbJKHUnlH6TAs8xGKiMDblcXWZMNtYzfos/jIlvNFGKJO2aPAWusbyYUzpbTzyS0dTEtvDBo83q6UnVHv+1lMxspWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dN6Zw6bQ0zYQv3m;
	Fri,  5 Dec 2025 18:10:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 75D8D1A0B63;
	Fri,  5 Dec 2025 18:10:55 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXwZ6vrzJpCVG3Ag--.58028S2;
	Fri, 05 Dec 2025 18:10:55 +0800 (CST)
Message-ID: <25cac682-e6a5-4ab2-bae2-fb4df2d33626@huaweicloud.com>
Date: Fri, 5 Dec 2025 18:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cgroup, binfmt_elf: Add hwcap masks to the misc
 controller
To: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251205005841.3942668-1-avagin@google.com>
 <20251205005841.3942668-2-avagin@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251205005841.3942668-2-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXwZ6vrzJpCVG3Ag--.58028S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr45Ww4xZFWDZFyxuw45Jrb_yoWfXw45pF
	WDCF98G395trW7JrWSy3Wqvryruw1kXr4Du3yUWw10vFZIgr15XF4UCw4UCF1YkFWv9ry3
	tw15CF4Y9340qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/5 8:58, Andrei Vagin wrote:
> Add an interface to the misc cgroup controller that allows masking out
> hardware capabilities (AT_HWCAP) reported to user-space processes. This
> provides a mechanism to restrict the features a containerized
> application can see.
> 
> The new "misc.mask" cgroup file allows users to specify masks for
> AT_HWCAP, AT_HWCAP2, AT_HWCAP3, and AT_HWCAP4.
> 
> The output of "misc.mask" is extended to display the effective mask,
> which is a combination of the masks from the current cgroup and all its
> ancestors.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/binfmt_elf.c             |  24 +++++--
>  include/linux/misc_cgroup.h |  25 +++++++
>  kernel/cgroup/misc.c        | 126 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 3eb734c192e9..59137784e81d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -47,6 +47,7 @@
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rseq.h>
> +#include <linux/misc_cgroup.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>  
> @@ -182,6 +183,21 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	int ei_index;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> +	struct misc_cg *misc_cg;
> +	u64 hwcap_mask[4] = {0, 0, 0, 0};
> +
> +	misc_cg = get_current_misc_cg();
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP, misc_cg, &hwcap_mask[0]);
> +#ifdef ELF_HWCAP2
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP2, misc_cg, &hwcap_mask[1]);
> +#endif
> +#ifdef ELF_HWCAP3
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP3, misc_cg, &hwcap_mask[2]);
> +#endif
> +#ifdef ELF_HWCAP4
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP4, misc_cg, &hwcap_mask[3]);
> +#endif
> +	put_misc_cg(misc_cg);
>  
>  	/*
>  	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
> @@ -246,7 +262,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	 */
>  	ARCH_DLINFO;
>  #endif
> -	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP & ~hwcap_mask[0]);
>  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>  	NEW_AUX_ENT(AT_PHDR, phdr_addr);
> @@ -264,13 +280,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>  	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>  #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2 & ~hwcap_mask[1]);
>  #endif
>  #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3 & ~hwcap_mask[2]);
>  #endif
>  #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4 & ~hwcap_mask[3]);
>  #endif
>  	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>  	if (k_platform) {
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index 0cb36a3ffc47..cff830c238fb 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -8,6 +8,8 @@
>  #ifndef _MISC_CGROUP_H_
>  #define _MISC_CGROUP_H_
>  
> +#include <linux/elf.h>
> +
>  /**
>   * enum misc_res_type - Types of misc cgroup entries supported by the host.
>   */
> @@ -26,6 +28,20 @@ enum misc_res_type {
>  	MISC_CG_RES_TYPES
>  };
>  
> +enum misc_mask_type {
> +	MISC_CG_MASK_HWCAP,
> +#ifdef ELF_HWCAP2
> +	MISC_CG_MASK_HWCAP2,
> +#endif
> +#ifdef ELF_HWCAP3
> +	MISC_CG_MASK_HWCAP3,
> +#endif
> +#ifdef ELF_HWCAP4
> +	MISC_CG_MASK_HWCAP4,
> +#endif
> +	MISC_CG_MASK_TYPES
> +};
> +
>  struct misc_cg;
>  
>  #ifdef CONFIG_CGROUP_MISC
> @@ -62,12 +78,15 @@ struct misc_cg {
>  	struct cgroup_file events_local_file;
>  
>  	struct misc_res res[MISC_CG_RES_TYPES];
> +	u64 mask[MISC_CG_MASK_TYPES];
>  };
>  
>  int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
>  int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
>  void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
>  
> +int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask);
> +
>  /**
>   * css_misc() - Get misc cgroup from the css.
>   * @css: cgroup subsys state object.
> @@ -134,5 +153,11 @@ static inline void put_misc_cg(struct misc_cg *cg)
>  {
>  }
>  
> +static inline int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask)
> +{
> +	*pmask = 0;
> +	return 0;
> +}
> +
>  #endif /* CONFIG_CGROUP_MISC */
>  #endif /* _MISC_CGROUP_H_ */
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 6a01d91ea4cb..d1386d86060f 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -30,6 +30,19 @@ static const char *const misc_res_name[] = {
>  #endif
>  };
>  
> +static const char *const misc_mask_name[] = {
> +	"AT_HWCAP",
> +#ifdef ELF_HWCAP2
> +	"AT_HWCAP2",
> +#endif
> +#ifdef ELF_HWCAP3
> +	"AT_HWCAP3",
> +#endif
> +#ifdef ELF_HWCAP4
> +	"AT_HWCAP4",
> +#endif
> +};
> +
>  /* Root misc cgroup */
>  static struct misc_cg root_cg;
>  
> @@ -71,6 +84,11 @@ static inline bool valid_type(enum misc_res_type type)
>  	return type >= 0 && type < MISC_CG_RES_TYPES;
>  }
>  
> +static inline bool valid_mask_type(enum misc_mask_type type)
> +{
> +	return type >= 0 && type < MISC_CG_MASK_TYPES;
> +}
> +
>  /**
>   * misc_cg_set_capacity() - Set the capacity of the misc cgroup res.
>   * @type: Type of the misc res.
> @@ -391,6 +409,109 @@ static int misc_events_local_show(struct seq_file *sf, void *v)
>  	return __misc_events_show(sf, true);
>  }
>  
> +/**
> + * misc_cg_get_mask() - Get the mask of the specified type.
> + * @type: The misc mask type.
> + * @cg: The misc cgroup.
> + * @pmask: Pointer to the resulting mask.
> + *
> + * This function calculates the effective mask for a given cgroup by walking up
> + * the hierarchy and ORing the masks from all parent cgroupfs. The final result
> + * is stored in the location pointed to by @pmask.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -EINVAL if @type is invalid.
> + */
> +int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask)
> +{
> +	struct misc_cg *i;
> +	u64 mask = 0;
> +
> +	if (!(valid_mask_type(type)))
> +		return -EINVAL;
> +
> +	for (i = cg; i; i = parent_misc(i))
> +		mask |= READ_ONCE(i->mask[type]);
> +
> +	*pmask = mask;
> +	return 0;
> +}
> +
> +/**
> + * misc_cg_mask_show() - Show the misc cgroup masks.
> + * @sf: Interface file
> + * @v: Arguments passed
> + *
> + * Context: Any context.
> + * Return: 0 to denote successful print.
> + */
> +static int misc_cg_mask_show(struct seq_file *sf, void *v)
> +{
> +	struct misc_cg *cg = css_misc(seq_css(sf));
> +	int i;
> +
> +	for (i = 0; i < MISC_CG_MASK_TYPES; i++) {
> +		u64 rval, val = READ_ONCE(cg->mask[i]);
> +
> +		misc_cg_get_mask(i, cg, &rval);
> +		seq_printf(sf, "%s\t%#016llx\t%#016llx\n", misc_mask_name[i], val, rval);
> +	}
> +
> +	return 0;
> +}
> +

I'm concerned about the performance impact of the bottom-up traversal in deeply nested cgroup
hierarchies. Could this approach introduce noticeable latency in such scenarios?

> +/**
> + * misc_cg_mask_write() - Update the mask of the specified type.
> + * @of: Handler for the file.
> + * @buf: The buffer containing the user's input.
> + * @nbytes: The number of bytes in @buf.
> + * @off: The offset in the file.
> + *
> + * This function parses a user-provided string to update a mask.
> + * The expected format is "<mask_name> <value>", for example:
> + *
> + * echo "AT_HWCAP 0xf00" > misc.mask
> + *
> + * Context: Process context.
> + * Return: The number of bytes processed on success, or a negative error code
> + * on failure.
> + */
> +static ssize_t misc_cg_mask_write(struct kernfs_open_file *of, char *buf,
> +				 size_t nbytes, loff_t off)
> +{
> +	struct misc_cg *cg;
> +	u64 max;
> +	int ret = 0, i;
> +	enum misc_mask_type type = MISC_CG_MASK_TYPES;
> +	char *token;
> +
> +	buf = strstrip(buf);
> +	token = strsep(&buf, " ");
> +
> +	if (!token || !buf)
> +		return -EINVAL;
> +
> +	for (i = 0; i < MISC_CG_MASK_TYPES; i++) {
> +		if (!strcmp(misc_mask_name[i], token)) {
> +			type = i;
> +			break;
> +		}
> +	}
> +
> +	if (type == MISC_CG_MASK_TYPES)
> +		return -EINVAL;
> +
> +	ret = kstrtou64(buf, 0, &max);
> +	if (ret)
> +		return ret;
> +
> +	cg = css_misc(of_css(of));
> +
> +	WRITE_ONCE(cg->mask[type], max);
> +
> +	return nbytes;
> +}
> +
>  /* Misc cgroup interface files */
>  static struct cftype misc_cg_files[] = {
>  	{
> @@ -424,6 +545,11 @@ static struct cftype misc_cg_files[] = {
>  		.file_offset = offsetof(struct misc_cg, events_local_file),
>  		.seq_show = misc_events_local_show,
>  	},
> +	{
> +		.name = "mask",
> +		.write = misc_cg_mask_write,
> +		.seq_show = misc_cg_mask_show,
> +	},
>  	{}
>  };
>  

-- 
Best regards,
Ridong


