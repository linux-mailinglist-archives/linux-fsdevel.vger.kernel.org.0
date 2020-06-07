Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6F1F0930
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 03:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgFGBNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 21:13:20 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50831 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728723AbgFGBNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 21:13:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7CF9D5800A6;
        Sat,  6 Jun 2020 21:13:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 Jun 2020 21:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        EjdSuTw7ySjJ1wbQSxC6dke+Hnj5woSaxhQn7kq2flA=; b=Ex5vAyC/n8rzrJN6
        p0/LZCi5QquXfoa5YOGeQoB5qYHO/GJQfOmAUSFbOXLeKY3aenQg5RngL/o4bOaW
        nD+cZxK2gqe1VsPGezsGpyBiVhjNerAH9AkyP/+t4b1bEZtY5kHMdzQ6YqNf6Z44
        A29Ntk8IiS+4MqhfiDhf0FP6tPfFnSkJ8/KoR/oCspdJ798UwLcc8ly020jpTkEO
        /Mz8t7lov4SC0UT5AuyNskizEhBkeCVSCVMN9TtMP9Sn9MILs3FRTCSOx6G2aPh9
        LcSfaHAHC1MYRDhJyx5Z9QX1CLu4JskUaMH/uE5R6/PpZ7CIhAYiSMBXiGbDbAdg
        Q4xjzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=EjdSuTw7ySjJ1wbQSxC6dke+Hnj5woSaxhQn7kq2f
        lA=; b=Vxp8+2V85iqVaOn5cQdeUU5NvmdbmZBAEvcS7i74MBKCo7VV9UAQ7W1+0
        5moU0hxWlSGwB9Tq8QPKZS3xvVW56mwLLJa2SWc3lvOp16PYXMUlzTOw8zFJAQ9p
        8tAUPhk8OIDgw0Yj7t0MIsWiawO4rYIu4KTInOXWQsrLFlopvmEvzrmFjJxX/xTc
        oEtwH1CIJQBpA+LIQJQ1TQr1h9lz4RmleiFsK/BLToayDXYsq7jo94LnKIXyAFes
        H6yFZR4Am7cm+ecIUzRhDp5BiluVgxVmuRkjM5aO3d49LHjbSpX5Rv87GbWkwUG8
        pW4GskM6seO/qaGe0lrvW21DjtE9w==
X-ME-Sender: <xms:LD_cXtHIxD5bG4nw57-PDKa_g318kLU4S1t_Nh_gTLZF7ehD06PBcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeehkedrjedrvddvtddrgeejnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhes
    thhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:LD_cXiVj1ywiwV7-QaAKnP15kZmtgtKtPpclFF6gay365vgZraN7Tg>
    <xmx:LD_cXvLMRA79D6VczrzrtqgPIiqrSRQRMOHpH0cxBG75vAAtSTLkEQ>
    <xmx:LD_cXjEbaPO1ofQ8VuT8pgpMcF5vfVPCo4aFy-zAwQ6sq6MHlmjNAw>
    <xmx:Lj_cXqEApNChWAt4PaMTfz5DCbTkNxfIDKhJSuQC6jZU5vd94GNdtQ>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92A18328005D;
        Sat,  6 Jun 2020 21:13:12 -0400 (EDT)
Message-ID: <5df6bec6f1b332c993474782c08fe8db30bffddc.camel@themaw.net>
Subject: Re: [kernfs] ea7c5fc39a: stress-ng.stream.ops_per_sec 11827.2%
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Date:   Sun, 07 Jun 2020 09:13:08 +0800
In-Reply-To: <20200606181802.GA15638@kroah.com>
References: <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
         <20200606155216.GU12456@shao2-debian> <20200606181802.GA15638@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-06-06 at 20:18 +0200, Greg Kroah-Hartman wrote:
> On Sat, Jun 06, 2020 at 11:52:16PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a 11827.2% improvement of stress-
> > ng.stream.ops_per_sec due to commit:
> > 
> > 
> > commit: ea7c5fc39ab005b501e0c7666c29db36321e4f74 ("[PATCH 1/4]
> > kernfs: switch kernfs to use an rwsem")
> > url: 
> > https://github.com/0day-ci/linux/commits/Ian-Kent/kernfs-proposed-locking-and-concurrency-improvement/20200525-134849
> > 
> 
> Seriously?  That's a huge performance increase, and one that feels
> really odd.  Why would a stress-ng test be touching sysfs?

That is unusually high even if there's a lot of sysfs or kernfs
activity and that patch shouldn't improve VFS path walk contention
very much even if it is present.

Maybe I've missed something, and the information provided doesn't
seem to be quite enough to even make a start on it.

That's going to need some analysis which, for my part, will need to
wait probably until around rc1 time frame to allow me to get through
the push down stack (reactive, postponed due to other priorities) of
jobs I have in order to get back to the fifo queue (longer term tasks,
of which this is one) list of jobs I need to do as well, ;)

Please, kernel test robot, more information about this test and what
it's doing.

Ian

