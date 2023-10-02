Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E947B5D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 00:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJBWSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 18:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:18:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199A91;
        Mon,  2 Oct 2023 15:18:49 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 6891A5C0176;
        Mon,  2 Oct 2023 18:18:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 02 Oct 2023 18:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696285126; x=1696371526; bh=Kf7Ykmgbfdu5N+OfY/OsdIyHSTeSp/sSxrP
        ybVZP/HQ=; b=lKLZvJ4F3LkgjNkja+6sXy7kK50ZuKGD2mY7H0PA/3PSryjqPNk
        tc5U/ZFh6WlIBd2FkJO2EcFlWFmHh7G6r2NfRTikNjxivA+BtL3nWlMxA02S7RX+
        NOLxJL4C1dXNdE3kaV/1xJnttlRTrMp7g2mnGrmUfsY1vm5aD+PjRlujpkDNOaPF
        b/g0mjXLfGYc7hZESdYItQk2Sdsw7vM6/jnnkyv4GCIYz6E4LFnvzoqeGkE9p7qT
        k7qi2YxD7sJDod6gpHvkyUq4ITTI+3Jon7pHpAw+8vdfNo1Kh6vyLgB54EdsxlsK
        z7cCbbawKMHpCBpoJax7azJVAUG45Qy//+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696285126; x=1696371526; bh=Kf7Ykmgbfdu5N+OfY/OsdIyHSTeSp/sSxrP
        ybVZP/HQ=; b=dZpwWqu6puNF7CyKZsmq225hr5AVDmYYRlTxub3v7FoYgl8ZZcM
        wgqwqvkXIkHKiww7cUHn3n5yzmms8WVXGXYlbm+RlFiBG092V8GbZqQz68roenAR
        7ndkC8ofwTK11yIBbshuD5gWzRJ/58J3YPIQ0aJEfImYhS1YDcS1T834SwTV0aWk
        t8evKXyVUtk1W1cOtMBSntaWlHmgIv6R839/or/g4PNPftj5zLatSocfw1zJ3ec2
        FczWr5/BDG6tVT3pjTfoqURM/5DAQ3nBT3dWBo7nwaYVY2FkaZnBKwlQRUR6dTan
        NZlRVqr+EIUGJM5XxQr/16hs5SK/EDPqICw==
X-ME-Sender: <xms:xUEbZc3u324XBuY6c0Ll07VtzDte2gJnsog_bNe5ibyH1LwbQpRbog>
    <xme:xUEbZXH31pijX1_0FrVNrzNN4zxnlNAaJ0uhy-YyfQDJPGlim6zRkep04KIzDNIDN
    ic4pQcHJkr19Z-X>
X-ME-Received: <xmr:xUEbZU45Y0dRcSMTo0v-FEsDetGvy_n96JEx6CGsEgVsibkCPb-QnulrdfuBydoi3Vpa2g0gdGiTq7JAcXbj75IksU3Tdyr9MIXiHLXZSnE9L103dl8D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:xUEbZV3mhkeepYT7X8ZkdfbDc_aN33bRvXXRtaeEQvF5UeJgPxW-CA>
    <xmx:xUEbZfFnZ-eWboMARv_Mqu1RLJ96qQmX0jJrhE7O3Rk1bSZl04oasw>
    <xmx:xUEbZe9jfL873vlg2_kIiBBY21ytQ9x7JYRZZo73aD4wE0I-CnY7BA>
    <xmx:xkEbZU6hCqdQ1E84DvskxdXGYbdTz94i2-DAtvH9v3GKnhaP6KaTmQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Oct 2023 18:18:44 -0400 (EDT)
Message-ID: <97163cdf-ab2c-4fb8-abf2-738a4680c47f@fastmail.fm>
Date:   Tue, 3 Oct 2023 00:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v2 0/2] virtiofs submounts that are still in use
 forgotten by shrinker
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <cover.1696043833.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/2/23 17:24, Krister Johansen wrote:
> Hi,
> I recently ran into a situation where a virtiofs client began
> encountering EBADF after the client / guest system had an OOM.  After
> reproducing the issue and debugging, the problem is caused by a
> virtiofsd submount having the nodeid of its root dentry fogotten.  This
> occurs because it borrows the reference for this dentry from the parent
> that is passed into the function.


Sorry, I didn't forget you, just didn't manage to review the 2nd version 
yet. Will definitely do this week.
Please also note that there will be merge conflicts with atomic open 
patches from Dharmendra/me. Although probably not too difficult to resolve.


Thanks,
Bernd
