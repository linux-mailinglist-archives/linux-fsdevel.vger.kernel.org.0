Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0661B7847DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbjHVQj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjHVQj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:39:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C5ACC7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 09:39:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 89A4A5C011B;
        Tue, 22 Aug 2023 12:39:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692722361; x=1692808761; bh=/TCC3w1zgGGGq8dCQhHWBO18yjBMIsLRXmK
        tkvrH6q4=; b=dF8dEG3wmSop8S9E2rHiWh08133icRIFPq1gZbaWWH9PnFpPY/u
        LSNCyPhoH1X2ZVNZ8XbI/8v98HMHokH4vxWFBB+xAvz1COhM1sg1vkrfqH8r9puy
        3ZL3OBEaTyBhRBmkN//bAecAom00jz4RvwU1EgkIXpOWnlq6M9tuRzRpYMI2k8UE
        /Xqufa4WLpgGSrmhMonnKEWeQFxKzsrCvE1Z8IF6t7YhHr/sBbSdee3JukijMZP+
        xAoHHswDi1sE2S3a9vhAg5nVlccYZuaZFnhzdyuRZQGY4fEelg915tmPy/9JTzQh
        jZADpxruRxBVQNMaRXcyTEA32h/2rG1jcHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1692722361; x=
        1692808761; bh=/TCC3w1zgGGGq8dCQhHWBO18yjBMIsLRXmKtkvrH6q4=; b=2
        GDnl/7A7wBDoVnrk2LF+KkwEZauPnJe6wE74qA4Y8L7p9Oxbhv0QRkEjjh0ukKP8
        sn4qlixvTf1uWNnQ4g7dgR8JiszQCvHVGPfDdIIBMzHkJENw70+Xg1Z3OPfVEOTB
        4x6HDOdx2vuHTbfRJ8IqTLOxQ48aiVqLTP+08dbYjOOPoCWJHZMEKJmJdRmThKhS
        yXoonUQrYxDfydHsSV/wNWwiD4Qpj+OAMztoCLLTX12HZgn+Jy9SrrzneY1DTtt8
        qZ+jtREoLRpM6HcYD6CcWw4vtoyoe8JYmA6N3IqEqQ3g60TC2u/aUCzZPr4AGL8k
        rm22Zfosv6FvIs2ZuPWEw==
X-ME-Sender: <xms:ueTkZNcQe7WiVwotBSRpca0Q9gVTAGMjQ0XZ61qPeTCyNBn_EFo-6w>
    <xme:ueTkZLNxsRb5RFyego0X_zb7uO76oPW1rYLfKUVIOg0snOiNnhCIstXd9gPjCbYzB
    SpBfWj0Zu9ARWnD>
X-ME-Received: <xmr:ueTkZGiTGBiXn5hUvi1_dxEOsOZPtcPSQjtwqi2yzNf6XdnVJXtANoNuCOeQqV4PdlVobqai1jbpldUQM_MPmncBnG5o0HXPT9r3_tgoPOqyKa8I2cFh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepgeffuddtgeeigfetleelgeegueeuudetfeei
    udevvdeufeeijeelvdejuefhfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:ueTkZG-fqa9zDsxgfD1BhOE3o_w1oNVCYcNKFyL_Rea1-T1jyVdVnQ>
    <xmx:ueTkZJtgDqncS2radU-TiNOeXtkv7i2j6IjXC6AyLqTxMsv2KFyR5A>
    <xmx:ueTkZFEAtd_NrABhtS57I49X3GCmlFJO2DkpanuYJFB0UpKFhyU4ow>
    <xmx:ueTkZH21DW1THhUfrc9oBboS4MwAvSjeQZfGskwl56nCdGqlhkIY_w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 12:39:20 -0400 (EDT)
