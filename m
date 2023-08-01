Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805BB76BD47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjHATFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjHATFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:05:49 -0400
Received: from out-116.mta1.migadu.com (out-116.mta1.migadu.com [IPv6:2001:41d0:203:375::74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062E1BF0
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 12:05:48 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690916746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ubgLwd+hMlZdsduA9ofiwuiDejvJ/EDMtYsrpjdDbWc=;
        b=oN3KEtYF/DC6U/4Z8RF+/oPyqvyX+f7zsgMTBMsYUJk+GH2QeRfY/DfAq0QcK2ll4twaXF
        1BLP1XSOg1ZsMLtOUMvc4BhpQXbBmJUCJqrpsRqGV8CtiSTxQP3N1pupZ24a5g8hpPdCZU
        CPP/0kI9X5Ba1Ib7PKmRSE8yf/QtoZg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/20] block: Bring back zero_fill_bio_iter
Message-ID: <20230801190541.gaoq45jkffcrm3cp@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-7-kent.overstreet@linux.dev>
 <ZL62cVmeI6t7o+G9@infradead.org>
 <20230725024553.bqwoyz4ywqx6fypb@moria.home.lan>
 <ZMEd08XCNFE1SwoU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEd08XCNFE1SwoU@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:21:23AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 10:45:53PM -0400, Kent Overstreet wrote:
> > And yet, we've had a subtle bug introduced in that code that took quite
> > awhile to be fixed - I'm not pro code duplication in general and I don't
> > think this is a good place to start.
> 
> I'm not sure arguing for adding a helper your can triviall implement
> yourself really helps to streamline your upstreaming process.

I gave you my engineering reasons, you're the one who's arguing.

And to make everything perfectly clear: this is code that I originally
wrote, and then you started changing without CCing me - your patch that
deleted zero_fill_bio_iter() never should've gone in.
