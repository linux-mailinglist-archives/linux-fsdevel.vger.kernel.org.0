Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60B5B8785
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiINLvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINLvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941377540;
        Wed, 14 Sep 2022 04:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D859B61C1E;
        Wed, 14 Sep 2022 11:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A191C433D7;
        Wed, 14 Sep 2022 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663156280;
        bh=X6kiqA3vAvyzSls3/AgVE2v/FEsxYi7tj84qKsyADRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uJa0v9qeHwb8WVGx+Pmyq1IzVgQKGgEg/HVaKyYqi96uBhi47IDhEKa1x4Ul1y0mH
         /w90TOMFwH8kX9giXvz3W7flfTWbaM/Q/B5u1FqNrs4/7m5vC5BEULUm6DShkSly67
         R4FDaE8yKtWgRjMSHxFLOtV0ClClIS3Za4N0HVNMlYGwsaCBuyHg+x7bZb6huOD/AZ
         +tCl7Au0A3qvfkB7e2I85bZG1RfS02XFGZrPXuvukiTg61tOt/3PRMn8l3KuDmd0yW
         6EJnF4409xTaQzTOH2UpI4g9rYBZ9RZnaoTzMRSsuBl8UEr5bjmRE/e9vXQhQoG0+U
         8NgmKnbtCRvmw==
Message-ID: <f8a41b55efd1c59bc63950e8c1b734626d970a90.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Wed, 14 Sep 2022 07:51:16 -0400
In-Reply-To: <166311144203.20483.1888757883086697314@noble.neil.brown.name>
References: <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
        , <166268467103.30452.1687952324107257676@noble.neil.brown.name>
        , <166268566751.30452.13562507405746100242@noble.neil.brown.name>
        , <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
        , <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
        , <166270570118.30452.16939807179630112340@noble.neil.brown.name>
        , <33d058be862ccc0ccaf959f2841a7e506e51fd1f.camel@kernel.org>
        , <166285038617.30452.11636397081493278357@noble.neil.brown.name>
        , <2e34a7d4e1a3474d80ee0402ed3bc0f18792443a.camel@kernel.org>
        , <166302538820.30452.7783524836504548113@noble.neil.brown.name>
        , <20220913011518.GE3600936@dread.disaster.area>
        , <b67fe8b26977dc1213deb5ec815a53a26d31fbc0.camel@kernel.org>
         <166311144203.20483.1888757883086697314@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-09-14 at 09:24 +1000, NeilBrown wrote:
> On Wed, 14 Sep 2022, Jeff Layton wrote:
> >=20
> > At that point, bumping i_version both before and after makes a bit more
> > sense, since it better ensures that a change will be noticed, whether
> > the related read op comes before or after the statx.
>=20
> How does bumping it before make any sense at all?  Maybe it wouldn't
> hurt much, but how does it help anyone at all?
>=20

My assumption (maybe wrong) was that timestamp updates were done before
the actual write by design. Does doing it before the write make increase
the chances that the inode metadata writeout will get done in the same
physical I/O as the data write? IDK, just speculating here.

If there's no benefit to doing it before then we should just move it
afterward.


>   i_version must appear to change no sooner than the change it reflects
>   becomes visible and no later than the request which initiated that
>   change is acknowledged as complete.
>=20
> Why would that definition ever not be satisfactory?

It's fine with me.
--=20
Jeff Layton <jlayton@kernel.org>
