Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7D399CE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFCIpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 04:45:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCIpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:45:10 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3BF0B1FD4D;
        Thu,  3 Jun 2021 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622709805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELnKKz0+YVWYJ7VvosZlvotDsRWzrVe+LH1Y4DNaxzg=;
        b=U3KOueh0zJApA/W05EWokttiRW+E9xLbQqKnavasQ0MAEmSS+weh06c3Cy+E+Icv3fmzNG
        CoX61cOFp4skQO0A0TOAvWrNH01n6PVZpY0d2TdSyAitK390SH3Xmj7KuUdObt/+GaGVEY
        WzmvLghD3XZWfHEBETStly3UueU/YDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622709805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELnKKz0+YVWYJ7VvosZlvotDsRWzrVe+LH1Y4DNaxzg=;
        b=eOzAoHDppsFTa2f4/wqILv4EEwrmCowNhDuxL8YyOfNOYqKmS5XwEbK+1weeKdgxkN5y/c
        wqye3OXeJBGA8kBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1448FA3B88;
        Thu,  3 Jun 2021 08:43:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E4E3E1F2C98; Thu,  3 Jun 2021 10:43:24 +0200 (CEST)
Date:   Thu, 3 Jun 2021 10:43:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [fanotify] a8b98c808e: stress-ng.fanotify.ops_per_sec 32.2%
 improvement
Message-ID: <20210603084324.GC23647@quack2.suse.cz>
References: <20210603015314.GA21290@xsang-OptiPlex-9020>
 <CAOQ4uxjdtfriARxh_CiTxFi8=T6j065HtbJGnuAas7oyPNADKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjdtfriARxh_CiTxFi8=T6j065HtbJGnuAas7oyPNADKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 09:57:15, Amir Goldstein wrote:
> On Thu, Jun 3, 2021 at 4:36 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed a 32.2% improvement of stress-ng.fanotify.ops_per_sec due to commit:
> >
> >
> > commit: a8b98c808eab3ec8f1b5a64be967b0f4af4cae43 ("fanotify: fix permission model of unprivileged group")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> 
> I guess now we know what caused the reported regression:
> https://lore.kernel.org/lkml/20210511124632.GL24154@quack2.suse.cz/
> 
> I didn't know that capable() is so significant.

Yeah, I wouldn't guess either. Interesting.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
