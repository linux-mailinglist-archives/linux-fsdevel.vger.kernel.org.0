Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA876A0E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGaTIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGaTIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78963173D;
        Mon, 31 Jul 2023 12:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB77861277;
        Mon, 31 Jul 2023 19:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4CBC433C8;
        Mon, 31 Jul 2023 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690830526;
        bh=nRBJMPp0sswdctWCTu+S7qVu3zqxXdAcDEbnShpEQW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjkZnK+t0wOVDp1QOAPx6ZoWCsvFM50FrgFaQfBlSKUvA7D4FqoB/A6JDo0q3AQq5
         4l+apP61ADKhwdHownNGFjTUGWS1MDbHF4DYRdzXGQoUjtlU5gKAcuM19smIvFwK0a
         KSagBxXRU91qOXCwdNbxjgImvMMTphF0Ue3Lj4lRjyhzi13RGxTpDcqcOrmXs27dJR
         Zv7IZNGTsCrbpoMQ/f+ufD4Ow7kNil+Q9r1+6MRQsvJYeneMnWTAI6R1xNTZ2lcuYN
         v7I3DS9/RknRsMOuKJLqQffUEpQNSMvhoLgNyDsE37HLwSotV1AV0rMr1ObgZTbMil
         y/ajxqtemKP6A==
Date:   Mon, 31 Jul 2023 21:08:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] kernfs: attach uuid for every kernfs and report it in
 fsid
Message-ID: <20230731-raubzug-imposant-ef57be965397@brauner>
References: <20230731184731.64568-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731184731.64568-1-ivan@cloudflare.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:47:31AM -0700, Ivan Babrou wrote:
> The following two commits added the same thing for tmpfs:
> 
> * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file handles on tmpfs")
> 
> Having fsid allows using fanotify, which is especially handy for cgroups,
> where one might be interested in knowing when they are created or removed.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Acked-by: Jan Kara <jack@suse.cz>
> 
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
