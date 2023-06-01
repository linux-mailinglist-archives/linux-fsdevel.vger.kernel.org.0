Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C94719866
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjFAKI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjFAKIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:08:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DCC138;
        Thu,  1 Jun 2023 03:06:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 167DF320069B;
        Thu,  1 Jun 2023 06:06:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685613993; x=1685700393; bh=8ZuU8TLDMySBnmghexzuWEa4NXd1xIu7Ee2
        fhDFog6Y=; b=B0NeQNg24xK+OoIFrVSls7ao2BGeZayfqlYJJn1anYHjnO50rkv
        NOO6fnvCOXoPpvFB2671T6AswEIcuH/uEPX5EsT3z8YqU7xyiJ6vWtVxK5ya/1zr
        90S7kJRE1peSTKNgVIKSDy9F23lOhokUaJz1jy7vTKbjjdMR2EyLaXaWLHu+TEXj
        PpdF/Y8Fma0Uai7uvV0YkvkCD85Sdv5rJpm90bNw1HTVQiiCIo8MfNiy5eEwC5nI
        3nuNPxvMUO1K3kFroe1fwcIMqxN/PgjZ76HtO0UpMFY6JIIwSC3ygLVor56gT//g
        th8ZfLVbc03nEavoBPctF8gRTnp3f4UcIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685613993; x=1685700393; bh=8ZuU8TLDMySBnmghexzuWEa4NXd1xIu7Ee2
        fhDFog6Y=; b=aaIgCVU34yJfwMFzTrrBwqx/Qcu9VgCYnru+25FPEX07Qp0P1XT
        1TLfjcVS/U9KVUyBXZzVTTkAfqhID3GjsQJbxfJp378jHS89KYISzaEVIodrLi9L
        P/5mOg0VVsoVlykbF+3cEgAJewoJxGwTr3p1lkLlwLNsoymVTOh6BNaXKhdcxauf
        XBkg/ZFUNDwPFR+OJClF3JX5M9ldUHPK9K//nwimWLd5E28ANTN08QhSjMg7HKQ4
        E1MRpv/Coaz2BTopEp2n/1gsF059oABqWearEc9CRZaEUKCHTv3CCOKGjxVOyY/8
        IT+4eRUgADN1fFePoxiadhs2V+0lmdb+dvw==
X-ME-Sender: <xms:qW14ZAPQUbn6w14w9ITrWgoDhBqhOIwabnwRyGOhartZGpQHWeDGDg>
    <xme:qW14ZG9fcg3m7HypuSQW09wrizA5xV40GmtYO12mAwvUvhddYkS_9yOeu3PpeQXn4
    UgwDbkbSeUIvptF>
X-ME-Received: <xmr:qW14ZHS0JK9tm-ygtF0unYYYIo4LRHHmUbl-5kIrWXN4tWPdW9sv7JRzaplfW6NN_7Gspnk-qaTFUL2nLwW93GtCUEjEVfSlWLORTXMu4pukJSPmgr7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekhe
    evkeelkeekjefhheegfedtffduudejjeeiheehudeuleelgefhueekfeevudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstg
    hhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:qW14ZIt5lMTI4aRpvjIgsAu_miSGHKvs9dG6RPthSfSsBgP2u9yKVQ>
    <xmx:qW14ZIdm0urElOxyJS8Y1S7Q5L6qHZtRXM0AF5dOTTB0IE6Moocfhg>
    <xmx:qW14ZM2NDRuHY9q4WXT6oN4bvPXtI8HmPQVeSz3FSjyWqLQmIObhTw>
    <xmx:qW14ZH45BwoF92PdEuFVlY6HnZgW7At2GkcncX-LC8jHYV4mhHnlrQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 06:06:32 -0400 (EDT)
Message-ID: <a00dc6d7-05b6-b0c2-7e89-262de91f5f18@fastmail.fm>
Date:   Thu, 1 Jun 2023 12:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
To:     chenzhiyin <zhiyin.chen@intel.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com
References: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner>
 <20230601092400.27162-1-zhiyin.chen@intel.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230601092400.27162-1-zhiyin.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/1/23 11:24, chenzhiyin wrote:
