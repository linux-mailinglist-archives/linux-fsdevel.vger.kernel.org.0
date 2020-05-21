Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354171DD476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEURcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgEURcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 13:32:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BBC061A0E;
        Thu, 21 May 2020 10:32:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbp33-00D3M5-H2; Thu, 21 May 2020 17:32:01 +0000
Date:   Thu, 21 May 2020 18:32:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
Message-ID: <20200521173201.GG23230@ZenIV.linux.org.uk>
References: <20200521122034.2254-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521122034.2254-1-namjae.jeon@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 09:20:34PM +0900, Namjae Jeon wrote:
> As Ubuntu and Fedora release new version used kernel version equal to or
> higher than v5.4, They started to support kernel exfat filesystem.
> 
> Linus Torvalds reported mount error with new version of exfat on Fedora.
> 
> 	exfat: Unknown parameter 'namecase'
> 
> This is because there is a difference in mount option between old
> staging/exfat and new exfat.
> And utf8, debug, and codepage options as well as namecase have been
> removed from new exfat.
> 
> This patch add the dummy mount options as deprecated option to be backward
> compatible with old one.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>

Do you want that to go via vfs.git #fixes, or would you rather have Linus
apply it straight to mainline?
