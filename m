Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1102525F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354802AbiEMJqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiEMJqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 05:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0E268EB5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 02:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB42621F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 09:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3BC34100;
        Fri, 13 May 2022 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652435169;
        bh=QauW+SpPaB1xRrtCyDnrLaF5sBA/xuDbXqSTeQHSvPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcGtqrE61dRM1obCr8AVf5h1wI3gIqT5j+s4EfT7miKCnpWG77OWdvbX3ID+FtNcI
         Z0gES6IsngdL2DJWZ1vV8vI0e/w5HiYB/T5DeJsth0+ntyyOVXzpv8VjLO6AKGopSd
         ZpeCCUPBDc3tN9z4QM6wh+ZR1Q7nGsvvwi98dFzKs4b8ieXzadpBcYKSby0sFA21pi
         0/0rWLYlX46D/01vcSjkgPGLKf77Pdd3bv2DMDmDPnIoCuU/3p3QdtwX4SpIVdOJkJ
         lVrox6GxUSmpjeirE6X7qRsuhwypxWD7etW43d5/0FXfVtGBS7xEZ54Y/zvJO2+4+V
         Woryk+QVJj+0g==
Date:   Fri, 13 May 2022 11:46:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: Add small intro to idmap examples
Message-ID: <20220513094605.qlphoumtss2xo6xd@wittgenstein>
References: <20220429135748.481301-1-rodrigo@sdfg.com.ar>
 <20220507120453.py54ujoizzxgvjbr@wittgenstein>
 <98607226-54cc-0f84-1aac-ce930aad10c4@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98607226-54cc-0f84-1aac-ce930aad10c4@sdfg.com.ar>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 11:43:13AM +0200, Rodrigo Campos wrote:
> On 5/7/22 14:04, Christian Brauner wrote:
> > 
> > Good idea. Thank you!
> 
> Thanks!
> 
> > (Will pick up next week. Just back from LSFMM.)
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> 
> Friendly ping? :)

Oh, sorry. Already applied and in for-next. :)
