Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF31310BBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 14:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBENYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 08:24:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:60312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhBENV6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:21:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4436ACD4;
        Fri,  5 Feb 2021 13:21:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 667F4DA6E9; Fri,  5 Feb 2021 14:19:10 +0100 (CET)
Date:   Fri, 5 Feb 2021 14:19:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs/efs: Follow kernel style guide
Message-ID: <20210205131910.GJ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Amy Parker <enbyamy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205045217.552927-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205045217.552927-1-enbyamy@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 08:52:14PM -0800, Amy Parker wrote:
> As the EFS driver is old and non-maintained,

Is anybody using EFS on current kernels? There's not much point updating
it to current coding style, deleting fs/efs is probably the best option.

The EFS name is common for several filesystems, not to be confused with
eg.  Encrypted File System. In linux it's the IRIX version, check
Kconfig, and you could hardly find the utilities to create such
filesystem.
