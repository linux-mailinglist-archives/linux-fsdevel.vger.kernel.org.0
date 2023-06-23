Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D320973B25E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjFWIJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 04:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFWIJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542172130;
        Fri, 23 Jun 2023 01:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C503E619A2;
        Fri, 23 Jun 2023 08:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0309C433C0;
        Fri, 23 Jun 2023 08:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687507768;
        bh=xI802DpDgRHiKKm9ZC+9C09p1dJUgMzr/A8W7L0AnFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHwQqYhYKxKYeoouZxEd56bHoeia4f2VpmI9D0VLeQnUC/4R4Dyfoh+jXWHAIHGnS
         +x1BRtE2ZzZIcRxXsbCkWUbBplItwlufrc7vS30Wh4/sQK7oV136o1M+bOpxuJdjez
         vIHshj/T60yAJv4nPOtdLCf+0EeUpls+3QsRUU3c=
Date:   Fri, 23 Jun 2023 10:09:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
Subject: Re: [PATCH v4 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Message-ID: <2023062313-crabgrass-puppet-3528@gregkh>
References: <20230621035102.13463-1-avadhut.naik@amd.com>
 <20230621035102.13463-3-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621035102.13463-3-avadhut.naik@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:51:00AM +0000, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Currently, debugfs_create_blob() creates read-only debugfs binary blob
> files.
> 
> In some cases, however, userspace tools need to write variable length
> data structures into predetermined memory addresses. An example is when
> injecting Vendor-defined error types through the einj module. In such
> cases, the functionality to write to these blob files in debugfs would
> be desired since the mapping aspect can be handled within the modules
> with userspace tools only needing to write into the blob files.
> 
> Implement a write callback to enable writing to these blob files in
> debugfs.
> 
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
