Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4F5BF576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 06:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiIUEiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 00:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiIUEic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:38:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B97D1F3;
        Tue, 20 Sep 2022 21:38:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E441B5C00B5;
        Wed, 21 Sep 2022 00:38:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 21 Sep 2022 00:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663735102; x=
        1663821502; bh=/oBlwj7OptLfoDBK2AJ3lQ87czh8+Sbi0J3c2Q63L7I=; b=G
        UABLQrXoDKVoeR/08dRbwcyoxuzVFSEpJnOg6+MKND93dE1T6fPyzOI8Z05r7Q0G
        KP9KxxYiZt/Yx1nLshwKdxnI8z6tgKYgff/TyuwAG8lrryVHgEBB9lTVkrLQB2WI
        vGBFcPRoP7Ke2Rr972XqkF9adcW+IJL0osDTOapKdPG8dYsmRvf6FO0yfh77YjtQ
        Es7tlcpvwepvcifuXtAJSWPBpBv27HDrvoaEd31FCveKS0NNtYI4X/7kxgO8UL92
        QzmXcTrorNE31Bw/T5Kuk9vuDqEs04llHcUOy5rdYJPjVnpQjgIFBwTVv0iTzHma
        S5kB+24TfWN6+HUaV71Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663735102; x=
        1663821502; bh=/oBlwj7OptLfoDBK2AJ3lQ87czh8+Sbi0J3c2Q63L7I=; b=T
        nHNx8LE5OF27LYigRouxUafGzlDV0+cDL83nlQNK5Iz7yzP32o1jUohIK6DAwtOR
        Im0TW5IGPw+LiA5rAbKoO7AzSKeZHFFukLO3L5mIXffp6yYty32qyLy1nsj36IHt
        s2Vmq4LdeNqgVTu0a04xJ9RMdfSlY3n6QLRKGNoo/TcTGo8mXXG8j7xjj8pmnbh7
        vKZ8vmhcGI5j06yyHdA44Di9jqalRiV449M0Gf04DdX626kecZpDNcWH49KXdXcc
        m4WNcKsV3Zo6KXiLNHpTbBq/pVThiFvashgQOBhUSyRe8djaR4LVwEmuy+i6veUi
        NzVa0bw7wQn6DwHMjuACA==
X-ME-Sender: <xms:PpUqY-sFd9MKeyik2cdpSZQxcGfbwPVvrl35Yk7BAnf4tVp-fuevDQ>
    <xme:PpUqYzfDmH8s3cDpXrsRuqzsmHc2C-fC-OWpbJYrfz46giMA-EjIFLd_zKzQ902Vo
    RSI25DKWtAf>
X-ME-Received: <xmr:PpUqY5zggjOHmCrLbICq7LdtVOPltD_dJ9aQ8tqQOjMWYxjwDnCibe4F6kTaNBFp-P6zjqR449ZBuDDo90awgE9LZDTEc3CYlaHOY2EVqstO_qRyheQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeftddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:PpUqY5M2OSFOaK32VTxyJT_6tOfZkpkqYyXCzWwuoaM9KeAHeag8sQ>
    <xmx:PpUqY-8SLJJIICPe9CLJRv63TVmWSCqjCri1rCpGe4QJjhvNVuiIMA>
    <xmx:PpUqYxVmAQ3VIm57wGKfObz4fDYQ66-0hcOYmZPEpZ9BH89vQKQfcg>
    <xmx:PpUqY-y7LRkgUqVoF2DxkpfM4SbFql0H34b00ADdgR2TlT-JwcQ3-g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 00:38:19 -0400 (EDT)
Message-ID: <7064c4cc-4098-6744-298d-fddb3621ca41@themaw.net>
Date:   Wed, 21 Sep 2022 12:38:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [REPOST PATCH v3 0/2] vfs: fix a mount table handling problem
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
 <Yypm+GO6eMdV0QQ0@mit.edu>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <Yypm+GO6eMdV0QQ0@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/9/22 09:20, Theodore Ts'o wrote:
> On Tue, Sep 20, 2022 at 03:26:17PM +0800, Ian Kent wrote:
>> Whenever a mount has an empty "source" (aka mnt_fsname), the glibc
>> function getmntent incorrectly parses its input, resulting in reporting
>> incorrect data to the caller.
>>
>> The problem is that the get_mnt_entry() function in glibc's
>> misc/mntent_r.c assumes that leading whitespace on a line can always
>> be discarded because it will always be followed by a # for the case
>> of a comment or a non-whitespace character that's part of the value
>> of the first field. However, this assumption is violated when the
>> value of the first field is an empty string.
>>
>> This is fixed in the mount API code by simply checking for a pointer
>> that contains a NULL and treating it as a NULL pointer.
> Why not simply have the mount API code disallow a zero-length "source"
> / mnt_fsname?

Hi Ted,


I suppose but it seems to me that, for certain file systems, mostly

pseudo file systems, the source isn't needed and is left out ... so

disallowing a zero length source could lead to quite a bit of breakage.


Ian

