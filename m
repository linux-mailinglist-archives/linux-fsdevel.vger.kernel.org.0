Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9915666B7D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjAPHJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 02:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjAPHJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:09:18 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C84A268
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jan 2023 23:09:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC58C68AFE; Mon, 16 Jan 2023 08:09:14 +0100 (CET)
Date:   Mon, 16 Jan 2023 08:09:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 25/25] fs: move mnt_idmap
Message-ID: <20230116070914.GC15498@lst.de>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org> <20230113-fs-idmapped-mnt_idmap-conversion-v1-25-fc84fa7eba67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-25-fc84fa7eba67@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/* Copyright (c) 2022 Christian Brauner (Microsoft) <brauner@kernel.org> */

Not a laywer, but this copyright statement looks wrong.  Either you
own personal copyright on this work, and you should drop the
" (Microsoft)", or your employer owns the copyright, in which case this
should be the usual corporate copyright blurb.
