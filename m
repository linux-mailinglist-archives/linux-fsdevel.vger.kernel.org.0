Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458171675B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjE3PoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjE3PoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90BF7;
        Tue, 30 May 2023 08:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C144609FA;
        Tue, 30 May 2023 15:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6126C433EF;
        Tue, 30 May 2023 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685461438;
        bh=yKpSUIDsI1YQx5+45dwZ2YU0mq3iYA9T6D3r+nll67w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuzbYPnYGEelnZAB99dHr2kPCy/Z3ZGV5J63M05Cy5Uco9o+XggemD8+SpTdwyzlY
         BVvM4WEZbK5xD/s/D6esxWLor5+a670bh95lE/mzPENY6X2yepubd9fGATdc1ZZRxQ
         eK4jF7u6QV1gsfuAHEUqQyZH1LPzanJZtAtcLpvf/tYNuRiGLo7J8ANA+40uYecAh6
         s+bTqiN65ckNjK+FCTbNsx9SOGFveLLxfDbA55/d6qkAuD0MEbT9Aft8U6VwtqN3k1
         WhpxE/fuBVV6Bwpih39kb01RM7+Ll6HUwOP1/JbthTWWVuJf/3qIYCvRCQ7T0MXFDc
         Zly11uKXtoqXA==
Date:   Tue, 30 May 2023 17:43:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
Message-ID: <20230530-angepackt-zahnpasta-3e24954150fc@brauner>
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
 <ZHYOucvIYTBwnzOb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHYOucvIYTBwnzOb@infradead.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 07:56:57AM -0700, Christoph Hellwig wrote:
> This clashes a bit with my big rework in this area in the
> "fix the name_to_dev_t mess" series. I need to resend that series
> anyway, should I just include a rebased version of this patch?

Sure, if this makes things easier for you then definitely.
