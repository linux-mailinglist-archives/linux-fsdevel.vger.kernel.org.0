Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391D51AB73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfELJRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 05:17:51 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35594 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfELJRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 05:17:51 -0400
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id D43142005B3; Sun, 12 May 2019 09:17:48 +0000 (UTC)
Date:   Sun, 12 May 2019 11:17:48 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190512091748.s6fvy2f5p2a2o6ja@isilmar-4.linta.de>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> This proposal consists in marshaling pathnames and xattrs in a file called
> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> been extracted.

Couldn't this parsing of the .xattr-list file and the setting of the xattrs
be done equivalently by the initramfs' /init? Why is kernel involvement
actually required here?

Thanks,
	Dominik
