Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAC1ACCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfELPbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 11:31:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52230 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfELPbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 11:31:24 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 73CE5200611;
        Sun, 12 May 2019 15:31:22 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 3642120920; Sun, 12 May 2019 17:31:05 +0200 (CEST)
Date:   Sun, 12 May 2019 17:31:05 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     hpa@zytor.com, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190512153105.GA25254@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557665567.10635.222.camel@linux.ibm.com>
 <4E92753A-04BD-4018-A3A4-5E3E4242D8B9@zytor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 12, 2019 at 03:18:16AM -0700, hpa@zytor.com wrote:
> > Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> > be done equivalently by the initramfs' /init? Why is kernel involvement
> > actually required here?
> 
> There are a lot of things that could/should be done that way...

Indeed... so why not try to avoid adding more such "things", and keeping
them in userspace (or in a fork_usermode_blob)?


On Sun, May 12, 2019 at 08:52:47AM -0400, Mimi Zohar wrote:
> It's too late.  The /init itself should be signed and verified.

Could you elaborate a bit more about the threat model, and why deferring
this to the initramfs is too late?

Thanks,
	Dominik
