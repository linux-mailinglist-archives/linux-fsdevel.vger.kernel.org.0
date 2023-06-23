Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9B73B25B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjFWIJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFWIJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593A1FE7;
        Fri, 23 Jun 2023 01:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD3B619A2;
        Fri, 23 Jun 2023 08:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984DEC433C8;
        Fri, 23 Jun 2023 08:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687507752;
        bh=x8YJqDiZFJOVAVqo60AZcX0NUgfmu2n2j8kc3y3jm+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=voTzrPmkWyo3rA9zp+7cRrpg8bPp9ALFPbe+bSEIa5lOVSi2Go8ycIl/j3ai9ruwC
         8WMDnFbngIHjECnpT1WeJv6OXPMVJEJXKk8ft+F+BIVg4o/oee22bveAhE1FM9ax4c
         WkACxJo3njKexq+DI54Q4n3nK2zvxTT9sWZ6WwUE=
Date:   Fri, 23 Jun 2023 10:09:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
Subject: Re: [PATCH v4 3/4] platform/chrome: cros_ec_debugfs: Fix permissions
 for panicinfo
Message-ID: <2023062357-deceased-rejoicing-03d6@gregkh>
References: <20230621035102.13463-1-avadhut.naik@amd.com>
 <20230621035102.13463-4-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621035102.13463-4-avadhut.naik@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:51:01AM +0000, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> The debugfs_create_blob() function has been used to create read-only binary
> blobs in debugfs. The function filters out permissions, other than S_IRUSR,
> S_IRGRP and S_IROTH, provided while creating the blobs.
> 
> The very behavior though is being changed through previous patch in the
> series (fs: debugfs: Add write functionality to debugfs blobs) which makes
> the binary blobs writable.
> 
> As such, rectify the permissions of panicinfo file to ensure it remains
> read-only.
> 
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
