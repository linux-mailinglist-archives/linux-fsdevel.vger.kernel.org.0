Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A777F9DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbjHQO5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352461AbjHQO4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A230EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A35644FA
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 14:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFF5C433C8;
        Thu, 17 Aug 2023 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284179;
        bh=nedXV4ECRGIOcnksE6Hhn2OYIsOMFWVZsYGIRxSVqDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2jjTwt5dP4bFDwG3njy99HgIv5kxX6za8ChYnrAk0FSFRrKaMx9RAdsyazmR67jM
         +kYe7QY9qg4U3AWsGMctUpp+tspxYZwAKv6XY2xH9TlWQQiluVkDRrNm9dbGvpcsXD
         iYePQbUpu1I0GSWCnPhBAwPD3u07PqFukTR/64WPLvxqr+cTvW6btK7EQsmP+SQ2Tw
         lLmvRLBX+1H5AdxW0YjY4nwxkyp4g3UnFnx3V1ujqxQTeAYskqEJmk957GO/dcurIo
         Hi1p5NJbsnGQKMZVCcFRitLC+fZ6SKo59GkvYKaKVvgA3oWddmf3czNCn1qyqss45Y
         /UkDhdv/AdI0g==
Date:   Thu, 17 Aug 2023 16:56:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
Message-ID: <20230817-situiert-eisstadion-cdf3b6b69539@brauner>
References: <20230817141337.1025891-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:13:30PM +0300, Amir Goldstein wrote:
> Christian,
> 
> This is an attempt to consolidate the open coded lockdep fooling in
> all those async io submitters into a single helper.
> The idea to do that consolidation was suggested by Jan.
> 
> This re-factoring is part of a larger vfs cleanup I am doing for
> fanotify permission events.  The complete series is not ready for
> prime time yet, but this one patch is independent and I would love
> to get it reviewed/merged a head of the rest.
> 
> This v3 series addresses the review comments of Jens on v2 [1].

I have neither quarrels nor strong opinions on this so if Jens tells me
it looks fine to him I can take it.
