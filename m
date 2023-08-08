Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9977443B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjHHSQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHHSPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A851F41F;
        Tue,  8 Aug 2023 10:22:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25D9C68AA6; Tue,  8 Aug 2023 19:22:20 +0200 (CEST)
Date:   Tue, 8 Aug 2023 19:22:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 btrfs_open_devices
Message-ID: <20230808172219.GA17612@lst.de>
References: <0000000000007921d606025b6ad6@google.com> <000000000000094846060260e710@google.com> <20230808-zentimeter-kappen-5da1e70c5535@brauner> <20230808160141.GA15875@lst.de> <20230808-wohnsiedlung-exerzierplatz-02b1257b97a2@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-wohnsiedlung-exerzierplatz-02b1257b97a2@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:35:04PM +0200, Christian Brauner wrote:
> On Tue, Aug 08, 2023 at 06:01:41PM +0200, Christoph Hellwig wrote:
> > Yes, probably.  The lifetimes looked fishy to me to start with, but
> > this might have made things worse.
> 
> It looks like we should be able to just drop that patch.
> Ok, are you fixing this or should I drop this patch?

I plan to fix it, but you can drop it for.  If we want to go on top
drop get_super like the preview series I sent you we'll eventually need
something like this patch back, though.
