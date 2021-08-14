Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94943EC155
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHNIJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 04:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNIJz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 04:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E69E60F14;
        Sat, 14 Aug 2021 08:09:24 +0000 (UTC)
Date:   Sat, 14 Aug 2021 10:09:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     ebiederm@xmission.com, linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain
 "locked mounts"
Message-ID: <20210814080922.spcv65hjfak4ermg@wittgenstein>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210813220120.502058-1-mtk.manpages@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 14, 2021 at 12:01:20AM +0200, Michael Kerrisk wrote:
> For a long time, this manual page has had a brief discussion of
> "locked" mounts, without clearly saying what this concept is, or
> why it exists. Expand the discussion with an explanation of what
> locked mounts are, why mounts are locked, and some examples of the
> effect of locking.
> 
> Thanks to Christian Brauner for a lot of help in understanding
> these details.
> 
> Link: https://lore.kernel.org/r/20210813220120.502058-1-mtk.manpages@gmail.com
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
> ---

Looks good. Thank you!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
