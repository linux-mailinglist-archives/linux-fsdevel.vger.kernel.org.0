Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3D23A86E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHCOal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 10:30:41 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40355 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgHCOak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:30:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 7BBDB10D1;
        Mon,  3 Aug 2020 10:30:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Aug 2020 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        6ek7rotfn8yHr2SVRzyFzJOuazfE8xSPG939AHlpXcs=; b=eMfuj2cAVKP+mJQT
        biNupJQwLHqaYhHLFPuUZQyX6CGdZVry0cLxvTO0phcdbXXnC+pMPkI29PiaDNuG
        aus0TI6+71rhFFJ6BuivmuUCNYH+sJkr9LS0qGEhf58g6Kq5foxI8EqS5PQ4BNtR
        m2Hdlp6p41lZC7lp1a58aYOyyx6HUKRh+y49rCGvH3/At3UhVpzU/LLsFFbPog+Q
        o+YatBlPIgnd5sSWDoODyp/+5qt4iIs/KHw+Wt+p37JNiEMwKJQSodCj8DAIHgqt
        92SGbDsncSpk0NxE6QhXTLUk7L+zUbWsu/4R0Yvsu1HaAUw9aPmQK8Z3tV+EcTxW
        XObDxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=6ek7rotfn8yHr2SVRzyFzJOuazfE8xSPG939AHlpX
        cs=; b=koW4Adc0qWAHAZh5OZze593zLQ5jC/97529jgi5ZrIO85WbZaTvEqIQYr
        FzDW3RVPNUW5x4HnrPnHyRr6XmXm9VP8iHULgGRKn+X1jvbZ6z9ptyApoH5WSadi
        H6wQAGmPvBQ4QiQWgzvSdwzx6x0ev37TRK7ZDLqk2H9gAmJeOH4fV/UIissEABEd
        XpLESd5lLaS64CIhyrHxFsftbia3cayePjctHkOuTYP6ZBHCYy2iaZ9Ze725oW/D
        fNGMN5ICfcWD3u4HYrxir3Sp56lt/TXEKJNl9Bg1yJWqZp3OgM88ok7OhlCLQ3Kd
        CIIiZfqW8kk15A5jO9EULcEaGWWYw==
X-ME-Sender: <xms:jB8oX9DYMRIhNCgzRhkgmRWYIqvLOsYXnTdrp5z4cl9pF3Zup2mUyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehtddrudekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:jB8oX7hMug9NSJyrBx-_hsaMghqA8sU1pT1QNwHXC8iZ-PoSEBXb8A>
    <xmx:jB8oX4lSQFRztQdi_y97W_W-WMfF73BDlC4jB3L_cbtLHrSDvH_uzw>
    <xmx:jB8oX3ymudJ9OvqndBdAuE8iQpa_i2PpNRXb7Io4TRefSNVLy68EDw>
    <xmx:jh8oX5JfCwhU_CdTBs5mjIgpfDFvki_ar5qP-6ciQt1_eoT-iTdbyo6YQfc>
Received: from mickey.themaw.net (58-7-250-185.dyn.iinet.net.au [58.7.250.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01829328005D;
        Mon,  3 Aug 2020 10:30:30 -0400 (EDT)
Message-ID: <bfba8e858885b8c507b8816d5296f7ab7f949e78.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 22:30:26 +0800
In-Reply-To: <1692826.1596457912@warthog.procyon.org.uk>
References: <303106be4785135446e56cb606138a6e94885887.camel@themaw.net>
         <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <2003787.1595585999@warthog.procyon.org.uk>
         <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
         <2023286.1595590563@warthog.procyon.org.uk>
         <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
         <1283475.1596449889@warthog.procyon.org.uk>
         <1576646.1596455376@warthog.procyon.org.uk>
         <1692826.1596457912@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 13:31 +0100, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > > I'm changing it so that the fields are 64-bit, but initialised
> > > with the
> > > existing mount ID in the notifications set.  The fsinfo set
> > > changes that
> > > to a unique ID.  I'm tempted to make the unique IDs start at
> > > UINT_MAX+1 to
> > > disambiguate them.
> > 
> > Mmm ... so what would I use as a mount id that's not used, like
> > NULL
> > for strings?
> 
> Zero is skipped, so you could use that.
> 
> > I'm using -1 now but changing this will mean I need something
> > different.
> 
> It's 64-bits, so you're not likely to see it reach -1, even if it
> does start
> at UINT_MAX+1.

Ha, either or, I don't think it will be a problem, there's
bound to be a few changes so the components using this will
need to change a bit before it's finalized, shouldn't be a
big deal I think. At least not for me and shouldn't be much
for libmount either I think.

Ian

