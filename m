Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C72747019
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGDLnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGDLnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:43:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD3119;
        Tue,  4 Jul 2023 04:43:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QwLWg24Y8z4f3p02;
        Tue,  4 Jul 2023 19:42:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgCXf929BaRkmuBrNA--.48562S2;
        Tue, 04 Jul 2023 19:42:57 +0800 (CST)
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
To:     Alexey Gladkov <legion@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christian Brauner <brauner@kernel.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
Date:   Tue, 4 Jul 2023 19:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgCXf929BaRkmuBrNA--.48562S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45CF17XF43Xr1DGF1DAwb_yoW5tw13pF
        4FkFn5Cr40qryagw1fJFyF9F4YgF97C3WUZr1xW3s8Ar1qgr1ftF4Ik3Z8Xr4rJr4kGw18
        WF1jgrWkury3JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 6/30/2023 7:08 PM, Alexey Gladkov wrote:
> Since the introduction of idmapped mounts, file handling has become
> somewhat more complicated. If the inode has been found through an
> idmapped mount the idmap of the vfsmount must be used to get proper
> i_uid / i_gid. This is important, for example, to correctly take into
> account idmapped files when caching, LSM or for an audit.

Could you please add a bpf selftest for these newly added kfuncs ?
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 4905665c47d0..ba98ce26b883 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -6,6 +6,7 @@
>  #include <linux/mnt_idmapping.h>
>  #include <linux/slab.h>
>  #include <linux/user_namespace.h>
> +#include <linux/bpf.h>
>  
>  #include "internal.h"
>  
> @@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
>  		kfree(idmap);
>  	}
>  }
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/**
> + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> + * @mnt: the mount to check
> + *
> + * Return: true if mount is mapped, false if not.
> + */
> +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> +{
> +	return is_idmapped_mnt(mnt);
> +}
> +
> +/**
> + * bpf_file_mnt_idmap - get file idmapping
> + * @file: the file from which to get mapping
> + *
> + * Return: The idmap for the @file.
> + */
> +__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
> +{
> +	return file_mnt_idmap(file);
> +}

A dummy question here: the implementation of file_mnt_idmap() is
file->f_path.mnt->mnt_idmap, so if the passed file is a BTF pointer, is
there any reason why we could not do such dereference directly in bpf
program ?
> +
> +/**
> + * bpf_inode_into_vfs_ids - map an inode's i_uid and i_gid down according to an idmapping
> + * @idmap: idmap of the mount the inode was found from
> + * @inode: inode to map
> + *
> + * The inode's i_uid and i_gid mapped down according to @idmap. If the inode's
> + * i_uid or i_gid has no mapping INVALID_VFSUID or INVALID_VFSGID is returned in
> + * the corresponding position.
> + *
> + * Return: A 64-bit integer containing the current GID and UID, and created as
> + * such: *gid* **<< 32 \|** *uid*.
> + */
> +__bpf_kfunc uint64_t bpf_inode_into_vfs_ids(struct mnt_idmap *idmap,
> +		const struct inode *inode)
> +{
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
> +	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> +
> +	return (u64) __vfsgid_val(vfsgid) << 32 |
> +		     __vfsuid_val(vfsuid);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(idmap_btf_ids)
> +BTF_ID_FLAGS(func, bpf_is_idmapped_mnt)
> +BTF_ID_FLAGS(func, bpf_file_mnt_idmap)
> +BTF_ID_FLAGS(func, bpf_inode_into_vfs_ids)
> +BTF_SET8_END(idmap_btf_ids)
> +
> +static const struct btf_kfunc_id_set idmap_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &idmap_btf_ids,
> +};
> +
> +static int __init bpf_idmap_kfunc_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &idmap_kfunc_set);
> +}
> +
Is BPF_PROG_TYPE_TRACING sufficient for your use case ? It seems
BPF_PROG_TYPE_UNSPEC will make these kfuncs be available for all bpf
program types.
> +late_initcall(bpf_idmap_kfunc_init);

