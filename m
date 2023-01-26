Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880BB67C68B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjAZJCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjAZJCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA196C116;
        Thu, 26 Jan 2023 01:02:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7A161765;
        Thu, 26 Jan 2023 09:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751AC433D2;
        Thu, 26 Jan 2023 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674723759;
        bh=cJiuZDmjWMBhb4TdT095zzkkdTzBcJKGtGars7rxrw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J01vOYnckHH0T+6Crj0h62ihT2+0ALe5PsH3tGqeRXFapzwzc1G/CpR+8KXP5fHEQ
         0FHof5r3G9rt5O9K1mR+izgIhXp6Mo2bgXIZBlw8mlLyL1sLmCkGPhD0JxVmKhkmWA
         LKZ16LejEj8108s/ZGLT/7KsGJqR/t+QCag6mkjC44l0fQVd6Tf/OZ88Zb0X3LdWKb
         JFEmxzUMOpp3ffc9mQLMaDhnYlzcMdkJ/oOrNFHkVk2+wsCusIGulEEN78g06iXFVd
         4+n+vK+1At6HV0emjnK3cm9WoCgvaxOe5yi13+Px++JmUEkikubltkiyK/lp8voZS/
         Qj6cjl1Zzj0tg==
Date:   Thu, 26 Jan 2023 10:02:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 RESEND 1/8] fs: uninline inode_query_iversion
Message-ID: <20230126090231.ploinhgeejxlyhmk@wittgenstein>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124193025.185781-2-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:30:18PM -0500, Jeff Layton wrote:
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
