Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897FD6816F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjA3Qxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3Qxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:53:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31433D0A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:53:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 555C868D0D; Mon, 30 Jan 2023 17:53:46 +0100 (CET)
Date:   Mon, 30 Jan 2023 17:53:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v2 8/8] fs: rename generic posix acl handlers
Message-ID: <20230130165346.GE8357@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v2-8-214cfb88bb56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-8-214cfb88bb56@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
