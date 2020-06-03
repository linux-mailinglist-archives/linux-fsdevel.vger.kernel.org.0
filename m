Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDC1ED69D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCTRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:17:45 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE9C08C5C0;
        Wed,  3 Jun 2020 12:17:45 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgYtS-002d77-2u; Wed, 03 Jun 2020 19:17:42 +0000
Date:   Wed, 3 Jun 2020 20:17:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Don.Brace@microchip.com
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, don.brace@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHES] uaccess hpsa
Message-ID: <20200603191742.GW23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529233923.GL23230@ZenIV.linux.org.uk>
 <SN6PR11MB2848F6299FBA22C75DF05218E1880@SN6PR11MB2848.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2848F6299FBA22C75DF05218E1880@SN6PR11MB2848.namprd11.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:37:11PM +0000, Don.Brace@microchip.com wrote:
> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Al Viro
> Sent: Friday, May 29, 2020 6:39 PM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Don Brace <don.brace@microsemi.com>; linux-scsi@vger.kernel.org
> Subject: [PATCHES] uaccess hpsa
> 
>         hpsa compat ioctl done (hopefully) saner.  I really want to kill compat_alloc_user_space() off - it's always trouble and for a driver-private ioctls it's absolutely pointless.
> 
>         The series is in vfs.git #uaccess.hpsa, based at v5.7-rc1
> 
> Al Viro (4):
>       hpsa passthrough: lift {BIG_,}IOCTL_Command_struct copy{in,out} into hpsa_ioctl()
>       hpsa: don't bother with vmalloc for BIG_IOCTL_Command_struct
>       hpsa: get rid of compat_alloc_user_space()
>       hpsa_ioctl(): tidy up a bit
> 
> Acked-by: Don Brace <don.brace@microsemi.com>
> Tested-by: Don Brace <don.brace@microsemi.com>

OK...  Acked-by/Tested-by added, branch re-pushed (commits are otherwise
identical).  Which tree would you prefer that to go through - vfs.git,
scsi.git, something else?
