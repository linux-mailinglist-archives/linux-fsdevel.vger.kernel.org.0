Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0196AE2C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfJXIhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 04:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbfJXIhS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83576B36C;
        Thu, 24 Oct 2019 08:37:16 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:37:15 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yong Sun <yosun@suse.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: "New" ext4 features tests in LTP
Message-ID: <20191024083713.GB13520@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20191023155846.GA28604@dell5510>
 <20191023225824.GB7630@mit.edu>
 <20191024074619.GI31271@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024074619.GI31271@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted, Jan,

> Yeah, I believe this may be useful to implement in fstests in some fs
> agnostic way.
Thank you both for reviewing LTP tests.

> > > ext4-nsec-timestamps [6]
> > > --------------------
> > > Directory containing the shell script which is used to test nanosec timestamps
> > > of ext4.

> > This basically tests that the file system supports nanosecond
> > timestamps, with a 0.3% false positive failure rate.   Again, why?

> > > ext4-subdir-limit [9]
> > > -----------------
> > > Directory containing the shell script which is used to test subdirectory limit
> > > of ext4. According to the kernel documentation, we create more than 32000
> > > subdirectorys on the ext4 filesystem.

> > This is a valid test, although it's not what I would call a "high
> > value" test.  (As in, it's testing maybe a total of four simple lines
> > of code that are highly unlikely to fail.)

> These two may be IMHO worth carrying over to fstests in some form. The other
> tests seem either already present in various fstests configs we run or
> pointless as Ted wrote.
As Sero already volunteered to contribute them to fstests (thanks Sero!),
I'll send a patch to delete them from LTP.

> 								Honza

Kind regards,
Petr
