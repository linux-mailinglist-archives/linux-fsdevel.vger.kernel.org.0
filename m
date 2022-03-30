Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1324EC908
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiC3QEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiC3QEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE3CD331;
        Wed, 30 Mar 2022 09:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13806B81D7F;
        Wed, 30 Mar 2022 16:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ECEC340EC;
        Wed, 30 Mar 2022 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648656139;
        bh=rCFLVfwP2YYZR/07SXYzxszKe7a3kQtFKBEZm2TvXSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYt83dqShVp1l9pMm76ILYhOSUFPYxiBB38hZ1iMMkZAnYeYlr0giSL9Pma8GznaZ
         wLh7L+znuNPja45SGjcL+ObLifstjCJwGrifXChDds+GAhgEsAlvP+EgozPf5kY97H
         k1uMAeWC4b4CsOtp86tsiGM/K3S70JsbD+YWnJ8r1WKXBllo5moeSRnVtlG8+X3kIC
         /Vnr+IFZj139iA9sdxgq0L1vuh9H57ISEdhLsVSaDe1+n0W7IEiaMAhQEHrNNimKcD
         Yjd0JsXIwXai8udFWDpBvlZEXMAw5wTfTBMfLuykwA/PdGjBcnce01wRdsTkXm/S3t
         tg3PTjnJUfTtg==
Date:   Wed, 30 Mar 2022 18:02:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH v2 01/19] fs: add two trivial lookup helpers
Message-ID: <20220330160214.acs4tegiomjn3amg@wittgenstein>
References: <20220330102409.1290850-1-brauner@kernel.org>
 <20220330102409.1290850-2-brauner@kernel.org>
 <20220330152532.GA4835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220330152532.GA4835@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:25:32PM +0200, Christoph Hellwig wrote:
> > +
> > +/*
> > + * Like lookup_positive_unlocked() but takes a mount's idmapping into account.
> > + */
> 
> Can you add a real kerneldoc comment here instead of referring to
> another function that will hopefully be removed rather sooner than
> later?

Done.

> 
> > +struct dentry *lookup_one_unlocked(struct user_namespace *, const char *, struct dentry *, int);
> > +struct dentry *lookup_one_positive_unlocked(struct user_namespace *, const char *, struct dentry *, int);
> 
> Please spellt out the parameter names and avoid the overy long lines.

Done.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
