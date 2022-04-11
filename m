Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3532A4FBCEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbiDKNWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346435AbiDKNW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:22:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254AC3B555
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 06:20:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E73835C01A9;
        Mon, 11 Apr 2022 09:20:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Apr 2022 09:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1649683207; x=
        1649769607; bh=Qcaue8cMMg5PtbNIB1AEaDX2BQHoo99wOpa/dWyMmuk=; b=V
        jx56gmn4tUzq5HZkMgEKlML/C9gLHscBCJSU+1hu/V1iFfyyeErCNclAgR6pOA2u
        OvZU6BlY54CsuboXRkogbJd2osy5uVv62CW5NiPNqquzloMvRJq7N3hlLg9t5rWg
        UI2ubsWSWrddUjn1FHm61cEvKyEAm5/vW8TmeJlwOu8P3xlD6hDylofE4e4bs2e9
        MhMRpYCNkRJ6s4Y4QJe8M5xcJl2zBCx2nkIvmXGUmPnaoHhTL03XUK8NNyK3B2y1
        MgHN55zB83/JdLkWxG5XYdiT5b3gidL3HaTBNiIwClLSY83G818ufKXAFx41A7UL
        q87kVYY9rANSQ+EEGh4+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1649683207; x=1649769607; bh=Qcaue8cMMg5Pt
        bNIB1AEaDX2BQHoo99wOpa/dWyMmuk=; b=B6I7QkhrRfYa9ZKlFF9UnVKDyR4ue
        3Q0OBmSxL6EVwwwCZ507Tb6t5RskqLUimEFOSOQjnrAcAkUCIfuthmZr0RCAApEK
        jPvjrk9j4eMUrT/GzGR1ph8Ura3KyPvd8mxatZPAADRpjmkgbfz1R8NUaXSydqJW
        Wo3Gj+WkqR2yZNzJb2IT6QkKfuAY9bequ/UeLrCG96naf8k6hBVcsTVmKRnFlBrD
        dloJZ50Rd/sipzaYMWpLvPC6P4l1mrHpGheMvfWLqfAoEezwTiavUZhLB0+XO1Dz
        mYgCVChEHNXTYzaIR2dHY9mdmSDv0B82V4DAPTHiXieXWe2cVzoEAdACQ==
X-ME-Sender: <xms:BytUYiLFWyyP0XqFfg7CzbMJSsuPdznaZgTrbYJO9L8McHfH0-HRVw>
    <xme:BytUYqKXfdVnLHQceLjJVhJ18P2G4AFY5W0yxMkvVIcGa9DgOaQ9axPGOG6fWgxuR
    ihXN8UbVFvKds42>
X-ME-Received: <xmr:BytUYit0bflxjNVZms1HdotzvN0QeFZ3rMdw1Y1edEmBuB0T_0wJ5H1XPLBWj1_CnvOLyohWXNoo6QvDisI4cItJeWH1Og5aIBFqUqeuTORRpHNLECpR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:BytUYnaEgDDFCQ16IYPQwwbtGiCTbDNLnmU2TIvlZT_Ni4RUEXA0ow>
    <xmx:BytUYpYuxsp3Ln-9PWSFqkMYp9pqbSKL7bh9IbvGtIJRaJWqbr2p5w>
    <xmx:BytUYjA2a-v-Rv6E1_1qtLjXXLhOS59PxAn3nfSarGa9gqqCf2rVbQ>
    <xmx:BytUYuO2rLl3awyKuBnc-uUb75-ifhxG9vqGXLQrWumpvZdt9gmjsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 09:20:06 -0400 (EDT)
Message-ID: <afc2f1ec-8aff-35fa-5fde-75852db7b4a8@fastmail.fm>
Date:   Mon, 11 Apr 2022 15:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
 <YlQWkGl1YQ+ioDas@redhat.com>
 <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/22 13:54, JeffleXu wrote:
> 
> 
> On 4/11/22 7:52 PM, Vivek Goyal wrote:
>> On Mon, Apr 11, 2022 at 10:10:23AM +0800, JeffleXu wrote:
>>>
>>>
>>> On 4/8/22 8:06 PM, Vivek Goyal wrote:
>>> Curiously, why minimum 1 range is not adequate? In which case minimum 2
>>> are required?
>>
>> Frankly speaking, right now I don't remember. I have vague memories
>> of concluding in the past that 1 range is not sufficient. But if you
>> like dive deeper, and try with one range and see if you can introduce
>> deadlock.
>>
> 
> Alright, thanks.
> 


Out of interest, how are you testing this at all? A patch from 
Dharmendra had been merged last week into libfuse to let it know about 
flags2, as we need that for our patches. But we didn't update the FLAGS 
yet to add in DAX on the libfuse side.

Is this used by virtio fs? Or is there another libfuse out there that 
should know about these flags (I think glusterfs has its own, but 
probably not using dax?).

Also, testing is always good, although I don't see how Jeffs patch would 
be able break anything here.



Thanks,
Bernd
