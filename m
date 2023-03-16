Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2E6BD40E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCPPkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCPPjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:39:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C07D7C3F
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 08:38:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316153017euoutp024b24064a827853032d77330a095f93c1~M7-nA5duF1570815708euoutp02l
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 15:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316153017euoutp024b24064a827853032d77330a095f93c1~M7-nA5duF1570815708euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678980617;
        bh=dw6ZM8dVL/gkZJVPvpAuxqdfmjR01x+CAelnHMcCROY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=VMat0wlgvbVPtM46pax/06d6MC/I6P0R9qAbbaCazV/cUWpT8go7K1hVGE98p/b0p
         FJjZHM3LqZZPv+l6qTMkIcgCcVloY/S/1IGYNcd+QGxTmuEM2TSofoFuo1dPmT5dfk
         WGn8a76STu1JimcU5w98ho5k1b21H4qKrebfphcA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230316153016eucas1p1061bfe038e8dfcb4a43ab5bd7e65ef3d~M7-mt0_oK2016020160eucas1p1Y;
        Thu, 16 Mar 2023 15:30:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.D2.09503.80633146; Thu, 16
        Mar 2023 15:30:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230316153016eucas1p14c300fe22d12c46881b889a7a4786cad~M7-mMfLhD1723017230eucas1p1W;
        Thu, 16 Mar 2023 15:30:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316153016eusmtrp262884fa26715c616db40201755be7daf~M7-mL4aBv1290912909eusmtrp2q;
        Thu, 16 Mar 2023 15:30:16 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-95-641336088113
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.BD.08862.80633146; Thu, 16
        Mar 2023 15:30:16 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316153015eusmtip19802e01efff92dc1fbb3b14a98748063~M7-mBRrTc0360603606eusmtip1h;
        Thu, 16 Mar 2023 15:30:15 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.172) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Mar 2023 15:29:57 +0000