> In the syscall test of UnixBench, performance regression occurred due
> to false sharing.
> 
> The lock and atomic members, including file::f_lock, file::f_count and
> file::f_pos_lock are highly contended and frequently updated in the
> high-concurrency test scenarios. perf c2c indentified one affected
> read access, file::f_op.
> To prevent false sharing, the layout of file struct is changed as
> following
> (A) f_lock, f_count and f_pos_lock are put together to share the same
> cache line.
> (B) The read mostly members, including f_path, f_inode, f_op are put
> into a separate cache line.
> (C) f_mode is put together with f_count, since they are used frequently
>   at the same time.
> Due to '__randomize_layout' attribute of file struct, the updated layout
> only can be effective when CONFIG_RANDSTRUCT_NONE is 'y'.
> 
> The optimization has been validated in the syscall test of UnixBench.
> performance gain is 30~50%. Furthermore, to confirm the optimization
> effectiveness on the other codes path, the results of fsdisk, fsbuffer
> and fstime are also shown.
> 
> Here are the detailed test results of unixbench.
> 
> Command: numactl -C 3-18 ./Run -c 16 syscall fsbuffer fstime fsdisk
> 
> Without Patch
> ------------------------------------------------------------------------
> File Copy 1024 bufsize 2000 maxblocks   875052.1 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks     235484.0 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks  2815153.5 KBps  (30.0 s, 2 samples)
> System Call Overhead                   5772268.3 lps   (10.0 s, 7 samples)
> 
> System Benchmarks Partial Index         BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks     3960.0     875052.1   2209.7
> File Copy 256 bufsize 500 maxblocks       1655.0     235484.0   1422.9
> File Copy 4096 bufsize 8000 maxblocks     5800.0    2815153.5   4853.7
> System Call Overhead                     15000.0    5772268.3   3848.2
>                                                                ========
> System Benchmarks Index Score (Partial Only)                    2768.3
> 
> With Patch
> ------------------------------------------------------------------------
> File Copy 1024 bufsize 2000 maxblocks  1009977.2 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks     264765.9 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks  3052236.0 KBps  (30.0 s, 2 samples)
> System Call Overhead                   8237404.4 lps   (10.0 s, 7 samples)
> 
> System Benchmarks Partial Index         BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks     3960.0    1009977.2   2550.4
> File Copy 256 bufsize 500 maxblocks       1655.0     264765.9   1599.8
> File Copy 4096 bufsize 8000 maxblocks     5800.0    3052236.0   5262.5
> System Call Overhead                     15000.0    8237404.4   5491.6
>                                                                ========
> System Benchmarks Index Score (Partial Only)                    3295.3
> 
> Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> ---
>   include/linux/fs.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 133f0640fb24..cf1388e4dad0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -962,23 +962,23 @@ struct file {
>   		struct rcu_head 	f_rcuhead;
>   		unsigned int 		f_iocb_flags;
>   	};
> -	struct path		f_path;
> -	struct inode		*f_inode;	/* cached value */
> -	const struct file_operations	*f_op;
>   
>   	/*
>   	 * Protects f_ep, f_flags.
>   	 * Must not be taken from IRQ context.
>   	 */
>   	spinlock_t		f_lock;
> -	atomic_long_t		f_count;
> -	unsigned int 		f_flags;
>   	fmode_t			f_mode;
> +	atomic_long_t		f_count;
>   	struct mutex		f_pos_lock;
>   	loff_t			f_pos;
> +	unsigned int		f_flags;
>   	struct fown_struct	f_owner;
>   	const struct cred	*f_cred;
>   	struct file_ra_state	f_ra;
> +	struct path		f_path;
> +	struct inode		*f_inode;	/* cached value */
> +	const struct file_operations	*f_op;
>   
>   	u64			f_version;
>   #ifdef CONFIG_SECURITY

Maybe add a comment for the struct that values are cache line optimized? 
I.e. any change in the structure that does not check for cache lines 
might/will invalidate your optimization - your patch adds maintenance 
overhead, without giving a hint about that.


Thanks,
Bernd


