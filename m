Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAC75FCEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGXRJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXRJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6FA9;
        Mon, 24 Jul 2023 10:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2EAA612CB;
        Mon, 24 Jul 2023 17:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C4EC433C8;
        Mon, 24 Jul 2023 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690218555;
        bh=VM2mlErwyG3xb5ny8Retw/i22OPT/06YmhNvqnaoB6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cuDjgU2+LItGznKi9JfDJm/YzdxHXVoKoxarhIpCp2Tu7ZUowZbtplzcB/p2yReG4
         ixDDMtKUuVd0rVGjAr3v/wvXhz7Z1a7ifQbiPiFydhTQ2aq/z4XRaDhBNV/5mDyK2m
         Yhtmjr18KBdSsDgmd8ZP7h2fTQxahhprWX6QliDcA4mgxYce0Yq12GbHhvcZdWgHby
         PmMhT+50deM83OaYF+NigH85EF2PblHeI7t3qfGwOQN6+I0Lz9pLBGWdvPc/s0q7Ht
         J95P53cqs3erLvb2PeA9RWvHoAan0BOObBh5K37jjfv1h809cgfy5raXXWncmAudvL
         8nOUbsJNhjqcQ==
Date:   Mon, 24 Jul 2023 10:09:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK
 socket
Message-ID: <20230724100914.38f286a5@kernel.org>
In-Reply-To: <10687.1690213447@warthog.procyon.org.uk>
References: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com>
        <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
        <64434.1690193532@warthog.procyon.org.uk>
        <10687.1690213447@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 16:44:07 +0100 David Howells wrote:
> Anyway, did you want to post this to netdev too so that the networking tree
> picks it up?  Feel free to add:

+1, no preference which tree this goes thru, but if no one else claims
it please repost CCing netdev@vger.kernel.org
