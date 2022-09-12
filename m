Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66D05B5BCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiILOCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiILOCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:02:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26931DF7;
        Mon, 12 Sep 2022 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55620B80D55;
        Mon, 12 Sep 2022 14:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12BDC433D7;
        Mon, 12 Sep 2022 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662991350;
        bh=CJr3xwvNDLqpU75iwXI4nimkb371IeI9yF6/g36e4xc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N1nOlaRpf2JgDjhUFohphJn0WEbiK2kjJ26VaR9g4S5wHF2HOFtBsFk/2T0nXBph7
         77ibhHYqpi3L6XnjzmPh//mHS2Lg5SslT7sj+yslZc8YFPDPcjTumTUL2w9WPW7OFR
         ftYUFI2lqrKbP35Bn4c5rnjobP2zddXr4QSR+0gCoI10pBxFj5bhOK+kISSJ0GCcM/
         +TKchp8rwoV4O9RbRNkPOrt/vl3g9S4zAofpbEG5hLuuh0hQKYt2c6vJkPZWnOv2Yq
         qsuylp4XPZcB4gkt7uTDSyigrW6sr28/mZGFZTJai5QQu7GOvbQT8p5m5xgzm4NEvW
         kfXn2hX9ZIvGQ==
Message-ID: <1abae98579030d437224ae24f73fffaabb3f64c1.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Florian Weimer <fweimer@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 10:02:27 -0400
In-Reply-To: <20220912135131.GC9304@fieldses.org>
References: <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <87a67423la.fsf@oldenburg.str.redhat.com>
         <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
         <20220912135131.GC9304@fieldses.org>
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

On Mon, 2022-09-12 at 09:51 -0400, J. Bruce Fields wrote:
> On Mon, Sep 12, 2022 at 08:55:04AM -0400, Jeff Layton wrote:
> > Because of the "seen" flag, we have a 63 bit counter to play with. Coul=
d
> > we use a similar scheme to the one we use to handle when "jiffies"
> > wraps?=A0Assume that we'd never compare two values that were more than
> > 2^62 apart? We could add i_version_before/i_version_after macros to mak=
e
> > it simple to handle this.
>=20
> As far as I recall the protocol just assumes it can never wrap.  I guess
> you could add a new change_attr_type that works the way you describe.
> But without some new protocol clients aren't going to know what to do
> with a change attribute that wraps.
>=20

Right, I think that's the case now, and with contemporary hardware that
shouldn't ever happen, but in 10 years when we're looking at femtosecond
latencies, could this be different? I don't know.

> I think this just needs to be designed so that wrapping is impossible in
> any realistic scenario.  I feel like that's doable?
>=20
> If we feel we have to catch that case, the only 100% correct behavior
> would probably be to make the filesystem readonly.

What would be the recourse at that point? Rebuild the fs from scratch, I
guess?
--=20
Jeff Layton <jlayton@kernel.org>
