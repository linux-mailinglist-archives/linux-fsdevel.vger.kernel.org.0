Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5803ED7EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 04:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfKDDBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 22:01:33 -0500
Received: from fieldses.org ([173.255.197.46]:59146 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfKDDBc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 22:01:32 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 3ECB71C19; Sun,  3 Nov 2019 22:01:32 -0500 (EST)
Date:   Sun, 3 Nov 2019 22:01:32 -0500
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
Message-ID: <20191104030132.GD26578@fieldses.org>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:55:09PM -0400, Chuck Lever wrote:
> > On Oct 24, 2019, at 7:15 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> > I think both of these are cases of being careful. E.g. don't enable
> > something by default and allow it to be disabled at runtime in
> > case something goes terribly wrong.
> > 
> > I didn't have any other reasons, really. I'm happy do to away with
> > the CONFIG options if that's the consensus, as well as the
> > nouser_xattr export option.
> 
> I have similar patches adding support for access to a couple of
> security xattrs. I initially wrapped the new code with CONFIG
> but after some discussion it was decided there was really no
> need to be so cautious.
> 
> The user_xattr export option is a separate matter, but again,
> if we don't know of a use case for it, I would leave it out for
> the moment.

Agreed.

Do ext4, xfs, etc. have an option to turn off xattrs?  If so, maybe it
would be good enough to turn off xattrs on the exported filesystem
rathre than on the export.

If not, maybe that's a sign that hasn't been a need.

--b.