Message-ID: <367c04f8-f5f6-a628-c4a9-7534fa83eb88@samsung.com>
Date:   Thu, 16 Mar 2023 16:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
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
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZAJ1aLWsir73bA1p@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1d+92d11oN7X2pZKlaTVpaQ+70cOkkCUWZVRkQa28mKhTdp3a
        C7QXuULnLMqb+ax8VdaSstSK1ZSZaQXpkrKnmK0Hapmy0rxeA/873znn+3HOx4/EXWrE7mSM
        OonRqFVx3oRUdLthqHU+GeQaFVDV5EtXN3QiurzSjNEGUxui6zv86bp6i4juvDoipu/b6nHa
        qu9C9PHTQxLaPphHrJYqm4pBeatMrjRWZBBKY59BosyxliJl7as0Qnmk2Ywr+40zNpKR0hVR
        TFxMMqNZsGq3dJ+l/Yok0TopNXO4jUhDH0gdciSBWgwnDZcxHZKSLlQZgmzD8PjwE0FWWh0u
        DP0ICm6cl/xfaW/uEQtCKYKBjmyMF8ZcbypSBaEWgfXIMTEvOFGr4ELtTZzHIsoX9LoaXOCn
        gCX3k0iHSHIqFQmfbck87UotByNXh3iMUzLo+FSA8RY3ah2MNPryz+NUPwbfOfMYT1BySM+Q
        8NCRCobuHJmwOQ+O37FLBOwFd77l4UJ8H8iz1Yzjw9BU3TFWGKhSR8h+MEAIwlqoPPseE7Ar
        fGmsHu/uCSN3C8b5g9BltePC8rHRa92tIvgQMJo/szlO8ITA/fZMTKCdwfptipDHGQy3z+F6
        5MtNuAM3oTA3oQI3oUIhElUgGaNl46MZNlDNpChYVTyrVUcr9ibEG9Ho53oy3NhXgy5+6VWY
        EEYiEwIS93Zz2iaiolycolT7DzCahF0abRzDmpAHKfKWOfmvtOx1oaJVSUwswyQymv8qRjq6
        p2Ezg9dw2pJQbUpL77XFR12XQO5WImvHC5vuj59kzqlQhQeXv0D6zuf6xpYe+6liu4MhaPKi
        wl2pD/4+fHxmFm0yz2EnbfhTvkhfMjtzelKJoii9Z4anXyz9dbk+dunQmpSXHq+fwll/qXxa
        GNWZTwQ8kngdOrGFzSrEZANv65xbxW4Lz9GDQT93dn+PSIjxDIxM100OCP4Y5hcy6yBxozfP
        nDQ3N6K1T128aXubLXzZ1fVdtoxL63+0zGazxU/OR6zeEe7s8EybNdjd4J68sGxmYaPtoT9j
        eUeGYIe3RH/9de9WaEb4oXmfV1YFJD5/Jd+sOaoq4nbHeHi19qh+OzCpe0hvEbtPFSjHNazq
        H+mAVbXLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7ocZsIpBhc+sFlsOXaP0WLl6qNM
        FpMOXWO02HtL22LP3pMsFvfW/Ge12Pd6L7PFjQlPGS1ae36yW/z+MYfNgcvj1CIJj80rtDw2
        repk89j0aRK7x+Qbyxk9dt9sYPNoOnOU2ePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
        PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jJPXl7EX3OCu6Pt3ja2B8RFHFyMnh4SAicT1
        My9Zuxi5OIQEljJK7Nn5hRkiISPx6cpHdghbWOLPtS42iKKPjBK3ms8xQTi7GSU2POhnBKni
        FbCTmL17I1g3i4CqxISuHcwQcUGJkzOfsIDYogJREk/vHAKLCwtYS2yatQesl1lAXOLWk/lA
        Qzk4RAQ8Jf4fVwWZzyzwmUmib+9UZohls5kl7l06yQJSxCagJdHYyQ5icgrYSzyfLA4xRlOi
        dftvdghbXmL72zlQzyhLzHm9A8qulfj89xnjBEbRWUium4XkillIRs1CMmoBI8sqRpHU0uLc
        9NxiQ73ixNzi0rx0veT83E2MwJjfduzn5h2M81591DvEyMTBeIhRgoNZSYQ3nEUgRYg3JbGy
        KrUoP76oNCe1+BCjKTCIJjJLiSbnA5NOXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2
        ampBahFMHxMHp1QDE0sqB+/R5sCWnwGfgu20Mi+6XbbjtV7mti+/prHzLGOo2pQfb1dunfrM
        XMt0nnRi66Y7opn/yhfuNUlcV1FcaP719M4lc35k2j64+eHYxuzNmo6F6be7vE5FR4Sqp6+o
        5FiauINbXsCOc3L6srsuLX+Fom1mnd9xxH3DcyXeT5O1tXNmC2x+Wn1+8+Oj55j2n/i+m+/C
        1mWn2jyyrmXpO2imL4t9L8j5u/EFC5fYKt+53rZ/713669EgZbqwjOfNz7TmbU4RTIk2szZG
        zm63e8oTmHM3iC164kKT8nOrRQwzLOIP7fSfO19v7pbUluY9wQ1msaHPkqfUquob5Ntc31Le
        sdVgktmpRad2T44RUGIpzkg01GIuKk4EAAl4REqCAwAA
X-CMS-MailID: 20230316153016eucas1p14c300fe22d12c46881b889a7a4786cad
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Keith,

On 2023-03-03 23:32, Keith Busch wrote:
>> Yes, clearly it says *yet* so that begs the question what would be
>> required?
> 
> Oh, gotcha. I'll work on a list of places it currently crashes.
>  
I started looking into this to see why it crashes when we increase the LBA
size of a block device greater than the page size. These are my primary
findings:

- Block device aops (address_space_operations) are all based on buffer
head, which limits us to work on only PAGE_SIZE chunks.

For a 8k LBA size, the stack trace you posted ultimately fails inside
alloc_page_buffers as the size will be > PAGE_SIZE.

struct buffer_head *alloc_page_buffers(struct page *page, unsigned long
size, bool retry)



{



        struct buffer_head *bh, *head;



....







        head = NULL;



        offset = PAGE_SIZE;



        while ((offset -= size) >= 0) {
	// we will not go into this loop as offset will be negative
...
...
	}
	return head;
}

- As Dave chinner pointed out later in the thread, we allocate pages in the
page cache with order 0, instead of BS of the device or the filesystem.
Letting filemap_get_folio(FGP_CREAT) allocate folios in LBA size for a
block device should solve that problem, I guess.

Is it a crazy idea to convert block device aops (block/fops.c) to use iomap
which supports higher order folios instead of mpage and other functions
that use buffer head?

Let me know your thoughts.
--
Pankaj
