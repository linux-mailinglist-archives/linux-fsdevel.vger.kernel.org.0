Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044EF1AAEAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410414AbgDOQrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:47:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:45400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416270AbgDOQrH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:47:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E2BAABD1;
        Wed, 15 Apr 2020 16:47:05 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:47:02 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Hyunchul Lee' <hyc.lee@gmail.com>,
        'Eric Sandeen' <sandeen@sandeen.net>
Subject: Re: [ANNOUNCE] exfat-utils-1.0.1 initial version released
Message-ID: <20200415164702.xf3t2stjpkjl6das@fiona>
References: <CGME20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295@epcas1p4.samsung.com>
 <001201d60e12$8454abb0$8cfe0310$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d60e12$8454abb0$8cfe0310$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 10:59 09/04, Namjae Jeon wrote:
> The initial version(1.0.1) of exfat-utils is now available.
> This is the official userspace utilities for exfat filesystem of
> linux-kernel.

For the sake of sanity of the distributions which already carry
exfat-utils based on fuse (https://github.com/relan/exfat), would it be
possible to either change the name of the project to say exfat-progs or
increase the version number to beyond 1.4?

exfat-progs is more in line with xfsprogs, btrfsprogs or e2fsprogs :)

-- 
Goldwyn
