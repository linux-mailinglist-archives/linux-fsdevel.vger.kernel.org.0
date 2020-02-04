Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903511515AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 07:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgBDGG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 01:06:57 -0500
Received: from verein.lst.de ([213.95.11.211]:59366 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgBDGG4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:06:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB75B68BFE; Tue,  4 Feb 2020 07:06:54 +0100 (CET)
Date:   Tue, 4 Feb 2020 07:06:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <linkinjeon@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hch@lst.de, sj1557.seo@samsung.com, pali.rohar@gmail.com,
        arnd@arndb.de, namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] exfat: update file system parameter handling
Message-ID: <20200204060654.GB31675@lst.de>
References: <297144.1580786668@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297144.1580786668@turing-police>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:24:28PM -0500, Valdis Klētnieks wrote:
> Al Viro recently reworked the way file system parameters are handled
> Update super.c to work with it in linux-next 20200203.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
