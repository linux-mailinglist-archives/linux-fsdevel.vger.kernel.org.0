Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7031C796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBPItK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:49:10 -0500
Received: from verein.lst.de ([213.95.11.211]:40382 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhBPItI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:49:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2302E6736F; Tue, 16 Feb 2021 09:48:26 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:48:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David P . Quigley" <dpquigl@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH -next] fs: libfs: fix kernel-doc for mnt_userns
Message-ID: <20210216084825.GA23845@lst.de>
References: <20210216042929.8931-1-rdunlap@infradead.org> <20210216042929.8931-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216042929.8931-2-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 08:29:27PM -0800, Randy Dunlap wrote:
> Fix kernel-doc warning in libfs.c.
> 
> ../fs/libfs.c:498: warning: Function parameter or member 'mnt_userns' not described in 'simple_setattr'

Shouldn't the subject say simple_setattr instead of mnt_userns?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
