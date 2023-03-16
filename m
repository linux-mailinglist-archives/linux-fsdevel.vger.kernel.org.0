Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE06BD460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 16:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCPPwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCPPwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:52:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459461B5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 08:52:10 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230316154316euoutp01cbf41a78d23e9e73a637896347f65930~M8K9Q5ASp2420224202euoutp01f
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 15:43:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230316154316euoutp01cbf41a78d23e9e73a637896347f65930~M8K9Q5ASp2420224202euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678981396;
        bh=cBS2uM3tktUpBRksdEzPpOkuP+mSr6w8d/dIJk6Yu7c=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=lNaFaGZVis8GLStNf2RtJtFGmJ6jqoFY55pGlvyiz4cGJB+EjOqzMs2MQ84ogmo8R
         M6lTZciDXmAmtxcOF6zTK7K5v7HTyJIN4ynIdb8Ig7CqEdsuOuCJYfuLoGX9x7J8+f
         HZM3XLLLgupKw2WxAMTovHWwY3vZTuykVROEOQBU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230316154316eucas1p21cd038591cef74f6a9a568d49373c913~M8K9AM_ja0325503255eucas1p2E;
        Thu, 16 Mar 2023 15:43:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.55.09966.41933146; Thu, 16
        Mar 2023 15:43:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316154316eucas1p203d1cb0da33c72fa8972d10c04714826~M8K8lVKVd2685926859eucas1p2N;
        Thu, 16 Mar 2023 15:43:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316154316eusmtrp2443fd2834f946cf37fdb2f7a6e8ac9c9~M8K8klVu52087120871eusmtrp2s;
        Thu, 16 Mar 2023 15:43:16 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-ee-64133914c561
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.7F.08862.31933146; Thu, 16
        Mar 2023 15:43:16 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316154315eusmtip1e15dd51f2e90d87f819a7015dab01d92~M8K8YZ6V31613816138eusmtip1P;
        Thu, 16 Mar 2023 15:43:15 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.172) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Mar 2023 15:41:21 +0000
Message-ID: <b353939d-2971-8fa1-2d15-e035d2aa03ed@samsung.com>
Date:   Thu, 16 Mar 2023 16:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
To:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        <lsf-pc@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, Dave Chinner <david@fromorbit.com>,
        "Christoph Hellwig" <hch@lst.de>
