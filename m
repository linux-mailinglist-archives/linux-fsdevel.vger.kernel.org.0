Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AAC6E4C69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjDQPKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDQPKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:10:10 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB47ED8;
        Mon, 17 Apr 2023 08:10:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D98E15C0110;
        Mon, 17 Apr 2023 11:10:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Apr 2023 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681744206; x=1681830606; bh=TS9dMLl1hXAh0cv6Px1UOsJTZ3pL/MLAgWs
        qzx5qTU8=; b=lCW/YyIgXLHf2QfAPXj7gabdcE+BamOdn1rtThmbgmbaec1uWc+
        tAr2LJF50C7qPUFwW71jKy5nswyjufmtHV/wyfpCDgO1AYPOoUfI1RA/IIKKnx8+
        67hOTyu7SuKlG9yNvrFKGtPrGMikqR1Td5fl55zB3TO3/GZjfp5Cdr+ey57yIaaX
        4yMt8IqAf6gvIAHmKjfHSZlzo6GLiQPV/GmILz/0eHG1CjXHb7+PWTFZS05soKr+
        jYMrwB44jmyQE1fGWnPgygg58uczA2q2kgsOQuXagcTqoXEaQPrmvt0cmhcsykje
        zwx7q57UyRtZ0RI3vTXm6mLoXOXUqeSAYiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681744206; x=1681830606; bh=TS9dMLl1hXAh0cv6Px1UOsJTZ3pL/MLAgWs
        qzx5qTU8=; b=HIVkCOtlZRX+Th9ErFStcskg/WByy0+EjyvCwZZ2tp7GVQTO0w1
        usZBUj+qF9W+RMX9qJ1p5UXXXLiS5vlvJm9ympTqYHOWcf6QvDRuM9nIE+AOZVNC
        hbPq/P6owa3nHj6HJ4MlrVIR0rrZ+BHCUd8cHtDlYttGi+2n2Dh2wlLXubfcVb5Y
        mPxu6+tqHelKujOtcFuK/1EenAoJJoxvnB0DrejQQEEByiNKXqR7NMmQaA9uTYwd
        VHl1dGAHI0yDLUtUmOPLVquWQyxAPVeTsKL4w0/gE/px9jJ07jBrnRt+HqhIG7rX
        PWjPsGlD/OGQl9q21vT2hD45hLbt3r3PVlw==
X-ME-Sender: <xms:TmE9ZGLwkdGLtxH4ZFjo9I5p680UswwxFEqPZ7x4-OunAk1K7mbs1A>
    <xme:TmE9ZOKBaTekLJ3CyxhRnu-K-RTOxONoklVo-nliRAhyICSp1hLxT9ljyD1gzerIM
    X22txL58gHwF2h0>
X-ME-Received: <xmr:TmE9ZGuxVRIt6ZdSqjTCZqdWApyNxldZrDOWHvD0NwQDqgSKA2YOQPvhqDbHEemjh8Wu9Ya7rxu81MVjYS5in2PO2k9S5GNahcnDFRI8gU-_Fu6OGu1S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:TmE9ZLYYamkBhbP7w1f8kzKEX7aK184NtbrPVHd0vxsFbKutVPun8g>
    <xmx:TmE9ZNbNawyxDDN3Sg5UzXQ6lYPmRMcCZtDGERHz8uUk685mHLmRlg>
    <xmx:TmE9ZHCEA_tdP-kTY0YJPr24mpnFVL8P0u2BBT4gEZIjuuPbL67GJQ>
    <xmx:TmE9ZMVU-DFkOqwQEnavFLhnQvmHz7kptwt4GhNKcWP_NM4g55xWpw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 11:10:05 -0400 (EDT)
Message-ID: <48eca641-e810-fac5-0ff0-8762eed3f61e@fastmail.fm>
Date:   Mon, 17 Apr 2023 17:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: sequential 1MB mmap read ends in 1 page sync read-ahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
References: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
 <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
 <ZDjRayNGU1zYn1pw@casper.infradead.org>
 <1e88b8ed-5f17-c42e-9646-6a97efd9f99c@fastmail.fm>
 <b8afbfba-a58d-807d-1bbc-3be4b5b08710@fastmail.fm>
 <c59e54f9-6eae-3c35-bce8-ac03af84b3ed@fastmail.fm>
 <ZDnNeKt1bPWb2PzC@casper.infradead.org>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ZDnNeKt1bPWb2PzC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/15/23 00:02, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 10:47:39PM +0200, Bernd Schubert wrote:
>>> Up to bs=512K it works fine, 1M (and for what it matters
>>> already 768K) introduce the order=0 issue.
>>
>> Hmm, I replaced memcpy with dumb version, that copies byte by byte - problem
>> gone. Is it possible that the optimized memcpy causes caused kind of random
>> memory access and confuses mm / readahead?
>> And somehow your memcpy or system is not doing that?
> 
> Oh, that would make sense!  If the memcpy() works high-to-low, then
> you'd see exactly the behaviour you're reporting.  Whereas low-to-high
> results in the behaviour I'm seeing.

In my case it is not exactly high-to-low, it is more low, high, then 
from high to low. Issue goes away with a sufficiently large RA size. And 
RA behaves better when POSIX_MADV_SEQUENTIAL is not done.
For sure memcpy implementation and cpu depending (I have tested on avx 
and avx2 systems).

> 
> Hm.  I don't know what to do about that.  Maybe a "sufficiently large"
> memcpy should call posix_madvise(src, n, POSIX_MADV_WILLNEED)


What would speak against ignoring POSIX_MADV_SEQUENTIAL for RA when it 
would detect that something breaks the contract?

But then I don't know how much mmap/memcpy is used for large memcpy or 
memcmp - maybe we should just document the issue right now in the mmap 
man page? Especially that POSIX_MADV_SEQUENTIAL should be avoided?



Thanks,
Bernd
