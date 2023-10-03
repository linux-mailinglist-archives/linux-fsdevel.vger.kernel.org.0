Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4981A7B6A89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjJCN24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbjJCN2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:28:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71003B8;
        Tue,  3 Oct 2023 06:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DF8C433C9;
        Tue,  3 Oct 2023 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696339730;
        bh=sehLgD2TutIYB7MxXdgHW4HKeN6+TJNSC72ZiOsgVHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4Zk1cff/6ophzGy0aSfolPXKFijZgIqqv11DAnnz9yibMx+C7wqxLLsAKHFTqpYA
         MOw1AdubPL6KCRqLlHmqS3nJp4joCxL1/PTuKooki0iD2thdwD5NZdDzOGiZ6nb+JJ
         3WxPCZrOSL4OwZ/XIfjngqmuUi9m8VTlc7l+QifRyJVcrXpbmjT+jwQxEdrh9GnwUs
         T4DWTbb0hueVUCqbNVvrbKt0PeHJIoic0bLeHmaBgrYpyX+SUzWhvmTiAzLdl8yZjO
         KF/3TEnqRedIPcYZE/IBOyx6MogYfefMuhGmimv9cEqEbJuc7rMmaAcWbIjse7JDQ8
         f9BTOil6eOdBw==
Date:   Tue, 3 Oct 2023 15:28:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 00/29] const xattr tables
Message-ID: <20231003-eiszapfen-bruder-d6fba9031133@brauner>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:00:04AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> The 's_xattr' field of 'struct super_block' currently requires a mutable
> table of 'struct xattr_handler' entries (although each handler itself is
> const). However, no code in vfs actually modifies the tables.
> 
> So this series changes the type of 's_xattr' to allow const tables, and
> modifies existing file system to move their tables to .rodata. This is
> desirable because these tables contain entries with function pointers in
> them; moving them to .rodata makes it considerably less likely to be
> modified accidentally or maliciously at runtime.

Fine by me and good idea. On vacation this week but I'll wait for
individual fs maintainers to ack their portions anyway and then pick up
next week.
