Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2B54F437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 11:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380738AbiFQJZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380514AbiFQJZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:25:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130160BA8;
        Fri, 17 Jun 2022 02:25:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 144315C004E;
        Fri, 17 Jun 2022 05:25:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 17 Jun 2022 05:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1655457953; x=
        1655544353; bh=l74iYgf36a4xgRUrlzEPDCKdeTCQISXrTwEyESJRvcY=; b=G
        /LNcEN/FNiY5Ka9UxRHujRlTljLtbdRddZQzd/0967f5uMOoPzsJTL712iS35NEi
        fs3fRjD3WFyxrZ44gZbMpG7owZMvNvMbX2+UK8Imnpn6NcnVBoWEnRfoJ9xxCWay
        b444yIAoZeQd3k1uh3rK0QaC0L0CkpLrcsFrW7QBRkpzNmsj4IY9iNEuw+5hUg0A
        G3cUEaIV3F7VwnyjfS0lfQCCj2hbztc9IrjKD8AEMcqwScO4L2ojZS4LYOut+E7/
        PDic9YevRbtHO+g4asNFu25wRwuL5PwYghqP9MMxW3y/dbcIT+m1aTy3+0sg4uVM
        AHHbHDn7bbCyBmFZHF9+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655457953; x=
        1655544353; bh=l74iYgf36a4xgRUrlzEPDCKdeTCQISXrTwEyESJRvcY=; b=g
        Ukw3ooq8XraMpYmwXtmtGlVJZ7wQeUmT8cjAS+wJsFDomIVrLspGTGR6oyesYCKF
        +zg4+kzyC/u9bV/JaqFp3RnkrExajp16pRCdBsU6tanbjYQF1XHoFMJYUPoWKyWL
        Pav/qT6uSqRagHHKtcZwtvZOvSGkCXDM6gTpu6aHZpeEg10JQlkGdpE6VjKixkzO
        DqcPLbbbi3OREU48LjZEBg/6sp+1MoV5stxOxM00580f7Xh4cun3oOi10XE2MARH
        LAYi9O+eg4tJThfnnDHc9g+9pKvSvRA9EAiLXl01CgJDB5Am/6p2gT98QfJx3b8n
        N2U7oh0Ew94ugZ0o3vmKA==
X-ME-Sender: <xms:oEisYheHzAs480LA2av084qVmdrM4gGRYFEW57dvdWsP-kpeA7s6cA>
    <xme:oEisYvNKnoqScfiJBTBgOXIijLbUwC96b5JCnMuI1yHbiau-JvLSSQpHGcNnqca4F
    wBDolzNdRpAmSp3>
X-ME-Received: <xmr:oEisYqiTIAawGEMAqM-j0h_ohGZbK4Wog6-iiAdPD9W1qymCZ8g6Dh7aBNWV9AVEYUHpmMV4hS0j9n5oXGOHS5lHH8ycRIlMDLkYr3tRK6JJVmAXls4a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:oEisYq86S_RytjG6dqjHTCKvkieTMnAVlz1DuqfGvM4dki-y4tnyIw>
    <xmx:oEisYtv6WLIMZcC4mb2T8p1Mr5-NniU3d3R0RMzxu8Xtm_SsOtJaZQ>
    <xmx:oEisYpEtDo59lWMr5L-4oN73zclk6M0QtRm8KpZJvs3N8wdKHiDvSA>
    <xmx:oUisYhjg1Rljv2eGWELh52a_1RU5JSvbZ2am61bOsShzBCVe31aL-Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jun 2022 05:25:51 -0400 (EDT)
Message-ID: <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
Date:   Fri, 17 Jun 2022 11:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

On 6/17/22 09:36, Miklos Szeredi wrote:
> On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> 
>> This patch relaxes the exclusive lock for direct non-extending writes
>> only. File size extending writes might not need the lock either,
>> but we are not entirely sure if there is a risk to introduce any
>> kind of regression. Furthermore, benchmarking with fio does not
>> show a difference between patch versions that take on file size
>> extension a) an exclusive lock and b) a shared lock.
> 
> I'm okay with this, but ISTR Bernd noted a real-life scenario where
> this is not sufficient.  Maybe that should be mentioned in the patch
> header?


the above comment is actually directly from me.

We didn't check if fio extends the file before the runs, but even if it 
would, my current thinking is that before we serialized n-threads, now 
we have an alternation of
	- "parallel n-1 threads running" + 1 waiting thread
	- "blocked  n-1 threads" + 1 running

I think if we will come back anyway, if we should continue to see slow 
IO with MPIIO. Right now we want to get our patches merged first and 
then will create an updated module for RHEL8 (+derivatives) customers. 
Our benchmark machines are also running plain RHEL8 kernels - without 
back porting the modules first we don' know yet what we will be the 
actual impact to things like io500.

Shall we still extend the commit message or are we good to go?



Thanks,
Bernd
