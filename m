Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6612F43AD76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJZHrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:47:37 -0400
Received: from verein.lst.de ([213.95.11.211]:60790 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhJZHrf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:47:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C3906732D; Tue, 26 Oct 2021 09:45:09 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:45:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/11] unicode: Add utf8-data module
Message-ID: <20211026074509.GA594@lst.de>
References: <20210915070006.954653-1-hch@lst.de> <20210915070006.954653-11-hch@lst.de> <87wnmipjrw.fsf@collabora.com> <20211012124904.GB9518@lst.de> <87sfx6papz.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfx6papz.fsf@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:40:56AM -0300, Gabriel Krisman Bertazi wrote:
> > Does this fix it?
> 
> Yes, it does.
> 
> I  will fold this into the original patch and queue this series for 5.16.

This series still doesn't seem to be queued up.
