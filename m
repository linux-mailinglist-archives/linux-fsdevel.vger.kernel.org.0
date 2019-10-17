Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85105DB066
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 16:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502988AbfJQOsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 10:48:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56548 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502979AbfJQOsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:48:21 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HEm8RO011183
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 10:48:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B88F3420458; Thu, 17 Oct 2019 10:48:08 -0400 (EDT)
Date:   Thu, 17 Oct 2019 10:48:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH v2] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191017144808.GJ25548@mit.edu>
References: <20191016051101.12620-1-david@fromorbit.com>
 <20191016060604.GH16973@dread.disaster.area>
 <20191017122911.GC25548@mit.edu>
 <20191017141705.GA31558@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017141705.GA31558@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:17:05AM -0700, Christoph Hellwig wrote:
> > 
> > Ext4 is not currently using iomap for any kind of writing right now,
> > so perhaps this should land via Matthew's patchset?
> 
> It does for DAX, which is one of the consumers of IOMAP_F_DIRTY.

Ah, right, I had forgotten about DAX.

					- Ted
