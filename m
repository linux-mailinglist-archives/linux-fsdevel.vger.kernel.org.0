Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E5603736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 02:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJSAmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 20:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJSAmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:42:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FB9379D;
        Tue, 18 Oct 2022 17:42:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0CE2E32003C0;
        Tue, 18 Oct 2022 20:42:17 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Tue, 18 Oct 2022 20:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1666140137; x=1666226537; bh=mIh4N6NCtP2679r32LZ+wgszmD5PbyIXtro
        ysiCTqEM=; b=wSOVpxdrGzELe7TNORZ9wAoMGGJrNUS3DE8jlzG0U3DiF6sa6S+
        +oXFKzj1hLRWB70Ivqk6C48+/tSwflWS2sdBfJW5cPNHhwG+KV85EcGY6uDifjel
        hH/cviYwxHXRQjPkqthsfHrgGPifwo6q9XXJAzHRw/1P1NRlP2oX6wBlNxUQlBVJ
        5JfeEdSMApWEedHsH/uLrSoDDJabklB8cEO1ivJiOCeCei5iFKffePSX9T8AO5gr
        GIcp1t3tj1HmlNpku0EanZrQKOBm5hOHiKZibvm1CfuTi+G20YEivpLJNxGNwNKn
        EFstRr7ldOBXJxHf2TPrhhamwsxhfcRhEyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666140137; x=
        1666226537; bh=mIh4N6NCtP2679r32LZ+wgszmD5PbyIXtroysiCTqEM=; b=c
        JPYvROp0027cTrIU+zHcwp5HVHbaZRos7IyiXjqvs8qXLWz+Bmm1Lh4g9n9+dIJt
        sh8czXk0Pea43pzj31U0ralyTlvRJRl0EdyrYa8q56iG781E89MpOukDAHAAaniO
        gid5+beuEOejJlVn8ent8vx6iboUw1Z7PLANiv2WhxW2EIwjSqZks+mqhr0MLl8b
        WcfI9Uisp9OjdaOADlkADqmTmGxFp5SEBpmPvHnaCJuJDzb+jtQ8vJQS51j0WtzW
        Jy4bPThIKZzFfx1cNrMv9dmfDjaC+ZwYDbQQdQN4IwEG1gxCBTig1M/lU2VQUpUW
        ohEDGAvIvEv4GBgO2bkYw==
X-ME-Sender: <xms:6UdPY88KhEJMst0UWtwdnzIm1Bsdijd0xum55uUBlyMfvuioP83tYw>
    <xme:6UdPY0uwuLQaoiICfhcKzYw7zT-4GCMJDMPME_E8LJDKdtKBhJQse0Jv1BdfW7kD_
    c9uauFdkqcOsuwgqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefofg
    ggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgedvvdeigfdthf
    ettdfghedtleeuteefueetiefhledvhfelleeutedufedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:6UdPYyDKimerttOT4AkrOZ8rKn0T7XdVgWRkjHfsQkstCclyaWLJuw>
    <xmx:6UdPY8c7FCLhQvwqwmRDskIUzgBgos6Vkfus8m2FNYVK3ocIYEBx8A>
    <xmx:6UdPYxMCCpqOWzlCpoHzUaTSZEXZld5SuZWBdTMtkKFIJgQxvGzM0A>
    <xmx:6UdPYzULW8tOhOsBo2EbHmEo0vk8SE65rEl8D0DibBcWNzUyo86P-A>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4F45CBC0078; Tue, 18 Oct 2022 20:42:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
Date:   Tue, 18 Oct 2022 18:42:04 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Odd interaction with file capabilities and procfs files
Content-Type: text/plain
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

(Going off get_maintainers.pl for fs/namei.c here)

I'm seeing some weird interactions with file capabilities and S_IRUSR
procfs files. Best I can tell it doesn't occur with real files on my btrfs
home partition.

Test program:

        #include <fcntl.h>
        #include <stdio.h>
        
        int main()
        {
                int fd = open("/proc/self/auxv", O_RDONLY);
                if (fd < 0) {
                        perror("open");
                        return 1;
                }
       
                printf("ok\n");
                return 0;
        }

Steps to reproduce:

        $ gcc main.c
        $ ./a.out
        ok
        $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
        $ ./a.out
        open: Permission denied

It's not obvious why this happens, even after spending a few hours
going through the standard documentation and kernel code. It's
intuitively odd b/c you'd think adding capabilities to the permitted
set wouldn't affect functionality.

Best I could tell the -EACCES error occurs in the fallthrough codepath
inside generic_permission().

Sorry if this is something dumb or obvious.

Thanks,
Daniel
