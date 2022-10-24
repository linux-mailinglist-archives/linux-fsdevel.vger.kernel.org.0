Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6660BBF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiJXVTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiJXVTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1414A26D234
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 12:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861C76155B
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 19:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C480EC433B5;
        Mon, 24 Oct 2022 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666639448;
        bh=sWWNEbwTkscLAJ79XJkcr9sI/mF5pJvjNR6CDnvTVNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+TS1yGaDHV9aW0o6zgh9RvG1In0mv0dUXuC5yzTKVkUuZxNoZOovnkx+7EoVxxzB
         3a0Tiw9+K1uahMJihvg4qboL9m8EbiuUuf7W1YEcim/XAK8TvvsS0odwfg6Ow1Xnod
         URRL5bUrC6AnYbf1hv016Ls2qaOCPBwoUh2DGZet0pqSo8yAR6MfhCSVdo04eiKvNC
         zvhMssCZtzGvZXk4EpuYhgYoycPsLmLopTblehsCEraByhyKrJOQNB8dh6uLWNGEwK
         Jg5IWi41Ptsgkwf2ycWI47Dr/K1QKjAYYTUKp6Hno5pr1T1CmzOtRt7Qc9g/Qpy6yL
         BQTDYuwBT81Rg==
Date:   Mon, 24 Oct 2022 14:24:07 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/8] finish port to new vfs*id helpers
Message-ID: <Y1bmVx+7Y9QmL9zH@do-x1extreme>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:12:41PM +0200, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> 
> Hey,
> 
> A while ago we converted all filesystems and a good chunk of the vfs to
> rely on the new vfs{g,u}id_t type and the associated type safe helpers.
> After this change all places where idmapped mounts matter deal with the
> dedicated new type and can't be easily confused with filesystem wide
> k{g,u}id_t types. This small series converts the remaining places and
> removes the old helpers. The series does not contain functional changes.
> xfstests, LTP, and the libcap testsuite pass without any regressions.
> 
> (The series is based on the setgid changes sitting in my tree. It
>  removes a bunch of open-coding and thus makes the change here simpler
>  as well.)
> 
> Thanks!
> Christian

Looks good to me.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
