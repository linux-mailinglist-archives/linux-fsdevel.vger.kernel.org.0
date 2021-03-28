Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6434BE2B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhC1SJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhC1SId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 14:08:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58095C061756;
        Sun, 28 Mar 2021 11:08:33 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQZpw-000UWX-Bl; Sun, 28 Mar 2021 18:08:32 +0000
Date:   Sun, 28 Mar 2021 18:08:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/18] ovl: stack fileattr ops
Message-ID: <YGDGICWI6o+1zhPI@zeniv-ca.linux.org.uk>
References: <20210325193755.294925-1-mszeredi@redhat.com>
 <20210325193755.294925-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325193755.294925-4-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:37:40PM +0100, Miklos Szeredi wrote:
> Add stacking for the fileattr operations.
> 
> Add hack for calling security_file_ioctl() for now.  Probably better to
> have a pair of specific hooks for these operations.

Umm...  Shouldn't you remove the old code from their ->ioctl() instance?
