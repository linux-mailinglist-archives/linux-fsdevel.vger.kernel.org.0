Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B938634924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 22:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiKVVXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 16:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiKVVXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:23:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C584199E;
        Tue, 22 Nov 2022 13:23:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 024923200962;
        Tue, 22 Nov 2022 16:23:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Nov 2022 16:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1669152218; x=
        1669238618; bh=uIR9dk1OF+2PZRsUTj/ptcMPoZCuHHWt4csJMKZd7Kg=; b=U
        vvgMVGSje05hUnxOvsk8JRVTCyR8dj23dDwlxETL0bvJ8x/u22DQB5s/gEyTVcCT
        G1FxUoK5m3KAgXaJf5dRMYK4pftWwlybxvfVzCYRbnsgT9m3T736W9Ybgiz7Zmtn
        voEy/jsa0QpZSal91XQ9utfRw+aB6K1JYzuO1YBabZaEKFn4x36VJzN5d5Zx3keU
        OBUShm2Nhu9p1xSN/vSF2ECzxTETREUZUdJFH1s+18MW0nW3gVF2C8XSM2s7Q51M
        QffjwyuvmY+rWSJi/rqZUVWaLbgc43p+ie/xgsJ74MXgsY3GoG/8hlvMGZaKDiqR
        BTNUClPzRULJc4vOWhbpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669152218; x=
        1669238618; bh=uIR9dk1OF+2PZRsUTj/ptcMPoZCuHHWt4csJMKZd7Kg=; b=h
        JbsEQofi0nUHo6b2IyxgT/XfJhhGrtUr2QpFQeixFbzDB7bj9/ppmFI2Ibn0IZ7H
        WSS20aMWS/0Dh9Hloy6BtFAf5saPVMcFJ+RF5SM8qknhkUFJDZQO33Tj2mpQuWgD
        PZgb/EnwwaMJKg321V3JmIczD3BA8rby9vKgonv6o3QsNq8gmskDA3U6PaJRTinp
        vUuWOI/FfTEV8bnbpaWMofoBu4dORVjSIZT/W2rWXg5MfVd+eOolinjCkux84LeT
        3wQsVhcZ9AJI9zVwRUmh0zSf1kOYXe2YzOd3XpYWrnUBcf8yaLV23fzVP059pSnY
        aBXV86O6nQiRjEpoOBNcw==
X-ME-Sender: <xms:2j19Y3JrigSXFCdotpMUUYgRDMRBawK9eF3OqtZMBJevtNYvJ8JM9A>
    <xme:2j19Y7JHhnx93vfhRQP7-PtPqU3hws8UL5ikHNBLTHlaPG3isVK-Z2twvVCEBVlRH
    6X8C7rF51p0kdPK>
X-ME-Received: <xmr:2j19Y_vKDhVJgCHuXcxKU-n7IPOotUXebwbeSGp5jIvvGIGXYj26eKl4KDUJj8vI9JP1ok0U2NnLbBDnO4VDoDG4Qppa1tDxjXrSNf-4TBJWsxSOQM0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedukeehleekjeehvddvieeftdeuleeiiedu
    tdelhfevueeludfgleejveeitdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:2j19YwZb8U9EijRe6aGI01Ws8wI-mXFLGRRa4YsgrkwlZ7zcg4mVkA>
    <xmx:2j19Y-bpVjvD7kYwexH4NnwqXqzt8eLvR_PZziuLHUZQjG60SUQvbw>
    <xmx:2j19Y0DXFO_w_5M_nXnfdangmTAxuOr0Uv08BinOZ2cBUvb7dfdX4Q>
    <xmx:2j19YzOREVdWlAFHMSZFYodzCTgVcg0L53YZIjNUDYNmrsFOMWJfxA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Nov 2022 16:23:37 -0500 (EST)
Message-ID: <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
Date:   Tue, 22 Nov 2022 22:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for
 FUSE
Content-Language: de-CH, en-US
To:     Daniel Rosenberg <drosen@google.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com
References: <20221122021536.1629178-1-drosen@google.com>
 <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/22/22 21:56, Daniel Rosenberg wrote:
> I've been running the generic xfstests against it, with some
> modifications to do things like mount/unmount the lower and upper fs
> at once. Most of the failures I see there are related to missing
> opcodes, like FUSE_SETLK, FUSE_GETLK, and FUSE_IOCTL. The main failure
> I have been seeing is generic/126, which is happening due to some
> additional checks we're doing in fuse_open_backing. I figured at some
> point we'd add some tests into libfuse, and that sounds like a good
> place to start.


Here is a branch of xfstests that should work with fuse and should not 
run "rm -fr /" (we are going to give it more testing this week).

https://github.com/hbirth/xfstests


Bernd
