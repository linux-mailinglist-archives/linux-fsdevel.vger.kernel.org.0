Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F82518CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHYMqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYMp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:45:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 05:45:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAYKl-004UF7-Dr; Tue, 25 Aug 2020 12:45:51 +0000
Date:   Tue, 25 Aug 2020 13:45:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vboxsf: Fix the check for the old binary mount-arguments
 struct
Message-ID: <20200825124551.GX1236603@ZenIV.linux.org.uk>
References: <20200825111257.125385-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825111257.125385-1-hdegoede@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:12:57PM +0200, Hans de Goede wrote:
> Fix the check for the mainline vboxsf code being used with the old
> mount.vboxsf mount binary from the out-of-tree vboxsf version doing
> a comparison between signed and unsigned data types.
> 
> This fixes the following smatch warnings:
> 
> fs/vboxsf/super.c:390 vboxsf_parse_monolithic() warn: impossible condition '(options[1] == (255)) => ((-128)-127 == 255)'
> fs/vboxsf/super.c:391 vboxsf_parse_monolithic() warn: impossible condition '(options[2] == (254)) => ((-128)-127 == 254)'
> fs/vboxsf/super.c:392 vboxsf_parse_monolithic() warn: impossible condition '(options[3] == (253)) => ((-128)-127 == 253)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  fs/vboxsf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.
