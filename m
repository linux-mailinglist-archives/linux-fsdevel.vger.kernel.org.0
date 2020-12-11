Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E932D6E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 03:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbgLKCTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 21:19:11 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34965 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387840AbgLKCSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:18:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 689BD580349;
        Thu, 10 Dec 2020 21:17:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Dec 2020 21:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        Mk4NqxzLuWLKy5drr/+acuyc6PH3oJ4a/giS9TGTLlg=; b=M5FBjrSRRvmOLfT6
        dmHwZYTypaadfcXCjc2RBLcosIjUmOIer3i/yjHLB6kXGgEd/CCHqkuEu+zH/HsT
        nJY9oxQxNJLRCTJeYZzB20I3OERPUtssPkCelFs7gAmlx/4PmFYr5BW7FOLKJs2z
        VAEvh9qI9+DoqKr6BKs7PNcmH4o4mB/v3UW6Xk5iociSvYNK4++rDL4gubz7j32k
        SRSt06kN5EsjiiDmuocwKdE9+1TgvK+o5oP/Fx0axzkv+3zYhm5HOzm2dvd9b/0B
        P0bndG/092b472IlQJ4ye58Xmqg1H1tjPA2vi+y7J1ck5DQIBKFktaxnStgxw/k7
        HeArNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Mk4NqxzLuWLKy5drr/+acuyc6PH3oJ4a/giS9TGTL
        lg=; b=AX+wtifYco/jV/K4xtfKRuQ+C9ODj1FTsNLhTufAWs86NqDx4obGBVdd7
        Rhz5B2shyxI7imQJBPqLOv+vBriX5gI8CnmQXmmCNjxSZ/vK9evaKOEaZNr/R/w0
        4R1nYEjjmreChqwd3+AiTiPP5pV3CFeK3kxet8cbjb6eiAK9VwM9x+wrBSHD4Qlk
        WwWH/GbKiroRBbONpmKdTeYZx+4tYrcn8IBqTDf35bxphZiE3g2G2FsJbkXBiPR6
        LQc6b9Oo62XypPPKmtJnbYgbl1W3ruP9kwq2tYbiHGERrv81fkIjEZY1NFcW6MX+
        DIwXSQ/avo8RY02Oe/J7lBYTX9vIQ==
X-ME-Sender: <xms:09bSX8dED9Yz0WAxRcrvIVhtvlsqjBSXDVMSfXbRBlnhzTB3lpYkkQ>
    <xme:09bSX-MutR1bYud6DGe2ITai06p64mjNEI5x0DZhp6R52jDkqVOoyEMYyfwWPG9xJ
    9OFbwKuWRTS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedutdeirdeiledrvdefkedrudekfe
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:09bSX9hA6XhLi1kUCTqFuL-hBjQUutVC7nAFVh45LuSwUfF_Pfxelw>
    <xmx:09bSXx8YlmfVbF3Hj0ueAM6CchzpYPa8KaPoObfnUa2qQJkU2akNCQ>
    <xmx:09bSX4vja08B-9k_PgND-cVMrBWn5G8yVjhmiZQAw_CJSl72kcPWpw>
    <xmx:1NbSX983pEaLJlWhVV0x_kM8FOAzo88Fw8HcT6bRun9rIgVjprikFQ>
Received: from mickey.themaw.net (106-69-238-183.dyn.iinet.net.au [106.69.238.183])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79A031080059;
        Thu, 10 Dec 2020 21:17:51 -0500 (EST)
Message-ID: <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au, tj@kernel.org,
        viro@ZenIV.linux.org.uk
Date:   Fri, 11 Dec 2020 10:17:47 +0800
In-Reply-To: <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> 
> > For the patches, there is a mutex_lock in kn->attr_mutex, as Tejun
> > mentioned here 
> > (https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/),
> > maybe a global 
> > rwsem for kn->iattr will be better??
> 
> I wasn't sure about that, IIRC a spin lock could be used around the
> initial check and checked again at the end which would probably have
> been much faster but much less conservative and a bit more ugly so
> I just went the conservative path since there was so much change
> already.

Sorry, I hadn't looked at Tejun's reply yet and TBH didn't remember
it.

Based on what Tejun said it sounds like that needs work.

Ian

