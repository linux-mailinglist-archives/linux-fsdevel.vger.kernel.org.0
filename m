Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4EA7B221A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjI1QTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI1QTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:19:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7AEB7;
        Thu, 28 Sep 2023 09:19:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B693C433C7;
        Thu, 28 Sep 2023 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695917967;
        bh=URLMtccifBSyoRGbF2yfNWk0hSSQMUVAszXvMp4GJqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOrXaakoqGVa43Eo1a7ate/4vjkLqVNB4PWlgz2yxOFwfGUYdBGbgDzPXpvvlaMsd
         O9Nb7OXark7G0KB9/L5CbF155daMcbevlnppE1KDoXAnePfmpsyPE88cf2UC7eSSm1
         T3d8C0dXdvu0QvIwghtAY0KNQip8Eh7npaDENW86ciXhs+/pkmG+6ftLlJhBm7Z9sf
         RwD1g/crAAWgeBNGEF+iqhXNS9FBj6kxDytpJWa8aFEnLeb0rMlf9Bu8Z7X74/R0df
         XVugE79eDnVD2iEgxH/cZKVP1S4aWbuOv8AKfpCzzh29t4xhss+DpbhjbQjfWQp+4T
         x9rMWVyKB0cAA==
Date:   Thu, 28 Sep 2023 18:19:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible extra iput() in do_unlinkat()
Message-ID: <20230928-erhoben-nennung-cc3e250c8667@brauner>
References: <20230928131129.14961-1-lhenriques@suse.de>
 <20230928134513.l2y3eknt2hfq3qgx@f>
 <878r8q1gn3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r8q1gn3.fsf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> OK, I'll rephrase the commit message for v2 so that it's clear it's not

I've already applied your first pach and massaged your commit message.
Authorship and all is retained. No need to resend. Probably got lost
because git send-email scrambled your mail address.
