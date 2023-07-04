Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3147475C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGDP5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGDP5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:57:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02610CF;
        Tue,  4 Jul 2023 08:57:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA7145C014D;
        Tue,  4 Jul 2023 11:57:06 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Tue, 04 Jul 2023 11:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688486226; x=1688572626; bh=ZU
        fuFzRVR7Z5joRopDD06vSXYpZWzL1KtHNnkTswtGM=; b=NXMAMnFG4lc6lbs3EM
        FB+uE7qqTxFyboH0fkS+eyoDNIDtjMZP4Uts835zaO8NWRmB4p7tnPLzOLYurg3I
        Um+emflhPLK8bYiVztGGO4rDwb/0icrzEtIFbIJSG16efYnJuKZkqj4O7wjZc307
        z1G9E7G+KyDVm+06aTTdo/VbID4akHoxnONEp0ljeEdPZlGzKz7kLifxf/rO6Vmh
        zeW8itP5sMQrvXxjgdKSLBm2dMwOFBt8wlJWfES5MT1n8kr1OyUan/ELwmqdnsYR
        O/PnfLf3sBvO8bYb2sh2f3M4o2butq85LKkNBcsv323TfqtRx/bN3SdPQkzH7Fw8
        wF3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688486226; x=1688572626; bh=ZUfuFzRVR7Z5j
        oRopDD06vSXYpZWzL1KtHNnkTswtGM=; b=ONDqJEhWYYAIvFfoxFfv/NP6uBnwN
        QPqYCSvTa87tMZ1MWexCrNL80OOtmLMDknV3R5NexD4OzSxnqFzwyHf9bVzUQad6
        FJA3r7n2+Qtn3Xdw1HzLIfuXUcu8RdKBpjnNfLAUscB0T1GHOeXeCCffTncYqx/Q
        Aoho2i9I3eSNTFowZLo9zwOWO1GT1p77wlhX0S3JcWMPcMNGcHZWHHEhEx+Cm5SJ
        dwyMVSVaKTqh53mchXk7f7NFQgh83Yy/QqRGc7umGWOfBK76FVhO5gCo1CVzHC6E
        AXMa9G6im+UXw2J6ExpTxbiGOsLUSftz6D93co6DIQH6udCqiV40atdlA==
X-ME-Sender: <xms:UUGkZMqzkAse1RIMae3mdSaFJGhMOBj65AFziiy5izfqW1e3oWnj5g>
    <xme:UUGkZColUiAXQlW0cG3b7pcFtV_uLw0TbViUom3VkJD47_aSsxCSGAs_d1nArwm2Z
    4ZChvmAX2cXCxQ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdevohhl
    ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffektdfgleeuudevheduueetffejgeefkeeifeekfeetkedujeff
    veeiudehhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghu
    mhdrohhrgh
X-ME-Proxy: <xmx:UkGkZBPndTbQCeq1cEAcAcLcJ7Uz0CEbvut23fSnM6e_wPFb99wQhg>
    <xmx:UkGkZD7hNeIouH3XLlpMHObVxmf1sMpO6aTQ3wLAn8gvU5bSAZAxVA>
    <xmx:UkGkZL5ful47gpNwszxbgCwahKSn0LqOWnpzUws9-bEksV1bszcYJg>
    <xmx:UkGkZPikEW8WZ89KpKzxYBY2d-V9nQEj3e6AETVClD-282Zio8F8Rw>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D671F2A20080; Tue,  4 Jul 2023 11:57:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
In-Reply-To: <20230704125702.23180-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
Date:   Tue, 04 Jul 2023 11:56:44 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Kees Cook" <keescook@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        "Alexander Popov" <alex.popov@linux.com>,
        "Eric Biggers" <ebiggers@google.com>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        "Dmitry Vyukov" <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to mounted
 devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023, at 8:56 AM, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether writes to block devices open with
> BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> this flag for used devices.
>
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
>
> Link: 
> https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/Kconfig             | 16 ++++++++++
>  block/bdev.c              | 63 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |  1 +
>  include/linux/blkdev.h    |  3 ++
>  4 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe0..8b4fa105b854 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -77,6 +77,22 @@ config BLK_DEV_INTEGRITY_T10
>  	select CRC_T10DIF
>  	select CRC64_ROCKSOFT
> 
> +config BLK_DEV_WRITE_MOUNTED
> +	bool "Allow writing to mounted block devices"
> +	default y
> +	help
> +	When a block device is mounted, writing to its buffer cache very likely

s/very/is very/

> +	going to cause filesystem corruption. It is also rather easy to crash
> +	the kernel in this way since the filesystem has no practical way of
> +	detecting these writes to buffer cache and verifying its metadata
> +	integrity. However there are some setups that need this capability
> +	like running fsck on read-only mounted root device, modifying some
> +	features on mounted ext4 filesystem, and similar. If you say N, the
> +	kernel will prevent processes from writing to block devices that are
> +	mounted by filesystems which provides some more protection from runaway
> +	priviledged processes. If in doubt, say Y. The configuration can be

s/priviledged/privileged/

> +	overridden with bdev_allow_write_mounted boot option.

s/with/with the/

> +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> +#define BLK_OPEN_BLOCK_WRITES	((__force blk_mode_t)(1 << 5))

Bikeshed but: I think BLK and BLOCK "stutter" here.  The doc comment already uses the term "exclusive" so how about BLK_OPEN_EXCLUSIVE ?  
