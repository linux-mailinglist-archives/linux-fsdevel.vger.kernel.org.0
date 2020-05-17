Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415691D687E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEQPA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 11:00:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60701 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbgEQPAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 11:00:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B2C95C0091
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 11:00:54 -0400 (EDT)
Received: from imap7 ([10.202.2.57])
  by compute1.internal (MEProxy); Sun, 17 May 2020 11:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type:content-transfer-encoding; s=fm2; bh=PYQdK
        a4yEw9ZT/evyfWGU9X9I4J6+RvfX5WenXXhhzw=; b=mMgblVV6pJjqRv2PQ093z
        WMKULfoywwpwvqKwNDK1wh+I+gu79t5P7F3G7wprdhlob58gAvtdXvFswiWl9GTH
        oEcSup6YbzvZwMJ8s6YogwJ9TQmVKzTWCdtKfyNO0z43ORux95pwjF/8iihXlFiC
        oxA9CBPZuEuGMA3u9eYG8uLZ4UgZIy0vOOpHkuDjt4e0eFozoF+YNzviAU/Q9XuL
        yA4wS0ei/nHE+NHcZI00OIaeJo/eBJGYA+aBYM3KoFHsr/7CoCVipIwRqqBB1man
        Os+sZ855w7qnWddaJKsvjwxnPgncDoikgzCLHO+iG08RHwmxi63c3SqESdL817PJ
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PYQdKa4yEw9ZT/evyfWGU9X9I4J6+RvfX5WenXXhh
        zw=; b=3erz6sa5/gtyOODTcltCRciXq4W9IbCxCSK+ZvVDoKEPx4HCj3tkaeAqD
        5KLTJ62zZqfvgmoMJ9tstCIvwgrIiKtH7uxFWOqmEcfYmwdH73w6W6pMB8Olp2Ta
        BvzMJJlivTX8vieGiBO/3iU7/QT+EhM6RbbjvMDehlDdy+I/bWtVhmy9lPbRbWVw
        TYL9j/OtLdGKY2jemOUT9mw3GeElhG9xFjmwFVGDsukQZ/wi0ZrTegY1Y3jJ+X4Y
        a5UxNqCVAFWrsbCLrdTf8S1NVrm3saMmkYa41yvZLxJo58/ZLcu5O5s/EcamOmDO
        jgDbZYZkH/11OqxEK1tOi0pZV2Q8w==
X-ME-Sender: <xms:plHBXkXINl2qejpxPQ541I3SPV3xNNUnJGmQbO-xXCi5PYe3KFvu8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtfedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfpfhi
    khholhgruhhsucftrghthhdfuceonhhikhholhgruhhssehrrghthhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdutdegvdegtddtgeekueevfeelgfejleetudegieelhfdtvefg
    jeejffefkedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepnhhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:plHBXolf06UvnvoWaaBz9a0cM60GFpJKgajgVJArGsy2w0954UBPig>
    <xmx:plHBXoYbgVqjyeJb-g3i4P9iaAZV97p6KDt3MqBv6v0il5BXjy0NkQ>
    <xmx:plHBXjWIHmCqrGqObIcVXSagGWqz2yQQN9mQFvdWcMrgfZmeTwGymg>
    <xmx:plHBXlvjZzejzcuha4y4ye3yjLfw4OUVb0Bu-A6qAuztgFwE0xTY9w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CDC9180091; Sun, 17 May 2020 11:00:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <f52ddbc4-4551-4997-8fda-235f2c461260@www.fastmail.com>
In-Reply-To: <20200517080909.lod7sjfio5jvsjr3@yavin.dot.cyphar.com>
References: <874kshqa1d.fsf@vostro.rath.org>
 <20200517080909.lod7sjfio5jvsjr3@yavin.dot.cyphar.com>
Date:   Sun, 17 May 2020 15:59:08 +0100
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [fuse-devel] Determining owner of a (fuse) mountpoint?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 17 May 2020, at 09:09, Aleksa Sarai wrote:
> On 2020-05-15, Nikolaus Rath <Nikolaus@rath.org> wrote:
> > Given a (FUSE) mountpoint (potentially mounted without -o allow_root=
),
> > is there a way for root to determine its "owner" (i.e. the user who =
has
> > started the FUSE process and invoked fusermount) that does not depen=
d on
> > cooperation of the user/filesystem?
>=20
> The mount options of a FUSE mount contain the entries "user_id=3DN" an=
d
> "group_id=3DM" which correspond to the "mount owner" and those entries=
 are
> filled by fusermount. Is that not sufficient?

I think it is sufficient, I just never noticed it. Thanks!

Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

 =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB
