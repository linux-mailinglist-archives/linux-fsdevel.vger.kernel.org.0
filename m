Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF234E4756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 21:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiCVUTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCVUTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:19:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D624BF2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:17:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A8B65C06F1;
        Tue, 22 Mar 2022 16:17:37 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute1.internal (MEProxy); Tue, 22 Mar 2022 16:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=n3yPUYwvIUbcuPbh5
        mzepewrf3BiHckm52gaGhvqPhQ=; b=maxLBh/Kwfjjo6a20QyBvTB1GrJ2SPA41
        LXX0y3FH+72DEBIFNUXdIp0qNs/QoKIZSNpyEjmiod+lRb1YAA0SfQrxP3uE4g8C
        z7k42bhWSgOFJm/T1+IZPksAyhSwnieu65ySmqfWISb+A4n7kR0Kd4syAyq1l+3C
        EjZuHNJOxqxKbEHGDOQWLTl9JB0qOKVimHKwFJwuBsogVrMKuq0Z40mE7NvMjibT
        a51s7RC2MQKgLPCCMeVQZHp2GXIGutzj+zAIfVM2Z8VpPK4+967jxrWquSeM2U6e
        0ylvkl/ulJbQFhn05xetlVE/a3CGorpdMI1ZB//fpBYMwMuL7CbJw==
X-ME-Sender: <xms:4C46YgYpHKf1JK3JT8ermSCAGnRYROveulaxBcugm9O8JCWUFCOgPQ>
    <xme:4C46Yrb3VsGhhiSFCaDsfdS39jYk2y7wqdBB7x-26UZ9N36kkmOlatVIvfzVdR23U
    szcU_yIahH3GK00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehffetudevkeejtdegledtjeeffeevledtheeiteefudefgfel
    tedufeeitedtueenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgs
    uhhmrdhorhhg
X-ME-Proxy: <xmx:4C46Yq9UvZt18wHMAYnlR2Mlgf5cgO_mEywcL5LGItU60Cp8RzSkOw>
    <xmx:4C46Yqq06YGvkmv4sVw7wM49nAlCCGTsqkDUJEcj7I3264ee1D_b9Q>
    <xmx:4C46Yrpszn0BdCSUwRUYlpTxkEEZul48GCqGl1EY5k8TGi_YLtcs7Q>
    <xmx:4S46YsfbnShcIAz57y_bSLbDZEMvGhJuOCqV-XqaMYDua6mub7BZGQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 90E621EE007B; Tue, 22 Mar 2022 16:17:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4907-g25ce6f34a9-fm-20220311.001-g25ce6f34
Mime-Version: 1.0
Message-Id: <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
In-Reply-To: <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
 <YjnmcaHhE1F2oTcH@casper.infradead.org>
 <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
Date:   Tue, 22 Mar 2022 16:17:16 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Dave Chinner" <david@fromorbit.com>
Cc:     "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Stephen Brennan" <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        "Gautham Ananthakrishna" <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Mar 22, 2022, at 3:19 PM, James Bottomley wrote:
> 
> Well, firstly what is the exact problem?  People maliciously looking up
> nonexistent files

Maybe most people have seen it, but for those who haven't:
https://bugzilla.redhat.com/show_bug.cgi?id=1571183
was definitely one of those things that just makes one recoil in horror.

TL;DR NSS used to have code that tried to detect "is this a network filesystem"
by timing `stat()` calls to nonexistent paths, and this massively boated
the negative dentry cache and caused all sorts of performance problems.
It was particularly confusing because this would just happen as a side effect of e.g. executing `curl https://somewebsite`.

That code wasn't *intentionally* malicious but...
