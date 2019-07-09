Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDB639AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIQqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:46:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52216 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfGIQqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:46:19 -0400
Received: from callcc.thunk.org ([199.116.118.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x69Gk3nw014432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Jul 2019 12:46:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EDC7742002E; Tue,  9 Jul 2019 12:46:02 -0400 (EDT)
Date:   Tue, 9 Jul 2019 12:46:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: Re: exfat filesystem
Message-ID: <20190709164602.GA8127@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com,
        Sasha Levin <sashal@kernel.org>
References: <21080.1562632662@turing-police>
 <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
 <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 08:48:34AM -0700, Matthew Wilcox wrote:
> 
> Interesting analysis.  It seems to me that the correct forms would be
> observed if someone suitably senior at Microsoft accepted the work from
> Valdis and submitted it with their sign-off.  KY, how about it?

It might be that the simplest way to do this is just to have someone
from Microsoft send the pull request (with a signed tag) to Linus.
There are any number ways to arrange this but the PGP-signed tag might
be sufficient.  Alternatively, some kind of declaration from a
Microsoft lawyer to OIN might be sufficient.  This is where asking the
LF if they can bring together a meeting of the minds of LF, OIN, and
Microsoft lawyers might make things much easier.

						- Ted
