Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0857D3D8888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhG1HGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 03:06:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhG1HGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:06:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4C0D20184;
        Wed, 28 Jul 2021 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627456006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfT1RNigMB0X8lNElLJC52DFJE8CZLB1bbjI9jWvyrE=;
        b=ppUYBNGdBKxOuntHL4e7tIFcFojxVgLKKOAo1un/XFpAk9RVMGiBwSVpgjXOn1Cl6jwuU7
        e06lNuLOCC4hT1/Y3TBOfDtvK7aUihpcvreAvsVomKzBaIgGcQpV6L3ml5wWMiOoJtWupw
        XmFMFEKpbutupWr1J1IprhJFUTr5iMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627456006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfT1RNigMB0X8lNElLJC52DFJE8CZLB1bbjI9jWvyrE=;
        b=NGQILfQ9RzmQm4xmwiR3jccC3Kg+aFC+LBztvbWmprJY+7W9aw13two/AVXbC2wYydy3Bb
        YX9gfDrCecLGjgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FC413B1B;
        Wed, 28 Jul 2021 07:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6/5fCwMCAWF+TwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 07:06:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <20210728125819.6E52.409509F4@e16-tech.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>
Date:   Wed, 28 Jul 2021 17:06:40 +1000
Message-id: <162745600062.21659.13334440659372332769@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, Wang Yugui wrote:
> Hi,
> 
> We no longer need the dummy inode(BTRFS_FIRST_FREE_OBJECTID - 1) in this
> patch serials?

No.

> 
> I tried to backport it to 5.10.x, but it failed to work.
> No big modification in this 5.10.x backporting, and all modified pathes
> are attached.

I'm not surprised, but I doubt there would be a major barrier to making
it work.  I'm unlikely to try until I have more positive reviews.

Thanks,
NeilBrown
