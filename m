Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9F7901A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjIAR5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjIAR5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:57:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A6E65;
        Fri,  1 Sep 2023 10:57:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7CA2F3200065;
        Fri,  1 Sep 2023 13:57:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Sep 2023 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693591020; x=1693677420; bh=cHHcGgcRSztsLcKdVLA1/t+Wcf1p+fdmcFK
        F30w4FHw=; b=WkMFzbfCBKMi76b8SEIwKANvAXwugqVzhESFCwfN4p45SaR8buG
        iy6aIGfniEJFD6m+TqhFaiG1COGxOZbZNkuyL8pzEX6SBndWealx88Qfi3LThvmc
        K0q6tphgLdh8ivNYlckAN6Asjlx5fSIfUDmU8U5Ntt1asn5pQDmqRCvCJCgnNpT3
        z2luG6zx69JALD4No/NojkM4bzURC+gAWKnIMYVoQBFh9Rhik55DskbwDKZfy6TB
        4qq15/lNhvtRx5A9NAB0o98VUezuvABPJZldYQyU5XejrSudzMtpPfHYYuKk40Au
        7Y3e2ANtD0YdWPrVrwkqun6apdED8olGsng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693591020; x=1693677420; bh=cHHcGgcRSztsLcKdVLA1/t+Wcf1p+fdmcFK
        F30w4FHw=; b=mKQ1kCoTjWSCICgQN4Sh83zVi3O041wtWdZHNrrd/jJE0NM1hHX
        hqY+gvC/BtaeMtnygewLZyFeTkoVY5c2W9EodgtJxFH7uQhXI6W38fw7XADbPkGK
        Bd09tjBUKjHqCMAo/dpQ0y+VqymkNnFbNaFGSCqQW6KDOrIE7VFJD4NbBuVu81XQ
        qOUU5t1kZU4d+eHO2t+qcrnIR781lBZu1f4mEn07Sp/K909vi6VZdXKX9OrAh/6O
        zX8+i3SsiIi5tMxMVLBd0WmpA4p8u/HSSMBtSeVx0iMIZQj5zMbBq43RO5EDU7Yt
        cT7JcCk9TSBlLttjXMuh/W7p/EzpELcpckQ==
X-ME-Sender: <xms:6iXyZERM0uoO-rKI_yqeN3wideGxs_MMAas-qL313AkHcYYPKRPJGg>
    <xme:6iXyZByttXoerOFKF0xUNZ88CtjFuPE3v1Sobcq4FQpnImQx0j4r71o1x9herpeeO
    _zElQVHpFh4TnW6>
X-ME-Received: <xmr:6iXyZB01Ek6RfUvwvC-NgsUv3vwTc9E-QkFp_X2HB2yCKe8wGi4wl0Oet6qJn1IYNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegvddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceorggrkhgvfhesfhgrshhtmhgrihhlrdhfmheqnecugg
    ftrfgrthhtvghrnhephfdvvdehjeduiefgheefheeikeehudejjeevvdfhtdfgveelleek
    uedugedugeehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrghkvghfsehfrghsthhmrghi
    lhdrfhhm
X-ME-Proxy: <xmx:6iXyZIAXGPsTpUd0KdDzP9lVPgtkAVdEeHRwruCc9bUXl8GuiPH3Sg>
    <xmx:6iXyZNjFonQPh3OxU5M_RrH465skNO8Zn0SyQ51mhqWs3M1KZObYhw>
    <xmx:6iXyZErpFBsPQsYKqCKKjZ7sad8gAIZYMemNoRXw92ERNQ2Kgk0e1Q>
    <xmx:7CXyZNcp_ooZWrU7dV7qw4TxyfI3d0k1bRfKS8X88NHEMLBGOOKFPA>
Feedback-ID: id8a84192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Sep 2023 13:56:57 -0400 (EDT)
Message-ID: <523cad2b-5319-6aa9-65e2-80e91a0bb050@fastmail.fm>
Date:   Fri, 1 Sep 2023 19:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Content-Language: en-US
To:     Lei Huang <lei.huang@linux.intel.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
 <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
From:   Bernd Schubert <aakef@fastmail.fm>
In-Reply-To: <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lei,

On 8/30/23 03:03, Lei Huang wrote:
> Hi Bernd,
> 
> Thank you very much for your reply!
> 
>  > Hmm, iov_iter_extract_pages does not exists for a long time and the code
>  > in fuse_get_user_pages didn't change much. So if you are right, there
>  > would be a long term data corruption for page migrations? And a back
>  > port to old kernels would not be obvious?
> 
> Right. The issue has been reproduced under various versions of kernels, 
> ranging from 3.10.0 to 6.3.6 in my tests. It would be different to make 
> a patch under older kernels like 3.10.0. One way I tested, one can query
> the physical pages associated with read buffer after data is ready 
> (right before writing the data into read buffer). This seems resolving 
> the issue in my tests.
> 
> 
>  > What confuses me further is that
>  > commit 85dd2c8ff368 does not mention migration or corruption, although
>  > lists several other advantages for iov_iter_extract_pages. Other commits
>  > using iov_iter_extract_pages point to fork - i.e. would your data
>  > corruption be possibly related that?
> 
> As I mentioned above, the issue seems resolved if we query the physical 
> pages as late as right before writing data into read buffer. I think the 
> root cause is page migration.
> 

out of interest, what is your exact reproducer and how much time does i 
take? I'm just trying passthrough_hp(*) and ql-fstest (**) and don't get 
and issue after about 1h run time. I let it continue over the weekend. 
The system is an older dual socket xeon.

(*) with slight modification for passthrough_hp to disable O_DIRECT for 
the underlying file system. It is running on xfs on an nvme.

(**) https://github.com/bsbernd/ql-fstest


Pinning the pages is certainly a good idea, I would just like to 
understand how severe the issue is. And would like to test 
backports/different patch on older kernels.


Thanks,
Bernd


