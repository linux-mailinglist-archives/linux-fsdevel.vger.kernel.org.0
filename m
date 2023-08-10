Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28187777981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjHJNXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjHJNXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:23:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005E92
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 06:23:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 58AEA320047A;
        Thu, 10 Aug 2023 09:22:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 09:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1691673776; x=1691760176; bh=m3wrM0pedGP7IS4x7QyEzIORBlLiIL9JwRy
        aIqKXoTY=; b=iwHCPuHQ/PQsYWegkhNuorTVZFt8+V63hR4+AqayqpO39a0Tjp8
        ksyAUXGo6IX6d2WWcgzCxxvg4BRcNlM5XdPMUws5H1vs3lSUJkThzoE6IXY1eoWw
        VpVyIpnfF6x7CnxBNCTQkCgbiLZoIizuiMp3GSb7Nd9Woeyd82BFzFOL4e7Uwqyt
        jXvebcW6Qni+Z7+e1w635ZsVsI7snuXDaFE3JQDCW5QKEa6AcUrxwXtEj57kamd0
        xXWBYKb7Z2fWTaq0n0R5tBp33HuF3Y0GNrQXdamjjK+VGFs5XGU4Gh1scoDJgBRD
        WUm7zIxjATMelSPEpWMDxTbNpW5ZVi2MgWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691673776; x=
        1691760176; bh=m3wrM0pedGP7IS4x7QyEzIORBlLiIL9JwRyaIqKXoTY=; b=V
        o51IgXF3W/nNL07W5XP6d/Iv3b2mv3tfX1eBV72tLHxQcaWLIXxVwN0AsnxdwOsN
        zLDS0mPPkK2d1A9mOlSmngqPZYfsh7vDTOjKEGc3ljsSxZAY/HxmmKLat8bXncnj
        jd2unZnB9ecWVuKaZydIa61unR4VukY0/IIcplzSLJytTzn1KLm5dCH7Pehzo41F
        3VDJODlly93a7S7tbgdb5eroAv0vZLerX7muLjg/D6u2buuAPdsBgrBFBOEst5Eo
        qzYGlQV79fGLxrpw46xlQiPYRWG0JqzGi2CFKTGynlW4hTt7T3QgVfMI1dEzRNJa
        pikRumxWEIG/JXfKOPx2A==
X-ME-Sender: <xms:sOTUZG06lYjzA0Sf6k3creUiW4K6JkjT1IxmxcOnsvBovnr4xV0mBw>
    <xme:sOTUZJHqeeRCrFyc0nk1mv_8oiq9sHejvuFLjIgiqWUKUXxhz18OubhOnWukjBkjW
    IiVFmM8Qr8sydD4>
X-ME-Received: <xmr:sOTUZO59s8O1NtfFmF5tBnFfe1iqnbKcUqzmFswZFESSzK5zUJ0-HSTMQdxdH_fL3w95nzHBcVUX-EpTpR4sjc_s2fhDLaf2yHijOICinviyA6X15HOYB93T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrd
    hfmheqnecuggftrfgrthhtvghrnhepgeffuddtgeeigfetleelgeegueeuudetfeeiudev
    vdeufeeijeelvdejuefhfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:sOTUZH3e21YjxGT02HKtkSNd4q0FEQcGCIGDAD3o4l6uypTNo3SHAg>
    <xmx:sOTUZJHNAUNktC-dOwWqgAiL5irSo7Lr0s9yn4N4-Q28ufVGMwWZcw>
    <xmx:sOTUZA9pB-cJsLnoemI9vtRJzF5VRnqwwHYU2OOWiq8dbxzKX9Aiuw>
    <xmx:sOTUZMMqDeM-13qLGxHqxxqyhclZJr93bH3mW4zFD6GnR1oy1Nn1VA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Aug 2023 09:22:55 -0400 (EDT)
