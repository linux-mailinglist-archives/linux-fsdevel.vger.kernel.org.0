Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2C4565CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKRWqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 17:46:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44469 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231895AbhKRWqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:46:21 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AE215C0180;
        Thu, 18 Nov 2021 17:43:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Nov 2021 17:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=S
        tnAUU2rS0wOiiGoGNQvkB/qSE+M3ANc+klXRENT9UU=; b=o607mGdGxGF+cr8sE
        7+JaN5OC3/mbyOzvZAlhmONCQI97qNQsyMgvkzqWaYChxFnmTbFlw+4nUh7VxWt5
        v5X4LE8/I9OuzeOxymSNva8DqZ3yP+FlIuuPuSoSxvJ4rEI69Be5BP3uHfE/ArPW
        e4e7/Z9qPenT+aBb+xn7CT7bnBA825SoZmcp/XEIQ+XfXpZ2mx72gNZ26sIHSKC6
        BaVxXrLrKV7WqStiIOcILIHBjlCvwVShNh5OucRjkE40uUwbF7NBHUXfN5h2b/zK
        LyBi++Ol+xMs+jHiymMCcaFNsTnPzojUMPvJdoMcmhI/I9a8tq4gVwvjjRKukrQx
        Dzo1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=StnAUU2rS0wOiiGoGNQvkB/qSE+M3ANc+klXRENT9
        UU=; b=Nxl7RHqnCiC3Oqw1/AFZTTXW1LfZhdk3PuF+apmgE9RyP0+q65wXr+mOe
        aIR66lT8D7ZtDFeMUGx1OwZxTfMrDnGk3WxnpMAeZE3EBW8yH0J2qjMgJGry78g+
        Jua8TV94DuBRwixs3DcbntXNBFmFTFU551XVrkW9/6DH8NyU08cRfEdQ59CMpfHK
        H7o+0YyH7OIFoVVAS07jbAwFPbgbmAgzZYB5CoVHIjISLE+1oKJSWE0lFgUOLAIh
        yXPW7Ki1OPOxT3IJq71mAR7Wkr27bkWgXEZuOOyocWSihMhcSAjKytevAk2jUUDk
        PB+xBWIehNdC/aMWrtM+qY6oA2qMw==
X-ME-Sender: <xms:CNeWYUCn-4iUWriMIsNFjBvjX5G-zi8MdYFmEu_3Ge-NLsHCkjsSkA>
    <xme:CNeWYWjSX2I6hX5rHknWXL9KJBWPta78HLq21bAfqAqUx2EmYb4ZfPf4yxKuGgp3f
    fC862roC3PMZE6yTA>
X-ME-Received: <xmr:CNeWYXleFhnpJJUqfI5s17V6OkixBUU0ZpkbVaPAuyrTDQdnlasiJFEeyHUSi1i8akXLSPBI7x14hQI6fl7v7_nYXj9lIt6f49_lVGqVFvllSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeejtdevudetvdevffekhedvjeffudeggeej
    ueeludehuefggeffieeftdejtdfhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:CNeWYaxb1hGHZ8rprE_s0-QwvSVkU7oPA3xcJfNttNR0qGTsEPbfTw>
    <xmx:CNeWYZRUdRXE1EgmOqIl9QKGMBHv-mpsZVvAYMFN7bn5dMPVVpNdbQ>
    <xmx:CNeWYVaXSF7OCp36Cws69TuEDAp2LBDgi7AYCF9U_vgNFofeBSFc-A>
    <xmx:CNeWYbdRcGwtHFCecqpwmuLWkreJm0qKyNrLCIg75-jR0OHJ2YstcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 17:43:19 -0500 (EST)
Subject: Re: [PATCH 1/1] exfat: fix i_blocks for files truncated over 4 GiB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
References: <20211118212828.4360-1-cvubrugier@fastmail.fm>
 <20211118212828.4360-2-cvubrugier@fastmail.fm>
 <YZbKobiUUt6eG6zQ@casper.infradead.org>
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Message-ID: <8bd90de5-0b1e-f9f3-38b3-038d73adf3d7@fastmail.fm>
Date:   Thu, 18 Nov 2021 23:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZbKobiUUt6eG6zQ@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Le 18/11/2021 à 22:50, Matthew Wilcox a écrit :
> On Thu, Nov 18, 2021 at 10:28:28PM +0100, Christophe Vu-Brugier wrote:
>>   	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
>> -			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
>> +		~((loff_t)sbi->cluster_size - 1)) >> inode->i_blkbits;
> 
> Isn't this a convoluted way to write:
> 
> 	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >>
> 				inode->i_blkbits;
> ?

Yes, it is. And we have evidence that it is more error prone.

I will update my patch with what you suggest.

Thanks!

-- 
Christophe Vu-Brugier
