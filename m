Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0179255F2CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiF2Bdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiF2Bdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:33:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A352201AB;
        Tue, 28 Jun 2022 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656466408;
        bh=pqxwvO1CJPahX0Vb7Uruphb3bKG+1p11HHH06KyuhDg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=eoiwbJpt9hnO0/8cLaxhg1Gjs1b5lcZNs/jfbAsd67yz9OsDfGFZvTCA5cNLR+jcw
         Bysl20MA42mHsKDS+NO01/GW5r+VzqH0hfijzd/tjYJU3Xp76Loq8pfs2+27M7BqBj
         YDk1EpAhHftaGzrKRAlMZeqPd/lm+LNgbmKqEidU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1nfrR20BFI-00zrch; Wed, 29
 Jun 2022 03:33:28 +0200
Message-ID: <77cb547c-a4d8-cca9-3889-872ebfed2859@gmx.com>
Date:   Wed, 29 Jun 2022 09:33:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de>
 <20220627101914.gpoz7f6riezkolad@quack3.lan>
 <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
 <20220628080035.qlbdib7zh3zd2zfq@quack3>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
In-Reply-To: <20220628080035.qlbdib7zh3zd2zfq@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxU8fmzPSOWo3S5klMCQWSzucckjFzmRRBgFQIBdlJy82yvmg+4
 Uk5NODhtl5p9QwM3ja0xSnfu0I9i7UP7MrmCeIhScsRbFwf1IvGVL5cFum/rLwvZ+GUGk42
 9ghHw55RPYGXu/HYjIKU9MH5bXnHcpGpaRNtq2eUy/cTE3o84nR+/0N+VVH6mEQ8NgM71LS
 JYR/xMnNYguQMXeC28ajA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ygxSUem6qzI=:G34aUae/gTEEUg0+3uQWaH
 cBcsvgnnkpb9SDbpxLO2Ilkh2QdjWxm8XtQWleCQxZHfPxR5TegwWDPEqn3v+wcXhryz8H4/y
 29EH/hpPH0eiApUIxM27VXbSnkZsOEFzc8KYK26+HVrpih9puDsCXeJW6eDbzo3eFTTqKo2yC
 bes5wTqJSV9DjDfV5NIJ0xslhlty83tgMkk3KJluz7xQH7IZwdd6o8JA6Zim7aWTn4et50pKm
 F2j16Jy50WtRVzakko1DGckpuSNNm0QPze4YDvo+9mc2l+WlNmSoWEE8Y4h/WFJquPXBLEU/a
 NYR190wYIHCrzrYf5SjKnJMkdvIqGOHzg1Q1MWFFXTfrWZbaS486IV2EkA2EDRIF2YfVAmb2h
 0nH4jbZQFCIX4Q0UT6VbTQ4EPla+eNnsmr2o7t4IywU1LF9MhQBM8IIqXtiR7ComhLuPdTqdP
 TNtmMoX4hClhkQvk2urM8foNbSJWYmy6+cJKjix271UFymCueTBJ9WLQcsppOLhbY0Xmxf6kf
 Qs3CFjjJFSpf8Qxs1DVArXEJ1OnpZcSFZW/vF6Ww5K1XiAEWQ/7Zi6M18R3V5Q1IddRiZs4AZ
 J9xyWLfevCCk4BCFCa59Zd29KzbRBBVWAyvRPjqY1AkLlD4+idQaeZtPGxS6+l1M76wJ0HHFJ
 zcimfLGkzxgD3/vABKD1fKuhjF/pm10HXQk+iHtSxybIKdoB8HFoA81nf5+s5NdcUuEnsec/a
 A6vzcgM1osJgApehrlBD40SSUhnqnIttvb5x6PwLdTsUj91AM67Iwz2DlvvtjpVRCwjvU+o6D
 pj6dShQNa1GSfppT1XoBF6ogS/a+MluFdUp+1s2kb+b+w4CbfDb3s2+dNxQ9a/pGuoph1WSYd
 SBHVPzFY5hQK3gKftuPJt8obM42P6WbIVZJPYptXPivT1+hygsXCOAnmQd+zigSORARIWVAL1
 /PApt0tXaXcfYm7jHWbuC4m7MtMpdD4oBZMyr/oeUyQBUBevR0XNEQXQ1xIvw8EQLox4DD3gy
 dFJs6RVtCIkDTQvRh+MeWspqZLpn6hYMVQtFFNSapW82P8I1ojYRETunCEnybQhSBNFex7Qkw
 g6frbE9WDDkxCAbjABcGr2UdjLmEMbEoxyEcfD4VyU0qaVkWRCgNJDzBA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/28 16:00, Jan Kara wrote:
