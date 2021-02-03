Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58830D5D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhBCJFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 04:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhBCJEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:04:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6566D64F6C;
        Wed,  3 Feb 2021 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612343049;
        bh=dose+0ib77aWrtl0UBLIjf+G+tsVPcA/kSlPAgriyoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZllJEt1adPsuVtJA583pG/4Bf/bITj56J2fFSbdEeh89KWnvv3zcRutVZiLZYoCVY
         1PWtaEcS9zjatbxvtoMgHrYZ6yRgcWDcLxh6Zzrn/C45HG2hTvLCckYUe5hUNqv3hV
         TQ9YN8ZcW7N8dg2aCVtVyVKMpPhoUcRR9gF6vXFo=
Date:   Wed, 3 Feb 2021 10:04:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>, iant@google.com
Subject: Re: [BUG] copy_file_range with sysfs file as input
Message-ID: <YBpnBUD+QoMW9NtL@kroah.com>
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> Hi copy_file_range experts,
> 
> We hit this interesting issue when upgrading Go compiler from 1.13 to
> 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> `/sys/kernel/debug/tracing/trace` to a temporary file.

Nit, the above file is NOT a sysfs file.  Odds are it is either a
debugfs, or a tracefs file, please check your mounts to determine which
it is, as that matters a lot on the kernel backend side for trying to
figure out what is going on here :)

thanks,

greg k-h
