Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB82E9DFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbhADTLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:11:46 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53535 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbhADTLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:11:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D2925C0126;
        Mon,  4 Jan 2021 14:11:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Jan 2021 14:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pZXhUZxCSADzBVQ9ofdJtQeBBSe
        xqsAm8Eg19RhO6cI=; b=agiscWQ98ZDuMJN0olfAXH6/OU4LfJ24tbHICetHAC2
        nYx4EZXVTSQ2E2t2AxOYCUAkBuEEpwMjAZA1hG/JLI6E+4pQ7uVmymHY92jaVsXm
        0BqMIBILJiEYUwQ3m5KIqfb/3JXeVsI3d48/Ei7Y8Llv3uF/Xzd5EMO0ylY+F06X
        ccH453M0ISZImILbZHSCV99Wq7A4t+xjeiP85iwf9znW+2Mz/HkjoTN/shrv5ri+
        Ro8AnK+iya1ZTqgvaNdNZloEA+4yW+GbXvD5SicIkkopqUPATMIYsvAAsb5GDkt6
        SuMu/AnCirpfwdRjvfQ/jdhhnb0wzGwOKhibJHFrLuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pZXhUZ
        xCSADzBVQ9ofdJtQeBBSexqsAm8Eg19RhO6cI=; b=NOehI7clTvaRQUcobnnJuU
        JIS01ZYV2qpr7LkfSG0pgRuWTaf8ZEjoxY/+Nu3NIoRenwkkED6AG3wbVIA3h6C8
        6EzHv4XRdHYSZy7RThzuM9gT8u83QBXMxXZ/2sd1MFUUNa+qqFeOP3CmgYov/n4i
        o5lW4eof7DB/4HQOomUFQ1R8Qo3pYe2wtrcIKYD2EWrxPjjGVuzyj1djpCXfAPCl
        qJ2qtHJwwkS55pzufZlDK+yXGHiFEIFCHvxwxJ07pWMil+2ITgXQUappRtFxYJaV
        xI6dSLoijMfXJ+5S6aWRzguUZo5kQnkkG4+KvRvgqcYBoQ9g/x3yQcfgdAKgtoUg
        ==
X-ME-Sender: <xms:Q2jzX7TMbCsmPAy47o265epCU8kG7dHJS3XwH6LgM1lAmO49GdjBxQ>
    <xme:Q2jzX8thonNni7mhli0HvCFfNERxeRJtf4DCD455qtsjxCLsE61abAxX_UdIF3eVg
    q0m4fto2xipiB9dJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeffedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepudekhfekleeugeevteehleffffejgeelueduleeffeeutdelffeujeff
    hfeuffdunecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:Q2jzX9v6SPLtIj6qaGqMkCDKAJRcmCnLoBQp20AWgDVqfhNj-m2SJA>
    <xmx:Q2jzXyx-AqhbjXoWiiNFevYXyoIHW7Ja31-VA4PMHqfjhHY-5oCYOg>
    <xmx:Q2jzXzhK-k3azrJOxdWkLG_2yDqVOU_vkss3UYwhfHEevAnb_McXSQ>
    <xmx:RGjzXzdT8WAgLl3Q6NeiyOO0YiW_qQhlQkwGVCuLRZnhW6E6KadpMQ>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7CF531080064;
        Mon,  4 Jan 2021 14:10:59 -0500 (EST)
Date:   Mon, 4 Jan 2021 11:10:58 -0800
From:   Andres Freund <andres@anarazel.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104181958.GE6908@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-01-04 10:19:58 -0800, Darrick J. Wong wrote:
> On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> > Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> > doesn't convert extents into unwritten extents, but instead uses
> > blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> > myself, but ...
> > 
> > Doing so as a variant of FALLOC_FL_ZERO_RANGE seems to make the most
> > sense, as that'd work reasonably efficiently to initialize newly
> > allocated space as well as for zeroing out previously used file space.
> > 
> > 
> > As blkdev_issue_zeroout() already has a fallback path it seems this
> > should be doable without too much concern for which devices have write
> > zeroes, and which do not?
> 
> Question: do you want the kernel to write zeroes even for devices that
> don't support accelerated zeroing?

I don't have a strong opinion on it. A complex userland application can
do a bit better job managing queue depth etc, but otherwise I suspect
doing the IO from kernel will win by a small bit. And the queue-depth
issue presumably would be relevant for write-zeroes as well, making me
lean towards just using the fallback.


> Since I assume that if the fallocate fails you'll fall back to writing
> zeroes from userspace anyway...

And there's non-linux platforms as well, at least that's the rumor I hear.


> Second question: Would it help to have a FALLOC_FL_DRY_RUN flag that
> could be used to probe if a file supports fallocate without actually
> changing anything?  I'm (separately) pursuing a fix for the loop device
> not being able to figure out if a file actually supports a particular
> fallocate mode.

Hm. I can see some potential uses of such a flag, but I haven't really
wished for it so far.

Greetings,

Andres Freund
