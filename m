Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C36C6B2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCWOhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCWOhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:37:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167B211E9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:37:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEbYI4012741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582256; bh=mFMJqLcjrnAL8JljGxhBhN4umzSGhKk2guyVXCBOPcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QU753MeneCiMKiUaxD2SVGtaiTPUast8Iy+eVbGI/zd7Xn7/UyBda8Q9N1+XDIqKK
         1TlpuOc0h2DttAII4hn/Tf+/mOFTyq51cT3CtOgLt4qqyxJIbsdHGDI15cFPabPCcV
         YtfscSmSgI8ZKxgKNx38VZYX0NO6/4ecDtphjOxOZPn/3lJBWu2Nhn/QsfS20A/MA0
         scOkceHzQBQ9Do1rsLBMItUlmwBHCgJKwMfqnEAD6z4yP2CODTkAtZSWOw8JEcoN2I
         xboNsLpu3jw7f7t6vsS69p20vliCL9y+nDvFsDdPYLEe2X/x3hlTC8BHabhvK1Rxuu
         UmRWma7CYmSKQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A11F915C4279; Thu, 23 Mar 2023 10:37:34 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:37:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
Message-ID: <20230323143734.GF136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-5-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:46:00PM -0400, Gabriel Krisman Bertazi wrote:
> Preserve the existing behavior for encrypted directories, by rejecting
> negative dentries of encrypted+casefolded directories.  This allows
> generic_ci_d_revalidate to be used by filesystems with both features
> enabled, as long as the directory is either casefolded or encrypted, but
> not both at the same time.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
