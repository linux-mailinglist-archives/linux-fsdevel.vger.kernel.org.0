Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92370778FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjHKMqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjHKMqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:46:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204730C0;
        Fri, 11 Aug 2023 05:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28C863559;
        Fri, 11 Aug 2023 12:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B1C433C7;
        Fri, 11 Aug 2023 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691757978;
        bh=Ed7kcZoi7uzNrtBbYEGRp0QP/eeld+oUtfaDghK+doM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tis21DbrAs9l1nZv1ByUephpm8g+gZCRRyJ9KRLKGinGXUGFZdV5nZKab3TAcS2A6
         EI/KHr9ULQzxf18IWg2IBrL944dheHz0cI/enwOtBhJXcm/PLi/WsLjLnEQIbxz0Vr
         KrS7/BpN/a2z5gyR5DSBQdVW6hkufpFtepI+9JlIRUsoqW7mx952gAHRnQCYCYD+Iu
         Cm1ETROLBERkpzK0qAz4dcWh7GSrvjXzshpOwTM7xBoZW9DZcn+WGgYanSsUrF19EQ
         5OHSa9NQkbcxBv9Y0vhM+b91JxXePa5MLbfPORe6duB6oYbEHoJMBn6nCOZHH0YbRH
         jueL99cyrRDiQ==
Date:   Fri, 11 Aug 2023 14:46:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/17] fs: remove get_super
Message-ID: <20230811-worum-lebewesen-e526bf69d1cc@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-17-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:27PM +0200, Christoph Hellwig wrote:
> get_super is unused now, remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
