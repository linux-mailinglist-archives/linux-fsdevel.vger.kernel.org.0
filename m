Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3D103D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEACO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 22:14:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54844 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfEACO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 22:14:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLelL-0004OG-Oy; Wed, 01 May 2019 02:14:23 +0000
Date:   Wed, 1 May 2019 03:14:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190501021423.GQ23075@ZenIV.linux.org.uk>
References: <20190411231630.50177-1-ebiggers@kernel.org>
 <20190422180346.GA22674@gmail.com>
 <20190501002517.GF48973@gmail.com>
 <20190501013649.GO23075@ZenIV.linux.org.uk>
 <20190430194943.4a7916be@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430194943.4a7916be@lwn.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 07:49:43PM -0600, Jonathan Corbet wrote:
> On Wed, 1 May 2019 02:36:49 +0100
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Thought I'd replied; apparently not...  Anyway, the problem with those
> > is that there'd been a series of patches converting vfs.txt to new
> > format; I'm not sure what Jon is going to do with it, but these are
> > certain to conflict.  I've no objections to the contents of changes,
> > but if that stuff is getting massive reformatting the first two
> > probably ought to go through Jon's tree.  I can take the last two
> > at any point.
> > 
> > Jon, what's the status of the format conversion?
> 
> Last I saw, it seemed that you wanted changes in how things were done and
> that Tobin (added to CC) had stepped back.  Tobin, are your thoughts on
> the matter different?  I could try to shoehorn them in for 5.2 still, I
> guess, but perhaps the best thing to do is to just take Eric's patch, and
> the reformatting can work around it if need be.

I can certainly apply Eric's series (or ACK it if we end up deciding to
feed it through your tree).

Rereading my replies in that thread, I hadn't been clear back then and
I can see how that could've been created the wrong impression. 

I do have problems with vfs.txt approach in general and I hope we end up
with per object type documents; however, that's completely orthogonal to
format conversion.  IOW, I have no objections whatsoever to format switch
done first; any migration of e.g. dentry-related parts into a separate
document, with lifecycle explicitly documented and descriptions of
methods tied to that can just as well go on top of that.

I don't think that vfs.txt will survive in recognizable form in the long
run, but by all means, let's get the format conversion out of the way
first.  And bits and pieces of contents will survive in the replacement
files when those appear.