Content-Language: en-US
In-Reply-To: <367c04f8-f5f6-a628-c4a9-7534fa83eb88@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87oilsIpBq/2K1psOXaP0WLl6qNM
        FpMOXWO02HtL22LP3pMsFvfW/Ge12Pd6L7PFjQlPGS1ae36yW/z+MYfNgcvj1CIJj80rtDw2
        repk89j0aRK7x+Qbyxk9dt9sYPNoOnOU2ePzJrkAjigum5TUnMyy1CJ9uwSujN3XNrAUTOKu
        uPGvqIHxOkcXIyeHhICJxNNdH1m7GLk4hARWMEqcu7cZyvnCKHFgZwMLSJWQwGdGiZ3Xw2E6
        eh4fhIovZ5RoOlkHVzNrVw1E825GieN/vjKDJHgF7CS27T/ODmKzCKhKHP11gwUiLihxcuYT
        IJuDQ1QgSuLF6zIQk01AS6KxE6xaWMBaYtOsPYwgYREBT4n/x1VBpjMLfGaSeDfrKBNIDbOA
        uMStJ/PBbE4Be4kd3x5AxTUlWrf/Zoew5SW2v53DDHG+ssSc1zug7FqJU1tuMYEMlRBYzSnx
        4ek/NoiEi8SGWcegbGGJV8e3sEPYMhL/d0IskxColnh64zczRHMLo0T/zvVsIJdKAF3ddyYH
        osZRYt/1PiaIMJ/EjbeCEPfwSUzaNp15AqPqLKSAmIXknVlIXpiF5IUFjCyrGMVTS4tz01OL
        jfJSy/WKE3OLS/PS9ZLzczcxApPW6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK84SwCKUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqYxK4aqZh0l8RKvXv/
        ofFpQsGko8Lan7bVC8+d1DH911HvhEVn8v9vWZCXxNVSkFc2USHtSPTBSst1HQZPpz17/VHj
        +LEZ25Z1cZoU3Sy8mpW15cxWMdMjaVtrDDukKl/y8s6+GXY2/ZjgqTDHrMqulq3sLXdCT4v1
        rv8TnaVqf0mcW3+jvYp45MtL9vP3MQduKmm9oTntyAazayWT/G5qL2JrTl5+YaruyQIV0x11
        cmU7RC56Bp1wMrxlGHrf90b2CY7Dsyutfl0J/VGjEqe8WKmS30/Laf45S6vgrz//fXzNucKl
        ckOF1K8X7F5P63IOi/1fr36wzcebZ6pJoLLI0YC/n+vdMwSmR97vS/FXYinOSDTUYi4qTgQA
        mOV1fckDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7oilsIpBu+nMFlsOXaP0WLl6qNM
        FpMOXWO02HtL22LP3pMsFvfW/Ge12Pd6L7PFjQlPGS1ae36yW/z+MYfNgcvj1CIJj80rtDw2
        repk89j0aRK7x+Qbyxk9dt9sYPNoOnOU2ePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
        PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN3XNrAUTOKuuPGvqIHxOkcXIyeHhICJRM/j
        gyxdjFwcQgJLGSW2NRxghEjISHy68pEdwhaW+HOtiw2i6COjxLMJ+1hBEkICuxklTp32A7F5
        Bewktu0/DtbAIqAqcfTXDRaIuKDEyZlPwGxRgSiJp3cOMXcxcnCwCWhJNHaClQsLWEtsmrWH
        ESQsIuAp8f+4KsgqZoHPTBJ9e6cyQ+y9wCwxuX0h2F5mAXGJW0/mM4HYnAL2Eju+PWCCiGtK
        tG7/zQ5hy0tsfzuHGeIBZYk5r3dA2bUSn/8+Y5zAKDoLyXmzkIydhWTULCSjFjCyrGIUSS0t
        zk3PLTbUK07MLS7NS9dLzs/dxAiM+G3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeMNZBFKEeFMS
        K6tSi/Lji0pzUosPMZoCw2gis5Rocj4w5eSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
        ZqemFqQWwfQxcXBKNTBpu2cmfo8Wm50Z+XT9iStMu2qrq8NV/XhfezJZ/1rortb4d128tXHY
        tt3uiw98qC5VCUr527p74eliAdvXdfwBf3QLw2/8nT9bO/iwx+yYZf6fko6++m0R+liTOzg1
        6sXWtXVL9p98EPVGVuZX40qBZ7c9KvJzcv1Nl7y/t8eN+e+0vWFWH/2+cM5ffUR06WXX266v
        Tk59e2h/eH+d34fmn//ChDIvffbP33OXPewaY4/YnsKNZwXe9cYvWl7S0pW78EnS3l6mPwrT
        On3aFGwuNAgH6KwRmMP+Ve7MLuZnQos/S11IVdjR/5Bhpv2UL6cPXSvy9bgRvZfrUMealAeH
        59+z4br7McDUcT/nD645SizFGYmGWsxFxYkAaQaBGYEDAAA=
X-CMS-MailID: 20230316154316eucas1p203d1cb0da33c72fa8972d10c04714826
X-Msg-Generator: CA
X-RootMTR: 20230303223216eucas1p2517850ab1c4f98dc4e09d83673525983
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230303223216eucas1p2517850ab1c4f98dc4e09d83673525983
References: <Y/7L74P6jSWwOvWt@mit.edu>
        <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
        <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
        <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
        <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
        <ZAJxX2u4CbgVpNNN@bombadil.infradead.org>
        <CGME20230303223216eucas1p2517850ab1c4f98dc4e09d83673525983@eucas1p2.samsung.com>
        <ZAJ1aLWsir73bA1p@kbusch-mbp.dhcp.thefacebook.com>
        <367c04f8-f5f6-a628-c4a9-7534fa83eb88@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-16 16:29, Pankaj Raghav wrote:
> Hi Keith,
> 
> On 2023-03-03 23:32, Keith Busch wrote:
>>> Yes, clearly it says *yet* so that begs the question what would be
>>> required?
>>
>> Oh, gotcha. I'll work on a list of places it currently crashes.
>>  
> I started looking into this to see why it crashes when we increase the LBA
> size of a block device greater than the page size. These are my primary
> findings:
> 
> - Block device aops (address_space_operations) are all based on buffer
> head, which limits us to work on only PAGE_SIZE chunks.
> 
> For a 8k LBA size, the stack trace you posted ultimately fails inside
> alloc_page_buffers as the size will be > PAGE_SIZE.
> 
> struct buffer_head *alloc_page_buffers(struct page *page, unsigned long
> size, bool retry)
> 
Aghh. Sorry for the ugly formatting:

struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
		bool retry)
{
	struct buffer_head *bh, *head;
	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
	long offset;
	struct mem_cgroup *memcg, *old_memcg;

	if (retry)
		gfp |= __GFP_NOFAIL;

	/* The page lock pins the memcg */
	memcg = page_memcg(page);
	old_memcg = set_active_memcg(memcg);

	head = NULL;
	offset = PAGE_SIZE;
	while ((offset -= size) >= 0) {
	// we will not go into this loop as offset will be negative
	...
	...
	}
...
return head; // we return NULL for LBA size > 4k
}
