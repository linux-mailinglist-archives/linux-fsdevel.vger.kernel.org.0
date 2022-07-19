Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B5357927B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 07:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiGSFbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 01:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiGSFbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:31:07 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5411EADA;
        Mon, 18 Jul 2022 22:31:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E4D375C0153;
        Tue, 19 Jul 2022 01:31:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Jul 2022 01:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658208663; x=
        1658295063; bh=1sjBbxFgBPTiDVOSKWdlcO9spNR6ZcXpMfJWWKpeatA=; b=g
        9i2q1lSSTwEH7YK2NPleq3VoDczMDZrUpX2AavXw54ijBz6VHsshViBQTGxZ8j2z
        8DxQIEYq5iumemoELwgQXrKkU5PYnauKtjMeUSkhBvUbUQ9nLhTSfhTd1Ybl+oOQ
        +yQP8UDa8SltBDWYpV9vr0pQpzbSJy4FbmpQGPSNUxwVYPtZLIylCMUis7ql3DsU
        oh0G7rpALhz8kpJCm8DNvYW0dKzurjDXsr46Ks8uiVrVdk8hUT1Sws+ste6ZMiBn
        1vM9xroVjLO625QCmFxdibGunCTdaLZ0RIAYwzhjWy1qHV/faL29uWwzT6Vr1/qK
        kfCUQcL0b6ormB08TPopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658208663; x=
        1658295063; bh=1sjBbxFgBPTiDVOSKWdlcO9spNR6ZcXpMfJWWKpeatA=; b=s
        MhPHtulg1BV/bGQd9QPM7If+m/igHOm9IWhg8wgXaUTctZ7EGxXGUtqxCrFMcjTi
        tyeP20kLp6tIsGLqVMIVI2UsJG/vbLyr6avTavTeTxVBkbLnerjlxPHLuFmxthLE
        tRfAMNfvUY2qPidy9pmyKWwDyrDe54YW5C4BeVfPf47AN291lzY0ep2SrdGSsh2T
        iBywv6fl7fn9KKBIe/zYtG59ezV8wvOYoPTXmq2gKWS1MLkU+i82+uDV5gc0yONw
        iWSE+T1x8s2tNotXj2iiI6URKJsVxZ3iG6wJEmDdv8rdYC21a9o8qHiyskoMV2nW
        lIlE6LZIIhIfOZpgQBe0A==
X-ME-Sender: <xms:lkHWYi6bJysiROujFRA1_gnzxX7FyqtQHAuLOx-UDd7QCIo_mPyDtw>
    <xme:lkHWYr6Cpi-J2nyRpIfz6pGGnmeOAgmDrcICjne7RfcExhouYEu6aYLULzWaLVVKO
    gStgxj3m-sL>
X-ME-Received: <xmr:lkHWYhe35CVw08yBJRSBcG179fDZUsVLh9wKw-TL5fhUobuLZ61KCTWqEvMaax0Vh5kDUq2Xl6b_k2tlqyRMyR_M_6P0CtluJOZU_xMgLeGx4A4CnjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    ephfdtfeeggeeuhfdthfelhfehgeevueeluedtveehhfehudehveehuefggefggfehnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghm
    rgifrdhnvght
X-ME-Proxy: <xmx:lkHWYvIK-J7nROEtnWWV6eQH8Ige26z6vhlabxj4qR3R12MnqluGgA>
    <xmx:lkHWYmLZzbgjxxnBX1wT63DWtr-y0TbmAuWFIlbYS3In2mgZaXNhhg>
    <xmx:lkHWYgw3MoQycjvIzNRM4lXXG9a8OXWVr_OfkwJDrVyraf25kJi__A>
    <xmx:l0HWYl-TmzYjFLcro4GHpWoDP1n62XVH3G4iWDWEwO3oAXYXlX1r5A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 01:30:58 -0400 (EDT)
Message-ID: <d93e3eb6-38b9-6a70-af3d-ab10fa646c96@themaw.net>
Date:   Tue, 19 Jul 2022 13:30:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [vfs] f756fe900f: canonical_address#:#[##]
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <YtVvs06ZoG3BtMyf@xsang-OptiPlex-9020>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <YtVvs06ZoG3BtMyf@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/7/22 22:35, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: f756fe900f17af85c3f4bafc9b9e996bcc0fbeb1 ("[REPOST PATCH v2] vfs: parse: deal with zero length string value")
> url: https://github.com/intel-lab-lkp/linux/commits/Ian-Kent/vfs-parse-deal-with-zero-length-string-value/20220708-094030
> base: https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git for-next
> patch link: https://lore.kernel.org/linux-fsdevel/165724435867.30814.6980005089665688371.stgit@donald.themaw.net
>
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220711
> with following parameters:
>
> 	disk: 4HDD
> 	fs: ext2
> 	test: ext4-group-02
> 	ucode: 0xec
>
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  380.748272][ T5965] EXT4-fs (sda4): mounting ext3 file system using the ext4 subsystem
> [  380.856453][ T5993] EXT4-fs: journaled quota format not specified
> [  380.879248][ T5997] EXT4-fs (sda4): mounting ext3 file system using the ext4 subsystem
> [  380.911204][ T6003] EXT4-fs: journaled quota format not specified
> [  380.924796][ T6007] EXT4-fs: journaled quota format not specified
> [  380.964372][ T6012] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> [  380.975568][ T6012] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [  380.983810][ T6012] CPU: 1 PID: 6012 Comm: mount Tainted: G S        I       5.19.0-rc2-00001-gf756fe900f17 #1
> [  380.993786][ T6012] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> [ 381.001854][ T6012] RIP: 0010:ext4_parse_param (kbuild/src/consumer/fs/ext4/super.c:2109)

It has to be this:

@@ -2110,12 +2110,12 @@ static int ext4_parse_param(struct fs_context 
*fc, struct fs_parameter *param)
         switch (token) {
  #ifdef CONFIG_QUOTA
         case Opt_usrjquota:
-               if (!*param->string)
+               if (!param->string || !*param->string)
                         return unnote_qf_name(fc, USRQUOTA);
                 else
                         return note_qf_name(fc, USRQUOTA, param);
         case Opt_grpjquota:
-               if (!*param->string)
+               if (!param->string || !*param->string)
                         return unnote_qf_name(fc, GRPQUOTA);
                 else
                         return note_qf_name(fc, GRPQUOTA, param);

IMHO it's fragile without the additional check since the file system

has no control over how parameters come to it both in the old and new

systems.


Ian

