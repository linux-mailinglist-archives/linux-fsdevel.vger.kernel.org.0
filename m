Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232063ED3E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhHPM14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:27:56 -0400
Received: from verein.lst.de ([213.95.11.211]:54220 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhHPM1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:27:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3DE96736F; Mon, 16 Aug 2021 14:27:21 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:27:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: your mail
Message-ID: <20210816122721.GA17355@lst.de>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-1-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:46:59AM +0300, Kari Argillander wrote:
> I would like really like to get fsparam_flag_no also for no_acs_rules
> but then we have to make new name for it. Other possibility is to
> modify mount api so it mount option can be no/no_. I think that would
> maybe be good change. 

I don't think adding another no_ alias is a good idea.  I'd suggest
to just rename the existing flag before the ntfs3 driver ever hits
mainline.