Message-ID: <e7979772-7e7b-9078-7b25-24e5bdb91342@fastmail.fm>
Date:   Thu, 10 Aug 2023 15:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] fuse: add STATX request
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-3-mszeredi@redhat.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230810105501.1418427-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/23 12:54, Miklos Szeredi wrote:
> Use the same structure as statx.

Wouldn't it be easier to just include struct statx? Or is there an issue 
with __u32, etc? If so, just a sufficiently large array could be used 
and statx values just mem-copied in/out?

> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   include/uapi/linux/fuse.h | 56 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index b3fcab13fcd3..fe700b91b33b 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -207,6 +207,9 @@
>    *  - add FUSE_EXT_GROUPS
>    *  - add FUSE_CREATE_SUPP_GROUP
>    *  - add FUSE_HAS_EXPIRE_ONLY
> + *
> + *  7.39
> + *  - add FUSE_STATX and related structures
>    */
>   
>   #ifndef _LINUX_FUSE_H
> @@ -242,7 +245,7 @@
>   #define FUSE_KERNEL_VERSION 7
>   
>   /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 38
> +#define FUSE_KERNEL_MINOR_VERSION 39
>   
>   /** The node ID of the root inode */
>   #define FUSE_ROOT_ID 1
> @@ -269,6 +272,40 @@ struct fuse_attr {
>   	uint32_t	flags;
>   };
>   
> +/*
> + * The following structures are bit-for-bit compatible with the statx(2) ABI in
> + * Linux.
> + */
> +struct fuse_sx_time {
> +	int64_t		tv_sec;
> +	uint32_t	tv_nsec;
> +	int32_t		__reserved;
> +};
> +
> +struct fuse_statx {
> +	uint32_t	mask;
> +	uint32_t	blksize;
> +	uint64_t	attributes;
> +	uint32_t	nlink;
> +	uint32_t	uid;
> +	uint32_t	gid;
> +	uint16_t	mode;
> +	uint16_t	__spare0[1];
> +	uint64_t	ino;
> +	uint64_t	size;
> +	uint64_t	blocks;
> +	uint64_t	attributes_mask;
> +	struct fuse_sx_time	atime;
> +	struct fuse_sx_time	btime;
> +	struct fuse_sx_time	ctime;
> +	struct fuse_sx_time	mtime;
> +	uint32_t	rdev_major;
> +	uint32_t	rdev_minor;
> +	uint32_t	dev_major;
> +	uint32_t	dev_minor;
> +	uint64_t	__spare2[14];
> +};

Looks like some recent values are missing?

	/* 0x90 */
	__u64	stx_mnt_id;
	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
	/* 0xa0 */
	__u64	__spare3[12];	/* Spare space for future expansion */
	/* 0x100 */

Which is basically why my personal preference would be not to do have a 
copy of the struct - there is maintenance overhead.


> +
>   struct fuse_kstatfs {
>   	uint64_t	blocks;
>   	uint64_t	bfree;
> @@ -575,6 +612,7 @@ enum fuse_opcode {
>   	FUSE_REMOVEMAPPING	= 49,
>   	FUSE_SYNCFS		= 50,
>   	FUSE_TMPFILE		= 51,
> +	FUSE_STATX		= 52,
>   
>   	/* CUSE specific operations */
>   	CUSE_INIT		= 4096,
> @@ -639,6 +677,22 @@ struct fuse_attr_out {
>   	struct fuse_attr attr;
>   };
>   
> +struct fuse_statx_in {
> +	uint32_t	getattr_flags;
> +	uint32_t	reserved;
> +	uint64_t	fh;
> +	uint32_t	sx_flags;
> +	uint32_t	sx_mask;
> +};
> +
> +struct fuse_statx_out {
> +	uint64_t	attr_valid;	/* Cache timeout for the attributes */
> +	uint32_t	attr_valid_nsec;
> +	uint32_t	flags;
> +	uint64_t	spare[2];
> +	struct fuse_statx stat;
> +};
> +
>   #define FUSE_COMPAT_MKNOD_IN_SIZE 8
>   
>   struct fuse_mknod_in {


Thanks,
Bernd
