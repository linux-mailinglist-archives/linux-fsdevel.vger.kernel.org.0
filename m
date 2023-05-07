Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E86F9CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 01:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjEGXni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 19:43:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E16A27E
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 16:43:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 18AF65C00F2;
        Sun,  7 May 2023 19:43:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 07 May 2023 19:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683503014; x=
        1683589414; bh=yctmE8aUSTY+g23EgQJS8xjH/ck8B5Sj3NMYvHiDIuk=; b=g
        wp7bxJpJUFlHK6PNd/gogp9R/w4fQ2tIb7HpvAdc4I6X6kO6m/iRefkjlxLSKSS0
        slzkGPiBF05ai5i47ZWgxig8phfCf163zkwNn0fSajdtgvqiNFHymUfCr4155cUS
        /5u/3x56XxOkXORUMiesLN5EMftNP/DPJG26UtBPO/vbLS7BVNNKzwr/qHYvUAXf
        C4xQdGsWHyLgMM9bNk2Rj6t0vjkBS/CSVz3PLBbhuJJcBSoB1kOZRu+ug1cvDP7d
        sgrw0OZNWz8tg+UIM1NQatHk6+QyIzwSUEzcdqOLL7UIMaYSf8f25OjL0cV/S1Cg
        K9sgIoHC0S71lqUjAEd7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683503014; x=1683589414; bh=yctmE8aUSTY+g
        23EgQJS8xjH/ck8B5Sj3NMYvHiDIuk=; b=D8yYhxQWoO+YkMCDQOADXbOkuQ/7q
        WH7sP4gCM7NuTE4hpIet9nnpNbBC7lE3CTCBdRi6zw0h8rAnF6t9fehuu4WMfTbg
        UtxD0cttKeyFFwE74rEbG3uj0Xhln96OM3k41LaRToZR8szx6GQCEGc5wOZ3+u9C
        GY9cPbyQw1UTzbPY0aUwsWt3HZH3x/yLejWXcGhnoEBgD4arwSKqFCAPXwGKLPB4
        4xHuoeerKvyNIazUvsdR80l5J2EWvFA/Awtqr4+rfWR42SfJYxgd/jeP3VL2zJNP
        aa7Zr0a8zuSmSvuDDI8dNtJeKLtj+5feDe2tEu/n8uBbKj+37BFwsz3YQ==
X-ME-Sender: <xms:pTdYZIzxFWeAqsMCGxrrToSXscPO3dGy7vJipLaAHW9YBUfVmiB6OA>
    <xme:pTdYZMS8Yfh8ftm6MVs4IVWh561jBT1sECeYiDWaIBJ68T4ARemNVDSQaupUwNWBq
    mNSKIeRw4HshnmqNOE>
X-ME-Received: <xmr:pTdYZKXPRYXUxf5t15Lf0GFLxc0K_O66Jr-plITUgwFSxlQEwCP4Ldd7hf53cIwA3KrJBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:pTdYZGgTRz6adaWDAZ_roPXDho7hBzriap4TuePBEg1u-yfLQDepUA>
    <xmx:pTdYZKB31q8cb60IuRZSCFiJbFv0yc2yPXTmrmOzCURp-F1Va81LNg>
    <xmx:pTdYZHJLMRar52cMA6oKtlHvfdbdgCF8CHdvFyDbm6JLYyUx4EAP2A>
    <xmx:pjdYZNPY3EX0kd1Uf_ovuVjM1iRLPmQaDpCxJJELBL-Y6OHo407hlg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 May 2023 19:43:33 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 56ADB10D349; Mon,  8 May 2023 02:43:30 +0300 (+03)
Date:   Mon, 8 May 2023 02:43:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF] Whither Highmem?
Message-ID: <20230507234330.cnzbumof2hdl4ci6@box.shutemov.name>
References: <ZFgySub+z210Rvsk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFgySub+z210Rvsk@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 12:20:42AM +0100, Matthew Wilcox wrote:
> 
> I see there's a couple of spots on the schedule open, so here's something
> fun we could talk about.
> 
> Highmem was originally introduced to support PAE36 (up to 64GB) on x86
> in the late 90s.  It's since been used to support a similar extension
> on ARM (maybe other 32-bit architectures?)
> 
> Things have changed a bit since then.  There aren't a lot of systems
> left which have more than 4GB of memory _and_ are incapable of running a
> 64-bit kernel.

Actual limit is lower. With 3G/1G userspace/kernel split you will have
somewhere about 700Mb of virtual address space for direct mapping.

But, I would like to get rid of highmem too. Not sure how realistic it is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
