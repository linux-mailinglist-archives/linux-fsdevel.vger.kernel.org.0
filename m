Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5C680008
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjA2Pmv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 10:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Pmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:42:47 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BB1F920;
        Sun, 29 Jan 2023 07:42:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D33FB60719A6;
        Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2Dfn6etn66hQ; Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3CD3162EFEA7;
        Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4_7Zr3UvarPC; Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 19C0260719A6;
        Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Date:   Sun, 29 Jan 2023 16:42:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chuck lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>, benmaynard <benmaynard@google.com>
Message-ID: <68008696.79813.1675006959005.JavaMail.zimbra@nod.at>
In-Reply-To: <EAE9AF79-93B8-4366-8672-20D407694E7E@oracle.com>
References: <20221207084309.8499-1-richard@nod.at> <20221207084309.8499-3-richard@nod.at> <EAE9AF79-93B8-4366-8672-20D407694E7E@oracle.com>
Subject: Re: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: namei: Allow follow_down() to uncover auto mounts
Thread-Index: AQHZH46KYwHmQVZSuUOnI7kKQrlJB7yd6FBk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chuck lever" <chuck.lever@oracle.com>
>> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
>> 
>> This function is only used by NFSD to cross mount points.
>> If a mount point is of type auto mount, follow_down() will
>> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
>> to have ->d_automount() called when NFSD walks down the
>> mount tree.
>> 
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Hello Al, you are top of the maintainers listed for fs/namei.c.
> I'd like to take this series for v6.3 via the nfsd tree. Can
> I get your Acked-by: for this one?

ping?

Thanks,
//richard
