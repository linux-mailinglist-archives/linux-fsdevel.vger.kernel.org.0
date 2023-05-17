Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A559706793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjEQMIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEQMHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 08:07:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64837658C;
        Wed, 17 May 2023 05:05:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09DC268BEB; Wed, 17 May 2023 14:05:29 +0200 (CEST)
Date:   Wed, 17 May 2023 14:05:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230517120528.GA17087@lst.de>
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org> <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com> <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> Adding fsdevel so we're aware of this quirk.
> 
> So I'm not sure whether this was ever discussed on fsdevel when you took
> the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> invalid value.

I've never heard of this before, and I think it is compltely
unacceptable. 0 ist just a normal FD, although one that happens to
have specific meaning in userspace as stdin.

> 
> If it was discussed then great but if not then I would like to make it
> very clear that if in the future you decide to introduce custom
> semantics for vfs provided infrastructure - especially when exposed to
> userspace - that you please Cc us.

I don't think it's just the future.  We really need to undo this ASAP.

