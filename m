Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01D36490E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLJVwI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 16:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:52:07 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AB71581F;
        Sat, 10 Dec 2022 13:52:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8A53C63E5714;
        Sat, 10 Dec 2022 22:52:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MqJGNmu8EMf3; Sat, 10 Dec 2022 22:52:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1559963E5733;
        Sat, 10 Dec 2022 22:52:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Nl9lbmLN4PGe; Sat, 10 Dec 2022 22:52:01 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E687763E5714;
        Sat, 10 Dec 2022 22:52:00 +0100 (CET)
Date:   Sat, 10 Dec 2022 22:52:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chuck lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>, benmaynard@google.com
Message-ID: <1733592831.372285.1670709120777.JavaMail.zimbra@nod.at>
In-Reply-To: <1AFA78FF-3F09-47E3-BE13-F5BB7F9C779C@oracle.com>
References: <20221207084309.8499-1-richard@nod.at> <1AFA78FF-3F09-47E3-BE13-F5BB7F9C779C@oracle.com>
Subject: Re: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when
 re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: NFSD: Allow crossing mounts when re-exporting
Thread-Index: AQHZChf8XdRuFhfYVUuBoBZu4IH8sa5nT0OA6nC3O8U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chuck lever" <chuck.lever@oracle.com>
>> Richard Weinberger (3):
>>  NFSD: Teach nfsd_mountpoint() auto mounts
>>  fs: namei: Allow follow_down() to uncover auto mounts
>>  NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
>> 
>> fs/namei.c            | 6 +++---
>> fs/nfs/export.c       | 2 +-
>> fs/nfsd/vfs.c         | 8 ++++++--
>> include/linux/namei.h | 2 +-
>> 4 files changed, 11 insertions(+), 7 deletions(-)
>> 
>> --
>> 2.26.2
>> 
> 
> This series is a bit late for inclusion in v6.2. The next opportunity
> will be v6.3 in a couple of months. I prefer to have a "final" version
> of patches by -rc5.
> 
> I'm waiting for review comments on v2 of this series.

Ok! Do you want me to resend the series in any case by v6.2-rc5 or only
if new comments arise?

Thanks,
//richard
