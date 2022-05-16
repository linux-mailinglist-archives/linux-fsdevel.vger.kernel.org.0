Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE25F528B16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiEPQyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiEPQyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95427B33;
        Mon, 16 May 2022 09:54:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 575A968AA6; Mon, 16 May 2022 18:53:58 +0200 (CEST)
Date:   Mon, 16 May 2022 18:53:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Krzysztof =?utf-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: relicense to GPLv2 only
Message-ID: <20220516165358.GA23039@lst.de>
References: <20220516133825.2810911-1-hch@lst.de> <1652713968.3497.416.camel@sysmikro.com.pl> <YoKA4AhEXF4tEVlZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YoKA4AhEXF4tEVlZ@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 06:50:40PM +0200, Greg KH wrote:
> On Mon, May 16, 2022 at 05:12:48PM +0200, Krzysztof Błaszkowski wrote:
> > Acked-by: Krzysztof Błaszkowski <kb@sysmikro.com.pl>
> 
> Thanks!
> 
> Christoph, want me to take this through my spdx.git tree, or are you
> going to take it through some vfs tree?

The spdx tree sounds good to me.
