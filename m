Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23BC7BF3CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 09:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbjJJHJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379425AbjJJHJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:09:05 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF35899;
        Tue, 10 Oct 2023 00:09:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S4RpH5Y67z4f3jsP;
        Tue, 10 Oct 2023 15:08:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgCn_UyJ+CRlyoq+CQ--.8005S2;
        Tue, 10 Oct 2023 15:09:00 +0800 (CST)
Subject: Re: [PATCH v6 bpf-next 02/13] bpf: add BPF token delegation mount
 options to BPF FS
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
References: <20230927225809.2049655-1-andrii@kernel.org>
 <20230927225809.2049655-3-andrii@kernel.org>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <02a63a35-7a0c-503b-eb24-774300e86841@huaweicloud.com>
Date:   Tue, 10 Oct 2023 15:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230927225809.2049655-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgCn_UyJ+CRlyoq+CQ--.8005S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48JFWkZFy5KF47Zr4ruFg_yoW5tr4rpF
        W8Jr4jkr48XF43Z3Wqqan0qF1Sk3yq9a4UG3yv934fCasFgrna9a40krWYvFW3Xry8GryI
        vw4vy34Uur47AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/28/2023 6:57 AM, Andrii Nakryiko wrote:
> Add few new mount options to BPF FS that allow to specify that a given
> BPF FS instance allows creation of BPF token (added in the next patch),
> and what sort of operations are allowed under BPF token. As such, we get
> 4 new mount options, each is a bit mask
>   - `delegate_cmds` allow to specify which bpf() syscall commands are
>     allowed with BPF token derived from this BPF FS instance;
>   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
>     a set of allowable BPF map types that could be created with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
>     a set of allowable BPF program types that could be loaded with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
>     a set of allowable BPF program attach types that could be loaded with
>     BPF token; delegate_progs and delegate_attachs are meant to be used
>     together, as full BPF program type is, in general, determined
>     through both program type and program attach type.
>
> Currently, these mount options accept the following forms of values:
>   - a special value "any", that enables all possible values of a given
>   bit set;
>   - numeric value (decimal or hexadecimal, determined by kernel
>   automatically) that specifies a bit mask value directly;
>   - all the values for a given mount option are combined, if specified
>   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
>   delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
>   mask.
>
SNIP
>  	return 0;
> @@ -740,10 +786,14 @@ static int populate_bpffs(struct dentry *parent)
>  static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	static const struct tree_descr bpf_rfiles[] = { { "" } };
> -	struct bpf_mount_opts *opts = fc->fs_private;
> +	struct bpf_mount_opts *opts = sb->s_fs_info;
>  	struct inode *inode;
>  	int ret;
>  
> +	/* Mounting an instance of BPF FS requires privileges */
> +	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
>  	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
>  	if (ret)
>  		return ret;
> @@ -765,7 +815,10 @@ static int bpf_get_tree(struct fs_context *fc)
>  
>  static void bpf_free_fc(struct fs_context *fc)
>  {
> -	kfree(fc->fs_private);
> +	struct bpf_mount_opts *opts = fc->s_fs_info;
> +
> +	if (opts)
> +		kfree(opts);
>  }
>  

The NULL check is not needed here, use kfree(fc->s_fs_info) will be enough.
>  static const struct fs_context_operations bpf_context_ops = {
> @@ -787,17 +840,32 @@ static int bpf_init_fs_context(struct fs_context *fc)
>  
>  	opts->mode = S_IRWXUGO;
>  
> -	fc->fs_private = opts;
> +	/* start out with no BPF token delegation enabled */
> +	opts->delegate_cmds = 0;
> +	opts->delegate_maps = 0;
> +	opts->delegate_progs = 0;
> +	opts->delegate_attachs = 0;
> +
> +	fc->s_fs_info = opts;
>  	fc->ops = &bpf_context_ops;
>  	return 0;
>  }
>  
> +static void bpf_kill_super(struct super_block *sb)
> +{
> +	struct bpf_mount_opts *opts = sb->s_fs_info;
> +
> +	kill_litter_super(sb);
> +	kfree(opts);
> +}
> +
>  static struct file_system_type bpf_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "bpf",
>  	.init_fs_context = bpf_init_fs_context,
>  	.parameters	= bpf_fs_parameters,
> -	.kill_sb	= kill_litter_super,
> +	.kill_sb	= bpf_kill_super,
> +	.fs_flags	= FS_USERNS_MOUNT,
>  };
>  
>  static int __init bpf_init(void)

