Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6C6A9F80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjCCSsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCCSsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:48:05 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53436637C9;
        Fri,  3 Mar 2023 10:47:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DF1D2320034E;
        Fri,  3 Mar 2023 13:47:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 13:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1677869248; x=1677955648; bh=niFhLoL8mZAKHzxOwJCZtw//OYV+1zMzQDS
        BRzdqnm0=; b=ztSLewv3PTy/bRfb65COKtv+/RQX25wRX/8WIkGniMdr7husC/0
        L7gXFLB8sEFjeXccmt+LRbC1sTMt+43ThZYRZ4CacxPC5GNAE4EnZLymF98DNpl6
        nmTiI0+mLXJZYfYi+SEHqsh3rvVAagd1gjp1HDFG4+2vpKpfYtfrGBYt4GdnlZ4O
        z/t5rdqIKk1Vfw1IzQLvfqEP1X+Z/EJebJhrYS8myJOixhQiLcU/wNpoVit8PP5b
        WWpy9BRQq2I50qvrGLASCSnCjY71n8m5xgOZuIMsKYaAvoPCYdhLqfeBbOtHvYpX
        Zw2qoGLsDhmiv9EXErd3ilqzpoMxHo3JsxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677869248; x=1677955648; bh=niFhLoL8mZAKHzxOwJCZtw//OYV+1zMzQDS
        BRzdqnm0=; b=kU29IabEvWZoXjFyhjPhUQXskUEvSPrJpKhtunFmEmKZ/j/nU3z
        8gq75rPot7rzOj5IaahUYUTEjS4yEDrRbjbeNIyp29Zy8geweLiGyKP8WmXa0Z0k
        td1Qm8uhlnUwbBFsMBLFidQYo4857cYHLQzQvLnRS1S3JT4ZVnfbeQpYNBuXgBgc
        wuToqBAl37/1f2/ehaAmkEOzlaR0yxklE2DF8ueA1c+N7+h5i0/l60jp9OLnTJVb
        rW+cQ/MjfXGxGoUi6TwUB3buoLxrKJIVjZDo2DMzzeofnmwZwITLH1kypL6Z1XXZ
        7Lnb+qNhisRWIFFJnyJLlno95V3jBsFPniQ==
X-ME-Sender: <xms:wEACZLhFdt-prwaaB2Ah2sGLCbm4jZXOP1SuxAPSXi20EQgX_r04ow>
    <xme:wEACZIAblYVEpEwtdUH5_M6Rtg3fUlHV7nuL7sghrzfXATmOO_8-jhIVSvBYAIF73
    y2AepSkbMO6pKpA>
X-ME-Received: <xmr:wEACZLENkihuBed3zZw-8HaKLb_0X3EPQe4lpsYl1vwfghHdhAToXzJUCJaSC37fHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefg
    vdefgfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:wEACZIRGjOClXxxodejV9maeseHYiK8rb9oloDXG2kg_d4MlxDWziA>
    <xmx:wEACZIxiCFlzRtV9XM9z5JzuQv9dcf5ftHGl6zi6nodKX7o6wzQMRA>
    <xmx:wEACZO5ZEjPZFKF82a6Lw8W0Lo5u72v40JMhyC3Je9RlXg3xWSlgtg>
    <xmx:wEACZNqvvGPynCK3kEqg351LHxtsWWm4MpsMEE7mPijQyvUJvsmJmA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 13:47:26 -0500 (EST)
Message-ID: <e78a7256-8508-bd7f-d62f-16f5a1837681@fastmail.fm>
Date:   Fri, 3 Mar 2023 19:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 4/9] fuse: handle stale inode connection in
 fuse_queue_forget
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mszeredi@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-5-aleksandr.mikhalitsyn@canonical.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230220193754.470330-5-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> We don't want to send FUSE_FORGET request to the new
> fuse daemon if inode was lookuped by the old fuse daemon
> because it can confuse and break userspace (libfuse).
> 
> For now, just add a new argument to fuse_queue_forget and
> handle it. Adjust all callers to match the old behaviour.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: StÃ©phane Graber <stgraber@ubuntu.com>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: criu@openvz.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/fuse/dev.c    | 4 ++--
>   fs/fuse/dir.c    | 8 ++++----
>   fs/fuse/fuse_i.h | 2 +-
>   fs/fuse/inode.c  | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index eb4f88e3dc97..85f69629f34d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -234,7 +234,7 @@ __releases(fiq->lock)
>   }
>   
>   void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
> -		       u64 nodeid, u64 nlookup)
> +		       u64 nodeid, u64 nlookup, bool stale_inode_conn)
>   {
>   	struct fuse_iqueue *fiq = &fc->iq;
>   
> @@ -242,7 +242,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
>   	forget->forget_one.nlookup = nlookup;
>   
>   	spin_lock(&fiq->lock);
> -	if (fiq->connected) {
> +	if (fiq->connected && !stale_inode_conn) {
>   		fiq->forget_list_tail->next = forget;
>   		fiq->forget_list_tail = forget;
>   		fiq->ops->wake_forget_and_unlock(fiq);

I'm not sure about kernel coding rules here - for me that is unlikely 
rare event - I would have added unlikely() here.