Message-ID: <b05d63c9-30e4-e3a5-2989-f5e66aab6496@fastmail.fm>
Date:   Tue, 22 Aug 2023 18:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: implement statx
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-5-mszeredi@redhat.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230810105501.1418427-5-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/23 12:55, Miklos Szeredi wrote:
> Allow querying btime.  When btime is requested in mask, then FUSE_STATX
> request is sent.  Otherwise keep using FUSE_GETATTR.
> 
> The userspace interface for statx matches that of the statx(2) API.
> However there are limitations on how this interface is used:
> 
>   - returned basic stats and btime are used, stx_attributes, etc. are
>     ignored
> 
>   - always query basic stats and btime, regardless of what was requested
> 
>   - requested sync type is ignored, the default is passed to the server
> 
>   - if server returns with some attributes missing from the result_mask,
>     then no attributes will be cached
> 
>   - btime is not cached yet (next patch will fix that)
> 
> For new inodes initialize fi->inval_mask to "all invalid", instead of "all
> valid" as previously.  Also only clear basic stats from inval_mask when
> caching attributes.  This will result in the caching logic not thinking
> that btime is cached.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/fuse/dir.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++---
>   fs/fuse/fuse_i.h |   3 ++
>   fs/fuse/inode.c  |   5 ++-
>   3 files changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 04006db6e173..552157bd6a4d 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -350,10 +350,14 @@ int fuse_valid_type(int m)
>   		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
>   }
>   
> +bool fuse_valid_size(u64 size)
> +{
> +	return size <= LLONG_MAX;
> +}
> +
>   bool fuse_invalid_attr(struct fuse_attr *attr)
>   {
> -	return !fuse_valid_type(attr->mode) ||
> -		attr->size > LLONG_MAX;
> +	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
>   }
>   
>   int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
> @@ -1143,6 +1147,84 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
>   	stat->blksize = 1 << blkbits;
>   }
>   
> +static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
> +{
> +	memset(attr, 0, sizeof(*attr));
> +	attr->ino = sx->ino;
> +	attr->size = sx->size;
> +	attr->blocks = sx->blocks;
> +	attr->atime = sx->atime.tv_sec;
> +	attr->mtime = sx->mtime.tv_sec;
> +	attr->ctime = sx->ctime.tv_sec;
> +	attr->atimensec = sx->atime.tv_nsec;
> +	attr->mtimensec = sx->mtime.tv_nsec;
> +	attr->ctimensec = sx->ctime.tv_nsec;
> +	attr->mode = sx->mode;
> +	attr->nlink = sx->nlink;
> +	attr->uid = sx->uid;
> +	attr->gid = sx->gid;
> +	attr->rdev = new_encode_dev(MKDEV(sx->rdev_major, sx->rdev_minor));
> +	attr->blksize = sx->blksize;
> +}
> +
> +static int fuse_do_statx(struct inode *inode, struct file *file,
> +			 struct kstat *stat)
> +{
> +	int err;
> +	struct fuse_attr attr;
> +	struct fuse_statx *sx;
> +	struct fuse_statx_in inarg;
> +	struct fuse_statx_out outarg;
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	u64 attr_version = fuse_get_attr_version(fm->fc);
> +	FUSE_ARGS(args);
> +
> +	memset(&inarg, 0, sizeof(inarg));
> +	memset(&outarg, 0, sizeof(outarg));
> +	/* Directories have separate file-handle space */
> +	if (file && S_ISREG(inode->i_mode)) {
> +		struct fuse_file *ff = file->private_data;
> +
> +		inarg.getattr_flags |= FUSE_GETATTR_FH;
> +		inarg.fh = ff->fh;
> +	}
> +	/* For now leave sync hints as the default, request all stats. */
> +	inarg.sx_flags = 0;
> +	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
> +	args.opcode = FUSE_STATX;
> +	args.nodeid = get_node_id(inode);
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	args.out_numargs = 1;
> +	args.out_args[0].size = sizeof(outarg);
> +	args.out_args[0].value = &outarg;
> +	err = fuse_simple_request(fm, &args);
> +	if (err)
> +		return err;
> +
> +	sx = &outarg.stat;
> +	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
> +	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
> +					 inode_wrong_type(inode, sx->mode)))) {
> +		make_bad_inode(inode);
> +		return -EIO;
> +	}
> +
> +	fuse_statx_to_attr(&outarg.stat, &attr);
> +	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
> +		fuse_change_attributes(inode, &attr, ATTR_TIMEOUT(&outarg),
> +				       attr_version);
> +	}
> +	stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
> +	stat->btime.tv_sec = sx->btime.tv_sec;
> +	stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> +	fuse_fillattr(inode, &attr, stat);
> +	stat->result_mask |= STATX_TYPE;
> +
> +	return 0;
> +}


Hmm, unconditionally using stat is potentially a NULL ptr with future 
updates. I think not right now, as fuse_update_get_attr() has the 
(request_mask & ~STATX_BASIC_STATS) condition and no caller
that passes 'stat = NULL' requests anything beyond STATX_BASIC_STATS, 
but wouldn't it be more safe to access stat only conditionally?


Thanks,
Bernd


