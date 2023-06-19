Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D3735592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFSLQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjFSLQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:16:42 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F191
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 04:16:41 -0700 (PDT)
Date:   Mon, 19 Jun 2023 07:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687173399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qyjVeZYBAzoxlutzK2qFbTnDa4h184q1k8uDAgWs8Y=;
        b=igOnmQXwHERJIUlLmJpYJwuPOTgNZjNzO0JXQPNHwcgVIJvQmOOaEZv+0XKGtmB3eoeAHl
        ZBYzcPD+ZFojzlsyvHxQe92VoWiwf8hcfuFYlzmROBUxz5HUYuKHmlhwlFTNOLqrbVY3oT
        QZlG3NevMj0lSYX8WJmt5znk7PfEvs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Christopher James Halse Rogers <raof@ubuntu.com>
Subject: Re: [PATCH 28/32] stacktrace: Export stack_trace_save_tsk
Message-ID: <20230619111635.ls26ojl7patttkiu@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-29-kent.overstreet@linux.dev>
 <ZJAboGKqWKA18ryp@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJAboGKqWKA18ryp@FVFF77S0Q05N>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 10:10:56AM +0100, Mark Rutland wrote:
> On Tue, May 09, 2023 at 12:56:53PM -0400, Kent Overstreet wrote:
> > From: Christopher James Halse Rogers <raof@ubuntu.com>
> > 
> > The bcachefs module wants it, and there doesn't seem to be any
> > reason it shouldn't be exported like the other functions.
> 
> What is the bcachefs module using this for?
> 
> Is that just for debug purposes? Assuming so, mentioning that in the commit
> message would be helpful.

Yes, the output ends up in debugfs.
