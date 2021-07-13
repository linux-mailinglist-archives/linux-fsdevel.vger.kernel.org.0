Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B23C7146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhGMNhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 09:37:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:55408 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhGMNhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:37:54 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3IWg-000J3s-K9; Tue, 13 Jul 2021 13:32:42 +0000
Date:   Tue, 13 Jul 2021 13:32:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/24] namei: handle mappings in lookup_one_len()
Message-ID: <YO2V+n1Cttrky+bD@zeniv-ca.linux.org.uk>
References: <20210713111344.1149376-1-brauner@kernel.org>
 <20210713111344.1149376-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713111344.1149376-2-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 01:13:21PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Various filesystems use the lookup_one_len() helper to lookup a single path
> component relative to a well-known starting point. Allow such filesystems to
> support idmapped mounts by enabling lookup_one_len() to take the idmap into
> account when calling inode_permission(). This change is a required to let btrfs
> (and other filesystems) support idmapped mounts.

NAK.  Expose a new variant if you must, but leave the old one alone.
