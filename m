Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7275764B1F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 10:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiLMJNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiLMJMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:36 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81BE50;
        Tue, 13 Dec 2022 01:09:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5FA59320097E;
        Tue, 13 Dec 2022 04:09:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Dec 2022 04:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670922560; x=
        1671008960; bh=x6EvN9RCMMZUQL1h6HXvoOYLnZvU8WJ2nMis5bUscl4=; b=H
        dl/8r/bqnayq2L2QpDq/yb8wV+sFSMd15m0tcmhyL1dGd9kJ3jaSIktL/AYws4yW
        C7qVbkttNbALjLUxXnNwNnkKNYsYUDP7iEq4L0NIHzHrHAPDv4i+gEkZkd8E0FR3
        ZfA2nVXE46b1Myiki31bqUPcpVsMA9LRjaobNyuimN7ho2gMfbwF6eQyLI5EnT72
        Y/Z7e0jmzrLMw98NDlH4E8p0Cg6hg/bMmMMVKO4EtP90COUOoDuSwSbA0lIjG1fM
        XBStvN/ohSM4Hghc2PTOqZTzknLfPNC5qUrIPCLLhJdu5hl1ojVuTUuDENBeXiNb
        B5X15Xtxe5LCcCkRc2TrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670922560; x=
        1671008960; bh=x6EvN9RCMMZUQL1h6HXvoOYLnZvU8WJ2nMis5bUscl4=; b=C
        HktLlN4HvSSYumBT+hzJcR2FabLQPoDTQG9bBtXkADytI+qNT3iMbj47XzM7a1Ku
        9riuKEB76Mdjv5RRUSmJIQXm9yEvTL1/eC/f1XjZ2FqKnvsNEsKkphmbLghI/3tv
        rFrgrBCsE+HWk+c7ynsM2mZ7K8lnhQ2chFxVYoY9UU+JwjuPHygIr5ubqBez6ZZU
        dqXqmjoxtmegtpavxpU8oTjsXUKnH1suepbVFGTXzJECHBq5w3gpm4Q3NxaPZ0Sc
        /MXPg/GA5BAJIyXe8lmQN73yTBaI9ClySHn55LJ5gkagT3NiY4bnYIrSY2TRN7m5
        Ra4AV1rXris/I8oWhkAxw==
X-ME-Sender: <xms:P0GYY3TVtQNkawVHKO0UUDYKcrnScExv3-le4P2wx50Kmx6p8zU1QA>
    <xme:P0GYY4w2GJnqG3vv_F5TE3kkgM-C88eKzV9MIFqhjD_keDsP6QuqjaTw1bqQfNzyG
    J_BehbNsRux>
X-ME-Received: <xmr:P0GYY81ZwZhCLJYlTj7LvZTyc3bZbcbn3wkzf-P3JbiFQK9Eturn272KGCdM2TCDYd4qZ3AFGS-rtoLIkdYuVuKDFCs842S9KpIve0mQPwJgI0qqLQK9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghnucfmvghn
    thcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepffekvd
    fhgfelueehleeiuedtkefgfefghfehvdevhffhgfevgefggfdtkeevgfdtnecuffhomhgr
    ihhnpehmrghrtgdrihhnfhhopdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgv
    th
X-ME-Proxy: <xmx:QEGYY3DW4JTpRuwQe2fWBvSs3AeaW2duDQ95armVpZs5r9NizGeK6Q>
    <xmx:QEGYYwiy52-Ulngvs_4EZ-3JzKUdnUSHgHAx0qORBh5Q4kFUX3-png>
    <xmx:QEGYY7qZ4F-LpQyp9K5V-bbts_ZPqhLYh0B41VUMdCIp-dLhqDAYNg>
    <xmx:QEGYY_qOGMCCFkBzTQX2Gm2ZMF7pcf6v5XMiM_rlKlcGfwZ1lpGS_A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 04:09:14 -0500 (EST)
Message-ID: <8967d08f-712c-5b64-efdc-4426e2b9d63a@themaw.net>
Date:   Tue, 13 Dec 2022 17:09:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when re-exporting
To:     Jeff Layton <jlayton@kernel.org>,
        Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        luis.turcitu@appsbroker.com, david@sigma-star.at,
        benmaynard@google.com
References: <20221207084309.8499-1-richard@nod.at>
 <2de81c537335da895bafcd9f50a239c439fb0439.camel@kernel.org>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <2de81c537335da895bafcd9f50a239c439fb0439.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/12/22 01:06, Jeff Layton wrote:
> On Wed, 2022-12-07 at 09:43 +0100, Richard Weinberger wrote:
>> Currently when re-exporting a NFS share the NFS cross mount feature does
>> not work [0].
>> This patch series outlines an approach to address the problem.
>>
>> Crossing mounts does not work for two reasons:
>>
>> 1. As soon the NFS client (on the re-exporting server) sees a different
>> filesystem id, it installs an automount. That way the other filesystem
>> will be mounted automatically when someone enters the directory.
>> But the cross mount logic of KNFS does not know about automount.
>> This patch series addresses the problem and teach both KNFSD
>> and the exportfs logic of NFS to deal with automount.
>>
>> 2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to install
>> a new export for the target mount point. Beside of authentication rpc.mountd
>> also has to find a filesystem id for the new export. Is the to be exported
>> filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it and
>> refuses to export. In the logs you'll see errors such as:
>>
>> mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or fsid= required
>>
>> To deal with that I've changed rpc.mountd to use generate and store fsids [1].
>> Since the kernel side of my changes did change for a long time I decided to
>> try upstreaming it first.
>> A 3rd iteration of my rpc.mountd will happen soon.
>>
>> [0] https://marc.info/?l=linux-nfs&m=161653016627277&w=2
>> [1] https://lore.kernel.org/linux-nfs/20220217131531.2890-1-richard@nod.at/
>>
>> Changes since v1:
>> https://lore.kernel.org/linux-nfs/20221117191151.14262-1-richard@nod.at/
>>
>> - Use LOOKUP_AUTOMOUNT only when NFSEXP_CROSSMOUNT is set (Jeff Layton)
>>
>> Richard Weinberger (3):
>>    NFSD: Teach nfsd_mountpoint() auto mounts
>>    fs: namei: Allow follow_down() to uncover auto mounts
>>    NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
>>
>>   fs/namei.c            | 6 +++---
>>   fs/nfs/export.c       | 2 +-
>>   fs/nfsd/vfs.c         | 8 ++++++--
>>   include/linux/namei.h | 2 +-
>>   4 files changed, 11 insertions(+), 7 deletions(-)
>>
> This set looks reasonable to me.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Right, looks ok to me too, at least from the POV of that follow_down()

change.


Reviewed-by: Ian Kent <raven@themaw.net>


Ian

