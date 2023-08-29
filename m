Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8393278CB77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjH2RmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjH2RmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:42:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4C11B;
        Tue, 29 Aug 2023 10:42:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C5BB15C02F8;
        Tue, 29 Aug 2023 13:42:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Aug 2023 13:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693330926; x=1693417326; bh=vU
        Px8oYX/3QZqAoIaLAAWnQwMvEn8D/TQzGmJFD44tU=; b=KVttY2fUjqrtpFj3u/
        mhZLGcaTNske7JtrPBgcwTi1RAOJ7Mjx7QmJX60EAwBCAd35RzLrlyGYW5TcnNLh
        5uA2/B9gxY1GmQQxjuCKrT6ZuEt/bEX2zQTNgq3pneMqAoCLJorJ0AFoUBOkoZCx
        a4Qp5Szc+N1h4QUSEUKxnyGvK/vFghIsG5T4RKGn+PGHQURYqNdBhSSNSwt0Za5u
        2MBOzgbI7hehgtRGMD5gtc684N/Af1A773RyM4HJSEOjSl+ON/DNFfNsPcT4jBTW
        5VzLk70eqpfZF5TX+cAW5wpW7ENnmzh5Lp2BjTEg5hFoO5ggw9HLv+VCnW2oyPcy
        g6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693330926; x=1693417326; bh=vUPx8oYX/3QZq
        AoIaLAAWnQwMvEn8D/TQzGmJFD44tU=; b=ONRcVfDeYseSBCSSURBgd5BsfEj7Q
        SRNJ1ZuDbbdqN2deFIbKUybgUAMhn16s4GO4C/GoDThU7Xh7J/SiYXsaD+9p/sof
        OMMrgPoAuHCV8kOj0cAKC+iMVulxRnsl/OPgibamLGFTQhFWxfmuqC54gQnYeqjG
        GbOYsN//plUsnB2hpETgWXZi949YJgAfMzOr8EiTFj6WHN4mmk0SWw9dKozKDP7V
        JzhMmY+y/MF1uh889VyI8y99dVUibexaIZcaSun8kgIq3Q1mA6QxxCuO6LWTQgFB
        AMsMh5k02prZO217YhumA0js4mLK7mNkFoCJLGNlPTngfeHhmou9GJRlA==
X-ME-Sender: <xms:7S3uZJdIWupChgxobXhkbrrsNWQjvxeETliORn97GUQ_AoPaAle-Hw>
    <xme:7S3uZHOu0go8c7zrpI9wgiWcnnah_kAM1oqkwOvTW1Q8lJyj-Vozsm5led1sf7f1r
    g7EH8CJUs2Z92_IxH8>
X-ME-Received: <xmr:7S3uZCjx02c7ALH--bpvDJm5WIsTEwgnifUf5sHAFzwlnekgb4YR6QFklr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeejieeitdekgeevhfefhefgvdehjeegudegudeltddvjeevieejhfev
    vdekffdtheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:7S3uZC8Kq-UCg05AFT_BwA_LU29mephwdusHimgKOHahV1k4-4BwFA>
    <xmx:7S3uZFtUkdbD8PqFatbqsMIj6JR_E02hg6v9lybsbKvKVnLv0n2lrg>
    <xmx:7S3uZBFJdRzfmrMpj4rkxvgiPLjuOsNf1coGGs3CdV1Akrol91CvQg>
    <xmx:7i3uZPIXRGyta5Rc6sLoieas89aWSNTVzNOupogUXiID0kqbiOqjlw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 13:42:04 -0400 (EDT)
Date:   Tue, 29 Aug 2023 11:42:02 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Message-ID: <ZO4t6pnCokUoEsoi@tycho.pizza>
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza>
 <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
 <ZNqseD4hqHWmeF2w@tycho.pizza>
 <CAJfpegtzj7=f99=m49DShDTgLpGAzx8gpHSakgPn0qe+dNjHdw@mail.gmail.com>
 <ZON8hKOAGRvTn83a@tycho.pizza>
 <CAJfpegt2WrKBswYgSzurNogLefO-vU6ZpbCkrDrjFL365kcsug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt2WrKBswYgSzurNogLefO-vU6ZpbCkrDrjFL365kcsug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:31:48PM +0200, Miklos Szeredi wrote:

(Apologies for the delay, I have been away without cell signal for
some time.)

> > I think the idea is that they're saving snapshots of their own threads
> > to the fs for debugging purposes.
> 
> This seems a fairly special situation.   Have they (whoever they may
> be) thought about fixing this in their server?

Sorry, "we" here is some internal team that works for my employer
Netflix. We can't use imap clients on our corporate e-mails, whee.

> > Whether this is a sane thing to do or not, it doesn't seem like it
> > should deadlock pid ns destruction.
> 
> True.   So the suggested solution is to allow wait_event_killable() to
> return if a terminal signal is pending in the exiting state and only
> in that case turn the flush into a background request?  That would
> still allow for regressions like the one reported, but that would be
> much less likely to happen in real life.  Okay, I said this for the
> original solution as well, so this may turn out to be wrong as well.

I wonder if there's room here for a completion that doesn't use the
wait primitives. Something like an atomic + queuing in task_work()
would both fix this bug and not exhibit this regression, IIUC.

> Anyway, I'd prefer if this was fixed in the server code, as it looks
> fairly special and adding complexity to the kernel for this case might
> not be justifiable.   But I'm also open to suggestions on fixing this
> in the kernel in a not too complex manner.

I don't think this is specific to the server-accessing-its-own-file
case. My reproducer uses that because I didn't quite understand the
bug fully at the time. I believe that *any* task that is killed with
an inflight fuse request will exhibit this. We have seen this fairly
rarely on another fuse fs we use throughout the fleet:
https://github.com/lxc/lxcfs and it doesn't really do anything
strange, and is mounted from the host's pid ns.

Tycho
