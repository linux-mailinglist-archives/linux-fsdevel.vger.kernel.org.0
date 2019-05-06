Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318E61535B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEFSEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 14:04:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35759 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfEFSEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 14:04:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D0F8F220CB;
        Mon,  6 May 2019 14:03:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 May 2019 14:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Me+YpgbdIGiVitedxC/gQk/BMWh
        0B+lfqVT9kHkmymg=; b=S2cZbbc+k5PJneo7CgUYQnRpZwV2HWbDO82XDu6qLJe
        IetmxVB6rFhMitKcMAmwtTTs7csejMkW5Hf7z0RFXcgCIvm9saLJcV2lqd1Tr1B9
        DoBp7cCSqpj3PwoEiAnYN/wXTmfDq62bT7sNU4q4aU/cTwAksrulfzp918noYXYI
        2J3bUrqnXj5oJnzZgPnFiWIEYo3Pco4VtZMFbfYQA80jrIdoCuxkNKwxDQHSOMYS
        xSm2IOLgkKSZ3nR0VWUVd9u8jXY+xT7Z+PAt9Q+Dp4fKT17V7LWIdK6SCQrePl95
        cZWHKC9XdCBzKSJJYDaVegnD7oBVDzRjqm9EzAQyWRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Me+Ypg
        bdIGiVitedxC/gQk/BMWh0B+lfqVT9kHkmymg=; b=uSkP0Ok5Pw4EhpjAShDCXe
        AZn8QME969+91uPXVVYk9UqiN6aFAwHFqGVuAJa7rHXRq9LSp8ksbcXJVvNrqt2K
        JKnrcX+PREsCZaKEdroAryeAq/TrtVgmJKOTdpgcL2za0RnI5cDsu+1h4uHvMbWd
        MSlew1/Mr/cj0RVElcqVSk7JvZQ/PqLHgMTL1gH+QVtl+GRpjivDlYAoBoOvvcdD
        WAqIDQtF/y9dAowgc9ZdZRyqfqJJYrmwrIchkNR8YO79zxiODSlGsWfyPtSkQoPv
        Eeu6UTm7iJAUClNfXWYdoc6epOrhhoP2xcQDT81X5sktZl6RcAIpisVP9BXjBj5w
        ==
X-ME-Sender: <xms:DHfQXK8lDUUY2TAVCfvjyXIsDly3DnQucge-AUUWv1cqudrmJe5sxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjeekgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppeelke
    drvddutddrudegtddrudejudenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghs
    segrnhgrrhgriigvlhdruggvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DHfQXIYlJF_dYg7jf1jAUA1h_4aErnd8GS1UOt4CalEex3k6qEx7Ug>
    <xmx:DHfQXIFFMTYj-gH4w3CyDVfmA710pgAXNF3gLd28m2SIEnbiSOWEKQ>
    <xmx:DHfQXK1gyYOTvD8PGfInpIGQXFwUaem4SSETST0xYgqu3X_rCS6PQw>
    <xmx:DHfQXF4TdfdBIOFcRpwmhBRN5CvgEMs5ObO_BPM1VByScYlL480Qrg>
Received: from intern.anarazel.de (c-98-210-140-171.hsd1.ca.comcast.net [98.210.140.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6C47E448F;
        Mon,  6 May 2019 14:03:55 -0400 (EDT)
Date:   Mon, 6 May 2019 11:03:54 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, clm@fb.com
Subject: Re: [PATCH 1/3] io_uring: add support for marking commands as
 draining
Message-ID: <20190506180354.maksphiaokual4jd@alap3.anarazel.de>
References: <20190411150657.18480-1-axboe@kernel.dk>
 <20190411150657.18480-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411150657.18480-2-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2019-04-11 09:06:55 -0600, Jens Axboe wrote:
> There are no ordering constraints between the submission and completion
> side of io_uring. But sometimes that would be useful to have. One common
> example is doing an fsync, for instance, and have it ordered with
> previous writes. Without support for that, the application must do this
> tracking itself.

The facility seems useful for at least this postgres developer playing
with optionally using io_uring in parts of postgres. As you say, I'd
otherwise need to manually implement drains in userland.


> This adds a general SQE flag, IOSQE_IO_DRAIN. If a command is marked
> with this flag, then it will not be issued before previous commands have
> completed, and subsequent commands submitted after the drain will not be
> issued before the drain is started.. If there are no pending commands,
> setting this flag will not change the behavior of the issue of the
> command.

I think it'd be good if there were some documentation about how io_uring
interacts with writes done via a different io_uring queue, or
traditional write(2) et al.  And whether IOSQE_IO_DRAIN drain influences
that.

In none of the docs I read it's documented if an io_uring fsync
guarantees that a write(2) that finished before an IORING_OP_FSYNC op is
submitted is durable? Given the current implementation that clearly
seems to be the case, but it's not great to rely on the current
implementation as a user of data integrity operations.

Similarly, it'd be good if there were docs about how traditional
read/write/fsync and multiple io_uring queues interact in the face of
concurrent operations. For plain read/write we have posix providing some
baseline guarantees, but obviously doesn't mean anything for io_uring.

I suspect that most people's intuition will be "it's obvious", but also
that such intuitions are likely to differ between people.

Greetings,

Andres Freund