> On Tue 28-06-22 08:24:07, Qu Wenruo wrote:
>> On 2022/6/27 18:19, Jan Kara wrote:
>>> On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
>>>> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
>>>>> I'm not sure I get the context 100% right but pages getting randomly=
 dirty
>>>>> behind filesystem's back can still happen - most commonly with RDMA =
and
>>>>> similar stuff which calls set_page_dirty() on pages it has got from
>>>>> pin_user_pages() once the transfer is done. page_maybe_dma_pinned() =
should
>>>>> be usable within filesystems to detect such cases and protect the
>>>>> filesystem but so far neither me nor John Hubbart has got to impleme=
nt this
>>>>> in the generic writeback infrastructure + some filesystem as a sampl=
e case
>>>>> others could copy...
>>>>
>>>> Well, so far the strategy elsewhere seems to be to just ignore pages
>>>> only dirtied through get_user_pages.  E.g. iomap skips over pages
>>>> reported as holes, and ext4_writepage complains about pages without
>>>> buffers and then clears the dirty bit and continues.
>>>>
>>>> I'm kinda surprised that btrfs wants to treat this so special
>>>> especially as more of the btrfs page and sub-page status will be out
>>>> of date as well.
>>>
>>> I agree btrfs probably needs a different solution than what it is curr=
ently
>>> doing if they want to get things right. I just wanted to make it clear=
 that
>>> the code you are ripping out may be a wrong solution but to a real pro=
blem.
>>
>> IHMO I believe btrfs should also ignore such dirty but not managed by f=
s
>> pages.
>>
>> But I still have a small concern here.
>>
>> Is it ensured that, after RDMA dirtying the pages, would we finally got
>> a proper notification to fs that those pages are marked written?
>
> So there is ->page_mkwrite() notification happening when RDMA code calls
> pin_user_pages() when preparing buffers.

I'm wondering why page_mkwrite() is only called when preparing the buffer?

Wouldn't it make more sense to call page_mkwrite() when the buffered is
released from RDMA?

Sorry for all these dumb questions, as the core-api/pin_user_pages.rst
still doesn't explain thing to my dumb brain...



Another thing is, RDMA doesn't really need to respect things like page
locked/writeback, right?
As to RDMA calls, all pages should be pinned and seemingly exclusive to
them.

And in that case, I think btrfs should ignore writing back those pages,
other than doing fixing ups.

As the btrfs csum requires everyone modifying the page to wait for
writeback, or the written data will be out-of-sync with the calculated
csum and cause future -EIO when reading it from disk.


> The trouble is that although later
> page_mkclean() makes page not writeable from page tables, it may be stil=
l
> written by RDMA code (even hours after ->page_mkwrite() notification, RD=
MA
> buffers are really long-lived) and that's what eventually confuses the
> filesystem.  Otherwise set_page_dirty() is the notification that page
> contents was changed and needs writing out...

Another thing I still didn't get is, is there any explicit
mkwrite()/set_page_dirty() calls when those page are unpinned.

If no such explicit calls, these dirty pages caused by RDMA would always
be ignored by fses (except btrfs), and would never got proper written back=
.

Thanks,
Qu

>
> 								Honza
