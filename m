Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DFA1DDFFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgEVGfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 02:35:55 -0400
Received: from verein.lst.de ([213.95.11.211]:57882 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVGfz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 02:35:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D91668C4E; Fri, 22 May 2020 08:35:52 +0200 (CEST)
Date:   Fri, 22 May 2020 08:35:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        adilger@dilger.ca, Ritesh Harjani <riteshh@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
Message-ID: <20200522063552.GA2392@lst.de>
References: <20200505154324.3226743-1-hch@lst.de> <20200507062419.GA5766@lst.de> <20200507144947.GJ404484@mit.edu> <20200519080459.GA26074@lst.de> <20200520032837.GA2744481@mit.edu> <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 05:00:45PM -0700, Linus Torvalds wrote:
> Ted's pull request got merged today, for anybody wondering..
> 
> Christoph, can you verify that everything looks good?

Looks good to me, thanks.
