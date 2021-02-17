Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9731D786
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 11:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhBQK0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 05:26:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:34684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhBQK0O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:26:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B358FB154;
        Wed, 17 Feb 2021 10:25:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26EC11E0871; Wed, 17 Feb 2021 11:25:31 +0100 (CET)
Date:   Wed, 17 Feb 2021 11:25:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/2] fanotify: configurable limits via sysfs
Message-ID: <20210217102531.GB14758@quack2.suse.cz>
References: <20210124184204.899729-1-amir73il@gmail.com>
 <20210124184204.899729-2-amir73il@gmail.com>
 <20210216162754.GF21108@quack2.suse.cz>
 <CAOQ4uxh8S-sdqtYjJ1naLwokA8M-dVcZJ1Xf4eUCv21Ug2e-BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh8S-sdqtYjJ1naLwokA8M-dVcZJ1Xf4eUCv21Ug2e-BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 20:02:49, Amir Goldstein wrote:
> On Tue, Feb 16, 2021 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
> > Also as a small style nit, please try to stay within 80 columns. Otherwise
> > the patch looks OK to me.
> >
> 
> Ever since discussions that led to:
> bdc48fa11e46 checkpatch/coding-style: deprecate 80-column warning

Yes, I know.

> I've tuned my editor to warn on 100 columns.
> I still try to refrain from long lines, but breaking a ~82 columns line
> in an ugly way is something that I try to avoid.

Well it depends what is in those two columns. I have my terminals exactly
80 columns wide so that I can fit as many of them on the screen as possible
;). So I don't see whatever is beyond column 80. Sometimes it is obvious
enough but sometimes not and if I have to scroll, it isn't ideal.
 
> I'll try harder to stay below 80 when it does not create ugly code,
> unless you absolutely want the patches to fit in 80 columns.

No, I'm not religious about 80 columns. It is really about readability.
E.g. for strings, few characters beyond 80 columns does not really matter.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
