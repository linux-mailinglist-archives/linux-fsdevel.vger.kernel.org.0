Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54B78B90C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjH1UEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjH1UD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:03:57 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A51B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 13:03:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A8F595C015A;
        Mon, 28 Aug 2023 16:03:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Aug 2023 16:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693253020; x=1693339420; bh=GxqwDKHydqlnJ7kbWpglWYqkoH0Zw6cwxq6
        aJLr0wPY=; b=mYUHBLfO6GBCsQnOMqrIbVDWWrrszG/aYNNbnrRAA70NlIAxn0y
        V54sBB1Z958QVaVuYWMZKU6ESfmYCmJpxnL4jCaC5PDvQqWswYqkk4arQAcY2Srd
        jP6rr28fxCxzCvGgJD2wsKejs1rPxQmbkO8PskeKhP4QR+q8R9G2C3v/RZXs1DzP
        +6A6GtZmaGaYz9M4qmTmTvORHrPnUmjR0Tnt8VPkVbWk53tPbUrAseSA2lLqKuOC
        2DVIwQ19IowAc0x0IOGLlA5CgBiHIqRWKkIkM+WRgQW7ZPbKlyL44YLZdhL+RRB+
        Nh5rbaW8QCfQ/uh20/JAGvY5YEXB96UH/Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693253020; x=1693339420; bh=GxqwDKHydqlnJ7kbWpglWYqkoH0Zw6cwxq6
        aJLr0wPY=; b=z5cu6QZfydyYuM4VY/C7u9K6yXGmlpcT49JnipLjzdclq0gD3IG
        X/qhKbw5mOd/4mkk02PecYxM2CfxJgpX4xa6Ugthe4apDFoqFJpxymm5TOhG/gVe
        a2OYuPj/qUlVg79B4UpDlJw0qkShglprGIW5ynJ0Ca7wEfLH2Dcc2SYgzuzrF6OT
        U9IuOSnGuCwowETey5/Uh/uDAPFsADNo1J51pIGFKCuCuOw0Yuh+q8ICUORGzVb9
        VzhWkCOEK0u2e+iSQu9uW+XXzTa2c9SiAgGOyKWfW+F3TOOp+huG9sCImTD9tfxj
        yJKIptaDxOsjuge2g9ZsT+gROq/29Od8m6g==
X-ME-Sender: <xms:m_3sZOjzUMaNpzuzdRyDGB9SczCaRlY5GA-GXeGdQwiXcVv97QaIrA>
    <xme:m_3sZPBlcH1LIERsJh4r-10cBmPy-TRcT6Xs7o7dYMMWYpA5EkRThRQafObyoIpW3
    NBRoFCrOPT-f76O>
X-ME-Received: <xmr:m_3sZGFfEXWQM7RLA5TsLsTS5OxuL4DSiC5hBq6CFMwNSuyK8b7u3XhRWk9nr4IOHDw7zpIzd7kMP2GOo7AqsXSc8wXj-SM8mgfIduGAHIeA9cu9fFbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:m_3sZHQuZsSNX_8jqmuawRnr6VcmFVTfcL0Gj1G3VWZ5_AlVZj13-w>
    <xmx:m_3sZLzDcRQgmbWPH7dKXKBwfVxpT_8bsBU0Kf25cqNwBw1yROfcZg>
    <xmx:m_3sZF7bgeQTIF19UROuznyhKWgyqV-Hyvwe7c0z80oWkOYIO5Pq0A>
    <xmx:nP3sZL8OOxh3Rbzx22Vj05KPDYovNrifCnrb9EP1YCCbvGEYlaNE2Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 16:03:38 -0400 (EDT)
Message-ID: <1673c0ad-8e1d-fdcd-cffc-33411a7fabd2@fastmail.fm>
Date:   Mon, 28 Aug 2023 22:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/28/23 13:59, Miklos Szeredi wrote:
> Also could we make the function names of fuse_direct_IO() and
> fuse_direct_io() less similar, as this is a very annoying (though
> minor) issue.

What about _fuse_do_direct_io()? '_' to mark that it is a follow up and 
'do' that it initiates the transfer? Or maybe just '_fuse_direct_io'? Or 
'fuse_send_dio'?


Thanks,
Bernd
