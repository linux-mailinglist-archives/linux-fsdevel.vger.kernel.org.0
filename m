Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100608DC20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHNRqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 13:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfHNRqF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:46:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6031AAB2;
        Wed, 14 Aug 2019 17:46:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A3DAB1E4200; Wed, 14 Aug 2019 19:46:04 +0200 (CEST)
Date:   Wed, 14 Aug 2019 19:46:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Deprecated mandatory file locking
Message-ID: <20190814174604.GC10843@quack2.suse.cz>
References: <20190814173345.GB10843@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814173345.GB10843@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Resending to proper Jeff's address...

On Wed 14-08-19 19:33:45, Jan Kara wrote:
> Hello Jeff,
> 
> we've got a report from user
> (https://bugzilla.suse.com/show_bug.cgi?id=1145007) wondering why his fstab
> entry (for root filesystem!) using 'mand' mount option stopped working.
> Now I understand your rationale in 9e8925b67a "locks: Allow disabling
> mandatory locking at compile time" but I guess there's some work to do wrt
> documentation. At least mount(8) manpage could mention that mandatory
> locking is broken and may be disabled referencing the rationale in fcntl
> manpage? Or the kernel could mention something in the log about failing
> mount because of 'mand' mount option?  What do you think? Because it took
> me some code searching to understand why the mount is actually failing
> which we can hardly expect from a normal sysadmin...
> 
> 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
