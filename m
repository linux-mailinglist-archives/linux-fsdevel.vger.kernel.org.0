Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EAE1C8274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGGYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 02:24:22 -0400
Received: from verein.lst.de ([213.95.11.211]:44796 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGGYW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 02:24:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6674368B05; Thu,  7 May 2020 08:24:19 +0200 (CEST)
Date:   Thu, 7 May 2020 08:24:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, tytso@mit.edu
Cc:     jack@suse.cz, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
Message-ID: <20200507062419.GA5766@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 05:43:13PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the first two patches should fix the issue where ext4 doesn't
> properly check the max file size for bitmap files in fiemap.
> 
> The rest cleans up the fiemap support in ext4 and in general.

Folks, I think the first two patches should go into 5.7 to fix the
ext4 vs overlay problem.  Ted, are you going to pick this up, or Al?

The rest should be ready for 5.8 once the fixes hit mainline.
