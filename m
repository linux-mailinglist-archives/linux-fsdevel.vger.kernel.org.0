Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177CC586D83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHAPRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiHAPQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:16:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0828710;
        Mon,  1 Aug 2022 08:16:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E7BCF5C0170;
        Mon,  1 Aug 2022 11:16:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Aug 2022 11:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659366986; x=1659453386; bh=Jlx2wYS5dQ
        dMZHaghArFewcukAvfQ2fbejFlis23+aY=; b=aIU0HpcThNBOo6ZZJQRtmFrO4g
        gE1B39TEWk8ZWiYdZ84gH04zoDxg526nHX+nsq0AK6DSmLN55UjyGtDQQlTVxKKQ
        0AJKeiMRK6dSSXCWhM53EIXSogbgniiDe8Rnb6Ry5b6BTjsSWMVkDXLa76ziBS6f
        fgblPPQuZzCMWf9ql++u1dyIpM1A6dikBmFlx7MvXjWii/IvMbmiImYyNjiB8N7r
        6YsL56Zyfc78VbX81ed9b4Qj6P/YYmq9AHvprt4PzcwKq+HrQzURFDbpWeLHmBSe
        vOZI9NJEgrjA7GlOpG4ZysrilMKHoTKXa/9LSTJSvv793uyc+mDCHklYuEsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659366986; x=1659453386; bh=Jlx2wYS5dQdMZHaghArFewcukAvf
        Q2fbejFlis23+aY=; b=E0snMbrZg5xvbjxrUpoz7PM7dW2IzqG2uLP3WTbO7yXS
        KsZE7kfF42nht4pSdYwiimka9LCy+WmQ1qZ6znerWlsNj6wJRW1+uPlCB2/rL0JW
        gudMuY1SJysmPofkw6Jma6H+OvUt/79Abiqz0L1Deg1lBRwaCnol/HCx2/Q6Pf0R
        U5IZpmfZnm4kb5y5bXP5kAmTnCz0uO5O83E7+A5hVwEv2qHvniq8EkYqyPoXdxO7
        2oCLzEFrT9uiryb8sSPMGFQG6+h59PE3ApfXj88o1SqMdAQx43ri1VB1u1iJ654c
        pkLRTrFu4go3y2eVCg1L3+fr5ijX3Gqmn3HhR8bc5A==
X-ME-Sender: <xms:Su7nYjsHH5a4J6YMvOkOb-BPnqNseDcpcC-y5U3mS6GEvP8elEPi1A>
    <xme:Su7nYkcyD-iHnzYjpshw-3co7cVI7YoalADZVbHl3SO4gik6Bk_lEn9ccgT5cD-pL
    UNqpKAKYcMrSg-feeE>
X-ME-Received: <xmr:Su7nYmyKeFjb3Sin2HTSlmMc-rOInbdhpSatPmrsJ-qJnhmGHNmzX-O2FBJl6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:Su7nYiNkI4DfqBt5l5Jb_lVX561Zkvp6xhVEJj0sqz1vrhMpITnAWw>
    <xmx:Su7nYj_ZkEFFy-8rEraSKbqnLyctQmI8DAPI6Rn7xm1gBGkzARVMWw>
    <xmx:Su7nYiW21XZTNvowFVzyM7XfGDYEzWGduwzBT6jLgpOS1yPnvF9MAw>
    <xmx:Su7nYukLYtFBDh7MLlz4ijzzdeWlANB9cClK9Nj0kSqgi9Y92y4CfA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 11:16:24 -0400 (EDT)
Date:   Mon, 1 Aug 2022 09:16:23 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants
 the return code
Message-ID: <YufuRyehrRquv+lk@tycho.pizza>
References: <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
 <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
 <20220729204730.GA3625@redhat.com>
 <YuR4MRL8WxA88il+@ZenIV>
 <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 30, 2022 at 12:10:33AM -0500, Eric W. Biederman wrote:
> +static int fuse_flush_async(struct file *file, fl_owner_t id)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	struct fuse_file *ff = file->private_data;
> +	struct fuse_flush_args *fa;
> +	int err;
> +
> +	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> +	if (!fa)
> +		return -ENOMEM;
> +
> +	fa->inarg.fh = ff->fh;
> +	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> +	fa->args.opcode = FUSE_FLUSH;
> +	fa->args.nodeid = get_node_id(inode);
> +	fa->args.in_numargs = 1;
> +	fa->args.in_args[0].size = sizeof(fa->inarg);
> +	fa->args.in_args[0].value = &fa->inarg;
> +	fa->args.force = true;

Seems like you need a

    fa->args.nocreds = true;

here or you'll hit the WARN() in fuse_simple_background().

Tycho
