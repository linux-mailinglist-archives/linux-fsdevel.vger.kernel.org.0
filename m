Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A952857ADFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiGTCb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiGTCbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:31:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EB5A891;
        Tue, 19 Jul 2022 19:31:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A99C5320089C;
        Tue, 19 Jul 2022 22:31:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 19 Jul 2022 22:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658284292; x=
        1658370692; bh=29i1hrZsl5NXrlVlhjdPpQNpjKoeLeQnUW12TsJOaio=; b=N
        7mvVFDfiwzkmmi8YfhXoRe8L+Bz/oh9mrkAptbYnCPhoavGUjzcOaUfA7gT/oRyS
        faLOsPrgRNdjA6BRHrqUxofQFtNPF7AvPSi9uYhSgks9lF1yMZ1kYlxz1OTwU44G
        3e2d8z1fGtVzquAnKu+54o17M/D7REi2pByXtGXEsR6jq0ZjMH458uhWy6B+mDmo
        EYL7eWXk+1QhRsSr5rxf4cLywBxpc4uiG6IB5rzYWe5UuOgF40E9Hw6taFElhCYy
        GNN3C/JsZZDaVE262ZzCxafsZ7NK1B9lvKxASLesD6+iB0T6Q3l5DtqlJxb09zNe
        OnDKXqPY8RQg1ZzjRFHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658284292; x=
        1658370692; bh=29i1hrZsl5NXrlVlhjdPpQNpjKoeLeQnUW12TsJOaio=; b=B
        JmDTV+X+BdlEiUbNUxzCS8xKncB/K+APilpbwmFiHN9bL+yKM/8dEdBnKqgnJXOX
        KSwfUIrYgD3+GXidnhePUXuPyXIkXrgpL7Fl6X8L1iWcMk0YVzXEDeVFegxZWCE2
        ReS49qnkwLKAOT02wvhANWVH0Q1koyZZ6qEYQ0lYqzCoo4NB739n9rBvCLzFFMPv
        CcEnrjodVprkO3svuTC3BnrJu1wVuL8VNKgW4p8qcweRog5hiWlIaefGb8dti/8J
        NKBtpJ9lsUUTJx0RIuxLIxhZygkCbMDYfCVbAqEYj0Paim7Ffu8VzkH7Yt0mDpjf
        UjGK0SPMS9k+r8aRlsC/g==
X-ME-Sender: <xms:A2nXYlK-sAwZUCIqK4cTB1ErlRfF7AEO6utZUTppLab9rPJEnQotMA>
    <xme:A2nXYhLRzAnbyPsTqU7x8xSTTb4xhqziryaHsFn2Usu7V9ngM9pe7FoiHD3BFgO46
    oNZhAYXWE-y>
X-ME-Received: <xmr:A2nXYtuIA4CDUy8UJHWQ4VDXqaLoKNq_Obvb-9cFjfxwk9yzWSLRyL9pIGJNf-HBUdffckkQP8EBYI8WJTOH28P7SWvRak2_nsuVr8nSpbGWNLSmn_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeluddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:A2nXYmZzPQcXiJSzk__nMgr7iKiyTBX8cMapBBsIyM9Mx2ATiSKRCw>
    <xmx:A2nXYsaKI10HGosAZHYFu1tPwQx9gtQKpoL_wmhfQtz002idMSbUag>
    <xmx:A2nXYqCWProIE7AuayrnpvC6xvcs_L5IdsL02mSG-mlV1xrFP-dUYA>
    <xmx:BGnXYkEwZ-yuPA0WlNIC4uXmLLpUklwXq-NJCu8fkYvzbL6-8c3dmQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 22:31:28 -0400 (EDT)
Message-ID: <41252c7e-674b-c110-962b-c20204dc7424@themaw.net>
Date:   Wed, 20 Jul 2022 10:31:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] vfs: add propagate_mount_tree_busy() helper
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066658.210556.1326573473015621909.stgit@donald.themaw.net>
 <YtdgUOJlTc4aB+82@ZenIV>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <YtdgUOJlTc4aB+82@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 20/7/22 09:54, Al Viro wrote:
> On Mon, Jul 11, 2022 at 11:37:46AM +0800, Ian Kent wrote:
>
>> +static int do_mount_in_use_check(struct mount *mnt, int cnt)
>> +{
>> +	struct mount *topper;
>> +
>> +	/* Is there exactly one mount on the child that covers
>> +	 * it completely?
>> +	 */
>> +	topper = find_topper(mnt);
>> +	if (topper) {
>> +		int topper_cnt = topper->mnt_mounts_cnt + 1;
>> +
>> +		/* Open file or pwd within singular mount? */
>> +		if (do_refcount_check(topper, topper_cnt))
>> +			return 1;
> Whatever the hell for?  umount(2) will be able to slide the
> underlying mount from under the topper, whatever the
> refcount of topper might have been.

My thinking was that a process could have set a working

directory (or opened a descriptor) and some later change

to an autofs map resulted in it being mounted on. It's

irrelevant now with your suggested simpler approach, ;)


Ian

