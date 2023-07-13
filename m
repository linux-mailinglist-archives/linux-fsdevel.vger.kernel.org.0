Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0D7516EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjGMDwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMDwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:52:12 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [IPv6:2001:41d0:203:375::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E61991
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 20:52:10 -0700 (PDT)
Date:   Wed, 12 Jul 2023 23:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689220328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhk+LWYZuFsg6MH/5PRvcr3hByEuKg0581vbBlxGO2s=;
        b=dQwZB55t2fV59oSEfoIzUoMl+9yFN2LZ/pgaPSjB10ZI5CUQGmF781qe/lVoS4zUfJKmSz
        VR2uImR/wNmcSvPdGliEBGIuF4V2Ps+AjAAKsVYaVt3FZ11BWKZDmWvzHOekFBR0KGGG5B
        eXS8Dtce+MDyhb90doooWkusAe+3eAc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Subject: Re: [PATCH 12/20] bcache: move closures to lib/
Message-ID: <20230713035204.xmaddzcdjgj3kqjw@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-13-kent.overstreet@linux.dev>
 <670a325f-f066-d146-f738-e5db1ca029ee@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670a325f-f066-d146-f738-e5db1ca029ee@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:21:05PM -0700, Randy Dunlap wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > +	depends on CLOSURES
> > +	select DEBUG_FS
> > +	help
> > +	Keeps all active closures in a linked list and provides a debugfs
> > +	interface to list them, which makes it possible to see asynchronous
> > +	operations that get stuck.
> 
> Indent those 3 help text lines with 2 additional spaces, please,
> as documented and as is done in (most of) the rest of this file.
> 
> With those fixed:
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Ack
