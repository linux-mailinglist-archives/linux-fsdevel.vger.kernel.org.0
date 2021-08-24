Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B63F5911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 09:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHXHfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 03:35:08 -0400
Received: from verein.lst.de ([213.95.11.211]:50571 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234817AbhHXHfE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:35:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B37B67373; Tue, 24 Aug 2021 09:34:19 +0200 (CEST)
Date:   Tue, 24 Aug 2021 09:34:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple to
 utf8_load
Message-ID: <20210824073418.GA25209@lst.de>
References: <20210818140651.17181-1-hch@lst.de> <20210818140651.17181-6-hch@lst.de> <87tujg19wj.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tujg19wj.fsf@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:02:52AM -0400, Gabriel Krisman Bertazi wrote:
> I remember this fallback was specifically requested during a review or
> in a discussion, but I honestly cannot remember the reason.
> 
> One advantage I can think is if we have a filesystem that requires a
> newer unicode version than the current kernel has, and strict mode flag
> is set, we can fallback to the latest version and still mount the fs
> read/write.

Well, that seems a little pointless.  If we add such a file system
we can just upgrade the unіcode data files.  (FYI, I did an upgrade
to 1.13 to test this series, but without any file system that needs
it I did not bother to submit the patch).
