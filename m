Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CE4418EAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhI0FdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 01:33:19 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32919 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232910AbhI0FdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 01:33:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3522D5C00CA;
        Mon, 27 Sep 2021 01:31:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 Sep 2021 01:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        5RSO3LTxmppqOTxU1Fq8i0gFbE0Ym22fxDCcb5hNdBU=; b=dD2LvoTqZYZMG2Vg
        LfEcGypnJm+/ZHvdAbnd5ic+Ge2zdgezP/za/2J5ZfTCjy520dxmYwCii6ubNdii
        m3XgbmMhmr/ULUxixnVPmCS8yL25nyvRet8ep0U1ItIKEwC+cm6lmRXJzvAyOEw7
        mVAjg0DDNGQJLNdRIfXN9kc16pWXnGMudWmMFmcwbn6XNuJcHyBxeJcOb88BmJV8
        D9jTmV4uyXRU6Tf9nU1FVFdTaHTfivOjfE8KbfQYRRykGNMtRfhMJHW1kDjp4VaJ
        m8X4D0u2tiMfR3H42l5EAP1LHRObEjOj82++4L205WNw7EmJ/sAZsW+WY7raHotS
        PH1MkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5RSO3LTxmppqOTxU1Fq8i0gFbE0Ym22fxDCcb5hNd
        BU=; b=Isz10WBs0jtGdolBY/WiXyacfLrKesdQWG3MNQxcETxwxq4qGa3cIINvj
        NLcrFGafPBJQNlT6kODuOiOcRxsrCIuQ5CI271cHcz0lKLscF4cbfyvpfIExtGCM
        2766f73J5SlI0ydKzDjWkLa+eZptwY3JSzebafEPoTNs+TFVHvOhrMWIbhF6/8IY
        1mPmpfFi4fi9KnBIzAYAiPvqckUZgA1joQPVPzi6ljvrl4jOCIj9f3qORuGsrnsV
        P3aIGCz8+1TX3dvnq3jqxUBV55eZEW3+GEssGWhaVrSTLWfg8jRN2G4GYldUdqvl
        C43Xp40wyob8GGximjecaIR3KdKKA==
X-ME-Sender: <xms:PVdRYY_R9BgzyRXTjAQ388O5-fqULvD3VfINYmA7MEiL0GutIX0pog>
    <xme:PVdRYQvQTQ4aRruY0Ee8OHH6UXQk_WlfO0Ff6EKkmi65RRaHDzgrZwkAHQDnn4rUW
    9Bm5mT6JOpB>
X-ME-Received: <xmr:PVdRYeDOj0twKsrF8TI1n4OrEFrh_eL0yFzZTLUv67XtGpyArgx3NDPDRKGerhCGKGR7TTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:PVdRYYfBe5sYZLkN4A8seaX2Ss_4F-UTs6ebn7vSOnNvS826dzqxNA>
    <xmx:PVdRYdN0SBrYjVIFb1eYW0T6mASrHct6lvM6NW_HsVy-C95Ks3eKzA>
    <xmx:PVdRYSnsOXedwBAMZ4dKbe56xs-NBOfZUMtKeW85EqEfsL_w3qjOGg>
    <xmx:PVdRYSoIn2cO2K-9KMl_pKMvTuqci4oXJNBSDKGHHdSa-f8GHPSM_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Sep 2021 01:31:38 -0400 (EDT)
Message-ID: <335238991ddf09e8873796feab9d53123d26b46d.camel@themaw.net>
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Hou Tao <houtao1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Sep 2021 13:31:34 +0800
In-Reply-To: <13592fb7-5bc1-41cf-f19d-150b1e634fb2@huawei.com>
References: <20210911021342.3280687-1-houtao1@huawei.com>
         <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
         <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
         <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
         <e3d22860-f2f0-70c1-35ef-35da0c0a44d2@huawei.com>
         <077362887b4ceeb01c27fbf36fa35adae02967c9.camel@themaw.net>
         <13592fb7-5bc1-41cf-f19d-150b1e634fb2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-09-27 at 09:51 +0800, Hou Tao wrote:
> Hi,
> 
> On 9/23/2021 10:50 AM, Ian Kent wrote:
> > Great, although I was hoping you would check it worked as expected.
> > Did you check?
> > If not could you please do that check?
> It fixes the race. I rerun the stress test of module addition and
> removal,
> and the problem doesn't occur after 12 hours.

Great, thanks, I'll forward the patch to Greg after some basic testing.

Ian

