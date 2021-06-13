Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D43A55F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 03:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhFMBTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Jun 2021 21:19:06 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:59401 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231556AbhFMBTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Jun 2021 21:19:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 974AD1101;
        Sat, 12 Jun 2021 21:17:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 12 Jun 2021 21:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        u8ezqT9fELbYDkaX+8jugkAQZTvKn4A3ePYthWdpp7k=; b=Sel2NbHZXd2ZEAdO
        SJLDzXakWa+Hwc4SH5yXQBw7ddVkD48/bbcktvkNXwewpqVwZX3IY5VrEwymu7RQ
        FUS4SSogNZHPQcgO02JT+RCgEcGH7r4I4MxGCt0nd2HjR6q5XNMe4p5u3zjqkF6i
        4bZK1dVBDB3kJJ+1dmQUMl9bBemegn80iI29lHSkXmC+BHv2LLNlrFWI/tm9YITy
        rFOjGuXSLSFuSJFRlLBqtCeTpyWXCxShbe0OqgU9qCR/zV+TCFVrdBEi0sCQDLBR
        V4spIBgmknuk+WIDrHfyqxf2gh1HC7tR9aWxlxkTbFJQVpa2oQv98Ah1uKnbvddC
        grIWzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=u8ezqT9fELbYDkaX+8jugkAQZTvKn4A3ePYthWdpp
        7k=; b=hmS+lA3GqdvkwgmYKyrRlYZRLbaWdzq/wTnCSrKOiJs+eia7KxJVEtwys
        jtp8gqVXujf6zcMWP5a84g9nnsBo0p3N1bGZYV7U/m8zhfEQi3GE5lb4f6NRO/P2
        /yAWWe5tSmGsgBNO3O/GqSUVFrVp1gX+jvuiU19BM4FY5Ss7xk4Z+A+PcpknwwdT
        fQ5x3mSPH28BzYL42HLvcgwxMUgNs9jWL4yfjyluU3T9eQkihXy0rTxN7GhC+FE/
        dFF/Ezwxkl5DIxRUw2FsBxDNK83z7lqAxp+oQx6c3smWfTw5fiNGdvuNEqRFXEKD
        bB7wKts14KiZxaGphMPGxEA2SmU5Q==
X-ME-Sender: <xms:jlzFYIkAgwbC1_cFGzajhRSm23iXbyKbh7R68aGuDy3S3V1GIxl8JA>
    <xme:jlzFYH1shAyfEpm6iUmX0UgPpIUJ-UbdX9OezozSkmEEgUxMf-Rw_HgcL3CMFWijn
    p4ec_QnhaaT>
X-ME-Received: <xmr:jlzFYGrXdq4F3vyiA2P5C37HaJxPLocH9Fj5IZWqLak8SvNTI8VMUSlIbgSdHgZcE0mPnbvRWvO3JmRDTjCLc_s6Rzk3hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:jlzFYElgvtS-pHzUiHMWjsuP0TVSdxq3kdkJht7JgZKB9bvR6TfMqw>
    <xmx:jlzFYG1ZIO2OJhcVSk_qoPsp3CkFc9691mKcXXEZMnSDiCRU19IxGA>
    <xmx:jlzFYLudgH53c7gjpxyfORLWA1PmdKK0LsoOZ3ft0x4zQ5u10JAVsw>
    <xmx:kFzFYDuVNfcD1uT2HRd7XZwxUweYHPod94IleS2YUeLrZARB_Y19lDPOc34>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jun 2021 21:16:57 -0400 (EDT)
Message-ID: <7c77820b6e8774fbe5e3e99e81e1ec5ad4f41f33.camel@themaw.net>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 13 Jun 2021 09:16:53 +0800
In-Reply-To: <YMQSfkgnw/B65bpV@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
         <CAJfpegunvr-0b1SW2FDNRdaExr=A9OFH1K-g7d0+UiS+9j5V_w@mail.gmail.com>
         <ca79f8feb8ac6b506e7fdf249dfede832ce45a22.camel@themaw.net>
         <YMQSfkgnw/B65bpV@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-06-12 at 01:48 +0000, Al Viro wrote:
> On Sat, Jun 12, 2021 at 08:47:17AM +0800, Ian Kent wrote:
> 
> > > Perhaps add a note about this being dependent on parent of a
> > > negative
> > > dentry never changing.
> > 
> > Which of course it it can change, at any time.
> 
> What?

For some reason I thought Miklos was talking about the revision
of the parent not changing but that's not what he's saying.

Ian


