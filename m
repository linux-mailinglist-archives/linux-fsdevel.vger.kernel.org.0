Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8E4EC82B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348159AbiC3P1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiC3P1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:27:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF34198EFC;
        Wed, 30 Mar 2022 08:25:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B787768AA6; Wed, 30 Mar 2022 17:25:32 +0200 (CEST)
Date:   Wed, 30 Mar 2022 17:25:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH v2 01/19] fs: add two trivial lookup helpers
Message-ID: <20220330152532.GA4835@lst.de>
References: <20220330102409.1290850-1-brauner@kernel.org> <20220330102409.1290850-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330102409.1290850-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +
> +/*
> + * Like lookup_positive_unlocked() but takes a mount's idmapping into account.
> + */

Can you add a real kerneldoc comment here instead of referring to
another function that will hopefully be removed rather sooner than
later?

> +struct dentry *lookup_one_unlocked(struct user_namespace *, const char *, struct dentry *, int);
> +struct dentry *lookup_one_positive_unlocked(struct user_namespace *, const char *, struct dentry *, int);

Please spellt out the parameter names and avoid the overy long lines.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
