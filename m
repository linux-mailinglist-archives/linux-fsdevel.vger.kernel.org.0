Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C9E8071
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 07:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfJ2Gkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 02:40:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47631 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730091AbfJ2Gkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:40:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DBBF21FF5;
        Tue, 29 Oct 2019 02:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 29 Oct 2019 02:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        +Kd+gejLW4mvcxOR/1de1M0XzYW9+aIH2V4YioUEMNI=; b=qD7RsmLq8Ofd51Vv
        DgNqEG91BfpGTvaMlhQ9/0tu+lqqYMi8a18ygNFRhXQtJOEEqzJU2meAi9YufHjK
        ij9m94F6W7MC+rugukqAzaYz4j/+i4tQO5NqifTiKmnvk4eM8NiIhTEKGXcMu8aK
        CPZtDwGNJ32uw1oRJozwswyDj5mugQmQ9exVs/MBLC8dCvLnZkE/eufEHaJo9ueJ
        hB9nJ5gcjZyl9EtPfsQEMYu/TqE3eLL7mWvoKoDDatk78RTUwI0ovRyM2LdHjzEw
        FUjsRs4YUKcTJ+R5wNumv35C5gYQSJI1RBwwsokgvHiFNxpr59TaVudpzHimfnlm
        UkPwQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=+Kd+gejLW4mvcxOR/1de1M0XzYW9+aIH2V4YioUEM
        NI=; b=Vd4cj99l0Zoa9gFjs4YJEGeFRqGJfnreZ2LSqQiL6U6vDcsu4TdB40uFy
        aCOwK6aHODaW5EKhpecQk0htwMxZoQKVjQJJ8xtsAglnG7mqRQS/HSYkzApLYhHr
        fmqzzjTq/Z+AmbAXHWfqdWitmxiFTbR8KwuEpImqaZfGE3Q+RAyNEDC0+n3VKtHB
        H2CnOTW6UzF4tksG3OOsX/5P3pCWgi+VXlUJUb/DzropZ307s9BHzIdmDl8x6sHA
        Sp+2mVVLE+yLMgRBRkDdcJTA+z76i2RurisOufLzI/uJu9Uh6eaMAQdyDfEFp6nG
        lYnygpDcAhUV2NGwsH/QaAPhP0tnA==
X-ME-Sender: <xms:8t63Xf5Au4t06__H4vRdlKzIo2TbZ6b5pWbuD53L-DqodkW8mhlFeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddttddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudekjedrfedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:8t63XT3lcX2Vm-998W9zF4htjFRRp77Ve2Jl78Xeop9rUAggzOczvQ>
    <xmx:8t63XSjcWSuN7ini50VXkevdTIoQhnWAQP8HKVQJzdVFKduvJ6s9sg>
    <xmx:8t63XTod0jboFMSkc15U37MO0JxZ2ZQFW2HcSrK-tMuUqahJWVZ4hA>
    <xmx:8t63XZWtIgZZfe08n4QMEjEJApUcjnc_7KJcB4WIkLct8qYbPzMGZA>
Received: from mickey.themaw.net (unknown [118.208.187.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48CA8D6005B;
        Tue, 29 Oct 2019 02:40:48 -0400 (EDT)
Message-ID: <b75d99b91559438ab0fa4aa31522da089cbf5c1f.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 29 Oct 2019 14:40:45 +0800
In-Reply-To: <8ca2feb2622165818f27c15564ca78529f31007e.camel@themaw.net>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
         <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
         <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
         <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
         <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
         <20190927161643.ehahioerrlgehhud@fiona>
         <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
         <20191001190916.fxko7vjcjsgzy6a2@fiona>
         <5117fb99760cc52ca24b103b70e197f6a619bee0.camel@themaw.net>
         <20191028162835.dtyjwwv57xqxrpap@fiona>
         <2dcbe8a95153e43cb179733f03de7da80fbbc6b2.camel@themaw.net>
         <8ca2feb2622165818f27c15564ca78529f31007e.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-10-29 at 14:39 +0800, Ian Kent wrote:
> 
> After working on this patch I'm even more inclined to let the kernel
> do it's propagation thing and set the autofs mounts, either silently
> by default or explicitly by map entry option.
> 
> Because it's the propagation setting of the parent mount that
> controls
> the propagation of its children there shouldn't be any chance of a
> race so this should be reliable.
> 
> Anyway, here is a patch, compile tested only, and without the
> changelog
> hunk I normally add to save you possible conflicts. But unless there
> are any problems found this is what I will eventually commit to the
> repo.
> 
> If there are any changes your not aware of I'll let you know.
> 
> Clearly this depends on the other two related patches for this issue.

Oh, forget to mention, this is compile tested only so far.
Please let me know how it goes.

Ian

