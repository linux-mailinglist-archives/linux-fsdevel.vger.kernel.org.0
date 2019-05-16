Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329FD20704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEPMdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:33:37 -0400
Received: from verein.lst.de ([213.95.11.211]:59114 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfEPMdh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:33:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE4A868B05; Thu, 16 May 2019 14:33:15 +0200 (CEST)
Date:   Thu, 16 May 2019 14:33:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 11/14] fsnotify: call fsnotify_rmdir() hook from
 configfs
Message-ID: <20190516123315.GA16889@lst.de>
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-12-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516102641.6574-12-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 01:26:38PM +0300, Amir Goldstein wrote:
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().

This seems to be missing 13 patches of context without it isn't
reviewable.  If you decide to Cc someone either make sure they get all
the patches or just don't bother to start with.
