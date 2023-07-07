Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAEE74B1DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGGNgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGGNga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:36:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B31997
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 06:36:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CAFD23200BA4;
        Fri,  7 Jul 2023 09:36:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jul 2023 09:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688736986; x=1688823386; bh=U3WwRbJjkg1pQ8GfApYEadicdAHcN3v3Iv4
        DzNNiQko=; b=H/3UqVfdKrddMxb+wCh0YliH2XgX8tlj3fC3e+ljxJUILbS/ug1
        K/dtqWHYBBOhFuL273jqCa6bycHYemEcNy2QwIVriOhEk4nMjp4MVNik9U3Zteg6
        GTnVVatrG+nMJ8hvg0j/nW/xcOk0DcdedZ4ByvDhbOY24vVjL1VQm4m3zh+nTaMK
        gv0NpXHZHSSaP90bhFnSAqgwL0r+60pLfTJuQE/GhgAr7D6hx6C9gAURWou9fAE9
        huEb1UQiG1yZDSsOh+HsnOGtZ+RfAflWqvEzLQetRFA6LACTcuZtYMIT7dkqJBuJ
        vEPIr/LozEDM7cT3tC6ZEl8r4Qo2p++pdIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688736986; x=1688823386; bh=U3WwRbJjkg1pQ8GfApYEadicdAHcN3v3Iv4
        DzNNiQko=; b=fyq7zLam5ysA8WnA85BSLKHdcHoOJy6l5TZwdEB89rkucAE3hzG
        w+a0/+b2umJuoSDMu3M0ktPEoP2ezPzBDJaAan4jdu/7adYmdFwDeWXR61lNhk03
        +dtPkZptVDUOiFdqwuj1k3QXnLUecSJDxnfK6yqBlRdOOsg/dMX0bfihZaC+gVaq
        ZlXj6f5DiRB6UjrjfeN/p5VuPIrWDG59cocEqAFpVPXrtt3CGbi9iFYaTGFFVdQL
        t88pkkqrbMhueshvBUB2nNJTw6cTIs02MoNvpri8vEsSoWmXEVqeR9aFBxv/MAz8
        pmh7V4AGda2afFJep5ogf8XYg2ikb+/1p+g==
X-ME-Sender: <xms:2RSoZGLl61vLk84ed98tr3A_0hICAgNfhdwjEPdP2vff_zEPYfmIIQ>
    <xme:2RSoZOLS1M2RCUxOkKcC0tZAAoadMAbXWXXdswgpxrrxAU3vlbSr43sHX5G9syT9f
    2oJBUaR_fG8VYAL>
X-ME-Received: <xmr:2RSoZGsuzTRH_6oxQTcP_ggSSkx51OKyB0LYo3kSLxGFDSDSvGtnfslPqqY7ZYLnQF8f9ERgcI24jTdhHLVJ1f_udARPGsBshLV557EIGsmpiQNe8lT5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:2RSoZLZRmKwS1fPRuuQoEer6Q-p2WcMCNBvo6jGnFhpoubSXHTMdVg>
    <xmx:2RSoZNYSULpeTdbdYs1cRrgJEzy8XYFstMWKQ_Q6FuioR3yDP0nO3A>
    <xmx:2RSoZHDlMrffLOQrDhppEj15B5zooXV44fhwwK4CelmZbtnwgxLKrg>
    <xmx:2hSoZCNnhYp3X2qggESa2JsHRexfnAB8jdZztzIEDrSUSDxFWMQ-bQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 09:36:24 -0400 (EDT)
Message-ID: <9768b226-0c0b-b882-4b0a-68c96a458358@fastmail.fm>
Date:   Fri, 7 Jul 2023 15:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] [PATCH] fuse: DIO writes always use the same code path
Content-Language: en-US, de-DE
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
 <ZKbTB+HgmtjnQqfe@infradead.org>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ZKbTB+HgmtjnQqfe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/6/23 16:43, Christoph Hellwig wrote:
> On Wed, Jul 05, 2023 at 12:23:40PM +0200, Bernd Schubert wrote:
>> @@ -1377,37 +1375,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb
>> *iocb, struct iov_iter *from)
>>   	if (err)
>>   		goto out;
>>
>> -	if (iocb->ki_flags & IOCB_DIRECT) {
>> -		loff_t pos = iocb->ki_pos;
>> -		written = generic_file_direct_write(iocb, from);
> 
> After this generic_file_direct_write becomes unused outside of
> mm/filemap.c, please add a patch to the series to mark it static.
> 
>> +	written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
>> +	if (written >= 0)
>> +		iocb->ki_pos += written;
> 
> This needs to be updated to the new fuse_perform_write calling
> conventions in Linus tree.
> 

Thanks a lot for your review, I will address it when I'm back from 
vacation in two weeks. I had seen your DIO patch series, but didn't 
notice it was merged already.
