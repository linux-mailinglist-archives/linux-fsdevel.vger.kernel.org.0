Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9223F5996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhHXIDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 04:03:50 -0400
Received: from verein.lst.de ([213.95.11.211]:50673 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhHXIDt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:03:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6D9767373; Tue, 24 Aug 2021 10:03:02 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:03:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Message-ID: <20210824080302.GC26733@lst.de>
References: <20210819002633.689831-1-kari.argillander@gmail.com> <20210819002633.689831-4-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-4-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	/*
> +	 * TODO: We should probably check some mount options does
> +	 * they all work after remount. Example can we really change
> +	 * nls. Remove this comment when all testing is done or
> +	 * even better xfstest is made for it.
> +	 */

Instead of the TODO I would suggest a prep patch to drop changing of
any options in remount before this one and then only add them back
as needed and tested.

The mechanics of the conversion look good to me.
