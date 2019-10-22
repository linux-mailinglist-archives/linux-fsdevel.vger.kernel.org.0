Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A966DDFCC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 06:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfJVEe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 00:34:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJVEe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:34:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMlsh-0008Bu-VQ; Tue, 22 Oct 2019 04:34:52 +0000
Date:   Tue, 22 Oct 2019 05:34:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 11/43] compat_ioctl: move drivers to compat_ptr_ioctl
Message-ID: <20191022043451.GB20354@ZenIV.linux.org.uk>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009191044.308087-11-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:10:11PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.

I'd rather flipped your #7 (ceph_compat_ioctl() introduction) past
that one...
